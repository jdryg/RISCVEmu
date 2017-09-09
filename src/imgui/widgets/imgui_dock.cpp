#include "../imgui.h"
#define IMGUI_DEFINE_PLACEMENT_NEW
#define IMGUI_DEFINE_MATH_OPERATORS
#include "../imgui_internal.h"
#include "../../json/json.h"
#include <stdlib.h>

namespace ImGui
{
char* strndup(const char* src, unsigned int len)
{
	char* dst = (char*)malloc(len + 1);
	memcpy(dst, src, len);
	dst[len] = '\0';
	return dst;
}

struct DockContext
{
	enum Slot_
	{
		Slot_Left,
		Slot_Right,
		Slot_Top,
		Slot_Bottom,
		Slot_Tab,

		Slot_Float,
		Slot_None
	};

	enum EndAction_
	{
		EndAction_None,
		EndAction_Panel,
		EndAction_End,
		EndAction_EndChild
	};

	enum Status_
	{
		Status_Docked,
		Status_Float,
		Status_Dragged
	};

	struct Dock
	{
		Dock()
			: id(0)
			, label(nullptr)
			, next_tab(nullptr)
			, prev_tab(nullptr)
			, parent(nullptr)
			, pos(0, 0)
			, size(-1, -1)
			, active(true)
			, status(Status_Float)
			, opened(false)
		{
			location[0] = 0;
			children[0] = children[1] = nullptr;
		}
		
		~Dock() 
		{
			MemFree(label); 
		}
		
		ImVec2 getMinSize() const
		{
			if (!children[0]) {
				return ImVec2(16, 16 + GetTextLineHeightWithSpacing());
			}

			ImVec2 s0 = children[0]->getMinSize();
			ImVec2 s1 = children[1]->getMinSize();
			return isHorizontal() 
				? ImVec2(s0.x + s1.x, ImMax(s0.y, s1.y)) 
				: ImVec2(ImMax(s0.x, s1.x), s0.y + s1.y);
		}
		
		bool isHorizontal() const 
		{
			return children[0]->pos.x < children[1]->pos.x; 
		}
		
		void setParent(Dock* dock)
		{
			parent = dock;
			for (Dock* tmp = prev_tab; tmp; tmp = tmp->prev_tab) {
				tmp->parent = dock;
			}
			for (Dock* tmp = next_tab; tmp; tmp = tmp->next_tab) {
				tmp->parent = dock;
			}
		}
		
		Dock& getSibling()
		{
			IM_ASSERT(parent);
			if (parent->children[0] == &getFirstTab()) {
				return *parent->children[1];
			}
			return *parent->children[0];
		}

		Dock& getFirstTab()
		{
			Dock* tmp = this;
			while (tmp->prev_tab) {
				tmp = tmp->prev_tab;
			}
			return *tmp;
		}
		
		void setActive()
		{
			active = true;
			for (Dock* tmp = prev_tab; tmp; tmp = tmp->prev_tab) {
				tmp->active = false;
			}
			for (Dock* tmp = next_tab; tmp; tmp = tmp->next_tab) {
				tmp->active = false;
			}
		}

		bool isContainer() const 
		{ 
			return children[0] != nullptr; 
		}
		
		void setChildrenPosSize(const ImVec2& _pos, const ImVec2& _size)
		{
			ImVec2 s = children[0]->size;
			if (isHorizontal()) {
				s.y = _size.y;
				s.x = (float)int(_size.x * children[0]->size.x / (children[0]->size.x + children[1]->size.x));
				if (s.x < children[0]->getMinSize().x) {
					s.x = children[0]->getMinSize().x;
				} else if (_size.x - s.x < children[1]->getMinSize().x) {
					s.x = _size.x - children[1]->getMinSize().x;
				}
				children[0]->setPosSize(_pos, s);

				s.x = _size.x - children[0]->size.x;
				ImVec2 p = _pos;
				p.x += children[0]->size.x;
				children[1]->setPosSize(p, s);
			} else {
				s.x = _size.x;
				s.y = (float)int(_size.y * children[0]->size.y / (children[0]->size.y + children[1]->size.y));
				if (s.y < children[0]->getMinSize().y) {
					s.y = children[0]->getMinSize().y;
				} else if (_size.y - s.y < children[1]->getMinSize().y) {
					s.y = _size.y - children[1]->getMinSize().y;
				}
				children[0]->setPosSize(_pos, s);

				s.y = _size.y - children[0]->size.y;
				ImVec2 p = _pos;
				p.y += children[0]->size.y;
				children[1]->setPosSize(p, s);
			}
		}

		void setPosSize(const ImVec2& _pos, const ImVec2& _size)
		{
			size = _size;
			pos = _pos;
			for (Dock* tmp = prev_tab; tmp; tmp = tmp->prev_tab) {
				tmp->size = _size;
				tmp->pos = _pos;
			}
			for (Dock* tmp = next_tab; tmp; tmp = tmp->next_tab) {
				tmp->size = _size;
				tmp->pos = _pos;
			}

			if (!isContainer()) {
				return;
			}
			setChildrenPosSize(_pos, _size);
		}

		ImU32 id;
		char* label;
		Dock* next_tab;
		Dock* prev_tab;
		Dock* parent;
		ImVec2 pos;
		ImVec2 size;
		bool active;
		Status_ status;
		bool opened;

		Dock* children[2];
		char location[16];
		int last_frame;
		int invalid_frames;
		bool first;
	};

	ImVector<Dock*> m_docks;
	ImVec2 m_drag_offset;
	Dock* m_current = nullptr;
	int m_last_frame = 0;
	EndAction_ m_end_action;
	
	~DockContext() {}
	
	Dock* getDock(const char* label, bool opened, bool createNew)
	{
		ImU32 id = ImHash(label, 0);
		for (int i = 0; i < m_docks.size(); ++i) {
			if (m_docks[i]->id == id) {
				return m_docks[i];
			}
		}

		if (!createNew) {
			return NULL;
		}

		Dock* new_dock = (Dock*)MemAlloc(sizeof(Dock));
		IM_PLACEMENT_NEW(new_dock) Dock();
		m_docks.push_back(new_dock);
		new_dock->label = ImStrdup(label);
		IM_ASSERT(new_dock->label);
		new_dock->id = id;
		new_dock->setActive();
		new_dock->status = Status_Float;
		new_dock->pos = ImVec2(0, 0);
		new_dock->size = GetIO().DisplaySize;
		new_dock->opened = opened;
		new_dock->first = true;
		new_dock->last_frame = 0;
		new_dock->invalid_frames = 0;
		new_dock->location[0] = 0;
		return new_dock;
	}
	
	void putInBackground()
	{
		ImGuiWindow* win = GetCurrentWindow();
		ImGuiContext& g = *GImGui;
		if (g.Windows[0] == win) {
			return;
		}

		for (int i = 0; i < g.Windows.Size; i++) {
			if (g.Windows[i] == win) {
				for (int j = i - 1; j >= 0; --j) {
					g.Windows[j + 1] = g.Windows[j];
				}
				g.Windows[0] = win;
				break;
			}
		}
	}
	
	void splits()
	{
		if (GetFrameCount() == m_last_frame) {
			return;
		}
		m_last_frame = GetFrameCount();

		putInBackground();
		
		ImU32 color = GetColorU32(ImGuiCol_Button);
		ImU32 color_hovered = GetColorU32(ImGuiCol_ButtonHovered);
		ImDrawList* draw_list = GetWindowDrawList();
		ImGuiIO& io = GetIO();
		for (int i = 0; i < m_docks.size(); ++i) {
			Dock& dock = *m_docks[i];
			if (!dock.isContainer()) {
				continue;
			}

			PushID(i);
			if (!IsMouseDown(0)) {
				dock.status = Status_Docked;
			}

			//ImVec2 size = dock.children[0]->size;
			ImVec2 dsize(0, 0);
			SetCursorScreenPos(dock.children[1]->pos);
			ImVec2 min_size0 = dock.children[0]->getMinSize();
			ImVec2 min_size1 = dock.children[1]->getMinSize();
			if (dock.isHorizontal()) {
				InvisibleButton("split", ImVec2(3, dock.size.y));
				if (dock.status == Status_Dragged) {
					dsize.x = io.MouseDelta.x;
				}
				dsize.x = -ImMin(-dsize.x, dock.children[0]->size.x - min_size0.x);
				dsize.x = ImMin(dsize.x, dock.children[1]->size.x - min_size1.x);
			} else {
				InvisibleButton("split", ImVec2(dock.size.x, 3));
				if (dock.status == Status_Dragged) {
					dsize.y = io.MouseDelta.y;
				}
				dsize.y = -ImMin(-dsize.y, dock.children[0]->size.y - min_size0.y);
				dsize.y = ImMin(dsize.y, dock.children[1]->size.y - min_size1.y);
			}
			
			ImVec2 new_size0 = dock.children[0]->size + dsize;
			ImVec2 new_size1 = dock.children[1]->size - dsize;
			ImVec2 new_pos1 = dock.children[1]->pos + dsize;
			dock.children[0]->setPosSize(dock.children[0]->pos, new_size0);
			dock.children[1]->setPosSize(new_pos1, new_size1);
			
			if (IsItemHovered() && IsMouseClicked(0)) {
				dock.status = Status_Dragged;
			}

			draw_list->AddRectFilled(GetItemRectMin(), GetItemRectMax(), IsItemHovered() ? color_hovered : color);
			PopID();
		}
	}
	
	void checkNonexistent()
	{
		int frame_limit = ImMax(0, ImGui::GetFrameCount() - 2);
		for (Dock* dock : m_docks) {
			if (dock->isContainer()) {
				continue;
			}
			if (dock->status == Status_Float) {
				continue;
			}
			if (dock->last_frame < frame_limit) {
				++dock->invalid_frames;
				if (dock->invalid_frames > 2) {
					doUndock(*dock);
					dock->status = Status_Float;
				}
				return;
			}
			dock->invalid_frames = 0;
		}
	}

	void beginPanel()
	{
		ImGuiWindowFlags flags = 0 
			| ImGuiWindowFlags_NoTitleBar 
			| ImGuiWindowFlags_NoResize 
			| ImGuiWindowFlags_NoMove 
			| ImGuiWindowFlags_NoCollapse 
			| ImGuiWindowFlags_NoSavedSettings 
			| ImGuiWindowFlags_NoScrollbar 
			| ImGuiWindowFlags_NoScrollWithMouse 
			| ImGuiWindowFlags_ShowBorders 
			| ImGuiWindowFlags_NoBringToFrontOnFocus;

		Dock* root = getRootDock();
		if (root) {
			SetNextWindowPos(root->pos);
			SetNextWindowSize(root->size);
		} else {
			SetNextWindowPos(ImVec2(0, 0));
			SetNextWindowSize(GetIO().DisplaySize);
		}
		ImGui::PushStyleVar(ImGuiStyleVar_WindowRounding, 0);
		Begin("###DockPanel", nullptr, flags);
		splits();

		checkNonexistent();
	}
	
	void endPanel()
	{
		End();
		ImGui::PopStyleVar();
	}

	// Doesn't use input??
	Dock* getDockAt(const ImVec2& /*pos*/) const
	{
		for (int i = 0; i < m_docks.size(); ++i) {
			Dock& dock = *m_docks[i];
			if (dock.isContainer()) {
				continue;
			}
			if (dock.status != Status_Docked) {
				continue;
			}
			if (IsMouseHoveringRect(dock.pos, dock.pos + dock.size, false)) {
				return &dock;
			}
		}

		return nullptr;
	}

	static ImRect getDockedRect(const ImRect& rect, Slot_ dock_slot)
	{
		ImVec2 half_size = rect.GetSize() * 0.5f;
		switch (dock_slot) {
		default:          return rect;
		case Slot_Top:    return ImRect(rect.Min, rect.Min + ImVec2(rect.Max.x, half_size.y));
		case Slot_Right:  return ImRect(rect.Min + ImVec2(half_size.x, 0), rect.Max);
		case Slot_Bottom: return ImRect(rect.Min + ImVec2(0, half_size.y), rect.Max);
		case Slot_Left:   return ImRect(rect.Min, rect.Min + ImVec2(half_size.x, rect.Max.y));
		}
	}
	
	static ImRect getSlotRect(ImRect parent_rect, Slot_ dock_slot)
	{
		ImVec2 size = parent_rect.Max - parent_rect.Min;
		ImVec2 center = parent_rect.Min + size * 0.5f;
		switch (dock_slot) {
		default:          return ImRect(center - ImVec2(20, 20), center + ImVec2(20, 20));
		case Slot_Top:    return ImRect(center + ImVec2(-20, -50), center + ImVec2(20, -30));
		case Slot_Right:  return ImRect(center + ImVec2(30, -20), center + ImVec2(50, 20));
		case Slot_Bottom: return ImRect(center + ImVec2(-20, +30), center + ImVec2(20, 50));
		case Slot_Left:   return ImRect(center + ImVec2(-50, -20), center + ImVec2(-30, 20));
		}
	}

	static ImRect getSlotRectOnBorder(ImRect parent_rect, Slot_ dock_slot)
	{
		ImVec2 size = parent_rect.Max - parent_rect.Min;
		ImVec2 center = parent_rect.Min + size * 0.5f;
		switch (dock_slot) {
		case Slot_Top:
			return ImRect(ImVec2(center.x - 20, parent_rect.Min.y + 10), ImVec2(center.x + 20, parent_rect.Min.y + 30));
		case Slot_Left:
			return ImRect(ImVec2(parent_rect.Min.x + 10, center.y - 20), ImVec2(parent_rect.Min.x + 30, center.y + 20));
		case Slot_Bottom:
			return ImRect(ImVec2(center.x - 20, parent_rect.Max.y - 30), ImVec2(center.x + 20, parent_rect.Max.y - 10));
		case Slot_Right:
			return ImRect(ImVec2(parent_rect.Max.x - 30, center.y - 20), ImVec2(parent_rect.Max.x - 10, center.y + 20));
		default:
			break;
		}

		IM_ASSERT(false);
		return ImRect();
	}

	Dock* getRootDock()
	{
		for (int i = 0; i < m_docks.size(); ++i) {
			if (!m_docks[i]->parent && (m_docks[i]->status == Status_Docked || m_docks[i]->children[0])) {
				return m_docks[i];
			}
		}
		return nullptr;
	}

	bool dockSlots(Dock& dock, Dock* dest_dock, const ImRect& rect, bool on_border)
	{
		ImDrawList* canvas = GetWindowDrawList();
		ImU32 color = GetColorU32(ImGuiCol_Button);
		ImU32 color_hovered = GetColorU32(ImGuiCol_ButtonHovered);
		ImVec2 mouse_pos = GetIO().MousePos;
		for (int i = 0; i < (on_border ? 4 : 5); ++i) {
			ImRect r = on_border ? getSlotRectOnBorder(rect, (Slot_)i) : getSlotRect(rect, (Slot_)i);
			bool hovered = r.Contains(mouse_pos);

			canvas->AddRectFilled(r.Min, r.Max, hovered ? color_hovered : color);
			if (!hovered) {
				continue;
			}
			
			if (!IsMouseDown(0)) {
				doDock(dock, dest_dock ? dest_dock : getRootDock(), (Slot_)i);
				return true;
			}

			ImRect docked_rect = getDockedRect(rect, (Slot_)i);
			canvas->AddRectFilled(docked_rect.Min, docked_rect.Max, GetColorU32(ImGuiCol_Button));
		}
		return false;
	}
	
	void handleDrag(Dock& dock)
	{
		Dock* dest_dock = getDockAt(GetIO().MousePos);
		
		Begin("##Overlay", NULL, ImVec2(0, 0), 0.f, 0
				| ImGuiWindowFlags_Tooltip 
				| ImGuiWindowFlags_NoTitleBar 
				| ImGuiWindowFlags_NoMove 
				| ImGuiWindowFlags_NoResize 
				| ImGuiWindowFlags_NoSavedSettings 
				| ImGuiWindowFlags_AlwaysAutoResize);

		ImDrawList* canvas = GetWindowDrawList();

		canvas->PushClipRectFullScreen();
		
		ImU32 docked_color = GetColorU32(ImGuiCol_FrameBg);
		docked_color = (docked_color & 0x00ffFFFF) | 0x80000000;
		dock.pos = GetIO().MousePos - m_drag_offset;
		if (dest_dock) {
			if (dockSlots(dock, dest_dock, ImRect(dest_dock->pos, dest_dock->pos + dest_dock->size), false)) {
				canvas->PopClipRect();
				End();
				return;
			}
		}
		if (dockSlots(dock, nullptr, ImRect(ImVec2(0, 0), GetIO().DisplaySize), true)) {
			canvas->PopClipRect();
			End();
			return;
		}
		canvas->AddRectFilled(dock.pos, dock.pos + dock.size, docked_color);
		canvas->PopClipRect();

		if (!IsMouseDown(0)) {
			dock.status = Status_Float;
			dock.location[0] = 0;
			dock.setActive();
		}

		End();
	}
	
	void fillLocation(Dock& dock)
	{
		if (dock.status == Status_Float) {
			return;
		}
		
		char* c = dock.location;
		Dock* tmp = &dock;
		while (tmp->parent) {
			*c = getLocationCode(tmp);
			tmp = tmp->parent;
			++c;
		}
		*c = 0;
	}
	
	void doUndock(Dock& dock)
	{
		if (dock.prev_tab) {
			dock.prev_tab->setActive();
		} else if (dock.next_tab) {
			dock.next_tab->setActive();
		} else {
			dock.active = false;
		}
		
		Dock* container = dock.parent;
		if (container) {
			Dock& sibling = dock.getSibling();
			if (container->children[0] == &dock) {
				container->children[0] = dock.next_tab;
			} else if (container->children[1] == &dock) {
				container->children[1] = dock.next_tab;
			}

			bool remove_container = !container->children[0] || !container->children[1];
			if (remove_container) {
				if (container->parent) {
					Dock*& child = container->parent->children[0] == container ? container->parent->children[0] : container->parent->children[1];
					child = &sibling;
					child->setPosSize(container->pos, container->size);
					child->setParent(container->parent);
				} else {
					if (container->children[0]) {
						container->children[0]->setParent(nullptr);
						container->children[0]->setPosSize(container->pos, container->size);
					}
					if (container->children[1]) {
						container->children[1]->setParent(nullptr);
						container->children[1]->setPosSize(container->pos, container->size);
					}
				}
				
				for (int i = 0; i < m_docks.size(); ++i) {
					if (m_docks[i] == container) {
						m_docks.erase(m_docks.begin() + i);
						break;
					}
				}
				
				container->~Dock();
				MemFree(container);
			}
		}
		
		if (dock.prev_tab) {
			dock.prev_tab->next_tab = dock.next_tab;
		}
		if (dock.next_tab) {
			dock.next_tab->prev_tab = dock.prev_tab;
		}
		dock.parent = nullptr;
		dock.prev_tab = dock.next_tab = nullptr;
	}
	
	void drawTabbarListButton(Dock& dock)
	{
		if (!dock.next_tab) {
			return;
		}

		ImDrawList* draw_list = GetWindowDrawList();
		if (InvisibleButton("list", ImVec2(16, 16))) {
			OpenPopup("tab_list_popup");
		}
		
		if (BeginPopup("tab_list_popup")) {
			Dock* tmp = &dock;
			while (tmp) {
				bool dummy = false;
				if (Selectable(tmp->label, &dummy)) {
					tmp->setActive();
				}
				tmp = tmp->next_tab;
			}
			EndPopup();
		}

		bool hovered = IsItemHovered();
		ImVec2 min = GetItemRectMin();
		ImVec2 max = GetItemRectMax();
		ImVec2 center = (min + max) * 0.5f;
		ImU32 text_color = GetColorU32(ImGuiCol_Text);
		ImU32 color_active = GetColorU32(ImGuiCol_FrameBgActive);
		draw_list->AddRectFilled(ImVec2(center.x - 4, min.y + 3), ImVec2(center.x + 4, min.y + 5), hovered ? color_active : text_color);
		draw_list->AddTriangleFilled(ImVec2(center.x - 4, min.y + 7), ImVec2(center.x + 4, min.y + 7), ImVec2(center.x, min.y + 12), hovered ? color_active : text_color);
	}
	
	bool tabbar(Dock& dock, bool close_button)
	{
		float tabbar_height = 2 * GetTextLineHeightWithSpacing();
		ImVec2 size(dock.size.x, tabbar_height);
		bool tab_closed = false;

		SetCursorScreenPos(dock.pos);
		char tmp[20];
		ImFormatString(tmp, IM_ARRAYSIZE(tmp), "tabs%d", (int)dock.id);
		if (BeginChild(tmp, size, true)) {
			Dock* dock_tab = &dock;
			
			ImDrawList* draw_list = GetWindowDrawList();
			ImU32 color = GetColorU32(ImGuiCol_FrameBg);
			ImU32 color_active = GetColorU32(ImGuiCol_FrameBgActive);
			ImU32 color_hovered = GetColorU32(ImGuiCol_FrameBgHovered);
			ImU32 text_color = GetColorU32(ImGuiCol_Text);
			ImU32 text_color_disabled = GetColorU32(ImGuiCol_TextDisabled);
			float line_height = GetTextLineHeightWithSpacing();
			float tab_base;
			
			drawTabbarListButton(dock);

			while (dock_tab) {
				SameLine(0, 15);

				const char* text_end = FindRenderedTextEnd(dock_tab->label);
				ImVec2 size(CalcTextSize(dock_tab->label, text_end).x, line_height);
				if (InvisibleButton(dock_tab->label, size)) {
					dock_tab->setActive();
				}

				if (IsItemActive() && IsMouseDragging()) {
					m_drag_offset = GetMousePos() - dock_tab->pos;
					doUndock(*dock_tab);
					dock_tab->status = Status_Dragged;
				}

				bool hovered = IsItemHovered();
				ImVec2 pos = GetItemRectMin();
				size.x += 20 + GetStyle().ItemSpacing.x;

				tab_base = pos.y;

				draw_list->AddRectFilled(pos + ImVec2(-8.0f, 0.0), pos + size, hovered ? color_hovered : (dock_tab->active ? color_active : color));
				draw_list->AddText(pos, text_color, dock_tab->label, text_end);

				if (dock_tab->active && close_button) {
					SameLine();
					tab_closed = InvisibleButton("close", ImVec2(16, 16));

					ImVec2 center = ((GetItemRectMin() + GetItemRectMax()) * 0.5f);
					draw_list->AddLine(center + ImVec2(-3.5f, -3.5f), center + ImVec2(3.5f, 3.5f), text_color);
					draw_list->AddLine(center + ImVec2(3.5f, -3.5f), center + ImVec2(-3.5f, 3.5f), text_color);
				} else {
					if (!dock_tab->active && close_button) {
						SameLine();
						InvisibleButton("close", ImVec2(16, 16));

						ImVec2 center = ((GetItemRectMin() + GetItemRectMax()) * 0.5f);
						draw_list->AddLine(center + ImVec2(-3.5f, -3.5f), center + ImVec2(3.5f, 3.5f), text_color_disabled);
						draw_list->AddLine(center + ImVec2(3.5f, -3.5f), center + ImVec2(-3.5f, 3.5f), text_color_disabled);
					}
				}

				dock_tab = dock_tab->next_tab;
			}
			ImVec2 cp(dock.pos.x, tab_base + line_height);
			draw_list->AddLine(cp, cp + ImVec2(dock.size.x, 0), color);
		}
		EndChild();
		return tab_closed;
	}

	static void setDockPosSize(Dock& dest, Dock& dock, Slot_ dock_slot, Dock& container)
	{
		IM_ASSERT(!dock.prev_tab && !dock.next_tab && !dock.children[0] && !dock.children[1]);

		dest.pos = container.pos;
		dest.size = container.size;
		dock.pos = container.pos;
		dock.size = container.size;

		switch (dock_slot) {
		case Slot_Bottom:
			dest.size.y *= 0.5f;
			dock.size.y *= 0.5f;
			dock.pos.y += dest.size.y;
			break;
		case Slot_Right:
			dest.size.x *= 0.5f;
			dock.size.x *= 0.5f;
			dock.pos.x += dest.size.x;
			break;
		case Slot_Left:
			dest.size.x *= 0.5f;
			dock.size.x *= 0.5f;
			dest.pos.x += dock.size.x;
			break;
		case Slot_Top:
			dest.size.y *= 0.5f;
			dock.size.y *= 0.5f;
			dest.pos.y += dock.size.y;
			break;
		default: IM_ASSERT(false); break;
		}
		dest.setPosSize(dest.pos, dest.size);

		if (container.children[1]->pos.x < container.children[0]->pos.x ||
			container.children[1]->pos.y < container.children[0]->pos.y) 
		{
			Dock* tmp = container.children[0];
			container.children[0] = container.children[1];
			container.children[1] = tmp;
		}
	}

	void doDock(Dock& dock, Dock* dest, Slot_ dock_slot)
	{
		IM_ASSERT(!dock.parent);
		if (!dest) {
			dock.status = Status_Docked;
			dock.setPosSize(ImVec2(0, 0), GetIO().DisplaySize);
		} else if (dock_slot == Slot_Tab) {
			Dock* tmp = dest;
			while (tmp->next_tab) {
				tmp = tmp->next_tab;
			}

			tmp->next_tab = &dock;
			dock.prev_tab = tmp;
			dock.size = tmp->size;
			dock.pos = tmp->pos;
			dock.parent = dest->parent;
			dock.status = Status_Docked;
		} else if (dock_slot == Slot_None) {
			dock.status = Status_Float;
		} else {
			Dock* container = (Dock*)MemAlloc(sizeof(Dock));
			IM_PLACEMENT_NEW(container) Dock();
			m_docks.push_back(container);
			container->children[0] = &dest->getFirstTab();
			container->children[1] = &dock;
			container->next_tab = nullptr;
			container->prev_tab = nullptr;
			container->parent = dest->parent;
			container->size = dest->size;
			container->pos = dest->pos;
			container->status = Status_Docked;
			container->label = ImStrdup("");

			if (!dest->parent) {
			} else if (&dest->getFirstTab() == dest->parent->children[0]) {
				dest->parent->children[0] = container;
			} else {
				dest->parent->children[1] = container;
			}

			dest->setParent(container);
			dock.parent = container;
			dock.status = Status_Docked;

			setDockPosSize(*dest, dock, dock_slot, *container);
		}
		dock.setActive();
	}

	void rootDock(const ImVec2& pos, const ImVec2& size)
	{
		Dock* root = getRootDock();
		if (!root) {
			return;
		}
		
		ImVec2 min_size = root->getMinSize();
		ImVec2 requested_size = size;
		root->setPosSize(pos, ImMax(min_size, requested_size));
	}

	void setDockActive()
	{
		IM_ASSERT(m_current);
		if (m_current) {
			m_current->setActive();
		}
	}
	
	static Slot_ getSlotFromLocationCode(char code)
	{
		switch (code) {
		case '1': return Slot_Left;
		case '2': return Slot_Top;
		case '3': return Slot_Bottom;
		default:  return Slot_Right;
		}
	}

	static char getLocationCode(Dock* dock)
	{
		if (!dock) {
			return '0';
		}

		if (dock->parent->isHorizontal()) {
			return ((dock->pos.x < dock->parent->children[0]->pos.x) || (dock->pos.x < dock->parent->children[1]->pos.x)) ? '1' : '0';
		} else {
			return ((dock->pos.y < dock->parent->children[0]->pos.y) || (dock->pos.y < dock->parent->children[1]->pos.y)) ? '2' : '3';
		}
	}

	void tryDockToStoredLocation(Dock& dock)
	{
		if (dock.status == Status_Docked) return;
		if (dock.location[0] == 0) return;

		Dock* tmp = getRootDock();
		if (!tmp) return;

		Dock* prev = nullptr;
		char* c = dock.location + strlen(dock.location) - 1;
		while (c >= dock.location && tmp) {
			prev = tmp;
			tmp = *c == getLocationCode(tmp->children[0]) ? tmp->children[0] : tmp->children[1];
			if (tmp) --c;
		}
		if (tmp && tmp->children[0]) tmp = tmp->parent;
		doDock(dock, tmp ? tmp : prev, tmp && !tmp->children[0] ? Slot_Tab : getSlotFromLocationCode(*c));
	}

	bool begin(const char* label, bool* opened, ImGuiWindowFlags extra_flags)
	{
		Dock* dock = getDock(label, !opened || *opened, true);
		if (!dock->opened && (!opened || *opened)) {
			tryDockToStoredLocation(*dock);
		}

		dock->last_frame = ImGui::GetFrameCount();
		if (strcmp(dock->label, label) != 0) {
			MemFree(dock->label);
			dock->label = ImStrdup(label);
		}

		m_end_action = EndAction_None;
		
		if (dock->first && opened) {
			*opened = dock->opened;
		}

		dock->first = false;
		if (opened && !*opened) {
			if (dock->status != Status_Float) {
				fillLocation(*dock);
				doUndock(*dock);
				dock->status = Status_Float;
			}
			dock->opened = false;
			return false;
		}
		dock->opened = true;

		m_end_action = EndAction_Panel;
		beginPanel();

		m_current = dock;
		if (dock->status == Status_Dragged) {
			handleDrag(*dock);
		}

		bool is_float = dock->status == Status_Float;
		if (is_float) {
			SetNextWindowPos(dock->pos);
			SetNextWindowSize(dock->size);
			bool ret = Begin(label, opened, dock->size, -1.0f, ImGuiWindowFlags_NoCollapse | ImGuiWindowFlags_ShowBorders | extra_flags);
			m_end_action = EndAction_End;
			dock->pos = GetWindowPos();
			dock->size = GetWindowSize();

			ImGuiContext& g = *GImGui;

			if (g.ActiveId == GetCurrentWindow()->MoveId && g.IO.MouseDown[0]) {
				m_drag_offset = GetMousePos() - dock->pos;
				doUndock(*dock);
				dock->status = Status_Dragged;
			}
			return ret;
		}

		if (!dock->active && dock->status != Status_Dragged) {
			return false;
		}

		m_end_action = EndAction_EndChild;

		PushStyleColor(ImGuiCol_Border, ImVec4(0, 0, 0, 0));
		PushStyleColor(ImGuiCol_BorderShadow, ImVec4(0, 0, 0, 0));
		float tabbar_height = GetTextLineHeightWithSpacing();
		if (tabbar(dock->getFirstTab(), opened != nullptr)) {
			fillLocation(*dock);
			*opened = false;
		}

		ImVec2 pos = dock->pos;
		ImVec2 size = dock->size;
		pos.y += tabbar_height + GetStyle().WindowPadding.y;
		size.y -= tabbar_height + GetStyle().WindowPadding.y;

		SetCursorScreenPos(pos);
		ImGuiWindowFlags flags = 0 
			| ImGuiWindowFlags_NoTitleBar 
			| ImGuiWindowFlags_NoResize 
			| ImGuiWindowFlags_NoMove 
			| ImGuiWindowFlags_NoCollapse 
			| ImGuiWindowFlags_NoSavedSettings 
			| ImGuiWindowFlags_NoBringToFrontOnFocus 
			| extra_flags;

		char tmp[256];
		strcpy(tmp, label);
		strcat(tmp, "_docked"); // to avoid https://github.com/ocornut/imgui/issues/713
		bool ret = BeginChild(tmp, size, true, flags);
		PopStyleColor();
		PopStyleColor();
		return ret;
	}

	void end()
	{
		if (m_end_action == EndAction_End) {
			End();
		} else if (m_end_action == EndAction_EndChild) {
			PushStyleColor(ImGuiCol_Border, ImVec4(0, 0, 0, 0));
			PushStyleColor(ImGuiCol_BorderShadow, ImVec4(0, 0, 0, 0));
			EndChild();
			PopStyleColor();
			PopStyleColor();
		}

		m_current = nullptr;
		
		if (m_end_action > EndAction_None) {
			endPanel();
		}
	}

	int getDockIndex(Dock* dock)
	{
		if (!dock) return -1;

		for (int i = 0; i < m_docks.size(); ++i) {
			if (dock == m_docks[i]) {
				return i;
			}
		}

		IM_ASSERT(false);

		return -1;
	}
		
	void save()
	{
		FILE* f = fopen("layout.json", "w");

		fprintf(f, "{\n");
		fprintf(f, "\t\"docks\" = [\n");

		const unsigned int n = m_docks.size();
		for (unsigned int i = 0; i < n; ++i) {
			Dock* dock = m_docks[i];

			fillLocation(*dock);

			fprintf(f, "\t\t{\n");
			fprintf(f, "\t\t\t\"index\" = \"%d\",\n", i);
			fprintf(f, "\t\t\t\"label\" = \"%s\",\n", dock->parent ? (dock->label[0] == '\0' ? "DOCK" : dock->label) : "ROOT");
			fprintf(f, "\t\t\t\"x\" = \"%f\",\n", dock->pos.x);
			fprintf(f, "\t\t\t\"y\" = \"%f\",\n", dock->pos.y);
			fprintf(f, "\t\t\t\"size_x\" = \"%f\",\n", dock->size.x);
			fprintf(f, "\t\t\t\"size_y\" = \"%f\",\n", dock->size.y);
			fprintf(f, "\t\t\t\"status\" = \"%d\",\n", dock->status);
			fprintf(f, "\t\t\t\"active\" = \"%s\",\n", dock->active ? "true" : "false");
			fprintf(f, "\t\t\t\"opened\" = \"%s\",\n", dock->opened ? "true" : "false");
			fprintf(f, "\t\t\t\"location\" = \"%s\",\n", strlen(dock->location) ? dock->location : "-1");
			fprintf(f, "\t\t\t\"child0\" = \"%d\",\n", getDockIndex(dock->children[0]));
			fprintf(f, "\t\t\t\"child1\" = \"%d\",\n", getDockIndex(dock->children[1]));
			fprintf(f, "\t\t\t\"prev_tab\" = \"%d\",\n", getDockIndex(dock->prev_tab));
			fprintf(f, "\t\t\t\"next_tab\" = \"%d\",\n", getDockIndex(dock->next_tab));
			fprintf(f, "\t\t\t\"parent\" = \"%d\"\n", getDockIndex(dock->parent));

			if (i != n - 1) {
				fprintf(f, "\t\t},\n");
			} else {
				fprintf(f, "\t\t}\n");
			}
		}
		fprintf(f, "\t]\n");
		fprintf(f, "}");

		fclose(f);
	}

	Dock* getDockByIndex(int idx) 
	{ 
		return idx < 0 ? nullptr : m_docks[idx]; 
	}

	void load()
	{
		// Free all existing docks (should be 0);
		const unsigned int n = m_docks.size();
		for (unsigned int i = 0; i < n; ++i) {
			m_docks[i]->~Dock();
			MemFree(m_docks[i]);
		}
		m_docks.clear();

		// Load the whole file into memory...
		FILE* f = fopen("layout.json", "rb");
		if (!f) {
			return;
		}

		fseek(f, 0, SEEK_END);
		unsigned int fileSize = (unsigned int)ftell(f);
		fseek(f, 0, SEEK_SET);

		char* fileBuffer = (char*)malloc(fileSize + 1);
		fread(fileBuffer, fileSize, 1, f);
		fileBuffer[fileSize] = '\0';

		fclose(f);

		// Parse the file...
		int read = 0;
		int num = json_num(fileBuffer, fileSize);
		json_token* toks = (json_token*)calloc(num, sizeof(json_token));
		json_load(toks, num, &read, fileBuffer, fileSize);

		json_token* docksToken = json_query(toks, num, "docks");
		IM_ASSERT(docksToken);
		int numDocks = docksToken->children;
		for (int i = 0; i < numDocks; i++) {
			Dock *new_dock = (Dock *)MemAlloc(sizeof(Dock));
			IM_PLACEMENT_NEW(new_dock) Dock();
			m_docks.push_back(new_dock);
		}

		for (int i = 0; i < numDocks; ++i) {
			char tokenStr[256];
			sprintf(tokenStr, "[%d]", i);

			json_token* dockToken = json_query(docksToken, docksToken->sub, tokenStr);
			json_token* indexToken = json_query(dockToken, dockToken->sub, "index");
			json_token* labelToken = json_query(dockToken, dockToken->sub, "label");
			json_token* posXToken = json_query(dockToken, dockToken->sub, "x");
			json_token* posYToken = json_query(dockToken, dockToken->sub, "y");
			json_token* sizeXToken = json_query(dockToken, dockToken->sub, "size_x");
			json_token* sizeYToken = json_query(dockToken, dockToken->sub, "size_y");
			json_token* statusToken = json_query(dockToken, dockToken->sub, "status");
			json_token* activeToken = json_query(dockToken, dockToken->sub, "active");
			json_token* openedToken = json_query(dockToken, dockToken->sub, "opened");
			json_token* locationToken = json_query(dockToken, dockToken->sub, "location");
			json_token* child0Token = json_query(dockToken, dockToken->sub, "child0");
			json_token* child1Token = json_query(dockToken, dockToken->sub, "child1");
			json_token* prevTabToken = json_query(dockToken, dockToken->sub, "prev_tab");
			json_token* nextTabToken = json_query(dockToken, dockToken->sub, "next_tab");
			json_token* parentToken = json_query(dockToken, dockToken->sub, "parent");

			IM_ASSERT(dockToken);
			IM_ASSERT(indexToken);
			IM_ASSERT(labelToken);
			IM_ASSERT(posXToken);
			IM_ASSERT(posYToken);
			IM_ASSERT(sizeXToken);
			IM_ASSERT(sizeYToken);
			IM_ASSERT(statusToken);
			IM_ASSERT(activeToken);
			IM_ASSERT(openedToken);
			IM_ASSERT(locationToken);
			IM_ASSERT(child0Token);
			IM_ASSERT(child1Token);
			IM_ASSERT(prevTabToken);
			IM_ASSERT(nextTabToken);
			IM_ASSERT(parentToken);

			int id = atoi(indexToken->str);
			float posX = (float)atof(posXToken->str);
			float posY = (float)atof(posYToken->str);
			float sizeX = (float)atof(sizeXToken->str);
			float sizeY = (float)atof(sizeYToken->str);
			int status = atoi(statusToken->str);
			bool active = !strncmp(activeToken->str, "true", 4);
			bool opened = !strncmp(openedToken->str, "true", 4);
			int child0 = atoi(child0Token->str);
			int child1 = atoi(child1Token->str);
			int prevTab = atoi(prevTabToken->str);
			int nextTab = atoi(nextTabToken->str);
			int parent = atoi(parentToken->str);

			Dock* dock = m_docks[id];

			int locLen = ImMin(IM_ARRAYSIZE(dock->location) - 1, locationToken->len);
			memcpy(dock->location, locationToken->str, locLen);
			dock->location[locLen] = '\0';
			dock->label = strndup(labelToken->str, labelToken->len);
			dock->id = ImHash(dock->label, 0);
			dock->pos.x = posX;
			dock->pos.y = posY;
			dock->size.x = sizeX;
			dock->size.y = sizeY;
			dock->children[0] = getDockByIndex(child0);
			dock->children[1] = getDockByIndex(child1);
			dock->prev_tab = getDockByIndex(prevTab);
			dock->next_tab = getDockByIndex(nextTab);
			dock->parent = getDockByIndex(parent);
			dock->status = (Status_)status;
			dock->active = active;
			dock->opened = opened;

			tryDockToStoredLocation(*dock);
		}

		free(fileBuffer);
		free(toks);
	}
};

static DockContext g_dock;
//void Print()
//{
//	for (int i = 0; i < g_dock.m_docks.size(); ++i) {
//		ImGui::Text("i=%d this=0x%.8p state=(%d %d) pos=(%.0f %.0f) size=(%.0f %.0f) children=(%s %s) tabs=(%s %s) parent=%s status=%d  location='%s' label='%s'\n", i,
//			(void*)g_dock.m_docks[i],
//			g_dock.m_docks[i]->active,
//			g_dock.m_docks[i]->opened,
//			g_dock.m_docks[i]->pos.x,
//			g_dock.m_docks[i]->pos.y,
//			g_dock.m_docks[i]->size.x,
//			g_dock.m_docks[i]->size.y,
//			g_dock.m_docks[i]->children[0] ? g_dock.m_docks[i]->children[0]->label : "None",
//			g_dock.m_docks[i]->children[1] ? g_dock.m_docks[i]->children[1]->label : "None",
//			g_dock.m_docks[i]->prev_tab ? g_dock.m_docks[i]->prev_tab->label : "None",
//			g_dock.m_docks[i]->next_tab ? g_dock.m_docks[i]->next_tab->label : "None",
//			g_dock.m_docks[i]->parent ? g_dock.m_docks[i]->parent->label : "None",
//			g_dock.m_docks[i]->status,
//			g_dock.m_docks[i]->location,
//			g_dock.m_docks[i]->label);
//	}
//}

void ShutdownDock()
{
	for (int i = 0; i < g_dock.m_docks.size(); ++i) {
		g_dock.m_docks[i]->~Dock();
		MemFree(g_dock.m_docks[i]);
	}
	g_dock.m_docks.clear();
}

void RootDock(const ImVec2& pos, const ImVec2& size)
{
	g_dock.rootDock(pos, size);
}

void SetDockActive()
{
	g_dock.setDockActive();
}

void SetDockActive(const char* label)
{
	DockContext::Dock* dock = g_dock.getDock(label, true, false);
	if (!dock) {
		return;
	}

	dock->setActive();
}

bool BeginDock(const char* label, bool* opened, ImGuiWindowFlags extra_flags)
{
	return g_dock.begin(label, opened, extra_flags);
}

void EndDock()
{
	g_dock.end();
}

void SaveDock()
{
	g_dock.save();
}

void LoadDock()
{
	g_dock.load();
}
} // namespace ImGui
