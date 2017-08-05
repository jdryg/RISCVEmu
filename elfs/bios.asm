
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
 234:	2e00006f          	j	514 <_init>

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
 2c4:	1d8000ef          	jal	ra,49c <handle_trap>
 2c8:	34151073          	csrw	mepc,a0
 2cc:	00012503          	lw	a0,0(sp)
 2d0:	00412083          	lw	ra,4(sp)
 2d4:	00812103          	lw	sp,8(sp)
 2d8:	00c12183          	lw	gp,12(sp)
 2dc:	01012203          	lw	tp,16(sp)
 2e0:	01412283          	lw	t0,20(sp)
 2e4:	01812303          	lw	t1,24(sp)
 2e8:	01c12383          	lw	t2,28(sp)
 2ec:	02012403          	lw	s0,32(sp)
 2f0:	02412483          	lw	s1,36(sp)
 2f4:	02812503          	lw	a0,40(sp)
 2f8:	02c12583          	lw	a1,44(sp)
 2fc:	03012603          	lw	a2,48(sp)
 300:	03412683          	lw	a3,52(sp)
 304:	03812703          	lw	a4,56(sp)
 308:	03c12783          	lw	a5,60(sp)
 30c:	04012803          	lw	a6,64(sp)
 310:	04412883          	lw	a7,68(sp)
 314:	04812903          	lw	s2,72(sp)
 318:	04c12983          	lw	s3,76(sp)
 31c:	05012a03          	lw	s4,80(sp)
 320:	05412a83          	lw	s5,84(sp)
 324:	05812b03          	lw	s6,88(sp)
 328:	05c12b83          	lw	s7,92(sp)
 32c:	06012c03          	lw	s8,96(sp)
 330:	06412c83          	lw	s9,100(sp)
 334:	06812d03          	lw	s10,104(sp)
 338:	06c12d83          	lw	s11,108(sp)
 33c:	07012e03          	lw	t3,112(sp)
 340:	07412e83          	lw	t4,116(sp)
 344:	07812f03          	lw	t5,120(sp)
 348:	07c12f83          	lw	t6,124(sp)
 34c:	08010113          	addi	sp,sp,128
 350:	30200073          	mret

00000354 <main>:
 354:	ee010113          	addi	sp,sp,-288
 358:	10112e23          	sw	ra,284(sp)
 35c:	10812c23          	sw	s0,280(sp)
 360:	10912a23          	sw	s1,276(sp)
 364:	00d00613          	li	a2,13
 368:	000015b7          	lui	a1,0x1
 36c:	b7458593          	addi	a1,a1,-1164 # b74 <__call_exitprocs+0x110>
 370:	00100513          	li	a0,1
 374:	2dc000ef          	jal	ra,650 <write>
 378:	10000613          	li	a2,256
 37c:	00000593          	li	a1,0
 380:	01010513          	addi	a0,sp,16
 384:	5e8000ef          	jal	ra,96c <memset>
 388:	00100613          	li	a2,1
 38c:	00f10593          	addi	a1,sp,15
 390:	00000513          	li	a0,0
 394:	268000ef          	jal	ra,5fc <read>
 398:	01010413          	addi	s0,sp,16
 39c:	0140006f          	j	3b0 <main+0x5c>
 3a0:	00100613          	li	a2,1
 3a4:	00f10593          	addi	a1,sp,15
 3a8:	00000513          	li	a0,0
 3ac:	250000ef          	jal	ra,5fc <read>
 3b0:	00050863          	beqz	a0,3c0 <main+0x6c>
 3b4:	00f14703          	lbu	a4,15(sp)
 3b8:	00a00793          	li	a5,10
 3bc:	02f70863          	beq	a4,a5,3ec <main+0x98>
 3c0:	fe0500e3          	beqz	a0,3a0 <main+0x4c>
 3c4:	00f14783          	lbu	a5,15(sp)
 3c8:	fc078ce3          	beqz	a5,3a0 <main+0x4c>
 3cc:	00140493          	addi	s1,s0,1
 3d0:	00f40023          	sb	a5,0(s0)
 3d4:	00100613          	li	a2,1
 3d8:	00f10593          	addi	a1,sp,15
 3dc:	00100513          	li	a0,1
 3e0:	270000ef          	jal	ra,650 <write>
 3e4:	00048413          	mv	s0,s1
 3e8:	fb9ff06f          	j	3a0 <main+0x4c>
 3ec:	00b00613          	li	a2,11
 3f0:	000015b7          	lui	a1,0x1
 3f4:	b8458593          	addi	a1,a1,-1148 # b84 <__call_exitprocs+0x120>
 3f8:	00100513          	li	a0,1
 3fc:	254000ef          	jal	ra,650 <write>
 400:	01010513          	addi	a0,sp,16
 404:	644000ef          	jal	ra,a48 <strlen>
 408:	00050613          	mv	a2,a0
 40c:	01010593          	addi	a1,sp,16
 410:	00100513          	li	a0,1
 414:	23c000ef          	jal	ra,650 <write>
 418:	12345537          	lui	a0,0x12345
 41c:	67850513          	addi	a0,a0,1656 # 12345678 <_end+0x123432b8>
 420:	11c12083          	lw	ra,284(sp)
 424:	11812403          	lw	s0,280(sp)
 428:	11412483          	lw	s1,276(sp)
 42c:	12010113          	addi	sp,sp,288
 430:	00008067          	ret

00000434 <unhandled_trap>:
 434:	ff010113          	addi	sp,sp,-16
 438:	00112623          	sw	ra,12(sp)
 43c:	00812423          	sw	s0,8(sp)
 440:	00050413          	mv	s0,a0
 444:	01100613          	li	a2,17
 448:	000015b7          	lui	a1,0x1
 44c:	b9058593          	addi	a1,a1,-1136 # b90 <__call_exitprocs+0x12c>
 450:	00200513          	li	a0,2
 454:	1fc000ef          	jal	ra,650 <write>
 458:	00040593          	mv	a1,s0
 45c:	00200513          	li	a0,2
 460:	294000ef          	jal	ra,6f4 <write_hex>
 464:	0000006f          	j	464 <unhandled_trap+0x30>

00000468 <illegalInstrTrap>:
 468:	ff010113          	addi	sp,sp,-16
 46c:	00112623          	sw	ra,12(sp)
 470:	00812423          	sw	s0,8(sp)
 474:	00050413          	mv	s0,a0
 478:	02000613          	li	a2,32
 47c:	000015b7          	lui	a1,0x1
 480:	ba458593          	addi	a1,a1,-1116 # ba4 <__call_exitprocs+0x140>
 484:	00200513          	li	a0,2
 488:	1c8000ef          	jal	ra,650 <write>
 48c:	00040593          	mv	a1,s0
 490:	00200513          	li	a0,2
 494:	260000ef          	jal	ra,6f4 <write_hex>
 498:	0000006f          	j	498 <illegalInstrTrap+0x30>

0000049c <handle_trap>:
 49c:	00300793          	li	a5,3
 4a0:	06f50463          	beq	a0,a5,508 <handle_trap+0x6c>
 4a4:	ff010113          	addi	sp,sp,-16
 4a8:	00112623          	sw	ra,12(sp)
 4ac:	00812423          	sw	s0,8(sp)
 4b0:	00912223          	sw	s1,4(sp)
 4b4:	00060493          	mv	s1,a2
 4b8:	00058413          	mv	s0,a1
 4bc:	02a7fe63          	bleu	a0,a5,4f8 <handle_trap+0x5c>
 4c0:	00800793          	li	a5,8
 4c4:	00f50663          	beq	a0,a5,4d0 <handle_trap+0x34>
 4c8:	00b00793          	li	a5,11
 4cc:	04f51263          	bne	a0,a5,510 <handle_trap+0x74>
 4d0:	02848593          	addi	a1,s1,40
 4d4:	0444a503          	lw	a0,68(s1)
 4d8:	2f0000ef          	jal	ra,7c8 <syscallHandler>
 4dc:	02a4a423          	sw	a0,40(s1)
 4e0:	00440513          	addi	a0,s0,4
 4e4:	00c12083          	lw	ra,12(sp)
 4e8:	00812403          	lw	s0,8(sp)
 4ec:	00412483          	lw	s1,4(sp)
 4f0:	01010113          	addi	sp,sp,16
 4f4:	00008067          	ret
 4f8:	00200793          	li	a5,2
 4fc:	00f51a63          	bne	a0,a5,510 <handle_trap+0x74>
 500:	00058513          	mv	a0,a1
 504:	f65ff0ef          	jal	ra,468 <illegalInstrTrap>
 508:	00458513          	addi	a0,a1,4
 50c:	00008067          	ret
 510:	f25ff0ef          	jal	ra,434 <unhandled_trap>

00000514 <_init>:
 514:	ff010113          	addi	sp,sp,-16
 518:	00112623          	sw	ra,12(sp)
 51c:	800005b7          	lui	a1,0x80000
 520:	00001537          	lui	a0,0x1
 524:	43050513          	addi	a0,a0,1072 # 1430 <g_ConsoleUART>
 528:	340000ef          	jal	ra,868 <uartInit>
 52c:	e29ff0ef          	jal	ra,354 <main>
 530:	408000ef          	jal	ra,938 <exit>

00000534 <stub>:
 534:	000017b7          	lui	a5,0x1
 538:	42a7aa23          	sw	a0,1076(a5) # 1434 <errno>
 53c:	fff00513          	li	a0,-1
 540:	00008067          	ret

00000544 <brk>:
 544:	00002537          	lui	a0,0x2
 548:	3c050513          	addi	a0,a0,960 # 23c0 <_end>
 54c:	00008067          	ret

00000550 <close>:
 550:	ff010113          	addi	sp,sp,-16
 554:	00112623          	sw	ra,12(sp)
 558:	00900513          	li	a0,9
 55c:	fd9ff0ef          	jal	ra,534 <stub>
 560:	00c12083          	lw	ra,12(sp)
 564:	01010113          	addi	sp,sp,16
 568:	00008067          	ret

0000056c <isatty>:
 56c:	00200793          	li	a5,2
 570:	00a7fc63          	bleu	a0,a5,588 <isatty+0x1c>
 574:	000017b7          	lui	a5,0x1
 578:	00900713          	li	a4,9
 57c:	42e7aa23          	sw	a4,1076(a5) # 1434 <errno>
 580:	00000513          	li	a0,0
 584:	00008067          	ret
 588:	00100513          	li	a0,1
 58c:	00008067          	ret

00000590 <fstat>:
 590:	ff010113          	addi	sp,sp,-16
 594:	00112623          	sw	ra,12(sp)
 598:	00812423          	sw	s0,8(sp)
 59c:	00058413          	mv	s0,a1
 5a0:	fcdff0ef          	jal	ra,56c <isatty>
 5a4:	02050063          	beqz	a0,5c4 <fstat+0x34>
 5a8:	000027b7          	lui	a5,0x2
 5ac:	00f42223          	sw	a5,4(s0)
 5b0:	00000513          	li	a0,0
 5b4:	00c12083          	lw	ra,12(sp)
 5b8:	00812403          	lw	s0,8(sp)
 5bc:	01010113          	addi	sp,sp,16
 5c0:	00008067          	ret
 5c4:	00900513          	li	a0,9
 5c8:	f6dff0ef          	jal	ra,534 <stub>
 5cc:	fe9ff06f          	j	5b4 <fstat+0x24>

000005d0 <lseek>:
 5d0:	ff010113          	addi	sp,sp,-16
 5d4:	00112623          	sw	ra,12(sp)
 5d8:	f95ff0ef          	jal	ra,56c <isatty>
 5dc:	00050a63          	beqz	a0,5f0 <lseek+0x20>
 5e0:	00000513          	li	a0,0
 5e4:	00c12083          	lw	ra,12(sp)
 5e8:	01010113          	addi	sp,sp,16
 5ec:	00008067          	ret
 5f0:	00900513          	li	a0,9
 5f4:	f41ff0ef          	jal	ra,534 <stub>
 5f8:	fedff06f          	j	5e4 <lseek+0x14>

000005fc <read>:
 5fc:	ff010113          	addi	sp,sp,-16
 600:	00112623          	sw	ra,12(sp)
 604:	00812423          	sw	s0,8(sp)
 608:	00912223          	sw	s1,4(sp)
 60c:	00058413          	mv	s0,a1
 610:	00060493          	mv	s1,a2
 614:	f59ff0ef          	jal	ra,56c <isatty>
 618:	02051063          	bnez	a0,638 <read+0x3c>
 61c:	00900513          	li	a0,9
 620:	f15ff0ef          	jal	ra,534 <stub>
 624:	00c12083          	lw	ra,12(sp)
 628:	00812403          	lw	s0,8(sp)
 62c:	00412483          	lw	s1,4(sp)
 630:	01010113          	addi	sp,sp,16
 634:	00008067          	ret
 638:	00048613          	mv	a2,s1
 63c:	00040593          	mv	a1,s0
 640:	00001537          	lui	a0,0x1
 644:	43050513          	addi	a0,a0,1072 # 1430 <g_ConsoleUART>
 648:	29c000ef          	jal	ra,8e4 <uartRead>
 64c:	fd9ff06f          	j	624 <read+0x28>

00000650 <write>:
 650:	fe010113          	addi	sp,sp,-32
 654:	00112e23          	sw	ra,28(sp)
 658:	00812c23          	sw	s0,24(sp)
 65c:	00912a23          	sw	s1,20(sp)
 660:	01212823          	sw	s2,16(sp)
 664:	01312623          	sw	s3,12(sp)
 668:	00058993          	mv	s3,a1
 66c:	00060913          	mv	s2,a2
 670:	efdff0ef          	jal	ra,56c <isatty>
 674:	06050a63          	beqz	a0,6e8 <write+0x98>
 678:	00000493          	li	s1,0
 67c:	0080006f          	j	684 <write+0x34>
 680:	00148493          	addi	s1,s1,1
 684:	0524f263          	bleu	s2,s1,6c8 <write+0x78>
 688:	00998433          	add	s0,s3,s1
 68c:	00100613          	li	a2,1
 690:	00040593          	mv	a1,s0
 694:	00001537          	lui	a0,0x1
 698:	43050513          	addi	a0,a0,1072 # 1430 <g_ConsoleUART>
 69c:	210000ef          	jal	ra,8ac <uartSend>
 6a0:	00044703          	lbu	a4,0(s0)
 6a4:	00a00793          	li	a5,10
 6a8:	fcf71ce3          	bne	a4,a5,680 <write+0x30>
 6ac:	00100613          	li	a2,1
 6b0:	000015b7          	lui	a1,0x1
 6b4:	bc858593          	addi	a1,a1,-1080 # bc8 <__call_exitprocs+0x164>
 6b8:	00001537          	lui	a0,0x1
 6bc:	43050513          	addi	a0,a0,1072 # 1430 <g_ConsoleUART>
 6c0:	1ec000ef          	jal	ra,8ac <uartSend>
 6c4:	fbdff06f          	j	680 <write+0x30>
 6c8:	00090513          	mv	a0,s2
 6cc:	01c12083          	lw	ra,28(sp)
 6d0:	01812403          	lw	s0,24(sp)
 6d4:	01412483          	lw	s1,20(sp)
 6d8:	01012903          	lw	s2,16(sp)
 6dc:	00c12983          	lw	s3,12(sp)
 6e0:	02010113          	addi	sp,sp,32
 6e4:	00008067          	ret
 6e8:	00900513          	li	a0,9
 6ec:	e49ff0ef          	jal	ra,534 <stub>
 6f0:	fddff06f          	j	6cc <write+0x7c>

000006f4 <write_hex>:
 6f4:	fe010113          	addi	sp,sp,-32
 6f8:	00112e23          	sw	ra,28(sp)
 6fc:	00812c23          	sw	s0,24(sp)
 700:	00912a23          	sw	s1,20(sp)
 704:	01212823          	sw	s2,16(sp)
 708:	00050913          	mv	s2,a0
 70c:	00058493          	mv	s1,a1
 710:	00200613          	li	a2,2
 714:	000015b7          	lui	a1,0x1
 718:	bcc58593          	addi	a1,a1,-1076 # bcc <__call_exitprocs+0x168>
 71c:	f35ff0ef          	jal	ra,650 <write>
 720:	00800413          	li	s0,8
 724:	0200006f          	j	744 <write_hex+0x50>
 728:	03778793          	addi	a5,a5,55 # 2037 <_gp+0x40f>
 72c:	0ff7f793          	andi	a5,a5,255
 730:	00f107a3          	sb	a5,15(sp)
 734:	00100613          	li	a2,1
 738:	00f10593          	addi	a1,sp,15
 73c:	00090513          	mv	a0,s2
 740:	f11ff0ef          	jal	ra,650 <write>
 744:	02040c63          	beqz	s0,77c <write_hex+0x88>
 748:	fff40413          	addi	s0,s0,-1
 74c:	0ff47413          	andi	s0,s0,255
 750:	00241713          	slli	a4,s0,0x2
 754:	00f00793          	li	a5,15
 758:	00e797b3          	sll	a5,a5,a4
 75c:	0097f7b3          	and	a5,a5,s1
 760:	00e7d7b3          	srl	a5,a5,a4
 764:	0ff7f793          	andi	a5,a5,255
 768:	00900713          	li	a4,9
 76c:	faf76ee3          	bltu	a4,a5,728 <write_hex+0x34>
 770:	03078793          	addi	a5,a5,48
 774:	0ff7f793          	andi	a5,a5,255
 778:	fb9ff06f          	j	730 <write_hex+0x3c>
 77c:	01c12083          	lw	ra,28(sp)
 780:	01812403          	lw	s0,24(sp)
 784:	01412483          	lw	s1,20(sp)
 788:	01012903          	lw	s2,16(sp)
 78c:	02010113          	addi	sp,sp,32
 790:	00008067          	ret

00000794 <_exit>:
 794:	ff010113          	addi	sp,sp,-16
 798:	00112623          	sw	ra,12(sp)
 79c:	00812423          	sw	s0,8(sp)
 7a0:	00050413          	mv	s0,a0
 7a4:	01b00613          	li	a2,27
 7a8:	000015b7          	lui	a1,0x1
 7ac:	bd058593          	addi	a1,a1,-1072 # bd0 <__call_exitprocs+0x16c>
 7b0:	00200513          	li	a0,2
 7b4:	e9dff0ef          	jal	ra,650 <write>
 7b8:	00040593          	mv	a1,s0
 7bc:	00200513          	li	a0,2
 7c0:	f35ff0ef          	jal	ra,6f4 <write_hex>
 7c4:	0000006f          	j	7c4 <_exit+0x30>

000007c8 <syscallHandler>:
 7c8:	ff010113          	addi	sp,sp,-16
 7cc:	00112623          	sw	ra,12(sp)
 7d0:	00050793          	mv	a5,a0
 7d4:	0005a503          	lw	a0,0(a1)
 7d8:	04000713          	li	a4,64
 7dc:	06e78863          	beq	a5,a4,84c <syscallHandler+0x84>
 7e0:	02f76463          	bltu	a4,a5,808 <syscallHandler+0x40>
 7e4:	03e00713          	li	a4,62
 7e8:	04e78263          	beq	a5,a4,82c <syscallHandler+0x64>
 7ec:	04f76863          	bltu	a4,a5,83c <syscallHandler+0x74>
 7f0:	03900713          	li	a4,57
 7f4:	00e79463          	bne	a5,a4,7fc <syscallHandler+0x34>
 7f8:	d59ff0ef          	jal	ra,550 <close>
 7fc:	00c12083          	lw	ra,12(sp)
 800:	01010113          	addi	sp,sp,16
 804:	00008067          	ret
 808:	05d00713          	li	a4,93
 80c:	04e78863          	beq	a5,a4,85c <syscallHandler+0x94>
 810:	0d600713          	li	a4,214
 814:	04e78663          	beq	a5,a4,860 <syscallHandler+0x98>
 818:	05000713          	li	a4,80
 81c:	fee790e3          	bne	a5,a4,7fc <syscallHandler+0x34>
 820:	0045a583          	lw	a1,4(a1)
 824:	d6dff0ef          	jal	ra,590 <fstat>
 828:	fd5ff06f          	j	7fc <syscallHandler+0x34>
 82c:	0085a603          	lw	a2,8(a1)
 830:	0045a583          	lw	a1,4(a1)
 834:	d9dff0ef          	jal	ra,5d0 <lseek>
 838:	fc5ff06f          	j	7fc <syscallHandler+0x34>
 83c:	0085a603          	lw	a2,8(a1)
 840:	0045a583          	lw	a1,4(a1)
 844:	db9ff0ef          	jal	ra,5fc <read>
 848:	fb5ff06f          	j	7fc <syscallHandler+0x34>
 84c:	0085a603          	lw	a2,8(a1)
 850:	0045a583          	lw	a1,4(a1)
 854:	dfdff0ef          	jal	ra,650 <write>
 858:	fa5ff06f          	j	7fc <syscallHandler+0x34>
 85c:	f39ff0ef          	jal	ra,794 <_exit>
 860:	ce5ff0ef          	jal	ra,544 <brk>
 864:	f99ff06f          	j	7fc <syscallHandler+0x34>

00000868 <uartInit>:
 868:	00b52023          	sw	a1,0(a0)
 86c:	00858713          	addi	a4,a1,8
 870:	0085c783          	lbu	a5,8(a1)
 874:	0ff7f793          	andi	a5,a5,255
 878:	0027f793          	andi	a5,a5,2
 87c:	02078663          	beqz	a5,8a8 <uartInit+0x40>
 880:	ff010113          	addi	sp,sp,-16
 884:	0045c783          	lbu	a5,4(a1)
 888:	0ff7f793          	andi	a5,a5,255
 88c:	00f107a3          	sb	a5,15(sp)
 890:	00074783          	lbu	a5,0(a4)
 894:	0ff7f793          	andi	a5,a5,255
 898:	0027f793          	andi	a5,a5,2
 89c:	fe0794e3          	bnez	a5,884 <uartInit+0x1c>
 8a0:	01010113          	addi	sp,sp,16
 8a4:	00008067          	ret
 8a8:	00008067          	ret

000008ac <uartSend>:
 8ac:	00060663          	beqz	a2,8b8 <uartSend+0xc>
 8b0:	00000693          	li	a3,0
 8b4:	0280006f          	j	8dc <uartSend+0x30>
 8b8:	00008067          	ret
 8bc:	00052703          	lw	a4,0(a0)
 8c0:	00874783          	lbu	a5,8(a4)
 8c4:	0017f793          	andi	a5,a5,1
 8c8:	fe078ae3          	beqz	a5,8bc <uartSend+0x10>
 8cc:	00d587b3          	add	a5,a1,a3
 8d0:	0007c783          	lbu	a5,0(a5)
 8d4:	00f70023          	sb	a5,0(a4)
 8d8:	00168693          	addi	a3,a3,1
 8dc:	fec6e0e3          	bltu	a3,a2,8bc <uartSend+0x10>
 8e0:	00008067          	ret

000008e4 <uartRead>:
 8e4:	04060463          	beqz	a2,92c <uartRead+0x48>
 8e8:	00052783          	lw	a5,0(a0)
 8ec:	0087c783          	lbu	a5,8(a5)
 8f0:	0ff7f793          	andi	a5,a5,255
 8f4:	00000713          	li	a4,0
 8f8:	0240006f          	j	91c <uartRead+0x38>
 8fc:	00e587b3          	add	a5,a1,a4
 900:	00052683          	lw	a3,0(a0)
 904:	0046c683          	lbu	a3,4(a3)
 908:	00d78023          	sb	a3,0(a5)
 90c:	00052783          	lw	a5,0(a0)
 910:	0087c783          	lbu	a5,8(a5)
 914:	0ff7f793          	andi	a5,a5,255
 918:	00170713          	addi	a4,a4,1
 91c:	0027f793          	andi	a5,a5,2
 920:	00078863          	beqz	a5,930 <uartRead+0x4c>
 924:	fcc76ce3          	bltu	a4,a2,8fc <uartRead+0x18>
 928:	0080006f          	j	930 <uartRead+0x4c>
 92c:	00060713          	mv	a4,a2
 930:	00070513          	mv	a0,a4
 934:	00008067          	ret

00000938 <exit>:
 938:	ff010113          	addi	sp,sp,-16
 93c:	00000593          	li	a1,0
 940:	00812423          	sw	s0,8(sp)
 944:	00112623          	sw	ra,12(sp)
 948:	00050413          	mv	s0,a0
 94c:	118000ef          	jal	ra,a64 <__call_exitprocs>
 950:	000017b7          	lui	a5,0x1
 954:	4287a503          	lw	a0,1064(a5) # 1428 <_global_impure_ptr>
 958:	03c52783          	lw	a5,60(a0)
 95c:	00078463          	beqz	a5,964 <exit+0x2c>
 960:	000780e7          	jalr	a5
 964:	00040513          	mv	a0,s0
 968:	e2dff0ef          	jal	ra,794 <_exit>

0000096c <memset>:
 96c:	00f00813          	li	a6,15
 970:	00050713          	mv	a4,a0
 974:	02c87e63          	bleu	a2,a6,9b0 <memset+0x44>
 978:	00f77793          	andi	a5,a4,15
 97c:	0a079063          	bnez	a5,a1c <memset+0xb0>
 980:	08059263          	bnez	a1,a04 <memset+0x98>
 984:	ff067693          	andi	a3,a2,-16
 988:	00f67613          	andi	a2,a2,15
 98c:	00e686b3          	add	a3,a3,a4
 990:	00b72023          	sw	a1,0(a4)
 994:	00b72223          	sw	a1,4(a4)
 998:	00b72423          	sw	a1,8(a4)
 99c:	00b72623          	sw	a1,12(a4)
 9a0:	01070713          	addi	a4,a4,16
 9a4:	fed766e3          	bltu	a4,a3,990 <memset+0x24>
 9a8:	00061463          	bnez	a2,9b0 <memset+0x44>
 9ac:	00008067          	ret
 9b0:	40c806b3          	sub	a3,a6,a2
 9b4:	00269693          	slli	a3,a3,0x2
 9b8:	00000297          	auipc	t0,0x0
 9bc:	005686b3          	add	a3,a3,t0
 9c0:	00c68067          	jr	12(a3)
 9c4:	00b70723          	sb	a1,14(a4)
 9c8:	00b706a3          	sb	a1,13(a4)
 9cc:	00b70623          	sb	a1,12(a4)
 9d0:	00b705a3          	sb	a1,11(a4)
 9d4:	00b70523          	sb	a1,10(a4)
 9d8:	00b704a3          	sb	a1,9(a4)
 9dc:	00b70423          	sb	a1,8(a4)
 9e0:	00b703a3          	sb	a1,7(a4)
 9e4:	00b70323          	sb	a1,6(a4)
 9e8:	00b702a3          	sb	a1,5(a4)
 9ec:	00b70223          	sb	a1,4(a4)
 9f0:	00b701a3          	sb	a1,3(a4)
 9f4:	00b70123          	sb	a1,2(a4)
 9f8:	00b700a3          	sb	a1,1(a4)
 9fc:	00b70023          	sb	a1,0(a4)
 a00:	00008067          	ret
 a04:	0ff5f593          	andi	a1,a1,255
 a08:	00859693          	slli	a3,a1,0x8
 a0c:	00d5e5b3          	or	a1,a1,a3
 a10:	01059693          	slli	a3,a1,0x10
 a14:	00d5e5b3          	or	a1,a1,a3
 a18:	f6dff06f          	j	984 <memset+0x18>
 a1c:	00279693          	slli	a3,a5,0x2
 a20:	00000297          	auipc	t0,0x0
 a24:	005686b3          	add	a3,a3,t0
 a28:	00008293          	mv	t0,ra
 a2c:	fa0680e7          	jalr	-96(a3)
 a30:	00028093          	mv	ra,t0
 a34:	ff078793          	addi	a5,a5,-16
 a38:	40f70733          	sub	a4,a4,a5
 a3c:	00f60633          	add	a2,a2,a5
 a40:	f6c878e3          	bleu	a2,a6,9b0 <memset+0x44>
 a44:	f3dff06f          	j	980 <memset+0x14>

00000a48 <strlen>:
 a48:	00050793          	mv	a5,a0
 a4c:	00178793          	addi	a5,a5,1
 a50:	fff7c703          	lbu	a4,-1(a5)
 a54:	fe071ce3          	bnez	a4,a4c <strlen+0x4>
 a58:	40a78533          	sub	a0,a5,a0
 a5c:	fff50513          	addi	a0,a0,-1
 a60:	00008067          	ret

00000a64 <__call_exitprocs>:
 a64:	fd010113          	addi	sp,sp,-48
 a68:	000017b7          	lui	a5,0x1
 a6c:	01312e23          	sw	s3,28(sp)
 a70:	4287a983          	lw	s3,1064(a5) # 1428 <_global_impure_ptr>
 a74:	01412c23          	sw	s4,24(sp)
 a78:	01512a23          	sw	s5,20(sp)
 a7c:	01612823          	sw	s6,16(sp)
 a80:	02112623          	sw	ra,44(sp)
 a84:	02812423          	sw	s0,40(sp)
 a88:	02912223          	sw	s1,36(sp)
 a8c:	03212023          	sw	s2,32(sp)
 a90:	01712623          	sw	s7,12(sp)
 a94:	00050a93          	mv	s5,a0
 a98:	00058a13          	mv	s4,a1
 a9c:	00100b13          	li	s6,1
 aa0:	1489a483          	lw	s1,328(s3)
 aa4:	00048c63          	beqz	s1,abc <__call_exitprocs+0x58>
 aa8:	0044a403          	lw	s0,4(s1)
 aac:	fff40913          	addi	s2,s0,-1
 ab0:	00241413          	slli	s0,s0,0x2
 ab4:	00848433          	add	s0,s1,s0
 ab8:	02095863          	bgez	s2,ae8 <__call_exitprocs+0x84>
 abc:	02c12083          	lw	ra,44(sp)
 ac0:	02812403          	lw	s0,40(sp)
 ac4:	02412483          	lw	s1,36(sp)
 ac8:	02012903          	lw	s2,32(sp)
 acc:	01c12983          	lw	s3,28(sp)
 ad0:	01812a03          	lw	s4,24(sp)
 ad4:	01412a83          	lw	s5,20(sp)
 ad8:	01012b03          	lw	s6,16(sp)
 adc:	00c12b83          	lw	s7,12(sp)
 ae0:	03010113          	addi	sp,sp,48
 ae4:	00008067          	ret
 ae8:	000a0c63          	beqz	s4,b00 <__call_exitprocs+0x9c>
 aec:	10442783          	lw	a5,260(s0)
 af0:	01478863          	beq	a5,s4,b00 <__call_exitprocs+0x9c>
 af4:	fff90913          	addi	s2,s2,-1
 af8:	ffc40413          	addi	s0,s0,-4
 afc:	fbdff06f          	j	ab8 <__call_exitprocs+0x54>
 b00:	0044a703          	lw	a4,4(s1)
 b04:	00442783          	lw	a5,4(s0)
 b08:	fff70713          	addi	a4,a4,-1
 b0c:	03271c63          	bne	a4,s2,b44 <__call_exitprocs+0xe0>
 b10:	0124a223          	sw	s2,4(s1)
 b14:	fe0780e3          	beqz	a5,af4 <__call_exitprocs+0x90>
 b18:	1884a683          	lw	a3,392(s1)
 b1c:	012b1733          	sll	a4,s6,s2
 b20:	0044ab83          	lw	s7,4(s1)
 b24:	00d776b3          	and	a3,a4,a3
 b28:	02069263          	bnez	a3,b4c <__call_exitprocs+0xe8>
 b2c:	000780e7          	jalr	a5
 b30:	0044a703          	lw	a4,4(s1)
 b34:	1489a783          	lw	a5,328(s3)
 b38:	f77714e3          	bne	a4,s7,aa0 <__call_exitprocs+0x3c>
 b3c:	faf48ce3          	beq	s1,a5,af4 <__call_exitprocs+0x90>
 b40:	f61ff06f          	j	aa0 <__call_exitprocs+0x3c>
 b44:	00042223          	sw	zero,4(s0)
 b48:	fcdff06f          	j	b14 <__call_exitprocs+0xb0>
 b4c:	18c4a683          	lw	a3,396(s1)
 b50:	08442583          	lw	a1,132(s0)
 b54:	00d77733          	and	a4,a4,a3
 b58:	00071863          	bnez	a4,b68 <__call_exitprocs+0x104>
 b5c:	000a8513          	mv	a0,s5
 b60:	000780e7          	jalr	a5
 b64:	fcdff06f          	j	b30 <__call_exitprocs+0xcc>
 b68:	00058513          	mv	a0,a1
 b6c:	000780e7          	jalr	a5
 b70:	fc1ff06f          	j	b30 <__call_exitprocs+0xcc>
