
bios:     file format elf32-littleriscv


Disassembly of section .text:

00000200 <_start>:
 200:	0080006f          	j	208 <reset>

00000204 <trap_vector>:
 204:	0380006f          	j	23c <trap>

00000208 <reset>:
 208:	00000297          	auipc	t0,0x0
 20c:	03428293          	addi	t0,t0,52 # 23c <trap>
 210:	30529073          	csrw	mtvec,t0
 214:	30005073          	csrwi	mstatus,0
 218:	30305073          	csrwi	mideleg,0
 21c:	30205073          	csrwi	medeleg,0
 220:	30405073          	csrwi	mie,0
 224:	00002197          	auipc	gp,0x2
 228:	a0418193          	addi	gp,gp,-1532 # 1c28 <_gp>
 22c:	00002117          	auipc	sp,0x2
 230:	19410113          	addi	sp,sp,404 # 23c0 <_end>
 234:	34011073          	csrw	mscratch,sp
 238:	3dc0006f          	j	614 <_init>

0000023c <trap>:
 23c:	34011173          	csrrw	sp,mscratch,sp
 240:	f8010113          	addi	sp,sp,-128
 244:	00112223          	sw	ra,4(sp)
 248:	00212423          	sw	sp,8(sp)
 24c:	00312623          	sw	gp,12(sp)
 250:	00412823          	sw	tp,16(sp)
 254:	00512a23          	sw	t0,20(sp)
 258:	00612c23          	sw	t1,24(sp)
 25c:	00712e23          	sw	t2,28(sp)
 260:	02812023          	sw	s0,32(sp)
 264:	02912223          	sw	s1,36(sp)
 268:	02a12423          	sw	a0,40(sp)
 26c:	02b12623          	sw	a1,44(sp)
 270:	02c12823          	sw	a2,48(sp)
 274:	02d12a23          	sw	a3,52(sp)
 278:	02e12c23          	sw	a4,56(sp)
 27c:	02f12e23          	sw	a5,60(sp)
 280:	05012023          	sw	a6,64(sp)
 284:	05112223          	sw	a7,68(sp)
 288:	05212423          	sw	s2,72(sp)
 28c:	05312623          	sw	s3,76(sp)
 290:	05412823          	sw	s4,80(sp)
 294:	05512a23          	sw	s5,84(sp)
 298:	05612c23          	sw	s6,88(sp)
 29c:	05712e23          	sw	s7,92(sp)
 2a0:	07812023          	sw	s8,96(sp)
 2a4:	07912223          	sw	s9,100(sp)
 2a8:	07a12423          	sw	s10,104(sp)
 2ac:	07b12623          	sw	s11,108(sp)
 2b0:	07c12823          	sw	t3,112(sp)
 2b4:	07d12a23          	sw	t4,116(sp)
 2b8:	07e12c23          	sw	t5,120(sp)
 2bc:	07f12e23          	sw	t6,124(sp)
 2c0:	34202573          	csrr	a0,mcause
 2c4:	341025f3          	csrr	a1,mepc
 2c8:	00010613          	mv	a2,sp
 2cc:	1a4000ef          	jal	ra,470 <handle_trap>
 2d0:	34151073          	csrw	mepc,a0
 2d4:	00412083          	lw	ra,4(sp)
 2d8:	00812103          	lw	sp,8(sp)
 2dc:	00c12183          	lw	gp,12(sp)
 2e0:	01012203          	lw	tp,16(sp)
 2e4:	01412283          	lw	t0,20(sp)
 2e8:	01812303          	lw	t1,24(sp)
 2ec:	01c12383          	lw	t2,28(sp)
 2f0:	02012403          	lw	s0,32(sp)
 2f4:	02412483          	lw	s1,36(sp)
 2f8:	02812503          	lw	a0,40(sp)
 2fc:	02c12583          	lw	a1,44(sp)
 300:	03012603          	lw	a2,48(sp)
 304:	03412683          	lw	a3,52(sp)
 308:	03812703          	lw	a4,56(sp)
 30c:	03c12783          	lw	a5,60(sp)
 310:	04012803          	lw	a6,64(sp)
 314:	04412883          	lw	a7,68(sp)
 318:	04812903          	lw	s2,72(sp)
 31c:	04c12983          	lw	s3,76(sp)
 320:	05012a03          	lw	s4,80(sp)
 324:	05412a83          	lw	s5,84(sp)
 328:	05812b03          	lw	s6,88(sp)
 32c:	05c12b83          	lw	s7,92(sp)
 330:	06012c03          	lw	s8,96(sp)
 334:	06412c83          	lw	s9,100(sp)
 338:	06812d03          	lw	s10,104(sp)
 33c:	06c12d83          	lw	s11,108(sp)
 340:	07012e03          	lw	t3,112(sp)
 344:	07412e83          	lw	t4,116(sp)
 348:	07812f03          	lw	t5,120(sp)
 34c:	07c12f83          	lw	t6,124(sp)
 350:	08010113          	addi	sp,sp,128
 354:	34011173          	csrrw	sp,mscratch,sp
 358:	30200073          	mret

0000035c <readLine>:
 35c:	fd010113          	addi	sp,sp,-48
 360:	01312e23          	sw	s3,28(sp)
 364:	01412c23          	sw	s4,24(sp)
 368:	00058993          	mv	s3,a1
 36c:	00050a13          	mv	s4,a0
 370:	00100613          	li	a2,1
 374:	00f10593          	addi	a1,sp,15
 378:	00000513          	li	a0,0
 37c:	02812423          	sw	s0,40(sp)
 380:	03212023          	sw	s2,32(sp)
 384:	02112623          	sw	ra,44(sp)
 388:	02912223          	sw	s1,36(sp)
 38c:	000a0413          	mv	s0,s4
 390:	53c000ef          	jal	ra,8cc <read>
 394:	00a00913          	li	s2,10
 398:	fff98993          	addi	s3,s3,-1
 39c:	00050863          	beqz	a0,3ac <readLine+0x50>
 3a0:	00f14783          	lbu	a5,15(sp)
 3a4:	05278063          	beq	a5,s2,3e4 <readLine+0x88>
 3a8:	00079c63          	bnez	a5,3c0 <readLine+0x64>
 3ac:	00100613          	li	a2,1
 3b0:	00f10593          	addi	a1,sp,15
 3b4:	00000513          	li	a0,0
 3b8:	514000ef          	jal	ra,8cc <read>
 3bc:	fe1ff06f          	j	39c <readLine+0x40>
 3c0:	00f40023          	sb	a5,0(s0)
 3c4:	00100613          	li	a2,1
 3c8:	00f10593          	addi	a1,sp,15
 3cc:	00100513          	li	a0,1
 3d0:	00140493          	addi	s1,s0,1
 3d4:	520000ef          	jal	ra,8f4 <write>
 3d8:	414487b3          	sub	a5,s1,s4
 3dc:	00048413          	mv	s0,s1
 3e0:	fd3796e3          	bne	a5,s3,3ac <readLine+0x50>
 3e4:	00040023          	sb	zero,0(s0)
 3e8:	02c12083          	lw	ra,44(sp)
 3ec:	02812403          	lw	s0,40(sp)
 3f0:	02412483          	lw	s1,36(sp)
 3f4:	02012903          	lw	s2,32(sp)
 3f8:	01c12983          	lw	s3,28(sp)
 3fc:	01812a03          	lw	s4,24(sp)
 400:	03010113          	addi	sp,sp,48
 404:	00008067          	ret

00000408 <unhandled_trap>:
 408:	ff010113          	addi	sp,sp,-16
 40c:	000015b7          	lui	a1,0x1
 410:	00812423          	sw	s0,8(sp)
 414:	e2058593          	addi	a1,a1,-480 # e20 <main+0x110>
 418:	00050413          	mv	s0,a0
 41c:	01100613          	li	a2,17
 420:	00200513          	li	a0,2
 424:	00112623          	sw	ra,12(sp)
 428:	4cc000ef          	jal	ra,8f4 <write>
 42c:	00040593          	mv	a1,s0
 430:	00200513          	li	a0,2
 434:	2d4000ef          	jal	ra,708 <write_hex>
 438:	0000006f          	j	438 <unhandled_trap+0x30>

0000043c <illegalInstrTrap>:
 43c:	ff010113          	addi	sp,sp,-16
 440:	000015b7          	lui	a1,0x1
 444:	00812423          	sw	s0,8(sp)
 448:	e3458593          	addi	a1,a1,-460 # e34 <main+0x124>
 44c:	00050413          	mv	s0,a0
 450:	02000613          	li	a2,32
 454:	00200513          	li	a0,2
 458:	00112623          	sw	ra,12(sp)
 45c:	498000ef          	jal	ra,8f4 <write>
 460:	00040593          	mv	a1,s0
 464:	00200513          	li	a0,2
 468:	2a0000ef          	jal	ra,708 <write_hex>
 46c:	0000006f          	j	46c <illegalInstrTrap+0x30>

00000470 <handle_trap>:
 470:	fe010113          	addi	sp,sp,-32
 474:	00812c23          	sw	s0,24(sp)
 478:	00112e23          	sw	ra,28(sp)
 47c:	00500713          	li	a4,5
 480:	00050793          	mv	a5,a0
 484:	00058413          	mv	s0,a1
 488:	06e50c63          	beq	a0,a4,500 <handle_trap+0x90>
 48c:	02a77263          	bleu	a0,a4,4b0 <handle_trap+0x40>
 490:	00800713          	li	a4,8
 494:	04e50063          	beq	a0,a4,4d4 <handle_trap+0x64>
 498:	00b00713          	li	a4,11
 49c:	02e50c63          	beq	a0,a4,4d4 <handle_trap+0x64>
 4a0:	00700713          	li	a4,7
 4a4:	04e50e63          	beq	a0,a4,500 <handle_trap+0x90>
 4a8:	00078513          	mv	a0,a5
 4ac:	f5dff0ef          	jal	ra,408 <unhandled_trap>
 4b0:	00200713          	li	a4,2
 4b4:	06e50663          	beq	a0,a4,520 <handle_trap+0xb0>
 4b8:	00300713          	li	a4,3
 4bc:	00458513          	addi	a0,a1,4
 4c0:	fee794e3          	bne	a5,a4,4a8 <handle_trap+0x38>
 4c4:	01c12083          	lw	ra,28(sp)
 4c8:	01812403          	lw	s0,24(sp)
 4cc:	02010113          	addi	sp,sp,32
 4d0:	00008067          	ret
 4d4:	04462503          	lw	a0,68(a2)
 4d8:	02860593          	addi	a1,a2,40
 4dc:	00c12623          	sw	a2,12(sp)
 4e0:	440000ef          	jal	ra,920 <syscallHandler>
 4e4:	00c12603          	lw	a2,12(sp)
 4e8:	01c12083          	lw	ra,28(sp)
 4ec:	02a62423          	sw	a0,40(a2)
 4f0:	00440513          	addi	a0,s0,4
 4f4:	01812403          	lw	s0,24(sp)
 4f8:	02010113          	addi	sp,sp,32
 4fc:	00008067          	ret
 500:	00001737          	lui	a4,0x1
 504:	43072703          	lw	a4,1072(a4) # 1430 <g_IsInsideMemTest>
 508:	fa0700e3          	beqz	a4,4a8 <handle_trap+0x38>
 50c:	00440513          	addi	a0,s0,4
 510:	01c12083          	lw	ra,28(sp)
 514:	01812403          	lw	s0,24(sp)
 518:	02010113          	addi	sp,sp,32
 51c:	00008067          	ret
 520:	00058513          	mv	a0,a1
 524:	f19ff0ef          	jal	ra,43c <illegalInstrTrap>

00000528 <memtest>:
 528:	ff010113          	addi	sp,sp,-16
 52c:	00012223          	sw	zero,4(sp)
 530:	00012423          	sw	zero,8(sp)
 534:	00100793          	li	a5,1
 538:	00001337          	lui	t1,0x1
 53c:	00012623          	sw	zero,12(sp)
 540:	42f32823          	sw	a5,1072(t1) # 1430 <g_IsInsideMemTest>
 544:	001017b7          	lui	a5,0x101
 548:	ffc7a703          	lw	a4,-4(a5) # 100ffc <_end+0xfec3c>
 54c:	555556b7          	lui	a3,0x55555
 550:	55568693          	addi	a3,a3,1365 # 55555555 <_end+0x55553195>
 554:	00e12623          	sw	a4,12(sp)
 558:	00c12703          	lw	a4,12(sp)
 55c:	00d74733          	xor	a4,a4,a3
 560:	fee7ae23          	sw	a4,-4(a5)
 564:	00c12703          	lw	a4,12(sp)
 568:	00e12223          	sw	a4,4(sp)
 56c:	ffc7a703          	lw	a4,-4(a5)
 570:	00e12423          	sw	a4,8(sp)
 574:	00c12703          	lw	a4,12(sp)
 578:	fee7ae23          	sw	a4,-4(a5)
 57c:	00c12783          	lw	a5,12(sp)
 580:	00812703          	lw	a4,8(sp)
 584:	00d7c7b3          	xor	a5,a5,a3
 588:	06e79e63          	bne	a5,a4,604 <memtest+0xdc>
 58c:	aaaab837          	lui	a6,0xaaaab
 590:	001025b7          	lui	a1,0x102
 594:	00000613          	li	a2,0
 598:	aaa80813          	addi	a6,a6,-1366 # aaaaaaaa <_end+0xaaaa86ea>
 59c:	000018b7          	lui	a7,0x1
 5a0:	ffc58593          	addi	a1,a1,-4 # 101ffc <_end+0xffc3c>
 5a4:	00c12703          	lw	a4,12(sp)
 5a8:	00b607b3          	add	a5,a2,a1
 5ac:	01160533          	add	a0,a2,a7
 5b0:	01074733          	xor	a4,a4,a6
 5b4:	00e12423          	sw	a4,8(sp)
 5b8:	0007a703          	lw	a4,0(a5)
 5bc:	00050613          	mv	a2,a0
 5c0:	00e12623          	sw	a4,12(sp)
 5c4:	00c12703          	lw	a4,12(sp)
 5c8:	00d74733          	xor	a4,a4,a3
 5cc:	00e7a023          	sw	a4,0(a5)
 5d0:	00c12703          	lw	a4,12(sp)
 5d4:	00e12223          	sw	a4,4(sp)
 5d8:	0007a703          	lw	a4,0(a5)
 5dc:	00e12423          	sw	a4,8(sp)
 5e0:	00c12703          	lw	a4,12(sp)
 5e4:	00e7a023          	sw	a4,0(a5)
 5e8:	00c12783          	lw	a5,12(sp)
 5ec:	00812703          	lw	a4,8(sp)
 5f0:	00d7c7b3          	xor	a5,a5,a3
 5f4:	fae788e3          	beq	a5,a4,5a4 <memtest+0x7c>
 5f8:	42032823          	sw	zero,1072(t1)
 5fc:	01010113          	addi	sp,sp,16
 600:	00008067          	ret
 604:	42032823          	sw	zero,1072(t1)
 608:	00000513          	li	a0,0
 60c:	01010113          	addi	sp,sp,16
 610:	00008067          	ret

00000614 <_init>:
 614:	00001537          	lui	a0,0x1
 618:	ff010113          	addi	sp,sp,-16
 61c:	800005b7          	lui	a1,0x80000
 620:	43450513          	addi	a0,a0,1076 # 1434 <g_ConsoleUART>
 624:	00112623          	sw	ra,12(sp)
 628:	3ec000ef          	jal	ra,a14 <uartInit>
 62c:	000015b7          	lui	a1,0x1
 630:	00900613          	li	a2,9
 634:	e5858593          	addi	a1,a1,-424 # e58 <main+0x148>
 638:	00100513          	li	a0,1
 63c:	2b8000ef          	jal	ra,8f4 <write>
 640:	ee9ff0ef          	jal	ra,528 <memtest>
 644:	00050593          	mv	a1,a0
 648:	00100513          	li	a0,1
 64c:	0bc000ef          	jal	ra,708 <write_hex>
 650:	000015b7          	lui	a1,0x1
 654:	00100613          	li	a2,1
 658:	e6458593          	addi	a1,a1,-412 # e64 <main+0x154>
 65c:	00100513          	li	a0,1
 660:	294000ef          	jal	ra,8f4 <write>
 664:	6ac000ef          	jal	ra,d10 <main>
 668:	46c000ef          	jal	ra,ad4 <exit>

0000066c <write.part.0>:
 66c:	fe010113          	addi	sp,sp,-32
 670:	01412423          	sw	s4,8(sp)
 674:	00112e23          	sw	ra,28(sp)
 678:	00812c23          	sw	s0,24(sp)
 67c:	00912a23          	sw	s1,20(sp)
 680:	01212823          	sw	s2,16(sp)
 684:	01312623          	sw	s3,12(sp)
 688:	01512223          	sw	s5,4(sp)
 68c:	00058a13          	mv	s4,a1
 690:	02058c63          	beqz	a1,6c8 <write.part.0+0x5c>
 694:	00050413          	mv	s0,a0
 698:	00b509b3          	add	s3,a0,a1
 69c:	000014b7          	lui	s1,0x1
 6a0:	00a00913          	li	s2,10
 6a4:	00001ab7          	lui	s5,0x1
 6a8:	00040593          	mv	a1,s0
 6ac:	00100613          	li	a2,1
 6b0:	43448513          	addi	a0,s1,1076 # 1434 <g_ConsoleUART>
 6b4:	3a0000ef          	jal	ra,a54 <uartSend>
 6b8:	00044783          	lbu	a5,0(s0)
 6bc:	00140413          	addi	s0,s0,1
 6c0:	03278863          	beq	a5,s2,6f0 <write.part.0+0x84>
 6c4:	ff3412e3          	bne	s0,s3,6a8 <write.part.0+0x3c>
 6c8:	01c12083          	lw	ra,28(sp)
 6cc:	01812403          	lw	s0,24(sp)
 6d0:	000a0513          	mv	a0,s4
 6d4:	01412483          	lw	s1,20(sp)
 6d8:	01012903          	lw	s2,16(sp)
 6dc:	00c12983          	lw	s3,12(sp)
 6e0:	00812a03          	lw	s4,8(sp)
 6e4:	00412a83          	lw	s5,4(sp)
 6e8:	02010113          	addi	sp,sp,32
 6ec:	00008067          	ret
 6f0:	00100613          	li	a2,1
 6f4:	e68a8593          	addi	a1,s5,-408 # e68 <main+0x158>
 6f8:	43448513          	addi	a0,s1,1076
 6fc:	358000ef          	jal	ra,a54 <uartSend>
 700:	fb3414e3          	bne	s0,s3,6a8 <write.part.0+0x3c>
 704:	fc5ff06f          	j	6c8 <write.part.0+0x5c>

00000708 <write_hex>:
 708:	fc010113          	addi	sp,sp,-64
 70c:	02912a23          	sw	s1,52(sp)
 710:	03612023          	sw	s6,32(sp)
 714:	02112e23          	sw	ra,60(sp)
 718:	02812c23          	sw	s0,56(sp)
 71c:	03212823          	sw	s2,48(sp)
 720:	03312623          	sw	s3,44(sp)
 724:	03412423          	sw	s4,40(sp)
 728:	03512223          	sw	s5,36(sp)
 72c:	01712e23          	sw	s7,28(sp)
 730:	01812c23          	sw	s8,24(sp)
 734:	00200793          	li	a5,2
 738:	00050493          	mv	s1,a0
 73c:	00058b13          	mv	s6,a1
 740:	0aa7fa63          	bleu	a0,a5,7f4 <write_hex+0xec>
 744:	000017b7          	lui	a5,0x1
 748:	00900713          	li	a4,9
 74c:	42e7ac23          	sw	a4,1080(a5) # 1438 <errno>
 750:	01c00413          	li	s0,28
 754:	00f00a93          	li	s5,15
 758:	00900a13          	li	s4,9
 75c:	00200993          	li	s3,2
 760:	00001c37          	lui	s8,0x1
 764:	00900b93          	li	s7,9
 768:	ffc00913          	li	s2,-4
 76c:	01c0006f          	j	788 <write_hex+0x80>
 770:	0ff6f793          	andi	a5,a3,255
 774:	00f107a3          	sb	a5,15(sp)
 778:	0299fc63          	bleu	s1,s3,7b0 <write_hex+0xa8>
 77c:	437c2c23          	sw	s7,1080(s8) # 1438 <errno>
 780:	ffc40413          	addi	s0,s0,-4
 784:	05240063          	beq	s0,s2,7c4 <write_hex+0xbc>
 788:	008a97b3          	sll	a5,s5,s0
 78c:	0167f7b3          	and	a5,a5,s6
 790:	0087d7b3          	srl	a5,a5,s0
 794:	0ff7f793          	andi	a5,a5,255
 798:	03078693          	addi	a3,a5,48
 79c:	03778713          	addi	a4,a5,55
 7a0:	fcfa78e3          	bleu	a5,s4,770 <write_hex+0x68>
 7a4:	0ff77793          	andi	a5,a4,255
 7a8:	00f107a3          	sb	a5,15(sp)
 7ac:	fc99e8e3          	bltu	s3,s1,77c <write_hex+0x74>
 7b0:	00100593          	li	a1,1
 7b4:	00f10513          	addi	a0,sp,15
 7b8:	ffc40413          	addi	s0,s0,-4
 7bc:	eb1ff0ef          	jal	ra,66c <write.part.0>
 7c0:	fd2414e3          	bne	s0,s2,788 <write_hex+0x80>
 7c4:	03c12083          	lw	ra,60(sp)
 7c8:	03812403          	lw	s0,56(sp)
 7cc:	03412483          	lw	s1,52(sp)
 7d0:	03012903          	lw	s2,48(sp)
 7d4:	02c12983          	lw	s3,44(sp)
 7d8:	02812a03          	lw	s4,40(sp)
 7dc:	02412a83          	lw	s5,36(sp)
 7e0:	02012b03          	lw	s6,32(sp)
 7e4:	01c12b83          	lw	s7,28(sp)
 7e8:	01812c03          	lw	s8,24(sp)
 7ec:	04010113          	addi	sp,sp,64
 7f0:	00008067          	ret
 7f4:	00001537          	lui	a0,0x1
 7f8:	00200593          	li	a1,2
 7fc:	e6c50513          	addi	a0,a0,-404 # e6c <main+0x15c>
 800:	e6dff0ef          	jal	ra,66c <write.part.0>
 804:	f4dff06f          	j	750 <write_hex+0x48>

00000808 <_exit>:
 808:	ff010113          	addi	sp,sp,-16
 80c:	00812423          	sw	s0,8(sp)
 810:	00050413          	mv	s0,a0
 814:	00001537          	lui	a0,0x1
 818:	01b00593          	li	a1,27
 81c:	e7050513          	addi	a0,a0,-400 # e70 <main+0x160>
 820:	00112623          	sw	ra,12(sp)
 824:	e49ff0ef          	jal	ra,66c <write.part.0>
 828:	00040593          	mv	a1,s0
 82c:	00200513          	li	a0,2
 830:	ed9ff0ef          	jal	ra,708 <write_hex>
 834:	0000006f          	j	834 <_exit+0x2c>

00000838 <brk>:
 838:	00002537          	lui	a0,0x2
 83c:	3c050513          	addi	a0,a0,960 # 23c0 <_end>
 840:	00008067          	ret

00000844 <close>:
 844:	000017b7          	lui	a5,0x1
 848:	00900713          	li	a4,9
 84c:	42e7ac23          	sw	a4,1080(a5) # 1438 <errno>
 850:	fff00513          	li	a0,-1
 854:	00008067          	ret

00000858 <fstat>:
 858:	00200793          	li	a5,2
 85c:	00a7ea63          	bltu	a5,a0,870 <fstat+0x18>
 860:	000027b7          	lui	a5,0x2
 864:	00f5a223          	sw	a5,4(a1)
 868:	00000513          	li	a0,0
 86c:	00008067          	ret
 870:	000017b7          	lui	a5,0x1
 874:	00900713          	li	a4,9
 878:	42e7ac23          	sw	a4,1080(a5) # 1438 <errno>
 87c:	fff00513          	li	a0,-1
 880:	00008067          	ret

00000884 <isatty>:
 884:	00200793          	li	a5,2
 888:	00a7fc63          	bleu	a0,a5,8a0 <isatty+0x1c>
 88c:	000017b7          	lui	a5,0x1
 890:	00900713          	li	a4,9
 894:	42e7ac23          	sw	a4,1080(a5) # 1438 <errno>
 898:	00000513          	li	a0,0
 89c:	00008067          	ret
 8a0:	00100513          	li	a0,1
 8a4:	00008067          	ret

000008a8 <lseek>:
 8a8:	00200793          	li	a5,2
 8ac:	00a7e663          	bltu	a5,a0,8b8 <lseek+0x10>
 8b0:	00000513          	li	a0,0
 8b4:	00008067          	ret
 8b8:	000017b7          	lui	a5,0x1
 8bc:	00900713          	li	a4,9
 8c0:	42e7ac23          	sw	a4,1080(a5) # 1438 <errno>
 8c4:	fff00513          	li	a0,-1
 8c8:	00008067          	ret

000008cc <read>:
 8cc:	00200793          	li	a5,2
 8d0:	00a7e863          	bltu	a5,a0,8e0 <read+0x14>
 8d4:	00001537          	lui	a0,0x1
 8d8:	43450513          	addi	a0,a0,1076 # 1434 <g_ConsoleUART>
 8dc:	1a80006f          	j	a84 <uartRead>
 8e0:	000017b7          	lui	a5,0x1
 8e4:	00900713          	li	a4,9
 8e8:	42e7ac23          	sw	a4,1080(a5) # 1438 <errno>
 8ec:	fff00513          	li	a0,-1
 8f0:	00008067          	ret

000008f4 <write>:
 8f4:	00200713          	li	a4,2
 8f8:	00058793          	mv	a5,a1
 8fc:	00060593          	mv	a1,a2
 900:	00a76663          	bltu	a4,a0,90c <write+0x18>
 904:	00078513          	mv	a0,a5
 908:	d65ff06f          	j	66c <write.part.0>
 90c:	000017b7          	lui	a5,0x1
 910:	00900713          	li	a4,9
 914:	42e7ac23          	sw	a4,1080(a5) # 1438 <errno>
 918:	fff00513          	li	a0,-1
 91c:	00008067          	ret

00000920 <syscallHandler>:
 920:	00050793          	mv	a5,a0
 924:	04000693          	li	a3,64
 928:	00058713          	mv	a4,a1
 92c:	0005a503          	lw	a0,0(a1)
 930:	0ad78c63          	beq	a5,a3,9e8 <syscallHandler+0xc8>
 934:	ff010113          	addi	sp,sp,-16
 938:	00112623          	sw	ra,12(sp)
 93c:	02f6ea63          	bltu	a3,a5,970 <syscallHandler+0x50>
 940:	03e00693          	li	a3,62
 944:	08d78a63          	beq	a5,a3,9d8 <syscallHandler+0xb8>
 948:	06f6e863          	bltu	a3,a5,9b8 <syscallHandler+0x98>
 94c:	03900713          	li	a4,57
 950:	00e79a63          	bne	a5,a4,964 <syscallHandler+0x44>
 954:	000017b7          	lui	a5,0x1
 958:	00900713          	li	a4,9
 95c:	42e7ac23          	sw	a4,1080(a5) # 1438 <errno>
 960:	fff00513          	li	a0,-1
 964:	00c12083          	lw	ra,12(sp)
 968:	01010113          	addi	sp,sp,16
 96c:	00008067          	ret
 970:	05d00693          	li	a3,93
 974:	08d78e63          	beq	a5,a3,a10 <syscallHandler+0xf0>
 978:	0d600693          	li	a3,214
 97c:	02d78463          	beq	a5,a3,9a4 <syscallHandler+0x84>
 980:	05000693          	li	a3,80
 984:	fed790e3          	bne	a5,a3,964 <syscallHandler+0x44>
 988:	00200793          	li	a5,2
 98c:	fca7e4e3          	bltu	a5,a0,954 <syscallHandler+0x34>
 990:	0045a783          	lw	a5,4(a1)
 994:	00002737          	lui	a4,0x2
 998:	00000513          	li	a0,0
 99c:	00e7a223          	sw	a4,4(a5)
 9a0:	fc5ff06f          	j	964 <syscallHandler+0x44>
 9a4:	00c12083          	lw	ra,12(sp)
 9a8:	00002537          	lui	a0,0x2
 9ac:	3c050513          	addi	a0,a0,960 # 23c0 <_end>
 9b0:	01010113          	addi	sp,sp,16
 9b4:	00008067          	ret
 9b8:	00200793          	li	a5,2
 9bc:	f8a7ece3          	bltu	a5,a0,954 <syscallHandler+0x34>
 9c0:	0085a603          	lw	a2,8(a1)
 9c4:	0045a583          	lw	a1,4(a1)
 9c8:	00001537          	lui	a0,0x1
 9cc:	43450513          	addi	a0,a0,1076 # 1434 <g_ConsoleUART>
 9d0:	0b4000ef          	jal	ra,a84 <uartRead>
 9d4:	f91ff06f          	j	964 <syscallHandler+0x44>
 9d8:	00200793          	li	a5,2
 9dc:	f6a7ece3          	bltu	a5,a0,954 <syscallHandler+0x34>
 9e0:	00000513          	li	a0,0
 9e4:	f81ff06f          	j	964 <syscallHandler+0x44>
 9e8:	00200793          	li	a5,2
 9ec:	00a7fc63          	bleu	a0,a5,a04 <syscallHandler+0xe4>
 9f0:	000017b7          	lui	a5,0x1
 9f4:	00900713          	li	a4,9
 9f8:	42e7ac23          	sw	a4,1080(a5) # 1438 <errno>
 9fc:	fff00513          	li	a0,-1
 a00:	00008067          	ret
 a04:	0085a583          	lw	a1,8(a1)
 a08:	00472503          	lw	a0,4(a4) # 2004 <_gp+0x3dc>
 a0c:	c61ff06f          	j	66c <write.part.0>
 a10:	df9ff0ef          	jal	ra,808 <_exit>

00000a14 <uartInit>:
 a14:	00b52023          	sw	a1,0(a0)
 a18:	0085c783          	lbu	a5,8(a1)
 a1c:	0027f793          	andi	a5,a5,2
 a20:	02078863          	beqz	a5,a50 <uartInit+0x3c>
 a24:	00858713          	addi	a4,a1,8
 a28:	ff010113          	addi	sp,sp,-16
 a2c:	00458593          	addi	a1,a1,4
 a30:	0005c783          	lbu	a5,0(a1)
 a34:	0ff7f793          	andi	a5,a5,255
 a38:	00f107a3          	sb	a5,15(sp)
 a3c:	00074783          	lbu	a5,0(a4)
 a40:	0027f793          	andi	a5,a5,2
 a44:	fe0796e3          	bnez	a5,a30 <uartInit+0x1c>
 a48:	01010113          	addi	sp,sp,16
 a4c:	00008067          	ret
 a50:	00008067          	ret

00000a54 <uartSend>:
 a54:	02060663          	beqz	a2,a80 <uartSend+0x2c>
 a58:	00c58633          	add	a2,a1,a2
 a5c:	00052683          	lw	a3,0(a0)
 a60:	00868713          	addi	a4,a3,8
 a64:	00074783          	lbu	a5,0(a4)
 a68:	0017f793          	andi	a5,a5,1
 a6c:	fe078ce3          	beqz	a5,a64 <uartSend+0x10>
 a70:	0005c783          	lbu	a5,0(a1)
 a74:	00158593          	addi	a1,a1,1
 a78:	00f68023          	sb	a5,0(a3)
 a7c:	feb610e3          	bne	a2,a1,a5c <uartSend+0x8>
 a80:	00008067          	ret

00000a84 <uartRead>:
 a84:	00000713          	li	a4,0
 a88:	00060c63          	beqz	a2,aa0 <uartRead+0x1c>
 a8c:	00052683          	lw	a3,0(a0)
 a90:	00000713          	li	a4,0
 a94:	0086c783          	lbu	a5,8(a3)
 a98:	0027f793          	andi	a5,a5,2
 a9c:	00079863          	bnez	a5,aac <uartRead+0x28>
 aa0:	00070513          	mv	a0,a4
 aa4:	00008067          	ret
 aa8:	fee60ce3          	beq	a2,a4,aa0 <uartRead+0x1c>
 aac:	0046c783          	lbu	a5,4(a3)
 ab0:	00158593          	addi	a1,a1,1
 ab4:	00170713          	addi	a4,a4,1
 ab8:	fef58fa3          	sb	a5,-1(a1)
 abc:	00052683          	lw	a3,0(a0)
 ac0:	0086c783          	lbu	a5,8(a3)
 ac4:	0027f793          	andi	a5,a5,2
 ac8:	fe0790e3          	bnez	a5,aa8 <uartRead+0x24>
 acc:	00070513          	mv	a0,a4
 ad0:	00008067          	ret

00000ad4 <exit>:
 ad4:	ff010113          	addi	sp,sp,-16
 ad8:	00000593          	li	a1,0
 adc:	00812423          	sw	s0,8(sp)
 ae0:	00112623          	sw	ra,12(sp)
 ae4:	00050413          	mv	s0,a0
 ae8:	118000ef          	jal	ra,c00 <__call_exitprocs>
 aec:	000017b7          	lui	a5,0x1
 af0:	4287a503          	lw	a0,1064(a5) # 1428 <_global_impure_ptr>
 af4:	03c52783          	lw	a5,60(a0)
 af8:	00078463          	beqz	a5,b00 <exit+0x2c>
 afc:	000780e7          	jalr	a5
 b00:	00040513          	mv	a0,s0
 b04:	d05ff0ef          	jal	ra,808 <_exit>

00000b08 <memset>:
 b08:	00f00813          	li	a6,15
 b0c:	00050713          	mv	a4,a0
 b10:	02c87e63          	bleu	a2,a6,b4c <memset+0x44>
 b14:	00f77793          	andi	a5,a4,15
 b18:	0a079063          	bnez	a5,bb8 <memset+0xb0>
 b1c:	08059263          	bnez	a1,ba0 <memset+0x98>
 b20:	ff067693          	andi	a3,a2,-16
 b24:	00f67613          	andi	a2,a2,15
 b28:	00e686b3          	add	a3,a3,a4
 b2c:	00b72023          	sw	a1,0(a4)
 b30:	00b72223          	sw	a1,4(a4)
 b34:	00b72423          	sw	a1,8(a4)
 b38:	00b72623          	sw	a1,12(a4)
 b3c:	01070713          	addi	a4,a4,16
 b40:	fed766e3          	bltu	a4,a3,b2c <memset+0x24>
 b44:	00061463          	bnez	a2,b4c <memset+0x44>
 b48:	00008067          	ret
 b4c:	40c806b3          	sub	a3,a6,a2
 b50:	00269693          	slli	a3,a3,0x2
 b54:	00000297          	auipc	t0,0x0
 b58:	005686b3          	add	a3,a3,t0
 b5c:	00c68067          	jr	12(a3)
 b60:	00b70723          	sb	a1,14(a4)
 b64:	00b706a3          	sb	a1,13(a4)
 b68:	00b70623          	sb	a1,12(a4)
 b6c:	00b705a3          	sb	a1,11(a4)
 b70:	00b70523          	sb	a1,10(a4)
 b74:	00b704a3          	sb	a1,9(a4)
 b78:	00b70423          	sb	a1,8(a4)
 b7c:	00b703a3          	sb	a1,7(a4)
 b80:	00b70323          	sb	a1,6(a4)
 b84:	00b702a3          	sb	a1,5(a4)
 b88:	00b70223          	sb	a1,4(a4)
 b8c:	00b701a3          	sb	a1,3(a4)
 b90:	00b70123          	sb	a1,2(a4)
 b94:	00b700a3          	sb	a1,1(a4)
 b98:	00b70023          	sb	a1,0(a4)
 b9c:	00008067          	ret
 ba0:	0ff5f593          	andi	a1,a1,255
 ba4:	00859693          	slli	a3,a1,0x8
 ba8:	00d5e5b3          	or	a1,a1,a3
 bac:	01059693          	slli	a3,a1,0x10
 bb0:	00d5e5b3          	or	a1,a1,a3
 bb4:	f6dff06f          	j	b20 <memset+0x18>
 bb8:	00279693          	slli	a3,a5,0x2
 bbc:	00000297          	auipc	t0,0x0
 bc0:	005686b3          	add	a3,a3,t0
 bc4:	00008293          	mv	t0,ra
 bc8:	fa0680e7          	jalr	-96(a3)
 bcc:	00028093          	mv	ra,t0
 bd0:	ff078793          	addi	a5,a5,-16
 bd4:	40f70733          	sub	a4,a4,a5
 bd8:	00f60633          	add	a2,a2,a5
 bdc:	f6c878e3          	bleu	a2,a6,b4c <memset+0x44>
 be0:	f3dff06f          	j	b1c <memset+0x14>

00000be4 <strlen>:
 be4:	00050793          	mv	a5,a0
 be8:	00178793          	addi	a5,a5,1
 bec:	fff7c703          	lbu	a4,-1(a5)
 bf0:	fe071ce3          	bnez	a4,be8 <strlen+0x4>
 bf4:	40a78533          	sub	a0,a5,a0
 bf8:	fff50513          	addi	a0,a0,-1
 bfc:	00008067          	ret

00000c00 <__call_exitprocs>:
 c00:	fd010113          	addi	sp,sp,-48
 c04:	000017b7          	lui	a5,0x1
 c08:	01312e23          	sw	s3,28(sp)
 c0c:	4287a983          	lw	s3,1064(a5) # 1428 <_global_impure_ptr>
 c10:	01412c23          	sw	s4,24(sp)
 c14:	01512a23          	sw	s5,20(sp)
 c18:	01612823          	sw	s6,16(sp)
 c1c:	02112623          	sw	ra,44(sp)
 c20:	02812423          	sw	s0,40(sp)
 c24:	02912223          	sw	s1,36(sp)
 c28:	03212023          	sw	s2,32(sp)
 c2c:	01712623          	sw	s7,12(sp)
 c30:	00050a93          	mv	s5,a0
 c34:	00058a13          	mv	s4,a1
 c38:	00100b13          	li	s6,1
 c3c:	1489a483          	lw	s1,328(s3)
 c40:	00048c63          	beqz	s1,c58 <__call_exitprocs+0x58>
 c44:	0044a403          	lw	s0,4(s1)
 c48:	fff40913          	addi	s2,s0,-1
 c4c:	00241413          	slli	s0,s0,0x2
 c50:	00848433          	add	s0,s1,s0
 c54:	02095863          	bgez	s2,c84 <__call_exitprocs+0x84>
 c58:	02c12083          	lw	ra,44(sp)
 c5c:	02812403          	lw	s0,40(sp)
 c60:	02412483          	lw	s1,36(sp)
 c64:	02012903          	lw	s2,32(sp)
 c68:	01c12983          	lw	s3,28(sp)
 c6c:	01812a03          	lw	s4,24(sp)
 c70:	01412a83          	lw	s5,20(sp)
 c74:	01012b03          	lw	s6,16(sp)
 c78:	00c12b83          	lw	s7,12(sp)
 c7c:	03010113          	addi	sp,sp,48
 c80:	00008067          	ret
 c84:	000a0c63          	beqz	s4,c9c <__call_exitprocs+0x9c>
 c88:	10442783          	lw	a5,260(s0)
 c8c:	01478863          	beq	a5,s4,c9c <__call_exitprocs+0x9c>
 c90:	fff90913          	addi	s2,s2,-1
 c94:	ffc40413          	addi	s0,s0,-4
 c98:	fbdff06f          	j	c54 <__call_exitprocs+0x54>
 c9c:	0044a703          	lw	a4,4(s1)
 ca0:	00442783          	lw	a5,4(s0)
 ca4:	fff70713          	addi	a4,a4,-1
 ca8:	03271c63          	bne	a4,s2,ce0 <__call_exitprocs+0xe0>
 cac:	0124a223          	sw	s2,4(s1)
 cb0:	fe0780e3          	beqz	a5,c90 <__call_exitprocs+0x90>
 cb4:	1884a683          	lw	a3,392(s1)
 cb8:	012b1733          	sll	a4,s6,s2
 cbc:	0044ab83          	lw	s7,4(s1)
 cc0:	00d776b3          	and	a3,a4,a3
 cc4:	02069263          	bnez	a3,ce8 <__call_exitprocs+0xe8>
 cc8:	000780e7          	jalr	a5
 ccc:	0044a703          	lw	a4,4(s1)
 cd0:	1489a783          	lw	a5,328(s3)
 cd4:	f77714e3          	bne	a4,s7,c3c <__call_exitprocs+0x3c>
 cd8:	faf48ce3          	beq	s1,a5,c90 <__call_exitprocs+0x90>
 cdc:	f61ff06f          	j	c3c <__call_exitprocs+0x3c>
 ce0:	00042223          	sw	zero,4(s0)
 ce4:	fcdff06f          	j	cb0 <__call_exitprocs+0xb0>
 ce8:	18c4a683          	lw	a3,396(s1)
 cec:	08442583          	lw	a1,132(s0)
 cf0:	00d77733          	and	a4,a4,a3
 cf4:	00071863          	bnez	a4,d04 <__call_exitprocs+0x104>
 cf8:	000a8513          	mv	a0,s5
 cfc:	000780e7          	jalr	a5
 d00:	fcdff06f          	j	ccc <__call_exitprocs+0xcc>
 d04:	00058513          	mv	a0,a1
 d08:	000780e7          	jalr	a5
 d0c:	fc1ff06f          	j	ccc <__call_exitprocs+0xcc>
