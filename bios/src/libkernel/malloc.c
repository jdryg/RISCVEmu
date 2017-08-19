#include "malloc.h"
#include "kernel.h"
#include "memory.h"

typedef struct BlockInfo_t
{
	size_t m_Size;
	struct BlockInfo_t* m_Prev;
	struct BlockInfo_t* m_Next;
	int m_Free;
} BlockInfo;

const size_t kBlockInfoSize = sizeof(BlockInfo);
const size_t kMinBlockSplitSize = sizeof(BlockInfo) * 8;

static BlockInfo* g_BlockListHead = 0;
static BlockInfo* g_BlockListTail = 0;

// sbrk() replacement for Kernel memory
// Uses __heap_start and __stack_top defined in linker script.
// In a hw implementation this is supposed to be the microcontroller's
// build in RAM which is different than the external RAM modules that
// might be attached to it (and which require initialization before
// use).
void* _sbrk(size_t size)
{
	extern char __heap_start;
	extern char __stack_top;
	static char* curProgramBreak = &__heap_start;

	if(size == 0) {
		return curProgramBreak;
	} else if(curProgramBreak + size >= &__stack_top) {
		return (void*)~0u;
	}

	char* ptr = curProgramBreak;
	curProgramBreak += size;
	return ptr;
}

BlockInfo* _ptrToBlock(void* ptr)
{
	return (BlockInfo*)ptr - 1;
}

void* _blockToPtr(BlockInfo* block)
{
	return block + 1;
}

BlockInfo* _allocNewBlock(size_t size) 
{
	BlockInfo* block;

	block = _sbrk(0);

	// Align requested size to 16 bytes
	// NOTE: Mask the lower 4 bits of the total size and add 16 (16 * floor(size / 16) + 16)
	const size_t reqSize = ((size + kBlockInfoSize) & 0xFFFFFFF0) + 16;
	void* request = _sbrk(reqSize);
	if (request == (void*)~0u) {
		return 0;
	}

	block->m_Size = size;
	block->m_Prev = 0;
	block->m_Next = 0;
	block->m_Free = 0;

	return block;
}

BlockInfo* _findFreeBlock(BlockInfo* cur, size_t size) 
{
	while (cur && !(cur->m_Free && cur->m_Size >= size)) {
		cur = cur->m_Next;
	}

	return cur;
}

int _mergeFreeBlockWithNext(BlockInfo* block)
{
	kassert(block != 0 && block->m_Free != 0, "_mergeFreeBlockWithNext() called with an invalid block");
	if(!block->m_Next || !block->m_Next->m_Free) {
		return 0;
	}

	block->m_Size += block->m_Next->m_Size + kBlockInfoSize;
	block->m_Next = block->m_Next->m_Next;
	if(block->m_Next) {
		block->m_Next->m_Prev = block;
	}

	return 1;
}

int _splitBlock(BlockInfo* block, size_t size)
{
	kassert(block->m_Size >= size, "_splitBlock() called with an invalid block");
	if(block->m_Size < size + kMinBlockSplitSize) {
		return 0;
	}

	uint8_t* blockData = (uint8_t*)_blockToPtr(block);
	blockData += size;

	BlockInfo* newFreeBlock = (BlockInfo*)blockData;
	newFreeBlock->m_Prev = block;
	newFreeBlock->m_Next = block->m_Next;
	if(newFreeBlock->m_Next) {
		newFreeBlock->m_Next->m_Prev = newFreeBlock;
	}
	newFreeBlock->m_Size = block->m_Size - size - kBlockInfoSize;
	newFreeBlock->m_Free = 1;

	block->m_Next = newFreeBlock;
	block->m_Size = size;

	_mergeFreeBlockWithNext(newFreeBlock);

	return 1;
}

void* kmalloc(size_t size)
{
	BlockInfo* block;

	if (size <= 0) {
	  return 0;
	}

	if (!g_BlockListHead) {
		block = _allocNewBlock(size);
		if (!block) {
			return 0;
		}

		g_BlockListHead = block;
		g_BlockListTail = block;
	} else {
		block = _findFreeBlock(g_BlockListHead, size);
		if (!block) {
			block = _allocNewBlock(size);
			if (!block) {
				return 0;
			}

			kassert(g_BlockListTail != 0, "kmalloc(): Invalid block list tail");
			block->m_Prev = g_BlockListTail;
			g_BlockListTail->m_Next = block;
			g_BlockListTail = block;
		} else {
			block->m_Free = 0;

			if(_splitBlock(block, size)) {
				kassert(block->m_Next && block->m_Next->m_Free, "Invalid blocks after split");

				// If this was the last block, update the list tail to point to the new block.
				if(block == g_BlockListTail) {
					g_BlockListTail = block->m_Next;
				}
			}
		}
	}

	return _blockToPtr(block);
}

void kfree(void* ptr)
{
	if (!ptr) {
		return;
	}

	BlockInfo* block = _ptrToBlock(ptr);
	kassert(block->m_Free == 0, "kfree(): Block is already free.");
	block->m_Free = 1;

	// Merge free blocks
	_mergeFreeBlockWithNext(block);
	while(block->m_Prev && block->m_Prev->m_Free == 1) {
		kassert(block->m_Prev->m_Next == block, "Invalid linked list node!");
		_mergeFreeBlockWithNext(block->m_Prev);
		block = block->m_Prev;
	}

	if(!block->m_Next) {
		g_BlockListTail = block;
	}
	if(!block->m_Prev) {
		kassert(block == g_BlockListHead, "Invalid linked list node!");
	}
}

void* krealloc(void* ptr, size_t size)
{
	if (!ptr) {
		return kmalloc(size);
	}

	BlockInfo* block = _ptrToBlock(ptr);
	if (block->m_Size >= size) {
		if(_splitBlock(block, size)) {
			kassert(block->m_Next && block->m_Next->m_Free, "Invalid blocks after split");

			// If this was the last block, update the list tail to point to the new block.
			if(block == g_BlockListTail) {
				g_BlockListTail = block->m_Next;
			}
		}

		return ptr;
	}

	// If the next block is free and it can hold the extra required space
	// merge the two.
	if(block->m_Next && block->m_Next->m_Free) {
		const size_t totalSize = block->m_Size + block->m_Next->m_Size + kBlockInfoSize;
		if(totalSize >= size) {
			block->m_Size = totalSize;
			block->m_Next = block->m_Next->m_Next;
			if(block->m_Next) {
				block->m_Next->m_Prev = block;
			} else {
				// This is the last block in the list.
				g_BlockListTail = block;
			}

			return ptr;
		}
	}

	// We have to allocate a shiny new block and copy the data to it.
	void* newPtr = kmalloc(size);
	if (!newPtr) {
		return 0;
	}

	kmemcpy(newPtr, ptr, block->m_Size);
	kfree(ptr);

	return newPtr;
}
