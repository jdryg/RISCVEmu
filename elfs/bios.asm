
bios:     file format elf32-littleriscv


Disassembly of section .text:

00000200 <_start>:
 200:	0080006f          	j	208 <reset>

00000204 <trap_vector>:
 204:	0340006f          	j	238 <trap>

00000208 <reset>:
 208:	00000297          	auipc	t0,0x0
 20c:	03028293          	addi	t0,t0,48 # 238 <trap>
 210:	30529073          	csrw	mtvec,t0
 214:	30005073          	csrwi	mstatus,0
 218:	30305073          	csrwi	mideleg,0
 21c:	30205073          	csrwi	medeleg,0
 220:	30405073          	csrwi	mie,0
 224:	00002197          	auipc	gp,0x2
 228:	a0418193          	addi	gp,gp,-1532 # 1c28 <_gp>
 22c:	00002117          	auipc	sp,0x2
 230:	19410113          	addi	sp,sp,404 # 23c0 <_end>
 234:	2a80006f          	j	4dc <_init>

00000238 <trap>:
 238:	f8010113          	addi	sp,sp,-128
 23c:	00112223          	sw	ra,4(sp)
 240:	00212423          	sw	sp,8(sp)
 244:	00312623          	sw	gp,12(sp)
 248:	00412823          	sw	tp,16(sp)
 24c:	00512a23          	sw	t0,20(sp)
 250:	00612c23          	sw	t1,24(sp)
 254:	00712e23          	sw	t2,28(sp)
 258:	02812023          	sw	s0,32(sp)
 25c:	02912223          	sw	s1,36(sp)
 260:	02a12423          	sw	a0,40(sp)
 264:	02b12623          	sw	a1,44(sp)
 268:	02c12823          	sw	a2,48(sp)
 26c:	02d12a23          	sw	a3,52(sp)
 270:	02e12c23          	sw	a4,56(sp)
 274:	02f12e23          	sw	a5,60(sp)
 278:	05012023          	sw	a6,64(sp)
 27c:	05112223          	sw	a7,68(sp)
 280:	05212423          	sw	s2,72(sp)
 284:	05312623          	sw	s3,76(sp)
 288:	05412823          	sw	s4,80(sp)
 28c:	05512a23          	sw	s5,84(sp)
 290:	05612c23          	sw	s6,88(sp)
 294:	05712e23          	sw	s7,92(sp)
 298:	07812023          	sw	s8,96(sp)
 29c:	07912223          	sw	s9,100(sp)
 2a0:	07a12423          	sw	s10,104(sp)
 2a4:	07b12623          	sw	s11,108(sp)
 2a8:	07c12823          	sw	t3,112(sp)
 2ac:	07d12a23          	sw	t4,116(sp)
 2b0:	07e12c23          	sw	t5,120(sp)
 2b4:	07f12e23          	sw	t6,124(sp)
 2b8:	34202573          	csrr	a0,mcause
 2bc:	341025f3          	csrr	a1,mepc
 2c0:	00010613          	mv	a2,sp
 2c4:	1a0000ef          	jal	ra,464 <handle_trap>
 2c8:	34151073          	csrw	mepc,a0
 2cc:	00412083          	lw	ra,4(sp)
 2d0:	00812103          	lw	sp,8(sp)
 2d4:	00c12183          	lw	gp,12(sp)
 2d8:	01012203          	lw	tp,16(sp)
 2dc:	01412283          	lw	t0,20(sp)
 2e0:	01812303          	lw	t1,24(sp)
 2e4:	01c12383          	lw	t2,28(sp)
 2e8:	02012403          	lw	s0,32(sp)
 2ec:	02412483          	lw	s1,36(sp)
 2f0:	02812503          	lw	a0,40(sp)
 2f4:	02c12583          	lw	a1,44(sp)
 2f8:	03012603          	lw	a2,48(sp)
 2fc:	03412683          	lw	a3,52(sp)
 300:	03812703          	lw	a4,56(sp)
 304:	03c12783          	lw	a5,60(sp)
 308:	04012803          	lw	a6,64(sp)
 30c:	04412883          	lw	a7,68(sp)
 310:	04812903          	lw	s2,72(sp)
 314:	04c12983          	lw	s3,76(sp)
 318:	05012a03          	lw	s4,80(sp)
 31c:	05412a83          	lw	s5,84(sp)
 320:	05812b03          	lw	s6,88(sp)
 324:	05c12b83          	lw	s7,92(sp)
 328:	06012c03          	lw	s8,96(sp)
 32c:	06412c83          	lw	s9,100(sp)
 330:	06812d03          	lw	s10,104(sp)
 334:	06c12d83          	lw	s11,108(sp)
 338:	07012e03          	lw	t3,112(sp)
 33c:	07412e83          	lw	t4,116(sp)
 340:	07812f03          	lw	t5,120(sp)
 344:	07c12f83          	lw	t6,124(sp)
 348:	08010113          	addi	sp,sp,128
 34c:	30200073          	mret

00000350 <readLine>:
 350:	fd010113          	addi	sp,sp,-48
 354:	01312e23          	sw	s3,28(sp)
 358:	01412c23          	sw	s4,24(sp)
 35c:	00058993          	mv	s3,a1
 360:	00050a13          	mv	s4,a0
 364:	00100613          	li	a2,1
 368:	00f10593          	addi	a1,sp,15
 36c:	00000513          	li	a0,0
 370:	02812423          	sw	s0,40(sp)
 374:	03212023          	sw	s2,32(sp)
 378:	02112623          	sw	ra,44(sp)
 37c:	02912223          	sw	s1,36(sp)
 380:	000a0413          	mv	s0,s4
 384:	3d8000ef          	jal	ra,75c <read>
 388:	00a00913          	li	s2,10
 38c:	fff98993          	addi	s3,s3,-1
 390:	00050863          	beqz	a0,3a0 <readLine+0x50>
 394:	00f14783          	lbu	a5,15(sp)
 398:	05278063          	beq	a5,s2,3d8 <readLine+0x88>
 39c:	00079c63          	bnez	a5,3b4 <readLine+0x64>
 3a0:	00100613          	li	a2,1
 3a4:	00f10593          	addi	a1,sp,15
 3a8:	00000513          	li	a0,0
 3ac:	3b0000ef          	jal	ra,75c <read>
 3b0:	fe1ff06f          	j	390 <readLine+0x40>
 3b4:	00f40023          	sb	a5,0(s0)
 3b8:	00100613          	li	a2,1
 3bc:	00f10593          	addi	a1,sp,15
 3c0:	00100513          	li	a0,1
 3c4:	00140493          	addi	s1,s0,1
 3c8:	3bc000ef          	jal	ra,784 <write>
 3cc:	414487b3          	sub	a5,s1,s4
 3d0:	00048413          	mv	s0,s1
 3d4:	fd3796e3          	bne	a5,s3,3a0 <readLine+0x50>
 3d8:	00040023          	sb	zero,0(s0)
 3dc:	02c12083          	lw	ra,44(sp)
 3e0:	02812403          	lw	s0,40(sp)
 3e4:	02412483          	lw	s1,36(sp)
 3e8:	02012903          	lw	s2,32(sp)
 3ec:	01c12983          	lw	s3,28(sp)
 3f0:	01812a03          	lw	s4,24(sp)
 3f4:	03010113          	addi	sp,sp,48
 3f8:	00008067          	ret

000003fc <unhandled_trap>:
 3fc:	ff010113          	addi	sp,sp,-16
 400:	000015b7          	lui	a1,0x1
 404:	00812423          	sw	s0,8(sp)
 408:	cb058593          	addi	a1,a1,-848 # cb0 <main+0x110>
 40c:	00050413          	mv	s0,a0
 410:	01100613          	li	a2,17
 414:	00200513          	li	a0,2
 418:	00112623          	sw	ra,12(sp)
 41c:	368000ef          	jal	ra,784 <write>
 420:	00040593          	mv	a1,s0
 424:	00200513          	li	a0,2
 428:	170000ef          	jal	ra,598 <write_hex>
 42c:	0000006f          	j	42c <unhandled_trap+0x30>

00000430 <illegalInstrTrap>:
 430:	ff010113          	addi	sp,sp,-16
 434:	000015b7          	lui	a1,0x1
 438:	00812423          	sw	s0,8(sp)
 43c:	cc458593          	addi	a1,a1,-828 # cc4 <main+0x124>
 440:	00050413          	mv	s0,a0
 444:	02000613          	li	a2,32
 448:	00200513          	li	a0,2
 44c:	00112623          	sw	ra,12(sp)
 450:	334000ef          	jal	ra,784 <write>
 454:	00040593          	mv	a1,s0
 458:	00200513          	li	a0,2
 45c:	13c000ef          	jal	ra,598 <write_hex>
 460:	0000006f          	j	460 <illegalInstrTrap+0x30>

00000464 <handle_trap>:
 464:	00300793          	li	a5,3
 468:	04f50c63          	beq	a0,a5,4c0 <handle_trap+0x5c>
 46c:	ff010113          	addi	sp,sp,-16
 470:	00812423          	sw	s0,8(sp)
 474:	00912223          	sw	s1,4(sp)
 478:	00112623          	sw	ra,12(sp)
 47c:	00060493          	mv	s1,a2
 480:	00058413          	mv	s0,a1
 484:	04a7f263          	bleu	a0,a5,4c8 <handle_trap+0x64>
 488:	00800793          	li	a5,8
 48c:	00f50663          	beq	a0,a5,498 <handle_trap+0x34>
 490:	00b00793          	li	a5,11
 494:	04f51263          	bne	a0,a5,4d8 <handle_trap+0x74>
 498:	0444a503          	lw	a0,68(s1)
 49c:	02848593          	addi	a1,s1,40
 4a0:	310000ef          	jal	ra,7b0 <syscallHandler>
 4a4:	02a4a423          	sw	a0,40(s1)
 4a8:	00c12083          	lw	ra,12(sp)
 4ac:	00440513          	addi	a0,s0,4
 4b0:	00812403          	lw	s0,8(sp)
 4b4:	00412483          	lw	s1,4(sp)
 4b8:	01010113          	addi	sp,sp,16
 4bc:	00008067          	ret
 4c0:	00458513          	addi	a0,a1,4
 4c4:	00008067          	ret
 4c8:	00200793          	li	a5,2
 4cc:	00f51663          	bne	a0,a5,4d8 <handle_trap+0x74>
 4d0:	00058513          	mv	a0,a1
 4d4:	f5dff0ef          	jal	ra,430 <illegalInstrTrap>
 4d8:	f25ff0ef          	jal	ra,3fc <unhandled_trap>

000004dc <_init>:
 4dc:	00001537          	lui	a0,0x1
 4e0:	ff010113          	addi	sp,sp,-16
 4e4:	800005b7          	lui	a1,0x80000
 4e8:	43050513          	addi	a0,a0,1072 # 1430 <g_ConsoleUART>
 4ec:	00112623          	sw	ra,12(sp)
 4f0:	3b4000ef          	jal	ra,8a4 <uartInit>
 4f4:	6ac000ef          	jal	ra,ba0 <main>
 4f8:	46c000ef          	jal	ra,964 <exit>

000004fc <write.part.0>:
 4fc:	fe010113          	addi	sp,sp,-32
 500:	01412423          	sw	s4,8(sp)
 504:	00112e23          	sw	ra,28(sp)
 508:	00812c23          	sw	s0,24(sp)
 50c:	00912a23          	sw	s1,20(sp)
 510:	01212823          	sw	s2,16(sp)
 514:	01312623          	sw	s3,12(sp)
 518:	01512223          	sw	s5,4(sp)
 51c:	00058a13          	mv	s4,a1
 520:	02058c63          	beqz	a1,558 <write.part.0+0x5c>
 524:	00050413          	mv	s0,a0
 528:	00b509b3          	add	s3,a0,a1
 52c:	000014b7          	lui	s1,0x1
 530:	00a00913          	li	s2,10
 534:	00001ab7          	lui	s5,0x1
 538:	00040593          	mv	a1,s0
 53c:	00100613          	li	a2,1
 540:	43048513          	addi	a0,s1,1072 # 1430 <g_ConsoleUART>
 544:	3a0000ef          	jal	ra,8e4 <uartSend>
 548:	00044783          	lbu	a5,0(s0)
 54c:	00140413          	addi	s0,s0,1
 550:	03278863          	beq	a5,s2,580 <write.part.0+0x84>
 554:	ff3412e3          	bne	s0,s3,538 <write.part.0+0x3c>
 558:	01c12083          	lw	ra,28(sp)
 55c:	01812403          	lw	s0,24(sp)
 560:	000a0513          	mv	a0,s4
 564:	01412483          	lw	s1,20(sp)
 568:	01012903          	lw	s2,16(sp)
 56c:	00c12983          	lw	s3,12(sp)
 570:	00812a03          	lw	s4,8(sp)
 574:	00412a83          	lw	s5,4(sp)
 578:	02010113          	addi	sp,sp,32
 57c:	00008067          	ret
 580:	00100613          	li	a2,1
 584:	ce8a8593          	addi	a1,s5,-792 # ce8 <main+0x148>
 588:	43048513          	addi	a0,s1,1072
 58c:	358000ef          	jal	ra,8e4 <uartSend>
 590:	fb3414e3          	bne	s0,s3,538 <write.part.0+0x3c>
 594:	fc5ff06f          	j	558 <write.part.0+0x5c>

00000598 <write_hex>:
 598:	fc010113          	addi	sp,sp,-64
 59c:	02912a23          	sw	s1,52(sp)
 5a0:	03612023          	sw	s6,32(sp)
 5a4:	02112e23          	sw	ra,60(sp)
 5a8:	02812c23          	sw	s0,56(sp)
 5ac:	03212823          	sw	s2,48(sp)
 5b0:	03312623          	sw	s3,44(sp)
 5b4:	03412423          	sw	s4,40(sp)
 5b8:	03512223          	sw	s5,36(sp)
 5bc:	01712e23          	sw	s7,28(sp)
 5c0:	01812c23          	sw	s8,24(sp)
 5c4:	00200793          	li	a5,2
 5c8:	00050493          	mv	s1,a0
 5cc:	00058b13          	mv	s6,a1
 5d0:	0aa7fa63          	bleu	a0,a5,684 <write_hex+0xec>
 5d4:	000017b7          	lui	a5,0x1
 5d8:	00900713          	li	a4,9
 5dc:	42e7aa23          	sw	a4,1076(a5) # 1434 <errno>
 5e0:	01c00413          	li	s0,28
 5e4:	00f00a93          	li	s5,15
 5e8:	00900a13          	li	s4,9
 5ec:	00200993          	li	s3,2
 5f0:	00001c37          	lui	s8,0x1
 5f4:	00900b93          	li	s7,9
 5f8:	ffc00913          	li	s2,-4
 5fc:	01c0006f          	j	618 <write_hex+0x80>
 600:	0ff6f793          	andi	a5,a3,255
 604:	00f107a3          	sb	a5,15(sp)
 608:	0299fc63          	bleu	s1,s3,640 <write_hex+0xa8>
 60c:	437c2a23          	sw	s7,1076(s8) # 1434 <errno>
 610:	ffc40413          	addi	s0,s0,-4
 614:	05240063          	beq	s0,s2,654 <write_hex+0xbc>
 618:	008a97b3          	sll	a5,s5,s0
 61c:	0167f7b3          	and	a5,a5,s6
 620:	0087d7b3          	srl	a5,a5,s0
 624:	0ff7f793          	andi	a5,a5,255
 628:	03078693          	addi	a3,a5,48
 62c:	03778713          	addi	a4,a5,55
 630:	fcfa78e3          	bleu	a5,s4,600 <write_hex+0x68>
 634:	0ff77793          	andi	a5,a4,255
 638:	00f107a3          	sb	a5,15(sp)
 63c:	fc99e8e3          	bltu	s3,s1,60c <write_hex+0x74>
 640:	00100593          	li	a1,1
 644:	00f10513          	addi	a0,sp,15
 648:	ffc40413          	addi	s0,s0,-4
 64c:	eb1ff0ef          	jal	ra,4fc <write.part.0>
 650:	fd2414e3          	bne	s0,s2,618 <write_hex+0x80>
 654:	03c12083          	lw	ra,60(sp)
 658:	03812403          	lw	s0,56(sp)
 65c:	03412483          	lw	s1,52(sp)
 660:	03012903          	lw	s2,48(sp)
 664:	02c12983          	lw	s3,44(sp)
 668:	02812a03          	lw	s4,40(sp)
 66c:	02412a83          	lw	s5,36(sp)
 670:	02012b03          	lw	s6,32(sp)
 674:	01c12b83          	lw	s7,28(sp)
 678:	01812c03          	lw	s8,24(sp)
 67c:	04010113          	addi	sp,sp,64
 680:	00008067          	ret
 684:	00001537          	lui	a0,0x1
 688:	00200593          	li	a1,2
 68c:	cec50513          	addi	a0,a0,-788 # cec <main+0x14c>
 690:	e6dff0ef          	jal	ra,4fc <write.part.0>
 694:	f4dff06f          	j	5e0 <write_hex+0x48>

00000698 <_exit>:
 698:	ff010113          	addi	sp,sp,-16
 69c:	00812423          	sw	s0,8(sp)
 6a0:	00050413          	mv	s0,a0
 6a4:	00001537          	lui	a0,0x1
 6a8:	01b00593          	li	a1,27
 6ac:	cf050513          	addi	a0,a0,-784 # cf0 <main+0x150>
 6b0:	00112623          	sw	ra,12(sp)
 6b4:	e49ff0ef          	jal	ra,4fc <write.part.0>
 6b8:	00040593          	mv	a1,s0
 6bc:	00200513          	li	a0,2
 6c0:	ed9ff0ef          	jal	ra,598 <write_hex>
 6c4:	0000006f          	j	6c4 <_exit+0x2c>

000006c8 <brk>:
 6c8:	00002537          	lui	a0,0x2
 6cc:	3c050513          	addi	a0,a0,960 # 23c0 <_end>
 6d0:	00008067          	ret

000006d4 <close>:
 6d4:	000017b7          	lui	a5,0x1
 6d8:	00900713          	li	a4,9
 6dc:	42e7aa23          	sw	a4,1076(a5) # 1434 <errno>
 6e0:	fff00513          	li	a0,-1
 6e4:	00008067          	ret

000006e8 <fstat>:
 6e8:	00200793          	li	a5,2
 6ec:	00a7ea63          	bltu	a5,a0,700 <fstat+0x18>
 6f0:	000027b7          	lui	a5,0x2
 6f4:	00f5a223          	sw	a5,4(a1) # 80000004 <_end+0x7fffdc44>
 6f8:	00000513          	li	a0,0
 6fc:	00008067          	ret
 700:	000017b7          	lui	a5,0x1
 704:	00900713          	li	a4,9
 708:	42e7aa23          	sw	a4,1076(a5) # 1434 <errno>
 70c:	fff00513          	li	a0,-1
 710:	00008067          	ret

00000714 <isatty>:
 714:	00200793          	li	a5,2
 718:	00a7fc63          	bleu	a0,a5,730 <isatty+0x1c>
 71c:	000017b7          	lui	a5,0x1
 720:	00900713          	li	a4,9
 724:	42e7aa23          	sw	a4,1076(a5) # 1434 <errno>
 728:	00000513          	li	a0,0
 72c:	00008067          	ret
 730:	00100513          	li	a0,1
 734:	00008067          	ret

00000738 <lseek>:
 738:	00200793          	li	a5,2
 73c:	00a7e663          	bltu	a5,a0,748 <lseek+0x10>
 740:	00000513          	li	a0,0
 744:	00008067          	ret
 748:	000017b7          	lui	a5,0x1
 74c:	00900713          	li	a4,9
 750:	42e7aa23          	sw	a4,1076(a5) # 1434 <errno>
 754:	fff00513          	li	a0,-1
 758:	00008067          	ret

0000075c <read>:
 75c:	00200793          	li	a5,2
 760:	00a7e863          	bltu	a5,a0,770 <read+0x14>
 764:	00001537          	lui	a0,0x1
 768:	43050513          	addi	a0,a0,1072 # 1430 <g_ConsoleUART>
 76c:	1a80006f          	j	914 <uartRead>
 770:	000017b7          	lui	a5,0x1
 774:	00900713          	li	a4,9
 778:	42e7aa23          	sw	a4,1076(a5) # 1434 <errno>
 77c:	fff00513          	li	a0,-1
 780:	00008067          	ret

00000784 <write>:
 784:	00200713          	li	a4,2
 788:	00058793          	mv	a5,a1
 78c:	00060593          	mv	a1,a2
 790:	00a76663          	bltu	a4,a0,79c <write+0x18>
 794:	00078513          	mv	a0,a5
 798:	d65ff06f          	j	4fc <write.part.0>
 79c:	000017b7          	lui	a5,0x1
 7a0:	00900713          	li	a4,9
 7a4:	42e7aa23          	sw	a4,1076(a5) # 1434 <errno>
 7a8:	fff00513          	li	a0,-1
 7ac:	00008067          	ret

000007b0 <syscallHandler>:
 7b0:	00050793          	mv	a5,a0
 7b4:	04000693          	li	a3,64
 7b8:	00058713          	mv	a4,a1
 7bc:	0005a503          	lw	a0,0(a1)
 7c0:	0ad78c63          	beq	a5,a3,878 <syscallHandler+0xc8>
 7c4:	ff010113          	addi	sp,sp,-16
 7c8:	00112623          	sw	ra,12(sp)
 7cc:	02f6ea63          	bltu	a3,a5,800 <syscallHandler+0x50>
 7d0:	03e00693          	li	a3,62
 7d4:	08d78a63          	beq	a5,a3,868 <syscallHandler+0xb8>
 7d8:	06f6e863          	bltu	a3,a5,848 <syscallHandler+0x98>
 7dc:	03900713          	li	a4,57
 7e0:	00e79a63          	bne	a5,a4,7f4 <syscallHandler+0x44>
 7e4:	000017b7          	lui	a5,0x1
 7e8:	00900713          	li	a4,9
 7ec:	42e7aa23          	sw	a4,1076(a5) # 1434 <errno>
 7f0:	fff00513          	li	a0,-1
 7f4:	00c12083          	lw	ra,12(sp)
 7f8:	01010113          	addi	sp,sp,16
 7fc:	00008067          	ret
 800:	05d00693          	li	a3,93
 804:	08d78e63          	beq	a5,a3,8a0 <syscallHandler+0xf0>
 808:	0d600693          	li	a3,214
 80c:	02d78463          	beq	a5,a3,834 <syscallHandler+0x84>
 810:	05000693          	li	a3,80
 814:	fed790e3          	bne	a5,a3,7f4 <syscallHandler+0x44>
 818:	00200793          	li	a5,2
 81c:	fca7e4e3          	bltu	a5,a0,7e4 <syscallHandler+0x34>
 820:	0045a783          	lw	a5,4(a1)
 824:	00002737          	lui	a4,0x2
 828:	00000513          	li	a0,0
 82c:	00e7a223          	sw	a4,4(a5)
 830:	fc5ff06f          	j	7f4 <syscallHandler+0x44>
 834:	00c12083          	lw	ra,12(sp)
 838:	00002537          	lui	a0,0x2
 83c:	3c050513          	addi	a0,a0,960 # 23c0 <_end>
 840:	01010113          	addi	sp,sp,16
 844:	00008067          	ret
 848:	00200793          	li	a5,2
 84c:	f8a7ece3          	bltu	a5,a0,7e4 <syscallHandler+0x34>
 850:	0085a603          	lw	a2,8(a1)
 854:	0045a583          	lw	a1,4(a1)
 858:	00001537          	lui	a0,0x1
 85c:	43050513          	addi	a0,a0,1072 # 1430 <g_ConsoleUART>
 860:	0b4000ef          	jal	ra,914 <uartRead>
 864:	f91ff06f          	j	7f4 <syscallHandler+0x44>
 868:	00200793          	li	a5,2
 86c:	f6a7ece3          	bltu	a5,a0,7e4 <syscallHandler+0x34>
 870:	00000513          	li	a0,0
 874:	f81ff06f          	j	7f4 <syscallHandler+0x44>
 878:	00200793          	li	a5,2
 87c:	00a7fc63          	bleu	a0,a5,894 <syscallHandler+0xe4>
 880:	000017b7          	lui	a5,0x1
 884:	00900713          	li	a4,9
 888:	42e7aa23          	sw	a4,1076(a5) # 1434 <errno>
 88c:	fff00513          	li	a0,-1
 890:	00008067          	ret
 894:	0085a583          	lw	a1,8(a1)
 898:	00472503          	lw	a0,4(a4) # 2004 <_gp+0x3dc>
 89c:	c61ff06f          	j	4fc <write.part.0>
 8a0:	df9ff0ef          	jal	ra,698 <_exit>

000008a4 <uartInit>:
 8a4:	00b52023          	sw	a1,0(a0)
 8a8:	0085c783          	lbu	a5,8(a1)
 8ac:	0027f793          	andi	a5,a5,2
 8b0:	02078863          	beqz	a5,8e0 <uartInit+0x3c>
 8b4:	00858713          	addi	a4,a1,8
 8b8:	ff010113          	addi	sp,sp,-16
 8bc:	00458593          	addi	a1,a1,4
 8c0:	0005c783          	lbu	a5,0(a1)
 8c4:	0ff7f793          	andi	a5,a5,255
 8c8:	00f107a3          	sb	a5,15(sp)
 8cc:	00074783          	lbu	a5,0(a4)
 8d0:	0027f793          	andi	a5,a5,2
 8d4:	fe0796e3          	bnez	a5,8c0 <uartInit+0x1c>
 8d8:	01010113          	addi	sp,sp,16
 8dc:	00008067          	ret
 8e0:	00008067          	ret

000008e4 <uartSend>:
 8e4:	02060663          	beqz	a2,910 <uartSend+0x2c>
 8e8:	00c58633          	add	a2,a1,a2
 8ec:	00052683          	lw	a3,0(a0)
 8f0:	00868713          	addi	a4,a3,8
 8f4:	00074783          	lbu	a5,0(a4)
 8f8:	0017f793          	andi	a5,a5,1
 8fc:	fe078ce3          	beqz	a5,8f4 <uartSend+0x10>
 900:	0005c783          	lbu	a5,0(a1)
 904:	00158593          	addi	a1,a1,1
 908:	00f68023          	sb	a5,0(a3)
 90c:	feb610e3          	bne	a2,a1,8ec <uartSend+0x8>
 910:	00008067          	ret

00000914 <uartRead>:
 914:	00000713          	li	a4,0
 918:	00060c63          	beqz	a2,930 <uartRead+0x1c>
 91c:	00052683          	lw	a3,0(a0)
 920:	00000713          	li	a4,0
 924:	0086c783          	lbu	a5,8(a3)
 928:	0027f793          	andi	a5,a5,2
 92c:	00079863          	bnez	a5,93c <uartRead+0x28>
 930:	00070513          	mv	a0,a4
 934:	00008067          	ret
 938:	fee60ce3          	beq	a2,a4,930 <uartRead+0x1c>
 93c:	0046c783          	lbu	a5,4(a3)
 940:	00158593          	addi	a1,a1,1
 944:	00170713          	addi	a4,a4,1
 948:	fef58fa3          	sb	a5,-1(a1)
 94c:	00052683          	lw	a3,0(a0)
 950:	0086c783          	lbu	a5,8(a3)
 954:	0027f793          	andi	a5,a5,2
 958:	fe0790e3          	bnez	a5,938 <uartRead+0x24>
 95c:	00070513          	mv	a0,a4
 960:	00008067          	ret

00000964 <exit>:
 964:	ff010113          	addi	sp,sp,-16
 968:	00000593          	li	a1,0
 96c:	00812423          	sw	s0,8(sp)
 970:	00112623          	sw	ra,12(sp)
 974:	00050413          	mv	s0,a0
 978:	118000ef          	jal	ra,a90 <__call_exitprocs>
 97c:	000017b7          	lui	a5,0x1
 980:	4287a503          	lw	a0,1064(a5) # 1428 <_global_impure_ptr>
 984:	03c52783          	lw	a5,60(a0)
 988:	00078463          	beqz	a5,990 <exit+0x2c>
 98c:	000780e7          	jalr	a5
 990:	00040513          	mv	a0,s0
 994:	d05ff0ef          	jal	ra,698 <_exit>

00000998 <memset>:
 998:	00f00813          	li	a6,15
 99c:	00050713          	mv	a4,a0
 9a0:	02c87e63          	bleu	a2,a6,9dc <memset+0x44>
 9a4:	00f77793          	andi	a5,a4,15
 9a8:	0a079063          	bnez	a5,a48 <memset+0xb0>
 9ac:	08059263          	bnez	a1,a30 <memset+0x98>
 9b0:	ff067693          	andi	a3,a2,-16
 9b4:	00f67613          	andi	a2,a2,15
 9b8:	00e686b3          	add	a3,a3,a4
 9bc:	00b72023          	sw	a1,0(a4)
 9c0:	00b72223          	sw	a1,4(a4)
 9c4:	00b72423          	sw	a1,8(a4)
 9c8:	00b72623          	sw	a1,12(a4)
 9cc:	01070713          	addi	a4,a4,16
 9d0:	fed766e3          	bltu	a4,a3,9bc <memset+0x24>
 9d4:	00061463          	bnez	a2,9dc <memset+0x44>
 9d8:	00008067          	ret
 9dc:	40c806b3          	sub	a3,a6,a2
 9e0:	00269693          	slli	a3,a3,0x2
 9e4:	00000297          	auipc	t0,0x0
 9e8:	005686b3          	add	a3,a3,t0
 9ec:	00c68067          	jr	12(a3)
 9f0:	00b70723          	sb	a1,14(a4)
 9f4:	00b706a3          	sb	a1,13(a4)
 9f8:	00b70623          	sb	a1,12(a4)
 9fc:	00b705a3          	sb	a1,11(a4)
 a00:	00b70523          	sb	a1,10(a4)
 a04:	00b704a3          	sb	a1,9(a4)
 a08:	00b70423          	sb	a1,8(a4)
 a0c:	00b703a3          	sb	a1,7(a4)
 a10:	00b70323          	sb	a1,6(a4)
 a14:	00b702a3          	sb	a1,5(a4)
 a18:	00b70223          	sb	a1,4(a4)
 a1c:	00b701a3          	sb	a1,3(a4)
 a20:	00b70123          	sb	a1,2(a4)
 a24:	00b700a3          	sb	a1,1(a4)
 a28:	00b70023          	sb	a1,0(a4)
 a2c:	00008067          	ret
 a30:	0ff5f593          	andi	a1,a1,255
 a34:	00859693          	slli	a3,a1,0x8
 a38:	00d5e5b3          	or	a1,a1,a3
 a3c:	01059693          	slli	a3,a1,0x10
 a40:	00d5e5b3          	or	a1,a1,a3
 a44:	f6dff06f          	j	9b0 <memset+0x18>
 a48:	00279693          	slli	a3,a5,0x2
 a4c:	00000297          	auipc	t0,0x0
 a50:	005686b3          	add	a3,a3,t0
 a54:	00008293          	mv	t0,ra
 a58:	fa0680e7          	jalr	-96(a3)
 a5c:	00028093          	mv	ra,t0
 a60:	ff078793          	addi	a5,a5,-16
 a64:	40f70733          	sub	a4,a4,a5
 a68:	00f60633          	add	a2,a2,a5
 a6c:	f6c878e3          	bleu	a2,a6,9dc <memset+0x44>
 a70:	f3dff06f          	j	9ac <memset+0x14>

00000a74 <strlen>:
 a74:	00050793          	mv	a5,a0
 a78:	00178793          	addi	a5,a5,1
 a7c:	fff7c703          	lbu	a4,-1(a5)
 a80:	fe071ce3          	bnez	a4,a78 <strlen+0x4>
 a84:	40a78533          	sub	a0,a5,a0
 a88:	fff50513          	addi	a0,a0,-1
 a8c:	00008067          	ret

00000a90 <__call_exitprocs>:
 a90:	fd010113          	addi	sp,sp,-48
 a94:	000017b7          	lui	a5,0x1
 a98:	01312e23          	sw	s3,28(sp)
 a9c:	4287a983          	lw	s3,1064(a5) # 1428 <_global_impure_ptr>
 aa0:	01412c23          	sw	s4,24(sp)
 aa4:	01512a23          	sw	s5,20(sp)
 aa8:	01612823          	sw	s6,16(sp)
 aac:	02112623          	sw	ra,44(sp)
 ab0:	02812423          	sw	s0,40(sp)
 ab4:	02912223          	sw	s1,36(sp)
 ab8:	03212023          	sw	s2,32(sp)
 abc:	01712623          	sw	s7,12(sp)
 ac0:	00050a93          	mv	s5,a0
 ac4:	00058a13          	mv	s4,a1
 ac8:	00100b13          	li	s6,1
 acc:	1489a483          	lw	s1,328(s3)
 ad0:	00048c63          	beqz	s1,ae8 <__call_exitprocs+0x58>
 ad4:	0044a403          	lw	s0,4(s1)
 ad8:	fff40913          	addi	s2,s0,-1
 adc:	00241413          	slli	s0,s0,0x2
 ae0:	00848433          	add	s0,s1,s0
 ae4:	02095863          	bgez	s2,b14 <__call_exitprocs+0x84>
 ae8:	02c12083          	lw	ra,44(sp)
 aec:	02812403          	lw	s0,40(sp)
 af0:	02412483          	lw	s1,36(sp)
 af4:	02012903          	lw	s2,32(sp)
 af8:	01c12983          	lw	s3,28(sp)
 afc:	01812a03          	lw	s4,24(sp)
 b00:	01412a83          	lw	s5,20(sp)
 b04:	01012b03          	lw	s6,16(sp)
 b08:	00c12b83          	lw	s7,12(sp)
 b0c:	03010113          	addi	sp,sp,48
 b10:	00008067          	ret
 b14:	000a0c63          	beqz	s4,b2c <__call_exitprocs+0x9c>
 b18:	10442783          	lw	a5,260(s0)
 b1c:	01478863          	beq	a5,s4,b2c <__call_exitprocs+0x9c>
 b20:	fff90913          	addi	s2,s2,-1
 b24:	ffc40413          	addi	s0,s0,-4
 b28:	fbdff06f          	j	ae4 <__call_exitprocs+0x54>
 b2c:	0044a703          	lw	a4,4(s1)
 b30:	00442783          	lw	a5,4(s0)
 b34:	fff70713          	addi	a4,a4,-1
 b38:	03271c63          	bne	a4,s2,b70 <__call_exitprocs+0xe0>
 b3c:	0124a223          	sw	s2,4(s1)
 b40:	fe0780e3          	beqz	a5,b20 <__call_exitprocs+0x90>
 b44:	1884a683          	lw	a3,392(s1)
 b48:	012b1733          	sll	a4,s6,s2
 b4c:	0044ab83          	lw	s7,4(s1)
 b50:	00d776b3          	and	a3,a4,a3
 b54:	02069263          	bnez	a3,b78 <__call_exitprocs+0xe8>
 b58:	000780e7          	jalr	a5
 b5c:	0044a703          	lw	a4,4(s1)
 b60:	1489a783          	lw	a5,328(s3)
 b64:	f77714e3          	bne	a4,s7,acc <__call_exitprocs+0x3c>
 b68:	faf48ce3          	beq	s1,a5,b20 <__call_exitprocs+0x90>
 b6c:	f61ff06f          	j	acc <__call_exitprocs+0x3c>
 b70:	00042223          	sw	zero,4(s0)
 b74:	fcdff06f          	j	b40 <__call_exitprocs+0xb0>
 b78:	18c4a683          	lw	a3,396(s1)
 b7c:	08442583          	lw	a1,132(s0)
 b80:	00d77733          	and	a4,a4,a3
 b84:	00071863          	bnez	a4,b94 <__call_exitprocs+0x104>
 b88:	000a8513          	mv	a0,s5
 b8c:	000780e7          	jalr	a5
 b90:	fcdff06f          	j	b5c <__call_exitprocs+0xcc>
 b94:	00058513          	mv	a0,a1
 b98:	000780e7          	jalr	a5
 b9c:	fc1ff06f          	j	b5c <__call_exitprocs+0xcc>
