
memory:     file format elf32-littleriscv


Disassembly of section .text:

00010074 <main>:
   10074:	00021537          	lui	a0,0x21
   10078:	ff010113          	addi	sp,sp,-16
   1007c:	40000593          	li	a1,1024
   10080:	6d050513          	addi	a0,a0,1744 # 216d0 <__clzsi2+0x4c>
   10084:	00112623          	sw	ra,12(sp)
   10088:	00812423          	sw	s0,8(sp)
   1008c:	289000ef          	jal	ra,10b14 <printf>
   10090:	00001537          	lui	a0,0x1
   10094:	300000ef          	jal	ra,10394 <malloc>
   10098:	00050593          	mv	a1,a0
   1009c:	00050413          	mv	s0,a0
   100a0:	00021537          	lui	a0,0x21
   100a4:	6ec50513          	addi	a0,a0,1772 # 216ec <__clzsi2+0x68>
   100a8:	26d000ef          	jal	ra,10b14 <printf>
   100ac:	00021537          	lui	a0,0x21
   100b0:	6fc50513          	addi	a0,a0,1788 # 216fc <__clzsi2+0x78>
   100b4:	375000ef          	jal	ra,10c28 <puts>
   100b8:	00040713          	mv	a4,s0
   100bc:	00000793          	li	a5,0
   100c0:	40000693          	li	a3,1024
   100c4:	00470713          	addi	a4,a4,4
   100c8:	fef72e23          	sw	a5,-4(a4)
   100cc:	00178793          	addi	a5,a5,1
   100d0:	fed79ae3          	bne	a5,a3,100c4 <main+0x50>
   100d4:	00021537          	lui	a0,0x21
   100d8:	72050513          	addi	a0,a0,1824 # 21720 <__clzsi2+0x9c>
   100dc:	34d000ef          	jal	ra,10c28 <puts>
   100e0:	00001537          	lui	a0,0x1
   100e4:	00a40533          	add	a0,s0,a0
   100e8:	2b8000ef          	jal	ra,103a0 <free>
   100ec:	00c12083          	lw	ra,12(sp)
   100f0:	00812403          	lw	s0,8(sp)
   100f4:	00000513          	li	a0,0
   100f8:	01010113          	addi	sp,sp,16
   100fc:	00008067          	ret

00010100 <_start>:
   10100:	00014197          	auipc	gp,0x14
   10104:	66018193          	addi	gp,gp,1632 # 24760 <__global_pointer$>
   10108:	00014517          	auipc	a0,0x14
   1010c:	e8450513          	addi	a0,a0,-380 # 23f8c <_edata>
   10110:	00014617          	auipc	a2,0x14
   10114:	ee060613          	addi	a2,a2,-288 # 23ff0 <_end>
   10118:	40a60633          	sub	a2,a2,a0
   1011c:	00000593          	li	a1,0
   10120:	0d1000ef          	jal	ra,109f0 <memset>
   10124:	00000517          	auipc	a0,0x0
   10128:	16050513          	addi	a0,a0,352 # 10284 <__libc_fini_array>
   1012c:	114000ef          	jal	ra,10240 <atexit>
   10130:	1c4000ef          	jal	ra,102f4 <__libc_init_array>
   10134:	00012503          	lw	a0,0(sp)
   10138:	00410593          	addi	a1,sp,4
   1013c:	00000613          	li	a2,0
   10140:	f35ff0ef          	jal	ra,10074 <main>
   10144:	1100006f          	j	10254 <exit>

00010148 <_fini>:
   10148:	00008067          	ret

0001014c <deregister_tm_clones>:
   1014c:	00024537          	lui	a0,0x24
   10150:	000247b7          	lui	a5,0x24
   10154:	f5c50713          	addi	a4,a0,-164 # 23f5c <__TMC_END__>
   10158:	f5c78793          	addi	a5,a5,-164 # 23f5c <__TMC_END__>
   1015c:	00e78c63          	beq	a5,a4,10174 <deregister_tm_clones+0x28>
   10160:	00000337          	lui	t1,0x0
   10164:	00030313          	mv	t1,t1
   10168:	00030663          	beqz	t1,10174 <deregister_tm_clones+0x28>
   1016c:	f5c50513          	addi	a0,a0,-164
   10170:	00030067          	jr	t1
   10174:	00008067          	ret

00010178 <register_tm_clones>:
   10178:	000247b7          	lui	a5,0x24
   1017c:	00024537          	lui	a0,0x24
   10180:	f5c78593          	addi	a1,a5,-164 # 23f5c <__TMC_END__>
   10184:	f5c50793          	addi	a5,a0,-164 # 23f5c <__TMC_END__>
   10188:	40f585b3          	sub	a1,a1,a5
   1018c:	4025d593          	srai	a1,a1,0x2
   10190:	01f5d793          	srli	a5,a1,0x1f
   10194:	00b785b3          	add	a1,a5,a1
   10198:	4015d593          	srai	a1,a1,0x1
   1019c:	00058c63          	beqz	a1,101b4 <register_tm_clones+0x3c>
   101a0:	00000337          	lui	t1,0x0
   101a4:	00030313          	mv	t1,t1
   101a8:	00030663          	beqz	t1,101b4 <register_tm_clones+0x3c>
   101ac:	f5c50513          	addi	a0,a0,-164
   101b0:	00030067          	jr	t1
   101b4:	00008067          	ret

000101b8 <__do_global_dtors_aux>:
   101b8:	8481c703          	lbu	a4,-1976(gp) # 23fa8 <completed.5148>
   101bc:	04071663          	bnez	a4,10208 <__do_global_dtors_aux+0x50>
   101c0:	ff010113          	addi	sp,sp,-16
   101c4:	00812423          	sw	s0,8(sp)
   101c8:	00112623          	sw	ra,12(sp)
   101cc:	00078413          	mv	s0,a5
   101d0:	f7dff0ef          	jal	ra,1014c <deregister_tm_clones>
   101d4:	000007b7          	lui	a5,0x0
   101d8:	00078793          	mv	a5,a5
   101dc:	00078a63          	beqz	a5,101f0 <__do_global_dtors_aux+0x38>
   101e0:	00022537          	lui	a0,0x22
   101e4:	44c50513          	addi	a0,a0,1100 # 2244c <__EH_FRAME_BEGIN__>
   101e8:	ffff0097          	auipc	ra,0xffff0
   101ec:	e18080e7          	jalr	-488(ra) # 0 <main-0x10074>
   101f0:	00100793          	li	a5,1
   101f4:	84f18423          	sb	a5,-1976(gp) # 23fa8 <completed.5148>
   101f8:	00c12083          	lw	ra,12(sp)
   101fc:	00812403          	lw	s0,8(sp)
   10200:	01010113          	addi	sp,sp,16
   10204:	00008067          	ret
   10208:	00008067          	ret

0001020c <frame_dummy>:
   1020c:	000007b7          	lui	a5,0x0
   10210:	00078793          	mv	a5,a5
   10214:	02078463          	beqz	a5,1023c <frame_dummy+0x30>
   10218:	00022537          	lui	a0,0x22
   1021c:	ff010113          	addi	sp,sp,-16
   10220:	84c18593          	addi	a1,gp,-1972 # 23fac <object.5153>
   10224:	44c50513          	addi	a0,a0,1100 # 2244c <__EH_FRAME_BEGIN__>
   10228:	00112623          	sw	ra,12(sp)
   1022c:	ffff0097          	auipc	ra,0xffff0
   10230:	dd4080e7          	jalr	-556(ra) # 0 <main-0x10074>
   10234:	00c12083          	lw	ra,12(sp)
   10238:	01010113          	addi	sp,sp,16
   1023c:	f3dff06f          	j	10178 <register_tm_clones>

00010240 <atexit>:
   10240:	00050593          	mv	a1,a0
   10244:	00000693          	li	a3,0
   10248:	00000613          	li	a2,0
   1024c:	00000513          	li	a0,0
   10250:	4690206f          	j	12eb8 <__register_exitproc>

00010254 <exit>:
   10254:	ff010113          	addi	sp,sp,-16
   10258:	00000593          	li	a1,0
   1025c:	00812423          	sw	s0,8(sp)
   10260:	00112623          	sw	ra,12(sp)
   10264:	00050413          	mv	s0,a0
   10268:	4cd020ef          	jal	ra,12f34 <__call_exitprocs>
   1026c:	81c1a503          	lw	a0,-2020(gp) # 23f7c <_global_impure_ptr>
   10270:	03c52783          	lw	a5,60(a0)
   10274:	00078463          	beqz	a5,1027c <exit+0x28>
   10278:	000780e7          	jalr	a5
   1027c:	00040513          	mv	a0,s0
   10280:	3e00c0ef          	jal	ra,1c660 <_exit>

00010284 <__libc_fini_array>:
   10284:	ff010113          	addi	sp,sp,-16
   10288:	000237b7          	lui	a5,0x23
   1028c:	00023737          	lui	a4,0x23
   10290:	00812423          	sw	s0,8(sp)
   10294:	5bc70713          	addi	a4,a4,1468 # 235bc <__init_array_end>
   10298:	5c078413          	addi	s0,a5,1472 # 235c0 <__fini_array_end>
   1029c:	40e40433          	sub	s0,s0,a4
   102a0:	00912223          	sw	s1,4(sp)
   102a4:	01212023          	sw	s2,0(sp)
   102a8:	00112623          	sw	ra,12(sp)
   102ac:	40245413          	srai	s0,s0,0x2
   102b0:	00000493          	li	s1,0
   102b4:	5c078913          	addi	s2,a5,1472
   102b8:	00941e63          	bne	s0,s1,102d4 <__libc_fini_array+0x50>
   102bc:	00812403          	lw	s0,8(sp)
   102c0:	00c12083          	lw	ra,12(sp)
   102c4:	00412483          	lw	s1,4(sp)
   102c8:	00012903          	lw	s2,0(sp)
   102cc:	01010113          	addi	sp,sp,16
   102d0:	e79ff06f          	j	10148 <_fini>
   102d4:	ffc00593          	li	a1,-4
   102d8:	00048513          	mv	a0,s1
   102dc:	2d0110ef          	jal	ra,215ac <__mulsi3>
   102e0:	00a90533          	add	a0,s2,a0
   102e4:	ffc52783          	lw	a5,-4(a0)
   102e8:	00148493          	addi	s1,s1,1
   102ec:	000780e7          	jalr	a5
   102f0:	fc9ff06f          	j	102b8 <__libc_fini_array+0x34>

000102f4 <__libc_init_array>:
   102f4:	ff010113          	addi	sp,sp,-16
   102f8:	00812423          	sw	s0,8(sp)
   102fc:	00912223          	sw	s1,4(sp)
   10300:	00023437          	lui	s0,0x23
   10304:	000234b7          	lui	s1,0x23
   10308:	5b848793          	addi	a5,s1,1464 # 235b8 <__frame_dummy_init_array_entry>
   1030c:	5b840413          	addi	s0,s0,1464 # 235b8 <__frame_dummy_init_array_entry>
   10310:	40f40433          	sub	s0,s0,a5
   10314:	01212023          	sw	s2,0(sp)
   10318:	00112623          	sw	ra,12(sp)
   1031c:	40245413          	srai	s0,s0,0x2
   10320:	5b848493          	addi	s1,s1,1464
   10324:	00000913          	li	s2,0
   10328:	04891263          	bne	s2,s0,1036c <__libc_init_array+0x78>
   1032c:	000234b7          	lui	s1,0x23
   10330:	e19ff0ef          	jal	ra,10148 <_fini>
   10334:	00023437          	lui	s0,0x23
   10338:	5b848793          	addi	a5,s1,1464 # 235b8 <__frame_dummy_init_array_entry>
   1033c:	5bc40413          	addi	s0,s0,1468 # 235bc <__init_array_end>
   10340:	40f40433          	sub	s0,s0,a5
   10344:	40245413          	srai	s0,s0,0x2
   10348:	5b848493          	addi	s1,s1,1464
   1034c:	00000913          	li	s2,0
   10350:	02891863          	bne	s2,s0,10380 <__libc_init_array+0x8c>
   10354:	00c12083          	lw	ra,12(sp)
   10358:	00812403          	lw	s0,8(sp)
   1035c:	00412483          	lw	s1,4(sp)
   10360:	00012903          	lw	s2,0(sp)
   10364:	01010113          	addi	sp,sp,16
   10368:	00008067          	ret
   1036c:	0004a783          	lw	a5,0(s1)
   10370:	00190913          	addi	s2,s2,1
   10374:	00448493          	addi	s1,s1,4
   10378:	000780e7          	jalr	a5
   1037c:	fadff06f          	j	10328 <__libc_init_array+0x34>
   10380:	0004a783          	lw	a5,0(s1)
   10384:	00190913          	addi	s2,s2,1
   10388:	00448493          	addi	s1,s1,4
   1038c:	000780e7          	jalr	a5
   10390:	fc1ff06f          	j	10350 <__libc_init_array+0x5c>

00010394 <malloc>:
   10394:	00050593          	mv	a1,a0
   10398:	8201a503          	lw	a0,-2016(gp) # 23f80 <_impure_ptr>
   1039c:	0100006f          	j	103ac <_malloc_r>

000103a0 <free>:
   103a0:	00050593          	mv	a1,a0
   103a4:	8201a503          	lw	a0,-2016(gp) # 23f80 <_impure_ptr>
   103a8:	2e80306f          	j	13690 <_free_r>

000103ac <_malloc_r>:
   103ac:	fd010113          	addi	sp,sp,-48
   103b0:	02112623          	sw	ra,44(sp)
   103b4:	02812423          	sw	s0,40(sp)
   103b8:	02912223          	sw	s1,36(sp)
   103bc:	03212023          	sw	s2,32(sp)
   103c0:	01312e23          	sw	s3,28(sp)
   103c4:	01412c23          	sw	s4,24(sp)
   103c8:	01512a23          	sw	s5,20(sp)
   103cc:	01612823          	sw	s6,16(sp)
   103d0:	01712623          	sw	s7,12(sp)
   103d4:	01812423          	sw	s8,8(sp)
   103d8:	00b58793          	addi	a5,a1,11
   103dc:	01600713          	li	a4,22
   103e0:	04f77463          	bleu	a5,a4,10428 <_malloc_r+0x7c>
   103e4:	ff87f493          	andi	s1,a5,-8
   103e8:	0404d263          	bgez	s1,1042c <_malloc_r+0x80>
   103ec:	00c00793          	li	a5,12
   103f0:	00f52023          	sw	a5,0(a0)
   103f4:	00000513          	li	a0,0
   103f8:	02c12083          	lw	ra,44(sp)
   103fc:	02812403          	lw	s0,40(sp)
   10400:	02412483          	lw	s1,36(sp)
   10404:	02012903          	lw	s2,32(sp)
   10408:	01c12983          	lw	s3,28(sp)
   1040c:	01812a03          	lw	s4,24(sp)
   10410:	01412a83          	lw	s5,20(sp)
   10414:	01012b03          	lw	s6,16(sp)
   10418:	00c12b83          	lw	s7,12(sp)
   1041c:	00812c03          	lw	s8,8(sp)
   10420:	03010113          	addi	sp,sp,48
   10424:	00008067          	ret
   10428:	01000493          	li	s1,16
   1042c:	fcb4e0e3          	bltu	s1,a1,103ec <_malloc_r+0x40>
   10430:	00050993          	mv	s3,a0
   10434:	698000ef          	jal	ra,10acc <__malloc_lock>
   10438:	00024937          	lui	s2,0x24
   1043c:	1f700793          	li	a5,503
   10440:	9e890913          	addi	s2,s2,-1560 # 239e8 <__malloc_av_>
   10444:	0497ea63          	bltu	a5,s1,10498 <_malloc_r+0xec>
   10448:	00848713          	addi	a4,s1,8
   1044c:	00e90733          	add	a4,s2,a4
   10450:	00472403          	lw	s0,4(a4)
   10454:	ff870693          	addi	a3,a4,-8
   10458:	0034d793          	srli	a5,s1,0x3
   1045c:	00d41863          	bne	s0,a3,1046c <_malloc_r+0xc0>
   10460:	00c72403          	lw	s0,12(a4)
   10464:	00278793          	addi	a5,a5,2
   10468:	08870063          	beq	a4,s0,104e8 <_malloc_r+0x13c>
   1046c:	00442783          	lw	a5,4(s0)
   10470:	00c42703          	lw	a4,12(s0)
   10474:	00842683          	lw	a3,8(s0)
   10478:	ffc7f793          	andi	a5,a5,-4
   1047c:	00f407b3          	add	a5,s0,a5
   10480:	00e6a623          	sw	a4,12(a3)
   10484:	00d72423          	sw	a3,8(a4)
   10488:	0047a703          	lw	a4,4(a5)
   1048c:	00176713          	ori	a4,a4,1
   10490:	00e7a223          	sw	a4,4(a5)
   10494:	0a80006f          	j	1053c <_malloc_r+0x190>
   10498:	0094d713          	srli	a4,s1,0x9
   1049c:	03f00793          	li	a5,63
   104a0:	00070a63          	beqz	a4,104b4 <_malloc_r+0x108>
   104a4:	00400793          	li	a5,4
   104a8:	0ae7e263          	bltu	a5,a4,1054c <_malloc_r+0x1a0>
   104ac:	0064d793          	srli	a5,s1,0x6
   104b0:	03878793          	addi	a5,a5,56
   104b4:	00178713          	addi	a4,a5,1
   104b8:	00371713          	slli	a4,a4,0x3
   104bc:	00e90733          	add	a4,s2,a4
   104c0:	00472403          	lw	s0,4(a4)
   104c4:	ff870593          	addi	a1,a4,-8
   104c8:	00f00513          	li	a0,15
   104cc:	00b40c63          	beq	s0,a1,104e4 <_malloc_r+0x138>
   104d0:	00442703          	lw	a4,4(s0)
   104d4:	ffc77713          	andi	a4,a4,-4
   104d8:	40970633          	sub	a2,a4,s1
   104dc:	0cc55063          	ble	a2,a0,1059c <_malloc_r+0x1f0>
   104e0:	fff78793          	addi	a5,a5,-1
   104e4:	00178793          	addi	a5,a5,1
   104e8:	01092403          	lw	s0,16(s2)
   104ec:	000245b7          	lui	a1,0x24
   104f0:	00890693          	addi	a3,s2,8
   104f4:	9f058593          	addi	a1,a1,-1552 # 239f0 <__malloc_av_+0x8>
   104f8:	12d40863          	beq	s0,a3,10628 <_malloc_r+0x27c>
   104fc:	00442703          	lw	a4,4(s0)
   10500:	00f00613          	li	a2,15
   10504:	ffc77713          	andi	a4,a4,-4
   10508:	40970533          	sub	a0,a4,s1
   1050c:	0aa65a63          	ble	a0,a2,105c0 <_malloc_r+0x214>
   10510:	0014e793          	ori	a5,s1,1
   10514:	00f42223          	sw	a5,4(s0)
   10518:	00940633          	add	a2,s0,s1
   1051c:	00c92a23          	sw	a2,20(s2)
   10520:	00c92823          	sw	a2,16(s2)
   10524:	00156793          	ori	a5,a0,1
   10528:	00d62623          	sw	a3,12(a2)
   1052c:	00d62423          	sw	a3,8(a2)
   10530:	00f62223          	sw	a5,4(a2)
   10534:	00e40733          	add	a4,s0,a4
   10538:	00a72023          	sw	a0,0(a4)
   1053c:	00098513          	mv	a0,s3
   10540:	590000ef          	jal	ra,10ad0 <__malloc_unlock>
   10544:	00840513          	addi	a0,s0,8
   10548:	eb1ff06f          	j	103f8 <_malloc_r+0x4c>
   1054c:	01400793          	li	a5,20
   10550:	00e7e663          	bltu	a5,a4,1055c <_malloc_r+0x1b0>
   10554:	05b70793          	addi	a5,a4,91
   10558:	f5dff06f          	j	104b4 <_malloc_r+0x108>
   1055c:	05400793          	li	a5,84
   10560:	00e7e863          	bltu	a5,a4,10570 <_malloc_r+0x1c4>
   10564:	00c4d793          	srli	a5,s1,0xc
   10568:	06e78793          	addi	a5,a5,110
   1056c:	f49ff06f          	j	104b4 <_malloc_r+0x108>
   10570:	15400793          	li	a5,340
   10574:	00e7e863          	bltu	a5,a4,10584 <_malloc_r+0x1d8>
   10578:	00f4d793          	srli	a5,s1,0xf
   1057c:	07778793          	addi	a5,a5,119
   10580:	f35ff06f          	j	104b4 <_malloc_r+0x108>
   10584:	55400693          	li	a3,1364
   10588:	07e00793          	li	a5,126
   1058c:	f2e6e4e3          	bltu	a3,a4,104b4 <_malloc_r+0x108>
   10590:	0124d793          	srli	a5,s1,0x12
   10594:	07c78793          	addi	a5,a5,124
   10598:	f1dff06f          	j	104b4 <_malloc_r+0x108>
   1059c:	00c42683          	lw	a3,12(s0)
   105a0:	00064c63          	bltz	a2,105b8 <_malloc_r+0x20c>
   105a4:	00842783          	lw	a5,8(s0)
   105a8:	00d7a623          	sw	a3,12(a5)
   105ac:	00f6a423          	sw	a5,8(a3)
   105b0:	00e407b3          	add	a5,s0,a4
   105b4:	ed5ff06f          	j	10488 <_malloc_r+0xdc>
   105b8:	00068413          	mv	s0,a3
   105bc:	f11ff06f          	j	104cc <_malloc_r+0x120>
   105c0:	00d92a23          	sw	a3,20(s2)
   105c4:	00d92823          	sw	a3,16(s2)
   105c8:	00054c63          	bltz	a0,105e0 <_malloc_r+0x234>
   105cc:	00e40733          	add	a4,s0,a4
   105d0:	00472783          	lw	a5,4(a4)
   105d4:	0017e793          	ori	a5,a5,1
   105d8:	00f72223          	sw	a5,4(a4)
   105dc:	f61ff06f          	j	1053c <_malloc_r+0x190>
   105e0:	1ff00693          	li	a3,511
   105e4:	00492803          	lw	a6,4(s2)
   105e8:	16e6e663          	bltu	a3,a4,10754 <_malloc_r+0x3a8>
   105ec:	00375713          	srli	a4,a4,0x3
   105f0:	40275613          	srai	a2,a4,0x2
   105f4:	00100693          	li	a3,1
   105f8:	00170713          	addi	a4,a4,1
   105fc:	00c696b3          	sll	a3,a3,a2
   10600:	00371713          	slli	a4,a4,0x3
   10604:	00e90733          	add	a4,s2,a4
   10608:	0106e6b3          	or	a3,a3,a6
   1060c:	00d92223          	sw	a3,4(s2)
   10610:	00072683          	lw	a3,0(a4)
   10614:	ff870613          	addi	a2,a4,-8
   10618:	00c42623          	sw	a2,12(s0)
   1061c:	00d42423          	sw	a3,8(s0)
   10620:	00872023          	sw	s0,0(a4)
   10624:	0086a623          	sw	s0,12(a3)
   10628:	4027d713          	srai	a4,a5,0x2
   1062c:	00100313          	li	t1,1
   10630:	00e31333          	sll	t1,t1,a4
   10634:	00492703          	lw	a4,4(s2)
   10638:	06676a63          	bltu	a4,t1,106ac <_malloc_r+0x300>
   1063c:	006776b3          	and	a3,a4,t1
   10640:	00069c63          	bnez	a3,10658 <_malloc_r+0x2ac>
   10644:	ffc7f793          	andi	a5,a5,-4
   10648:	00131313          	slli	t1,t1,0x1
   1064c:	006776b3          	and	a3,a4,t1
   10650:	00478793          	addi	a5,a5,4
   10654:	fe068ae3          	beqz	a3,10648 <_malloc_r+0x29c>
   10658:	00f00e13          	li	t3,15
   1065c:	00379693          	slli	a3,a5,0x3
   10660:	00d906b3          	add	a3,s2,a3
   10664:	00068813          	mv	a6,a3
   10668:	00078513          	mv	a0,a5
   1066c:	00c82403          	lw	s0,12(a6)
   10670:	1b041263          	bne	s0,a6,10814 <_malloc_r+0x468>
   10674:	00150513          	addi	a0,a0,1
   10678:	00357713          	andi	a4,a0,3
   1067c:	00880813          	addi	a6,a6,8
   10680:	fe0716e3          	bnez	a4,1066c <_malloc_r+0x2c0>
   10684:	0037f713          	andi	a4,a5,3
   10688:	20071463          	bnez	a4,10890 <_malloc_r+0x4e4>
   1068c:	00492703          	lw	a4,4(s2)
   10690:	fff34793          	not	a5,t1
   10694:	00f777b3          	and	a5,a4,a5
   10698:	00f92223          	sw	a5,4(s2)
   1069c:	00492703          	lw	a4,4(s2)
   106a0:	00131313          	slli	t1,t1,0x1
   106a4:	00676463          	bltu	a4,t1,106ac <_malloc_r+0x300>
   106a8:	20031863          	bnez	t1,108b8 <_malloc_r+0x50c>
   106ac:	00892b83          	lw	s7,8(s2)
   106b0:	004ba403          	lw	s0,4(s7)
   106b4:	ffc47a93          	andi	s5,s0,-4
   106b8:	009ae863          	bltu	s5,s1,106c8 <_malloc_r+0x31c>
   106bc:	409a8733          	sub	a4,s5,s1
   106c0:	00f00793          	li	a5,15
   106c4:	30e7ca63          	blt	a5,a4,109d8 <_malloc_r+0x62c>
   106c8:	8341a403          	lw	s0,-1996(gp) # 23f94 <__malloc_top_pad>
   106cc:	8241a703          	lw	a4,-2012(gp) # 23f84 <__malloc_sbrk_base>
   106d0:	fff00793          	li	a5,-1
   106d4:	00848433          	add	s0,s1,s0
   106d8:	1ef71463          	bne	a4,a5,108c0 <_malloc_r+0x514>
   106dc:	01040413          	addi	s0,s0,16
   106e0:	00040593          	mv	a1,s0
   106e4:	00098513          	mv	a0,s3
   106e8:	54c000ef          	jal	ra,10c34 <_sbrk_r>
   106ec:	fff00793          	li	a5,-1
   106f0:	00050b13          	mv	s6,a0
   106f4:	26f50863          	beq	a0,a5,10964 <_malloc_r+0x5b8>
   106f8:	015b87b3          	add	a5,s7,s5
   106fc:	00f57463          	bleu	a5,a0,10704 <_malloc_r+0x358>
   10700:	272b9263          	bne	s7,s2,10964 <_malloc_r+0x5b8>
   10704:	86418693          	addi	a3,gp,-1948 # 23fc4 <__malloc_current_mallinfo>
   10708:	0006a703          	lw	a4,0(a3)
   1070c:	86418c13          	addi	s8,gp,-1948 # 23fc4 <__malloc_current_mallinfo>
   10710:	00e40733          	add	a4,s0,a4
   10714:	00e6a023          	sw	a4,0(a3)
   10718:	1d679063          	bne	a5,s6,108d8 <_malloc_r+0x52c>
   1071c:	01479693          	slli	a3,a5,0x14
   10720:	1a069c63          	bnez	a3,108d8 <_malloc_r+0x52c>
   10724:	00892783          	lw	a5,8(s2)
   10728:	008a8433          	add	s0,s5,s0
   1072c:	00146413          	ori	s0,s0,1
   10730:	0087a223          	sw	s0,4(a5)
   10734:	000c2783          	lw	a5,0(s8)
   10738:	8301a683          	lw	a3,-2000(gp) # 23f90 <__malloc_max_sbrked_mem>
   1073c:	00f6f463          	bleu	a5,a3,10744 <_malloc_r+0x398>
   10740:	82f1a823          	sw	a5,-2000(gp) # 23f90 <__malloc_max_sbrked_mem>
   10744:	82c1a683          	lw	a3,-2004(gp) # 23f8c <_edata>
   10748:	20f6fe63          	bleu	a5,a3,10964 <_malloc_r+0x5b8>
   1074c:	82f1a623          	sw	a5,-2004(gp) # 23f8c <_edata>
   10750:	2140006f          	j	10964 <_malloc_r+0x5b8>
   10754:	00975613          	srli	a2,a4,0x9
   10758:	00400693          	li	a3,4
   1075c:	04c6e663          	bltu	a3,a2,107a8 <_malloc_r+0x3fc>
   10760:	00675693          	srli	a3,a4,0x6
   10764:	03868693          	addi	a3,a3,56
   10768:	00168613          	addi	a2,a3,1
   1076c:	00361613          	slli	a2,a2,0x3
   10770:	00c90633          	add	a2,s2,a2
   10774:	ff860513          	addi	a0,a2,-8
   10778:	00062603          	lw	a2,0(a2)
   1077c:	08c51263          	bne	a0,a2,10800 <_malloc_r+0x454>
   10780:	4026d693          	srai	a3,a3,0x2
   10784:	00100713          	li	a4,1
   10788:	00d716b3          	sll	a3,a4,a3
   1078c:	0106e6b3          	or	a3,a3,a6
   10790:	00d92223          	sw	a3,4(s2)
   10794:	00a42623          	sw	a0,12(s0)
   10798:	00c42423          	sw	a2,8(s0)
   1079c:	00852423          	sw	s0,8(a0)
   107a0:	00862623          	sw	s0,12(a2)
   107a4:	e85ff06f          	j	10628 <_malloc_r+0x27c>
   107a8:	01400693          	li	a3,20
   107ac:	00c6e663          	bltu	a3,a2,107b8 <_malloc_r+0x40c>
   107b0:	05b60693          	addi	a3,a2,91
   107b4:	fb5ff06f          	j	10768 <_malloc_r+0x3bc>
   107b8:	05400693          	li	a3,84
   107bc:	00c6e863          	bltu	a3,a2,107cc <_malloc_r+0x420>
   107c0:	00c75693          	srli	a3,a4,0xc
   107c4:	06e68693          	addi	a3,a3,110
   107c8:	fa1ff06f          	j	10768 <_malloc_r+0x3bc>
   107cc:	15400693          	li	a3,340
   107d0:	00c6e863          	bltu	a3,a2,107e0 <_malloc_r+0x434>
   107d4:	00f75693          	srli	a3,a4,0xf
   107d8:	07768693          	addi	a3,a3,119
   107dc:	f8dff06f          	j	10768 <_malloc_r+0x3bc>
   107e0:	55400513          	li	a0,1364
   107e4:	07e00693          	li	a3,126
   107e8:	f8c560e3          	bltu	a0,a2,10768 <_malloc_r+0x3bc>
   107ec:	01275693          	srli	a3,a4,0x12
   107f0:	07c68693          	addi	a3,a3,124
   107f4:	f75ff06f          	j	10768 <_malloc_r+0x3bc>
   107f8:	00862603          	lw	a2,8(a2)
   107fc:	00c50863          	beq	a0,a2,1080c <_malloc_r+0x460>
   10800:	00462683          	lw	a3,4(a2)
   10804:	ffc6f693          	andi	a3,a3,-4
   10808:	fed768e3          	bltu	a4,a3,107f8 <_malloc_r+0x44c>
   1080c:	00c62503          	lw	a0,12(a2)
   10810:	f85ff06f          	j	10794 <_malloc_r+0x3e8>
   10814:	00442703          	lw	a4,4(s0)
   10818:	00c42603          	lw	a2,12(s0)
   1081c:	ffc77713          	andi	a4,a4,-4
   10820:	409708b3          	sub	a7,a4,s1
   10824:	051e5063          	ble	a7,t3,10864 <_malloc_r+0x4b8>
   10828:	0014e793          	ori	a5,s1,1
   1082c:	00f42223          	sw	a5,4(s0)
   10830:	00842783          	lw	a5,8(s0)
   10834:	009406b3          	add	a3,s0,s1
   10838:	00e40733          	add	a4,s0,a4
   1083c:	00c7a623          	sw	a2,12(a5)
   10840:	00f62423          	sw	a5,8(a2)
   10844:	00d92a23          	sw	a3,20(s2)
   10848:	00d92823          	sw	a3,16(s2)
   1084c:	0018e793          	ori	a5,a7,1
   10850:	00b6a623          	sw	a1,12(a3)
   10854:	00b6a423          	sw	a1,8(a3)
   10858:	00f6a223          	sw	a5,4(a3)
   1085c:	01172023          	sw	a7,0(a4)
   10860:	cddff06f          	j	1053c <_malloc_r+0x190>
   10864:	0208c263          	bltz	a7,10888 <_malloc_r+0x4dc>
   10868:	00e40733          	add	a4,s0,a4
   1086c:	00472783          	lw	a5,4(a4)
   10870:	0017e793          	ori	a5,a5,1
   10874:	00f72223          	sw	a5,4(a4)
   10878:	00842783          	lw	a5,8(s0)
   1087c:	00c7a623          	sw	a2,12(a5)
   10880:	00f62423          	sw	a5,8(a2)
   10884:	cb9ff06f          	j	1053c <_malloc_r+0x190>
   10888:	00060413          	mv	s0,a2
   1088c:	de5ff06f          	j	10670 <_malloc_r+0x2c4>
   10890:	ff868713          	addi	a4,a3,-8
   10894:	0006a683          	lw	a3,0(a3)
   10898:	fff78793          	addi	a5,a5,-1
   1089c:	dee684e3          	beq	a3,a4,10684 <_malloc_r+0x2d8>
   108a0:	dfdff06f          	j	1069c <_malloc_r+0x2f0>
   108a4:	00478793          	addi	a5,a5,4
   108a8:	00131313          	slli	t1,t1,0x1
   108ac:	006776b3          	and	a3,a4,t1
   108b0:	fe068ae3          	beqz	a3,108a4 <_malloc_r+0x4f8>
   108b4:	da9ff06f          	j	1065c <_malloc_r+0x2b0>
   108b8:	00050793          	mv	a5,a0
   108bc:	ff1ff06f          	j	108ac <_malloc_r+0x500>
   108c0:	000017b7          	lui	a5,0x1
   108c4:	00f78793          	addi	a5,a5,15 # 100f <main-0xf065>
   108c8:	00f40433          	add	s0,s0,a5
   108cc:	fffff7b7          	lui	a5,0xfffff
   108d0:	00f47433          	and	s0,s0,a5
   108d4:	e0dff06f          	j	106e0 <_malloc_r+0x334>
   108d8:	8241a603          	lw	a2,-2012(gp) # 23f84 <__malloc_sbrk_base>
   108dc:	fff00693          	li	a3,-1
   108e0:	0ad61663          	bne	a2,a3,1098c <_malloc_r+0x5e0>
   108e4:	8361a223          	sw	s6,-2012(gp) # 23f84 <__malloc_sbrk_base>
   108e8:	007b7593          	andi	a1,s6,7
   108ec:	00058863          	beqz	a1,108fc <_malloc_r+0x550>
   108f0:	00800793          	li	a5,8
   108f4:	40b785b3          	sub	a1,a5,a1
   108f8:	00bb0b33          	add	s6,s6,a1
   108fc:	000017b7          	lui	a5,0x1
   10900:	00f585b3          	add	a1,a1,a5
   10904:	008b0433          	add	s0,s6,s0
   10908:	fff78793          	addi	a5,a5,-1 # fff <main-0xf075>
   1090c:	00f47433          	and	s0,s0,a5
   10910:	40858a33          	sub	s4,a1,s0
   10914:	000a0593          	mv	a1,s4
   10918:	00098513          	mv	a0,s3
   1091c:	318000ef          	jal	ra,10c34 <_sbrk_r>
   10920:	fff00793          	li	a5,-1
   10924:	00f51663          	bne	a0,a5,10930 <_malloc_r+0x584>
   10928:	000b0513          	mv	a0,s6
   1092c:	00000a13          	li	s4,0
   10930:	000c2783          	lw	a5,0(s8)
   10934:	41650533          	sub	a0,a0,s6
   10938:	01692423          	sw	s6,8(s2)
   1093c:	014787b3          	add	a5,a5,s4
   10940:	01450a33          	add	s4,a0,s4
   10944:	001a6a13          	ori	s4,s4,1
   10948:	00fc2023          	sw	a5,0(s8)
   1094c:	014b2223          	sw	s4,4(s6)
   10950:	df2b82e3          	beq	s7,s2,10734 <_malloc_r+0x388>
   10954:	00f00713          	li	a4,15
   10958:	05576263          	bltu	a4,s5,1099c <_malloc_r+0x5f0>
   1095c:	00100793          	li	a5,1
   10960:	00fb2223          	sw	a5,4(s6)
   10964:	00892783          	lw	a5,8(s2)
   10968:	0047a783          	lw	a5,4(a5)
   1096c:	ffc7f793          	andi	a5,a5,-4
   10970:	40978733          	sub	a4,a5,s1
   10974:	0097e663          	bltu	a5,s1,10980 <_malloc_r+0x5d4>
   10978:	00f00793          	li	a5,15
   1097c:	04e7ce63          	blt	a5,a4,109d8 <_malloc_r+0x62c>
   10980:	00098513          	mv	a0,s3
   10984:	14c000ef          	jal	ra,10ad0 <__malloc_unlock>
   10988:	a6dff06f          	j	103f4 <_malloc_r+0x48>
   1098c:	40fb07b3          	sub	a5,s6,a5
   10990:	00e787b3          	add	a5,a5,a4
   10994:	00fc2023          	sw	a5,0(s8)
   10998:	f51ff06f          	j	108e8 <_malloc_r+0x53c>
   1099c:	004ba783          	lw	a5,4(s7)
   109a0:	ff4a8413          	addi	s0,s5,-12
   109a4:	ff847413          	andi	s0,s0,-8
   109a8:	0017f793          	andi	a5,a5,1
   109ac:	0087e7b3          	or	a5,a5,s0
   109b0:	00fba223          	sw	a5,4(s7)
   109b4:	00500693          	li	a3,5
   109b8:	008b87b3          	add	a5,s7,s0
   109bc:	00d7a223          	sw	a3,4(a5)
   109c0:	00d7a423          	sw	a3,8(a5)
   109c4:	d68778e3          	bleu	s0,a4,10734 <_malloc_r+0x388>
   109c8:	008b8593          	addi	a1,s7,8
   109cc:	00098513          	mv	a0,s3
   109d0:	4c1020ef          	jal	ra,13690 <_free_r>
   109d4:	d61ff06f          	j	10734 <_malloc_r+0x388>
   109d8:	00892403          	lw	s0,8(s2)
   109dc:	0014e793          	ori	a5,s1,1
   109e0:	00f42223          	sw	a5,4(s0)
   109e4:	009407b3          	add	a5,s0,s1
   109e8:	00f92423          	sw	a5,8(s2)
   109ec:	aa1ff06f          	j	1048c <_malloc_r+0xe0>

000109f0 <memset>:
   109f0:	00f00813          	li	a6,15
   109f4:	00050713          	mv	a4,a0
   109f8:	02c87e63          	bleu	a2,a6,10a34 <memset+0x44>
   109fc:	00f77793          	andi	a5,a4,15
   10a00:	0a079063          	bnez	a5,10aa0 <memset+0xb0>
   10a04:	08059263          	bnez	a1,10a88 <memset+0x98>
   10a08:	ff067693          	andi	a3,a2,-16
   10a0c:	00f67613          	andi	a2,a2,15
   10a10:	00e686b3          	add	a3,a3,a4
   10a14:	00b72023          	sw	a1,0(a4)
   10a18:	00b72223          	sw	a1,4(a4)
   10a1c:	00b72423          	sw	a1,8(a4)
   10a20:	00b72623          	sw	a1,12(a4)
   10a24:	01070713          	addi	a4,a4,16
   10a28:	fed766e3          	bltu	a4,a3,10a14 <memset+0x24>
   10a2c:	00061463          	bnez	a2,10a34 <memset+0x44>
   10a30:	00008067          	ret
   10a34:	40c806b3          	sub	a3,a6,a2
   10a38:	00269693          	slli	a3,a3,0x2
   10a3c:	00000297          	auipc	t0,0x0
   10a40:	005686b3          	add	a3,a3,t0
   10a44:	00c68067          	jr	12(a3)
   10a48:	00b70723          	sb	a1,14(a4)
   10a4c:	00b706a3          	sb	a1,13(a4)
   10a50:	00b70623          	sb	a1,12(a4)
   10a54:	00b705a3          	sb	a1,11(a4)
   10a58:	00b70523          	sb	a1,10(a4)
   10a5c:	00b704a3          	sb	a1,9(a4)
   10a60:	00b70423          	sb	a1,8(a4)
   10a64:	00b703a3          	sb	a1,7(a4)
   10a68:	00b70323          	sb	a1,6(a4)
   10a6c:	00b702a3          	sb	a1,5(a4)
   10a70:	00b70223          	sb	a1,4(a4)
   10a74:	00b701a3          	sb	a1,3(a4)
   10a78:	00b70123          	sb	a1,2(a4)
   10a7c:	00b700a3          	sb	a1,1(a4)
   10a80:	00b70023          	sb	a1,0(a4)
   10a84:	00008067          	ret
   10a88:	0ff5f593          	andi	a1,a1,255
   10a8c:	00859693          	slli	a3,a1,0x8
   10a90:	00d5e5b3          	or	a1,a1,a3
   10a94:	01059693          	slli	a3,a1,0x10
   10a98:	00d5e5b3          	or	a1,a1,a3
   10a9c:	f6dff06f          	j	10a08 <memset+0x18>
   10aa0:	00279693          	slli	a3,a5,0x2
   10aa4:	00000297          	auipc	t0,0x0
   10aa8:	005686b3          	add	a3,a3,t0
   10aac:	00008293          	mv	t0,ra
   10ab0:	fa0680e7          	jalr	-96(a3)
   10ab4:	00028093          	mv	ra,t0
   10ab8:	ff078793          	addi	a5,a5,-16
   10abc:	40f70733          	sub	a4,a4,a5
   10ac0:	00f60633          	add	a2,a2,a5
   10ac4:	f6c878e3          	bleu	a2,a6,10a34 <memset+0x44>
   10ac8:	f3dff06f          	j	10a04 <memset+0x14>

00010acc <__malloc_lock>:
   10acc:	00008067          	ret

00010ad0 <__malloc_unlock>:
   10ad0:	00008067          	ret

00010ad4 <_printf_r>:
   10ad4:	fc010113          	addi	sp,sp,-64
   10ad8:	02c12423          	sw	a2,40(sp)
   10adc:	02d12623          	sw	a3,44(sp)
   10ae0:	02e12823          	sw	a4,48(sp)
   10ae4:	02f12a23          	sw	a5,52(sp)
   10ae8:	03012c23          	sw	a6,56(sp)
   10aec:	03112e23          	sw	a7,60(sp)
   10af0:	00058613          	mv	a2,a1
   10af4:	00852583          	lw	a1,8(a0)
   10af8:	02810693          	addi	a3,sp,40
   10afc:	00112e23          	sw	ra,28(sp)
   10b00:	00d12623          	sw	a3,12(sp)
   10b04:	194000ef          	jal	ra,10c98 <_vfprintf_r>
   10b08:	01c12083          	lw	ra,28(sp)
   10b0c:	04010113          	addi	sp,sp,64
   10b10:	00008067          	ret

00010b14 <printf>:
   10b14:	fc010113          	addi	sp,sp,-64
   10b18:	02f12a23          	sw	a5,52(sp)
   10b1c:	8201a783          	lw	a5,-2016(gp) # 23f80 <_impure_ptr>
   10b20:	02c12423          	sw	a2,40(sp)
   10b24:	02d12623          	sw	a3,44(sp)
   10b28:	02b12223          	sw	a1,36(sp)
   10b2c:	02e12823          	sw	a4,48(sp)
   10b30:	03012c23          	sw	a6,56(sp)
   10b34:	03112e23          	sw	a7,60(sp)
   10b38:	0087a583          	lw	a1,8(a5)
   10b3c:	02410693          	addi	a3,sp,36
   10b40:	00050613          	mv	a2,a0
   10b44:	00078513          	mv	a0,a5
   10b48:	00112e23          	sw	ra,28(sp)
   10b4c:	00d12623          	sw	a3,12(sp)
   10b50:	148000ef          	jal	ra,10c98 <_vfprintf_r>
   10b54:	01c12083          	lw	ra,28(sp)
   10b58:	04010113          	addi	sp,sp,64
   10b5c:	00008067          	ret

00010b60 <_puts_r>:
   10b60:	fc010113          	addi	sp,sp,-64
   10b64:	02812c23          	sw	s0,56(sp)
   10b68:	00050413          	mv	s0,a0
   10b6c:	00058513          	mv	a0,a1
   10b70:	00b12623          	sw	a1,12(sp)
   10b74:	02112e23          	sw	ra,60(sp)
   10b78:	104000ef          	jal	ra,10c7c <strlen>
   10b7c:	000217b7          	lui	a5,0x21
   10b80:	73878793          	addi	a5,a5,1848 # 21738 <__clzsi2+0xb4>
   10b84:	02f12423          	sw	a5,40(sp)
   10b88:	00100793          	li	a5,1
   10b8c:	02f12623          	sw	a5,44(sp)
   10b90:	02010793          	addi	a5,sp,32
   10b94:	00c12583          	lw	a1,12(sp)
   10b98:	00f12a23          	sw	a5,20(sp)
   10b9c:	00200793          	li	a5,2
   10ba0:	00f12c23          	sw	a5,24(sp)
   10ba4:	03842783          	lw	a5,56(s0)
   10ba8:	02a12223          	sw	a0,36(sp)
   10bac:	00150513          	addi	a0,a0,1
   10bb0:	02b12023          	sw	a1,32(sp)
   10bb4:	00a12e23          	sw	a0,28(sp)
   10bb8:	00842583          	lw	a1,8(s0)
   10bbc:	00079a63          	bnez	a5,10bd0 <_puts_r+0x70>
   10bc0:	00040513          	mv	a0,s0
   10bc4:	00b12623          	sw	a1,12(sp)
   10bc8:	01d020ef          	jal	ra,133e4 <__sinit>
   10bcc:	00c12583          	lw	a1,12(sp)
   10bd0:	00c59783          	lh	a5,12(a1)
   10bd4:	01279713          	slli	a4,a5,0x12
   10bd8:	02074263          	bltz	a4,10bfc <_puts_r+0x9c>
   10bdc:	000026b7          	lui	a3,0x2
   10be0:	0645a703          	lw	a4,100(a1)
   10be4:	00d7e7b3          	or	a5,a5,a3
   10be8:	00f59623          	sh	a5,12(a1)
   10bec:	ffffe7b7          	lui	a5,0xffffe
   10bf0:	fff78793          	addi	a5,a5,-1 # ffffdfff <__global_pointer$+0xfffd989f>
   10bf4:	00f777b3          	and	a5,a4,a5
   10bf8:	06f5a223          	sw	a5,100(a1)
   10bfc:	01410613          	addi	a2,sp,20
   10c00:	00040513          	mv	a0,s0
   10c04:	4e9020ef          	jal	ra,138ec <__sfvwrite_r>
   10c08:	fff00793          	li	a5,-1
   10c0c:	00051463          	bnez	a0,10c14 <_puts_r+0xb4>
   10c10:	00a00793          	li	a5,10
   10c14:	03c12083          	lw	ra,60(sp)
   10c18:	03812403          	lw	s0,56(sp)
   10c1c:	00078513          	mv	a0,a5
   10c20:	04010113          	addi	sp,sp,64
   10c24:	00008067          	ret

00010c28 <puts>:
   10c28:	00050593          	mv	a1,a0
   10c2c:	8201a503          	lw	a0,-2016(gp) # 23f80 <_impure_ptr>
   10c30:	f31ff06f          	j	10b60 <_puts_r>

00010c34 <_sbrk_r>:
   10c34:	ff010113          	addi	sp,sp,-16
   10c38:	00812423          	sw	s0,8(sp)
   10c3c:	00912223          	sw	s1,4(sp)
   10c40:	00050493          	mv	s1,a0
   10c44:	00058513          	mv	a0,a1
   10c48:	00112623          	sw	ra,12(sp)
   10c4c:	8801a623          	sw	zero,-1908(gp) # 23fec <errno>
   10c50:	1850b0ef          	jal	ra,1c5d4 <sbrk>
   10c54:	fff00793          	li	a5,-1
   10c58:	00f51863          	bne	a0,a5,10c68 <_sbrk_r+0x34>
   10c5c:	88c1a783          	lw	a5,-1908(gp) # 23fec <errno>
   10c60:	00078463          	beqz	a5,10c68 <_sbrk_r+0x34>
   10c64:	00f4a023          	sw	a5,0(s1)
   10c68:	00c12083          	lw	ra,12(sp)
   10c6c:	00812403          	lw	s0,8(sp)
   10c70:	00412483          	lw	s1,4(sp)
   10c74:	01010113          	addi	sp,sp,16
   10c78:	00008067          	ret

00010c7c <strlen>:
   10c7c:	00050793          	mv	a5,a0
   10c80:	00178793          	addi	a5,a5,1
   10c84:	fff7c703          	lbu	a4,-1(a5)
   10c88:	fe071ce3          	bnez	a4,10c80 <strlen+0x4>
   10c8c:	40a78533          	sub	a0,a5,a0
   10c90:	fff50513          	addi	a0,a0,-1
   10c94:	00008067          	ret

00010c98 <_vfprintf_r>:
   10c98:	e1010113          	addi	sp,sp,-496
   10c9c:	1e112623          	sw	ra,492(sp)
   10ca0:	1e912223          	sw	s1,484(sp)
   10ca4:	1f212023          	sw	s2,480(sp)
   10ca8:	1d312e23          	sw	s3,476(sp)
   10cac:	1d812423          	sw	s8,456(sp)
   10cb0:	00058913          	mv	s2,a1
   10cb4:	00060493          	mv	s1,a2
   10cb8:	00068c13          	mv	s8,a3
   10cbc:	1e812423          	sw	s0,488(sp)
   10cc0:	1d412c23          	sw	s4,472(sp)
   10cc4:	1d512a23          	sw	s5,468(sp)
   10cc8:	1d612823          	sw	s6,464(sp)
   10ccc:	1d712623          	sw	s7,460(sp)
   10cd0:	1d912223          	sw	s9,452(sp)
   10cd4:	1da12023          	sw	s10,448(sp)
   10cd8:	1bb12e23          	sw	s11,444(sp)
   10cdc:	00050993          	mv	s3,a0
   10ce0:	244050ef          	jal	ra,15f24 <_localeconv_r>
   10ce4:	00052783          	lw	a5,0(a0)
   10ce8:	00078513          	mv	a0,a5
   10cec:	02f12c23          	sw	a5,56(sp)
   10cf0:	f8dff0ef          	jal	ra,10c7c <strlen>
   10cf4:	02a12223          	sw	a0,36(sp)
   10cf8:	0e012823          	sw	zero,240(sp)
   10cfc:	0e012a23          	sw	zero,244(sp)
   10d00:	0e012c23          	sw	zero,248(sp)
   10d04:	0e012e23          	sw	zero,252(sp)
   10d08:	00098a63          	beqz	s3,10d1c <_vfprintf_r+0x84>
   10d0c:	0389a783          	lw	a5,56(s3)
   10d10:	00079663          	bnez	a5,10d1c <_vfprintf_r+0x84>
   10d14:	00098513          	mv	a0,s3
   10d18:	6cc020ef          	jal	ra,133e4 <__sinit>
   10d1c:	00c91783          	lh	a5,12(s2)
   10d20:	01279713          	slli	a4,a5,0x12
   10d24:	02074263          	bltz	a4,10d48 <_vfprintf_r+0xb0>
   10d28:	000026b7          	lui	a3,0x2
   10d2c:	06492703          	lw	a4,100(s2)
   10d30:	00d7e7b3          	or	a5,a5,a3
   10d34:	00f91623          	sh	a5,12(s2)
   10d38:	ffffe7b7          	lui	a5,0xffffe
   10d3c:	fff78793          	addi	a5,a5,-1 # ffffdfff <__global_pointer$+0xfffd989f>
   10d40:	00f777b3          	and	a5,a4,a5
   10d44:	06f92223          	sw	a5,100(s2)
   10d48:	00c95783          	lhu	a5,12(s2)
   10d4c:	0087f793          	andi	a5,a5,8
   10d50:	06078e63          	beqz	a5,10dcc <_vfprintf_r+0x134>
   10d54:	01092783          	lw	a5,16(s2)
   10d58:	06078a63          	beqz	a5,10dcc <_vfprintf_r+0x134>
   10d5c:	00c95783          	lhu	a5,12(s2)
   10d60:	00a00713          	li	a4,10
   10d64:	01a7f793          	andi	a5,a5,26
   10d68:	08e79063          	bne	a5,a4,10de8 <_vfprintf_r+0x150>
   10d6c:	00e91783          	lh	a5,14(s2)
   10d70:	0607cc63          	bltz	a5,10de8 <_vfprintf_r+0x150>
   10d74:	000c0693          	mv	a3,s8
   10d78:	00048613          	mv	a2,s1
   10d7c:	00090593          	mv	a1,s2
   10d80:	00098513          	mv	a0,s3
   10d84:	745010ef          	jal	ra,12cc8 <__sbprintf>
   10d88:	02a12423          	sw	a0,40(sp)
   10d8c:	1ec12083          	lw	ra,492(sp)
   10d90:	1e812403          	lw	s0,488(sp)
   10d94:	02812503          	lw	a0,40(sp)
   10d98:	1e412483          	lw	s1,484(sp)
   10d9c:	1e012903          	lw	s2,480(sp)
   10da0:	1dc12983          	lw	s3,476(sp)
   10da4:	1d812a03          	lw	s4,472(sp)
   10da8:	1d412a83          	lw	s5,468(sp)
   10dac:	1d012b03          	lw	s6,464(sp)
   10db0:	1cc12b83          	lw	s7,460(sp)
   10db4:	1c812c03          	lw	s8,456(sp)
   10db8:	1c412c83          	lw	s9,452(sp)
   10dbc:	1c012d03          	lw	s10,448(sp)
   10dc0:	1bc12d83          	lw	s11,444(sp)
   10dc4:	1f010113          	addi	sp,sp,496
   10dc8:	00008067          	ret
   10dcc:	00090593          	mv	a1,s2
   10dd0:	00098513          	mv	a0,s3
   10dd4:	7b1010ef          	jal	ra,12d84 <__swsetup_r>
   10dd8:	f80502e3          	beqz	a0,10d5c <_vfprintf_r+0xc4>
   10ddc:	fff00793          	li	a5,-1
   10de0:	02f12423          	sw	a5,40(sp)
   10de4:	fa9ff06f          	j	10d8c <_vfprintf_r+0xf4>
   10de8:	000217b7          	lui	a5,0x21
   10dec:	73c78793          	addi	a5,a5,1852 # 2173c <__clzsi2+0xb8>
   10df0:	06f12023          	sw	a5,96(sp)
   10df4:	000227b7          	lui	a5,0x22
   10df8:	10c10893          	addi	a7,sp,268
   10dfc:	8b878793          	addi	a5,a5,-1864 # 218b8 <zeroes.4377>
   10e00:	0f112223          	sw	a7,228(sp)
   10e04:	0e012623          	sw	zero,236(sp)
   10e08:	0e012423          	sw	zero,232(sp)
   10e0c:	00000a13          	li	s4,0
   10e10:	00088d13          	mv	s10,a7
   10e14:	04012223          	sw	zero,68(sp)
   10e18:	04012023          	sw	zero,64(sp)
   10e1c:	00012a23          	sw	zero,20(sp)
   10e20:	02012a23          	sw	zero,52(sp)
   10e24:	02012e23          	sw	zero,60(sp)
   10e28:	02012423          	sw	zero,40(sp)
   10e2c:	00f12c23          	sw	a5,24(sp)
   10e30:	00048413          	mv	s0,s1
   10e34:	02500713          	li	a4,37
   10e38:	00044783          	lbu	a5,0(s0)
   10e3c:	00078463          	beqz	a5,10e44 <_vfprintf_r+0x1ac>
   10e40:	0ce79263          	bne	a5,a4,10f04 <_vfprintf_r+0x26c>
   10e44:	40940ab3          	sub	s5,s0,s1
   10e48:	040a8a63          	beqz	s5,10e9c <_vfprintf_r+0x204>
   10e4c:	0ec12783          	lw	a5,236(sp)
   10e50:	009d2023          	sw	s1,0(s10)
   10e54:	015d2223          	sw	s5,4(s10)
   10e58:	015787b3          	add	a5,a5,s5
   10e5c:	0ef12623          	sw	a5,236(sp)
   10e60:	0e812783          	lw	a5,232(sp)
   10e64:	00700713          	li	a4,7
   10e68:	008d0d13          	addi	s10,s10,8
   10e6c:	00178793          	addi	a5,a5,1
   10e70:	0ef12423          	sw	a5,232(sp)
   10e74:	00f75e63          	ble	a5,a4,10e90 <_vfprintf_r+0x1f8>
   10e78:	0e410613          	addi	a2,sp,228
   10e7c:	00090593          	mv	a1,s2
   10e80:	00098513          	mv	a0,s3
   10e84:	759080ef          	jal	ra,19ddc <__sprint_r>
   10e88:	78051063          	bnez	a0,11608 <_vfprintf_r+0x970>
   10e8c:	10c10d13          	addi	s10,sp,268
   10e90:	02812783          	lw	a5,40(sp)
   10e94:	015787b3          	add	a5,a5,s5
   10e98:	02f12423          	sw	a5,40(sp)
   10e9c:	00044783          	lbu	a5,0(s0)
   10ea0:	00079463          	bnez	a5,10ea8 <_vfprintf_r+0x210>
   10ea4:	5f10106f          	j	12c94 <_vfprintf_r+0x1ffc>
   10ea8:	00140793          	addi	a5,s0,1
   10eac:	02f12023          	sw	a5,32(sp)
   10eb0:	0c0103a3          	sb	zero,199(sp)
   10eb4:	fff00b13          	li	s6,-1
   10eb8:	02012623          	sw	zero,44(sp)
   10ebc:	00000413          	li	s0,0
   10ec0:	00900a93          	li	s5,9
   10ec4:	05a00b93          	li	s7,90
   10ec8:	02012783          	lw	a5,32(sp)
   10ecc:	0007c783          	lbu	a5,0(a5)
   10ed0:	00f12623          	sw	a5,12(sp)
   10ed4:	02012783          	lw	a5,32(sp)
   10ed8:	00178793          	addi	a5,a5,1
   10edc:	02f12023          	sw	a5,32(sp)
   10ee0:	00c12783          	lw	a5,12(sp)
   10ee4:	fe078793          	addi	a5,a5,-32
   10ee8:	00fbf463          	bleu	a5,s7,10ef0 <_vfprintf_r+0x258>
   10eec:	2ac0106f          	j	12198 <_vfprintf_r+0x1500>
   10ef0:	06012703          	lw	a4,96(sp)
   10ef4:	00279793          	slli	a5,a5,0x2
   10ef8:	00e787b3          	add	a5,a5,a4
   10efc:	0007a783          	lw	a5,0(a5)
   10f00:	00078067          	jr	a5
   10f04:	00140413          	addi	s0,s0,1
   10f08:	f31ff06f          	j	10e38 <_vfprintf_r+0x1a0>
   10f0c:	000227b7          	lui	a5,0x22
   10f10:	92478793          	addi	a5,a5,-1756 # 21924 <zeroes.4377+0x6c>
   10f14:	04f12223          	sw	a5,68(sp)
   10f18:	02047793          	andi	a5,s0,32
   10f1c:	00079463          	bnez	a5,10f24 <_vfprintf_r+0x28c>
   10f20:	0ac0106f          	j	11fcc <_vfprintf_r+0x1334>
   10f24:	007c0c13          	addi	s8,s8,7
   10f28:	ff8c7c13          	andi	s8,s8,-8
   10f2c:	008c0793          	addi	a5,s8,8
   10f30:	000c2c83          	lw	s9,0(s8)
   10f34:	004c2c03          	lw	s8,4(s8)
   10f38:	00f12e23          	sw	a5,28(sp)
   10f3c:	00147793          	andi	a5,s0,1
   10f40:	02078063          	beqz	a5,10f60 <_vfprintf_r+0x2c8>
   10f44:	018ce7b3          	or	a5,s9,s8
   10f48:	00078c63          	beqz	a5,10f60 <_vfprintf_r+0x2c8>
   10f4c:	03000793          	li	a5,48
   10f50:	0cf10423          	sb	a5,200(sp)
   10f54:	00c14783          	lbu	a5,12(sp)
   10f58:	00246413          	ori	s0,s0,2
   10f5c:	0cf104a3          	sb	a5,201(sp)
   10f60:	bff47413          	andi	s0,s0,-1025
   10f64:	00200793          	li	a5,2
   10f68:	7010006f          	j	11e68 <_vfprintf_r+0x11d0>
   10f6c:	00098513          	mv	a0,s3
   10f70:	7b5040ef          	jal	ra,15f24 <_localeconv_r>
   10f74:	00452783          	lw	a5,4(a0)
   10f78:	00078513          	mv	a0,a5
   10f7c:	02f12e23          	sw	a5,60(sp)
   10f80:	cfdff0ef          	jal	ra,10c7c <strlen>
   10f84:	02a12a23          	sw	a0,52(sp)
   10f88:	00098513          	mv	a0,s3
   10f8c:	799040ef          	jal	ra,15f24 <_localeconv_r>
   10f90:	00852783          	lw	a5,8(a0)
   10f94:	00f12a23          	sw	a5,20(sp)
   10f98:	03412783          	lw	a5,52(sp)
   10f9c:	f20784e3          	beqz	a5,10ec4 <_vfprintf_r+0x22c>
   10fa0:	01412783          	lw	a5,20(sp)
   10fa4:	f20780e3          	beqz	a5,10ec4 <_vfprintf_r+0x22c>
   10fa8:	0007c783          	lbu	a5,0(a5)
   10fac:	f0078ce3          	beqz	a5,10ec4 <_vfprintf_r+0x22c>
   10fb0:	40046413          	ori	s0,s0,1024
   10fb4:	f11ff06f          	j	10ec4 <_vfprintf_r+0x22c>
   10fb8:	0c714783          	lbu	a5,199(sp)
   10fbc:	f00794e3          	bnez	a5,10ec4 <_vfprintf_r+0x22c>
   10fc0:	02000793          	li	a5,32
   10fc4:	0cf103a3          	sb	a5,199(sp)
   10fc8:	efdff06f          	j	10ec4 <_vfprintf_r+0x22c>
   10fcc:	00146413          	ori	s0,s0,1
   10fd0:	ef5ff06f          	j	10ec4 <_vfprintf_r+0x22c>
   10fd4:	000c2783          	lw	a5,0(s8)
   10fd8:	004c0c13          	addi	s8,s8,4
   10fdc:	02f12623          	sw	a5,44(sp)
   10fe0:	ee07d2e3          	bgez	a5,10ec4 <_vfprintf_r+0x22c>
   10fe4:	40f007b3          	neg	a5,a5
   10fe8:	02f12623          	sw	a5,44(sp)
   10fec:	00446413          	ori	s0,s0,4
   10ff0:	ed5ff06f          	j	10ec4 <_vfprintf_r+0x22c>
   10ff4:	02b00793          	li	a5,43
   10ff8:	fcdff06f          	j	10fc4 <_vfprintf_r+0x32c>
   10ffc:	02012783          	lw	a5,32(sp)
   11000:	02a00713          	li	a4,42
   11004:	00178c93          	addi	s9,a5,1
   11008:	0007c783          	lbu	a5,0(a5)
   1100c:	00f12623          	sw	a5,12(sp)
   11010:	04e79863          	bne	a5,a4,11060 <_vfprintf_r+0x3c8>
   11014:	000c2b03          	lw	s6,0(s8)
   11018:	004c0793          	addi	a5,s8,4
   1101c:	000b5463          	bgez	s6,11024 <_vfprintf_r+0x38c>
   11020:	fff00b13          	li	s6,-1
   11024:	00078c13          	mv	s8,a5
   11028:	03912023          	sw	s9,32(sp)
   1102c:	e99ff06f          	j	10ec4 <_vfprintf_r+0x22c>
   11030:	000b0513          	mv	a0,s6
   11034:	00a00593          	li	a1,10
   11038:	574100ef          	jal	ra,215ac <__mulsi3>
   1103c:	001c8c93          	addi	s9,s9,1
   11040:	fffcc783          	lbu	a5,-1(s9)
   11044:	01b50b33          	add	s6,a0,s11
   11048:	00f12623          	sw	a5,12(sp)
   1104c:	00c12783          	lw	a5,12(sp)
   11050:	fd078d93          	addi	s11,a5,-48
   11054:	fdbafee3          	bleu	s11,s5,11030 <_vfprintf_r+0x398>
   11058:	03912023          	sw	s9,32(sp)
   1105c:	e85ff06f          	j	10ee0 <_vfprintf_r+0x248>
   11060:	00000b13          	li	s6,0
   11064:	fe9ff06f          	j	1104c <_vfprintf_r+0x3b4>
   11068:	08046413          	ori	s0,s0,128
   1106c:	e59ff06f          	j	10ec4 <_vfprintf_r+0x22c>
   11070:	02012c83          	lw	s9,32(sp)
   11074:	02012623          	sw	zero,44(sp)
   11078:	02c12503          	lw	a0,44(sp)
   1107c:	00a00593          	li	a1,10
   11080:	001c8c93          	addi	s9,s9,1
   11084:	528100ef          	jal	ra,215ac <__mulsi3>
   11088:	00c12783          	lw	a5,12(sp)
   1108c:	fd078793          	addi	a5,a5,-48
   11090:	00a787b3          	add	a5,a5,a0
   11094:	02f12623          	sw	a5,44(sp)
   11098:	fffcc783          	lbu	a5,-1(s9)
   1109c:	00f12623          	sw	a5,12(sp)
   110a0:	fd078793          	addi	a5,a5,-48
   110a4:	fcfafae3          	bleu	a5,s5,11078 <_vfprintf_r+0x3e0>
   110a8:	fb1ff06f          	j	11058 <_vfprintf_r+0x3c0>
   110ac:	00846413          	ori	s0,s0,8
   110b0:	e15ff06f          	j	10ec4 <_vfprintf_r+0x22c>
   110b4:	02012783          	lw	a5,32(sp)
   110b8:	0007c703          	lbu	a4,0(a5)
   110bc:	06800793          	li	a5,104
   110c0:	00f71c63          	bne	a4,a5,110d8 <_vfprintf_r+0x440>
   110c4:	02012783          	lw	a5,32(sp)
   110c8:	20046413          	ori	s0,s0,512
   110cc:	00178793          	addi	a5,a5,1
   110d0:	02f12023          	sw	a5,32(sp)
   110d4:	df1ff06f          	j	10ec4 <_vfprintf_r+0x22c>
   110d8:	04046413          	ori	s0,s0,64
   110dc:	de9ff06f          	j	10ec4 <_vfprintf_r+0x22c>
   110e0:	02012783          	lw	a5,32(sp)
   110e4:	0007c703          	lbu	a4,0(a5)
   110e8:	06c00793          	li	a5,108
   110ec:	00f71c63          	bne	a4,a5,11104 <_vfprintf_r+0x46c>
   110f0:	02012783          	lw	a5,32(sp)
   110f4:	00178793          	addi	a5,a5,1
   110f8:	02f12023          	sw	a5,32(sp)
   110fc:	02046413          	ori	s0,s0,32
   11100:	dc5ff06f          	j	10ec4 <_vfprintf_r+0x22c>
   11104:	01046413          	ori	s0,s0,16
   11108:	dbdff06f          	j	10ec4 <_vfprintf_r+0x22c>
   1110c:	004c0793          	addi	a5,s8,4
   11110:	00f12e23          	sw	a5,28(sp)
   11114:	000c2783          	lw	a5,0(s8)
   11118:	0c0103a3          	sb	zero,199(sp)
   1111c:	14f10623          	sb	a5,332(sp)
   11120:	00012823          	sw	zero,16(sp)
   11124:	00100b13          	li	s6,1
   11128:	00000a93          	li	s5,0
   1112c:	00000c13          	li	s8,0
   11130:	00000b93          	li	s7,0
   11134:	00000c93          	li	s9,0
   11138:	14c10493          	addi	s1,sp,332
   1113c:	03512823          	sw	s5,48(sp)
   11140:	016ad463          	ble	s6,s5,11148 <_vfprintf_r+0x4b0>
   11144:	03612823          	sw	s6,48(sp)
   11148:	0c714703          	lbu	a4,199(sp)
   1114c:	00070863          	beqz	a4,1115c <_vfprintf_r+0x4c4>
   11150:	03012783          	lw	a5,48(sp)
   11154:	00178793          	addi	a5,a5,1
   11158:	02f12823          	sw	a5,48(sp)
   1115c:	00247d93          	andi	s11,s0,2
   11160:	000d8863          	beqz	s11,11170 <_vfprintf_r+0x4d8>
   11164:	03012783          	lw	a5,48(sp)
   11168:	00278793          	addi	a5,a5,2
   1116c:	02f12823          	sw	a5,48(sp)
   11170:	08447793          	andi	a5,s0,132
   11174:	04f12423          	sw	a5,72(sp)
   11178:	06079c63          	bnez	a5,111f0 <_vfprintf_r+0x558>
   1117c:	02c12783          	lw	a5,44(sp)
   11180:	03012703          	lw	a4,48(sp)
   11184:	40e78733          	sub	a4,a5,a4
   11188:	06e05463          	blez	a4,111f0 <_vfprintf_r+0x558>
   1118c:	00022e37          	lui	t3,0x22
   11190:	01000e93          	li	t4,16
   11194:	8a8e0e13          	addi	t3,t3,-1880 # 218a8 <blanks.4376>
   11198:	00700f13          	li	t5,7
   1119c:	0e812683          	lw	a3,232(sp)
   111a0:	01cd2023          	sw	t3,0(s10)
   111a4:	0ec12603          	lw	a2,236(sp)
   111a8:	00168693          	addi	a3,a3,1 # 2001 <main-0xe073>
   111ac:	008d0593          	addi	a1,s10,8
   111b0:	00eed463          	ble	a4,t4,111b8 <_vfprintf_r+0x520>
   111b4:	0000106f          	j	121b4 <_vfprintf_r+0x151c>
   111b8:	00ed2223          	sw	a4,4(s10)
   111bc:	00c70733          	add	a4,a4,a2
   111c0:	0ee12623          	sw	a4,236(sp)
   111c4:	0ed12423          	sw	a3,232(sp)
   111c8:	00700713          	li	a4,7
   111cc:	00058d13          	mv	s10,a1
   111d0:	02d75063          	ble	a3,a4,111f0 <_vfprintf_r+0x558>
   111d4:	0e410613          	addi	a2,sp,228
   111d8:	00090593          	mv	a1,s2
   111dc:	00098513          	mv	a0,s3
   111e0:	3fd080ef          	jal	ra,19ddc <__sprint_r>
   111e4:	00050463          	beqz	a0,111ec <_vfprintf_r+0x554>
   111e8:	2490106f          	j	12c30 <_vfprintf_r+0x1f98>
   111ec:	10c10d13          	addi	s10,sp,268
   111f0:	0c714703          	lbu	a4,199(sp)
   111f4:	04070a63          	beqz	a4,11248 <_vfprintf_r+0x5b0>
   111f8:	0c710713          	addi	a4,sp,199
   111fc:	00ed2023          	sw	a4,0(s10)
   11200:	00100713          	li	a4,1
   11204:	00ed2223          	sw	a4,4(s10)
   11208:	0ec12703          	lw	a4,236(sp)
   1120c:	00700693          	li	a3,7
   11210:	008d0d13          	addi	s10,s10,8
   11214:	00170713          	addi	a4,a4,1
   11218:	0ee12623          	sw	a4,236(sp)
   1121c:	0e812703          	lw	a4,232(sp)
   11220:	00170713          	addi	a4,a4,1
   11224:	0ee12423          	sw	a4,232(sp)
   11228:	02e6d063          	ble	a4,a3,11248 <_vfprintf_r+0x5b0>
   1122c:	0e410613          	addi	a2,sp,228
   11230:	00090593          	mv	a1,s2
   11234:	00098513          	mv	a0,s3
   11238:	3a5080ef          	jal	ra,19ddc <__sprint_r>
   1123c:	00050463          	beqz	a0,11244 <_vfprintf_r+0x5ac>
   11240:	1f10106f          	j	12c30 <_vfprintf_r+0x1f98>
   11244:	10c10d13          	addi	s10,sp,268
   11248:	040d8a63          	beqz	s11,1129c <_vfprintf_r+0x604>
   1124c:	0c810713          	addi	a4,sp,200
   11250:	00ed2023          	sw	a4,0(s10)
   11254:	00200713          	li	a4,2
   11258:	00ed2223          	sw	a4,4(s10)
   1125c:	0ec12703          	lw	a4,236(sp)
   11260:	00700693          	li	a3,7
   11264:	008d0d13          	addi	s10,s10,8
   11268:	00270713          	addi	a4,a4,2
   1126c:	0ee12623          	sw	a4,236(sp)
   11270:	0e812703          	lw	a4,232(sp)
   11274:	00170713          	addi	a4,a4,1
   11278:	0ee12423          	sw	a4,232(sp)
   1127c:	02e6d063          	ble	a4,a3,1129c <_vfprintf_r+0x604>
   11280:	0e410613          	addi	a2,sp,228
   11284:	00090593          	mv	a1,s2
   11288:	00098513          	mv	a0,s3
   1128c:	351080ef          	jal	ra,19ddc <__sprint_r>
   11290:	00050463          	beqz	a0,11298 <_vfprintf_r+0x600>
   11294:	19d0106f          	j	12c30 <_vfprintf_r+0x1f98>
   11298:	10c10d13          	addi	s10,sp,268
   1129c:	04812783          	lw	a5,72(sp)
   112a0:	08000713          	li	a4,128
   112a4:	06e79863          	bne	a5,a4,11314 <_vfprintf_r+0x67c>
   112a8:	02c12783          	lw	a5,44(sp)
   112ac:	03012703          	lw	a4,48(sp)
   112b0:	40e78db3          	sub	s11,a5,a4
   112b4:	07b05063          	blez	s11,11314 <_vfprintf_r+0x67c>
   112b8:	01000793          	li	a5,16
   112bc:	00700e13          	li	t3,7
   112c0:	0e812703          	lw	a4,232(sp)
   112c4:	0ec12683          	lw	a3,236(sp)
   112c8:	008d0613          	addi	a2,s10,8
   112cc:	00170713          	addi	a4,a4,1
   112d0:	73b7cee3          	blt	a5,s11,1220c <_vfprintf_r+0x1574>
   112d4:	01812783          	lw	a5,24(sp)
   112d8:	01bd2223          	sw	s11,4(s10)
   112dc:	00dd8db3          	add	s11,s11,a3
   112e0:	00fd2023          	sw	a5,0(s10)
   112e4:	0fb12623          	sw	s11,236(sp)
   112e8:	0ee12423          	sw	a4,232(sp)
   112ec:	00700693          	li	a3,7
   112f0:	00060d13          	mv	s10,a2
   112f4:	02e6d063          	ble	a4,a3,11314 <_vfprintf_r+0x67c>
   112f8:	0e410613          	addi	a2,sp,228
   112fc:	00090593          	mv	a1,s2
   11300:	00098513          	mv	a0,s3
   11304:	2d9080ef          	jal	ra,19ddc <__sprint_r>
   11308:	00050463          	beqz	a0,11310 <_vfprintf_r+0x678>
   1130c:	1250106f          	j	12c30 <_vfprintf_r+0x1f98>
   11310:	10c10d13          	addi	s10,sp,268
   11314:	416a8ab3          	sub	s5,s5,s6
   11318:	07505063          	blez	s5,11378 <_vfprintf_r+0x6e0>
   1131c:	01000d93          	li	s11,16
   11320:	00700813          	li	a6,7
   11324:	01812783          	lw	a5,24(sp)
   11328:	0e812703          	lw	a4,232(sp)
   1132c:	0ec12683          	lw	a3,236(sp)
   11330:	00fd2023          	sw	a5,0(s10)
   11334:	00170713          	addi	a4,a4,1
   11338:	008d0613          	addi	a2,s10,8
   1133c:	735dc0e3          	blt	s11,s5,1225c <_vfprintf_r+0x15c4>
   11340:	015d2223          	sw	s5,4(s10)
   11344:	00da8ab3          	add	s5,s5,a3
   11348:	0f512623          	sw	s5,236(sp)
   1134c:	0ee12423          	sw	a4,232(sp)
   11350:	00700693          	li	a3,7
   11354:	00060d13          	mv	s10,a2
   11358:	02e6d063          	ble	a4,a3,11378 <_vfprintf_r+0x6e0>
   1135c:	0e410613          	addi	a2,sp,228
   11360:	00090593          	mv	a1,s2
   11364:	00098513          	mv	a0,s3
   11368:	275080ef          	jal	ra,19ddc <__sprint_r>
   1136c:	00050463          	beqz	a0,11374 <_vfprintf_r+0x6dc>
   11370:	0c10106f          	j	12c30 <_vfprintf_r+0x1f98>
   11374:	10c10d13          	addi	s10,sp,268
   11378:	10047713          	andi	a4,s0,256
   1137c:	0ec12d83          	lw	s11,236(sp)
   11380:	70071ee3          	bnez	a4,1229c <_vfprintf_r+0x1604>
   11384:	0e812783          	lw	a5,232(sp)
   11388:	01bb0333          	add	t1,s6,s11
   1138c:	009d2023          	sw	s1,0(s10)
   11390:	00178793          	addi	a5,a5,1
   11394:	016d2223          	sw	s6,4(s10)
   11398:	0e612623          	sw	t1,236(sp)
   1139c:	0ef12423          	sw	a5,232(sp)
   113a0:	00700713          	li	a4,7
   113a4:	008d0d13          	addi	s10,s10,8
   113a8:	00f74463          	blt	a4,a5,113b0 <_vfprintf_r+0x718>
   113ac:	1b80106f          	j	12564 <_vfprintf_r+0x18cc>
   113b0:	0e410613          	addi	a2,sp,228
   113b4:	00090593          	mv	a1,s2
   113b8:	00098513          	mv	a0,s3
   113bc:	221080ef          	jal	ra,19ddc <__sprint_r>
   113c0:	00050463          	beqz	a0,113c8 <_vfprintf_r+0x730>
   113c4:	06d0106f          	j	12c30 <_vfprintf_r+0x1f98>
   113c8:	10c10d13          	addi	s10,sp,268
   113cc:	1980106f          	j	12564 <_vfprintf_r+0x18cc>
   113d0:	01046413          	ori	s0,s0,16
   113d4:	02047793          	andi	a5,s0,32
   113d8:	04078e63          	beqz	a5,11434 <_vfprintf_r+0x79c>
   113dc:	007c0c13          	addi	s8,s8,7
   113e0:	ff8c7c13          	andi	s8,s8,-8
   113e4:	008c0793          	addi	a5,s8,8
   113e8:	000c2c83          	lw	s9,0(s8)
   113ec:	004c2c03          	lw	s8,4(s8)
   113f0:	00f12e23          	sw	a5,28(sp)
   113f4:	000c5e63          	bgez	s8,11410 <_vfprintf_r+0x778>
   113f8:	41900cb3          	neg	s9,s9
   113fc:	019037b3          	snez	a5,s9
   11400:	41800c33          	neg	s8,s8
   11404:	40fc0c33          	sub	s8,s8,a5
   11408:	02d00793          	li	a5,45
   1140c:	0cf103a3          	sb	a5,199(sp)
   11410:	fff00793          	li	a5,-1
   11414:	3efb1ae3          	bne	s6,a5,12008 <_vfprintf_r+0x1370>
   11418:	460c1ce3          	bnez	s8,12090 <_vfprintf_r+0x13f8>
   1141c:	00900793          	li	a5,9
   11420:	4797e8e3          	bltu	a5,s9,12090 <_vfprintf_r+0x13f8>
   11424:	030c8c93          	addi	s9,s9,48
   11428:	1b9107a3          	sb	s9,431(sp)
   1142c:	1af10493          	addi	s1,sp,431
   11430:	4390006f          	j	12068 <_vfprintf_r+0x13d0>
   11434:	004c0793          	addi	a5,s8,4
   11438:	00f12e23          	sw	a5,28(sp)
   1143c:	01047793          	andi	a5,s0,16
   11440:	00078863          	beqz	a5,11450 <_vfprintf_r+0x7b8>
   11444:	000c2c83          	lw	s9,0(s8)
   11448:	41fcdc13          	srai	s8,s9,0x1f
   1144c:	fa9ff06f          	j	113f4 <_vfprintf_r+0x75c>
   11450:	04047793          	andi	a5,s0,64
   11454:	000c2c83          	lw	s9,0(s8)
   11458:	00078863          	beqz	a5,11468 <_vfprintf_r+0x7d0>
   1145c:	010c9c93          	slli	s9,s9,0x10
   11460:	410cdc93          	srai	s9,s9,0x10
   11464:	fe5ff06f          	j	11448 <_vfprintf_r+0x7b0>
   11468:	20047793          	andi	a5,s0,512
   1146c:	fc078ee3          	beqz	a5,11448 <_vfprintf_r+0x7b0>
   11470:	018c9c93          	slli	s9,s9,0x18
   11474:	418cdc93          	srai	s9,s9,0x18
   11478:	fd1ff06f          	j	11448 <_vfprintf_r+0x7b0>
   1147c:	00847793          	andi	a5,s0,8
   11480:	0a078a63          	beqz	a5,11534 <_vfprintf_r+0x89c>
   11484:	004c0793          	addi	a5,s8,4
   11488:	00f12e23          	sw	a5,28(sp)
   1148c:	000c2783          	lw	a5,0(s8)
   11490:	0007a603          	lw	a2,0(a5)
   11494:	0047a683          	lw	a3,4(a5)
   11498:	0087a703          	lw	a4,8(a5)
   1149c:	00c7a783          	lw	a5,12(a5)
   114a0:	0ec12823          	sw	a2,240(sp)
   114a4:	0ed12a23          	sw	a3,244(sp)
   114a8:	0ee12c23          	sw	a4,248(sp)
   114ac:	0f010513          	addi	a0,sp,240
   114b0:	0ef12e23          	sw	a5,252(sp)
   114b4:	205040ef          	jal	ra,15eb8 <_ldcheck>
   114b8:	0ca12623          	sw	a0,204(sp)
   114bc:	00200793          	li	a5,2
   114c0:	0cf51063          	bne	a0,a5,11580 <_vfprintf_r+0x8e8>
   114c4:	0f012783          	lw	a5,240(sp)
   114c8:	0a010593          	addi	a1,sp,160
   114cc:	0b010513          	addi	a0,sp,176
   114d0:	0af12823          	sw	a5,176(sp)
   114d4:	0f412783          	lw	a5,244(sp)
   114d8:	0a012023          	sw	zero,160(sp)
   114dc:	0a012223          	sw	zero,164(sp)
   114e0:	0af12a23          	sw	a5,180(sp)
   114e4:	0f812783          	lw	a5,248(sp)
   114e8:	0a012423          	sw	zero,168(sp)
   114ec:	0a012623          	sw	zero,172(sp)
   114f0:	0af12c23          	sw	a5,184(sp)
   114f4:	0fc12783          	lw	a5,252(sp)
   114f8:	0af12e23          	sw	a5,188(sp)
   114fc:	5910c0ef          	jal	ra,1e28c <__letf2>
   11500:	00055663          	bgez	a0,1150c <_vfprintf_r+0x874>
   11504:	02d00793          	li	a5,45
   11508:	0cf103a3          	sb	a5,199(sp)
   1150c:	00c12703          	lw	a4,12(sp)
   11510:	04700793          	li	a5,71
   11514:	06e7c063          	blt	a5,a4,11574 <_vfprintf_r+0x8dc>
   11518:	000224b7          	lui	s1,0x22
   1151c:	90048493          	addi	s1,s1,-1792 # 21900 <zeroes.4377+0x48>
   11520:	f7f47413          	andi	s0,s0,-129
   11524:	00012823          	sw	zero,16(sp)
   11528:	00300b13          	li	s6,3
   1152c:	00000a93          	li	s5,0
   11530:	3490006f          	j	12078 <_vfprintf_r+0x13e0>
   11534:	007c0c13          	addi	s8,s8,7
   11538:	ff8c7c13          	andi	s8,s8,-8
   1153c:	000c2583          	lw	a1,0(s8)
   11540:	004c2603          	lw	a2,4(s8)
   11544:	008c0793          	addi	a5,s8,8
   11548:	0b010513          	addi	a0,sp,176
   1154c:	00f12e23          	sw	a5,28(sp)
   11550:	2b50f0ef          	jal	ra,21004 <__extenddftf2>
   11554:	0b012783          	lw	a5,176(sp)
   11558:	0ef12823          	sw	a5,240(sp)
   1155c:	0b412783          	lw	a5,180(sp)
   11560:	0ef12a23          	sw	a5,244(sp)
   11564:	0b812783          	lw	a5,184(sp)
   11568:	0ef12c23          	sw	a5,248(sp)
   1156c:	0bc12783          	lw	a5,188(sp)
   11570:	f3dff06f          	j	114ac <_vfprintf_r+0x814>
   11574:	000224b7          	lui	s1,0x22
   11578:	90448493          	addi	s1,s1,-1788 # 21904 <zeroes.4377+0x4c>
   1157c:	fa5ff06f          	j	11520 <_vfprintf_r+0x888>
   11580:	00100793          	li	a5,1
   11584:	02f51463          	bne	a0,a5,115ac <_vfprintf_r+0x914>
   11588:	00c12703          	lw	a4,12(sp)
   1158c:	04700793          	li	a5,71
   11590:	00e7c863          	blt	a5,a4,115a0 <_vfprintf_r+0x908>
   11594:	000224b7          	lui	s1,0x22
   11598:	90848493          	addi	s1,s1,-1784 # 21908 <zeroes.4377+0x50>
   1159c:	f85ff06f          	j	11520 <_vfprintf_r+0x888>
   115a0:	000224b7          	lui	s1,0x22
   115a4:	90c48493          	addi	s1,s1,-1780 # 2190c <zeroes.4377+0x54>
   115a8:	f79ff06f          	j	11520 <_vfprintf_r+0x888>
   115ac:	00c12783          	lw	a5,12(sp)
   115b0:	fdf7fb93          	andi	s7,a5,-33
   115b4:	04100793          	li	a5,65
   115b8:	06fb9063          	bne	s7,a5,11618 <_vfprintf_r+0x980>
   115bc:	00c12683          	lw	a3,12(sp)
   115c0:	03000793          	li	a5,48
   115c4:	0cf10423          	sb	a5,200(sp)
   115c8:	06100713          	li	a4,97
   115cc:	05800793          	li	a5,88
   115d0:	00e69463          	bne	a3,a4,115d8 <_vfprintf_r+0x940>
   115d4:	07800793          	li	a5,120
   115d8:	0cf104a3          	sb	a5,201(sp)
   115dc:	06300793          	li	a5,99
   115e0:	00246413          	ori	s0,s0,2
   115e4:	5167d663          	ble	s6,a5,11af0 <_vfprintf_r+0xe58>
   115e8:	001b0593          	addi	a1,s6,1
   115ec:	00098513          	mv	a0,s3
   115f0:	dbdfe0ef          	jal	ra,103ac <_malloc_r>
   115f4:	00050493          	mv	s1,a0
   115f8:	50051263          	bnez	a0,11afc <_vfprintf_r+0xe64>
   115fc:	00c95783          	lhu	a5,12(s2)
   11600:	0407e793          	ori	a5,a5,64
   11604:	00f91623          	sh	a5,12(s2)
   11608:	00c95783          	lhu	a5,12(s2)
   1160c:	0407f793          	andi	a5,a5,64
   11610:	f6078e63          	beqz	a5,10d8c <_vfprintf_r+0xf4>
   11614:	fc8ff06f          	j	10ddc <_vfprintf_r+0x144>
   11618:	fff00793          	li	a5,-1
   1161c:	4efb0463          	beq	s6,a5,11b04 <_vfprintf_r+0xe6c>
   11620:	04700793          	li	a5,71
   11624:	00012823          	sw	zero,16(sp)
   11628:	00fb9463          	bne	s7,a5,11630 <_vfprintf_r+0x998>
   1162c:	4e0b0263          	beqz	s6,11b10 <_vfprintf_r+0xe78>
   11630:	0fc12a03          	lw	s4,252(sp)
   11634:	10046793          	ori	a5,s0,256
   11638:	02f12823          	sw	a5,48(sp)
   1163c:	04012423          	sw	zero,72(sp)
   11640:	0f012e03          	lw	t3,240(sp)
   11644:	0f412d83          	lw	s11,244(sp)
   11648:	0f812c83          	lw	s9,248(sp)
   1164c:	000a5a63          	bgez	s4,11660 <_vfprintf_r+0x9c8>
   11650:	800007b7          	lui	a5,0x80000
   11654:	0147ca33          	xor	s4,a5,s4
   11658:	02d00793          	li	a5,45
   1165c:	04f12423          	sw	a5,72(sp)
   11660:	04100793          	li	a5,65
   11664:	50fb9063          	bne	s7,a5,11b64 <_vfprintf_r+0xecc>
   11668:	0b010513          	addi	a0,sp,176
   1166c:	0bc12823          	sw	t3,176(sp)
   11670:	0bb12a23          	sw	s11,180(sp)
   11674:	0b912c23          	sw	s9,184(sp)
   11678:	0b412e23          	sw	s4,188(sp)
   1167c:	3d90f0ef          	jal	ra,21254 <__trunctfdf2>
   11680:	0cc10613          	addi	a2,sp,204
   11684:	2f4060ef          	jal	ra,17978 <frexp>
   11688:	00058613          	mv	a2,a1
   1168c:	00050593          	mv	a1,a0
   11690:	0b010513          	addi	a0,sp,176
   11694:	1710f0ef          	jal	ra,21004 <__extenddftf2>
   11698:	0b012583          	lw	a1,176(sp)
   1169c:	000227b7          	lui	a5,0x22
   116a0:	8d078793          	addi	a5,a5,-1840 # 218d0 <zeroes.4377+0x18>
   116a4:	08b12823          	sw	a1,144(sp)
   116a8:	0b412583          	lw	a1,180(sp)
   116ac:	0007a603          	lw	a2,0(a5)
   116b0:	0047a683          	lw	a3,4(a5)
   116b4:	08b12a23          	sw	a1,148(sp)
   116b8:	0b812583          	lw	a1,184(sp)
   116bc:	0087a703          	lw	a4,8(a5)
   116c0:	00c7a783          	lw	a5,12(a5)
   116c4:	08b12c23          	sw	a1,152(sp)
   116c8:	0bc12583          	lw	a1,188(sp)
   116cc:	08c12023          	sw	a2,128(sp)
   116d0:	0a010513          	addi	a0,sp,160
   116d4:	08b12e23          	sw	a1,156(sp)
   116d8:	08010613          	addi	a2,sp,128
   116dc:	09010593          	addi	a1,sp,144
   116e0:	08d12223          	sw	a3,132(sp)
   116e4:	08e12423          	sw	a4,136(sp)
   116e8:	08f12623          	sw	a5,140(sp)
   116ec:	5010c0ef          	jal	ra,1e3ec <__multf3>
   116f0:	0a012383          	lw	t2,160(sp)
   116f4:	0a412803          	lw	a6,164(sp)
   116f8:	0a812d83          	lw	s11,168(sp)
   116fc:	0ac12c83          	lw	s9,172(sp)
   11700:	0a010593          	addi	a1,sp,160
   11704:	0b010513          	addi	a0,sp,176
   11708:	0a712823          	sw	t2,176(sp)
   1170c:	04712823          	sw	t2,80(sp)
   11710:	0b012a23          	sw	a6,180(sp)
   11714:	05012623          	sw	a6,76(sp)
   11718:	0bb12c23          	sw	s11,184(sp)
   1171c:	0b912e23          	sw	s9,188(sp)
   11720:	0a012023          	sw	zero,160(sp)
   11724:	0a012223          	sw	zero,164(sp)
   11728:	0a012423          	sw	zero,168(sp)
   1172c:	0a012623          	sw	zero,172(sp)
   11730:	1310c0ef          	jal	ra,1e060 <__eqtf2>
   11734:	04c12803          	lw	a6,76(sp)
   11738:	05012383          	lw	t2,80(sp)
   1173c:	00051663          	bnez	a0,11748 <_vfprintf_r+0xab0>
   11740:	00100793          	li	a5,1
   11744:	0cf12623          	sw	a5,204(sp)
   11748:	00c12703          	lw	a4,12(sp)
   1174c:	06100793          	li	a5,97
   11750:	3cf71663          	bne	a4,a5,11b1c <_vfprintf_r+0xe84>
   11754:	00022ab7          	lui	s5,0x22
   11758:	910a8a93          	addi	s5,s5,-1776 # 21910 <zeroes.4377+0x58>
   1175c:	00022737          	lui	a4,0x22
   11760:	8e070713          	addi	a4,a4,-1824 # 218e0 <zeroes.4377+0x28>
   11764:	00072783          	lw	a5,0(a4)
   11768:	fffb0e13          	addi	t3,s6,-1
   1176c:	00048c13          	mv	s8,s1
   11770:	04f12823          	sw	a5,80(sp)
   11774:	00472783          	lw	a5,4(a4)
   11778:	04f12a23          	sw	a5,84(sp)
   1177c:	00872783          	lw	a5,8(a4)
   11780:	04f12c23          	sw	a5,88(sp)
   11784:	00c72783          	lw	a5,12(a4)
   11788:	04f12e23          	sw	a5,92(sp)
   1178c:	05012783          	lw	a5,80(sp)
   11790:	0a010593          	addi	a1,sp,160
   11794:	09010613          	addi	a2,sp,144
   11798:	08f12823          	sw	a5,144(sp)
   1179c:	05412783          	lw	a5,84(sp)
   117a0:	0b010513          	addi	a0,sp,176
   117a4:	07c12423          	sw	t3,104(sp)
   117a8:	08f12a23          	sw	a5,148(sp)
   117ac:	05812783          	lw	a5,88(sp)
   117b0:	0a712023          	sw	t2,160(sp)
   117b4:	0b012223          	sw	a6,164(sp)
   117b8:	08f12c23          	sw	a5,152(sp)
   117bc:	05c12783          	lw	a5,92(sp)
   117c0:	0bb12423          	sw	s11,168(sp)
   117c4:	0b912623          	sw	s9,172(sp)
   117c8:	08f12e23          	sw	a5,156(sp)
   117cc:	4210c0ef          	jal	ra,1e3ec <__multf3>
   117d0:	0b012603          	lw	a2,176(sp)
   117d4:	0b412683          	lw	a3,180(sp)
   117d8:	0b010513          	addi	a0,sp,176
   117dc:	06c12223          	sw	a2,100(sp)
   117e0:	04d12623          	sw	a3,76(sp)
   117e4:	53c0f0ef          	jal	ra,20d20 <__fixtfsi>
   117e8:	00050593          	mv	a1,a0
   117ec:	00050a13          	mv	s4,a0
   117f0:	0b010513          	addi	a0,sp,176
   117f4:	0b812d83          	lw	s11,184(sp)
   117f8:	0bc12c83          	lw	s9,188(sp)
   117fc:	6880f0ef          	jal	ra,20e84 <__floatsitf>
   11800:	0b012703          	lw	a4,176(sp)
   11804:	06412603          	lw	a2,100(sp)
   11808:	04c12683          	lw	a3,76(sp)
   1180c:	08e12023          	sw	a4,128(sp)
   11810:	0b412703          	lw	a4,180(sp)
   11814:	08c12823          	sw	a2,144(sp)
   11818:	09010593          	addi	a1,sp,144
   1181c:	08e12223          	sw	a4,132(sp)
   11820:	0b812703          	lw	a4,184(sp)
   11824:	08010613          	addi	a2,sp,128
   11828:	0a010513          	addi	a0,sp,160
   1182c:	08e12423          	sw	a4,136(sp)
   11830:	0bc12703          	lw	a4,188(sp)
   11834:	09b12c23          	sw	s11,152(sp)
   11838:	09912e23          	sw	s9,156(sp)
   1183c:	08e12623          	sw	a4,140(sp)
   11840:	08d12a23          	sw	a3,148(sp)
   11844:	7d90d0ef          	jal	ra,1f81c <__subtf3>
   11848:	014a8733          	add	a4,s5,s4
   1184c:	00074703          	lbu	a4,0(a4)
   11850:	06812e03          	lw	t3,104(sp)
   11854:	0a812f03          	lw	t5,168(sp)
   11858:	0ac12e83          	lw	t4,172(sp)
   1185c:	001c0c13          	addi	s8,s8,1
   11860:	0a012283          	lw	t0,160(sp)
   11864:	0a412f83          	lw	t6,164(sp)
   11868:	05c12623          	sw	t3,76(sp)
   1186c:	feec0fa3          	sb	a4,-1(s8)
   11870:	fff00713          	li	a4,-1
   11874:	000f0d93          	mv	s11,t5
   11878:	000e8c93          	mv	s9,t4
   1187c:	06ee0863          	beq	t3,a4,118ec <_vfprintf_r+0xc54>
   11880:	fffe0e13          	addi	t3,t3,-1
   11884:	0a010593          	addi	a1,sp,160
   11888:	0b010513          	addi	a0,sp,176
   1188c:	07d12e23          	sw	t4,124(sp)
   11890:	07e12c23          	sw	t5,120(sp)
   11894:	07f12a23          	sw	t6,116(sp)
   11898:	06512823          	sw	t0,112(sp)
   1189c:	07c12623          	sw	t3,108(sp)
   118a0:	0a512823          	sw	t0,176(sp)
   118a4:	06512423          	sw	t0,104(sp)
   118a8:	0bf12a23          	sw	t6,180(sp)
   118ac:	07f12223          	sw	t6,100(sp)
   118b0:	0be12c23          	sw	t5,184(sp)
   118b4:	0bd12e23          	sw	t4,188(sp)
   118b8:	0a012023          	sw	zero,160(sp)
   118bc:	0a012223          	sw	zero,164(sp)
   118c0:	0a012423          	sw	zero,168(sp)
   118c4:	0a012623          	sw	zero,172(sp)
   118c8:	7980c0ef          	jal	ra,1e060 <__eqtf2>
   118cc:	06412803          	lw	a6,100(sp)
   118d0:	06812383          	lw	t2,104(sp)
   118d4:	06c12e03          	lw	t3,108(sp)
   118d8:	07012283          	lw	t0,112(sp)
   118dc:	07412f83          	lw	t6,116(sp)
   118e0:	07812f03          	lw	t5,120(sp)
   118e4:	07c12e83          	lw	t4,124(sp)
   118e8:	ea0512e3          	bnez	a0,1178c <_vfprintf_r+0xaf4>
   118ec:	00022737          	lui	a4,0x22
   118f0:	8f070713          	addi	a4,a4,-1808 # 218f0 <zeroes.4377+0x38>
   118f4:	00072603          	lw	a2,0(a4)
   118f8:	00472683          	lw	a3,4(a4)
   118fc:	00872d83          	lw	s11,8(a4)
   11900:	00c72c83          	lw	s9,12(a4)
   11904:	0a010593          	addi	a1,sp,160
   11908:	0b010513          	addi	a0,sp,176
   1190c:	0a512823          	sw	t0,176(sp)
   11910:	06512423          	sw	t0,104(sp)
   11914:	0bf12a23          	sw	t6,180(sp)
   11918:	07f12223          	sw	t6,100(sp)
   1191c:	0be12c23          	sw	t5,184(sp)
   11920:	05e12e23          	sw	t5,92(sp)
   11924:	0bd12e23          	sw	t4,188(sp)
   11928:	05d12c23          	sw	t4,88(sp)
   1192c:	0ac12023          	sw	a2,160(sp)
   11930:	04c12a23          	sw	a2,84(sp)
   11934:	0ad12223          	sw	a3,164(sp)
   11938:	04d12823          	sw	a3,80(sp)
   1193c:	0bb12423          	sw	s11,168(sp)
   11940:	0b912623          	sw	s9,172(sp)
   11944:	7e80c0ef          	jal	ra,1e12c <__getf2>
   11948:	04a04a63          	bgtz	a0,1199c <_vfprintf_r+0xd04>
   1194c:	06812283          	lw	t0,104(sp)
   11950:	06412f83          	lw	t6,100(sp)
   11954:	05c12f03          	lw	t5,92(sp)
   11958:	05812e83          	lw	t4,88(sp)
   1195c:	05412603          	lw	a2,84(sp)
   11960:	05012683          	lw	a3,80(sp)
   11964:	0a010593          	addi	a1,sp,160
   11968:	0b010513          	addi	a0,sp,176
   1196c:	0a512823          	sw	t0,176(sp)
   11970:	0bf12a23          	sw	t6,180(sp)
   11974:	0be12c23          	sw	t5,184(sp)
   11978:	0bd12e23          	sw	t4,188(sp)
   1197c:	0ac12023          	sw	a2,160(sp)
   11980:	0ad12223          	sw	a3,164(sp)
   11984:	0bb12423          	sw	s11,168(sp)
   11988:	0b912623          	sw	s9,172(sp)
   1198c:	6d40c0ef          	jal	ra,1e060 <__eqtf2>
   11990:	1c051063          	bnez	a0,11b50 <_vfprintf_r+0xeb8>
   11994:	001a7a13          	andi	s4,s4,1
   11998:	1a0a0c63          	beqz	s4,11b50 <_vfprintf_r+0xeb8>
   1199c:	00fac603          	lbu	a2,15(s5)
   119a0:	0d812e23          	sw	s8,220(sp)
   119a4:	03000593          	li	a1,48
   119a8:	0dc12683          	lw	a3,220(sp)
   119ac:	fff68713          	addi	a4,a3,-1
   119b0:	0ce12e23          	sw	a4,220(sp)
   119b4:	fff6c703          	lbu	a4,-1(a3)
   119b8:	16c70863          	beq	a4,a2,11b28 <_vfprintf_r+0xe90>
   119bc:	03900613          	li	a2,57
   119c0:	16c71863          	bne	a4,a2,11b30 <_vfprintf_r+0xe98>
   119c4:	00aac703          	lbu	a4,10(s5)
   119c8:	fee68fa3          	sb	a4,-1(a3)
   119cc:	000c0a13          	mv	s4,s8
   119d0:	04700713          	li	a4,71
   119d4:	409a0a33          	sub	s4,s4,s1
   119d8:	0cc12c83          	lw	s9,204(sp)
   119dc:	2aeb9a63          	bne	s7,a4,11c90 <_vfprintf_r+0xff8>
   119e0:	ffd00713          	li	a4,-3
   119e4:	00ecc463          	blt	s9,a4,119ec <_vfprintf_r+0xd54>
   119e8:	339b5863          	ble	s9,s6,11d18 <_vfprintf_r+0x1080>
   119ec:	00c12783          	lw	a5,12(sp)
   119f0:	ffe78793          	addi	a5,a5,-2
   119f4:	00f12623          	sw	a5,12(sp)
   119f8:	00c12783          	lw	a5,12(sp)
   119fc:	fffc8a93          	addi	s5,s9,-1
   11a00:	0d512623          	sw	s5,204(sp)
   11a04:	fdf7f693          	andi	a3,a5,-33
   11a08:	04100593          	li	a1,65
   11a0c:	00c14703          	lbu	a4,12(sp)
   11a10:	00000613          	li	a2,0
   11a14:	00b69863          	bne	a3,a1,11a24 <_vfprintf_r+0xd8c>
   11a18:	00f70713          	addi	a4,a4,15
   11a1c:	0ff77713          	andi	a4,a4,255
   11a20:	00100613          	li	a2,1
   11a24:	0ce10a23          	sb	a4,212(sp)
   11a28:	02b00793          	li	a5,43
   11a2c:	000ad863          	bgez	s5,11a3c <_vfprintf_r+0xda4>
   11a30:	00100a93          	li	s5,1
   11a34:	419a8ab3          	sub	s5,s5,s9
   11a38:	02d00793          	li	a5,45
   11a3c:	0cf10aa3          	sb	a5,213(sp)
   11a40:	00900793          	li	a5,9
   11a44:	2957dc63          	ble	s5,a5,11cdc <_vfprintf_r+0x1044>
   11a48:	0e310b93          	addi	s7,sp,227
   11a4c:	000b8c93          	mv	s9,s7
   11a50:	00900d93          	li	s11,9
   11a54:	00a00593          	li	a1,10
   11a58:	000a8513          	mv	a0,s5
   11a5c:	3f90f0ef          	jal	ra,21654 <__modsi3>
   11a60:	03050513          	addi	a0,a0,48
   11a64:	feab8fa3          	sb	a0,-1(s7)
   11a68:	00a00593          	li	a1,10
   11a6c:	000a8513          	mv	a0,s5
   11a70:	3610f0ef          	jal	ra,215d0 <__divsi3>
   11a74:	fffb8c13          	addi	s8,s7,-1
   11a78:	00050a93          	mv	s5,a0
   11a7c:	24adc263          	blt	s11,a0,11cc0 <_vfprintf_r+0x1028>
   11a80:	03050a93          	addi	s5,a0,48
   11a84:	ffeb8b93          	addi	s7,s7,-2
   11a88:	ff5c0fa3          	sb	s5,-1(s8)
   11a8c:	0d610793          	addi	a5,sp,214
   11a90:	239bec63          	bltu	s7,s9,11cc8 <_vfprintf_r+0x1030>
   11a94:	0d410713          	addi	a4,sp,212
   11a98:	40e787b3          	sub	a5,a5,a4
   11a9c:	04f12023          	sw	a5,64(sp)
   11aa0:	01478b33          	add	s6,a5,s4
   11aa4:	00100793          	li	a5,1
   11aa8:	0147c663          	blt	a5,s4,11ab4 <_vfprintf_r+0xe1c>
   11aac:	00147793          	andi	a5,s0,1
   11ab0:	00078663          	beqz	a5,11abc <_vfprintf_r+0xe24>
   11ab4:	02412783          	lw	a5,36(sp)
   11ab8:	00fb0b33          	add	s6,s6,a5
   11abc:	bff47413          	andi	s0,s0,-1025
   11ac0:	10046793          	ori	a5,s0,256
   11ac4:	02f12823          	sw	a5,48(sp)
   11ac8:	00000c13          	li	s8,0
   11acc:	00000b93          	li	s7,0
   11ad0:	00000c93          	li	s9,0
   11ad4:	04812783          	lw	a5,72(sp)
   11ad8:	00078663          	beqz	a5,11ae4 <_vfprintf_r+0xe4c>
   11adc:	02d00713          	li	a4,45
   11ae0:	0ce103a3          	sb	a4,199(sp)
   11ae4:	03012403          	lw	s0,48(sp)
   11ae8:	00000a93          	li	s5,0
   11aec:	e50ff06f          	j	1113c <_vfprintf_r+0x4a4>
   11af0:	00012823          	sw	zero,16(sp)
   11af4:	14c10493          	addi	s1,sp,332
   11af8:	b39ff06f          	j	11630 <_vfprintf_r+0x998>
   11afc:	00a12823          	sw	a0,16(sp)
   11b00:	b31ff06f          	j	11630 <_vfprintf_r+0x998>
   11b04:	00012823          	sw	zero,16(sp)
   11b08:	00600b13          	li	s6,6
   11b0c:	b25ff06f          	j	11630 <_vfprintf_r+0x998>
   11b10:	01612823          	sw	s6,16(sp)
   11b14:	00100b13          	li	s6,1
   11b18:	b19ff06f          	j	11630 <_vfprintf_r+0x998>
   11b1c:	00022ab7          	lui	s5,0x22
   11b20:	924a8a93          	addi	s5,s5,-1756 # 21924 <zeroes.4377+0x6c>
   11b24:	c39ff06f          	j	1175c <_vfprintf_r+0xac4>
   11b28:	feb68fa3          	sb	a1,-1(a3)
   11b2c:	e7dff06f          	j	119a8 <_vfprintf_r+0xd10>
   11b30:	00170713          	addi	a4,a4,1
   11b34:	0ff77713          	andi	a4,a4,255
   11b38:	e91ff06f          	j	119c8 <_vfprintf_r+0xd30>
   11b3c:	001a0a13          	addi	s4,s4,1
   11b40:	feea0fa3          	sb	a4,-1(s4)
   11b44:	414c07b3          	sub	a5,s8,s4
   11b48:	fe07dae3          	bgez	a5,11b3c <_vfprintf_r+0xea4>
   11b4c:	e85ff06f          	j	119d0 <_vfprintf_r+0xd38>
   11b50:	04c12783          	lw	a5,76(sp)
   11b54:	000c0a13          	mv	s4,s8
   11b58:	03000713          	li	a4,48
   11b5c:	00fc0c33          	add	s8,s8,a5
   11b60:	fe5ff06f          	j	11b44 <_vfprintf_r+0xeac>
   11b64:	04600793          	li	a5,70
   11b68:	00fb8e63          	beq	s7,a5,11b84 <_vfprintf_r+0xeec>
   11b6c:	04500793          	li	a5,69
   11b70:	001b0a93          	addi	s5,s6,1
   11b74:	00fb8463          	beq	s7,a5,11b7c <_vfprintf_r+0xee4>
   11b78:	000b0a93          	mv	s5,s6
   11b7c:	00200613          	li	a2,2
   11b80:	00c0006f          	j	11b8c <_vfprintf_r+0xef4>
   11b84:	000b0a93          	mv	s5,s6
   11b88:	00300613          	li	a2,3
   11b8c:	0d010793          	addi	a5,sp,208
   11b90:	0dc10813          	addi	a6,sp,220
   11b94:	0cc10713          	addi	a4,sp,204
   11b98:	000a8693          	mv	a3,s5
   11b9c:	0b010593          	addi	a1,sp,176
   11ba0:	00098513          	mv	a0,s3
   11ba4:	0bc12823          	sw	t3,176(sp)
   11ba8:	05c12623          	sw	t3,76(sp)
   11bac:	0bb12a23          	sw	s11,180(sp)
   11bb0:	0b912c23          	sw	s9,184(sp)
   11bb4:	0b412e23          	sw	s4,188(sp)
   11bb8:	6ac030ef          	jal	ra,15264 <_ldtoa_r>
   11bbc:	04700793          	li	a5,71
   11bc0:	00050493          	mv	s1,a0
   11bc4:	04c12e03          	lw	t3,76(sp)
   11bc8:	00fb9663          	bne	s7,a5,11bd4 <_vfprintf_r+0xf3c>
   11bcc:	00147793          	andi	a5,s0,1
   11bd0:	0a078063          	beqz	a5,11c70 <_vfprintf_r+0xfd8>
   11bd4:	04600793          	li	a5,70
   11bd8:	01548c33          	add	s8,s1,s5
   11bdc:	04fb9e63          	bne	s7,a5,11c38 <_vfprintf_r+0xfa0>
   11be0:	0004c703          	lbu	a4,0(s1)
   11be4:	03000793          	li	a5,48
   11be8:	04f71463          	bne	a4,a5,11c30 <_vfprintf_r+0xf98>
   11bec:	0a010593          	addi	a1,sp,160
   11bf0:	0b010513          	addi	a0,sp,176
   11bf4:	0bc12823          	sw	t3,176(sp)
   11bf8:	05c12623          	sw	t3,76(sp)
   11bfc:	0bb12a23          	sw	s11,180(sp)
   11c00:	0b912c23          	sw	s9,184(sp)
   11c04:	0b412e23          	sw	s4,188(sp)
   11c08:	0a012023          	sw	zero,160(sp)
   11c0c:	0a012223          	sw	zero,164(sp)
   11c10:	0a012423          	sw	zero,168(sp)
   11c14:	0a012623          	sw	zero,172(sp)
   11c18:	4480c0ef          	jal	ra,1e060 <__eqtf2>
   11c1c:	04c12e03          	lw	t3,76(sp)
   11c20:	00050863          	beqz	a0,11c30 <_vfprintf_r+0xf98>
   11c24:	00100793          	li	a5,1
   11c28:	41578ab3          	sub	s5,a5,s5
   11c2c:	0d512623          	sw	s5,204(sp)
   11c30:	0cc12783          	lw	a5,204(sp)
   11c34:	00fc0c33          	add	s8,s8,a5
   11c38:	0a010593          	addi	a1,sp,160
   11c3c:	0b010513          	addi	a0,sp,176
   11c40:	0bc12823          	sw	t3,176(sp)
   11c44:	0bb12a23          	sw	s11,180(sp)
   11c48:	0b912c23          	sw	s9,184(sp)
   11c4c:	0b412e23          	sw	s4,188(sp)
   11c50:	0a012023          	sw	zero,160(sp)
   11c54:	0a012223          	sw	zero,164(sp)
   11c58:	0a012423          	sw	zero,168(sp)
   11c5c:	0a012623          	sw	zero,172(sp)
   11c60:	4000c0ef          	jal	ra,1e060 <__eqtf2>
   11c64:	03000713          	li	a4,48
   11c68:	00051e63          	bnez	a0,11c84 <_vfprintf_r+0xfec>
   11c6c:	0d812e23          	sw	s8,220(sp)
   11c70:	0dc12a03          	lw	s4,220(sp)
   11c74:	d5dff06f          	j	119d0 <_vfprintf_r+0xd38>
   11c78:	00178693          	addi	a3,a5,1
   11c7c:	0cd12e23          	sw	a3,220(sp)
   11c80:	00e78023          	sb	a4,0(a5)
   11c84:	0dc12783          	lw	a5,220(sp)
   11c88:	ff87e8e3          	bltu	a5,s8,11c78 <_vfprintf_r+0xfe0>
   11c8c:	fe5ff06f          	j	11c70 <_vfprintf_r+0xfd8>
   11c90:	04600713          	li	a4,70
   11c94:	d6eb92e3          	bne	s7,a4,119f8 <_vfprintf_r+0xd60>
   11c98:	07905463          	blez	s9,11d00 <_vfprintf_r+0x1068>
   11c9c:	000b1663          	bnez	s6,11ca8 <_vfprintf_r+0x1010>
   11ca0:	00147713          	andi	a4,s0,1
   11ca4:	0c070663          	beqz	a4,11d70 <_vfprintf_r+0x10d8>
   11ca8:	02412783          	lw	a5,36(sp)
   11cac:	00fc8733          	add	a4,s9,a5
   11cb0:	00eb0b33          	add	s6,s6,a4
   11cb4:	06600793          	li	a5,102
   11cb8:	00f12623          	sw	a5,12(sp)
   11cbc:	0980006f          	j	11d54 <_vfprintf_r+0x10bc>
   11cc0:	000c0b93          	mv	s7,s8
   11cc4:	d91ff06f          	j	11a54 <_vfprintf_r+0xdbc>
   11cc8:	001b8b93          	addi	s7,s7,1
   11ccc:	fffbc703          	lbu	a4,-1(s7)
   11cd0:	00178793          	addi	a5,a5,1
   11cd4:	fee78fa3          	sb	a4,-1(a5)
   11cd8:	db9ff06f          	j	11a90 <_vfprintf_r+0xdf8>
   11cdc:	0d610713          	addi	a4,sp,214
   11ce0:	00061863          	bnez	a2,11cf0 <_vfprintf_r+0x1058>
   11ce4:	03000793          	li	a5,48
   11ce8:	0cf10b23          	sb	a5,214(sp)
   11cec:	0d710713          	addi	a4,sp,215
   11cf0:	030a8a93          	addi	s5,s5,48
   11cf4:	00170793          	addi	a5,a4,1
   11cf8:	01570023          	sb	s5,0(a4)
   11cfc:	d99ff06f          	j	11a94 <_vfprintf_r+0xdfc>
   11d00:	000b1663          	bnez	s6,11d0c <_vfprintf_r+0x1074>
   11d04:	00147713          	andi	a4,s0,1
   11d08:	06070863          	beqz	a4,11d78 <_vfprintf_r+0x10e0>
   11d0c:	02412783          	lw	a5,36(sp)
   11d10:	00178713          	addi	a4,a5,1
   11d14:	f9dff06f          	j	11cb0 <_vfprintf_r+0x1018>
   11d18:	034cc063          	blt	s9,s4,11d38 <_vfprintf_r+0x10a0>
   11d1c:	00147713          	andi	a4,s0,1
   11d20:	000c8b13          	mv	s6,s9
   11d24:	00070663          	beqz	a4,11d30 <_vfprintf_r+0x1098>
   11d28:	02412783          	lw	a5,36(sp)
   11d2c:	00fc8b33          	add	s6,s9,a5
   11d30:	06700793          	li	a5,103
   11d34:	f85ff06f          	j	11cb8 <_vfprintf_r+0x1020>
   11d38:	02412783          	lw	a5,36(sp)
   11d3c:	00fa0b33          	add	s6,s4,a5
   11d40:	06700793          	li	a5,103
   11d44:	00f12623          	sw	a5,12(sp)
   11d48:	01904663          	bgtz	s9,11d54 <_vfprintf_r+0x10bc>
   11d4c:	419b0333          	sub	t1,s6,s9
   11d50:	00130b13          	addi	s6,t1,1 # 1 <main-0x10073>
   11d54:	40047b93          	andi	s7,s0,1024
   11d58:	00000c13          	li	s8,0
   11d5c:	d60b8ce3          	beqz	s7,11ad4 <_vfprintf_r+0xe3c>
   11d60:	00000b93          	li	s7,0
   11d64:	d79058e3          	blez	s9,11ad4 <_vfprintf_r+0xe3c>
   11d68:	0ff00693          	li	a3,255
   11d6c:	03c0006f          	j	11da8 <_vfprintf_r+0x1110>
   11d70:	000c8b13          	mv	s6,s9
   11d74:	f41ff06f          	j	11cb4 <_vfprintf_r+0x101c>
   11d78:	06600793          	li	a5,102
   11d7c:	00f12623          	sw	a5,12(sp)
   11d80:	00100b13          	li	s6,1
   11d84:	fd1ff06f          	j	11d54 <_vfprintf_r+0x10bc>
   11d88:	03975663          	ble	s9,a4,11db4 <_vfprintf_r+0x111c>
   11d8c:	01412783          	lw	a5,20(sp)
   11d90:	40ec8cb3          	sub	s9,s9,a4
   11d94:	0017c703          	lbu	a4,1(a5)
   11d98:	02070863          	beqz	a4,11dc8 <_vfprintf_r+0x1130>
   11d9c:	00178793          	addi	a5,a5,1
   11da0:	001b8b93          	addi	s7,s7,1
   11da4:	00f12a23          	sw	a5,20(sp)
   11da8:	01412783          	lw	a5,20(sp)
   11dac:	0007c703          	lbu	a4,0(a5)
   11db0:	fcd71ce3          	bne	a4,a3,11d88 <_vfprintf_r+0x10f0>
   11db4:	03412583          	lw	a1,52(sp)
   11db8:	018b8533          	add	a0,s7,s8
   11dbc:	7f00f0ef          	jal	ra,215ac <__mulsi3>
   11dc0:	01650b33          	add	s6,a0,s6
   11dc4:	d11ff06f          	j	11ad4 <_vfprintf_r+0xe3c>
   11dc8:	001c0c13          	addi	s8,s8,1
   11dcc:	fddff06f          	j	11da8 <_vfprintf_r+0x1110>
   11dd0:	004c0713          	addi	a4,s8,4
   11dd4:	00e12e23          	sw	a4,28(sp)
   11dd8:	02047713          	andi	a4,s0,32
   11ddc:	000c2783          	lw	a5,0(s8)
   11de0:	02070063          	beqz	a4,11e00 <_vfprintf_r+0x1168>
   11de4:	02812703          	lw	a4,40(sp)
   11de8:	00e7a023          	sw	a4,0(a5)
   11dec:	41f75713          	srai	a4,a4,0x1f
   11df0:	00e7a223          	sw	a4,4(a5)
   11df4:	01c12c03          	lw	s8,28(sp)
   11df8:	02012483          	lw	s1,32(sp)
   11dfc:	834ff06f          	j	10e30 <_vfprintf_r+0x198>
   11e00:	01047713          	andi	a4,s0,16
   11e04:	00070863          	beqz	a4,11e14 <_vfprintf_r+0x117c>
   11e08:	02812703          	lw	a4,40(sp)
   11e0c:	00e7a023          	sw	a4,0(a5)
   11e10:	fe5ff06f          	j	11df4 <_vfprintf_r+0x115c>
   11e14:	04047713          	andi	a4,s0,64
   11e18:	00070863          	beqz	a4,11e28 <_vfprintf_r+0x1190>
   11e1c:	02815703          	lhu	a4,40(sp)
   11e20:	00e79023          	sh	a4,0(a5)
   11e24:	fd1ff06f          	j	11df4 <_vfprintf_r+0x115c>
   11e28:	20047413          	andi	s0,s0,512
   11e2c:	fc040ee3          	beqz	s0,11e08 <_vfprintf_r+0x1170>
   11e30:	02814703          	lbu	a4,40(sp)
   11e34:	00e78023          	sb	a4,0(a5)
   11e38:	fbdff06f          	j	11df4 <_vfprintf_r+0x115c>
   11e3c:	01046413          	ori	s0,s0,16
   11e40:	02047793          	andi	a5,s0,32
   11e44:	04078863          	beqz	a5,11e94 <_vfprintf_r+0x11fc>
   11e48:	007c0c13          	addi	s8,s8,7
   11e4c:	ff8c7c13          	andi	s8,s8,-8
   11e50:	008c0793          	addi	a5,s8,8
   11e54:	000c2c83          	lw	s9,0(s8)
   11e58:	004c2c03          	lw	s8,4(s8)
   11e5c:	00f12e23          	sw	a5,28(sp)
   11e60:	bff47413          	andi	s0,s0,-1025
   11e64:	00000793          	li	a5,0
   11e68:	0c0103a3          	sb	zero,199(sp)
   11e6c:	fff00713          	li	a4,-1
   11e70:	1aeb0263          	beq	s6,a4,12014 <_vfprintf_r+0x137c>
   11e74:	00040713          	mv	a4,s0
   11e78:	018ce6b3          	or	a3,s9,s8
   11e7c:	f7f47413          	andi	s0,s0,-129
   11e80:	18069a63          	bnez	a3,12014 <_vfprintf_r+0x137c>
   11e84:	2e0b0c63          	beqz	s6,1217c <_vfprintf_r+0x14e4>
   11e88:	00100713          	li	a4,1
   11e8c:	18e79863          	bne	a5,a4,1201c <_vfprintf_r+0x1384>
   11e90:	d94ff06f          	j	11424 <_vfprintf_r+0x78c>
   11e94:	004c0793          	addi	a5,s8,4
   11e98:	00f12e23          	sw	a5,28(sp)
   11e9c:	01047793          	andi	a5,s0,16
   11ea0:	00078663          	beqz	a5,11eac <_vfprintf_r+0x1214>
   11ea4:	000c2c83          	lw	s9,0(s8)
   11ea8:	0100006f          	j	11eb8 <_vfprintf_r+0x1220>
   11eac:	04047793          	andi	a5,s0,64
   11eb0:	00078863          	beqz	a5,11ec0 <_vfprintf_r+0x1228>
   11eb4:	000c5c83          	lhu	s9,0(s8)
   11eb8:	00000c13          	li	s8,0
   11ebc:	fa5ff06f          	j	11e60 <_vfprintf_r+0x11c8>
   11ec0:	20047793          	andi	a5,s0,512
   11ec4:	fe0780e3          	beqz	a5,11ea4 <_vfprintf_r+0x120c>
   11ec8:	000c4c83          	lbu	s9,0(s8)
   11ecc:	fedff06f          	j	11eb8 <_vfprintf_r+0x1220>
   11ed0:	004c0793          	addi	a5,s8,4
   11ed4:	00f12e23          	sw	a5,28(sp)
   11ed8:	ffff87b7          	lui	a5,0xffff8
   11edc:	8307c793          	xori	a5,a5,-2000
   11ee0:	0cf11423          	sh	a5,200(sp)
   11ee4:	000227b7          	lui	a5,0x22
   11ee8:	91078793          	addi	a5,a5,-1776 # 21910 <zeroes.4377+0x58>
   11eec:	07800713          	li	a4,120
   11ef0:	000c2c83          	lw	s9,0(s8)
   11ef4:	04f12223          	sw	a5,68(sp)
   11ef8:	00000c13          	li	s8,0
   11efc:	00246413          	ori	s0,s0,2
   11f00:	00200793          	li	a5,2
   11f04:	00e12623          	sw	a4,12(sp)
   11f08:	f61ff06f          	j	11e68 <_vfprintf_r+0x11d0>
   11f0c:	004c0793          	addi	a5,s8,4
   11f10:	00f12e23          	sw	a5,28(sp)
   11f14:	0c0103a3          	sb	zero,199(sp)
   11f18:	fff00793          	li	a5,-1
   11f1c:	000c2483          	lw	s1,0(s8)
   11f20:	02fb0463          	beq	s6,a5,11f48 <_vfprintf_r+0x12b0>
   11f24:	000b0613          	mv	a2,s6
   11f28:	00000593          	li	a1,0
   11f2c:	00048513          	mv	a0,s1
   11f30:	2f4040ef          	jal	ra,16224 <memchr>
   11f34:	00a12823          	sw	a0,16(sp)
   11f38:	de050a63          	beqz	a0,1152c <_vfprintf_r+0x894>
   11f3c:	40950b33          	sub	s6,a0,s1
   11f40:	00012823          	sw	zero,16(sp)
   11f44:	de8ff06f          	j	1152c <_vfprintf_r+0x894>
   11f48:	00048513          	mv	a0,s1
   11f4c:	d31fe0ef          	jal	ra,10c7c <strlen>
   11f50:	00050b13          	mv	s6,a0
   11f54:	fedff06f          	j	11f40 <_vfprintf_r+0x12a8>
   11f58:	01046413          	ori	s0,s0,16
   11f5c:	02047793          	andi	a5,s0,32
   11f60:	02078263          	beqz	a5,11f84 <_vfprintf_r+0x12ec>
   11f64:	007c0c13          	addi	s8,s8,7
   11f68:	ff8c7c13          	andi	s8,s8,-8
   11f6c:	008c0793          	addi	a5,s8,8
   11f70:	000c2c83          	lw	s9,0(s8)
   11f74:	004c2c03          	lw	s8,4(s8)
   11f78:	00f12e23          	sw	a5,28(sp)
   11f7c:	00100793          	li	a5,1
   11f80:	ee9ff06f          	j	11e68 <_vfprintf_r+0x11d0>
   11f84:	004c0793          	addi	a5,s8,4
   11f88:	00f12e23          	sw	a5,28(sp)
   11f8c:	01047793          	andi	a5,s0,16
   11f90:	00078663          	beqz	a5,11f9c <_vfprintf_r+0x1304>
   11f94:	000c2c83          	lw	s9,0(s8)
   11f98:	0100006f          	j	11fa8 <_vfprintf_r+0x1310>
   11f9c:	04047793          	andi	a5,s0,64
   11fa0:	00078863          	beqz	a5,11fb0 <_vfprintf_r+0x1318>
   11fa4:	000c5c83          	lhu	s9,0(s8)
   11fa8:	00000c13          	li	s8,0
   11fac:	fd1ff06f          	j	11f7c <_vfprintf_r+0x12e4>
   11fb0:	20047793          	andi	a5,s0,512
   11fb4:	fe0780e3          	beqz	a5,11f94 <_vfprintf_r+0x12fc>
   11fb8:	000c4c83          	lbu	s9,0(s8)
   11fbc:	fedff06f          	j	11fa8 <_vfprintf_r+0x1310>
   11fc0:	000227b7          	lui	a5,0x22
   11fc4:	91078793          	addi	a5,a5,-1776 # 21910 <zeroes.4377+0x58>
   11fc8:	f4dfe06f          	j	10f14 <_vfprintf_r+0x27c>
   11fcc:	004c0793          	addi	a5,s8,4
   11fd0:	00f12e23          	sw	a5,28(sp)
   11fd4:	01047793          	andi	a5,s0,16
   11fd8:	00078663          	beqz	a5,11fe4 <_vfprintf_r+0x134c>
   11fdc:	000c2c83          	lw	s9,0(s8)
   11fe0:	0100006f          	j	11ff0 <_vfprintf_r+0x1358>
   11fe4:	04047793          	andi	a5,s0,64
   11fe8:	00078863          	beqz	a5,11ff8 <_vfprintf_r+0x1360>
   11fec:	000c5c83          	lhu	s9,0(s8)
   11ff0:	00000c13          	li	s8,0
   11ff4:	f49fe06f          	j	10f3c <_vfprintf_r+0x2a4>
   11ff8:	20047793          	andi	a5,s0,512
   11ffc:	fe0780e3          	beqz	a5,11fdc <_vfprintf_r+0x1344>
   12000:	000c4c83          	lbu	s9,0(s8)
   12004:	fedff06f          	j	11ff0 <_vfprintf_r+0x1358>
   12008:	00040713          	mv	a4,s0
   1200c:	00100793          	li	a5,1
   12010:	e69ff06f          	j	11e78 <_vfprintf_r+0x11e0>
   12014:	00100713          	li	a4,1
   12018:	c0e78063          	beq	a5,a4,11418 <_vfprintf_r+0x780>
   1201c:	00200713          	li	a4,2
   12020:	12e78263          	beq	a5,a4,12144 <_vfprintf_r+0x14ac>
   12024:	1b010793          	addi	a5,sp,432
   12028:	01dc1693          	slli	a3,s8,0x1d
   1202c:	007cf713          	andi	a4,s9,7
   12030:	003cdc93          	srli	s9,s9,0x3
   12034:	03070713          	addi	a4,a4,48
   12038:	0196ecb3          	or	s9,a3,s9
   1203c:	003c5c13          	srli	s8,s8,0x3
   12040:	fee78fa3          	sb	a4,-1(a5)
   12044:	018ce6b3          	or	a3,s9,s8
   12048:	fff78493          	addi	s1,a5,-1
   1204c:	02069e63          	bnez	a3,12088 <_vfprintf_r+0x13f0>
   12050:	00147693          	andi	a3,s0,1
   12054:	00068a63          	beqz	a3,12068 <_vfprintf_r+0x13d0>
   12058:	03000693          	li	a3,48
   1205c:	00d70663          	beq	a4,a3,12068 <_vfprintf_r+0x13d0>
   12060:	fed48fa3          	sb	a3,-1(s1)
   12064:	ffe78493          	addi	s1,a5,-2
   12068:	1b010793          	addi	a5,sp,432
   1206c:	000b0a93          	mv	s5,s6
   12070:	00012823          	sw	zero,16(sp)
   12074:	40978b33          	sub	s6,a5,s1
   12078:	00000c13          	li	s8,0
   1207c:	00000b93          	li	s7,0
   12080:	00000c93          	li	s9,0
   12084:	8b8ff06f          	j	1113c <_vfprintf_r+0x4a4>
   12088:	00048793          	mv	a5,s1
   1208c:	f9dff06f          	j	12028 <_vfprintf_r+0x1390>
   12090:	00000a13          	li	s4,0
   12094:	1b010d93          	addi	s11,sp,432
   12098:	40047a93          	andi	s5,s0,1024
   1209c:	00900b93          	li	s7,9
   120a0:	00a00613          	li	a2,10
   120a4:	00000693          	li	a3,0
   120a8:	000c8513          	mv	a0,s9
   120ac:	000c0593          	mv	a1,s8
   120b0:	3b90a0ef          	jal	ra,1cc68 <__umoddi3>
   120b4:	03050513          	addi	a0,a0,48
   120b8:	fead8fa3          	sb	a0,-1(s11)
   120bc:	fffd8493          	addi	s1,s11,-1
   120c0:	001a0a13          	addi	s4,s4,1
   120c4:	040a8a63          	beqz	s5,12118 <_vfprintf_r+0x1480>
   120c8:	01412783          	lw	a5,20(sp)
   120cc:	0007c783          	lbu	a5,0(a5)
   120d0:	04fa1463          	bne	s4,a5,12118 <_vfprintf_r+0x1480>
   120d4:	0ff00793          	li	a5,255
   120d8:	04fa0063          	beq	s4,a5,12118 <_vfprintf_r+0x1480>
   120dc:	000c1463          	bnez	s8,120e4 <_vfprintf_r+0x144c>
   120e0:	039bfc63          	bleu	s9,s7,12118 <_vfprintf_r+0x1480>
   120e4:	03412783          	lw	a5,52(sp)
   120e8:	03c12583          	lw	a1,60(sp)
   120ec:	00000a13          	li	s4,0
   120f0:	40f484b3          	sub	s1,s1,a5
   120f4:	00078613          	mv	a2,a5
   120f8:	00048513          	mv	a0,s1
   120fc:	4d9050ef          	jal	ra,17dd4 <strncpy>
   12100:	01412783          	lw	a5,20(sp)
   12104:	0017c783          	lbu	a5,1(a5)
   12108:	00078863          	beqz	a5,12118 <_vfprintf_r+0x1480>
   1210c:	01412783          	lw	a5,20(sp)
   12110:	00178793          	addi	a5,a5,1
   12114:	00f12a23          	sw	a5,20(sp)
   12118:	000c8513          	mv	a0,s9
   1211c:	000c0593          	mv	a1,s8
   12120:	00a00613          	li	a2,10
   12124:	00000693          	li	a3,0
   12128:	5640a0ef          	jal	ra,1c68c <__udivdi3>
   1212c:	00058c13          	mv	s8,a1
   12130:	00a5e5b3          	or	a1,a1,a0
   12134:	00050c93          	mv	s9,a0
   12138:	f20588e3          	beqz	a1,12068 <_vfprintf_r+0x13d0>
   1213c:	00048d93          	mv	s11,s1
   12140:	f61ff06f          	j	120a0 <_vfprintf_r+0x1408>
   12144:	1b010493          	addi	s1,sp,432
   12148:	04412703          	lw	a4,68(sp)
   1214c:	00fcf793          	andi	a5,s9,15
   12150:	fff48493          	addi	s1,s1,-1
   12154:	00f707b3          	add	a5,a4,a5
   12158:	0007c783          	lbu	a5,0(a5)
   1215c:	004cdc93          	srli	s9,s9,0x4
   12160:	00f48023          	sb	a5,0(s1)
   12164:	01cc1793          	slli	a5,s8,0x1c
   12168:	0197ecb3          	or	s9,a5,s9
   1216c:	004c5c13          	srli	s8,s8,0x4
   12170:	018ce7b3          	or	a5,s9,s8
   12174:	fc079ae3          	bnez	a5,12148 <_vfprintf_r+0x14b0>
   12178:	ef1ff06f          	j	12068 <_vfprintf_r+0x13d0>
   1217c:	1b010493          	addi	s1,sp,432
   12180:	ee0794e3          	bnez	a5,12068 <_vfprintf_r+0x13d0>
   12184:	00177713          	andi	a4,a4,1
   12188:	ee0700e3          	beqz	a4,12068 <_vfprintf_r+0x13d0>
   1218c:	03000793          	li	a5,48
   12190:	1af107a3          	sb	a5,431(sp)
   12194:	a98ff06f          	j	1142c <_vfprintf_r+0x794>
   12198:	00c12783          	lw	a5,12(sp)
   1219c:	2e078ce3          	beqz	a5,12c94 <_vfprintf_r+0x1ffc>
   121a0:	00c14783          	lbu	a5,12(sp)
   121a4:	0c0103a3          	sb	zero,199(sp)
   121a8:	01812e23          	sw	s8,28(sp)
   121ac:	14f10623          	sb	a5,332(sp)
   121b0:	f71fe06f          	j	11120 <_vfprintf_r+0x488>
   121b4:	01060613          	addi	a2,a2,16
   121b8:	01dd2223          	sw	t4,4(s10)
   121bc:	0ec12623          	sw	a2,236(sp)
   121c0:	0ed12423          	sw	a3,232(sp)
   121c4:	02df5e63          	ble	a3,t5,12200 <_vfprintf_r+0x1568>
   121c8:	0e410613          	addi	a2,sp,228
   121cc:	00090593          	mv	a1,s2
   121d0:	00098513          	mv	a0,s3
   121d4:	05e12c23          	sw	t5,88(sp)
   121d8:	05c12a23          	sw	t3,84(sp)
   121dc:	05d12823          	sw	t4,80(sp)
   121e0:	04e12623          	sw	a4,76(sp)
   121e4:	3f9070ef          	jal	ra,19ddc <__sprint_r>
   121e8:	240514e3          	bnez	a0,12c30 <_vfprintf_r+0x1f98>
   121ec:	05812f03          	lw	t5,88(sp)
   121f0:	05412e03          	lw	t3,84(sp)
   121f4:	05012e83          	lw	t4,80(sp)
   121f8:	04c12703          	lw	a4,76(sp)
   121fc:	10c10593          	addi	a1,sp,268
   12200:	ff070713          	addi	a4,a4,-16
   12204:	00058d13          	mv	s10,a1
   12208:	f95fe06f          	j	1119c <_vfprintf_r+0x504>
   1220c:	01812583          	lw	a1,24(sp)
   12210:	01068693          	addi	a3,a3,16
   12214:	00fd2223          	sw	a5,4(s10)
   12218:	00bd2023          	sw	a1,0(s10)
   1221c:	0ed12623          	sw	a3,236(sp)
   12220:	0ee12423          	sw	a4,232(sp)
   12224:	02ee5663          	ble	a4,t3,12250 <_vfprintf_r+0x15b8>
   12228:	0e410613          	addi	a2,sp,228
   1222c:	00090593          	mv	a1,s2
   12230:	00098513          	mv	a0,s3
   12234:	05c12623          	sw	t3,76(sp)
   12238:	04f12423          	sw	a5,72(sp)
   1223c:	3a1070ef          	jal	ra,19ddc <__sprint_r>
   12240:	1e0518e3          	bnez	a0,12c30 <_vfprintf_r+0x1f98>
   12244:	04c12e03          	lw	t3,76(sp)
   12248:	04812783          	lw	a5,72(sp)
   1224c:	10c10613          	addi	a2,sp,268
   12250:	ff0d8d93          	addi	s11,s11,-16
   12254:	00060d13          	mv	s10,a2
   12258:	868ff06f          	j	112c0 <_vfprintf_r+0x628>
   1225c:	01068693          	addi	a3,a3,16
   12260:	01bd2223          	sw	s11,4(s10)
   12264:	0ed12623          	sw	a3,236(sp)
   12268:	0ee12423          	sw	a4,232(sp)
   1226c:	02e85263          	ble	a4,a6,12290 <_vfprintf_r+0x15f8>
   12270:	0e410613          	addi	a2,sp,228
   12274:	00090593          	mv	a1,s2
   12278:	00098513          	mv	a0,s3
   1227c:	05012423          	sw	a6,72(sp)
   12280:	35d070ef          	jal	ra,19ddc <__sprint_r>
   12284:	1a0516e3          	bnez	a0,12c30 <_vfprintf_r+0x1f98>
   12288:	04812803          	lw	a6,72(sp)
   1228c:	10c10613          	addi	a2,sp,268
   12290:	ff0a8a93          	addi	s5,s5,-16
   12294:	00060d13          	mv	s10,a2
   12298:	88cff06f          	j	11324 <_vfprintf_r+0x68c>
   1229c:	00c12783          	lw	a5,12(sp)
   122a0:	06500713          	li	a4,101
   122a4:	72f75463          	ble	a5,a4,129cc <_vfprintf_r+0x1d34>
   122a8:	0f012703          	lw	a4,240(sp)
   122ac:	0a010593          	addi	a1,sp,160
   122b0:	0b010513          	addi	a0,sp,176
   122b4:	0ae12823          	sw	a4,176(sp)
   122b8:	0f412703          	lw	a4,244(sp)
   122bc:	0a012023          	sw	zero,160(sp)
   122c0:	0a012223          	sw	zero,164(sp)
   122c4:	0ae12a23          	sw	a4,180(sp)
   122c8:	0f812703          	lw	a4,248(sp)
   122cc:	0a012423          	sw	zero,168(sp)
   122d0:	0a012623          	sw	zero,172(sp)
   122d4:	0ae12c23          	sw	a4,184(sp)
   122d8:	0fc12703          	lw	a4,252(sp)
   122dc:	0ae12e23          	sw	a4,188(sp)
   122e0:	5810b0ef          	jal	ra,1e060 <__eqtf2>
   122e4:	12051a63          	bnez	a0,12418 <_vfprintf_r+0x1780>
   122e8:	000227b7          	lui	a5,0x22
   122ec:	93878793          	addi	a5,a5,-1736 # 21938 <zeroes.4377+0x80>
   122f0:	00fd2023          	sw	a5,0(s10)
   122f4:	00100793          	li	a5,1
   122f8:	00fd2223          	sw	a5,4(s10)
   122fc:	0e812783          	lw	a5,232(sp)
   12300:	001d8d93          	addi	s11,s11,1
   12304:	0fb12623          	sw	s11,236(sp)
   12308:	00178793          	addi	a5,a5,1
   1230c:	0ef12423          	sw	a5,232(sp)
   12310:	00700713          	li	a4,7
   12314:	008d0d13          	addi	s10,s10,8
   12318:	00f75e63          	ble	a5,a4,12334 <_vfprintf_r+0x169c>
   1231c:	0e410613          	addi	a2,sp,228
   12320:	00090593          	mv	a1,s2
   12324:	00098513          	mv	a0,s3
   12328:	2b5070ef          	jal	ra,19ddc <__sprint_r>
   1232c:	100512e3          	bnez	a0,12c30 <_vfprintf_r+0x1f98>
   12330:	10c10d13          	addi	s10,sp,268
   12334:	0cc12783          	lw	a5,204(sp)
   12338:	0147c663          	blt	a5,s4,12344 <_vfprintf_r+0x16ac>
   1233c:	00147793          	andi	a5,s0,1
   12340:	22078263          	beqz	a5,12564 <_vfprintf_r+0x18cc>
   12344:	03812783          	lw	a5,56(sp)
   12348:	02412703          	lw	a4,36(sp)
   1234c:	008d0d13          	addi	s10,s10,8
   12350:	fefd2c23          	sw	a5,-8(s10)
   12354:	02412783          	lw	a5,36(sp)
   12358:	fefd2e23          	sw	a5,-4(s10)
   1235c:	0ec12783          	lw	a5,236(sp)
   12360:	00e787b3          	add	a5,a5,a4
   12364:	0ef12623          	sw	a5,236(sp)
   12368:	0e812783          	lw	a5,232(sp)
   1236c:	00700713          	li	a4,7
   12370:	00178793          	addi	a5,a5,1
   12374:	0ef12423          	sw	a5,232(sp)
   12378:	00f75e63          	ble	a5,a4,12394 <_vfprintf_r+0x16fc>
   1237c:	0e410613          	addi	a2,sp,228
   12380:	00090593          	mv	a1,s2
   12384:	00098513          	mv	a0,s3
   12388:	255070ef          	jal	ra,19ddc <__sprint_r>
   1238c:	0a0512e3          	bnez	a0,12c30 <_vfprintf_r+0x1f98>
   12390:	10c10d13          	addi	s10,sp,268
   12394:	fffa0493          	addi	s1,s4,-1
   12398:	1c905663          	blez	s1,12564 <_vfprintf_r+0x18cc>
   1239c:	01000a93          	li	s5,16
   123a0:	00700b93          	li	s7,7
   123a4:	01812603          	lw	a2,24(sp)
   123a8:	0e812783          	lw	a5,232(sp)
   123ac:	0ec12703          	lw	a4,236(sp)
   123b0:	00cd2023          	sw	a2,0(s10)
   123b4:	00178793          	addi	a5,a5,1
   123b8:	008d0693          	addi	a3,s10,8
   123bc:	029ac263          	blt	s5,s1,123e0 <_vfprintf_r+0x1748>
   123c0:	009d2223          	sw	s1,4(s10)
   123c4:	00e484b3          	add	s1,s1,a4
   123c8:	0e912623          	sw	s1,236(sp)
   123cc:	0ef12423          	sw	a5,232(sp)
   123d0:	00700713          	li	a4,7
   123d4:	00068d13          	mv	s10,a3
   123d8:	18f75663          	ble	a5,a4,12564 <_vfprintf_r+0x18cc>
   123dc:	fd5fe06f          	j	113b0 <_vfprintf_r+0x718>
   123e0:	01070713          	addi	a4,a4,16
   123e4:	015d2223          	sw	s5,4(s10)
   123e8:	0ee12623          	sw	a4,236(sp)
   123ec:	0ef12423          	sw	a5,232(sp)
   123f0:	00fbde63          	ble	a5,s7,1240c <_vfprintf_r+0x1774>
   123f4:	0e410613          	addi	a2,sp,228
   123f8:	00090593          	mv	a1,s2
   123fc:	00098513          	mv	a0,s3
   12400:	1dd070ef          	jal	ra,19ddc <__sprint_r>
   12404:	020516e3          	bnez	a0,12c30 <_vfprintf_r+0x1f98>
   12408:	10c10693          	addi	a3,sp,268
   1240c:	ff048493          	addi	s1,s1,-16
   12410:	00068d13          	mv	s10,a3
   12414:	f91ff06f          	j	123a4 <_vfprintf_r+0x170c>
   12418:	0cc12703          	lw	a4,204(sp)
   1241c:	1ce04a63          	bgtz	a4,125f0 <_vfprintf_r+0x1958>
   12420:	000227b7          	lui	a5,0x22
   12424:	93878793          	addi	a5,a5,-1736 # 21938 <zeroes.4377+0x80>
   12428:	00fd2023          	sw	a5,0(s10)
   1242c:	00100793          	li	a5,1
   12430:	00fd2223          	sw	a5,4(s10)
   12434:	0e812783          	lw	a5,232(sp)
   12438:	001d8d93          	addi	s11,s11,1
   1243c:	0fb12623          	sw	s11,236(sp)
   12440:	00178793          	addi	a5,a5,1
   12444:	0ef12423          	sw	a5,232(sp)
   12448:	00700713          	li	a4,7
   1244c:	008d0d13          	addi	s10,s10,8
   12450:	00f75e63          	ble	a5,a4,1246c <_vfprintf_r+0x17d4>
   12454:	0e410613          	addi	a2,sp,228
   12458:	00090593          	mv	a1,s2
   1245c:	00098513          	mv	a0,s3
   12460:	17d070ef          	jal	ra,19ddc <__sprint_r>
   12464:	7c051663          	bnez	a0,12c30 <_vfprintf_r+0x1f98>
   12468:	10c10d13          	addi	s10,sp,268
   1246c:	0cc12783          	lw	a5,204(sp)
   12470:	00079863          	bnez	a5,12480 <_vfprintf_r+0x17e8>
   12474:	000a1663          	bnez	s4,12480 <_vfprintf_r+0x17e8>
   12478:	00147793          	andi	a5,s0,1
   1247c:	0e078463          	beqz	a5,12564 <_vfprintf_r+0x18cc>
   12480:	03812783          	lw	a5,56(sp)
   12484:	02412703          	lw	a4,36(sp)
   12488:	008d0893          	addi	a7,s10,8
   1248c:	00fd2023          	sw	a5,0(s10)
   12490:	02412783          	lw	a5,36(sp)
   12494:	00fd2223          	sw	a5,4(s10)
   12498:	0ec12783          	lw	a5,236(sp)
   1249c:	00e787b3          	add	a5,a5,a4
   124a0:	0ef12623          	sw	a5,236(sp)
   124a4:	0e812783          	lw	a5,232(sp)
   124a8:	00700713          	li	a4,7
   124ac:	00178793          	addi	a5,a5,1
   124b0:	0ef12423          	sw	a5,232(sp)
   124b4:	00f75e63          	ble	a5,a4,124d0 <_vfprintf_r+0x1838>
   124b8:	0e410613          	addi	a2,sp,228
   124bc:	00090593          	mv	a1,s2
   124c0:	00098513          	mv	a0,s3
   124c4:	119070ef          	jal	ra,19ddc <__sprint_r>
   124c8:	76051463          	bnez	a0,12c30 <_vfprintf_r+0x1f98>
   124cc:	10c10893          	addi	a7,sp,268
   124d0:	0cc12a83          	lw	s5,204(sp)
   124d4:	060ad063          	bgez	s5,12534 <_vfprintf_r+0x189c>
   124d8:	41500ab3          	neg	s5,s5
   124dc:	00088713          	mv	a4,a7
   124e0:	01000b93          	li	s7,16
   124e4:	00700c13          	li	s8,7
   124e8:	01812603          	lw	a2,24(sp)
   124ec:	0e812783          	lw	a5,232(sp)
   124f0:	0ec12683          	lw	a3,236(sp)
   124f4:	00c72023          	sw	a2,0(a4)
   124f8:	00178793          	addi	a5,a5,1
   124fc:	00888893          	addi	a7,a7,8
   12500:	0b5bcc63          	blt	s7,s5,125b8 <_vfprintf_r+0x1920>
   12504:	01572223          	sw	s5,4(a4)
   12508:	00da8ab3          	add	s5,s5,a3
   1250c:	0f512623          	sw	s5,236(sp)
   12510:	0ef12423          	sw	a5,232(sp)
   12514:	00700713          	li	a4,7
   12518:	00f75e63          	ble	a5,a4,12534 <_vfprintf_r+0x189c>
   1251c:	0e410613          	addi	a2,sp,228
   12520:	00090593          	mv	a1,s2
   12524:	00098513          	mv	a0,s3
   12528:	0b5070ef          	jal	ra,19ddc <__sprint_r>
   1252c:	70051263          	bnez	a0,12c30 <_vfprintf_r+0x1f98>
   12530:	10c10893          	addi	a7,sp,268
   12534:	0ec12783          	lw	a5,236(sp)
   12538:	0098a023          	sw	s1,0(a7)
   1253c:	0148a223          	sw	s4,4(a7)
   12540:	014787b3          	add	a5,a5,s4
   12544:	0ef12623          	sw	a5,236(sp)
   12548:	0e812783          	lw	a5,232(sp)
   1254c:	00700713          	li	a4,7
   12550:	00888d13          	addi	s10,a7,8
   12554:	00178793          	addi	a5,a5,1
   12558:	0ef12423          	sw	a5,232(sp)
   1255c:	00f75463          	ble	a5,a4,12564 <_vfprintf_r+0x18cc>
   12560:	e51fe06f          	j	113b0 <_vfprintf_r+0x718>
   12564:	00447413          	andi	s0,s0,4
   12568:	66041463          	bnez	s0,12bd0 <_vfprintf_r+0x1f38>
   1256c:	02c12d03          	lw	s10,44(sp)
   12570:	03012783          	lw	a5,48(sp)
   12574:	00fd5463          	ble	a5,s10,1257c <_vfprintf_r+0x18e4>
   12578:	00078d13          	mv	s10,a5
   1257c:	02812783          	lw	a5,40(sp)
   12580:	01a787b3          	add	a5,a5,s10
   12584:	02f12423          	sw	a5,40(sp)
   12588:	0ec12783          	lw	a5,236(sp)
   1258c:	00078c63          	beqz	a5,125a4 <_vfprintf_r+0x190c>
   12590:	0e410613          	addi	a2,sp,228
   12594:	00090593          	mv	a1,s2
   12598:	00098513          	mv	a0,s3
   1259c:	041070ef          	jal	ra,19ddc <__sprint_r>
   125a0:	68051863          	bnez	a0,12c30 <_vfprintf_r+0x1f98>
   125a4:	01012783          	lw	a5,16(sp)
   125a8:	0e012423          	sw	zero,232(sp)
   125ac:	6c079c63          	bnez	a5,12c84 <_vfprintf_r+0x1fec>
   125b0:	10c10d13          	addi	s10,sp,268
   125b4:	841ff06f          	j	11df4 <_vfprintf_r+0x115c>
   125b8:	01068693          	addi	a3,a3,16
   125bc:	01772223          	sw	s7,4(a4)
   125c0:	0ed12623          	sw	a3,236(sp)
   125c4:	0ef12423          	sw	a5,232(sp)
   125c8:	00fc5e63          	ble	a5,s8,125e4 <_vfprintf_r+0x194c>
   125cc:	0e410613          	addi	a2,sp,228
   125d0:	00090593          	mv	a1,s2
   125d4:	00098513          	mv	a0,s3
   125d8:	005070ef          	jal	ra,19ddc <__sprint_r>
   125dc:	64051a63          	bnez	a0,12c30 <_vfprintf_r+0x1f98>
   125e0:	10c10893          	addi	a7,sp,268
   125e4:	ff0a8a93          	addi	s5,s5,-16
   125e8:	00088713          	mv	a4,a7
   125ec:	efdff06f          	j	124e8 <_vfprintf_r+0x1850>
   125f0:	000c8a93          	mv	s5,s9
   125f4:	019a5463          	ble	s9,s4,125fc <_vfprintf_r+0x1964>
   125f8:	000a0a93          	mv	s5,s4
   125fc:	05505263          	blez	s5,12640 <_vfprintf_r+0x19a8>
   12600:	0e812703          	lw	a4,232(sp)
   12604:	01ba8db3          	add	s11,s5,s11
   12608:	009d2023          	sw	s1,0(s10)
   1260c:	00170713          	addi	a4,a4,1
   12610:	015d2223          	sw	s5,4(s10)
   12614:	0fb12623          	sw	s11,236(sp)
   12618:	0ee12423          	sw	a4,232(sp)
   1261c:	00700693          	li	a3,7
   12620:	008d0d13          	addi	s10,s10,8
   12624:	00e6de63          	ble	a4,a3,12640 <_vfprintf_r+0x19a8>
   12628:	0e410613          	addi	a2,sp,228
   1262c:	00090593          	mv	a1,s2
   12630:	00098513          	mv	a0,s3
   12634:	7a8070ef          	jal	ra,19ddc <__sprint_r>
   12638:	5e051c63          	bnez	a0,12c30 <_vfprintf_r+0x1f98>
   1263c:	10c10d13          	addi	s10,sp,268
   12640:	000ad463          	bgez	s5,12648 <_vfprintf_r+0x19b0>
   12644:	00000a93          	li	s5,0
   12648:	415c8ab3          	sub	s5,s9,s5
   1264c:	05505e63          	blez	s5,126a8 <_vfprintf_r+0x1a10>
   12650:	01000b13          	li	s6,16
   12654:	00700d93          	li	s11,7
   12658:	01812783          	lw	a5,24(sp)
   1265c:	0e812703          	lw	a4,232(sp)
   12660:	0ec12683          	lw	a3,236(sp)
   12664:	00fd2023          	sw	a5,0(s10)
   12668:	00170713          	addi	a4,a4,1
   1266c:	008d0613          	addi	a2,s10,8
   12670:	195b4c63          	blt	s6,s5,12808 <_vfprintf_r+0x1b70>
   12674:	015d2223          	sw	s5,4(s10)
   12678:	00da8ab3          	add	s5,s5,a3
   1267c:	0f512623          	sw	s5,236(sp)
   12680:	0ee12423          	sw	a4,232(sp)
   12684:	00700693          	li	a3,7
   12688:	00060d13          	mv	s10,a2
   1268c:	00e6de63          	ble	a4,a3,126a8 <_vfprintf_r+0x1a10>
   12690:	0e410613          	addi	a2,sp,228
   12694:	00090593          	mv	a1,s2
   12698:	00098513          	mv	a0,s3
   1269c:	740070ef          	jal	ra,19ddc <__sprint_r>
   126a0:	58051863          	bnez	a0,12c30 <_vfprintf_r+0x1f98>
   126a4:	10c10d13          	addi	s10,sp,268
   126a8:	40047793          	andi	a5,s0,1024
   126ac:	01948ab3          	add	s5,s1,s9
   126b0:	02078063          	beqz	a5,126d0 <_vfprintf_r+0x1a38>
   126b4:	00700b13          	li	s6,7
   126b8:	01448db3          	add	s11,s1,s4
   126bc:	180b9263          	bnez	s7,12840 <_vfprintf_r+0x1ba8>
   126c0:	180c1263          	bnez	s8,12844 <_vfprintf_r+0x1bac>
   126c4:	014487b3          	add	a5,s1,s4
   126c8:	0157f463          	bleu	s5,a5,126d0 <_vfprintf_r+0x1a38>
   126cc:	00078a93          	mv	s5,a5
   126d0:	0cc12783          	lw	a5,204(sp)
   126d4:	0147c663          	blt	a5,s4,126e0 <_vfprintf_r+0x1a48>
   126d8:	00147793          	andi	a5,s0,1
   126dc:	04078a63          	beqz	a5,12730 <_vfprintf_r+0x1a98>
   126e0:	03812783          	lw	a5,56(sp)
   126e4:	02412703          	lw	a4,36(sp)
   126e8:	008d0d13          	addi	s10,s10,8
   126ec:	fefd2c23          	sw	a5,-8(s10)
   126f0:	02412783          	lw	a5,36(sp)
   126f4:	fefd2e23          	sw	a5,-4(s10)
   126f8:	0ec12783          	lw	a5,236(sp)
   126fc:	00e787b3          	add	a5,a5,a4
   12700:	0ef12623          	sw	a5,236(sp)
   12704:	0e812783          	lw	a5,232(sp)
   12708:	00700713          	li	a4,7
   1270c:	00178793          	addi	a5,a5,1
   12710:	0ef12423          	sw	a5,232(sp)
   12714:	00f75e63          	ble	a5,a4,12730 <_vfprintf_r+0x1a98>
   12718:	0e410613          	addi	a2,sp,228
   1271c:	00090593          	mv	a1,s2
   12720:	00098513          	mv	a0,s3
   12724:	6b8070ef          	jal	ra,19ddc <__sprint_r>
   12728:	50051463          	bnez	a0,12c30 <_vfprintf_r+0x1f98>
   1272c:	10c10d13          	addi	s10,sp,268
   12730:	014484b3          	add	s1,s1,s4
   12734:	415487b3          	sub	a5,s1,s5
   12738:	0cc12483          	lw	s1,204(sp)
   1273c:	409a04b3          	sub	s1,s4,s1
   12740:	0097d463          	ble	s1,a5,12748 <_vfprintf_r+0x1ab0>
   12744:	00078493          	mv	s1,a5
   12748:	04905463          	blez	s1,12790 <_vfprintf_r+0x1af8>
   1274c:	0ec12783          	lw	a5,236(sp)
   12750:	015d2023          	sw	s5,0(s10)
   12754:	009d2223          	sw	s1,4(s10)
   12758:	00f487b3          	add	a5,s1,a5
   1275c:	0ef12623          	sw	a5,236(sp)
   12760:	0e812783          	lw	a5,232(sp)
   12764:	00700713          	li	a4,7
   12768:	008d0d13          	addi	s10,s10,8
   1276c:	00178793          	addi	a5,a5,1
   12770:	0ef12423          	sw	a5,232(sp)
   12774:	00f75e63          	ble	a5,a4,12790 <_vfprintf_r+0x1af8>
   12778:	0e410613          	addi	a2,sp,228
   1277c:	00090593          	mv	a1,s2
   12780:	00098513          	mv	a0,s3
   12784:	658070ef          	jal	ra,19ddc <__sprint_r>
   12788:	4a051463          	bnez	a0,12c30 <_vfprintf_r+0x1f98>
   1278c:	10c10d13          	addi	s10,sp,268
   12790:	00048793          	mv	a5,s1
   12794:	0004d463          	bgez	s1,1279c <_vfprintf_r+0x1b04>
   12798:	00000793          	li	a5,0
   1279c:	0cc12483          	lw	s1,204(sp)
   127a0:	409a04b3          	sub	s1,s4,s1
   127a4:	40f484b3          	sub	s1,s1,a5
   127a8:	da905ee3          	blez	s1,12564 <_vfprintf_r+0x18cc>
   127ac:	01000a93          	li	s5,16
   127b0:	00700b93          	li	s7,7
   127b4:	01812603          	lw	a2,24(sp)
   127b8:	0e812783          	lw	a5,232(sp)
   127bc:	0ec12703          	lw	a4,236(sp)
   127c0:	00cd2023          	sw	a2,0(s10)
   127c4:	00178793          	addi	a5,a5,1
   127c8:	008d0693          	addi	a3,s10,8
   127cc:	be9adae3          	ble	s1,s5,123c0 <_vfprintf_r+0x1728>
   127d0:	01070713          	addi	a4,a4,16
   127d4:	015d2223          	sw	s5,4(s10)
   127d8:	0ee12623          	sw	a4,236(sp)
   127dc:	0ef12423          	sw	a5,232(sp)
   127e0:	00fbde63          	ble	a5,s7,127fc <_vfprintf_r+0x1b64>
   127e4:	0e410613          	addi	a2,sp,228
   127e8:	00090593          	mv	a1,s2
   127ec:	00098513          	mv	a0,s3
   127f0:	5ec070ef          	jal	ra,19ddc <__sprint_r>
   127f4:	42051e63          	bnez	a0,12c30 <_vfprintf_r+0x1f98>
   127f8:	10c10693          	addi	a3,sp,268
   127fc:	ff048493          	addi	s1,s1,-16
   12800:	00068d13          	mv	s10,a3
   12804:	fb1ff06f          	j	127b4 <_vfprintf_r+0x1b1c>
   12808:	01068693          	addi	a3,a3,16
   1280c:	016d2223          	sw	s6,4(s10)
   12810:	0ed12623          	sw	a3,236(sp)
   12814:	0ee12423          	sw	a4,232(sp)
   12818:	00edde63          	ble	a4,s11,12834 <_vfprintf_r+0x1b9c>
   1281c:	0e410613          	addi	a2,sp,228
   12820:	00090593          	mv	a1,s2
   12824:	00098513          	mv	a0,s3
   12828:	5b4070ef          	jal	ra,19ddc <__sprint_r>
   1282c:	40051263          	bnez	a0,12c30 <_vfprintf_r+0x1f98>
   12830:	10c10613          	addi	a2,sp,268
   12834:	ff0a8a93          	addi	s5,s5,-16
   12838:	00060d13          	mv	s10,a2
   1283c:	e1dff06f          	j	12658 <_vfprintf_r+0x19c0>
   12840:	0e0c0263          	beqz	s8,12924 <_vfprintf_r+0x1c8c>
   12844:	fffc0c13          	addi	s8,s8,-1
   12848:	03c12783          	lw	a5,60(sp)
   1284c:	03412703          	lw	a4,52(sp)
   12850:	008d0d13          	addi	s10,s10,8
   12854:	fefd2c23          	sw	a5,-8(s10)
   12858:	03412783          	lw	a5,52(sp)
   1285c:	fefd2e23          	sw	a5,-4(s10)
   12860:	0ec12783          	lw	a5,236(sp)
   12864:	00e787b3          	add	a5,a5,a4
   12868:	0ef12623          	sw	a5,236(sp)
   1286c:	0e812783          	lw	a5,232(sp)
   12870:	00178793          	addi	a5,a5,1
   12874:	0ef12423          	sw	a5,232(sp)
   12878:	00fb5e63          	ble	a5,s6,12894 <_vfprintf_r+0x1bfc>
   1287c:	0e410613          	addi	a2,sp,228
   12880:	00090593          	mv	a1,s2
   12884:	00098513          	mv	a0,s3
   12888:	554070ef          	jal	ra,19ddc <__sprint_r>
   1288c:	3a051263          	bnez	a0,12c30 <_vfprintf_r+0x1f98>
   12890:	10c10d13          	addi	s10,sp,268
   12894:	01412783          	lw	a5,20(sp)
   12898:	415d8733          	sub	a4,s11,s5
   1289c:	0007c783          	lbu	a5,0(a5)
   128a0:	00f75463          	ble	a5,a4,128a8 <_vfprintf_r+0x1c10>
   128a4:	00070793          	mv	a5,a4
   128a8:	04f05663          	blez	a5,128f4 <_vfprintf_r+0x1c5c>
   128ac:	0ec12703          	lw	a4,236(sp)
   128b0:	015d2023          	sw	s5,0(s10)
   128b4:	00fd2223          	sw	a5,4(s10)
   128b8:	00e78733          	add	a4,a5,a4
   128bc:	0ee12623          	sw	a4,236(sp)
   128c0:	0e812703          	lw	a4,232(sp)
   128c4:	008d0d13          	addi	s10,s10,8
   128c8:	00170713          	addi	a4,a4,1
   128cc:	0ee12423          	sw	a4,232(sp)
   128d0:	02eb5263          	ble	a4,s6,128f4 <_vfprintf_r+0x1c5c>
   128d4:	0e410613          	addi	a2,sp,228
   128d8:	00090593          	mv	a1,s2
   128dc:	00098513          	mv	a0,s3
   128e0:	00f12623          	sw	a5,12(sp)
   128e4:	4f8070ef          	jal	ra,19ddc <__sprint_r>
   128e8:	34051463          	bnez	a0,12c30 <_vfprintf_r+0x1f98>
   128ec:	00c12783          	lw	a5,12(sp)
   128f0:	10c10d13          	addi	s10,sp,268
   128f4:	00078713          	mv	a4,a5
   128f8:	0007d463          	bgez	a5,12900 <_vfprintf_r+0x1c68>
   128fc:	00000713          	li	a4,0
   12900:	01412783          	lw	a5,20(sp)
   12904:	01000813          	li	a6,16
   12908:	0007c783          	lbu	a5,0(a5)
   1290c:	40e787b3          	sub	a5,a5,a4
   12910:	06f04663          	bgtz	a5,1297c <_vfprintf_r+0x1ce4>
   12914:	01412783          	lw	a5,20(sp)
   12918:	0007c783          	lbu	a5,0(a5)
   1291c:	00fa8ab3          	add	s5,s5,a5
   12920:	d9dff06f          	j	126bc <_vfprintf_r+0x1a24>
   12924:	01412783          	lw	a5,20(sp)
   12928:	fffb8b93          	addi	s7,s7,-1
   1292c:	fff78793          	addi	a5,a5,-1
   12930:	00f12a23          	sw	a5,20(sp)
   12934:	f15ff06f          	j	12848 <_vfprintf_r+0x1bb0>
   12938:	01068693          	addi	a3,a3,16
   1293c:	010d2223          	sw	a6,4(s10)
   12940:	0ed12623          	sw	a3,236(sp)
   12944:	0ee12423          	sw	a4,232(sp)
   12948:	02eb5663          	ble	a4,s6,12974 <_vfprintf_r+0x1cdc>
   1294c:	0e410613          	addi	a2,sp,228
   12950:	00090593          	mv	a1,s2
   12954:	00098513          	mv	a0,s3
   12958:	05012423          	sw	a6,72(sp)
   1295c:	00f12623          	sw	a5,12(sp)
   12960:	47c070ef          	jal	ra,19ddc <__sprint_r>
   12964:	2c051663          	bnez	a0,12c30 <_vfprintf_r+0x1f98>
   12968:	04812803          	lw	a6,72(sp)
   1296c:	00c12783          	lw	a5,12(sp)
   12970:	10c10613          	addi	a2,sp,268
   12974:	ff078793          	addi	a5,a5,-16
   12978:	00060d13          	mv	s10,a2
   1297c:	01812583          	lw	a1,24(sp)
   12980:	0e812703          	lw	a4,232(sp)
   12984:	0ec12683          	lw	a3,236(sp)
   12988:	00bd2023          	sw	a1,0(s10)
   1298c:	00170713          	addi	a4,a4,1
   12990:	008d0613          	addi	a2,s10,8
   12994:	faf842e3          	blt	a6,a5,12938 <_vfprintf_r+0x1ca0>
   12998:	00fd2223          	sw	a5,4(s10)
   1299c:	00d787b3          	add	a5,a5,a3
   129a0:	0ef12623          	sw	a5,236(sp)
   129a4:	0ee12423          	sw	a4,232(sp)
   129a8:	00060d13          	mv	s10,a2
   129ac:	f6eb54e3          	ble	a4,s6,12914 <_vfprintf_r+0x1c7c>
   129b0:	0e410613          	addi	a2,sp,228
   129b4:	00090593          	mv	a1,s2
   129b8:	00098513          	mv	a0,s3
   129bc:	420070ef          	jal	ra,19ddc <__sprint_r>
   129c0:	26051863          	bnez	a0,12c30 <_vfprintf_r+0x1f98>
   129c4:	10c10d13          	addi	s10,sp,268
   129c8:	f4dff06f          	j	12914 <_vfprintf_r+0x1c7c>
   129cc:	0e812783          	lw	a5,232(sp)
   129d0:	00100713          	li	a4,1
   129d4:	009d2023          	sw	s1,0(s10)
   129d8:	001d8d93          	addi	s11,s11,1
   129dc:	00178793          	addi	a5,a5,1
   129e0:	008d0b93          	addi	s7,s10,8
   129e4:	01474663          	blt	a4,s4,129f0 <_vfprintf_r+0x1d58>
   129e8:	00147693          	andi	a3,s0,1
   129ec:	1c068663          	beqz	a3,12bb8 <_vfprintf_r+0x1f20>
   129f0:	00100713          	li	a4,1
   129f4:	00ed2223          	sw	a4,4(s10)
   129f8:	0fb12623          	sw	s11,236(sp)
   129fc:	0ef12423          	sw	a5,232(sp)
   12a00:	00700713          	li	a4,7
   12a04:	00f75e63          	ble	a5,a4,12a20 <_vfprintf_r+0x1d88>
   12a08:	0e410613          	addi	a2,sp,228
   12a0c:	00090593          	mv	a1,s2
   12a10:	00098513          	mv	a0,s3
   12a14:	3c8070ef          	jal	ra,19ddc <__sprint_r>
   12a18:	20051c63          	bnez	a0,12c30 <_vfprintf_r+0x1f98>
   12a1c:	10c10b93          	addi	s7,sp,268
   12a20:	03812783          	lw	a5,56(sp)
   12a24:	02412703          	lw	a4,36(sp)
   12a28:	008b8b93          	addi	s7,s7,8
   12a2c:	fefbac23          	sw	a5,-8(s7)
   12a30:	02412783          	lw	a5,36(sp)
   12a34:	fefbae23          	sw	a5,-4(s7)
   12a38:	0ec12783          	lw	a5,236(sp)
   12a3c:	00e787b3          	add	a5,a5,a4
   12a40:	0ef12623          	sw	a5,236(sp)
   12a44:	0e812783          	lw	a5,232(sp)
   12a48:	00700713          	li	a4,7
   12a4c:	00178793          	addi	a5,a5,1
   12a50:	0ef12423          	sw	a5,232(sp)
   12a54:	00f75e63          	ble	a5,a4,12a70 <_vfprintf_r+0x1dd8>
   12a58:	0e410613          	addi	a2,sp,228
   12a5c:	00090593          	mv	a1,s2
   12a60:	00098513          	mv	a0,s3
   12a64:	378070ef          	jal	ra,19ddc <__sprint_r>
   12a68:	1c051463          	bnez	a0,12c30 <_vfprintf_r+0x1f98>
   12a6c:	10c10b93          	addi	s7,sp,268
   12a70:	0f012783          	lw	a5,240(sp)
   12a74:	0a010593          	addi	a1,sp,160
   12a78:	0b010513          	addi	a0,sp,176
   12a7c:	0af12823          	sw	a5,176(sp)
   12a80:	0f412783          	lw	a5,244(sp)
   12a84:	fffa0a93          	addi	s5,s4,-1
   12a88:	0a012023          	sw	zero,160(sp)
   12a8c:	0af12a23          	sw	a5,180(sp)
   12a90:	0f812783          	lw	a5,248(sp)
   12a94:	0a012223          	sw	zero,164(sp)
   12a98:	0a012423          	sw	zero,168(sp)
   12a9c:	0af12c23          	sw	a5,184(sp)
   12aa0:	0fc12783          	lw	a5,252(sp)
   12aa4:	0a012623          	sw	zero,172(sp)
   12aa8:	0af12e23          	sw	a5,188(sp)
   12aac:	5b40b0ef          	jal	ra,1e060 <__eqtf2>
   12ab0:	08050663          	beqz	a0,12b3c <_vfprintf_r+0x1ea4>
   12ab4:	0ec12783          	lw	a5,236(sp)
   12ab8:	0e812703          	lw	a4,232(sp)
   12abc:	00148493          	addi	s1,s1,1
   12ac0:	fff78793          	addi	a5,a5,-1
   12ac4:	014787b3          	add	a5,a5,s4
   12ac8:	00170713          	addi	a4,a4,1
   12acc:	009ba023          	sw	s1,0(s7)
   12ad0:	015ba223          	sw	s5,4(s7)
   12ad4:	0ef12623          	sw	a5,236(sp)
   12ad8:	0ee12423          	sw	a4,232(sp)
   12adc:	00700793          	li	a5,7
   12ae0:	008b8b93          	addi	s7,s7,8
   12ae4:	00e7de63          	ble	a4,a5,12b00 <_vfprintf_r+0x1e68>
   12ae8:	0e410613          	addi	a2,sp,228
   12aec:	00090593          	mv	a1,s2
   12af0:	00098513          	mv	a0,s3
   12af4:	2e8070ef          	jal	ra,19ddc <__sprint_r>
   12af8:	12051c63          	bnez	a0,12c30 <_vfprintf_r+0x1f98>
   12afc:	10c10b93          	addi	s7,sp,268
   12b00:	0d410793          	addi	a5,sp,212
   12b04:	00fba023          	sw	a5,0(s7)
   12b08:	04012783          	lw	a5,64(sp)
   12b0c:	04012703          	lw	a4,64(sp)
   12b10:	008b8d13          	addi	s10,s7,8
   12b14:	00fba223          	sw	a5,4(s7)
   12b18:	0ec12783          	lw	a5,236(sp)
   12b1c:	00e787b3          	add	a5,a5,a4
   12b20:	0ef12623          	sw	a5,236(sp)
   12b24:	0e812783          	lw	a5,232(sp)
   12b28:	00700713          	li	a4,7
   12b2c:	00178793          	addi	a5,a5,1
   12b30:	0ef12423          	sw	a5,232(sp)
   12b34:	a2f758e3          	ble	a5,a4,12564 <_vfprintf_r+0x18cc>
   12b38:	879fe06f          	j	113b0 <_vfprintf_r+0x718>
   12b3c:	fd5052e3          	blez	s5,12b00 <_vfprintf_r+0x1e68>
   12b40:	01000493          	li	s1,16
   12b44:	00700c13          	li	s8,7
   12b48:	01812603          	lw	a2,24(sp)
   12b4c:	0e812703          	lw	a4,232(sp)
   12b50:	0ec12783          	lw	a5,236(sp)
   12b54:	00cba023          	sw	a2,0(s7)
   12b58:	00170713          	addi	a4,a4,1
   12b5c:	008b8693          	addi	a3,s7,8
   12b60:	0354c063          	blt	s1,s5,12b80 <_vfprintf_r+0x1ee8>
   12b64:	00fa87b3          	add	a5,s5,a5
   12b68:	015ba223          	sw	s5,4(s7)
   12b6c:	0ef12623          	sw	a5,236(sp)
   12b70:	0ee12423          	sw	a4,232(sp)
   12b74:	00700793          	li	a5,7
   12b78:	00068b93          	mv	s7,a3
   12b7c:	f69ff06f          	j	12ae4 <_vfprintf_r+0x1e4c>
   12b80:	01078793          	addi	a5,a5,16
   12b84:	009ba223          	sw	s1,4(s7)
   12b88:	0ef12623          	sw	a5,236(sp)
   12b8c:	0ee12423          	sw	a4,232(sp)
   12b90:	00ec5e63          	ble	a4,s8,12bac <_vfprintf_r+0x1f14>
   12b94:	0e410613          	addi	a2,sp,228
   12b98:	00090593          	mv	a1,s2
   12b9c:	00098513          	mv	a0,s3
   12ba0:	23c070ef          	jal	ra,19ddc <__sprint_r>
   12ba4:	08051663          	bnez	a0,12c30 <_vfprintf_r+0x1f98>
   12ba8:	10c10693          	addi	a3,sp,268
   12bac:	ff0a8a93          	addi	s5,s5,-16
   12bb0:	00068b93          	mv	s7,a3
   12bb4:	f95ff06f          	j	12b48 <_vfprintf_r+0x1eb0>
   12bb8:	00ed2223          	sw	a4,4(s10)
   12bbc:	0fb12623          	sw	s11,236(sp)
   12bc0:	0ef12423          	sw	a5,232(sp)
   12bc4:	00700713          	li	a4,7
   12bc8:	f2f75ce3          	ble	a5,a4,12b00 <_vfprintf_r+0x1e68>
   12bcc:	f1dff06f          	j	12ae8 <_vfprintf_r+0x1e50>
   12bd0:	02c12783          	lw	a5,44(sp)
   12bd4:	03012703          	lw	a4,48(sp)
   12bd8:	40e78433          	sub	s0,a5,a4
   12bdc:	988058e3          	blez	s0,1256c <_vfprintf_r+0x18d4>
   12be0:	000224b7          	lui	s1,0x22
   12be4:	01000a93          	li	s5,16
   12be8:	8a848493          	addi	s1,s1,-1880 # 218a8 <blanks.4376>
   12bec:	00700b93          	li	s7,7
   12bf0:	0e812783          	lw	a5,232(sp)
   12bf4:	009d2023          	sw	s1,0(s10)
   12bf8:	0ec12703          	lw	a4,236(sp)
   12bfc:	00178793          	addi	a5,a5,1
   12c00:	048ac663          	blt	s5,s0,12c4c <_vfprintf_r+0x1fb4>
   12c04:	008d2223          	sw	s0,4(s10)
   12c08:	00e40433          	add	s0,s0,a4
   12c0c:	0e812623          	sw	s0,236(sp)
   12c10:	0ef12423          	sw	a5,232(sp)
   12c14:	00700713          	li	a4,7
   12c18:	94f75ae3          	ble	a5,a4,1256c <_vfprintf_r+0x18d4>
   12c1c:	0e410613          	addi	a2,sp,228
   12c20:	00090593          	mv	a1,s2
   12c24:	00098513          	mv	a0,s3
   12c28:	1b4070ef          	jal	ra,19ddc <__sprint_r>
   12c2c:	940500e3          	beqz	a0,1256c <_vfprintf_r+0x18d4>
   12c30:	01012783          	lw	a5,16(sp)
   12c34:	00079463          	bnez	a5,12c3c <_vfprintf_r+0x1fa4>
   12c38:	9d1fe06f          	j	11608 <_vfprintf_r+0x970>
   12c3c:	00078593          	mv	a1,a5
   12c40:	00098513          	mv	a0,s3
   12c44:	24d000ef          	jal	ra,13690 <_free_r>
   12c48:	9c1fe06f          	j	11608 <_vfprintf_r+0x970>
   12c4c:	01070713          	addi	a4,a4,16
   12c50:	015d2223          	sw	s5,4(s10)
   12c54:	0ee12623          	sw	a4,236(sp)
   12c58:	0ef12423          	sw	a5,232(sp)
   12c5c:	008d0d13          	addi	s10,s10,8
   12c60:	00fbde63          	ble	a5,s7,12c7c <_vfprintf_r+0x1fe4>
   12c64:	0e410613          	addi	a2,sp,228
   12c68:	00090593          	mv	a1,s2
   12c6c:	00098513          	mv	a0,s3
   12c70:	16c070ef          	jal	ra,19ddc <__sprint_r>
   12c74:	fa051ee3          	bnez	a0,12c30 <_vfprintf_r+0x1f98>
   12c78:	10c10d13          	addi	s10,sp,268
   12c7c:	ff040413          	addi	s0,s0,-16
   12c80:	f71ff06f          	j	12bf0 <_vfprintf_r+0x1f58>
   12c84:	01012583          	lw	a1,16(sp)
   12c88:	00098513          	mv	a0,s3
   12c8c:	205000ef          	jal	ra,13690 <_free_r>
   12c90:	921ff06f          	j	125b0 <_vfprintf_r+0x1918>
   12c94:	0ec12783          	lw	a5,236(sp)
   12c98:	00079463          	bnez	a5,12ca0 <_vfprintf_r+0x2008>
   12c9c:	96dfe06f          	j	11608 <_vfprintf_r+0x970>
   12ca0:	0e410613          	addi	a2,sp,228
   12ca4:	00090593          	mv	a1,s2
   12ca8:	00098513          	mv	a0,s3
   12cac:	130070ef          	jal	ra,19ddc <__sprint_r>
   12cb0:	959fe06f          	j	11608 <_vfprintf_r+0x970>

00012cb4 <vfprintf>:
   12cb4:	00060693          	mv	a3,a2
   12cb8:	00058613          	mv	a2,a1
   12cbc:	00050593          	mv	a1,a0
   12cc0:	8201a503          	lw	a0,-2016(gp) # 23f80 <_impure_ptr>
   12cc4:	fd5fd06f          	j	10c98 <_vfprintf_r>

00012cc8 <__sbprintf>:
   12cc8:	00c5d783          	lhu	a5,12(a1)
   12ccc:	b8010113          	addi	sp,sp,-1152
   12cd0:	46812c23          	sw	s0,1144(sp)
   12cd4:	ffd7f793          	andi	a5,a5,-3
   12cd8:	00f11a23          	sh	a5,20(sp)
   12cdc:	0645a783          	lw	a5,100(a1)
   12ce0:	00058413          	mv	s0,a1
   12ce4:	46912a23          	sw	s1,1140(sp)
   12ce8:	06f12623          	sw	a5,108(sp)
   12cec:	00e5d783          	lhu	a5,14(a1)
   12cf0:	47212823          	sw	s2,1136(sp)
   12cf4:	46112e23          	sw	ra,1148(sp)
   12cf8:	00f11b23          	sh	a5,22(sp)
   12cfc:	01c5a783          	lw	a5,28(a1)
   12d00:	00050913          	mv	s2,a0
   12d04:	02012023          	sw	zero,32(sp)
   12d08:	02f12223          	sw	a5,36(sp)
   12d0c:	0245a783          	lw	a5,36(a1)
   12d10:	00810593          	addi	a1,sp,8
   12d14:	02f12623          	sw	a5,44(sp)
   12d18:	07010793          	addi	a5,sp,112
   12d1c:	00f12423          	sw	a5,8(sp)
   12d20:	00f12c23          	sw	a5,24(sp)
   12d24:	40000793          	li	a5,1024
   12d28:	00f12823          	sw	a5,16(sp)
   12d2c:	00f12e23          	sw	a5,28(sp)
   12d30:	f69fd0ef          	jal	ra,10c98 <_vfprintf_r>
   12d34:	00050493          	mv	s1,a0
   12d38:	00054c63          	bltz	a0,12d50 <__sbprintf+0x88>
   12d3c:	00810593          	addi	a1,sp,8
   12d40:	00090513          	mv	a0,s2
   12d44:	504000ef          	jal	ra,13248 <_fflush_r>
   12d48:	00050463          	beqz	a0,12d50 <__sbprintf+0x88>
   12d4c:	fff00493          	li	s1,-1
   12d50:	01415783          	lhu	a5,20(sp)
   12d54:	0407f793          	andi	a5,a5,64
   12d58:	00078863          	beqz	a5,12d68 <__sbprintf+0xa0>
   12d5c:	00c45783          	lhu	a5,12(s0)
   12d60:	0407e793          	ori	a5,a5,64
   12d64:	00f41623          	sh	a5,12(s0)
   12d68:	47c12083          	lw	ra,1148(sp)
   12d6c:	47812403          	lw	s0,1144(sp)
   12d70:	00048513          	mv	a0,s1
   12d74:	47012903          	lw	s2,1136(sp)
   12d78:	47412483          	lw	s1,1140(sp)
   12d7c:	48010113          	addi	sp,sp,1152
   12d80:	00008067          	ret

00012d84 <__swsetup_r>:
   12d84:	ff010113          	addi	sp,sp,-16
   12d88:	00912223          	sw	s1,4(sp)
   12d8c:	00050493          	mv	s1,a0
   12d90:	8201a503          	lw	a0,-2016(gp) # 23f80 <_impure_ptr>
   12d94:	00812423          	sw	s0,8(sp)
   12d98:	00112623          	sw	ra,12(sp)
   12d9c:	00058413          	mv	s0,a1
   12da0:	00050863          	beqz	a0,12db0 <__swsetup_r+0x2c>
   12da4:	03852783          	lw	a5,56(a0)
   12da8:	00079463          	bnez	a5,12db0 <__swsetup_r+0x2c>
   12dac:	638000ef          	jal	ra,133e4 <__sinit>
   12db0:	00c41703          	lh	a4,12(s0)
   12db4:	01071793          	slli	a5,a4,0x10
   12db8:	0107d793          	srli	a5,a5,0x10
   12dbc:	0087f693          	andi	a3,a5,8
   12dc0:	06069e63          	bnez	a3,12e3c <__swsetup_r+0xb8>
   12dc4:	0107f693          	andi	a3,a5,16
   12dc8:	02069663          	bnez	a3,12df4 <__swsetup_r+0x70>
   12dcc:	00900793          	li	a5,9
   12dd0:	00f4a023          	sw	a5,0(s1)
   12dd4:	04076713          	ori	a4,a4,64
   12dd8:	00e41623          	sh	a4,12(s0)
   12ddc:	fff00513          	li	a0,-1
   12de0:	00c12083          	lw	ra,12(sp)
   12de4:	00812403          	lw	s0,8(sp)
   12de8:	00412483          	lw	s1,4(sp)
   12dec:	01010113          	addi	sp,sp,16
   12df0:	00008067          	ret
   12df4:	0047f793          	andi	a5,a5,4
   12df8:	02078c63          	beqz	a5,12e30 <__swsetup_r+0xac>
   12dfc:	03042583          	lw	a1,48(s0)
   12e00:	00058c63          	beqz	a1,12e18 <__swsetup_r+0x94>
   12e04:	04040793          	addi	a5,s0,64
   12e08:	00f58663          	beq	a1,a5,12e14 <__swsetup_r+0x90>
   12e0c:	00048513          	mv	a0,s1
   12e10:	081000ef          	jal	ra,13690 <_free_r>
   12e14:	02042823          	sw	zero,48(s0)
   12e18:	00c45783          	lhu	a5,12(s0)
   12e1c:	00042223          	sw	zero,4(s0)
   12e20:	fdb7f793          	andi	a5,a5,-37
   12e24:	00f41623          	sh	a5,12(s0)
   12e28:	01042783          	lw	a5,16(s0)
   12e2c:	00f42023          	sw	a5,0(s0)
   12e30:	00c45783          	lhu	a5,12(s0)
   12e34:	0087e793          	ori	a5,a5,8
   12e38:	00f41623          	sh	a5,12(s0)
   12e3c:	01042783          	lw	a5,16(s0)
   12e40:	02079063          	bnez	a5,12e60 <__swsetup_r+0xdc>
   12e44:	00c45783          	lhu	a5,12(s0)
   12e48:	20000713          	li	a4,512
   12e4c:	2807f793          	andi	a5,a5,640
   12e50:	00e78863          	beq	a5,a4,12e60 <__swsetup_r+0xdc>
   12e54:	00040593          	mv	a1,s0
   12e58:	00048513          	mv	a0,s1
   12e5c:	260030ef          	jal	ra,160bc <__smakebuf_r>
   12e60:	00c45783          	lhu	a5,12(s0)
   12e64:	0017f713          	andi	a4,a5,1
   12e68:	02070c63          	beqz	a4,12ea0 <__swsetup_r+0x11c>
   12e6c:	01442783          	lw	a5,20(s0)
   12e70:	00042423          	sw	zero,8(s0)
   12e74:	40f007b3          	neg	a5,a5
   12e78:	00f42c23          	sw	a5,24(s0)
   12e7c:	01042783          	lw	a5,16(s0)
   12e80:	00000513          	li	a0,0
   12e84:	f4079ee3          	bnez	a5,12de0 <__swsetup_r+0x5c>
   12e88:	00c41783          	lh	a5,12(s0)
   12e8c:	0807f713          	andi	a4,a5,128
   12e90:	f40708e3          	beqz	a4,12de0 <__swsetup_r+0x5c>
   12e94:	0407e793          	ori	a5,a5,64
   12e98:	00f41623          	sh	a5,12(s0)
   12e9c:	f41ff06f          	j	12ddc <__swsetup_r+0x58>
   12ea0:	0027f793          	andi	a5,a5,2
   12ea4:	00000713          	li	a4,0
   12ea8:	00079463          	bnez	a5,12eb0 <__swsetup_r+0x12c>
   12eac:	01442703          	lw	a4,20(s0)
   12eb0:	00e42423          	sw	a4,8(s0)
   12eb4:	fc9ff06f          	j	12e7c <__swsetup_r+0xf8>

00012eb8 <__register_exitproc>:
   12eb8:	81c1a703          	lw	a4,-2020(gp) # 23f7c <_global_impure_ptr>
   12ebc:	00050313          	mv	t1,a0
   12ec0:	14872783          	lw	a5,328(a4)
   12ec4:	00079663          	bnez	a5,12ed0 <__register_exitproc+0x18>
   12ec8:	14c70793          	addi	a5,a4,332
   12ecc:	14f72423          	sw	a5,328(a4)
   12ed0:	0047a703          	lw	a4,4(a5)
   12ed4:	01f00813          	li	a6,31
   12ed8:	fff00513          	li	a0,-1
   12edc:	04e84a63          	blt	a6,a4,12f30 <__register_exitproc+0x78>
   12ee0:	00271893          	slli	a7,a4,0x2
   12ee4:	02030c63          	beqz	t1,12f1c <__register_exitproc+0x64>
   12ee8:	01178533          	add	a0,a5,a7
   12eec:	08c52423          	sw	a2,136(a0)
   12ef0:	1887a803          	lw	a6,392(a5)
   12ef4:	00100613          	li	a2,1
   12ef8:	00e61633          	sll	a2,a2,a4
   12efc:	00c86833          	or	a6,a6,a2
   12f00:	1907a423          	sw	a6,392(a5)
   12f04:	10d52423          	sw	a3,264(a0)
   12f08:	00200693          	li	a3,2
   12f0c:	00d31863          	bne	t1,a3,12f1c <__register_exitproc+0x64>
   12f10:	18c7a683          	lw	a3,396(a5)
   12f14:	00c6e633          	or	a2,a3,a2
   12f18:	18c7a623          	sw	a2,396(a5)
   12f1c:	00170713          	addi	a4,a4,1
   12f20:	00e7a223          	sw	a4,4(a5)
   12f24:	011787b3          	add	a5,a5,a7
   12f28:	00b7a423          	sw	a1,8(a5)
   12f2c:	00000513          	li	a0,0
   12f30:	00008067          	ret

00012f34 <__call_exitprocs>:
   12f34:	fd010113          	addi	sp,sp,-48
   12f38:	01312e23          	sw	s3,28(sp)
   12f3c:	81c1a983          	lw	s3,-2020(gp) # 23f7c <_global_impure_ptr>
   12f40:	01412c23          	sw	s4,24(sp)
   12f44:	01512a23          	sw	s5,20(sp)
   12f48:	01612823          	sw	s6,16(sp)
   12f4c:	02112623          	sw	ra,44(sp)
   12f50:	02812423          	sw	s0,40(sp)
   12f54:	02912223          	sw	s1,36(sp)
   12f58:	03212023          	sw	s2,32(sp)
   12f5c:	01712623          	sw	s7,12(sp)
   12f60:	00050a93          	mv	s5,a0
   12f64:	00058a13          	mv	s4,a1
   12f68:	00100b13          	li	s6,1
   12f6c:	1489a483          	lw	s1,328(s3)
   12f70:	00048c63          	beqz	s1,12f88 <__call_exitprocs+0x54>
   12f74:	0044a403          	lw	s0,4(s1)
   12f78:	fff40913          	addi	s2,s0,-1
   12f7c:	00241413          	slli	s0,s0,0x2
   12f80:	00848433          	add	s0,s1,s0
   12f84:	02095863          	bgez	s2,12fb4 <__call_exitprocs+0x80>
   12f88:	02c12083          	lw	ra,44(sp)
   12f8c:	02812403          	lw	s0,40(sp)
   12f90:	02412483          	lw	s1,36(sp)
   12f94:	02012903          	lw	s2,32(sp)
   12f98:	01c12983          	lw	s3,28(sp)
   12f9c:	01812a03          	lw	s4,24(sp)
   12fa0:	01412a83          	lw	s5,20(sp)
   12fa4:	01012b03          	lw	s6,16(sp)
   12fa8:	00c12b83          	lw	s7,12(sp)
   12fac:	03010113          	addi	sp,sp,48
   12fb0:	00008067          	ret
   12fb4:	000a0c63          	beqz	s4,12fcc <__call_exitprocs+0x98>
   12fb8:	10442783          	lw	a5,260(s0)
   12fbc:	01478863          	beq	a5,s4,12fcc <__call_exitprocs+0x98>
   12fc0:	fff90913          	addi	s2,s2,-1
   12fc4:	ffc40413          	addi	s0,s0,-4
   12fc8:	fbdff06f          	j	12f84 <__call_exitprocs+0x50>
   12fcc:	0044a703          	lw	a4,4(s1)
   12fd0:	00442783          	lw	a5,4(s0)
   12fd4:	fff70713          	addi	a4,a4,-1
   12fd8:	03271c63          	bne	a4,s2,13010 <__call_exitprocs+0xdc>
   12fdc:	0124a223          	sw	s2,4(s1)
   12fe0:	fe0780e3          	beqz	a5,12fc0 <__call_exitprocs+0x8c>
   12fe4:	1884a683          	lw	a3,392(s1)
   12fe8:	012b1733          	sll	a4,s6,s2
   12fec:	0044ab83          	lw	s7,4(s1)
   12ff0:	00d776b3          	and	a3,a4,a3
   12ff4:	02069263          	bnez	a3,13018 <__call_exitprocs+0xe4>
   12ff8:	000780e7          	jalr	a5
   12ffc:	0044a703          	lw	a4,4(s1)
   13000:	1489a783          	lw	a5,328(s3)
   13004:	f77714e3          	bne	a4,s7,12f6c <__call_exitprocs+0x38>
   13008:	faf48ce3          	beq	s1,a5,12fc0 <__call_exitprocs+0x8c>
   1300c:	f61ff06f          	j	12f6c <__call_exitprocs+0x38>
   13010:	00042223          	sw	zero,4(s0)
   13014:	fcdff06f          	j	12fe0 <__call_exitprocs+0xac>
   13018:	18c4a683          	lw	a3,396(s1)
   1301c:	08442583          	lw	a1,132(s0)
   13020:	00d77733          	and	a4,a4,a3
   13024:	00071863          	bnez	a4,13034 <__call_exitprocs+0x100>
   13028:	000a8513          	mv	a0,s5
   1302c:	000780e7          	jalr	a5
   13030:	fcdff06f          	j	12ffc <__call_exitprocs+0xc8>
   13034:	00058513          	mv	a0,a1
   13038:	000780e7          	jalr	a5
   1303c:	fc1ff06f          	j	12ffc <__call_exitprocs+0xc8>

00013040 <__sflush_r>:
   13040:	00c59783          	lh	a5,12(a1)
   13044:	fe010113          	addi	sp,sp,-32
   13048:	00812c23          	sw	s0,24(sp)
   1304c:	01079713          	slli	a4,a5,0x10
   13050:	01075713          	srli	a4,a4,0x10
   13054:	00912a23          	sw	s1,20(sp)
   13058:	00112e23          	sw	ra,28(sp)
   1305c:	01212823          	sw	s2,16(sp)
   13060:	01312623          	sw	s3,12(sp)
   13064:	00877693          	andi	a3,a4,8
   13068:	00050493          	mv	s1,a0
   1306c:	00058413          	mv	s0,a1
   13070:	16069c63          	bnez	a3,131e8 <__sflush_r+0x1a8>
   13074:	00001737          	lui	a4,0x1
   13078:	80070713          	addi	a4,a4,-2048 # 800 <main-0xf874>
   1307c:	00e7e7b3          	or	a5,a5,a4
   13080:	0045a703          	lw	a4,4(a1)
   13084:	00f59623          	sh	a5,12(a1)
   13088:	02e04663          	bgtz	a4,130b4 <__sflush_r+0x74>
   1308c:	03c5a703          	lw	a4,60(a1)
   13090:	02e04263          	bgtz	a4,130b4 <__sflush_r+0x74>
   13094:	00000513          	li	a0,0
   13098:	01c12083          	lw	ra,28(sp)
   1309c:	01812403          	lw	s0,24(sp)
   130a0:	01412483          	lw	s1,20(sp)
   130a4:	01012903          	lw	s2,16(sp)
   130a8:	00c12983          	lw	s3,12(sp)
   130ac:	02010113          	addi	sp,sp,32
   130b0:	00008067          	ret
   130b4:	02842703          	lw	a4,40(s0)
   130b8:	fc070ee3          	beqz	a4,13094 <__sflush_r+0x54>
   130bc:	0004a903          	lw	s2,0(s1)
   130c0:	01379693          	slli	a3,a5,0x13
   130c4:	0004a023          	sw	zero,0(s1)
   130c8:	01c42583          	lw	a1,28(s0)
   130cc:	0c06d863          	bgez	a3,1319c <__sflush_r+0x15c>
   130d0:	05042603          	lw	a2,80(s0)
   130d4:	00c45783          	lhu	a5,12(s0)
   130d8:	0047f793          	andi	a5,a5,4
   130dc:	00078e63          	beqz	a5,130f8 <__sflush_r+0xb8>
   130e0:	00442783          	lw	a5,4(s0)
   130e4:	40f60633          	sub	a2,a2,a5
   130e8:	03042783          	lw	a5,48(s0)
   130ec:	00078663          	beqz	a5,130f8 <__sflush_r+0xb8>
   130f0:	03c42783          	lw	a5,60(s0)
   130f4:	40f60633          	sub	a2,a2,a5
   130f8:	02842783          	lw	a5,40(s0)
   130fc:	01c42583          	lw	a1,28(s0)
   13100:	00000693          	li	a3,0
   13104:	00048513          	mv	a0,s1
   13108:	000780e7          	jalr	a5
   1310c:	fff00793          	li	a5,-1
   13110:	00c45683          	lhu	a3,12(s0)
   13114:	02f51263          	bne	a0,a5,13138 <__sflush_r+0xf8>
   13118:	0004a783          	lw	a5,0(s1)
   1311c:	01d00713          	li	a4,29
   13120:	0af76c63          	bltu	a4,a5,131d8 <__sflush_r+0x198>
   13124:	20400737          	lui	a4,0x20400
   13128:	00170713          	addi	a4,a4,1 # 20400001 <__global_pointer$+0x203db8a1>
   1312c:	00f75733          	srl	a4,a4,a5
   13130:	00177713          	andi	a4,a4,1
   13134:	0a070263          	beqz	a4,131d8 <__sflush_r+0x198>
   13138:	fffff7b7          	lui	a5,0xfffff
   1313c:	7ff78793          	addi	a5,a5,2047 # fffff7ff <__global_pointer$+0xfffdb09f>
   13140:	01042703          	lw	a4,16(s0)
   13144:	00d7f7b3          	and	a5,a5,a3
   13148:	01079793          	slli	a5,a5,0x10
   1314c:	4107d793          	srai	a5,a5,0x10
   13150:	00e42023          	sw	a4,0(s0)
   13154:	00f41623          	sh	a5,12(s0)
   13158:	00042223          	sw	zero,4(s0)
   1315c:	01379713          	slli	a4,a5,0x13
   13160:	00075c63          	bgez	a4,13178 <__sflush_r+0x138>
   13164:	fff00793          	li	a5,-1
   13168:	00f51663          	bne	a0,a5,13174 <__sflush_r+0x134>
   1316c:	0004a783          	lw	a5,0(s1)
   13170:	00079463          	bnez	a5,13178 <__sflush_r+0x138>
   13174:	04a42823          	sw	a0,80(s0)
   13178:	03042583          	lw	a1,48(s0)
   1317c:	0124a023          	sw	s2,0(s1)
   13180:	f0058ae3          	beqz	a1,13094 <__sflush_r+0x54>
   13184:	04040793          	addi	a5,s0,64
   13188:	00f58663          	beq	a1,a5,13194 <__sflush_r+0x154>
   1318c:	00048513          	mv	a0,s1
   13190:	500000ef          	jal	ra,13690 <_free_r>
   13194:	02042823          	sw	zero,48(s0)
   13198:	efdff06f          	j	13094 <__sflush_r+0x54>
   1319c:	00000613          	li	a2,0
   131a0:	00100693          	li	a3,1
   131a4:	00048513          	mv	a0,s1
   131a8:	000700e7          	jalr	a4
   131ac:	fff00793          	li	a5,-1
   131b0:	00050613          	mv	a2,a0
   131b4:	f2f510e3          	bne	a0,a5,130d4 <__sflush_r+0x94>
   131b8:	0004a783          	lw	a5,0(s1)
   131bc:	f0078ce3          	beqz	a5,130d4 <__sflush_r+0x94>
   131c0:	01d00713          	li	a4,29
   131c4:	00e78663          	beq	a5,a4,131d0 <__sflush_r+0x190>
   131c8:	01600713          	li	a4,22
   131cc:	06e79263          	bne	a5,a4,13230 <__sflush_r+0x1f0>
   131d0:	0124a023          	sw	s2,0(s1)
   131d4:	ec1ff06f          	j	13094 <__sflush_r+0x54>
   131d8:	0406e793          	ori	a5,a3,64
   131dc:	00f41623          	sh	a5,12(s0)
   131e0:	fff00513          	li	a0,-1
   131e4:	eb5ff06f          	j	13098 <__sflush_r+0x58>
   131e8:	0105a983          	lw	s3,16(a1)
   131ec:	ea0984e3          	beqz	s3,13094 <__sflush_r+0x54>
   131f0:	0005a903          	lw	s2,0(a1)
   131f4:	00377713          	andi	a4,a4,3
   131f8:	0135a023          	sw	s3,0(a1)
   131fc:	41390933          	sub	s2,s2,s3
   13200:	00000793          	li	a5,0
   13204:	00071463          	bnez	a4,1320c <__sflush_r+0x1cc>
   13208:	0145a783          	lw	a5,20(a1)
   1320c:	00f42423          	sw	a5,8(s0)
   13210:	e92052e3          	blez	s2,13094 <__sflush_r+0x54>
   13214:	02442783          	lw	a5,36(s0)
   13218:	01c42583          	lw	a1,28(s0)
   1321c:	00090693          	mv	a3,s2
   13220:	00098613          	mv	a2,s3
   13224:	00048513          	mv	a0,s1
   13228:	000780e7          	jalr	a5
   1322c:	00a04863          	bgtz	a0,1323c <__sflush_r+0x1fc>
   13230:	00c45783          	lhu	a5,12(s0)
   13234:	0407e793          	ori	a5,a5,64
   13238:	fa5ff06f          	j	131dc <__sflush_r+0x19c>
   1323c:	00a989b3          	add	s3,s3,a0
   13240:	40a90933          	sub	s2,s2,a0
   13244:	fcdff06f          	j	13210 <__sflush_r+0x1d0>

00013248 <_fflush_r>:
   13248:	fe010113          	addi	sp,sp,-32
   1324c:	00812c23          	sw	s0,24(sp)
   13250:	00112e23          	sw	ra,28(sp)
   13254:	00050413          	mv	s0,a0
   13258:	00050c63          	beqz	a0,13270 <_fflush_r+0x28>
   1325c:	03852783          	lw	a5,56(a0)
   13260:	00079863          	bnez	a5,13270 <_fflush_r+0x28>
   13264:	00b12623          	sw	a1,12(sp)
   13268:	17c000ef          	jal	ra,133e4 <__sinit>
   1326c:	00c12583          	lw	a1,12(sp)
   13270:	00c59783          	lh	a5,12(a1)
   13274:	00078c63          	beqz	a5,1328c <_fflush_r+0x44>
   13278:	00040513          	mv	a0,s0
   1327c:	01812403          	lw	s0,24(sp)
   13280:	01c12083          	lw	ra,28(sp)
   13284:	02010113          	addi	sp,sp,32
   13288:	db9ff06f          	j	13040 <__sflush_r>
   1328c:	01c12083          	lw	ra,28(sp)
   13290:	01812403          	lw	s0,24(sp)
   13294:	00000513          	li	a0,0
   13298:	02010113          	addi	sp,sp,32
   1329c:	00008067          	ret

000132a0 <fflush>:
   132a0:	00050593          	mv	a1,a0
   132a4:	00051a63          	bnez	a0,132b8 <fflush+0x18>
   132a8:	81c1a503          	lw	a0,-2020(gp) # 23f7c <_global_impure_ptr>
   132ac:	000135b7          	lui	a1,0x13
   132b0:	24858593          	addi	a1,a1,584 # 13248 <_fflush_r>
   132b4:	33d0006f          	j	13df0 <_fwalk_reent>
   132b8:	8201a503          	lw	a0,-2016(gp) # 23f80 <_impure_ptr>
   132bc:	f8dff06f          	j	13248 <_fflush_r>

000132c0 <__fp_lock>:
   132c0:	00000513          	li	a0,0
   132c4:	00008067          	ret

000132c8 <_cleanup_r>:
   132c8:	0001b5b7          	lui	a1,0x1b
   132cc:	db058593          	addi	a1,a1,-592 # 1adb0 <_fclose_r>
   132d0:	3210006f          	j	13df0 <_fwalk_reent>

000132d4 <std.isra.0>:
   132d4:	ff010113          	addi	sp,sp,-16
   132d8:	00812423          	sw	s0,8(sp)
   132dc:	00112623          	sw	ra,12(sp)
   132e0:	00050413          	mv	s0,a0
   132e4:	00b51623          	sh	a1,12(a0)
   132e8:	00c51723          	sh	a2,14(a0)
   132ec:	00052023          	sw	zero,0(a0)
   132f0:	00052223          	sw	zero,4(a0)
   132f4:	00052423          	sw	zero,8(a0)
   132f8:	06052223          	sw	zero,100(a0)
   132fc:	00052823          	sw	zero,16(a0)
   13300:	00052a23          	sw	zero,20(a0)
   13304:	00052c23          	sw	zero,24(a0)
   13308:	00800613          	li	a2,8
   1330c:	00000593          	li	a1,0
   13310:	05c50513          	addi	a0,a0,92
   13314:	edcfd0ef          	jal	ra,109f0 <memset>
   13318:	000187b7          	lui	a5,0x18
   1331c:	b0078793          	addi	a5,a5,-1280 # 17b00 <__sread>
   13320:	02f42023          	sw	a5,32(s0)
   13324:	000187b7          	lui	a5,0x18
   13328:	b5878793          	addi	a5,a5,-1192 # 17b58 <__swrite>
   1332c:	02f42223          	sw	a5,36(s0)
   13330:	000187b7          	lui	a5,0x18
   13334:	bdc78793          	addi	a5,a5,-1060 # 17bdc <__sseek>
   13338:	02f42423          	sw	a5,40(s0)
   1333c:	000187b7          	lui	a5,0x18
   13340:	c3478793          	addi	a5,a5,-972 # 17c34 <__sclose>
   13344:	00842e23          	sw	s0,28(s0)
   13348:	02f42623          	sw	a5,44(s0)
   1334c:	00c12083          	lw	ra,12(sp)
   13350:	00812403          	lw	s0,8(sp)
   13354:	01010113          	addi	sp,sp,16
   13358:	00008067          	ret

0001335c <__fp_unlock>:
   1335c:	00000513          	li	a0,0
   13360:	00008067          	ret

00013364 <__sfmoreglue>:
   13364:	ff010113          	addi	sp,sp,-16
   13368:	01212023          	sw	s2,0(sp)
   1336c:	00058913          	mv	s2,a1
   13370:	00812423          	sw	s0,8(sp)
   13374:	06800593          	li	a1,104
   13378:	00050413          	mv	s0,a0
   1337c:	fff90513          	addi	a0,s2,-1
   13380:	00112623          	sw	ra,12(sp)
   13384:	00912223          	sw	s1,4(sp)
   13388:	2240e0ef          	jal	ra,215ac <__mulsi3>
   1338c:	07450593          	addi	a1,a0,116
   13390:	00050493          	mv	s1,a0
   13394:	00040513          	mv	a0,s0
   13398:	814fd0ef          	jal	ra,103ac <_malloc_r>
   1339c:	00050413          	mv	s0,a0
   133a0:	02050063          	beqz	a0,133c0 <__sfmoreglue+0x5c>
   133a4:	00052023          	sw	zero,0(a0)
   133a8:	01252223          	sw	s2,4(a0)
   133ac:	00c50513          	addi	a0,a0,12
   133b0:	00a42423          	sw	a0,8(s0)
   133b4:	06848613          	addi	a2,s1,104
   133b8:	00000593          	li	a1,0
   133bc:	e34fd0ef          	jal	ra,109f0 <memset>
   133c0:	00040513          	mv	a0,s0
   133c4:	00c12083          	lw	ra,12(sp)
   133c8:	00812403          	lw	s0,8(sp)
   133cc:	00412483          	lw	s1,4(sp)
   133d0:	00012903          	lw	s2,0(sp)
   133d4:	01010113          	addi	sp,sp,16
   133d8:	00008067          	ret

000133dc <_cleanup>:
   133dc:	81c1a503          	lw	a0,-2020(gp) # 23f7c <_global_impure_ptr>
   133e0:	ee9ff06f          	j	132c8 <_cleanup_r>

000133e4 <__sinit>:
   133e4:	03852783          	lw	a5,56(a0)
   133e8:	06079e63          	bnez	a5,13464 <__sinit+0x80>
   133ec:	ff010113          	addi	sp,sp,-16
   133f0:	000137b7          	lui	a5,0x13
   133f4:	00112623          	sw	ra,12(sp)
   133f8:	00812423          	sw	s0,8(sp)
   133fc:	2c878793          	addi	a5,a5,712 # 132c8 <_cleanup_r>
   13400:	02f52e23          	sw	a5,60(a0)
   13404:	00300793          	li	a5,3
   13408:	2ef52223          	sw	a5,740(a0)
   1340c:	2ec50793          	addi	a5,a0,748
   13410:	00050413          	mv	s0,a0
   13414:	2ef52423          	sw	a5,744(a0)
   13418:	2e052023          	sw	zero,736(a0)
   1341c:	00452503          	lw	a0,4(a0)
   13420:	00000613          	li	a2,0
   13424:	00400593          	li	a1,4
   13428:	eadff0ef          	jal	ra,132d4 <std.isra.0>
   1342c:	00842503          	lw	a0,8(s0)
   13430:	00100613          	li	a2,1
   13434:	00900593          	li	a1,9
   13438:	e9dff0ef          	jal	ra,132d4 <std.isra.0>
   1343c:	00c42503          	lw	a0,12(s0)
   13440:	00200613          	li	a2,2
   13444:	01200593          	li	a1,18
   13448:	e8dff0ef          	jal	ra,132d4 <std.isra.0>
   1344c:	00100793          	li	a5,1
   13450:	02f42c23          	sw	a5,56(s0)
   13454:	00c12083          	lw	ra,12(sp)
   13458:	00812403          	lw	s0,8(sp)
   1345c:	01010113          	addi	sp,sp,16
   13460:	00008067          	ret
   13464:	00008067          	ret

00013468 <__sfp>:
   13468:	ff010113          	addi	sp,sp,-16
   1346c:	00912223          	sw	s1,4(sp)
   13470:	81c1a483          	lw	s1,-2020(gp) # 23f7c <_global_impure_ptr>
   13474:	01212023          	sw	s2,0(sp)
   13478:	00112623          	sw	ra,12(sp)
   1347c:	0384a783          	lw	a5,56(s1)
   13480:	00812423          	sw	s0,8(sp)
   13484:	00050913          	mv	s2,a0
   13488:	00079663          	bnez	a5,13494 <__sfp+0x2c>
   1348c:	00048513          	mv	a0,s1
   13490:	f55ff0ef          	jal	ra,133e4 <__sinit>
   13494:	2e048493          	addi	s1,s1,736
   13498:	0084a403          	lw	s0,8(s1)
   1349c:	0044a783          	lw	a5,4(s1)
   134a0:	fff78793          	addi	a5,a5,-1
   134a4:	0007da63          	bgez	a5,134b8 <__sfp+0x50>
   134a8:	0004a783          	lw	a5,0(s1)
   134ac:	00078e63          	beqz	a5,134c8 <__sfp+0x60>
   134b0:	0004a483          	lw	s1,0(s1)
   134b4:	fe5ff06f          	j	13498 <__sfp+0x30>
   134b8:	00c41703          	lh	a4,12(s0)
   134bc:	04070463          	beqz	a4,13504 <__sfp+0x9c>
   134c0:	06840413          	addi	s0,s0,104
   134c4:	fddff06f          	j	134a0 <__sfp+0x38>
   134c8:	00400593          	li	a1,4
   134cc:	00090513          	mv	a0,s2
   134d0:	e95ff0ef          	jal	ra,13364 <__sfmoreglue>
   134d4:	00a4a023          	sw	a0,0(s1)
   134d8:	fc051ce3          	bnez	a0,134b0 <__sfp+0x48>
   134dc:	00c00793          	li	a5,12
   134e0:	00f92023          	sw	a5,0(s2)
   134e4:	00000413          	li	s0,0
   134e8:	00040513          	mv	a0,s0
   134ec:	00c12083          	lw	ra,12(sp)
   134f0:	00812403          	lw	s0,8(sp)
   134f4:	00412483          	lw	s1,4(sp)
   134f8:	00012903          	lw	s2,0(sp)
   134fc:	01010113          	addi	sp,sp,16
   13500:	00008067          	ret
   13504:	ffff07b7          	lui	a5,0xffff0
   13508:	00178793          	addi	a5,a5,1 # ffff0001 <__global_pointer$+0xfffcb8a1>
   1350c:	06042223          	sw	zero,100(s0)
   13510:	00042023          	sw	zero,0(s0)
   13514:	00042223          	sw	zero,4(s0)
   13518:	00042423          	sw	zero,8(s0)
   1351c:	00f42623          	sw	a5,12(s0)
   13520:	00042823          	sw	zero,16(s0)
   13524:	00042a23          	sw	zero,20(s0)
   13528:	00042c23          	sw	zero,24(s0)
   1352c:	00800613          	li	a2,8
   13530:	00000593          	li	a1,0
   13534:	05c40513          	addi	a0,s0,92
   13538:	cb8fd0ef          	jal	ra,109f0 <memset>
   1353c:	02042823          	sw	zero,48(s0)
   13540:	02042a23          	sw	zero,52(s0)
   13544:	04042223          	sw	zero,68(s0)
   13548:	04042423          	sw	zero,72(s0)
   1354c:	f9dff06f          	j	134e8 <__sfp+0x80>

00013550 <__sfp_lock_acquire>:
   13550:	00008067          	ret

00013554 <__sfp_lock_release>:
   13554:	00008067          	ret

00013558 <__sinit_lock_acquire>:
   13558:	00008067          	ret

0001355c <__sinit_lock_release>:
   1355c:	00008067          	ret

00013560 <__fp_lock_all>:
   13560:	8201a503          	lw	a0,-2016(gp) # 23f80 <_impure_ptr>
   13564:	000135b7          	lui	a1,0x13
   13568:	2c058593          	addi	a1,a1,704 # 132c0 <__fp_lock>
   1356c:	7e40006f          	j	13d50 <_fwalk>

00013570 <__fp_unlock_all>:
   13570:	8201a503          	lw	a0,-2016(gp) # 23f80 <_impure_ptr>
   13574:	000135b7          	lui	a1,0x13
   13578:	35c58593          	addi	a1,a1,860 # 1335c <__fp_unlock>
   1357c:	7d40006f          	j	13d50 <_fwalk>

00013580 <_malloc_trim_r>:
   13580:	fd010113          	addi	sp,sp,-48
   13584:	03212023          	sw	s2,32(sp)
   13588:	00024937          	lui	s2,0x24
   1358c:	02812423          	sw	s0,40(sp)
   13590:	02912223          	sw	s1,36(sp)
   13594:	01312e23          	sw	s3,28(sp)
   13598:	00b12623          	sw	a1,12(sp)
   1359c:	02112623          	sw	ra,44(sp)
   135a0:	00050993          	mv	s3,a0
   135a4:	9e890913          	addi	s2,s2,-1560 # 239e8 <__malloc_av_>
   135a8:	d24fd0ef          	jal	ra,10acc <__malloc_lock>
   135ac:	00892783          	lw	a5,8(s2)
   135b0:	00c12583          	lw	a1,12(sp)
   135b4:	0047a483          	lw	s1,4(a5)
   135b8:	000017b7          	lui	a5,0x1
   135bc:	fef78413          	addi	s0,a5,-17 # fef <main-0xf085>
   135c0:	ffc4f493          	andi	s1,s1,-4
   135c4:	40b40433          	sub	s0,s0,a1
   135c8:	00940433          	add	s0,s0,s1
   135cc:	00c45413          	srli	s0,s0,0xc
   135d0:	fff40413          	addi	s0,s0,-1
   135d4:	00c41413          	slli	s0,s0,0xc
   135d8:	02f45663          	ble	a5,s0,13604 <_malloc_trim_r+0x84>
   135dc:	00098513          	mv	a0,s3
   135e0:	cf0fd0ef          	jal	ra,10ad0 <__malloc_unlock>
   135e4:	00000513          	li	a0,0
   135e8:	02c12083          	lw	ra,44(sp)
   135ec:	02812403          	lw	s0,40(sp)
   135f0:	02412483          	lw	s1,36(sp)
   135f4:	02012903          	lw	s2,32(sp)
   135f8:	01c12983          	lw	s3,28(sp)
   135fc:	03010113          	addi	sp,sp,48
   13600:	00008067          	ret
   13604:	00000593          	li	a1,0
   13608:	00098513          	mv	a0,s3
   1360c:	e28fd0ef          	jal	ra,10c34 <_sbrk_r>
   13610:	00892783          	lw	a5,8(s2)
   13614:	009787b3          	add	a5,a5,s1
   13618:	fcf512e3          	bne	a0,a5,135dc <_malloc_trim_r+0x5c>
   1361c:	408005b3          	neg	a1,s0
   13620:	00098513          	mv	a0,s3
   13624:	e10fd0ef          	jal	ra,10c34 <_sbrk_r>
   13628:	fff00793          	li	a5,-1
   1362c:	02f51c63          	bne	a0,a5,13664 <_malloc_trim_r+0xe4>
   13630:	00000593          	li	a1,0
   13634:	00098513          	mv	a0,s3
   13638:	dfcfd0ef          	jal	ra,10c34 <_sbrk_r>
   1363c:	00892703          	lw	a4,8(s2)
   13640:	00f00693          	li	a3,15
   13644:	40e507b3          	sub	a5,a0,a4
   13648:	f8f6dae3          	ble	a5,a3,135dc <_malloc_trim_r+0x5c>
   1364c:	8241a683          	lw	a3,-2012(gp) # 23f84 <__malloc_sbrk_base>
   13650:	0017e793          	ori	a5,a5,1
   13654:	00f72223          	sw	a5,4(a4)
   13658:	40d50533          	sub	a0,a0,a3
   1365c:	86a1a223          	sw	a0,-1948(gp) # 23fc4 <__malloc_current_mallinfo>
   13660:	f7dff06f          	j	135dc <_malloc_trim_r+0x5c>
   13664:	00892783          	lw	a5,8(s2)
   13668:	408484b3          	sub	s1,s1,s0
   1366c:	0014e493          	ori	s1,s1,1
   13670:	0097a223          	sw	s1,4(a5)
   13674:	8641a783          	lw	a5,-1948(gp) # 23fc4 <__malloc_current_mallinfo>
   13678:	00098513          	mv	a0,s3
   1367c:	40878433          	sub	s0,a5,s0
   13680:	8681a223          	sw	s0,-1948(gp) # 23fc4 <__malloc_current_mallinfo>
   13684:	c4cfd0ef          	jal	ra,10ad0 <__malloc_unlock>
   13688:	00100513          	li	a0,1
   1368c:	f5dff06f          	j	135e8 <_malloc_trim_r+0x68>

00013690 <_free_r>:
   13690:	24058c63          	beqz	a1,138e8 <_free_r+0x258>
   13694:	ff010113          	addi	sp,sp,-16
   13698:	00812423          	sw	s0,8(sp)
   1369c:	00912223          	sw	s1,4(sp)
   136a0:	00050413          	mv	s0,a0
   136a4:	00058493          	mv	s1,a1
   136a8:	00112623          	sw	ra,12(sp)
   136ac:	c20fd0ef          	jal	ra,10acc <__malloc_lock>
   136b0:	ffc4a503          	lw	a0,-4(s1)
   136b4:	00024637          	lui	a2,0x24
   136b8:	ff848693          	addi	a3,s1,-8
   136bc:	ffe57793          	andi	a5,a0,-2
   136c0:	9e860813          	addi	a6,a2,-1560 # 239e8 <__malloc_av_>
   136c4:	00f685b3          	add	a1,a3,a5
   136c8:	0045a703          	lw	a4,4(a1)
   136cc:	00882803          	lw	a6,8(a6)
   136d0:	9e860613          	addi	a2,a2,-1560
   136d4:	ffc77713          	andi	a4,a4,-4
   136d8:	00157513          	andi	a0,a0,1
   136dc:	06b81063          	bne	a6,a1,1373c <_free_r+0xac>
   136e0:	00e787b3          	add	a5,a5,a4
   136e4:	02051063          	bnez	a0,13704 <_free_r+0x74>
   136e8:	ff84a703          	lw	a4,-8(s1)
   136ec:	40e686b3          	sub	a3,a3,a4
   136f0:	0086a583          	lw	a1,8(a3)
   136f4:	00e787b3          	add	a5,a5,a4
   136f8:	00c6a703          	lw	a4,12(a3)
   136fc:	00e5a623          	sw	a4,12(a1)
   13700:	00b72423          	sw	a1,8(a4)
   13704:	0017e713          	ori	a4,a5,1
   13708:	00e6a223          	sw	a4,4(a3)
   1370c:	8281a703          	lw	a4,-2008(gp) # 23f88 <__malloc_trim_threshold>
   13710:	00d62423          	sw	a3,8(a2)
   13714:	00e7e863          	bltu	a5,a4,13724 <_free_r+0x94>
   13718:	8341a583          	lw	a1,-1996(gp) # 23f94 <__malloc_top_pad>
   1371c:	00040513          	mv	a0,s0
   13720:	e61ff0ef          	jal	ra,13580 <_malloc_trim_r>
   13724:	00040513          	mv	a0,s0
   13728:	00812403          	lw	s0,8(sp)
   1372c:	00c12083          	lw	ra,12(sp)
   13730:	00412483          	lw	s1,4(sp)
   13734:	01010113          	addi	sp,sp,16
   13738:	b98fd06f          	j	10ad0 <__malloc_unlock>
   1373c:	00e5a223          	sw	a4,4(a1)
   13740:	00000813          	li	a6,0
   13744:	02051663          	bnez	a0,13770 <_free_r+0xe0>
   13748:	ff84a503          	lw	a0,-8(s1)
   1374c:	000248b7          	lui	a7,0x24
   13750:	9f088893          	addi	a7,a7,-1552 # 239f0 <__malloc_av_+0x8>
   13754:	40a686b3          	sub	a3,a3,a0
   13758:	00a787b3          	add	a5,a5,a0
   1375c:	0086a503          	lw	a0,8(a3)
   13760:	0b150663          	beq	a0,a7,1380c <_free_r+0x17c>
   13764:	00c6a883          	lw	a7,12(a3)
   13768:	01152623          	sw	a7,12(a0)
   1376c:	00a8a423          	sw	a0,8(a7)
   13770:	00e58533          	add	a0,a1,a4
   13774:	00452503          	lw	a0,4(a0)
   13778:	00157513          	andi	a0,a0,1
   1377c:	02051863          	bnez	a0,137ac <_free_r+0x11c>
   13780:	00e787b3          	add	a5,a5,a4
   13784:	0085a703          	lw	a4,8(a1)
   13788:	08081663          	bnez	a6,13814 <_free_r+0x184>
   1378c:	00024537          	lui	a0,0x24
   13790:	9f050513          	addi	a0,a0,-1552 # 239f0 <__malloc_av_+0x8>
   13794:	08a71063          	bne	a4,a0,13814 <_free_r+0x184>
   13798:	00d62a23          	sw	a3,20(a2)
   1379c:	00d62823          	sw	a3,16(a2)
   137a0:	00e6a623          	sw	a4,12(a3)
   137a4:	00e6a423          	sw	a4,8(a3)
   137a8:	00100813          	li	a6,1
   137ac:	0017e713          	ori	a4,a5,1
   137b0:	00e6a223          	sw	a4,4(a3)
   137b4:	00f68733          	add	a4,a3,a5
   137b8:	00f72023          	sw	a5,0(a4)
   137bc:	f60814e3          	bnez	a6,13724 <_free_r+0x94>
   137c0:	1ff00713          	li	a4,511
   137c4:	06f76063          	bltu	a4,a5,13824 <_free_r+0x194>
   137c8:	0037d793          	srli	a5,a5,0x3
   137cc:	4027d593          	srai	a1,a5,0x2
   137d0:	00100713          	li	a4,1
   137d4:	00b71733          	sll	a4,a4,a1
   137d8:	00462583          	lw	a1,4(a2)
   137dc:	00178793          	addi	a5,a5,1
   137e0:	00379793          	slli	a5,a5,0x3
   137e4:	00f607b3          	add	a5,a2,a5
   137e8:	00b76733          	or	a4,a4,a1
   137ec:	00e62223          	sw	a4,4(a2)
   137f0:	0007a703          	lw	a4,0(a5)
   137f4:	ff878613          	addi	a2,a5,-8
   137f8:	00c6a623          	sw	a2,12(a3)
   137fc:	00e6a423          	sw	a4,8(a3)
   13800:	00d7a023          	sw	a3,0(a5)
   13804:	00d72623          	sw	a3,12(a4)
   13808:	f1dff06f          	j	13724 <_free_r+0x94>
   1380c:	00100813          	li	a6,1
   13810:	f61ff06f          	j	13770 <_free_r+0xe0>
   13814:	00c5a583          	lw	a1,12(a1)
   13818:	00b72623          	sw	a1,12(a4)
   1381c:	00e5a423          	sw	a4,8(a1)
   13820:	f8dff06f          	j	137ac <_free_r+0x11c>
   13824:	0097d593          	srli	a1,a5,0x9
   13828:	00400713          	li	a4,4
   1382c:	04b76863          	bltu	a4,a1,1387c <_free_r+0x1ec>
   13830:	0067d713          	srli	a4,a5,0x6
   13834:	03870713          	addi	a4,a4,56
   13838:	00170593          	addi	a1,a4,1
   1383c:	00359593          	slli	a1,a1,0x3
   13840:	00b605b3          	add	a1,a2,a1
   13844:	ff858513          	addi	a0,a1,-8
   13848:	0005a583          	lw	a1,0(a1)
   1384c:	08b51463          	bne	a0,a1,138d4 <_free_r+0x244>
   13850:	00100793          	li	a5,1
   13854:	40275713          	srai	a4,a4,0x2
   13858:	00e79733          	sll	a4,a5,a4
   1385c:	00462783          	lw	a5,4(a2)
   13860:	00f76733          	or	a4,a4,a5
   13864:	00e62223          	sw	a4,4(a2)
   13868:	00a6a623          	sw	a0,12(a3)
   1386c:	00b6a423          	sw	a1,8(a3)
   13870:	00d52423          	sw	a3,8(a0)
   13874:	00d5a623          	sw	a3,12(a1)
   13878:	eadff06f          	j	13724 <_free_r+0x94>
   1387c:	01400713          	li	a4,20
   13880:	00b76663          	bltu	a4,a1,1388c <_free_r+0x1fc>
   13884:	05b58713          	addi	a4,a1,91
   13888:	fb1ff06f          	j	13838 <_free_r+0x1a8>
   1388c:	05400713          	li	a4,84
   13890:	00b76863          	bltu	a4,a1,138a0 <_free_r+0x210>
   13894:	00c7d713          	srli	a4,a5,0xc
   13898:	06e70713          	addi	a4,a4,110
   1389c:	f9dff06f          	j	13838 <_free_r+0x1a8>
   138a0:	15400713          	li	a4,340
   138a4:	00b76863          	bltu	a4,a1,138b4 <_free_r+0x224>
   138a8:	00f7d713          	srli	a4,a5,0xf
   138ac:	07770713          	addi	a4,a4,119
   138b0:	f89ff06f          	j	13838 <_free_r+0x1a8>
   138b4:	55400513          	li	a0,1364
   138b8:	07e00713          	li	a4,126
   138bc:	f6b56ee3          	bltu	a0,a1,13838 <_free_r+0x1a8>
   138c0:	0127d713          	srli	a4,a5,0x12
   138c4:	07c70713          	addi	a4,a4,124
   138c8:	f71ff06f          	j	13838 <_free_r+0x1a8>
   138cc:	0085a583          	lw	a1,8(a1)
   138d0:	00b50863          	beq	a0,a1,138e0 <_free_r+0x250>
   138d4:	0045a703          	lw	a4,4(a1)
   138d8:	ffc77713          	andi	a4,a4,-4
   138dc:	fee7e8e3          	bltu	a5,a4,138cc <_free_r+0x23c>
   138e0:	00c5a503          	lw	a0,12(a1)
   138e4:	f85ff06f          	j	13868 <_free_r+0x1d8>
   138e8:	00008067          	ret

000138ec <__sfvwrite_r>:
   138ec:	00862783          	lw	a5,8(a2)
   138f0:	00079863          	bnez	a5,13900 <__sfvwrite_r+0x14>
   138f4:	00000793          	li	a5,0
   138f8:	00078513          	mv	a0,a5
   138fc:	00008067          	ret
   13900:	00c5d783          	lhu	a5,12(a1)
   13904:	fc010113          	addi	sp,sp,-64
   13908:	02812c23          	sw	s0,56(sp)
   1390c:	03212823          	sw	s2,48(sp)
   13910:	03612023          	sw	s6,32(sp)
   13914:	02112e23          	sw	ra,60(sp)
   13918:	02912a23          	sw	s1,52(sp)
   1391c:	03312623          	sw	s3,44(sp)
   13920:	03412423          	sw	s4,40(sp)
   13924:	03512223          	sw	s5,36(sp)
   13928:	01712e23          	sw	s7,28(sp)
   1392c:	01812c23          	sw	s8,24(sp)
   13930:	01912a23          	sw	s9,20(sp)
   13934:	01a12823          	sw	s10,16(sp)
   13938:	01b12623          	sw	s11,12(sp)
   1393c:	0087f793          	andi	a5,a5,8
   13940:	00060b13          	mv	s6,a2
   13944:	00058413          	mv	s0,a1
   13948:	00050913          	mv	s2,a0
   1394c:	0e078263          	beqz	a5,13a30 <__sfvwrite_r+0x144>
   13950:	0105a783          	lw	a5,16(a1)
   13954:	0c078e63          	beqz	a5,13a30 <__sfvwrite_r+0x144>
   13958:	00c45783          	lhu	a5,12(s0)
   1395c:	000b2a03          	lw	s4,0(s6)
   13960:	0027f713          	andi	a4,a5,2
   13964:	16071a63          	bnez	a4,13ad8 <__sfvwrite_r+0x1ec>
   13968:	0017f793          	andi	a5,a5,1
   1396c:	00000b93          	li	s7,0
   13970:	20078a63          	beqz	a5,13b84 <__sfvwrite_r+0x298>
   13974:	00000513          	li	a0,0
   13978:	00000a93          	li	s5,0
   1397c:	00000993          	li	s3,0
   13980:	36098663          	beqz	s3,13cec <__sfvwrite_r+0x400>
   13984:	02051263          	bnez	a0,139a8 <__sfvwrite_r+0xbc>
   13988:	00098613          	mv	a2,s3
   1398c:	00a00593          	li	a1,10
   13990:	000a8513          	mv	a0,s5
   13994:	091020ef          	jal	ra,16224 <memchr>
   13998:	00198b93          	addi	s7,s3,1
   1399c:	00050663          	beqz	a0,139a8 <__sfvwrite_r+0xbc>
   139a0:	00150513          	addi	a0,a0,1
   139a4:	41550bb3          	sub	s7,a0,s5
   139a8:	000b8c13          	mv	s8,s7
   139ac:	0179f463          	bleu	s7,s3,139b4 <__sfvwrite_r+0xc8>
   139b0:	00098c13          	mv	s8,s3
   139b4:	00042503          	lw	a0,0(s0)
   139b8:	01042783          	lw	a5,16(s0)
   139bc:	01442683          	lw	a3,20(s0)
   139c0:	34a7f063          	bleu	a0,a5,13d00 <__sfvwrite_r+0x414>
   139c4:	00842483          	lw	s1,8(s0)
   139c8:	009684b3          	add	s1,a3,s1
   139cc:	3384da63          	ble	s8,s1,13d00 <__sfvwrite_r+0x414>
   139d0:	000a8593          	mv	a1,s5
   139d4:	00048613          	mv	a2,s1
   139d8:	159020ef          	jal	ra,16330 <memmove>
   139dc:	00042783          	lw	a5,0(s0)
   139e0:	00040593          	mv	a1,s0
   139e4:	00090513          	mv	a0,s2
   139e8:	009787b3          	add	a5,a5,s1
   139ec:	00f42023          	sw	a5,0(s0)
   139f0:	859ff0ef          	jal	ra,13248 <_fflush_r>
   139f4:	16051e63          	bnez	a0,13b70 <__sfvwrite_r+0x284>
   139f8:	409b8bb3          	sub	s7,s7,s1
   139fc:	00100513          	li	a0,1
   13a00:	000b9a63          	bnez	s7,13a14 <__sfvwrite_r+0x128>
   13a04:	00040593          	mv	a1,s0
   13a08:	00090513          	mv	a0,s2
   13a0c:	83dff0ef          	jal	ra,13248 <_fflush_r>
   13a10:	16051063          	bnez	a0,13b70 <__sfvwrite_r+0x284>
   13a14:	008b2783          	lw	a5,8(s6)
   13a18:	009a8ab3          	add	s5,s5,s1
   13a1c:	409989b3          	sub	s3,s3,s1
   13a20:	409784b3          	sub	s1,a5,s1
   13a24:	009b2423          	sw	s1,8(s6)
   13a28:	f4049ce3          	bnez	s1,13980 <__sfvwrite_r+0x94>
   13a2c:	0680006f          	j	13a94 <__sfvwrite_r+0x1a8>
   13a30:	00040593          	mv	a1,s0
   13a34:	00090513          	mv	a0,s2
   13a38:	b4cff0ef          	jal	ra,12d84 <__swsetup_r>
   13a3c:	fff00793          	li	a5,-1
   13a40:	f0050ce3          	beqz	a0,13958 <__sfvwrite_r+0x6c>
   13a44:	0540006f          	j	13a98 <__sfvwrite_r+0x1ac>
   13a48:	000a2983          	lw	s3,0(s4)
   13a4c:	004a2483          	lw	s1,4(s4)
   13a50:	008a0a13          	addi	s4,s4,8
   13a54:	fe048ae3          	beqz	s1,13a48 <__sfvwrite_r+0x15c>
   13a58:	00048693          	mv	a3,s1
   13a5c:	009af463          	bleu	s1,s5,13a64 <__sfvwrite_r+0x178>
   13a60:	000a8693          	mv	a3,s5
   13a64:	02442783          	lw	a5,36(s0)
   13a68:	01c42583          	lw	a1,28(s0)
   13a6c:	00098613          	mv	a2,s3
   13a70:	00090513          	mv	a0,s2
   13a74:	000780e7          	jalr	a5
   13a78:	0ea05c63          	blez	a0,13b70 <__sfvwrite_r+0x284>
   13a7c:	008b2783          	lw	a5,8(s6)
   13a80:	00a989b3          	add	s3,s3,a0
   13a84:	40a484b3          	sub	s1,s1,a0
   13a88:	40a78533          	sub	a0,a5,a0
   13a8c:	00ab2423          	sw	a0,8(s6)
   13a90:	fc0512e3          	bnez	a0,13a54 <__sfvwrite_r+0x168>
   13a94:	00000793          	li	a5,0
   13a98:	03c12083          	lw	ra,60(sp)
   13a9c:	03812403          	lw	s0,56(sp)
   13aa0:	03412483          	lw	s1,52(sp)
   13aa4:	03012903          	lw	s2,48(sp)
   13aa8:	02c12983          	lw	s3,44(sp)
   13aac:	02812a03          	lw	s4,40(sp)
   13ab0:	02412a83          	lw	s5,36(sp)
   13ab4:	02012b03          	lw	s6,32(sp)
   13ab8:	01c12b83          	lw	s7,28(sp)
   13abc:	01812c03          	lw	s8,24(sp)
   13ac0:	01412c83          	lw	s9,20(sp)
   13ac4:	01012d03          	lw	s10,16(sp)
   13ac8:	00c12d83          	lw	s11,12(sp)
   13acc:	00078513          	mv	a0,a5
   13ad0:	04010113          	addi	sp,sp,64
   13ad4:	00008067          	ret
   13ad8:	80000ab7          	lui	s5,0x80000
   13adc:	00000993          	li	s3,0
   13ae0:	00000493          	li	s1,0
   13ae4:	c00aca93          	xori	s5,s5,-1024
   13ae8:	f6dff06f          	j	13a54 <__sfvwrite_r+0x168>
   13aec:	000a2b83          	lw	s7,0(s4)
   13af0:	004a2483          	lw	s1,4(s4)
   13af4:	008a0a13          	addi	s4,s4,8
   13af8:	fe048ae3          	beqz	s1,13aec <__sfvwrite_r+0x200>
   13afc:	00c45983          	lhu	s3,12(s0)
   13b00:	00842d83          	lw	s11,8(s0)
   13b04:	00042503          	lw	a0,0(s0)
   13b08:	2009f793          	andi	a5,s3,512
   13b0c:	14078463          	beqz	a5,13c54 <__sfvwrite_r+0x368>
   13b10:	0db4e063          	bltu	s1,s11,13bd0 <__sfvwrite_r+0x2e4>
   13b14:	4809f793          	andi	a5,s3,1152
   13b18:	0a078c63          	beqz	a5,13bd0 <__sfvwrite_r+0x2e4>
   13b1c:	01042d83          	lw	s11,16(s0)
   13b20:	00300593          	li	a1,3
   13b24:	41b50d33          	sub	s10,a0,s11
   13b28:	01442503          	lw	a0,20(s0)
   13b2c:	2810d0ef          	jal	ra,215ac <__mulsi3>
   13b30:	01f55a93          	srli	s5,a0,0x1f
   13b34:	00aa8ab3          	add	s5,s5,a0
   13b38:	001d0793          	addi	a5,s10,1
   13b3c:	401ada93          	srai	s5,s5,0x1
   13b40:	009787b3          	add	a5,a5,s1
   13b44:	00faf463          	bleu	a5,s5,13b4c <__sfvwrite_r+0x260>
   13b48:	00078a93          	mv	s5,a5
   13b4c:	4009f993          	andi	s3,s3,1024
   13b50:	0c098863          	beqz	s3,13c20 <__sfvwrite_r+0x334>
   13b54:	000a8593          	mv	a1,s5
   13b58:	00090513          	mv	a0,s2
   13b5c:	851fc0ef          	jal	ra,103ac <_malloc_r>
   13b60:	00050993          	mv	s3,a0
   13b64:	02051a63          	bnez	a0,13b98 <__sfvwrite_r+0x2ac>
   13b68:	00c00793          	li	a5,12
   13b6c:	00f92023          	sw	a5,0(s2)
   13b70:	00c45783          	lhu	a5,12(s0)
   13b74:	0407e793          	ori	a5,a5,64
   13b78:	00f41623          	sh	a5,12(s0)
   13b7c:	fff00793          	li	a5,-1
   13b80:	f19ff06f          	j	13a98 <__sfvwrite_r+0x1ac>
   13b84:	80000c37          	lui	s8,0x80000
   13b88:	ffec4c93          	xori	s9,s8,-2
   13b8c:	00000493          	li	s1,0
   13b90:	fffc4c13          	not	s8,s8
   13b94:	f65ff06f          	j	13af8 <__sfvwrite_r+0x20c>
   13b98:	01042583          	lw	a1,16(s0)
   13b9c:	000d0613          	mv	a2,s10
   13ba0:	6a8020ef          	jal	ra,16248 <memcpy>
   13ba4:	00c45783          	lhu	a5,12(s0)
   13ba8:	b7f7f793          	andi	a5,a5,-1153
   13bac:	0807e793          	ori	a5,a5,128
   13bb0:	00f41623          	sh	a5,12(s0)
   13bb4:	01342823          	sw	s3,16(s0)
   13bb8:	01542a23          	sw	s5,20(s0)
   13bbc:	01a989b3          	add	s3,s3,s10
   13bc0:	41aa8ab3          	sub	s5,s5,s10
   13bc4:	01342023          	sw	s3,0(s0)
   13bc8:	00048d93          	mv	s11,s1
   13bcc:	01542423          	sw	s5,8(s0)
   13bd0:	00048993          	mv	s3,s1
   13bd4:	01b4f463          	bleu	s11,s1,13bdc <__sfvwrite_r+0x2f0>
   13bd8:	00048d93          	mv	s11,s1
   13bdc:	00042503          	lw	a0,0(s0)
   13be0:	000d8613          	mv	a2,s11
   13be4:	000b8593          	mv	a1,s7
   13be8:	748020ef          	jal	ra,16330 <memmove>
   13bec:	00842783          	lw	a5,8(s0)
   13bf0:	41b787b3          	sub	a5,a5,s11
   13bf4:	00f42423          	sw	a5,8(s0)
   13bf8:	00042783          	lw	a5,0(s0)
   13bfc:	01b78db3          	add	s11,a5,s11
   13c00:	01b42023          	sw	s11,0(s0)
   13c04:	008b2783          	lw	a5,8(s6)
   13c08:	013b8bb3          	add	s7,s7,s3
   13c0c:	413484b3          	sub	s1,s1,s3
   13c10:	413789b3          	sub	s3,a5,s3
   13c14:	013b2423          	sw	s3,8(s6)
   13c18:	ee0990e3          	bnez	s3,13af8 <__sfvwrite_r+0x20c>
   13c1c:	e79ff06f          	j	13a94 <__sfvwrite_r+0x1a8>
   13c20:	000a8613          	mv	a2,s5
   13c24:	000d8593          	mv	a1,s11
   13c28:	00090513          	mv	a0,s2
   13c2c:	6a8030ef          	jal	ra,172d4 <_realloc_r>
   13c30:	00050993          	mv	s3,a0
   13c34:	f80510e3          	bnez	a0,13bb4 <__sfvwrite_r+0x2c8>
   13c38:	01042583          	lw	a1,16(s0)
   13c3c:	00090513          	mv	a0,s2
   13c40:	a51ff0ef          	jal	ra,13690 <_free_r>
   13c44:	00c45783          	lhu	a5,12(s0)
   13c48:	f7f7f793          	andi	a5,a5,-129
   13c4c:	00f41623          	sh	a5,12(s0)
   13c50:	f19ff06f          	j	13b68 <__sfvwrite_r+0x27c>
   13c54:	01042783          	lw	a5,16(s0)
   13c58:	00a7e663          	bltu	a5,a0,13c64 <__sfvwrite_r+0x378>
   13c5c:	01442983          	lw	s3,20(s0)
   13c60:	0534f663          	bleu	s3,s1,13cac <__sfvwrite_r+0x3c0>
   13c64:	000d8993          	mv	s3,s11
   13c68:	01b4f463          	bleu	s11,s1,13c70 <__sfvwrite_r+0x384>
   13c6c:	00048993          	mv	s3,s1
   13c70:	00098613          	mv	a2,s3
   13c74:	000b8593          	mv	a1,s7
   13c78:	6b8020ef          	jal	ra,16330 <memmove>
   13c7c:	00842783          	lw	a5,8(s0)
   13c80:	00042703          	lw	a4,0(s0)
   13c84:	413787b3          	sub	a5,a5,s3
   13c88:	01370733          	add	a4,a4,s3
   13c8c:	00f42423          	sw	a5,8(s0)
   13c90:	00e42023          	sw	a4,0(s0)
   13c94:	f60798e3          	bnez	a5,13c04 <__sfvwrite_r+0x318>
   13c98:	00040593          	mv	a1,s0
   13c9c:	00090513          	mv	a0,s2
   13ca0:	da8ff0ef          	jal	ra,13248 <_fflush_r>
   13ca4:	f60500e3          	beqz	a0,13c04 <__sfvwrite_r+0x318>
   13ca8:	ec9ff06f          	j	13b70 <__sfvwrite_r+0x284>
   13cac:	000c0513          	mv	a0,s8
   13cb0:	009ce463          	bltu	s9,s1,13cb8 <__sfvwrite_r+0x3cc>
   13cb4:	00048513          	mv	a0,s1
   13cb8:	00098593          	mv	a1,s3
   13cbc:	1150d0ef          	jal	ra,215d0 <__divsi3>
   13cc0:	00098593          	mv	a1,s3
   13cc4:	0e90d0ef          	jal	ra,215ac <__mulsi3>
   13cc8:	02442783          	lw	a5,36(s0)
   13ccc:	01c42583          	lw	a1,28(s0)
   13cd0:	00050693          	mv	a3,a0
   13cd4:	000b8613          	mv	a2,s7
   13cd8:	00090513          	mv	a0,s2
   13cdc:	000780e7          	jalr	a5
   13ce0:	00050993          	mv	s3,a0
   13ce4:	f2a040e3          	bgtz	a0,13c04 <__sfvwrite_r+0x318>
   13ce8:	e89ff06f          	j	13b70 <__sfvwrite_r+0x284>
   13cec:	000a2a83          	lw	s5,0(s4)
   13cf0:	004a2983          	lw	s3,4(s4)
   13cf4:	00000513          	li	a0,0
   13cf8:	008a0a13          	addi	s4,s4,8
   13cfc:	c85ff06f          	j	13980 <__sfvwrite_r+0x94>
   13d00:	02dc4263          	blt	s8,a3,13d24 <__sfvwrite_r+0x438>
   13d04:	02442783          	lw	a5,36(s0)
   13d08:	01c42583          	lw	a1,28(s0)
   13d0c:	000a8613          	mv	a2,s5
   13d10:	00090513          	mv	a0,s2
   13d14:	000780e7          	jalr	a5
   13d18:	00050493          	mv	s1,a0
   13d1c:	cca04ee3          	bgtz	a0,139f8 <__sfvwrite_r+0x10c>
   13d20:	e51ff06f          	j	13b70 <__sfvwrite_r+0x284>
   13d24:	000c0613          	mv	a2,s8
   13d28:	000a8593          	mv	a1,s5
   13d2c:	604020ef          	jal	ra,16330 <memmove>
   13d30:	00842783          	lw	a5,8(s0)
   13d34:	000c0493          	mv	s1,s8
   13d38:	418787b3          	sub	a5,a5,s8
   13d3c:	00f42423          	sw	a5,8(s0)
   13d40:	00042783          	lw	a5,0(s0)
   13d44:	018787b3          	add	a5,a5,s8
   13d48:	00f42023          	sw	a5,0(s0)
   13d4c:	cadff06f          	j	139f8 <__sfvwrite_r+0x10c>

00013d50 <_fwalk>:
   13d50:	fd010113          	addi	sp,sp,-48
   13d54:	02812423          	sw	s0,40(sp)
   13d58:	03212023          	sw	s2,32(sp)
   13d5c:	01412c23          	sw	s4,24(sp)
   13d60:	01512a23          	sw	s5,20(sp)
   13d64:	02112623          	sw	ra,44(sp)
   13d68:	02912223          	sw	s1,36(sp)
   13d6c:	01312e23          	sw	s3,28(sp)
   13d70:	2e050413          	addi	s0,a0,736
   13d74:	00000913          	li	s2,0
   13d78:	00100a13          	li	s4,1
   13d7c:	fff00a93          	li	s5,-1
   13d80:	02041663          	bnez	s0,13dac <_fwalk+0x5c>
   13d84:	02c12083          	lw	ra,44(sp)
   13d88:	02812403          	lw	s0,40(sp)
   13d8c:	00090513          	mv	a0,s2
   13d90:	02412483          	lw	s1,36(sp)
   13d94:	02012903          	lw	s2,32(sp)
   13d98:	01c12983          	lw	s3,28(sp)
   13d9c:	01812a03          	lw	s4,24(sp)
   13da0:	01412a83          	lw	s5,20(sp)
   13da4:	03010113          	addi	sp,sp,48
   13da8:	00008067          	ret
   13dac:	00842483          	lw	s1,8(s0)
   13db0:	00442983          	lw	s3,4(s0)
   13db4:	fff98993          	addi	s3,s3,-1
   13db8:	0009d663          	bgez	s3,13dc4 <_fwalk+0x74>
   13dbc:	00042403          	lw	s0,0(s0)
   13dc0:	fc1ff06f          	j	13d80 <_fwalk+0x30>
   13dc4:	00c4d783          	lhu	a5,12(s1)
   13dc8:	02fa7063          	bleu	a5,s4,13de8 <_fwalk+0x98>
   13dcc:	00e49783          	lh	a5,14(s1)
   13dd0:	01578c63          	beq	a5,s5,13de8 <_fwalk+0x98>
   13dd4:	00048513          	mv	a0,s1
   13dd8:	00b12623          	sw	a1,12(sp)
   13ddc:	000580e7          	jalr	a1
   13de0:	00c12583          	lw	a1,12(sp)
   13de4:	00a96933          	or	s2,s2,a0
   13de8:	06848493          	addi	s1,s1,104
   13dec:	fc9ff06f          	j	13db4 <_fwalk+0x64>

00013df0 <_fwalk_reent>:
   13df0:	fd010113          	addi	sp,sp,-48
   13df4:	02812423          	sw	s0,40(sp)
   13df8:	03212023          	sw	s2,32(sp)
   13dfc:	01412c23          	sw	s4,24(sp)
   13e00:	01512a23          	sw	s5,20(sp)
   13e04:	01612823          	sw	s6,16(sp)
   13e08:	01712623          	sw	s7,12(sp)
   13e0c:	02112623          	sw	ra,44(sp)
   13e10:	02912223          	sw	s1,36(sp)
   13e14:	01312e23          	sw	s3,28(sp)
   13e18:	00050a13          	mv	s4,a0
   13e1c:	00058a93          	mv	s5,a1
   13e20:	2e050413          	addi	s0,a0,736
   13e24:	00000913          	li	s2,0
   13e28:	00100b13          	li	s6,1
   13e2c:	fff00b93          	li	s7,-1
   13e30:	02041a63          	bnez	s0,13e64 <_fwalk_reent+0x74>
   13e34:	02c12083          	lw	ra,44(sp)
   13e38:	02812403          	lw	s0,40(sp)
   13e3c:	00090513          	mv	a0,s2
   13e40:	02412483          	lw	s1,36(sp)
   13e44:	02012903          	lw	s2,32(sp)
   13e48:	01c12983          	lw	s3,28(sp)
   13e4c:	01812a03          	lw	s4,24(sp)
   13e50:	01412a83          	lw	s5,20(sp)
   13e54:	01012b03          	lw	s6,16(sp)
   13e58:	00c12b83          	lw	s7,12(sp)
   13e5c:	03010113          	addi	sp,sp,48
   13e60:	00008067          	ret
   13e64:	00842483          	lw	s1,8(s0)
   13e68:	00442983          	lw	s3,4(s0)
   13e6c:	fff98993          	addi	s3,s3,-1
   13e70:	0009d663          	bgez	s3,13e7c <_fwalk_reent+0x8c>
   13e74:	00042403          	lw	s0,0(s0)
   13e78:	fb9ff06f          	j	13e30 <_fwalk_reent+0x40>
   13e7c:	00c4d783          	lhu	a5,12(s1)
   13e80:	00fb7e63          	bleu	a5,s6,13e9c <_fwalk_reent+0xac>
   13e84:	00e49783          	lh	a5,14(s1)
   13e88:	01778a63          	beq	a5,s7,13e9c <_fwalk_reent+0xac>
   13e8c:	00048593          	mv	a1,s1
   13e90:	000a0513          	mv	a0,s4
   13e94:	000a80e7          	jalr	s5
   13e98:	00a96933          	or	s2,s2,a0
   13e9c:	06848493          	addi	s1,s1,104
   13ea0:	fcdff06f          	j	13e6c <_fwalk_reent+0x7c>

00013ea4 <eclear>:
   13ea4:	01450793          	addi	a5,a0,20
   13ea8:	00250513          	addi	a0,a0,2
   13eac:	fe051f23          	sh	zero,-2(a0)
   13eb0:	fef51ce3          	bne	a0,a5,13ea8 <eclear+0x4>
   13eb4:	00008067          	ret

00013eb8 <emov>:
   13eb8:	01450793          	addi	a5,a0,20
   13ebc:	00250513          	addi	a0,a0,2
   13ec0:	ffe55703          	lhu	a4,-2(a0)
   13ec4:	00258593          	addi	a1,a1,2
   13ec8:	fee59f23          	sh	a4,-2(a1)
   13ecc:	fea798e3          	bne	a5,a0,13ebc <emov+0x4>
   13ed0:	00008067          	ret

00013ed4 <ecleaz>:
   13ed4:	01a50793          	addi	a5,a0,26
   13ed8:	00250513          	addi	a0,a0,2
   13edc:	fe051f23          	sh	zero,-2(a0)
   13ee0:	fef51ce3          	bne	a0,a5,13ed8 <ecleaz+0x4>
   13ee4:	00008067          	ret

00013ee8 <emovz>:
   13ee8:	01850713          	addi	a4,a0,24
   13eec:	00058793          	mv	a5,a1
   13ef0:	00250513          	addi	a0,a0,2
   13ef4:	ffe55683          	lhu	a3,-2(a0)
   13ef8:	00278793          	addi	a5,a5,2
   13efc:	fed79f23          	sh	a3,-2(a5)
   13f00:	fea718e3          	bne	a4,a0,13ef0 <emovz+0x8>
   13f04:	00059c23          	sh	zero,24(a1)
   13f08:	00008067          	ret

00013f0c <ecmpm>:
   13f0c:	00450793          	addi	a5,a0,4
   13f10:	00458593          	addi	a1,a1,4
   13f14:	01a50513          	addi	a0,a0,26
   13f18:	00278793          	addi	a5,a5,2
   13f1c:	00258593          	addi	a1,a1,2
   13f20:	ffe7d683          	lhu	a3,-2(a5)
   13f24:	ffe5d703          	lhu	a4,-2(a1)
   13f28:	00e69863          	bne	a3,a4,13f38 <ecmpm+0x2c>
   13f2c:	fef516e3          	bne	a0,a5,13f18 <ecmpm+0xc>
   13f30:	00000513          	li	a0,0
   13f34:	00008067          	ret
   13f38:	00100513          	li	a0,1
   13f3c:	00d76463          	bltu	a4,a3,13f44 <ecmpm+0x38>
   13f40:	fff00513          	li	a0,-1
   13f44:	00008067          	ret

00013f48 <eshdn1>:
   13f48:	00450693          	addi	a3,a0,4
   13f4c:	00000793          	li	a5,0
   13f50:	01a50513          	addi	a0,a0,26
   13f54:	ffff8637          	lui	a2,0xffff8
   13f58:	0006d703          	lhu	a4,0(a3)
   13f5c:	00177593          	andi	a1,a4,1
   13f60:	00058463          	beqz	a1,13f68 <eshdn1+0x20>
   13f64:	0017e793          	ori	a5,a5,1
   13f68:	0027f593          	andi	a1,a5,2
   13f6c:	00175713          	srli	a4,a4,0x1
   13f70:	02059063          	bnez	a1,13f90 <eshdn1+0x48>
   13f74:	00179793          	slli	a5,a5,0x1
   13f78:	00e69023          	sh	a4,0(a3)
   13f7c:	01079793          	slli	a5,a5,0x10
   13f80:	00268693          	addi	a3,a3,2
   13f84:	0107d793          	srli	a5,a5,0x10
   13f88:	fcd518e3          	bne	a0,a3,13f58 <eshdn1+0x10>
   13f8c:	00008067          	ret
   13f90:	00c76733          	or	a4,a4,a2
   13f94:	fe1ff06f          	j	13f74 <eshdn1+0x2c>

00013f98 <eshup1>:
   13f98:	01650693          	addi	a3,a0,22
   13f9c:	00000713          	li	a4,0
   13fa0:	0026d783          	lhu	a5,2(a3)
   13fa4:	01079613          	slli	a2,a5,0x10
   13fa8:	41065613          	srai	a2,a2,0x10
   13fac:	00065463          	bgez	a2,13fb4 <eshup1+0x1c>
   13fb0:	00176713          	ori	a4,a4,1
   13fb4:	00179793          	slli	a5,a5,0x1
   13fb8:	01079793          	slli	a5,a5,0x10
   13fbc:	00277613          	andi	a2,a4,2
   13fc0:	0107d793          	srli	a5,a5,0x10
   13fc4:	02061063          	bnez	a2,13fe4 <eshup1+0x4c>
   13fc8:	00171713          	slli	a4,a4,0x1
   13fcc:	00f69123          	sh	a5,2(a3)
   13fd0:	01071713          	slli	a4,a4,0x10
   13fd4:	ffe68693          	addi	a3,a3,-2
   13fd8:	01075713          	srli	a4,a4,0x10
   13fdc:	fcd512e3          	bne	a0,a3,13fa0 <eshup1+0x8>
   13fe0:	00008067          	ret
   13fe4:	0017e793          	ori	a5,a5,1
   13fe8:	fe1ff06f          	j	13fc8 <eshup1+0x30>

00013fec <eshdn8>:
   13fec:	00450793          	addi	a5,a0,4
   13ff0:	00000713          	li	a4,0
   13ff4:	01a50513          	addi	a0,a0,26
   13ff8:	0007d683          	lhu	a3,0(a5)
   13ffc:	00278793          	addi	a5,a5,2
   14000:	0086d613          	srli	a2,a3,0x8
   14004:	00c76733          	or	a4,a4,a2
   14008:	fee79f23          	sh	a4,-2(a5)
   1400c:	00869713          	slli	a4,a3,0x8
   14010:	01071713          	slli	a4,a4,0x10
   14014:	01075713          	srli	a4,a4,0x10
   14018:	fef510e3          	bne	a0,a5,13ff8 <eshdn8+0xc>
   1401c:	00008067          	ret

00014020 <eshup8>:
   14020:	01650793          	addi	a5,a0,22
   14024:	00000713          	li	a4,0
   14028:	0027d683          	lhu	a3,2(a5)
   1402c:	ffe78793          	addi	a5,a5,-2
   14030:	00869613          	slli	a2,a3,0x8
   14034:	00c76733          	or	a4,a4,a2
   14038:	00e79223          	sh	a4,4(a5)
   1403c:	0086d713          	srli	a4,a3,0x8
   14040:	fef514e3          	bne	a0,a5,14028 <eshup8+0x8>
   14044:	00008067          	ret

00014048 <eshup6>:
   14048:	00450793          	addi	a5,a0,4
   1404c:	01850713          	addi	a4,a0,24
   14050:	00278793          	addi	a5,a5,2
   14054:	0007d683          	lhu	a3,0(a5)
   14058:	fed79f23          	sh	a3,-2(a5)
   1405c:	fef71ae3          	bne	a4,a5,14050 <eshup6+0x8>
   14060:	00051c23          	sh	zero,24(a0)
   14064:	00008067          	ret

00014068 <eshdn6>:
   14068:	01850793          	addi	a5,a0,24
   1406c:	01a50713          	addi	a4,a0,26
   14070:	00450693          	addi	a3,a0,4
   14074:	ffe78793          	addi	a5,a5,-2
   14078:	0007d603          	lhu	a2,0(a5)
   1407c:	ffe70713          	addi	a4,a4,-2
   14080:	00c71023          	sh	a2,0(a4)
   14084:	fef698e3          	bne	a3,a5,14074 <eshdn6+0xc>
   14088:	00051223          	sh	zero,4(a0)
   1408c:	00008067          	ret

00014090 <eaddm>:
   14090:	01858593          	addi	a1,a1,24
   14094:	01650713          	addi	a4,a0,22
   14098:	00000693          	li	a3,0
   1409c:	00275783          	lhu	a5,2(a4)
   140a0:	0005d603          	lhu	a2,0(a1)
   140a4:	ffe70713          	addi	a4,a4,-2
   140a8:	ffe58593          	addi	a1,a1,-2
   140ac:	00c787b3          	add	a5,a5,a2
   140b0:	00d787b3          	add	a5,a5,a3
   140b4:	00f59123          	sh	a5,2(a1)
   140b8:	0107d793          	srli	a5,a5,0x10
   140bc:	0017f693          	andi	a3,a5,1
   140c0:	fce51ee3          	bne	a0,a4,1409c <eaddm+0xc>
   140c4:	00008067          	ret

000140c8 <esubm>:
   140c8:	01858593          	addi	a1,a1,24
   140cc:	01650713          	addi	a4,a0,22
   140d0:	00000693          	li	a3,0
   140d4:	0005d783          	lhu	a5,0(a1)
   140d8:	00275603          	lhu	a2,2(a4)
   140dc:	ffe70713          	addi	a4,a4,-2
   140e0:	ffe58593          	addi	a1,a1,-2
   140e4:	40c787b3          	sub	a5,a5,a2
   140e8:	40d787b3          	sub	a5,a5,a3
   140ec:	00f59123          	sh	a5,2(a1)
   140f0:	0107d793          	srli	a5,a5,0x10
   140f4:	0017f693          	andi	a3,a5,1
   140f8:	fce51ee3          	bne	a0,a4,140d4 <esubm+0xc>
   140fc:	00008067          	ret

00014100 <m16m>:
   14100:	fb010113          	addi	sp,sp,-80
   14104:	03312e23          	sw	s3,60(sp)
   14108:	000109b7          	lui	s3,0x10
   1410c:	04812423          	sw	s0,72(sp)
   14110:	04912223          	sw	s1,68(sp)
   14114:	05212023          	sw	s2,64(sp)
   14118:	03412c23          	sw	s4,56(sp)
   1411c:	04112623          	sw	ra,76(sp)
   14120:	00050a13          	mv	s4,a0
   14124:	02011523          	sh	zero,42(sp)
   14128:	02011623          	sh	zero,44(sp)
   1412c:	01858493          	addi	s1,a1,24
   14130:	00458913          	addi	s2,a1,4
   14134:	02c10413          	addi	s0,sp,44
   14138:	fff98993          	addi	s3,s3,-1 # ffff <main-0x75>
   1413c:	0004d503          	lhu	a0,0(s1)
   14140:	ffe40413          	addi	s0,s0,-2
   14144:	ffe48493          	addi	s1,s1,-2
   14148:	04051863          	bnez	a0,14198 <m16m+0x98>
   1414c:	fe041f23          	sh	zero,-2(s0)
   14150:	fe9916e3          	bne	s2,s1,1413c <m16m+0x3c>
   14154:	00400793          	li	a5,4
   14158:	01a00713          	li	a4,26
   1415c:	01410593          	addi	a1,sp,20
   14160:	00f585b3          	add	a1,a1,a5
   14164:	0005d583          	lhu	a1,0(a1)
   14168:	00f606b3          	add	a3,a2,a5
   1416c:	00278793          	addi	a5,a5,2
   14170:	00b69023          	sh	a1,0(a3)
   14174:	fee794e3          	bne	a5,a4,1415c <m16m+0x5c>
   14178:	04c12083          	lw	ra,76(sp)
   1417c:	04812403          	lw	s0,72(sp)
   14180:	04412483          	lw	s1,68(sp)
   14184:	04012903          	lw	s2,64(sp)
   14188:	03c12983          	lw	s3,60(sp)
   1418c:	03812a03          	lw	s4,56(sp)
   14190:	05010113          	addi	sp,sp,80
   14194:	00008067          	ret
   14198:	000a0593          	mv	a1,s4
   1419c:	00c12623          	sw	a2,12(sp)
   141a0:	40c0d0ef          	jal	ra,215ac <__mulsi3>
   141a4:	00245703          	lhu	a4,2(s0)
   141a8:	013577b3          	and	a5,a0,s3
   141ac:	01055513          	srli	a0,a0,0x10
   141b0:	00e787b3          	add	a5,a5,a4
   141b4:	00045703          	lhu	a4,0(s0)
   141b8:	00f41123          	sh	a5,2(s0)
   141bc:	0107d793          	srli	a5,a5,0x10
   141c0:	00e50533          	add	a0,a0,a4
   141c4:	00f50533          	add	a0,a0,a5
   141c8:	00a41023          	sh	a0,0(s0)
   141cc:	01055513          	srli	a0,a0,0x10
   141d0:	fea41f23          	sh	a0,-2(s0)
   141d4:	00c12603          	lw	a2,12(sp)
   141d8:	f79ff06f          	j	14150 <m16m+0x50>

000141dc <eisnan>:
   141dc:	01255783          	lhu	a5,18(a0)
   141e0:	fff7c793          	not	a5,a5
   141e4:	01179713          	slli	a4,a5,0x11
   141e8:	00071c63          	bnez	a4,14200 <eisnan+0x24>
   141ec:	01250793          	addi	a5,a0,18
   141f0:	00250513          	addi	a0,a0,2
   141f4:	ffe55703          	lhu	a4,-2(a0)
   141f8:	00071863          	bnez	a4,14208 <eisnan+0x2c>
   141fc:	fea79ae3          	bne	a5,a0,141f0 <eisnan+0x14>
   14200:	00000513          	li	a0,0
   14204:	00008067          	ret
   14208:	00100513          	li	a0,1
   1420c:	00008067          	ret

00014210 <eisneg>:
   14210:	ff010113          	addi	sp,sp,-16
   14214:	00812423          	sw	s0,8(sp)
   14218:	00112623          	sw	ra,12(sp)
   1421c:	00050413          	mv	s0,a0
   14220:	fbdff0ef          	jal	ra,141dc <eisnan>
   14224:	00051e63          	bnez	a0,14240 <eisneg+0x30>
   14228:	01241503          	lh	a0,18(s0)
   1422c:	01f55513          	srli	a0,a0,0x1f
   14230:	00c12083          	lw	ra,12(sp)
   14234:	00812403          	lw	s0,8(sp)
   14238:	01010113          	addi	sp,sp,16
   1423c:	00008067          	ret
   14240:	00000513          	li	a0,0
   14244:	fedff06f          	j	14230 <eisneg+0x20>

00014248 <emovi>:
   14248:	01251783          	lh	a5,18(a0)
   1424c:	ff010113          	addi	sp,sp,-16
   14250:	00112623          	sw	ra,12(sp)
   14254:	00812423          	sw	s0,8(sp)
   14258:	00912223          	sw	s1,4(sp)
   1425c:	01212023          	sw	s2,0(sp)
   14260:	0607d863          	bgez	a5,142d0 <emovi+0x88>
   14264:	fff00793          	li	a5,-1
   14268:	00f59023          	sh	a5,0(a1)
   1426c:	01255703          	lhu	a4,18(a0)
   14270:	000087b7          	lui	a5,0x8
   14274:	fff78793          	addi	a5,a5,-1 # 7fff <main-0x8075>
   14278:	00e7f733          	and	a4,a5,a4
   1427c:	00e59123          	sh	a4,2(a1)
   14280:	01050913          	addi	s2,a0,16
   14284:	06f71663          	bne	a4,a5,142f0 <emovi+0xa8>
   14288:	00058413          	mv	s0,a1
   1428c:	00050493          	mv	s1,a0
   14290:	f4dff0ef          	jal	ra,141dc <eisnan>
   14294:	04050263          	beqz	a0,142d8 <emovi+0x90>
   14298:	00640793          	addi	a5,s0,6
   1429c:	00041223          	sh	zero,4(s0)
   142a0:	ffc48513          	addi	a0,s1,-4
   142a4:	ffe90913          	addi	s2,s2,-2
   142a8:	00295703          	lhu	a4,2(s2)
   142ac:	00278793          	addi	a5,a5,2
   142b0:	fee79f23          	sh	a4,-2(a5)
   142b4:	fea918e3          	bne	s2,a0,142a4 <emovi+0x5c>
   142b8:	00c12083          	lw	ra,12(sp)
   142bc:	00812403          	lw	s0,8(sp)
   142c0:	00412483          	lw	s1,4(sp)
   142c4:	00012903          	lw	s2,0(sp)
   142c8:	01010113          	addi	sp,sp,16
   142cc:	00008067          	ret
   142d0:	00059023          	sh	zero,0(a1)
   142d4:	f99ff06f          	j	1426c <emovi+0x24>
   142d8:	00440793          	addi	a5,s0,4
   142dc:	01a40593          	addi	a1,s0,26
   142e0:	00278793          	addi	a5,a5,2
   142e4:	fe079f23          	sh	zero,-2(a5)
   142e8:	feb79ce3          	bne	a5,a1,142e0 <emovi+0x98>
   142ec:	fcdff06f          	j	142b8 <emovi+0x70>
   142f0:	00658793          	addi	a5,a1,6
   142f4:	00059223          	sh	zero,4(a1)
   142f8:	ffe50513          	addi	a0,a0,-2
   142fc:	ffe90913          	addi	s2,s2,-2
   14300:	00295703          	lhu	a4,2(s2)
   14304:	00278793          	addi	a5,a5,2
   14308:	fee79f23          	sh	a4,-2(a5)
   1430c:	fea918e3          	bne	s2,a0,142fc <emovi+0xb4>
   14310:	00059c23          	sh	zero,24(a1)
   14314:	fa5ff06f          	j	142b8 <emovi+0x70>

00014318 <ecmp>:
   14318:	fb010113          	addi	sp,sp,-80
   1431c:	04912223          	sw	s1,68(sp)
   14320:	05212023          	sw	s2,64(sp)
   14324:	04112623          	sw	ra,76(sp)
   14328:	04812423          	sw	s0,72(sp)
   1432c:	00050913          	mv	s2,a0
   14330:	00058493          	mv	s1,a1
   14334:	ea9ff0ef          	jal	ra,141dc <eisnan>
   14338:	0e051063          	bnez	a0,14418 <ecmp+0x100>
   1433c:	00048513          	mv	a0,s1
   14340:	e9dff0ef          	jal	ra,141dc <eisnan>
   14344:	00050413          	mv	s0,a0
   14348:	0c051863          	bnez	a0,14418 <ecmp+0x100>
   1434c:	00810593          	addi	a1,sp,8
   14350:	00090513          	mv	a0,s2
   14354:	ef5ff0ef          	jal	ra,14248 <emovi>
   14358:	02410593          	addi	a1,sp,36
   1435c:	00048513          	mv	a0,s1
   14360:	ee9ff0ef          	jal	ra,14248 <emovi>
   14364:	00815703          	lhu	a4,8(sp)
   14368:	02415783          	lhu	a5,36(sp)
   1436c:	06e78063          	beq	a5,a4,143cc <ecmp+0xb4>
   14370:	00200793          	li	a5,2
   14374:	01800693          	li	a3,24
   14378:	00810613          	addi	a2,sp,8
   1437c:	00f60633          	add	a2,a2,a5
   14380:	00065603          	lhu	a2,0(a2) # ffff8000 <__global_pointer$+0xfffd38a0>
   14384:	02061c63          	bnez	a2,143bc <ecmp+0xa4>
   14388:	02410613          	addi	a2,sp,36
   1438c:	00f60633          	add	a2,a2,a5
   14390:	00065603          	lhu	a2,0(a2)
   14394:	02061463          	bnez	a2,143bc <ecmp+0xa4>
   14398:	00278793          	addi	a5,a5,2
   1439c:	fcd79ee3          	bne	a5,a3,14378 <ecmp+0x60>
   143a0:	00040513          	mv	a0,s0
   143a4:	04c12083          	lw	ra,76(sp)
   143a8:	04812403          	lw	s0,72(sp)
   143ac:	04412483          	lw	s1,68(sp)
   143b0:	04012903          	lw	s2,64(sp)
   143b4:	05010113          	addi	sp,sp,80
   143b8:	00008067          	ret
   143bc:	00100413          	li	s0,1
   143c0:	fe0700e3          	beqz	a4,143a0 <ecmp+0x88>
   143c4:	fff00413          	li	s0,-1
   143c8:	fd9ff06f          	j	143a0 <ecmp+0x88>
   143cc:	00100613          	li	a2,1
   143d0:	00078463          	beqz	a5,143d8 <ecmp+0xc0>
   143d4:	fff00613          	li	a2,-1
   143d8:	00000793          	li	a5,0
   143dc:	01800593          	li	a1,24
   143e0:	00810713          	addi	a4,sp,8
   143e4:	00f70733          	add	a4,a4,a5
   143e8:	00075683          	lhu	a3,0(a4)
   143ec:	02410713          	addi	a4,sp,36
   143f0:	00f70733          	add	a4,a4,a5
   143f4:	00075703          	lhu	a4,0(a4)
   143f8:	00e69863          	bne	a3,a4,14408 <ecmp+0xf0>
   143fc:	00278793          	addi	a5,a5,2
   14400:	feb790e3          	bne	a5,a1,143e0 <ecmp+0xc8>
   14404:	f9dff06f          	j	143a0 <ecmp+0x88>
   14408:	00060413          	mv	s0,a2
   1440c:	f8d76ae3          	bltu	a4,a3,143a0 <ecmp+0x88>
   14410:	40c00433          	neg	s0,a2
   14414:	f8dff06f          	j	143a0 <ecmp+0x88>
   14418:	ffe00413          	li	s0,-2
   1441c:	f85ff06f          	j	143a0 <ecmp+0x88>

00014420 <eisinf>:
   14420:	01255783          	lhu	a5,18(a0)
   14424:	fff7c793          	not	a5,a5
   14428:	01179713          	slli	a4,a5,0x11
   1442c:	02071063          	bnez	a4,1444c <eisinf+0x2c>
   14430:	ff010113          	addi	sp,sp,-16
   14434:	00112623          	sw	ra,12(sp)
   14438:	da5ff0ef          	jal	ra,141dc <eisnan>
   1443c:	00c12083          	lw	ra,12(sp)
   14440:	00153513          	seqz	a0,a0
   14444:	01010113          	addi	sp,sp,16
   14448:	00008067          	ret
   1444c:	00000513          	li	a0,0
   14450:	00008067          	ret

00014454 <einfin.isra.2>:
   14454:	01250793          	addi	a5,a0,18
   14458:	00250513          	addi	a0,a0,2
   1445c:	fe051f23          	sh	zero,-2(a0)
   14460:	fef51ce3          	bne	a0,a5,14458 <einfin.isra.2+0x4>
   14464:	00055783          	lhu	a5,0(a0)
   14468:	00008737          	lui	a4,0x8
   1446c:	fff70713          	addi	a4,a4,-1 # 7fff <main-0x8075>
   14470:	00e7e7b3          	or	a5,a5,a4
   14474:	00f51023          	sh	a5,0(a0)
   14478:	00008067          	ret

0001447c <eshift.part.3>:
   1447c:	fe010113          	addi	sp,sp,-32
   14480:	00812c23          	sw	s0,24(sp)
   14484:	01212823          	sw	s2,16(sp)
   14488:	00112e23          	sw	ra,28(sp)
   1448c:	00912a23          	sw	s1,20(sp)
   14490:	01312623          	sw	s3,12(sp)
   14494:	01412423          	sw	s4,8(sp)
   14498:	01512223          	sw	s5,4(sp)
   1449c:	00050913          	mv	s2,a0
   144a0:	00058413          	mv	s0,a1
   144a4:	1005d263          	bgez	a1,145a8 <eshift.part.3+0x12c>
   144a8:	40b00a33          	neg	s4,a1
   144ac:	000a0993          	mv	s3,s4
   144b0:	00000493          	li	s1,0
   144b4:	00f00a93          	li	s5,15
   144b8:	033ace63          	blt	s5,s3,144f4 <eshift.part.3+0x78>
   144bc:	004a5513          	srli	a0,s4,0x4
   144c0:	ff000593          	li	a1,-16
   144c4:	0e80d0ef          	jal	ra,215ac <__mulsi3>
   144c8:	40850433          	sub	s0,a0,s0
   144cc:	00040993          	mv	s3,s0
   144d0:	00700a13          	li	s4,7
   144d4:	033a4c63          	blt	s4,s3,1450c <eshift.part.3+0x90>
   144d8:	00345513          	srli	a0,s0,0x3
   144dc:	ff800593          	li	a1,-8
   144e0:	0cc0d0ef          	jal	ra,215ac <__mulsi3>
   144e4:	00850433          	add	s0,a0,s0
   144e8:	02041e63          	bnez	s0,14524 <eshift.part.3+0xa8>
   144ec:	00903533          	snez	a0,s1
   144f0:	0940006f          	j	14584 <eshift.part.3+0x108>
   144f4:	01895783          	lhu	a5,24(s2)
   144f8:	00090513          	mv	a0,s2
   144fc:	ff098993          	addi	s3,s3,-16
   14500:	00f4e4b3          	or	s1,s1,a5
   14504:	b65ff0ef          	jal	ra,14068 <eshdn6>
   14508:	fb1ff06f          	j	144b8 <eshift.part.3+0x3c>
   1450c:	01894783          	lbu	a5,24(s2)
   14510:	00090513          	mv	a0,s2
   14514:	ff898993          	addi	s3,s3,-8
   14518:	0097e4b3          	or	s1,a5,s1
   1451c:	ad1ff0ef          	jal	ra,13fec <eshdn8>
   14520:	fb5ff06f          	j	144d4 <eshift.part.3+0x58>
   14524:	01895783          	lhu	a5,24(s2)
   14528:	00090513          	mv	a0,s2
   1452c:	fff40413          	addi	s0,s0,-1
   14530:	0017f793          	andi	a5,a5,1
   14534:	0097e4b3          	or	s1,a5,s1
   14538:	a11ff0ef          	jal	ra,13f48 <eshdn1>
   1453c:	fadff06f          	j	144e8 <eshift.part.3+0x6c>
   14540:	00090513          	mv	a0,s2
   14544:	b05ff0ef          	jal	ra,14048 <eshup6>
   14548:	ff048493          	addi	s1,s1,-16
   1454c:	fe99cae3          	blt	s3,s1,14540 <eshift.part.3+0xc4>
   14550:	00445513          	srli	a0,s0,0x4
   14554:	ff000593          	li	a1,-16
   14558:	0540d0ef          	jal	ra,215ac <__mulsi3>
   1455c:	00a40433          	add	s0,s0,a0
   14560:	00040493          	mv	s1,s0
   14564:	00700993          	li	s3,7
   14568:	0499c663          	blt	s3,s1,145b4 <eshift.part.3+0x138>
   1456c:	00345513          	srli	a0,s0,0x3
   14570:	ff800593          	li	a1,-8
   14574:	0380d0ef          	jal	ra,215ac <__mulsi3>
   14578:	00a40433          	add	s0,s0,a0
   1457c:	04041463          	bnez	s0,145c4 <eshift.part.3+0x148>
   14580:	00000513          	li	a0,0
   14584:	01c12083          	lw	ra,28(sp)
   14588:	01812403          	lw	s0,24(sp)
   1458c:	01412483          	lw	s1,20(sp)
   14590:	01012903          	lw	s2,16(sp)
   14594:	00c12983          	lw	s3,12(sp)
   14598:	00812a03          	lw	s4,8(sp)
   1459c:	00412a83          	lw	s5,4(sp)
   145a0:	02010113          	addi	sp,sp,32
   145a4:	00008067          	ret
   145a8:	00058493          	mv	s1,a1
   145ac:	00f00993          	li	s3,15
   145b0:	f9dff06f          	j	1454c <eshift.part.3+0xd0>
   145b4:	00090513          	mv	a0,s2
   145b8:	a69ff0ef          	jal	ra,14020 <eshup8>
   145bc:	ff848493          	addi	s1,s1,-8
   145c0:	fa9ff06f          	j	14568 <eshift.part.3+0xec>
   145c4:	00090513          	mv	a0,s2
   145c8:	9d1ff0ef          	jal	ra,13f98 <eshup1>
   145cc:	fff40413          	addi	s0,s0,-1
   145d0:	fadff06f          	j	1457c <eshift.part.3+0x100>

000145d4 <enormlz>:
   145d4:	00455783          	lhu	a5,4(a0)
   145d8:	ff010113          	addi	sp,sp,-16
   145dc:	00912223          	sw	s1,4(sp)
   145e0:	00112623          	sw	ra,12(sp)
   145e4:	00812423          	sw	s0,8(sp)
   145e8:	01212023          	sw	s2,0(sp)
   145ec:	00050493          	mv	s1,a0
   145f0:	08079263          	bnez	a5,14674 <enormlz+0xa0>
   145f4:	00651783          	lh	a5,6(a0)
   145f8:	00000413          	li	s0,0
   145fc:	0a000913          	li	s2,160
   14600:	0207d863          	bgez	a5,14630 <enormlz+0x5c>
   14604:	00040513          	mv	a0,s0
   14608:	00c12083          	lw	ra,12(sp)
   1460c:	00812403          	lw	s0,8(sp)
   14610:	00412483          	lw	s1,4(sp)
   14614:	00012903          	lw	s2,0(sp)
   14618:	01010113          	addi	sp,sp,16
   1461c:	00008067          	ret
   14620:	00048513          	mv	a0,s1
   14624:	01040413          	addi	s0,s0,16
   14628:	a21ff0ef          	jal	ra,14048 <eshup6>
   1462c:	fd240ce3          	beq	s0,s2,14604 <enormlz+0x30>
   14630:	0064d783          	lhu	a5,6(s1)
   14634:	fe0786e3          	beqz	a5,14620 <enormlz+0x4c>
   14638:	0064d783          	lhu	a5,6(s1)
   1463c:	f007f793          	andi	a5,a5,-256
   14640:	02078263          	beqz	a5,14664 <enormlz+0x90>
   14644:	0a000913          	li	s2,160
   14648:	00649783          	lh	a5,6(s1)
   1464c:	fa07cce3          	bltz	a5,14604 <enormlz+0x30>
   14650:	00048513          	mv	a0,s1
   14654:	00140413          	addi	s0,s0,1
   14658:	941ff0ef          	jal	ra,13f98 <eshup1>
   1465c:	fe8956e3          	ble	s0,s2,14648 <enormlz+0x74>
   14660:	fa5ff06f          	j	14604 <enormlz+0x30>
   14664:	00048513          	mv	a0,s1
   14668:	9b9ff0ef          	jal	ra,14020 <eshup8>
   1466c:	00840413          	addi	s0,s0,8
   14670:	fc9ff06f          	j	14638 <enormlz+0x64>
   14674:	f007f793          	andi	a5,a5,-256
   14678:	00000413          	li	s0,0
   1467c:	00078663          	beqz	a5,14688 <enormlz+0xb4>
   14680:	96dff0ef          	jal	ra,13fec <eshdn8>
   14684:	ff800413          	li	s0,-8
   14688:	f7000913          	li	s2,-144
   1468c:	0140006f          	j	146a0 <enormlz+0xcc>
   14690:	00048513          	mv	a0,s1
   14694:	fff40413          	addi	s0,s0,-1
   14698:	8b1ff0ef          	jal	ra,13f48 <eshdn1>
   1469c:	f72444e3          	blt	s0,s2,14604 <enormlz+0x30>
   146a0:	0044d783          	lhu	a5,4(s1)
   146a4:	fe0796e3          	bnez	a5,14690 <enormlz+0xbc>
   146a8:	f5dff06f          	j	14604 <enormlz+0x30>

000146ac <enan.constprop.12>:
   146ac:	01050793          	addi	a5,a0,16
   146b0:	00250513          	addi	a0,a0,2
   146b4:	fe051f23          	sh	zero,-2(a0)
   146b8:	fef51ce3          	bne	a0,a5,146b0 <enan.constprop.12+0x4>
   146bc:	ffffc7b7          	lui	a5,0xffffc
   146c0:	00f51023          	sh	a5,0(a0)
   146c4:	000087b7          	lui	a5,0x8
   146c8:	fff78793          	addi	a5,a5,-1 # 7fff <main-0x8075>
   146cc:	00f51123          	sh	a5,2(a0)
   146d0:	00008067          	ret

000146d4 <emovo.isra.6>:
   146d4:	00050713          	mv	a4,a0
   146d8:	00075683          	lhu	a3,0(a4)
   146dc:	00058513          	mv	a0,a1
   146e0:	00275783          	lhu	a5,2(a4)
   146e4:	00068663          	beqz	a3,146f0 <emovo.isra.6+0x1c>
   146e8:	ffff86b7          	lui	a3,0xffff8
   146ec:	00d7e7b3          	or	a5,a5,a3
   146f0:	00f51923          	sh	a5,18(a0)
   146f4:	00275603          	lhu	a2,2(a4)
   146f8:	000086b7          	lui	a3,0x8
   146fc:	fff68693          	addi	a3,a3,-1 # 7fff <main-0x8075>
   14700:	00670793          	addi	a5,a4,6
   14704:	00d61e63          	bne	a2,a3,14720 <emovo.isra.6+0x4c>
   14708:	01a70713          	addi	a4,a4,26
   1470c:	0007d683          	lhu	a3,0(a5)
   14710:	02069863          	bnez	a3,14740 <emovo.isra.6+0x6c>
   14714:	00278793          	addi	a5,a5,2
   14718:	fee79ae3          	bne	a5,a4,1470c <emovo.isra.6+0x38>
   1471c:	d39ff06f          	j	14454 <einfin.isra.2>
   14720:	01050513          	addi	a0,a0,16
   14724:	01870713          	addi	a4,a4,24
   14728:	00278793          	addi	a5,a5,2
   1472c:	ffe7d683          	lhu	a3,-2(a5)
   14730:	ffe50513          	addi	a0,a0,-2
   14734:	00d51123          	sh	a3,2(a0)
   14738:	fee798e3          	bne	a5,a4,14728 <emovo.isra.6+0x54>
   1473c:	00008067          	ret
   14740:	f6dff06f          	j	146ac <enan.constprop.12>

00014744 <e113toe.isra.8>:
   14744:	fd010113          	addi	sp,sp,-48
   14748:	02912223          	sw	s1,36(sp)
   1474c:	00050493          	mv	s1,a0
   14750:	00410513          	addi	a0,sp,4
   14754:	02812423          	sw	s0,40(sp)
   14758:	02112623          	sw	ra,44(sp)
   1475c:	00058413          	mv	s0,a1
   14760:	f74ff0ef          	jal	ra,13ed4 <ecleaz>
   14764:	00e4d703          	lhu	a4,14(s1)
   14768:	01071793          	slli	a5,a4,0x10
   1476c:	4107d793          	srai	a5,a5,0x10
   14770:	0407c263          	bltz	a5,147b4 <e113toe.isra.8+0x70>
   14774:	00011223          	sh	zero,4(sp)
   14778:	000086b7          	lui	a3,0x8
   1477c:	fff68693          	addi	a3,a3,-1 # 7fff <main-0x8075>
   14780:	00d77733          	and	a4,a4,a3
   14784:	00e48793          	addi	a5,s1,14
   14788:	06d71c63          	bne	a4,a3,14800 <e113toe.isra.8+0xbc>
   1478c:	00048713          	mv	a4,s1
   14790:	00075683          	lhu	a3,0(a4)
   14794:	02068663          	beqz	a3,147c0 <e113toe.isra.8+0x7c>
   14798:	00040513          	mv	a0,s0
   1479c:	f11ff0ef          	jal	ra,146ac <enan.constprop.12>
   147a0:	02c12083          	lw	ra,44(sp)
   147a4:	02812403          	lw	s0,40(sp)
   147a8:	02412483          	lw	s1,36(sp)
   147ac:	03010113          	addi	sp,sp,48
   147b0:	00008067          	ret
   147b4:	fff00793          	li	a5,-1
   147b8:	00f11223          	sh	a5,4(sp)
   147bc:	fbdff06f          	j	14778 <e113toe.isra.8+0x34>
   147c0:	00270713          	addi	a4,a4,2
   147c4:	fce796e3          	bne	a5,a4,14790 <e113toe.isra.8+0x4c>
   147c8:	00040513          	mv	a0,s0
   147cc:	ed8ff0ef          	jal	ra,13ea4 <eclear>
   147d0:	00040513          	mv	a0,s0
   147d4:	c81ff0ef          	jal	ra,14454 <einfin.isra.2>
   147d8:	00e49783          	lh	a5,14(s1)
   147dc:	fc07d2e3          	bgez	a5,147a0 <e113toe.isra.8+0x5c>
   147e0:	00040513          	mv	a0,s0
   147e4:	9f9ff0ef          	jal	ra,141dc <eisnan>
   147e8:	fa051ce3          	bnez	a0,147a0 <e113toe.isra.8+0x5c>
   147ec:	01245783          	lhu	a5,18(s0)
   147f0:	ffff8737          	lui	a4,0xffff8
   147f4:	00e7c7b3          	xor	a5,a5,a4
   147f8:	00f41923          	sh	a5,18(s0)
   147fc:	fa5ff06f          	j	147a0 <e113toe.isra.8+0x5c>
   14800:	00e11323          	sh	a4,6(sp)
   14804:	00410693          	addi	a3,sp,4
   14808:	ffe78793          	addi	a5,a5,-2
   1480c:	0007d603          	lhu	a2,0(a5)
   14810:	00268693          	addi	a3,a3,2
   14814:	00c69223          	sh	a2,4(a3)
   14818:	fef498e3          	bne	s1,a5,14808 <e113toe.isra.8+0xc4>
   1481c:	00071c63          	bnez	a4,14834 <e113toe.isra.8+0xf0>
   14820:	00011423          	sh	zero,8(sp)
   14824:	00040593          	mv	a1,s0
   14828:	00410513          	addi	a0,sp,4
   1482c:	ea9ff0ef          	jal	ra,146d4 <emovo.isra.6>
   14830:	f71ff06f          	j	147a0 <e113toe.isra.8+0x5c>
   14834:	00100793          	li	a5,1
   14838:	fff00593          	li	a1,-1
   1483c:	00410513          	addi	a0,sp,4
   14840:	00f11423          	sh	a5,8(sp)
   14844:	c39ff0ef          	jal	ra,1447c <eshift.part.3>
   14848:	fddff06f          	j	14824 <e113toe.isra.8+0xe0>

0001484c <emdnorm>:
   1484c:	fe010113          	addi	sp,sp,-32
   14850:	00812c23          	sw	s0,24(sp)
   14854:	00912a23          	sw	s1,20(sp)
   14858:	01212823          	sw	s2,16(sp)
   1485c:	01312623          	sw	s3,12(sp)
   14860:	01412423          	sw	s4,8(sp)
   14864:	01512223          	sw	s5,4(sp)
   14868:	00068913          	mv	s2,a3
   1486c:	00078413          	mv	s0,a5
   14870:	00112e23          	sw	ra,28(sp)
   14874:	00050493          	mv	s1,a0
   14878:	00058993          	mv	s3,a1
   1487c:	00060a13          	mv	s4,a2
   14880:	00070a93          	mv	s5,a4
   14884:	d51ff0ef          	jal	ra,145d4 <enormlz>
   14888:	09000793          	li	a5,144
   1488c:	40a90933          	sub	s2,s2,a0
   14890:	04a7d463          	ble	a0,a5,148d8 <emdnorm+0x8c>
   14894:	000087b7          	lui	a5,0x8
   14898:	ffe78793          	addi	a5,a5,-2 # 7ffe <main-0x8076>
   1489c:	2d27c663          	blt	a5,s2,14b68 <emdnorm+0x31c>
   148a0:	00248793          	addi	a5,s1,2
   148a4:	01a48493          	addi	s1,s1,26
   148a8:	00278793          	addi	a5,a5,2
   148ac:	fe079f23          	sh	zero,-2(a5)
   148b0:	fe979ce3          	bne	a5,s1,148a8 <emdnorm+0x5c>
   148b4:	01c12083          	lw	ra,28(sp)
   148b8:	01812403          	lw	s0,24(sp)
   148bc:	01412483          	lw	s1,20(sp)
   148c0:	01012903          	lw	s2,16(sp)
   148c4:	00c12983          	lw	s3,12(sp)
   148c8:	00812a03          	lw	s4,8(sp)
   148cc:	00412a83          	lw	s5,4(sp)
   148d0:	02010113          	addi	sp,sp,32
   148d4:	00008067          	ret
   148d8:	00095e63          	bgez	s2,148f4 <emdnorm+0xa8>
   148dc:	f7000793          	li	a5,-144
   148e0:	12f94c63          	blt	s2,a5,14a18 <emdnorm+0x1cc>
   148e4:	00090593          	mv	a1,s2
   148e8:	00048513          	mv	a0,s1
   148ec:	b91ff0ef          	jal	ra,1447c <eshift.part.3>
   148f0:	14051063          	bnez	a0,14a30 <emdnorm+0x1e4>
   148f4:	220a8663          	beqz	s5,14b20 <emdnorm+0x2d4>
   148f8:	00442703          	lw	a4,4(s0)
   148fc:	00042783          	lw	a5,0(s0)
   14900:	06f70663          	beq	a4,a5,1496c <emdnorm+0x120>
   14904:	01a40513          	addi	a0,s0,26
   14908:	dccff0ef          	jal	ra,13ed4 <ecleaz>
   1490c:	00442783          	lw	a5,4(s0)
   14910:	03800713          	li	a4,56
   14914:	16e78e63          	beq	a5,a4,14a90 <emdnorm+0x244>
   14918:	12f74063          	blt	a4,a5,14a38 <emdnorm+0x1ec>
   1491c:	01800713          	li	a4,24
   14920:	1ae78663          	beq	a5,a4,14acc <emdnorm+0x280>
   14924:	03500713          	li	a4,53
   14928:	18e78263          	beq	a5,a4,14aac <emdnorm+0x260>
   1492c:	00c00713          	li	a4,12
   14930:	00e42423          	sw	a4,8(s0)
   14934:	80010737          	lui	a4,0x80010
   14938:	fff70713          	addi	a4,a4,-1 # 8000ffff <__global_pointer$+0x7ffeb89f>
   1493c:	00e42a23          	sw	a4,20(s0)
   14940:	00100713          	li	a4,1
   14944:	00e41c23          	sh	a4,24(s0)
   14948:	00b00713          	li	a4,11
   1494c:	00e42623          	sw	a4,12(s0)
   14950:	00c42703          	lw	a4,12(s0)
   14954:	01845683          	lhu	a3,24(s0)
   14958:	00870713          	addi	a4,a4,8
   1495c:	00171713          	slli	a4,a4,0x1
   14960:	00e40733          	add	a4,s0,a4
   14964:	00d71523          	sh	a3,10(a4)
   14968:	00f42023          	sw	a5,0(s0)
   1496c:	03204263          	bgtz	s2,14990 <emdnorm+0x144>
   14970:	00442703          	lw	a4,4(s0)
   14974:	09000793          	li	a5,144
   14978:	00f70c63          	beq	a4,a5,14990 <emdnorm+0x144>
   1497c:	0184d783          	lhu	a5,24(s1)
   14980:	00048513          	mv	a0,s1
   14984:	0017f793          	andi	a5,a5,1
   14988:	00f9e9b3          	or	s3,s3,a5
   1498c:	dbcff0ef          	jal	ra,13f48 <eshdn1>
   14990:	00842683          	lw	a3,8(s0)
   14994:	01445603          	lhu	a2,20(s0)
   14998:	00442583          	lw	a1,4(s0)
   1499c:	00169713          	slli	a4,a3,0x1
   149a0:	00e48733          	add	a4,s1,a4
   149a4:	00075783          	lhu	a5,0(a4)
   149a8:	00c7f7b3          	and	a5,a5,a2
   149ac:	08f00613          	li	a2,143
   149b0:	00b64a63          	blt	a2,a1,149c4 <emdnorm+0x178>
   149b4:	00168693          	addi	a3,a3,1
   149b8:	00070613          	mv	a2,a4
   149bc:	00c00593          	li	a1,12
   149c0:	10d5da63          	ble	a3,a1,14ad4 <emdnorm+0x288>
   149c4:	01445683          	lhu	a3,20(s0)
   149c8:	00075603          	lhu	a2,0(a4)
   149cc:	fff6c693          	not	a3,a3
   149d0:	00c6f6b3          	and	a3,a3,a2
   149d4:	00d71023          	sh	a3,0(a4)
   149d8:	01645703          	lhu	a4,22(s0)
   149dc:	00f776b3          	and	a3,a4,a5
   149e0:	10068a63          	beqz	a3,14af4 <emdnorm+0x2a8>
   149e4:	02f71263          	bne	a4,a5,14a08 <emdnorm+0x1bc>
   149e8:	10099463          	bnez	s3,14af0 <emdnorm+0x2a4>
   149ec:	00c42783          	lw	a5,12(s0)
   149f0:	01845703          	lhu	a4,24(s0)
   149f4:	00179793          	slli	a5,a5,0x1
   149f8:	00f487b3          	add	a5,s1,a5
   149fc:	0007d783          	lhu	a5,0(a5)
   14a00:	00e7f7b3          	and	a5,a5,a4
   14a04:	0e078863          	beqz	a5,14af4 <emdnorm+0x2a8>
   14a08:	00048593          	mv	a1,s1
   14a0c:	01a40513          	addi	a0,s0,26
   14a10:	e80ff0ef          	jal	ra,14090 <eaddm>
   14a14:	0e00006f          	j	14af4 <emdnorm+0x2a8>
   14a18:	00248793          	addi	a5,s1,2
   14a1c:	01a48493          	addi	s1,s1,26
   14a20:	00278793          	addi	a5,a5,2
   14a24:	fe079f23          	sh	zero,-2(a5)
   14a28:	fe979ce3          	bne	a5,s1,14a20 <emdnorm+0x1d4>
   14a2c:	e89ff06f          	j	148b4 <emdnorm+0x68>
   14a30:	00100993          	li	s3,1
   14a34:	ec1ff06f          	j	148f4 <emdnorm+0xa8>
   14a38:	04000713          	li	a4,64
   14a3c:	02e78863          	beq	a5,a4,14a6c <emdnorm+0x220>
   14a40:	07100713          	li	a4,113
   14a44:	eee794e3          	bne	a5,a4,1492c <emdnorm+0xe0>
   14a48:	40008737          	lui	a4,0x40008
   14a4c:	fff70713          	addi	a4,a4,-1 # 40007fff <__global_pointer$+0x3ffe389f>
   14a50:	00a00693          	li	a3,10
   14a54:	00e42a23          	sw	a4,20(s0)
   14a58:	00d42423          	sw	a3,8(s0)
   14a5c:	ffff8737          	lui	a4,0xffff8
   14a60:	00e41c23          	sh	a4,24(s0)
   14a64:	00d42623          	sw	a3,12(s0)
   14a68:	ee9ff06f          	j	14950 <emdnorm+0x104>
   14a6c:	00700713          	li	a4,7
   14a70:	00e42423          	sw	a4,8(s0)
   14a74:	80010737          	lui	a4,0x80010
   14a78:	fff70713          	addi	a4,a4,-1 # 8000ffff <__global_pointer$+0x7ffeb89f>
   14a7c:	00e42a23          	sw	a4,20(s0)
   14a80:	00100713          	li	a4,1
   14a84:	00e41c23          	sh	a4,24(s0)
   14a88:	00600713          	li	a4,6
   14a8c:	ec1ff06f          	j	1494c <emdnorm+0x100>
   14a90:	00600693          	li	a3,6
   14a94:	00800737          	lui	a4,0x800
   14a98:	0ff70713          	addi	a4,a4,255 # 8000ff <__global_pointer$+0x7db99f>
   14a9c:	00e42a23          	sw	a4,20(s0)
   14aa0:	00d42423          	sw	a3,8(s0)
   14aa4:	10000713          	li	a4,256
   14aa8:	fb9ff06f          	j	14a60 <emdnorm+0x214>
   14aac:	04000737          	lui	a4,0x4000
   14ab0:	7ff70713          	addi	a4,a4,2047 # 40007ff <__global_pointer$+0x3fdc09f>
   14ab4:	00600693          	li	a3,6
   14ab8:	00e42a23          	sw	a4,20(s0)
   14abc:	00001737          	lui	a4,0x1
   14ac0:	00d42423          	sw	a3,8(s0)
   14ac4:	80070713          	addi	a4,a4,-2048 # 800 <main-0xf874>
   14ac8:	f99ff06f          	j	14a60 <emdnorm+0x214>
   14acc:	00400693          	li	a3,4
   14ad0:	fc5ff06f          	j	14a94 <emdnorm+0x248>
   14ad4:	00265503          	lhu	a0,2(a2)
   14ad8:	00050463          	beqz	a0,14ae0 <emdnorm+0x294>
   14adc:	0017e793          	ori	a5,a5,1
   14ae0:	00061123          	sh	zero,2(a2)
   14ae4:	00168693          	addi	a3,a3,1
   14ae8:	00260613          	addi	a2,a2,2
   14aec:	ed5ff06f          	j	149c0 <emdnorm+0x174>
   14af0:	f00a0ce3          	beqz	s4,14a08 <emdnorm+0x1bc>
   14af4:	01204c63          	bgtz	s2,14b0c <emdnorm+0x2c0>
   14af8:	00442703          	lw	a4,4(s0)
   14afc:	09000793          	li	a5,144
   14b00:	00f70663          	beq	a4,a5,14b0c <emdnorm+0x2c0>
   14b04:	00048513          	mv	a0,s1
   14b08:	c90ff0ef          	jal	ra,13f98 <eshup1>
   14b0c:	0044d783          	lhu	a5,4(s1)
   14b10:	00078863          	beqz	a5,14b20 <emdnorm+0x2d4>
   14b14:	00048513          	mv	a0,s1
   14b18:	c30ff0ef          	jal	ra,13f48 <eshdn1>
   14b1c:	00190913          	addi	s2,s2,1
   14b20:	000087b7          	lui	a5,0x8
   14b24:	00049c23          	sh	zero,24(s1)
   14b28:	ffe78793          	addi	a5,a5,-2 # 7ffe <main-0x8076>
   14b2c:	0327d463          	ble	s2,a5,14b54 <emdnorm+0x308>
   14b30:	ffff87b7          	lui	a5,0xffff8
   14b34:	fff7c793          	not	a5,a5
   14b38:	00f49123          	sh	a5,2(s1)
   14b3c:	00448793          	addi	a5,s1,4
   14b40:	01848493          	addi	s1,s1,24
   14b44:	00079023          	sh	zero,0(a5) # ffff8000 <__global_pointer$+0xfffd38a0>
   14b48:	00278793          	addi	a5,a5,2
   14b4c:	fef49ce3          	bne	s1,a5,14b44 <emdnorm+0x2f8>
   14b50:	d65ff06f          	j	148b4 <emdnorm+0x68>
   14b54:	00095663          	bgez	s2,14b60 <emdnorm+0x314>
   14b58:	00049123          	sh	zero,2(s1)
   14b5c:	d59ff06f          	j	148b4 <emdnorm+0x68>
   14b60:	01249123          	sh	s2,2(s1)
   14b64:	d51ff06f          	j	148b4 <emdnorm+0x68>
   14b68:	d80a98e3          	bnez	s5,148f8 <emdnorm+0xac>
   14b6c:	00049c23          	sh	zero,24(s1)
   14b70:	fc1ff06f          	j	14b30 <emdnorm+0x2e4>

00014b74 <eiremain>:
   14b74:	fe010113          	addi	sp,sp,-32
   14b78:	01412423          	sw	s4,8(sp)
   14b7c:	00255a03          	lhu	s4,2(a0)
   14b80:	00812c23          	sw	s0,24(sp)
   14b84:	00058413          	mv	s0,a1
   14b88:	00112e23          	sw	ra,28(sp)
   14b8c:	00912a23          	sw	s1,20(sp)
   14b90:	01212823          	sw	s2,16(sp)
   14b94:	01512223          	sw	s5,4(sp)
   14b98:	01612023          	sw	s6,0(sp)
   14b9c:	00060913          	mv	s2,a2
   14ba0:	03460b13          	addi	s6,a2,52
   14ba4:	01312623          	sw	s3,12(sp)
   14ba8:	00050a93          	mv	s5,a0
   14bac:	a29ff0ef          	jal	ra,145d4 <enormlz>
   14bb0:	00245483          	lhu	s1,2(s0)
   14bb4:	40aa0a33          	sub	s4,s4,a0
   14bb8:	00040513          	mv	a0,s0
   14bbc:	a19ff0ef          	jal	ra,145d4 <enormlz>
   14bc0:	40a484b3          	sub	s1,s1,a0
   14bc4:	000b0513          	mv	a0,s6
   14bc8:	b0cff0ef          	jal	ra,13ed4 <ecleaz>
   14bcc:	0544d263          	ble	s4,s1,14c10 <eiremain+0x9c>
   14bd0:	00040513          	mv	a0,s0
   14bd4:	01812403          	lw	s0,24(sp)
   14bd8:	01c12083          	lw	ra,28(sp)
   14bdc:	00c12983          	lw	s3,12(sp)
   14be0:	00812a03          	lw	s4,8(sp)
   14be4:	00412a83          	lw	s5,4(sp)
   14be8:	00012b03          	lw	s6,0(sp)
   14bec:	00090793          	mv	a5,s2
   14bf0:	00048693          	mv	a3,s1
   14bf4:	01012903          	lw	s2,16(sp)
   14bf8:	01412483          	lw	s1,20(sp)
   14bfc:	00000713          	li	a4,0
   14c00:	00000613          	li	a2,0
   14c04:	00000593          	li	a1,0
   14c08:	02010113          	addi	sp,sp,32
   14c0c:	c41ff06f          	j	1484c <emdnorm>
   14c10:	00040593          	mv	a1,s0
   14c14:	000a8513          	mv	a0,s5
   14c18:	af4ff0ef          	jal	ra,13f0c <ecmpm>
   14c1c:	00000993          	li	s3,0
   14c20:	00a04a63          	bgtz	a0,14c34 <eiremain+0xc0>
   14c24:	00040593          	mv	a1,s0
   14c28:	000a8513          	mv	a0,s5
   14c2c:	c9cff0ef          	jal	ra,140c8 <esubm>
   14c30:	00100993          	li	s3,1
   14c34:	000b0513          	mv	a0,s6
   14c38:	b60ff0ef          	jal	ra,13f98 <eshup1>
   14c3c:	04c95783          	lhu	a5,76(s2)
   14c40:	00040513          	mv	a0,s0
   14c44:	fff48493          	addi	s1,s1,-1
   14c48:	00f9e9b3          	or	s3,s3,a5
   14c4c:	05391623          	sh	s3,76(s2)
   14c50:	b48ff0ef          	jal	ra,13f98 <eshup1>
   14c54:	f79ff06f          	j	14bcc <eiremain+0x58>

00014c58 <emul>:
   14c58:	f7010113          	addi	sp,sp,-144
   14c5c:	08812423          	sw	s0,136(sp)
   14c60:	08912223          	sw	s1,132(sp)
   14c64:	09212023          	sw	s2,128(sp)
   14c68:	07312e23          	sw	s3,124(sp)
   14c6c:	08112623          	sw	ra,140(sp)
   14c70:	07412c23          	sw	s4,120(sp)
   14c74:	07512a23          	sw	s5,116(sp)
   14c78:	07612823          	sw	s6,112(sp)
   14c7c:	07712623          	sw	s7,108(sp)
   14c80:	07812423          	sw	s8,104(sp)
   14c84:	07912223          	sw	s9,100(sp)
   14c88:	00050493          	mv	s1,a0
   14c8c:	00058413          	mv	s0,a1
   14c90:	00060913          	mv	s2,a2
   14c94:	00068993          	mv	s3,a3
   14c98:	d44ff0ef          	jal	ra,141dc <eisnan>
   14c9c:	04050263          	beqz	a0,14ce0 <emul+0x88>
   14ca0:	00090593          	mv	a1,s2
   14ca4:	00048513          	mv	a0,s1
   14ca8:	a10ff0ef          	jal	ra,13eb8 <emov>
   14cac:	08c12083          	lw	ra,140(sp)
   14cb0:	08812403          	lw	s0,136(sp)
   14cb4:	08412483          	lw	s1,132(sp)
   14cb8:	08012903          	lw	s2,128(sp)
   14cbc:	07c12983          	lw	s3,124(sp)
   14cc0:	07812a03          	lw	s4,120(sp)
   14cc4:	07412a83          	lw	s5,116(sp)
   14cc8:	07012b03          	lw	s6,112(sp)
   14ccc:	06c12b83          	lw	s7,108(sp)
   14cd0:	06812c03          	lw	s8,104(sp)
   14cd4:	06412c83          	lw	s9,100(sp)
   14cd8:	09010113          	addi	sp,sp,144
   14cdc:	00008067          	ret
   14ce0:	00040513          	mv	a0,s0
   14ce4:	cf8ff0ef          	jal	ra,141dc <eisnan>
   14ce8:	00050863          	beqz	a0,14cf8 <emul+0xa0>
   14cec:	00090593          	mv	a1,s2
   14cf0:	00040513          	mv	a0,s0
   14cf4:	fb5ff06f          	j	14ca8 <emul+0x50>
   14cf8:	00048513          	mv	a0,s1
   14cfc:	f24ff0ef          	jal	ra,14420 <eisinf>
   14d00:	06051463          	bnez	a0,14d68 <emul+0x110>
   14d04:	00040513          	mv	a0,s0
   14d08:	f18ff0ef          	jal	ra,14420 <eisinf>
   14d0c:	00050c63          	beqz	a0,14d24 <emul+0xcc>
   14d10:	000225b7          	lui	a1,0x22
   14d14:	93c58593          	addi	a1,a1,-1732 # 2193c <ezero>
   14d18:	00048513          	mv	a0,s1
   14d1c:	dfcff0ef          	jal	ra,14318 <ecmp>
   14d20:	04050e63          	beqz	a0,14d7c <emul+0x124>
   14d24:	00048513          	mv	a0,s1
   14d28:	ef8ff0ef          	jal	ra,14420 <eisinf>
   14d2c:	00051863          	bnez	a0,14d3c <emul+0xe4>
   14d30:	00040513          	mv	a0,s0
   14d34:	eecff0ef          	jal	ra,14420 <eisinf>
   14d38:	04050c63          	beqz	a0,14d90 <emul+0x138>
   14d3c:	00048513          	mv	a0,s1
   14d40:	cd0ff0ef          	jal	ra,14210 <eisneg>
   14d44:	00050493          	mv	s1,a0
   14d48:	00040513          	mv	a0,s0
   14d4c:	cc4ff0ef          	jal	ra,14210 <eisneg>
   14d50:	02a48c63          	beq	s1,a0,14d88 <emul+0x130>
   14d54:	ffff87b7          	lui	a5,0xffff8
   14d58:	00f91923          	sh	a5,18(s2)
   14d5c:	00090513          	mv	a0,s2
   14d60:	ef4ff0ef          	jal	ra,14454 <einfin.isra.2>
   14d64:	f49ff06f          	j	14cac <emul+0x54>
   14d68:	000225b7          	lui	a1,0x22
   14d6c:	93c58593          	addi	a1,a1,-1732 # 2193c <ezero>
   14d70:	00040513          	mv	a0,s0
   14d74:	da4ff0ef          	jal	ra,14318 <ecmp>
   14d78:	f80516e3          	bnez	a0,14d04 <emul+0xac>
   14d7c:	00090513          	mv	a0,s2
   14d80:	92dff0ef          	jal	ra,146ac <enan.constprop.12>
   14d84:	f29ff06f          	j	14cac <emul+0x54>
   14d88:	00091923          	sh	zero,18(s2)
   14d8c:	fd1ff06f          	j	14d5c <emul+0x104>
   14d90:	00048513          	mv	a0,s1
   14d94:	00c10593          	addi	a1,sp,12
   14d98:	cb0ff0ef          	jal	ra,14248 <emovi>
   14d9c:	00040513          	mv	a0,s0
   14da0:	02810593          	addi	a1,sp,40
   14da4:	ca4ff0ef          	jal	ra,14248 <emovi>
   14da8:	00e15403          	lhu	s0,14(sp)
   14dac:	02a15483          	lhu	s1,42(sp)
   14db0:	02041463          	bnez	s0,14dd8 <emul+0x180>
   14db4:	00000793          	li	a5,0
   14db8:	01600713          	li	a4,22
   14dbc:	00c10693          	addi	a3,sp,12
   14dc0:	00f686b3          	add	a3,a3,a5
   14dc4:	0026d683          	lhu	a3,2(a3)
   14dc8:	10068a63          	beqz	a3,14edc <emul+0x284>
   14dcc:	00c10513          	addi	a0,sp,12
   14dd0:	805ff0ef          	jal	ra,145d4 <enormlz>
   14dd4:	40a00433          	neg	s0,a0
   14dd8:	02a15783          	lhu	a5,42(sp)
   14ddc:	00048c13          	mv	s8,s1
   14de0:	02079263          	bnez	a5,14e04 <emul+0x1ac>
   14de4:	01600713          	li	a4,22
   14de8:	02810693          	addi	a3,sp,40
   14dec:	00f686b3          	add	a3,a3,a5
   14df0:	0026d683          	lhu	a3,2(a3)
   14df4:	0e068e63          	beqz	a3,14ef0 <emul+0x298>
   14df8:	02810513          	addi	a0,sp,40
   14dfc:	fd8ff0ef          	jal	ra,145d4 <enormlz>
   14e00:	40a48c33          	sub	s8,s1,a0
   14e04:	02815783          	lhu	a5,40(sp)
   14e08:	03498b93          	addi	s7,s3,52
   14e0c:	03898493          	addi	s1,s3,56
   14e10:	02f99a23          	sh	a5,52(s3)
   14e14:	02a15783          	lhu	a5,42(sp)
   14e18:	000b8a13          	mv	s4,s7
   14e1c:	02f99b23          	sh	a5,54(s3)
   14e20:	04e98793          	addi	a5,s3,78
   14e24:	00049023          	sh	zero,0(s1)
   14e28:	00248493          	addi	s1,s1,2
   14e2c:	fe979ce3          	bne	a5,s1,14e24 <emul+0x1cc>
   14e30:	00000a93          	li	s5,0
   14e34:	00000b13          	li	s6,0
   14e38:	fec00c93          	li	s9,-20
   14e3c:	00c10793          	addi	a5,sp,12
   14e40:	015787b3          	add	a5,a5,s5
   14e44:	0187d503          	lhu	a0,24(a5) # ffff8018 <__global_pointer$+0xfffd38b8>
   14e48:	00050e63          	beqz	a0,14e64 <emul+0x20c>
   14e4c:	02810593          	addi	a1,sp,40
   14e50:	04410613          	addi	a2,sp,68
   14e54:	aacff0ef          	jal	ra,14100 <m16m>
   14e58:	000b8593          	mv	a1,s7
   14e5c:	04410513          	addi	a0,sp,68
   14e60:	a30ff0ef          	jal	ra,14090 <eaddm>
   14e64:	04c9d783          	lhu	a5,76(s3)
   14e68:	000b8513          	mv	a0,s7
   14e6c:	ffea8a93          	addi	s5,s5,-2 # 7ffffffe <__global_pointer$+0x7ffdb89e>
   14e70:	00fb6b33          	or	s6,s6,a5
   14e74:	9f4ff0ef          	jal	ra,14068 <eshdn6>
   14e78:	fd9a92e3          	bne	s5,s9,14e3c <emul+0x1e4>
   14e7c:	02810793          	addi	a5,sp,40
   14e80:	000a5703          	lhu	a4,0(s4)
   14e84:	002a0a13          	addi	s4,s4,2
   14e88:	00278793          	addi	a5,a5,2
   14e8c:	fee79f23          	sh	a4,-2(a5)
   14e90:	fe9a18e3          	bne	s4,s1,14e80 <emul+0x228>
   14e94:	ffffc6b7          	lui	a3,0xffffc
   14e98:	01840433          	add	s0,s0,s8
   14e9c:	00268693          	addi	a3,a3,2 # ffffc002 <__global_pointer$+0xfffd78a2>
   14ea0:	00098793          	mv	a5,s3
   14ea4:	04000713          	li	a4,64
   14ea8:	00d406b3          	add	a3,s0,a3
   14eac:	00000613          	li	a2,0
   14eb0:	000b0593          	mv	a1,s6
   14eb4:	02810513          	addi	a0,sp,40
   14eb8:	995ff0ef          	jal	ra,1484c <emdnorm>
   14ebc:	00c15703          	lhu	a4,12(sp)
   14ec0:	02815783          	lhu	a5,40(sp)
   14ec4:	02f71c63          	bne	a4,a5,14efc <emul+0x2a4>
   14ec8:	02011423          	sh	zero,40(sp)
   14ecc:	00090593          	mv	a1,s2
   14ed0:	02810513          	addi	a0,sp,40
   14ed4:	801ff0ef          	jal	ra,146d4 <emovo.isra.6>
   14ed8:	dd5ff06f          	j	14cac <emul+0x54>
   14edc:	00278793          	addi	a5,a5,2
   14ee0:	ece79ee3          	bne	a5,a4,14dbc <emul+0x164>
   14ee4:	00090513          	mv	a0,s2
   14ee8:	fbdfe0ef          	jal	ra,13ea4 <eclear>
   14eec:	dc1ff06f          	j	14cac <emul+0x54>
   14ef0:	00278793          	addi	a5,a5,2
   14ef4:	eee79ae3          	bne	a5,a4,14de8 <emul+0x190>
   14ef8:	fedff06f          	j	14ee4 <emul+0x28c>
   14efc:	fff00793          	li	a5,-1
   14f00:	02f11423          	sh	a5,40(sp)
   14f04:	fc9ff06f          	j	14ecc <emul+0x274>

00014f08 <ediv>:
   14f08:	f7010113          	addi	sp,sp,-144
   14f0c:	08812423          	sw	s0,136(sp)
   14f10:	08912223          	sw	s1,132(sp)
   14f14:	09212023          	sw	s2,128(sp)
   14f18:	07512a23          	sw	s5,116(sp)
   14f1c:	08112623          	sw	ra,140(sp)
   14f20:	07312e23          	sw	s3,124(sp)
   14f24:	07412c23          	sw	s4,120(sp)
   14f28:	07612823          	sw	s6,112(sp)
   14f2c:	07712623          	sw	s7,108(sp)
   14f30:	07812423          	sw	s8,104(sp)
   14f34:	07912223          	sw	s9,100(sp)
   14f38:	07a12023          	sw	s10,96(sp)
   14f3c:	00050493          	mv	s1,a0
   14f40:	00058413          	mv	s0,a1
   14f44:	00060913          	mv	s2,a2
   14f48:	00068a93          	mv	s5,a3
   14f4c:	a90ff0ef          	jal	ra,141dc <eisnan>
   14f50:	04050463          	beqz	a0,14f98 <ediv+0x90>
   14f54:	00090593          	mv	a1,s2
   14f58:	00048513          	mv	a0,s1
   14f5c:	f5dfe0ef          	jal	ra,13eb8 <emov>
   14f60:	08c12083          	lw	ra,140(sp)
   14f64:	08812403          	lw	s0,136(sp)
   14f68:	08412483          	lw	s1,132(sp)
   14f6c:	08012903          	lw	s2,128(sp)
   14f70:	07c12983          	lw	s3,124(sp)
   14f74:	07812a03          	lw	s4,120(sp)
   14f78:	07412a83          	lw	s5,116(sp)
   14f7c:	07012b03          	lw	s6,112(sp)
   14f80:	06c12b83          	lw	s7,108(sp)
   14f84:	06812c03          	lw	s8,104(sp)
   14f88:	06412c83          	lw	s9,100(sp)
   14f8c:	06012d03          	lw	s10,96(sp)
   14f90:	09010113          	addi	sp,sp,144
   14f94:	00008067          	ret
   14f98:	00040513          	mv	a0,s0
   14f9c:	a40ff0ef          	jal	ra,141dc <eisnan>
   14fa0:	00050863          	beqz	a0,14fb0 <ediv+0xa8>
   14fa4:	00090593          	mv	a1,s2
   14fa8:	00040513          	mv	a0,s0
   14fac:	fb1ff06f          	j	14f5c <ediv+0x54>
   14fb0:	000229b7          	lui	s3,0x22
   14fb4:	93c98593          	addi	a1,s3,-1732 # 2193c <ezero>
   14fb8:	00048513          	mv	a0,s1
   14fbc:	b5cff0ef          	jal	ra,14318 <ecmp>
   14fc0:	1e050e63          	beqz	a0,151bc <ediv+0x2b4>
   14fc4:	00048513          	mv	a0,s1
   14fc8:	c58ff0ef          	jal	ra,14420 <eisinf>
   14fcc:	00050993          	mv	s3,a0
   14fd0:	00040513          	mv	a0,s0
   14fd4:	c4cff0ef          	jal	ra,14420 <eisinf>
   14fd8:	20099063          	bnez	s3,151d8 <ediv+0x2d0>
   14fdc:	20051663          	bnez	a0,151e8 <ediv+0x2e0>
   14fe0:	00048513          	mv	a0,s1
   14fe4:	00c10593          	addi	a1,sp,12
   14fe8:	a60ff0ef          	jal	ra,14248 <emovi>
   14fec:	00040513          	mv	a0,s0
   14ff0:	02810593          	addi	a1,sp,40
   14ff4:	a54ff0ef          	jal	ra,14248 <emovi>
   14ff8:	02a15483          	lhu	s1,42(sp)
   14ffc:	00e15403          	lhu	s0,14(sp)
   15000:	02049463          	bnez	s1,15028 <ediv+0x120>
   15004:	00000793          	li	a5,0
   15008:	01600713          	li	a4,22
   1500c:	02810693          	addi	a3,sp,40
   15010:	00f686b3          	add	a3,a3,a5
   15014:	0026d683          	lhu	a3,2(a3)
   15018:	1e068e63          	beqz	a3,15214 <ediv+0x30c>
   1501c:	02810513          	addi	a0,sp,40
   15020:	db4ff0ef          	jal	ra,145d4 <enormlz>
   15024:	40a004b3          	neg	s1,a0
   15028:	00e15783          	lhu	a5,14(sp)
   1502c:	00040b93          	mv	s7,s0
   15030:	02079263          	bnez	a5,15054 <ediv+0x14c>
   15034:	01600713          	li	a4,22
   15038:	00c10693          	addi	a3,sp,12
   1503c:	00f686b3          	add	a3,a3,a5
   15040:	0026d683          	lhu	a3,2(a3)
   15044:	1c068e63          	beqz	a3,15220 <ediv+0x318>
   15048:	00c10513          	addi	a0,sp,12
   1504c:	d88ff0ef          	jal	ra,145d4 <enormlz>
   15050:	40a40bb3          	sub	s7,s0,a0
   15054:	02815783          	lhu	a5,40(sp)
   15058:	02a15703          	lhu	a4,42(sp)
   1505c:	034a8993          	addi	s3,s5,52
   15060:	02fa9a23          	sh	a5,52(s5)
   15064:	038a8793          	addi	a5,s5,56
   15068:	02ea9b23          	sh	a4,54(s5)
   1506c:	00078a13          	mv	s4,a5
   15070:	04ea8713          	addi	a4,s5,78
   15074:	00278793          	addi	a5,a5,2
   15078:	fe079f23          	sh	zero,-2(a5)
   1507c:	fee79ce3          	bne	a5,a4,15074 <ediv+0x16c>
   15080:	02810513          	addi	a0,sp,40
   15084:	ec5fe0ef          	jal	ra,13f48 <eshdn1>
   15088:	01215c03          	lhu	s8,18(sp)
   1508c:	00010b37          	lui	s6,0x10
   15090:	fffb0593          	addi	a1,s6,-1 # ffff <main-0x75>
   15094:	000c0513          	mv	a0,s8
   15098:	5140c0ef          	jal	ra,215ac <__mulsi3>
   1509c:	00050d13          	mv	s10,a0
   150a0:	01a98c93          	addi	s9,s3,26
   150a4:	fffb0b13          	addi	s6,s6,-1
   150a8:	02c15503          	lhu	a0,44(sp)
   150ac:	02e15783          	lhu	a5,46(sp)
   150b0:	000b0413          	mv	s0,s6
   150b4:	01051513          	slli	a0,a0,0x10
   150b8:	00f50533          	add	a0,a0,a5
   150bc:	00ad6a63          	bltu	s10,a0,150d0 <ediv+0x1c8>
   150c0:	000c0593          	mv	a1,s8
   150c4:	5140c0ef          	jal	ra,215d8 <__udivsi3>
   150c8:	01051413          	slli	s0,a0,0x10
   150cc:	01045413          	srli	s0,s0,0x10
   150d0:	00c10593          	addi	a1,sp,12
   150d4:	00040513          	mv	a0,s0
   150d8:	04410613          	addi	a2,sp,68
   150dc:	824ff0ef          	jal	ra,14100 <m16m>
   150e0:	02810593          	addi	a1,sp,40
   150e4:	04410513          	addi	a0,sp,68
   150e8:	e25fe0ef          	jal	ra,13f0c <ecmpm>
   150ec:	02a05663          	blez	a0,15118 <ediv+0x210>
   150f0:	04410593          	addi	a1,sp,68
   150f4:	00c10513          	addi	a0,sp,12
   150f8:	fd1fe0ef          	jal	ra,140c8 <esubm>
   150fc:	02810593          	addi	a1,sp,40
   15100:	04410513          	addi	a0,sp,68
   15104:	e09fe0ef          	jal	ra,13f0c <ecmpm>
   15108:	12a04a63          	bgtz	a0,1523c <ediv+0x334>
   1510c:	fff40413          	addi	s0,s0,-1
   15110:	01041413          	slli	s0,s0,0x10
   15114:	01045413          	srli	s0,s0,0x10
   15118:	02810593          	addi	a1,sp,40
   1511c:	04410513          	addi	a0,sp,68
   15120:	fa9fe0ef          	jal	ra,140c8 <esubm>
   15124:	02810513          	addi	a0,sp,40
   15128:	008a1023          	sh	s0,0(s4)
   1512c:	002a0a13          	addi	s4,s4,2
   15130:	f19fe0ef          	jal	ra,14048 <eshup6>
   15134:	f79a1ae3          	bne	s4,s9,150a8 <ediv+0x1a0>
   15138:	00000793          	li	a5,0
   1513c:	00000593          	li	a1,0
   15140:	01600713          	li	a4,22
   15144:	02810693          	addi	a3,sp,40
   15148:	00f686b3          	add	a3,a3,a5
   1514c:	0046d683          	lhu	a3,4(a3)
   15150:	00278793          	addi	a5,a5,2
   15154:	00d5e5b3          	or	a1,a1,a3
   15158:	fee796e3          	bne	a5,a4,15144 <ediv+0x23c>
   1515c:	00b035b3          	snez	a1,a1
   15160:	02810793          	addi	a5,sp,40
   15164:	0009d703          	lhu	a4,0(s3)
   15168:	00298993          	addi	s3,s3,2
   1516c:	00278793          	addi	a5,a5,2
   15170:	fee79f23          	sh	a4,-2(a5)
   15174:	ff3a18e3          	bne	s4,s3,15164 <ediv+0x25c>
   15178:	000046b7          	lui	a3,0x4
   1517c:	417484b3          	sub	s1,s1,s7
   15180:	fff68693          	addi	a3,a3,-1 # 3fff <main-0xc075>
   15184:	000a8793          	mv	a5,s5
   15188:	04000713          	li	a4,64
   1518c:	00d486b3          	add	a3,s1,a3
   15190:	00000613          	li	a2,0
   15194:	02810513          	addi	a0,sp,40
   15198:	eb4ff0ef          	jal	ra,1484c <emdnorm>
   1519c:	00c15703          	lhu	a4,12(sp)
   151a0:	02815783          	lhu	a5,40(sp)
   151a4:	0af71a63          	bne	a4,a5,15258 <ediv+0x350>
   151a8:	02011423          	sh	zero,40(sp)
   151ac:	00090593          	mv	a1,s2
   151b0:	02810513          	addi	a0,sp,40
   151b4:	d20ff0ef          	jal	ra,146d4 <emovo.isra.6>
   151b8:	da9ff06f          	j	14f60 <ediv+0x58>
   151bc:	93c98593          	addi	a1,s3,-1732
   151c0:	00040513          	mv	a0,s0
   151c4:	954ff0ef          	jal	ra,14318 <ecmp>
   151c8:	de051ee3          	bnez	a0,14fc4 <ediv+0xbc>
   151cc:	00090513          	mv	a0,s2
   151d0:	cdcff0ef          	jal	ra,146ac <enan.constprop.12>
   151d4:	d8dff06f          	j	14f60 <ediv+0x58>
   151d8:	fe051ae3          	bnez	a0,151cc <ediv+0x2c4>
   151dc:	00090513          	mv	a0,s2
   151e0:	cc5fe0ef          	jal	ra,13ea4 <eclear>
   151e4:	d7dff06f          	j	14f60 <ediv+0x58>
   151e8:	00048513          	mv	a0,s1
   151ec:	824ff0ef          	jal	ra,14210 <eisneg>
   151f0:	00050493          	mv	s1,a0
   151f4:	00040513          	mv	a0,s0
   151f8:	818ff0ef          	jal	ra,14210 <eisneg>
   151fc:	02a48c63          	beq	s1,a0,15234 <ediv+0x32c>
   15200:	ffff87b7          	lui	a5,0xffff8
   15204:	00f91923          	sh	a5,18(s2)
   15208:	00090513          	mv	a0,s2
   1520c:	a48ff0ef          	jal	ra,14454 <einfin.isra.2>
   15210:	d51ff06f          	j	14f60 <ediv+0x58>
   15214:	00278793          	addi	a5,a5,2 # ffff8002 <__global_pointer$+0xfffd38a2>
   15218:	dee79ae3          	bne	a5,a4,1500c <ediv+0x104>
   1521c:	fc1ff06f          	j	151dc <ediv+0x2d4>
   15220:	00278793          	addi	a5,a5,2
   15224:	e0e79ae3          	bne	a5,a4,15038 <ediv+0x130>
   15228:	00c15703          	lhu	a4,12(sp)
   1522c:	02815783          	lhu	a5,40(sp)
   15230:	fcf718e3          	bne	a4,a5,15200 <ediv+0x2f8>
   15234:	00091923          	sh	zero,18(s2)
   15238:	fd1ff06f          	j	15208 <ediv+0x300>
   1523c:	ffe40413          	addi	s0,s0,-2
   15240:	01041413          	slli	s0,s0,0x10
   15244:	04410593          	addi	a1,sp,68
   15248:	00c10513          	addi	a0,sp,12
   1524c:	01045413          	srli	s0,s0,0x10
   15250:	e79fe0ef          	jal	ra,140c8 <esubm>
   15254:	ec5ff06f          	j	15118 <ediv+0x210>
   15258:	fff00793          	li	a5,-1
   1525c:	02f11423          	sh	a5,40(sp)
   15260:	f4dff06f          	j	151ac <ediv+0x2a4>

00015264 <_ldtoa_r>:
   15264:	0005ae03          	lw	t3,0(a1)
   15268:	0045a303          	lw	t1,4(a1)
   1526c:	0085a883          	lw	a7,8(a1)
   15270:	00c5a583          	lw	a1,12(a1)
   15274:	e2010113          	addi	sp,sp,-480
   15278:	1c812c23          	sw	s0,472(sp)
   1527c:	02b12623          	sw	a1,44(sp)
   15280:	00078413          	mv	s0,a5
   15284:	04052583          	lw	a1,64(a0)
   15288:	fff00793          	li	a5,-1
   1528c:	14f12823          	sw	a5,336(sp)
   15290:	09000793          	li	a5,144
   15294:	1d412423          	sw	s4,456(sp)
   15298:	1d512223          	sw	s5,452(sp)
   1529c:	1b712e23          	sw	s7,444(sp)
   152a0:	1b912a23          	sw	s9,436(sp)
   152a4:	1c112e23          	sw	ra,476(sp)
   152a8:	1c912a23          	sw	s1,468(sp)
   152ac:	1d212823          	sw	s2,464(sp)
   152b0:	1d312623          	sw	s3,460(sp)
   152b4:	1d612023          	sw	s6,448(sp)
   152b8:	1b812c23          	sw	s8,440(sp)
   152bc:	1ba12823          	sw	s10,432(sp)
   152c0:	1bb12623          	sw	s11,428(sp)
   152c4:	01012623          	sw	a6,12(sp)
   152c8:	03c12023          	sw	t3,32(sp)
   152cc:	02612223          	sw	t1,36(sp)
   152d0:	03112423          	sw	a7,40(sp)
   152d4:	14f12a23          	sw	a5,340(sp)
   152d8:	00050a13          	mv	s4,a0
   152dc:	00060b93          	mv	s7,a2
   152e0:	00068a93          	mv	s5,a3
   152e4:	00070c93          	mv	s9,a4
   152e8:	02058063          	beqz	a1,15308 <_ldtoa_r+0xa4>
   152ec:	04452783          	lw	a5,68(a0)
   152f0:	00100713          	li	a4,1
   152f4:	00f71733          	sll	a4,a4,a5
   152f8:	00f5a223          	sw	a5,4(a1)
   152fc:	00e5a423          	sw	a4,8(a1)
   15300:	12c010ef          	jal	ra,1642c <_Bfree>
   15304:	040a2023          	sw	zero,64(s4)
   15308:	02010513          	addi	a0,sp,32
   1530c:	05010593          	addi	a1,sp,80
   15310:	c34ff0ef          	jal	ra,14744 <e113toe.isra.8>
   15314:	05010513          	addi	a0,sp,80
   15318:	ef9fe0ef          	jal	ra,14210 <eisneg>
   1531c:	18050e63          	beqz	a0,154b8 <_ldtoa_r+0x254>
   15320:	00100793          	li	a5,1
   15324:	00f42023          	sw	a5,0(s0)
   15328:	00300793          	li	a5,3
   1532c:	18fb8a63          	beq	s7,a5,154c0 <_ldtoa_r+0x25c>
   15330:	01400913          	li	s2,20
   15334:	000b8a63          	beqz	s7,15348 <_ldtoa_r+0xe4>
   15338:	fffa8913          	addi	s2,s5,-1
   1533c:	02a00793          	li	a5,42
   15340:	0127d463          	ble	s2,a5,15348 <_ldtoa_r+0xe4>
   15344:	02a00913          	li	s2,42
   15348:	15412783          	lw	a5,340(sp)
   1534c:	05010513          	addi	a0,sp,80
   15350:	00f12823          	sw	a5,16(sp)
   15354:	e89fe0ef          	jal	ra,141dc <eisnan>
   15358:	00050413          	mv	s0,a0
   1535c:	16050663          	beqz	a0,154c8 <_ldtoa_r+0x264>
   15360:	000225b7          	lui	a1,0x22
   15364:	b9058593          	addi	a1,a1,-1136 # 21b90 <emtens+0x104>
   15368:	11410513          	addi	a0,sp,276
   1536c:	00002437          	lui	s0,0x2
   15370:	720020ef          	jal	ra,17a90 <sprintf>
   15374:	70f40413          	addi	s0,s0,1807 # 270f <main-0xd965>
   15378:	01012783          	lw	a5,16(sp)
   1537c:	05010513          	addi	a0,sp,80
   15380:	16812023          	sw	s0,352(sp)
   15384:	14f12a23          	sw	a5,340(sp)
   15388:	898ff0ef          	jal	ra,14420 <eisinf>
   1538c:	11410993          	addi	s3,sp,276
   15390:	00051863          	bnez	a0,153a0 <_ldtoa_r+0x13c>
   15394:	05010513          	addi	a0,sp,80
   15398:	e45fe0ef          	jal	ra,141dc <eisnan>
   1539c:	240508e3          	beqz	a0,15dec <_ldtoa_r+0xb88>
   153a0:	000027b7          	lui	a5,0x2
   153a4:	70f78793          	addi	a5,a5,1807 # 270f <main-0xd965>
   153a8:	00fca023          	sw	a5,0(s9)
   153ac:	00098793          	mv	a5,s3
   153b0:	02000613          	li	a2,32
   153b4:	02d00693          	li	a3,45
   153b8:	0007c703          	lbu	a4,0(a5)
   153bc:	28c706e3          	beq	a4,a2,15e48 <_ldtoa_r+0xbe4>
   153c0:	28d704e3          	beq	a4,a3,15e48 <_ldtoa_r+0xbe4>
   153c4:	00098413          	mv	s0,s3
   153c8:	00178793          	addi	a5,a5,1
   153cc:	fff7c703          	lbu	a4,-1(a5)
   153d0:	00140693          	addi	a3,s0,1
   153d4:	fee68fa3          	sb	a4,-1(a3)
   153d8:	26071ce3          	bnez	a4,15e50 <_ldtoa_r+0xbec>
   153dc:	00200713          	li	a4,2
   153e0:	00100793          	li	a5,1
   153e4:	00eb8863          	beq	s7,a4,153f4 <_ldtoa_r+0x190>
   153e8:	16012783          	lw	a5,352(sp)
   153ec:	0127d463          	ble	s2,a5,153f4 <_ldtoa_r+0x190>
   153f0:	00090793          	mv	a5,s2
   153f4:	03000693          	li	a3,48
   153f8:	fff44703          	lbu	a4,-1(s0)
   153fc:	00d71663          	bne	a4,a3,15408 <_ldtoa_r+0x1a4>
   15400:	41340733          	sub	a4,s0,s3
   15404:	24e7cae3          	blt	a5,a4,15e58 <_ldtoa_r+0xbf4>
   15408:	00300793          	li	a5,3
   1540c:	009a8713          	addi	a4,s5,9
   15410:	02fb9463          	bne	s7,a5,15438 <_ldtoa_r+0x1d4>
   15414:	16012783          	lw	a5,352(sp)
   15418:	00f90933          	add	s2,s2,a5
   1541c:	00095863          	bgez	s2,1542c <_ldtoa_r+0x1c8>
   15420:	10010a23          	sb	zero,276(sp)
   15424:	000ca023          	sw	zero,0(s9)
   15428:	00098413          	mv	s0,s3
   1542c:	000ca783          	lw	a5,0(s9)
   15430:	00fa8ab3          	add	s5,s5,a5
   15434:	003a8713          	addi	a4,s5,3
   15438:	040a2223          	sw	zero,68(s4)
   1543c:	00400793          	li	a5,4
   15440:	01478693          	addi	a3,a5,20
   15444:	044a2583          	lw	a1,68(s4)
   15448:	20d77ee3          	bleu	a3,a4,15e64 <_ldtoa_r+0xc00>
   1544c:	000a0513          	mv	a0,s4
   15450:	735000ef          	jal	ra,16384 <_Balloc>
   15454:	04aa2023          	sw	a0,64(s4)
   15458:	00098593          	mv	a1,s3
   1545c:	00050493          	mv	s1,a0
   15460:	159020ef          	jal	ra,17db8 <strcpy>
   15464:	00c12783          	lw	a5,12(sp)
   15468:	00078863          	beqz	a5,15478 <_ldtoa_r+0x214>
   1546c:	41340433          	sub	s0,s0,s3
   15470:	00848433          	add	s0,s1,s0
   15474:	0087a023          	sw	s0,0(a5)
   15478:	1dc12083          	lw	ra,476(sp)
   1547c:	1d812403          	lw	s0,472(sp)
   15480:	00048513          	mv	a0,s1
   15484:	1d012903          	lw	s2,464(sp)
   15488:	1d412483          	lw	s1,468(sp)
   1548c:	1cc12983          	lw	s3,460(sp)
   15490:	1c812a03          	lw	s4,456(sp)
   15494:	1c412a83          	lw	s5,452(sp)
   15498:	1c012b03          	lw	s6,448(sp)
   1549c:	1bc12b83          	lw	s7,444(sp)
   154a0:	1b812c03          	lw	s8,440(sp)
   154a4:	1b412c83          	lw	s9,436(sp)
   154a8:	1b012d03          	lw	s10,432(sp)
   154ac:	1ac12d83          	lw	s11,428(sp)
   154b0:	1e010113          	addi	sp,sp,480
   154b4:	00008067          	ret
   154b8:	00042023          	sw	zero,0(s0)
   154bc:	e6dff06f          	j	15328 <_ldtoa_r+0xc4>
   154c0:	000a8913          	mv	s2,s5
   154c4:	e79ff06f          	j	1533c <_ldtoa_r+0xd8>
   154c8:	09000793          	li	a5,144
   154cc:	06c10593          	addi	a1,sp,108
   154d0:	05010513          	addi	a0,sp,80
   154d4:	14f12a23          	sw	a5,340(sp)
   154d8:	9e1fe0ef          	jal	ra,13eb8 <emov>
   154dc:	07e15783          	lhu	a5,126(sp)
   154e0:	00012223          	sw	zero,4(sp)
   154e4:	01079713          	slli	a4,a5,0x10
   154e8:	41075713          	srai	a4,a4,0x10
   154ec:	02075063          	bgez	a4,1550c <_ldtoa_r+0x2a8>
   154f0:	00008737          	lui	a4,0x8
   154f4:	fff70713          	addi	a4,a4,-1 # 7fff <main-0x8075>
   154f8:	00e7f7b3          	and	a5,a5,a4
   154fc:	06f11f23          	sh	a5,126(sp)
   15500:	000107b7          	lui	a5,0x10
   15504:	fff78793          	addi	a5,a5,-1 # ffff <main-0x75>
   15508:	00f12223          	sw	a5,4(sp)
   1550c:	00022b37          	lui	s6,0x22
   15510:	93cb0513          	addi	a0,s6,-1732 # 2193c <ezero>
   15514:	08810593          	addi	a1,sp,136
   15518:	01450513          	addi	a0,a0,20
   1551c:	99dfe0ef          	jal	ra,13eb8 <emov>
   15520:	07e15703          	lhu	a4,126(sp)
   15524:	000224b7          	lui	s1,0x22
   15528:	93cb0993          	addi	s3,s6,-1732
   1552c:	95048493          	addi	s1,s1,-1712 # 21950 <eone>
   15530:	140712e3          	bnez	a4,15e74 <_ldtoa_r+0xc10>
   15534:	06c10713          	addi	a4,sp,108
   15538:	00000793          	li	a5,0
   1553c:	00900693          	li	a3,9
   15540:	00075603          	lhu	a2,0(a4)
   15544:	10061063          	bnez	a2,15644 <_ldtoa_r+0x3e0>
   15548:	00178793          	addi	a5,a5,1
   1554c:	00270713          	addi	a4,a4,2
   15550:	fed798e3          	bne	a5,a3,15540 <_ldtoa_r+0x2dc>
   15554:	0c010593          	addi	a1,sp,192
   15558:	08810513          	addi	a0,sp,136
   1555c:	cedfe0ef          	jal	ra,14248 <emovi>
   15560:	08810593          	addi	a1,sp,136
   15564:	0c010513          	addi	a0,sp,192
   15568:	981fe0ef          	jal	ra,13ee8 <emovz>
   1556c:	0c010593          	addi	a1,sp,192
   15570:	06c10513          	addi	a0,sp,108
   15574:	cd5fe0ef          	jal	ra,14248 <emovi>
   15578:	06c10593          	addi	a1,sp,108
   1557c:	0c010513          	addi	a0,sp,192
   15580:	969fe0ef          	jal	ra,13ee8 <emovz>
   15584:	15010613          	addi	a2,sp,336
   15588:	06c10593          	addi	a1,sp,108
   1558c:	08810513          	addi	a0,sp,136
   15590:	de4ff0ef          	jal	ra,14b74 <eiremain>
   15594:	19c15483          	lhu	s1,412(sp)
   15598:	00049a63          	bnez	s1,155ac <_ldtoa_r+0x348>
   1559c:	93cb0593          	addi	a1,s6,-1732
   155a0:	06c10513          	addi	a0,sp,108
   155a4:	d75fe0ef          	jal	ra,14318 <ecmp>
   155a8:	6a051863          	bnez	a0,15c58 <_ldtoa_r+0x9f4>
   155ac:	00412783          	lw	a5,4(sp)
   155b0:	6e078a63          	beqz	a5,15ca4 <_ldtoa_r+0xa40>
   155b4:	02d00793          	li	a5,45
   155b8:	10f10a23          	sb	a5,276(sp)
   155bc:	00300793          	li	a5,3
   155c0:	00090993          	mv	s3,s2
   155c4:	00fb9863          	bne	s7,a5,155d4 <_ldtoa_r+0x370>
   155c8:	008909b3          	add	s3,s2,s0
   155cc:	02a00793          	li	a5,42
   155d0:	0d37c2e3          	blt	a5,s3,15e94 <_ldtoa_r+0xc30>
   155d4:	00a00793          	li	a5,10
   155d8:	6cf49a63          	bne	s1,a5,15cac <_ldtoa_r+0xa48>
   155dc:	03100793          	li	a5,49
   155e0:	10f10aa3          	sb	a5,277(sp)
   155e4:	02e00793          	li	a5,46
   155e8:	10f10b23          	sb	a5,278(sp)
   155ec:	11710c13          	addi	s8,sp,279
   155f0:	01305a63          	blez	s3,15604 <_ldtoa_r+0x3a0>
   155f4:	03000793          	li	a5,48
   155f8:	10f10ba3          	sb	a5,279(sp)
   155fc:	fff98993          	addi	s3,s3,-1
   15600:	11810c13          	addi	s8,sp,280
   15604:	00140413          	addi	s0,s0,1
   15608:	6a09dc63          	bgez	s3,15cc0 <_ldtoa_r+0xa5c>
   1560c:	000225b7          	lui	a1,0x22
   15610:	00040613          	mv	a2,s0
   15614:	bb458593          	addi	a1,a1,-1100 # 21bb4 <emtens+0x128>
   15618:	000c0513          	mv	a0,s8
   1561c:	474020ef          	jal	ra,17a90 <sprintf>
   15620:	d59ff06f          	j	15378 <_ldtoa_r+0x114>
   15624:	000225b7          	lui	a1,0x22
   15628:	ba458593          	addi	a1,a1,-1116 # 21ba4 <emtens+0x118>
   1562c:	d3dff06f          	j	15368 <_ldtoa_r+0x104>
   15630:	07c11783          	lh	a5,124(sp)
   15634:	0007c863          	bltz	a5,15644 <_ldtoa_r+0x3e0>
   15638:	000225b7          	lui	a1,0x22
   1563c:	bb058593          	addi	a1,a1,-1104 # 21bb0 <emtens+0x124>
   15640:	d29ff06f          	j	15368 <_ldtoa_r+0x104>
   15644:	06c10593          	addi	a1,sp,108
   15648:	00048513          	mv	a0,s1
   1564c:	ccdfe0ef          	jal	ra,14318 <ecmp>
   15650:	f00502e3          	beqz	a0,15554 <_ldtoa_r+0x2f0>
   15654:	46055a63          	bgez	a0,15ac8 <_ldtoa_r+0x864>
   15658:	0a410593          	addi	a1,sp,164
   1565c:	06c10513          	addi	a0,sp,108
   15660:	859fe0ef          	jal	ra,13eb8 <emov>
   15664:	000047b7          	lui	a5,0x4
   15668:	08e78793          	addi	a5,a5,142 # 408e <main-0xbfe6>
   1566c:	0af11b23          	sh	a5,182(sp)
   15670:	01000793          	li	a5,16
   15674:	00f12423          	sw	a5,8(sp)
   15678:	000087b7          	lui	a5,0x8
   1567c:	fff78793          	addi	a5,a5,-1 # 7fff <main-0x8075>
   15680:	00f12a23          	sw	a5,20(sp)
   15684:	ffffc7b7          	lui	a5,0xffffc
   15688:	00278793          	addi	a5,a5,2 # ffffc002 <__global_pointer$+0xfffd78a2>
   1568c:	00000d13          	li	s10,0
   15690:	00f12c23          	sw	a5,24(sp)
   15694:	000227b7          	lui	a5,0x22
   15698:	a0478793          	addi	a5,a5,-1532 # 21a04 <etens+0xa0>
   1569c:	01a78533          	add	a0,a5,s10
   156a0:	15010693          	addi	a3,sp,336
   156a4:	08810613          	addi	a2,sp,136
   156a8:	0a410593          	addi	a1,sp,164
   156ac:	85dff0ef          	jal	ra,14f08 <ediv>
   156b0:	08810513          	addi	a0,sp,136
   156b4:	03c10593          	addi	a1,sp,60
   156b8:	801fe0ef          	jal	ra,13eb8 <emov>
   156bc:	01412783          	lw	a5,20(sp)
   156c0:	04e15c03          	lhu	s8,78(sp)
   156c4:	01812703          	lw	a4,24(sp)
   156c8:	00fc77b3          	and	a5,s8,a5
   156cc:	00e78533          	add	a0,a5,a4
   156d0:	04a04a63          	bgtz	a0,15724 <_ldtoa_r+0x4c0>
   156d4:	0c010513          	addi	a0,sp,192
   156d8:	fccfe0ef          	jal	ra,13ea4 <eclear>
   156dc:	010c1c13          	slli	s8,s8,0x10
   156e0:	410c5c13          	srai	s8,s8,0x10
   156e4:	100c5863          	bgez	s8,157f4 <_ldtoa_r+0x590>
   156e8:	00000793          	li	a5,0
   156ec:	03c10713          	addi	a4,sp,60
   156f0:	00f70733          	add	a4,a4,a5
   156f4:	00075683          	lhu	a3,0(a4)
   156f8:	0c010713          	addi	a4,sp,192
   156fc:	00f70733          	add	a4,a4,a5
   15700:	00075703          	lhu	a4,0(a4)
   15704:	3ae68a63          	beq	a3,a4,15ab8 <_ldtoa_r+0x854>
   15708:	00048513          	mv	a0,s1
   1570c:	ad1fe0ef          	jal	ra,141dc <eisnan>
   15710:	08050663          	beqz	a0,1579c <_ldtoa_r+0x538>
   15714:	0c010593          	addi	a1,sp,192
   15718:	00048513          	mv	a0,s1
   1571c:	f9cfe0ef          	jal	ra,13eb8 <emov>
   15720:	0d40006f          	j	157f4 <_ldtoa_r+0x590>
   15724:	09000793          	li	a5,144
   15728:	40a78db3          	sub	s11,a5,a0
   1572c:	0c010593          	addi	a1,sp,192
   15730:	03c10513          	addi	a0,sp,60
   15734:	f84fe0ef          	jal	ra,13eb8 <emov>
   15738:	0bb05e63          	blez	s11,157f4 <_ldtoa_r+0x590>
   1573c:	0c010693          	addi	a3,sp,192
   15740:	000d8713          	mv	a4,s11
   15744:	00f00613          	li	a2,15
   15748:	04e64263          	blt	a2,a4,1578c <_ldtoa_r+0x528>
   1574c:	004dd513          	srli	a0,s11,0x4
   15750:	0c010793          	addi	a5,sp,192
   15754:	00151713          	slli	a4,a0,0x1
   15758:	00e78733          	add	a4,a5,a4
   1575c:	ff000593          	li	a1,-16
   15760:	00e12e23          	sw	a4,28(sp)
   15764:	6490b0ef          	jal	ra,215ac <__mulsi3>
   15768:	01c12703          	lw	a4,28(sp)
   1576c:	01b50533          	add	a0,a0,s11
   15770:	00151513          	slli	a0,a0,0x1
   15774:	00a98533          	add	a0,s3,a0
   15778:	00075683          	lhu	a3,0(a4)
   1577c:	12c55783          	lhu	a5,300(a0)
   15780:	00d7f7b3          	and	a5,a5,a3
   15784:	00f71023          	sh	a5,0(a4)
   15788:	f55ff06f          	j	156dc <_ldtoa_r+0x478>
   1578c:	00069023          	sh	zero,0(a3)
   15790:	ff070713          	addi	a4,a4,-16
   15794:	00268693          	addi	a3,a3,2
   15798:	fb1ff06f          	j	15748 <_ldtoa_r+0x4e4>
   1579c:	0c010513          	addi	a0,sp,192
   157a0:	a3dfe0ef          	jal	ra,141dc <eisnan>
   157a4:	00050863          	beqz	a0,157b4 <_ldtoa_r+0x550>
   157a8:	0c010593          	addi	a1,sp,192
   157ac:	00058513          	mv	a0,a1
   157b0:	f6dff06f          	j	1571c <_ldtoa_r+0x4b8>
   157b4:	00048513          	mv	a0,s1
   157b8:	c69fe0ef          	jal	ra,14420 <eisinf>
   157bc:	00050d93          	mv	s11,a0
   157c0:	0c010513          	addi	a0,sp,192
   157c4:	c5dfe0ef          	jal	ra,14420 <eisinf>
   157c8:	00050c13          	mv	s8,a0
   157cc:	140d8c63          	beqz	s11,15924 <_ldtoa_r+0x6c0>
   157d0:	12050463          	beqz	a0,158f8 <_ldtoa_r+0x694>
   157d4:	00048513          	mv	a0,s1
   157d8:	a39fe0ef          	jal	ra,14210 <eisneg>
   157dc:	00050c13          	mv	s8,a0
   157e0:	0c010513          	addi	a0,sp,192
   157e4:	a2dfe0ef          	jal	ra,14210 <eisneg>
   157e8:	10ac1863          	bne	s8,a0,158f8 <_ldtoa_r+0x694>
   157ec:	0c010513          	addi	a0,sp,192
   157f0:	ebdfe0ef          	jal	ra,146ac <enan.constprop.12>
   157f4:	00000793          	li	a5,0
   157f8:	08810713          	addi	a4,sp,136
   157fc:	00f70733          	add	a4,a4,a5
   15800:	00075683          	lhu	a3,0(a4)
   15804:	0c010713          	addi	a4,sp,192
   15808:	00f70733          	add	a4,a4,a5
   1580c:	00075703          	lhu	a4,0(a4)
   15810:	02e69263          	bne	a3,a4,15834 <_ldtoa_r+0x5d0>
   15814:	00278793          	addi	a5,a5,2
   15818:	01200713          	li	a4,18
   1581c:	fce79ee3          	bne	a5,a4,157f8 <_ldtoa_r+0x594>
   15820:	0a410593          	addi	a1,sp,164
   15824:	08810513          	addi	a0,sp,136
   15828:	e90fe0ef          	jal	ra,13eb8 <emov>
   1582c:	00812783          	lw	a5,8(sp)
   15830:	00f40433          	add	s0,s0,a5
   15834:	00812783          	lw	a5,8(sp)
   15838:	014d0d13          	addi	s10,s10,20
   1583c:	0017d793          	srli	a5,a5,0x1
   15840:	00f12423          	sw	a5,8(sp)
   15844:	06400793          	li	a5,100
   15848:	e4fd16e3          	bne	s10,a5,15694 <_ldtoa_r+0x430>
   1584c:	0b615783          	lhu	a5,182(sp)
   15850:	07e15703          	lhu	a4,126(sp)
   15854:	06c10593          	addi	a1,sp,108
   15858:	0a410513          	addi	a0,sp,164
   1585c:	00e787b3          	add	a5,a5,a4
   15860:	ffffc737          	lui	a4,0xffffc
   15864:	f7270713          	addi	a4,a4,-142 # ffffbf72 <__global_pointer$+0xfffd7812>
   15868:	00e787b3          	add	a5,a5,a4
   1586c:	0af11b23          	sh	a5,182(sp)
   15870:	e48fe0ef          	jal	ra,13eb8 <emov>
   15874:	00048513          	mv	a0,s1
   15878:	08810593          	addi	a1,sp,136
   1587c:	e3cfe0ef          	jal	ra,13eb8 <emov>
   15880:	00000493          	li	s1,0
   15884:	00001d37          	lui	s10,0x1
   15888:	11898993          	addi	s3,s3,280
   1588c:	10400d93          	li	s11,260
   15890:	000227b7          	lui	a5,0x22
   15894:	96478793          	addi	a5,a5,-1692 # 21964 <etens>
   15898:	0a410593          	addi	a1,sp,164
   1589c:	00098513          	mv	a0,s3
   158a0:	00f48c33          	add	s8,s1,a5
   158a4:	a75fe0ef          	jal	ra,14318 <ecmp>
   158a8:	caa046e3          	bgtz	a0,15554 <_ldtoa_r+0x2f0>
   158ac:	0a410593          	addi	a1,sp,164
   158b0:	000c0513          	mv	a0,s8
   158b4:	a65fe0ef          	jal	ra,14318 <ecmp>
   158b8:	02a04863          	bgtz	a0,158e8 <_ldtoa_r+0x684>
   158bc:	0a410613          	addi	a2,sp,164
   158c0:	00060593          	mv	a1,a2
   158c4:	15010693          	addi	a3,sp,336
   158c8:	000c0513          	mv	a0,s8
   158cc:	e3cff0ef          	jal	ra,14f08 <ediv>
   158d0:	08810613          	addi	a2,sp,136
   158d4:	15010693          	addi	a3,sp,336
   158d8:	00060593          	mv	a1,a2
   158dc:	000c0513          	mv	a0,s8
   158e0:	b78ff0ef          	jal	ra,14c58 <emul>
   158e4:	01a40433          	add	s0,s0,s10
   158e8:	01448493          	addi	s1,s1,20
   158ec:	001d5d13          	srli	s10,s10,0x1
   158f0:	fbb490e3          	bne	s1,s11,15890 <_ldtoa_r+0x62c>
   158f4:	c61ff06f          	j	15554 <_ldtoa_r+0x2f0>
   158f8:	00048513          	mv	a0,s1
   158fc:	0c010593          	addi	a1,sp,192
   15900:	db8fe0ef          	jal	ra,13eb8 <emov>
   15904:	0c010513          	addi	a0,sp,192
   15908:	8d5fe0ef          	jal	ra,141dc <eisnan>
   1590c:	ee0514e3          	bnez	a0,157f4 <_ldtoa_r+0x590>
   15910:	0d215783          	lhu	a5,210(sp)
   15914:	ffff8737          	lui	a4,0xffff8
   15918:	00e7c7b3          	xor	a5,a5,a4
   1591c:	0cf11923          	sh	a5,210(sp)
   15920:	ed5ff06f          	j	157f4 <_ldtoa_r+0x590>
   15924:	e80512e3          	bnez	a0,157a8 <_ldtoa_r+0x544>
   15928:	0dc10593          	addi	a1,sp,220
   1592c:	00048513          	mv	a0,s1
   15930:	919fe0ef          	jal	ra,14248 <emovi>
   15934:	0f810593          	addi	a1,sp,248
   15938:	0c010513          	addi	a0,sp,192
   1593c:	90dfe0ef          	jal	ra,14248 <emovi>
   15940:	0dc15703          	lhu	a4,220(sp)
   15944:	0fa15d83          	lhu	s11,250(sp)
   15948:	0de15783          	lhu	a5,222(sp)
   1594c:	fff74713          	not	a4,a4
   15950:	01071713          	slli	a4,a4,0x10
   15954:	01075713          	srli	a4,a4,0x10
   15958:	0ce11e23          	sh	a4,220(sp)
   1595c:	41b787b3          	sub	a5,a5,s11
   15960:	08f05863          	blez	a5,159f0 <_ldtoa_r+0x78c>
   15964:	11410593          	addi	a1,sp,276
   15968:	0f810513          	addi	a0,sp,248
   1596c:	00f12e23          	sw	a5,28(sp)
   15970:	d78fe0ef          	jal	ra,13ee8 <emovz>
   15974:	0f810593          	addi	a1,sp,248
   15978:	0dc10513          	addi	a0,sp,220
   1597c:	d6cfe0ef          	jal	ra,13ee8 <emovz>
   15980:	0dc10593          	addi	a1,sp,220
   15984:	11410513          	addi	a0,sp,276
   15988:	d60fe0ef          	jal	ra,13ee8 <emovz>
   1598c:	01c12783          	lw	a5,28(sp)
   15990:	0fa15d83          	lhu	s11,250(sp)
   15994:	40f007b3          	neg	a5,a5
   15998:	f6f00713          	li	a4,-145
   1599c:	08e7ce63          	blt	a5,a4,15a38 <_ldtoa_r+0x7d4>
   159a0:	00078593          	mv	a1,a5
   159a4:	0dc10513          	addi	a0,sp,220
   159a8:	ad5fe0ef          	jal	ra,1447c <eshift.part.3>
   159ac:	00050813          	mv	a6,a0
   159b0:	0dc15703          	lhu	a4,220(sp)
   159b4:	0f815783          	lhu	a5,248(sp)
   159b8:	01012e23          	sw	a6,28(sp)
   159bc:	0f810593          	addi	a1,sp,248
   159c0:	0dc10513          	addi	a0,sp,220
   159c4:	0ef71463          	bne	a4,a5,15aac <_ldtoa_r+0x848>
   159c8:	ec8fe0ef          	jal	ra,14090 <eaddm>
   159cc:	01c12803          	lw	a6,28(sp)
   159d0:	15010793          	addi	a5,sp,336
   159d4:	04000713          	li	a4,64
   159d8:	000d8693          	mv	a3,s11
   159dc:	000c0613          	mv	a2,s8
   159e0:	00080593          	mv	a1,a6
   159e4:	0f810513          	addi	a0,sp,248
   159e8:	e65fe0ef          	jal	ra,1484c <emdnorm>
   159ec:	04c0006f          	j	15a38 <_ldtoa_r+0x7d4>
   159f0:	fa0794e3          	bnez	a5,15998 <_ldtoa_r+0x734>
   159f4:	0f810593          	addi	a1,sp,248
   159f8:	0dc10513          	addi	a0,sp,220
   159fc:	00e12e23          	sw	a4,28(sp)
   15a00:	d0cfe0ef          	jal	ra,13f0c <ecmpm>
   15a04:	06051a63          	bnez	a0,15a78 <_ldtoa_r+0x814>
   15a08:	0f815783          	lhu	a5,248(sp)
   15a0c:	01c12703          	lw	a4,28(sp)
   15a10:	00e78863          	beq	a5,a4,15a20 <_ldtoa_r+0x7bc>
   15a14:	0c010513          	addi	a0,sp,192
   15a18:	c8cfe0ef          	jal	ra,13ea4 <eclear>
   15a1c:	dd9ff06f          	j	157f4 <_ldtoa_r+0x590>
   15a20:	020d9463          	bnez	s11,15a48 <_ldtoa_r+0x7e4>
   15a24:	0fe11703          	lh	a4,254(sp)
   15a28:	00000793          	li	a5,0
   15a2c:	02074063          	bltz	a4,15a4c <_ldtoa_r+0x7e8>
   15a30:	0f810513          	addi	a0,sp,248
   15a34:	d64fe0ef          	jal	ra,13f98 <eshup1>
   15a38:	0c010593          	addi	a1,sp,192
   15a3c:	0f810513          	addi	a0,sp,248
   15a40:	c95fe0ef          	jal	ra,146d4 <emovo.isra.6>
   15a44:	db1ff06f          	j	157f4 <_ldtoa_r+0x590>
   15a48:	00000793          	li	a5,0
   15a4c:	01600713          	li	a4,22
   15a50:	0f810693          	addi	a3,sp,248
   15a54:	00f68633          	add	a2,a3,a5
   15a58:	00265603          	lhu	a2,2(a2)
   15a5c:	00060863          	beqz	a2,15a6c <_ldtoa_r+0x808>
   15a60:	001d8d93          	addi	s11,s11,1
   15a64:	0fb11d23          	sh	s11,250(sp)
   15a68:	fd1ff06f          	j	15a38 <_ldtoa_r+0x7d4>
   15a6c:	00278793          	addi	a5,a5,2
   15a70:	fee790e3          	bne	a5,a4,15a50 <_ldtoa_r+0x7ec>
   15a74:	ff1ff06f          	j	15a64 <_ldtoa_r+0x800>
   15a78:	00000813          	li	a6,0
   15a7c:	f2a05ae3          	blez	a0,159b0 <_ldtoa_r+0x74c>
   15a80:	11410593          	addi	a1,sp,276
   15a84:	0f810513          	addi	a0,sp,248
   15a88:	c60fe0ef          	jal	ra,13ee8 <emovz>
   15a8c:	0f810593          	addi	a1,sp,248
   15a90:	0dc10513          	addi	a0,sp,220
   15a94:	c54fe0ef          	jal	ra,13ee8 <emovz>
   15a98:	0dc10593          	addi	a1,sp,220
   15a9c:	11410513          	addi	a0,sp,276
   15aa0:	c48fe0ef          	jal	ra,13ee8 <emovz>
   15aa4:	000c0813          	mv	a6,s8
   15aa8:	f09ff06f          	j	159b0 <_ldtoa_r+0x74c>
   15aac:	e1cfe0ef          	jal	ra,140c8 <esubm>
   15ab0:	00100c13          	li	s8,1
   15ab4:	f19ff06f          	j	159cc <_ldtoa_r+0x768>
   15ab8:	00278793          	addi	a5,a5,2
   15abc:	01200713          	li	a4,18
   15ac0:	c2e796e3          	bne	a5,a4,156ec <_ldtoa_r+0x488>
   15ac4:	d31ff06f          	j	157f4 <_ldtoa_r+0x590>
   15ac8:	07e15783          	lhu	a5,126(sp)
   15acc:	11898c13          	addi	s8,s3,280
   15ad0:	0a078863          	beqz	a5,15b80 <_ldtoa_r+0x91c>
   15ad4:	0c010593          	addi	a1,sp,192
   15ad8:	06c10513          	addi	a0,sp,108
   15adc:	00004c37          	lui	s8,0x4
   15ae0:	f68fe0ef          	jal	ra,14248 <emovi>
   15ae4:	ffec0c13          	addi	s8,s8,-2 # 3ffe <main-0xc076>
   15ae8:	fd500d13          	li	s10,-43
   15aec:	0d815783          	lhu	a5,216(sp)
   15af0:	0077f793          	andi	a5,a5,7
   15af4:	06079263          	bnez	a5,15b58 <_ldtoa_r+0x8f4>
   15af8:	0a410593          	addi	a1,sp,164
   15afc:	0c010513          	addi	a0,sp,192
   15b00:	be8fe0ef          	jal	ra,13ee8 <emovz>
   15b04:	0a410513          	addi	a0,sp,164
   15b08:	c40fe0ef          	jal	ra,13f48 <eshdn1>
   15b0c:	0a410513          	addi	a0,sp,164
   15b10:	c38fe0ef          	jal	ra,13f48 <eshdn1>
   15b14:	0a410593          	addi	a1,sp,164
   15b18:	0c010513          	addi	a0,sp,192
   15b1c:	d74fe0ef          	jal	ra,14090 <eaddm>
   15b20:	0a615783          	lhu	a5,166(sp)
   15b24:	00378793          	addi	a5,a5,3
   15b28:	0af11323          	sh	a5,166(sp)
   15b2c:	0a815783          	lhu	a5,168(sp)
   15b30:	10079a63          	bnez	a5,15c44 <_ldtoa_r+0x9e0>
   15b34:	0bc15783          	lhu	a5,188(sp)
   15b38:	02079063          	bnez	a5,15b58 <_ldtoa_r+0x8f4>
   15b3c:	0a615783          	lhu	a5,166(sp)
   15b40:	00fc6c63          	bltu	s8,a5,15b58 <_ldtoa_r+0x8f4>
   15b44:	0c010593          	addi	a1,sp,192
   15b48:	0a410513          	addi	a0,sp,164
   15b4c:	fff40413          	addi	s0,s0,-1
   15b50:	b98fe0ef          	jal	ra,13ee8 <emovz>
   15b54:	f9a41ce3          	bne	s0,s10,15aec <_ldtoa_r+0x888>
   15b58:	06c10593          	addi	a1,sp,108
   15b5c:	0c010513          	addi	a0,sp,192
   15b60:	b75fe0ef          	jal	ra,146d4 <emovo.isra.6>
   15b64:	0240006f          	j	15b88 <_ldtoa_r+0x924>
   15b68:	06c10613          	addi	a2,sp,108
   15b6c:	15010693          	addi	a3,sp,336
   15b70:	00060593          	mv	a1,a2
   15b74:	000c0513          	mv	a0,s8
   15b78:	8e0ff0ef          	jal	ra,14c58 <emul>
   15b7c:	fff40413          	addi	s0,s0,-1
   15b80:	07c11783          	lh	a5,124(sp)
   15b84:	fe07d2e3          	bgez	a5,15b68 <_ldtoa_r+0x904>
   15b88:	0c010593          	addi	a1,sp,192
   15b8c:	06c10513          	addi	a0,sp,108
   15b90:	b28fe0ef          	jal	ra,13eb8 <emov>
   15b94:	08810593          	addi	a1,sp,136
   15b98:	00048513          	mv	a0,s1
   15b9c:	b1cfe0ef          	jal	ra,13eb8 <emov>
   15ba0:	15098793          	addi	a5,s3,336
   15ba4:	00000d13          	li	s10,0
   15ba8:	fffffc37          	lui	s8,0xfffff
   15bac:	02898d93          	addi	s11,s3,40
   15bb0:	00f12423          	sw	a5,8(sp)
   15bb4:	00812783          	lw	a5,8(sp)
   15bb8:	0c010593          	addi	a1,sp,192
   15bbc:	00048513          	mv	a0,s1
   15bc0:	01a78733          	add	a4,a5,s10
   15bc4:	00e12a23          	sw	a4,20(sp)
   15bc8:	f50fe0ef          	jal	ra,14318 <ecmp>
   15bcc:	01ad89b3          	add	s3,s11,s10
   15bd0:	01412703          	lw	a4,20(sp)
   15bd4:	04a05c63          	blez	a0,15c2c <_ldtoa_r+0x9c8>
   15bd8:	0c010593          	addi	a1,sp,192
   15bdc:	00070513          	mv	a0,a4
   15be0:	f38fe0ef          	jal	ra,14318 <ecmp>
   15be4:	02054863          	bltz	a0,15c14 <_ldtoa_r+0x9b0>
   15be8:	0c010613          	addi	a2,sp,192
   15bec:	00060593          	mv	a1,a2
   15bf0:	15010693          	addi	a3,sp,336
   15bf4:	00098513          	mv	a0,s3
   15bf8:	860ff0ef          	jal	ra,14c58 <emul>
   15bfc:	08810613          	addi	a2,sp,136
   15c00:	15010693          	addi	a3,sp,336
   15c04:	00060593          	mv	a1,a2
   15c08:	00098513          	mv	a0,s3
   15c0c:	84cff0ef          	jal	ra,14c58 <emul>
   15c10:	01840433          	add	s0,s0,s8
   15c14:	01fc5713          	srli	a4,s8,0x1f
   15c18:	01870c33          	add	s8,a4,s8
   15c1c:	014d0d13          	addi	s10,s10,20 # 1014 <main-0xf060>
   15c20:	10400793          	li	a5,260
   15c24:	401c5c13          	srai	s8,s8,0x1
   15c28:	f8fd16e3          	bne	s10,a5,15bb4 <_ldtoa_r+0x950>
   15c2c:	08810613          	addi	a2,sp,136
   15c30:	15010693          	addi	a3,sp,336
   15c34:	00048593          	mv	a1,s1
   15c38:	00060513          	mv	a0,a2
   15c3c:	accff0ef          	jal	ra,14f08 <ediv>
   15c40:	915ff06f          	j	15554 <_ldtoa_r+0x2f0>
   15c44:	0a410513          	addi	a0,sp,164
   15c48:	b00fe0ef          	jal	ra,13f48 <eshdn1>
   15c4c:	0a615783          	lhu	a5,166(sp)
   15c50:	00178793          	addi	a5,a5,1
   15c54:	ed5ff06f          	j	15b28 <_ldtoa_r+0x8c4>
   15c58:	06c10513          	addi	a0,sp,108
   15c5c:	b3cfe0ef          	jal	ra,13f98 <eshup1>
   15c60:	0a410593          	addi	a1,sp,164
   15c64:	06c10513          	addi	a0,sp,108
   15c68:	a80fe0ef          	jal	ra,13ee8 <emovz>
   15c6c:	0a410513          	addi	a0,sp,164
   15c70:	b28fe0ef          	jal	ra,13f98 <eshup1>
   15c74:	0a410513          	addi	a0,sp,164
   15c78:	b20fe0ef          	jal	ra,13f98 <eshup1>
   15c7c:	06c10593          	addi	a1,sp,108
   15c80:	0a410513          	addi	a0,sp,164
   15c84:	c0cfe0ef          	jal	ra,14090 <eaddm>
   15c88:	15010613          	addi	a2,sp,336
   15c8c:	06c10593          	addi	a1,sp,108
   15c90:	08810513          	addi	a0,sp,136
   15c94:	ee1fe0ef          	jal	ra,14b74 <eiremain>
   15c98:	fff40413          	addi	s0,s0,-1
   15c9c:	19c15483          	lhu	s1,412(sp)
   15ca0:	8f9ff06f          	j	15598 <_ldtoa_r+0x334>
   15ca4:	02000793          	li	a5,32
   15ca8:	911ff06f          	j	155b8 <_ldtoa_r+0x354>
   15cac:	03048493          	addi	s1,s1,48
   15cb0:	02e00793          	li	a5,46
   15cb4:	10910aa3          	sb	s1,277(sp)
   15cb8:	10f10b23          	sb	a5,278(sp)
   15cbc:	11710c13          	addi	s8,sp,279
   15cc0:	000c0493          	mv	s1,s8
   15cc4:	418487b3          	sub	a5,s1,s8
   15cc8:	04f9d663          	ble	a5,s3,15d14 <_ldtoa_r+0xab0>
   15ccc:	19c15783          	lhu	a5,412(sp)
   15cd0:	00400713          	li	a4,4
   15cd4:	fff48c13          	addi	s8,s1,-1
   15cd8:	92f75ae3          	ble	a5,a4,1560c <_ldtoa_r+0x3a8>
   15cdc:	00500713          	li	a4,5
   15ce0:	08e78463          	beq	a5,a4,15d68 <_ldtoa_r+0xb04>
   15ce4:	000c0793          	mv	a5,s8
   15ce8:	02e00613          	li	a2,46
   15cec:	03800593          	li	a1,56
   15cf0:	03000693          	li	a3,48
   15cf4:	fff78793          	addi	a5,a5,-1
   15cf8:	0007c703          	lbu	a4,0(a5)
   15cfc:	07f77713          	andi	a4,a4,127
   15d00:	0a09d663          	bgez	s3,15dac <_ldtoa_r+0xb48>
   15d04:	03100713          	li	a4,49
   15d08:	00e78023          	sb	a4,0(a5)
   15d0c:	00140413          	addi	s0,s0,1
   15d10:	8fdff06f          	j	1560c <_ldtoa_r+0x3a8>
   15d14:	06c10513          	addi	a0,sp,108
   15d18:	a80fe0ef          	jal	ra,13f98 <eshup1>
   15d1c:	0a410593          	addi	a1,sp,164
   15d20:	06c10513          	addi	a0,sp,108
   15d24:	9c4fe0ef          	jal	ra,13ee8 <emovz>
   15d28:	0a410513          	addi	a0,sp,164
   15d2c:	a6cfe0ef          	jal	ra,13f98 <eshup1>
   15d30:	0a410513          	addi	a0,sp,164
   15d34:	a64fe0ef          	jal	ra,13f98 <eshup1>
   15d38:	06c10593          	addi	a1,sp,108
   15d3c:	0a410513          	addi	a0,sp,164
   15d40:	b50fe0ef          	jal	ra,14090 <eaddm>
   15d44:	15010613          	addi	a2,sp,336
   15d48:	06c10593          	addi	a1,sp,108
   15d4c:	08810513          	addi	a0,sp,136
   15d50:	e25fe0ef          	jal	ra,14b74 <eiremain>
   15d54:	19c14783          	lbu	a5,412(sp)
   15d58:	00148493          	addi	s1,s1,1
   15d5c:	03078793          	addi	a5,a5,48
   15d60:	fef48fa3          	sb	a5,-1(s1)
   15d64:	f61ff06f          	j	15cc4 <_ldtoa_r+0xa60>
   15d68:	08810593          	addi	a1,sp,136
   15d6c:	06c10513          	addi	a0,sp,108
   15d70:	965fe0ef          	jal	ra,146d4 <emovo.isra.6>
   15d74:	93cb0593          	addi	a1,s6,-1732
   15d78:	08810513          	addi	a0,sp,136
   15d7c:	d9cfe0ef          	jal	ra,14318 <ecmp>
   15d80:	f60512e3          	bnez	a0,15ce4 <_ldtoa_r+0xa80>
   15d84:	8809c4e3          	bltz	s3,1560c <_ldtoa_r+0x3a8>
   15d88:	ffe4c783          	lbu	a5,-2(s1)
   15d8c:	fd278793          	addi	a5,a5,-46
   15d90:	0017b793          	seqz	a5,a5
   15d94:	fff7c793          	not	a5,a5
   15d98:	00fc07b3          	add	a5,s8,a5
   15d9c:	0007c783          	lbu	a5,0(a5)
   15da0:	0017f793          	andi	a5,a5,1
   15da4:	860784e3          	beqz	a5,1560c <_ldtoa_r+0x3a8>
   15da8:	f3dff06f          	j	15ce4 <_ldtoa_r+0xa80>
   15dac:	02c71463          	bne	a4,a2,15dd4 <_ldtoa_r+0xb70>
   15db0:	fff7c703          	lbu	a4,-1(a5)
   15db4:	03800693          	li	a3,56
   15db8:	00e6e863          	bltu	a3,a4,15dc8 <_ldtoa_r+0xb64>
   15dbc:	00170713          	addi	a4,a4,1 # ffff8001 <__global_pointer$+0xfffd38a1>
   15dc0:	fee78fa3          	sb	a4,-1(a5)
   15dc4:	849ff06f          	j	1560c <_ldtoa_r+0x3a8>
   15dc8:	00140413          	addi	s0,s0,1
   15dcc:	03100713          	li	a4,49
   15dd0:	ff1ff06f          	j	15dc0 <_ldtoa_r+0xb5c>
   15dd4:	00e5e863          	bltu	a1,a4,15de4 <_ldtoa_r+0xb80>
   15dd8:	00170713          	addi	a4,a4,1
   15ddc:	00e78023          	sb	a4,0(a5)
   15de0:	82dff06f          	j	1560c <_ldtoa_r+0x3a8>
   15de4:	00d78023          	sb	a3,0(a5)
   15de8:	f0dff06f          	j	15cf4 <_ldtoa_r+0xa90>
   15dec:	00140413          	addi	s0,s0,1
   15df0:	008ca023          	sw	s0,0(s9)
   15df4:	00098793          	mv	a5,s3
   15df8:	02e00693          	li	a3,46
   15dfc:	0007c703          	lbu	a4,0(a5)
   15e00:	00071e63          	bnez	a4,15e1c <_ldtoa_r+0xbb8>
   15e04:	04500713          	li	a4,69
   15e08:	0007c683          	lbu	a3,0(a5)
   15e0c:	00e68463          	beq	a3,a4,15e14 <_ldtoa_r+0xbb0>
   15e10:	02f9e863          	bltu	s3,a5,15e40 <_ldtoa_r+0xbdc>
   15e14:	00078023          	sb	zero,0(a5)
   15e18:	d94ff06f          	j	153ac <_ldtoa_r+0x148>
   15e1c:	00d70c63          	beq	a4,a3,15e34 <_ldtoa_r+0xbd0>
   15e20:	00178793          	addi	a5,a5,1
   15e24:	fd9ff06f          	j	15dfc <_ldtoa_r+0xb98>
   15e28:	0017c703          	lbu	a4,1(a5)
   15e2c:	00178793          	addi	a5,a5,1
   15e30:	fee78fa3          	sb	a4,-1(a5)
   15e34:	0007c703          	lbu	a4,0(a5)
   15e38:	fe0718e3          	bnez	a4,15e28 <_ldtoa_r+0xbc4>
   15e3c:	fc9ff06f          	j	15e04 <_ldtoa_r+0xba0>
   15e40:	fff78793          	addi	a5,a5,-1
   15e44:	fc5ff06f          	j	15e08 <_ldtoa_r+0xba4>
   15e48:	00178793          	addi	a5,a5,1
   15e4c:	d6cff06f          	j	153b8 <_ldtoa_r+0x154>
   15e50:	00068413          	mv	s0,a3
   15e54:	d74ff06f          	j	153c8 <_ldtoa_r+0x164>
   15e58:	fff40413          	addi	s0,s0,-1
   15e5c:	00040023          	sb	zero,0(s0)
   15e60:	d98ff06f          	j	153f8 <_ldtoa_r+0x194>
   15e64:	00158593          	addi	a1,a1,1
   15e68:	04ba2223          	sw	a1,68(s4)
   15e6c:	00179793          	slli	a5,a5,0x1
   15e70:	dd0ff06f          	j	15440 <_ldtoa_r+0x1dc>
   15e74:	000087b7          	lui	a5,0x8
   15e78:	fff78793          	addi	a5,a5,-1 # 7fff <main-0x8075>
   15e7c:	faf71a63          	bne	a4,a5,15630 <_ldtoa_r+0x3cc>
   15e80:	00412783          	lw	a5,4(sp)
   15e84:	fa078063          	beqz	a5,15624 <_ldtoa_r+0x3c0>
   15e88:	000225b7          	lui	a1,0x22
   15e8c:	b9858593          	addi	a1,a1,-1128 # 21b98 <emtens+0x10c>
   15e90:	cd8ff06f          	j	15368 <_ldtoa_r+0x104>
   15e94:	00a00793          	li	a5,10
   15e98:	02a00993          	li	s3,42
   15e9c:	e0f498e3          	bne	s1,a5,15cac <_ldtoa_r+0xa48>
   15ea0:	03100793          	li	a5,49
   15ea4:	10f10aa3          	sb	a5,277(sp)
   15ea8:	02e00793          	li	a5,46
   15eac:	10f10b23          	sb	a5,278(sp)
   15eb0:	02a00993          	li	s3,42
   15eb4:	f40ff06f          	j	155f4 <_ldtoa_r+0x390>

00015eb8 <_ldcheck>:
   15eb8:	00052783          	lw	a5,0(a0)
   15ebc:	fc010113          	addi	sp,sp,-64
   15ec0:	01410593          	addi	a1,sp,20
   15ec4:	00f12023          	sw	a5,0(sp)
   15ec8:	00452783          	lw	a5,4(a0)
   15ecc:	02112e23          	sw	ra,60(sp)
   15ed0:	00f12223          	sw	a5,4(sp)
   15ed4:	00852783          	lw	a5,8(a0)
   15ed8:	00f12423          	sw	a5,8(sp)
   15edc:	00c52783          	lw	a5,12(a0)
   15ee0:	00010513          	mv	a0,sp
   15ee4:	00f12623          	sw	a5,12(sp)
   15ee8:	85dfe0ef          	jal	ra,14744 <e113toe.isra.8>
   15eec:	02615783          	lhu	a5,38(sp)
   15ef0:	00000513          	li	a0,0
   15ef4:	fff7c793          	not	a5,a5
   15ef8:	01179713          	slli	a4,a5,0x11
   15efc:	00071a63          	bnez	a4,15f10 <_ldcheck+0x58>
   15f00:	01410513          	addi	a0,sp,20
   15f04:	ad8fe0ef          	jal	ra,141dc <eisnan>
   15f08:	00153513          	seqz	a0,a0
   15f0c:	00150513          	addi	a0,a0,1
   15f10:	03c12083          	lw	ra,60(sp)
   15f14:	04010113          	addi	sp,sp,64
   15f18:	00008067          	ret

00015f1c <__localeconv_l>:
   15f1c:	0f050513          	addi	a0,a0,240
   15f20:	00008067          	ret

00015f24 <_localeconv_r>:
   15f24:	8201a783          	lw	a5,-2016(gp) # 23f80 <_impure_ptr>
   15f28:	0347a503          	lw	a0,52(a5)
   15f2c:	00051663          	bnez	a0,15f38 <_localeconv_r+0x14>
   15f30:	00024537          	lui	a0,0x24
   15f34:	df050513          	addi	a0,a0,-528 # 23df0 <__global_locale>
   15f38:	0f050513          	addi	a0,a0,240
   15f3c:	00008067          	ret

00015f40 <localeconv>:
   15f40:	8201a783          	lw	a5,-2016(gp) # 23f80 <_impure_ptr>
   15f44:	0347a503          	lw	a0,52(a5)
   15f48:	00051663          	bnez	a0,15f54 <localeconv+0x14>
   15f4c:	00024537          	lui	a0,0x24
   15f50:	df050513          	addi	a0,a0,-528 # 23df0 <__global_locale>
   15f54:	0f050513          	addi	a0,a0,240
   15f58:	00008067          	ret

00015f5c <_setlocale_r>:
   15f5c:	ff010113          	addi	sp,sp,-16
   15f60:	00912223          	sw	s1,4(sp)
   15f64:	00112623          	sw	ra,12(sp)
   15f68:	00812423          	sw	s0,8(sp)
   15f6c:	000224b7          	lui	s1,0x22
   15f70:	04060263          	beqz	a2,15fb4 <_setlocale_r+0x58>
   15f74:	000225b7          	lui	a1,0x22
   15f78:	bbc58593          	addi	a1,a1,-1092 # 21bbc <emtens+0x130>
   15f7c:	00060513          	mv	a0,a2
   15f80:	00060413          	mv	s0,a2
   15f84:	4b9010ef          	jal	ra,17c3c <strcmp>
   15f88:	02050663          	beqz	a0,15fb4 <_setlocale_r+0x58>
   15f8c:	bb848593          	addi	a1,s1,-1096 # 21bb8 <emtens+0x12c>
   15f90:	00040513          	mv	a0,s0
   15f94:	4a9010ef          	jal	ra,17c3c <strcmp>
   15f98:	00050e63          	beqz	a0,15fb4 <_setlocale_r+0x58>
   15f9c:	000225b7          	lui	a1,0x22
   15fa0:	93458593          	addi	a1,a1,-1740 # 21934 <zeroes.4377+0x7c>
   15fa4:	00040513          	mv	a0,s0
   15fa8:	495010ef          	jal	ra,17c3c <strcmp>
   15fac:	00000793          	li	a5,0
   15fb0:	00051463          	bnez	a0,15fb8 <_setlocale_r+0x5c>
   15fb4:	bb848793          	addi	a5,s1,-1096
   15fb8:	00c12083          	lw	ra,12(sp)
   15fbc:	00812403          	lw	s0,8(sp)
   15fc0:	00412483          	lw	s1,4(sp)
   15fc4:	00078513          	mv	a0,a5
   15fc8:	01010113          	addi	sp,sp,16
   15fcc:	00008067          	ret

00015fd0 <__locale_mb_cur_max>:
   15fd0:	8201a783          	lw	a5,-2016(gp) # 23f80 <_impure_ptr>
   15fd4:	0347a783          	lw	a5,52(a5)
   15fd8:	00079663          	bnez	a5,15fe4 <__locale_mb_cur_max+0x14>
   15fdc:	000247b7          	lui	a5,0x24
   15fe0:	df078793          	addi	a5,a5,-528 # 23df0 <__global_locale>
   15fe4:	1287c503          	lbu	a0,296(a5)
   15fe8:	00008067          	ret

00015fec <__locale_ctype_ptr_l>:
   15fec:	0ec52503          	lw	a0,236(a0)
   15ff0:	00008067          	ret

00015ff4 <__locale_ctype_ptr>:
   15ff4:	8201a783          	lw	a5,-2016(gp) # 23f80 <_impure_ptr>
   15ff8:	0347a783          	lw	a5,52(a5)
   15ffc:	00079663          	bnez	a5,16008 <__locale_ctype_ptr+0x14>
   16000:	000247b7          	lui	a5,0x24
   16004:	df078793          	addi	a5,a5,-528 # 23df0 <__global_locale>
   16008:	0ec7a503          	lw	a0,236(a5)
   1600c:	00008067          	ret

00016010 <setlocale>:
   16010:	00058613          	mv	a2,a1
   16014:	00050593          	mv	a1,a0
   16018:	8201a503          	lw	a0,-2016(gp) # 23f80 <_impure_ptr>
   1601c:	f41ff06f          	j	15f5c <_setlocale_r>

00016020 <__swhatbuf_r>:
   16020:	fa010113          	addi	sp,sp,-96
   16024:	04912a23          	sw	s1,84(sp)
   16028:	00058493          	mv	s1,a1
   1602c:	00e59583          	lh	a1,14(a1)
   16030:	04812c23          	sw	s0,88(sp)
   16034:	04112e23          	sw	ra,92(sp)
   16038:	00060413          	mv	s0,a2
   1603c:	0005de63          	bgez	a1,16058 <__swhatbuf_r+0x38>
   16040:	00c4d783          	lhu	a5,12(s1)
   16044:	0006a023          	sw	zero,0(a3)
   16048:	0807f793          	andi	a5,a5,128
   1604c:	04079863          	bnez	a5,1609c <__swhatbuf_r+0x7c>
   16050:	40000793          	li	a5,1024
   16054:	04c0006f          	j	160a0 <__swhatbuf_r+0x80>
   16058:	01410613          	addi	a2,sp,20
   1605c:	00d12623          	sw	a3,12(sp)
   16060:	7cd040ef          	jal	ra,1b02c <_fstat_r>
   16064:	00c12683          	lw	a3,12(sp)
   16068:	fc054ce3          	bltz	a0,16040 <__swhatbuf_r+0x20>
   1606c:	01812703          	lw	a4,24(sp)
   16070:	0000f7b7          	lui	a5,0xf
   16074:	00001537          	lui	a0,0x1
   16078:	00e7f7b3          	and	a5,a5,a4
   1607c:	ffffe737          	lui	a4,0xffffe
   16080:	00e787b3          	add	a5,a5,a4
   16084:	0017b793          	seqz	a5,a5
   16088:	00f6a023          	sw	a5,0(a3)
   1608c:	40000793          	li	a5,1024
   16090:	00f42023          	sw	a5,0(s0)
   16094:	80050513          	addi	a0,a0,-2048 # 800 <main-0xf874>
   16098:	0100006f          	j	160a8 <__swhatbuf_r+0x88>
   1609c:	04000793          	li	a5,64
   160a0:	00f42023          	sw	a5,0(s0)
   160a4:	00000513          	li	a0,0
   160a8:	05c12083          	lw	ra,92(sp)
   160ac:	05812403          	lw	s0,88(sp)
   160b0:	05412483          	lw	s1,84(sp)
   160b4:	06010113          	addi	sp,sp,96
   160b8:	00008067          	ret

000160bc <__smakebuf_r>:
   160bc:	00c5d783          	lhu	a5,12(a1)
   160c0:	fe010113          	addi	sp,sp,-32
   160c4:	00812c23          	sw	s0,24(sp)
   160c8:	00112e23          	sw	ra,28(sp)
   160cc:	00912a23          	sw	s1,20(sp)
   160d0:	01212823          	sw	s2,16(sp)
   160d4:	0027f793          	andi	a5,a5,2
   160d8:	00058413          	mv	s0,a1
   160dc:	02078863          	beqz	a5,1610c <__smakebuf_r+0x50>
   160e0:	04340793          	addi	a5,s0,67
   160e4:	00f42023          	sw	a5,0(s0)
   160e8:	00f42823          	sw	a5,16(s0)
   160ec:	00100793          	li	a5,1
   160f0:	00f42a23          	sw	a5,20(s0)
   160f4:	01c12083          	lw	ra,28(sp)
   160f8:	01812403          	lw	s0,24(sp)
   160fc:	01412483          	lw	s1,20(sp)
   16100:	01012903          	lw	s2,16(sp)
   16104:	02010113          	addi	sp,sp,32
   16108:	00008067          	ret
   1610c:	00c10693          	addi	a3,sp,12
   16110:	00810613          	addi	a2,sp,8
   16114:	00050493          	mv	s1,a0
   16118:	f09ff0ef          	jal	ra,16020 <__swhatbuf_r>
   1611c:	00812583          	lw	a1,8(sp)
   16120:	00050913          	mv	s2,a0
   16124:	00048513          	mv	a0,s1
   16128:	a84fa0ef          	jal	ra,103ac <_malloc_r>
   1612c:	02051063          	bnez	a0,1614c <__smakebuf_r+0x90>
   16130:	00c41783          	lh	a5,12(s0)
   16134:	2007f713          	andi	a4,a5,512
   16138:	fa071ee3          	bnez	a4,160f4 <__smakebuf_r+0x38>
   1613c:	ffc7f793          	andi	a5,a5,-4
   16140:	0027e793          	ori	a5,a5,2
   16144:	00f41623          	sh	a5,12(s0)
   16148:	f99ff06f          	j	160e0 <__smakebuf_r+0x24>
   1614c:	000137b7          	lui	a5,0x13
   16150:	2c878793          	addi	a5,a5,712 # 132c8 <_cleanup_r>
   16154:	02f4ae23          	sw	a5,60(s1)
   16158:	00c45783          	lhu	a5,12(s0)
   1615c:	00a42023          	sw	a0,0(s0)
   16160:	00a42823          	sw	a0,16(s0)
   16164:	0807e793          	ori	a5,a5,128
   16168:	00f41623          	sh	a5,12(s0)
   1616c:	00812783          	lw	a5,8(sp)
   16170:	00f42a23          	sw	a5,20(s0)
   16174:	00c12783          	lw	a5,12(sp)
   16178:	02078263          	beqz	a5,1619c <__smakebuf_r+0xe0>
   1617c:	00e41583          	lh	a1,14(s0)
   16180:	00048513          	mv	a0,s1
   16184:	6f5040ef          	jal	ra,1b078 <_isatty_r>
   16188:	00050a63          	beqz	a0,1619c <__smakebuf_r+0xe0>
   1618c:	00c45783          	lhu	a5,12(s0)
   16190:	ffc7f793          	andi	a5,a5,-4
   16194:	0017e793          	ori	a5,a5,1
   16198:	00f41623          	sh	a5,12(s0)
   1619c:	00c45783          	lhu	a5,12(s0)
   161a0:	00f96933          	or	s2,s2,a5
   161a4:	01241623          	sh	s2,12(s0)
   161a8:	f4dff06f          	j	160f4 <__smakebuf_r+0x38>

000161ac <_mbtowc_r>:
   161ac:	8201a783          	lw	a5,-2016(gp) # 23f80 <_impure_ptr>
   161b0:	0347a783          	lw	a5,52(a5)
   161b4:	00079663          	bnez	a5,161c0 <_mbtowc_r+0x14>
   161b8:	000247b7          	lui	a5,0x24
   161bc:	df078793          	addi	a5,a5,-528 # 23df0 <__global_locale>
   161c0:	0e47a303          	lw	t1,228(a5)
   161c4:	00030067          	jr	t1

000161c8 <__ascii_mbtowc>:
   161c8:	02059a63          	bnez	a1,161fc <__ascii_mbtowc+0x34>
   161cc:	ff010113          	addi	sp,sp,-16
   161d0:	00c10593          	addi	a1,sp,12
   161d4:	00000513          	li	a0,0
   161d8:	00060e63          	beqz	a2,161f4 <__ascii_mbtowc+0x2c>
   161dc:	ffe00513          	li	a0,-2
   161e0:	00068a63          	beqz	a3,161f4 <__ascii_mbtowc+0x2c>
   161e4:	00064783          	lbu	a5,0(a2)
   161e8:	00f5a023          	sw	a5,0(a1)
   161ec:	00064503          	lbu	a0,0(a2)
   161f0:	00a03533          	snez	a0,a0
   161f4:	01010113          	addi	sp,sp,16
   161f8:	00008067          	ret
   161fc:	00000513          	li	a0,0
   16200:	02060063          	beqz	a2,16220 <__ascii_mbtowc+0x58>
   16204:	ffe00513          	li	a0,-2
   16208:	00068c63          	beqz	a3,16220 <__ascii_mbtowc+0x58>
   1620c:	00064783          	lbu	a5,0(a2)
   16210:	00f5a023          	sw	a5,0(a1)
   16214:	00064503          	lbu	a0,0(a2)
   16218:	00a03533          	snez	a0,a0
   1621c:	00008067          	ret
   16220:	00008067          	ret

00016224 <memchr>:
   16224:	0ff5f593          	andi	a1,a1,255
   16228:	00c50633          	add	a2,a0,a2
   1622c:	00c51663          	bne	a0,a2,16238 <memchr+0x14>
   16230:	00000513          	li	a0,0
   16234:	00008067          	ret
   16238:	00054783          	lbu	a5,0(a0)
   1623c:	feb78ce3          	beq	a5,a1,16234 <memchr+0x10>
   16240:	00150513          	addi	a0,a0,1
   16244:	fe9ff06f          	j	1622c <memchr+0x8>

00016248 <memcpy>:
   16248:	00a5c7b3          	xor	a5,a1,a0
   1624c:	0037f793          	andi	a5,a5,3
   16250:	00c50733          	add	a4,a0,a2
   16254:	00079663          	bnez	a5,16260 <memcpy+0x18>
   16258:	00300793          	li	a5,3
   1625c:	02c7e463          	bltu	a5,a2,16284 <memcpy+0x3c>
   16260:	00050793          	mv	a5,a0
   16264:	00e56c63          	bltu	a0,a4,1627c <memcpy+0x34>
   16268:	00008067          	ret
   1626c:	0005c683          	lbu	a3,0(a1)
   16270:	00178793          	addi	a5,a5,1
   16274:	00158593          	addi	a1,a1,1
   16278:	fed78fa3          	sb	a3,-1(a5)
   1627c:	fee7e8e3          	bltu	a5,a4,1626c <memcpy+0x24>
   16280:	00008067          	ret
   16284:	00357793          	andi	a5,a0,3
   16288:	08079263          	bnez	a5,1630c <memcpy+0xc4>
   1628c:	00050793          	mv	a5,a0
   16290:	ffc77693          	andi	a3,a4,-4
   16294:	fe068613          	addi	a2,a3,-32
   16298:	08c7f663          	bleu	a2,a5,16324 <memcpy+0xdc>
   1629c:	0005a383          	lw	t2,0(a1)
   162a0:	0045a283          	lw	t0,4(a1)
   162a4:	0085af83          	lw	t6,8(a1)
   162a8:	00c5af03          	lw	t5,12(a1)
   162ac:	0105ae83          	lw	t4,16(a1)
   162b0:	0145ae03          	lw	t3,20(a1)
   162b4:	0185a303          	lw	t1,24(a1)
   162b8:	01c5a883          	lw	a7,28(a1)
   162bc:	02458593          	addi	a1,a1,36
   162c0:	02478793          	addi	a5,a5,36
   162c4:	ffc5a803          	lw	a6,-4(a1)
   162c8:	fc77ae23          	sw	t2,-36(a5)
   162cc:	fe57a023          	sw	t0,-32(a5)
   162d0:	fff7a223          	sw	t6,-28(a5)
   162d4:	ffe7a423          	sw	t5,-24(a5)
   162d8:	ffd7a623          	sw	t4,-20(a5)
   162dc:	ffc7a823          	sw	t3,-16(a5)
   162e0:	fe67aa23          	sw	t1,-12(a5)
   162e4:	ff17ac23          	sw	a7,-8(a5)
   162e8:	ff07ae23          	sw	a6,-4(a5)
   162ec:	fadff06f          	j	16298 <memcpy+0x50>
   162f0:	0005c683          	lbu	a3,0(a1)
   162f4:	00178793          	addi	a5,a5,1
   162f8:	00158593          	addi	a1,a1,1
   162fc:	fed78fa3          	sb	a3,-1(a5)
   16300:	0037f693          	andi	a3,a5,3
   16304:	fe0696e3          	bnez	a3,162f0 <memcpy+0xa8>
   16308:	f89ff06f          	j	16290 <memcpy+0x48>
   1630c:	00050793          	mv	a5,a0
   16310:	ff1ff06f          	j	16300 <memcpy+0xb8>
   16314:	0005a603          	lw	a2,0(a1)
   16318:	00478793          	addi	a5,a5,4
   1631c:	00458593          	addi	a1,a1,4
   16320:	fec7ae23          	sw	a2,-4(a5)
   16324:	fed7e8e3          	bltu	a5,a3,16314 <memcpy+0xcc>
   16328:	f4e7eae3          	bltu	a5,a4,1627c <memcpy+0x34>
   1632c:	00008067          	ret

00016330 <memmove>:
   16330:	00c50733          	add	a4,a0,a2
   16334:	00a5e863          	bltu	a1,a0,16344 <memmove+0x14>
   16338:	00050793          	mv	a5,a0
   1633c:	02f71a63          	bne	a4,a5,16370 <memmove+0x40>
   16340:	00008067          	ret
   16344:	00c587b3          	add	a5,a1,a2
   16348:	40f60633          	sub	a2,a2,a5
   1634c:	fef576e3          	bleu	a5,a0,16338 <memmove+0x8>
   16350:	00c786b3          	add	a3,a5,a2
   16354:	00069463          	bnez	a3,1635c <memmove+0x2c>
   16358:	00008067          	ret
   1635c:	fff78793          	addi	a5,a5,-1
   16360:	0007c683          	lbu	a3,0(a5)
   16364:	fff70713          	addi	a4,a4,-1 # ffffdfff <__global_pointer$+0xfffd989f>
   16368:	00d70023          	sb	a3,0(a4)
   1636c:	fe5ff06f          	j	16350 <memmove+0x20>
   16370:	00158593          	addi	a1,a1,1
   16374:	fff5c683          	lbu	a3,-1(a1)
   16378:	00178793          	addi	a5,a5,1
   1637c:	fed78fa3          	sb	a3,-1(a5)
   16380:	fbdff06f          	j	1633c <memmove+0xc>

00016384 <_Balloc>:
   16384:	04c52783          	lw	a5,76(a0)
   16388:	ff010113          	addi	sp,sp,-16
   1638c:	00912223          	sw	s1,4(sp)
   16390:	01212023          	sw	s2,0(sp)
   16394:	00112623          	sw	ra,12(sp)
   16398:	00812423          	sw	s0,8(sp)
   1639c:	00050493          	mv	s1,a0
   163a0:	00058913          	mv	s2,a1
   163a4:	04078263          	beqz	a5,163e8 <_Balloc+0x64>
   163a8:	04c4a703          	lw	a4,76(s1)
   163ac:	00291793          	slli	a5,s2,0x2
   163b0:	00f707b3          	add	a5,a4,a5
   163b4:	0007a503          	lw	a0,0(a5)
   163b8:	06051063          	bnez	a0,16418 <_Balloc+0x94>
   163bc:	00100413          	li	s0,1
   163c0:	01241433          	sll	s0,s0,s2
   163c4:	00540613          	addi	a2,s0,5
   163c8:	00261613          	slli	a2,a2,0x2
   163cc:	00100593          	li	a1,1
   163d0:	00048513          	mv	a0,s1
   163d4:	0e5040ef          	jal	ra,1acb8 <_calloc_r>
   163d8:	02050263          	beqz	a0,163fc <_Balloc+0x78>
   163dc:	01252223          	sw	s2,4(a0)
   163e0:	00852423          	sw	s0,8(a0)
   163e4:	03c0006f          	j	16420 <_Balloc+0x9c>
   163e8:	02100613          	li	a2,33
   163ec:	00400593          	li	a1,4
   163f0:	0c9040ef          	jal	ra,1acb8 <_calloc_r>
   163f4:	04a4a623          	sw	a0,76(s1)
   163f8:	fa0518e3          	bnez	a0,163a8 <_Balloc+0x24>
   163fc:	00000513          	li	a0,0
   16400:	00c12083          	lw	ra,12(sp)
   16404:	00812403          	lw	s0,8(sp)
   16408:	00412483          	lw	s1,4(sp)
   1640c:	00012903          	lw	s2,0(sp)
   16410:	01010113          	addi	sp,sp,16
   16414:	00008067          	ret
   16418:	00052703          	lw	a4,0(a0)
   1641c:	00e7a023          	sw	a4,0(a5)
   16420:	00052823          	sw	zero,16(a0)
   16424:	00052623          	sw	zero,12(a0)
   16428:	fd9ff06f          	j	16400 <_Balloc+0x7c>

0001642c <_Bfree>:
   1642c:	02058063          	beqz	a1,1644c <_Bfree+0x20>
   16430:	0045a783          	lw	a5,4(a1)
   16434:	00279713          	slli	a4,a5,0x2
   16438:	04c52783          	lw	a5,76(a0)
   1643c:	00e787b3          	add	a5,a5,a4
   16440:	0007a703          	lw	a4,0(a5)
   16444:	00e5a023          	sw	a4,0(a1)
   16448:	00b7a023          	sw	a1,0(a5)
   1644c:	00008067          	ret

00016450 <__multadd>:
   16450:	fd010113          	addi	sp,sp,-48
   16454:	02912223          	sw	s1,36(sp)
   16458:	0105a483          	lw	s1,16(a1)
   1645c:	01512a23          	sw	s5,20(sp)
   16460:	00010ab7          	lui	s5,0x10
   16464:	02812423          	sw	s0,40(sp)
   16468:	03212023          	sw	s2,32(sp)
   1646c:	01312e23          	sw	s3,28(sp)
   16470:	01612823          	sw	s6,16(sp)
   16474:	01712623          	sw	s7,12(sp)
   16478:	01812423          	sw	s8,8(sp)
   1647c:	02112623          	sw	ra,44(sp)
   16480:	01412c23          	sw	s4,24(sp)
   16484:	01912223          	sw	s9,4(sp)
   16488:	00050b13          	mv	s6,a0
   1648c:	00058413          	mv	s0,a1
   16490:	00060b93          	mv	s7,a2
   16494:	00068913          	mv	s2,a3
   16498:	01458993          	addi	s3,a1,20
   1649c:	00000c13          	li	s8,0
   164a0:	fffa8a93          	addi	s5,s5,-1 # ffff <main-0x75>
   164a4:	0009ac83          	lw	s9,0(s3)
   164a8:	000b8593          	mv	a1,s7
   164ac:	00498993          	addi	s3,s3,4
   164b0:	015cf533          	and	a0,s9,s5
   164b4:	0f80b0ef          	jal	ra,215ac <__mulsi3>
   164b8:	01250a33          	add	s4,a0,s2
   164bc:	000b8593          	mv	a1,s7
   164c0:	010cd513          	srli	a0,s9,0x10
   164c4:	0e80b0ef          	jal	ra,215ac <__mulsi3>
   164c8:	010a5793          	srli	a5,s4,0x10
   164cc:	00f50533          	add	a0,a0,a5
   164d0:	01055913          	srli	s2,a0,0x10
   164d4:	015a7a33          	and	s4,s4,s5
   164d8:	01051513          	slli	a0,a0,0x10
   164dc:	01450533          	add	a0,a0,s4
   164e0:	fea9ae23          	sw	a0,-4(s3)
   164e4:	001c0c13          	addi	s8,s8,1 # fffff001 <__global_pointer$+0xfffda8a1>
   164e8:	fa9c4ee3          	blt	s8,s1,164a4 <__multadd+0x54>
   164ec:	06090063          	beqz	s2,1654c <__multadd+0xfc>
   164f0:	00842783          	lw	a5,8(s0)
   164f4:	04f4c063          	blt	s1,a5,16534 <__multadd+0xe4>
   164f8:	00442583          	lw	a1,4(s0)
   164fc:	000b0513          	mv	a0,s6
   16500:	00158593          	addi	a1,a1,1
   16504:	e81ff0ef          	jal	ra,16384 <_Balloc>
   16508:	01042603          	lw	a2,16(s0)
   1650c:	00c40593          	addi	a1,s0,12
   16510:	00050993          	mv	s3,a0
   16514:	00260613          	addi	a2,a2,2
   16518:	00261613          	slli	a2,a2,0x2
   1651c:	00c50513          	addi	a0,a0,12
   16520:	d29ff0ef          	jal	ra,16248 <memcpy>
   16524:	00040593          	mv	a1,s0
   16528:	000b0513          	mv	a0,s6
   1652c:	f01ff0ef          	jal	ra,1642c <_Bfree>
   16530:	00098413          	mv	s0,s3
   16534:	00448793          	addi	a5,s1,4
   16538:	00279793          	slli	a5,a5,0x2
   1653c:	00f407b3          	add	a5,s0,a5
   16540:	0127a223          	sw	s2,4(a5)
   16544:	00148493          	addi	s1,s1,1
   16548:	00942823          	sw	s1,16(s0)
   1654c:	00040513          	mv	a0,s0
   16550:	02c12083          	lw	ra,44(sp)
   16554:	02812403          	lw	s0,40(sp)
   16558:	02412483          	lw	s1,36(sp)
   1655c:	02012903          	lw	s2,32(sp)
   16560:	01c12983          	lw	s3,28(sp)
   16564:	01812a03          	lw	s4,24(sp)
   16568:	01412a83          	lw	s5,20(sp)
   1656c:	01012b03          	lw	s6,16(sp)
   16570:	00c12b83          	lw	s7,12(sp)
   16574:	00812c03          	lw	s8,8(sp)
   16578:	00412c83          	lw	s9,4(sp)
   1657c:	03010113          	addi	sp,sp,48
   16580:	00008067          	ret

00016584 <__s2b>:
   16584:	fe010113          	addi	sp,sp,-32
   16588:	00812c23          	sw	s0,24(sp)
   1658c:	01312623          	sw	s3,12(sp)
   16590:	00058413          	mv	s0,a1
   16594:	00050993          	mv	s3,a0
   16598:	00900593          	li	a1,9
   1659c:	00868513          	addi	a0,a3,8
   165a0:	00912a23          	sw	s1,20(sp)
   165a4:	01212823          	sw	s2,16(sp)
   165a8:	01412423          	sw	s4,8(sp)
   165ac:	00112e23          	sw	ra,28(sp)
   165b0:	01512223          	sw	s5,4(sp)
   165b4:	00060493          	mv	s1,a2
   165b8:	00068a13          	mv	s4,a3
   165bc:	00070913          	mv	s2,a4
   165c0:	0100b0ef          	jal	ra,215d0 <__divsi3>
   165c4:	00100793          	li	a5,1
   165c8:	00000593          	li	a1,0
   165cc:	08a7c263          	blt	a5,a0,16650 <__s2b+0xcc>
   165d0:	00098513          	mv	a0,s3
   165d4:	db1ff0ef          	jal	ra,16384 <_Balloc>
   165d8:	00100793          	li	a5,1
   165dc:	00f52823          	sw	a5,16(a0)
   165e0:	01252a23          	sw	s2,20(a0)
   165e4:	00900793          	li	a5,9
   165e8:	0697da63          	ble	s1,a5,1665c <__s2b+0xd8>
   165ec:	00940a93          	addi	s5,s0,9
   165f0:	000a8913          	mv	s2,s5
   165f4:	00940433          	add	s0,s0,s1
   165f8:	00190913          	addi	s2,s2,1
   165fc:	fff94683          	lbu	a3,-1(s2)
   16600:	00050593          	mv	a1,a0
   16604:	00a00613          	li	a2,10
   16608:	fd068693          	addi	a3,a3,-48
   1660c:	00098513          	mv	a0,s3
   16610:	e41ff0ef          	jal	ra,16450 <__multadd>
   16614:	fe8912e3          	bne	s2,s0,165f8 <__s2b+0x74>
   16618:	ff848413          	addi	s0,s1,-8
   1661c:	008a8433          	add	s0,s5,s0
   16620:	408484b3          	sub	s1,s1,s0
   16624:	009407b3          	add	a5,s0,s1
   16628:	0547c063          	blt	a5,s4,16668 <__s2b+0xe4>
   1662c:	01c12083          	lw	ra,28(sp)
   16630:	01812403          	lw	s0,24(sp)
   16634:	01412483          	lw	s1,20(sp)
   16638:	01012903          	lw	s2,16(sp)
   1663c:	00c12983          	lw	s3,12(sp)
   16640:	00812a03          	lw	s4,8(sp)
   16644:	00412a83          	lw	s5,4(sp)
   16648:	02010113          	addi	sp,sp,32
   1664c:	00008067          	ret
   16650:	00179793          	slli	a5,a5,0x1
   16654:	00158593          	addi	a1,a1,1
   16658:	f75ff06f          	j	165cc <__s2b+0x48>
   1665c:	00a40413          	addi	s0,s0,10
   16660:	00900493          	li	s1,9
   16664:	fbdff06f          	j	16620 <__s2b+0x9c>
   16668:	00140413          	addi	s0,s0,1
   1666c:	fff44683          	lbu	a3,-1(s0)
   16670:	00050593          	mv	a1,a0
   16674:	00a00613          	li	a2,10
   16678:	fd068693          	addi	a3,a3,-48
   1667c:	00098513          	mv	a0,s3
   16680:	dd1ff0ef          	jal	ra,16450 <__multadd>
   16684:	fa1ff06f          	j	16624 <__s2b+0xa0>

00016688 <__hi0bits>:
   16688:	ffff0737          	lui	a4,0xffff0
   1668c:	00e57733          	and	a4,a0,a4
   16690:	00050793          	mv	a5,a0
   16694:	00000513          	li	a0,0
   16698:	00071663          	bnez	a4,166a4 <__hi0bits+0x1c>
   1669c:	01079793          	slli	a5,a5,0x10
   166a0:	01000513          	li	a0,16
   166a4:	ff000737          	lui	a4,0xff000
   166a8:	00e7f733          	and	a4,a5,a4
   166ac:	00071663          	bnez	a4,166b8 <__hi0bits+0x30>
   166b0:	00850513          	addi	a0,a0,8
   166b4:	00879793          	slli	a5,a5,0x8
   166b8:	f0000737          	lui	a4,0xf0000
   166bc:	00e7f733          	and	a4,a5,a4
   166c0:	00071663          	bnez	a4,166cc <__hi0bits+0x44>
   166c4:	00450513          	addi	a0,a0,4
   166c8:	00479793          	slli	a5,a5,0x4
   166cc:	c0000737          	lui	a4,0xc0000
   166d0:	00e7f733          	and	a4,a5,a4
   166d4:	00071663          	bnez	a4,166e0 <__hi0bits+0x58>
   166d8:	00250513          	addi	a0,a0,2
   166dc:	00279793          	slli	a5,a5,0x2
   166e0:	0007cc63          	bltz	a5,166f8 <__hi0bits+0x70>
   166e4:	00179713          	slli	a4,a5,0x1
   166e8:	00075663          	bgez	a4,166f4 <__hi0bits+0x6c>
   166ec:	00150513          	addi	a0,a0,1
   166f0:	00008067          	ret
   166f4:	02000513          	li	a0,32
   166f8:	00008067          	ret

000166fc <__lo0bits>:
   166fc:	00052783          	lw	a5,0(a0)
   16700:	0077f713          	andi	a4,a5,7
   16704:	02070e63          	beqz	a4,16740 <__lo0bits+0x44>
   16708:	0017f693          	andi	a3,a5,1
   1670c:	00000713          	li	a4,0
   16710:	00069c63          	bnez	a3,16728 <__lo0bits+0x2c>
   16714:	0027f713          	andi	a4,a5,2
   16718:	00070c63          	beqz	a4,16730 <__lo0bits+0x34>
   1671c:	0017d793          	srli	a5,a5,0x1
   16720:	00f52023          	sw	a5,0(a0)
   16724:	00100713          	li	a4,1
   16728:	00070513          	mv	a0,a4
   1672c:	00008067          	ret
   16730:	0027d793          	srli	a5,a5,0x2
   16734:	00f52023          	sw	a5,0(a0)
   16738:	00200713          	li	a4,2
   1673c:	fedff06f          	j	16728 <__lo0bits+0x2c>
   16740:	01079693          	slli	a3,a5,0x10
   16744:	0106d693          	srli	a3,a3,0x10
   16748:	00000713          	li	a4,0
   1674c:	00069663          	bnez	a3,16758 <__lo0bits+0x5c>
   16750:	0107d793          	srli	a5,a5,0x10
   16754:	01000713          	li	a4,16
   16758:	0ff7f693          	andi	a3,a5,255
   1675c:	00069663          	bnez	a3,16768 <__lo0bits+0x6c>
   16760:	00870713          	addi	a4,a4,8 # c0000008 <__global_pointer$+0xbffdb8a8>
   16764:	0087d793          	srli	a5,a5,0x8
   16768:	00f7f693          	andi	a3,a5,15
   1676c:	00069663          	bnez	a3,16778 <__lo0bits+0x7c>
   16770:	00470713          	addi	a4,a4,4
   16774:	0047d793          	srli	a5,a5,0x4
   16778:	0037f693          	andi	a3,a5,3
   1677c:	00069663          	bnez	a3,16788 <__lo0bits+0x8c>
   16780:	00270713          	addi	a4,a4,2
   16784:	0027d793          	srli	a5,a5,0x2
   16788:	0017f693          	andi	a3,a5,1
   1678c:	00069863          	bnez	a3,1679c <__lo0bits+0xa0>
   16790:	0017d793          	srli	a5,a5,0x1
   16794:	00078863          	beqz	a5,167a4 <__lo0bits+0xa8>
   16798:	00170713          	addi	a4,a4,1
   1679c:	00f52023          	sw	a5,0(a0)
   167a0:	f89ff06f          	j	16728 <__lo0bits+0x2c>
   167a4:	02000713          	li	a4,32
   167a8:	f81ff06f          	j	16728 <__lo0bits+0x2c>

000167ac <__i2b>:
   167ac:	ff010113          	addi	sp,sp,-16
   167b0:	00812423          	sw	s0,8(sp)
   167b4:	00058413          	mv	s0,a1
   167b8:	00100593          	li	a1,1
   167bc:	00112623          	sw	ra,12(sp)
   167c0:	bc5ff0ef          	jal	ra,16384 <_Balloc>
   167c4:	00852a23          	sw	s0,20(a0)
   167c8:	00c12083          	lw	ra,12(sp)
   167cc:	00812403          	lw	s0,8(sp)
   167d0:	00100713          	li	a4,1
   167d4:	00e52823          	sw	a4,16(a0)
   167d8:	01010113          	addi	sp,sp,16
   167dc:	00008067          	ret

000167e0 <__multiply>:
   167e0:	0105a703          	lw	a4,16(a1)
   167e4:	01062783          	lw	a5,16(a2)
   167e8:	fb010113          	addi	sp,sp,-80
   167ec:	04912223          	sw	s1,68(sp)
   167f0:	03412c23          	sw	s4,56(sp)
   167f4:	04112623          	sw	ra,76(sp)
   167f8:	04812423          	sw	s0,72(sp)
   167fc:	05212023          	sw	s2,64(sp)
   16800:	03312e23          	sw	s3,60(sp)
   16804:	03512a23          	sw	s5,52(sp)
   16808:	03612823          	sw	s6,48(sp)
   1680c:	03712623          	sw	s7,44(sp)
   16810:	03812423          	sw	s8,40(sp)
   16814:	03912223          	sw	s9,36(sp)
   16818:	03a12023          	sw	s10,32(sp)
   1681c:	01b12e23          	sw	s11,28(sp)
   16820:	00058a13          	mv	s4,a1
   16824:	00060493          	mv	s1,a2
   16828:	00f75663          	ble	a5,a4,16834 <__multiply+0x54>
   1682c:	00060a13          	mv	s4,a2
   16830:	00058493          	mv	s1,a1
   16834:	010a2903          	lw	s2,16(s4)
   16838:	0104a983          	lw	s3,16(s1)
   1683c:	008a2783          	lw	a5,8(s4)
   16840:	004a2583          	lw	a1,4(s4)
   16844:	01390c33          	add	s8,s2,s3
   16848:	0187d463          	ble	s8,a5,16850 <__multiply+0x70>
   1684c:	00158593          	addi	a1,a1,1
   16850:	b35ff0ef          	jal	ra,16384 <_Balloc>
   16854:	01450b93          	addi	s7,a0,20
   16858:	002c1c93          	slli	s9,s8,0x2
   1685c:	00050d13          	mv	s10,a0
   16860:	019b8cb3          	add	s9,s7,s9
   16864:	000b8793          	mv	a5,s7
   16868:	0997e463          	bltu	a5,s9,168f0 <__multiply+0x110>
   1686c:	014a0a13          	addi	s4,s4,20
   16870:	00291913          	slli	s2,s2,0x2
   16874:	012a07b3          	add	a5,s4,s2
   16878:	01448493          	addi	s1,s1,20
   1687c:	00299993          	slli	s3,s3,0x2
   16880:	00f12023          	sw	a5,0(sp)
   16884:	00010ab7          	lui	s5,0x10
   16888:	013487b3          	add	a5,s1,s3
   1688c:	00f12223          	sw	a5,4(sp)
   16890:	fffa8a93          	addi	s5,s5,-1 # ffff <main-0x75>
   16894:	00412783          	lw	a5,4(sp)
   16898:	06f4e263          	bltu	s1,a5,168fc <__multiply+0x11c>
   1689c:	01805863          	blez	s8,168ac <__multiply+0xcc>
   168a0:	ffcc8c93          	addi	s9,s9,-4
   168a4:	000ca783          	lw	a5,0(s9)
   168a8:	16078a63          	beqz	a5,16a1c <__multiply+0x23c>
   168ac:	04c12083          	lw	ra,76(sp)
   168b0:	04812403          	lw	s0,72(sp)
   168b4:	018d2823          	sw	s8,16(s10)
   168b8:	000d0513          	mv	a0,s10
   168bc:	04412483          	lw	s1,68(sp)
   168c0:	04012903          	lw	s2,64(sp)
   168c4:	03c12983          	lw	s3,60(sp)
   168c8:	03812a03          	lw	s4,56(sp)
   168cc:	03412a83          	lw	s5,52(sp)
   168d0:	03012b03          	lw	s6,48(sp)
   168d4:	02c12b83          	lw	s7,44(sp)
   168d8:	02812c03          	lw	s8,40(sp)
   168dc:	02412c83          	lw	s9,36(sp)
   168e0:	02012d03          	lw	s10,32(sp)
   168e4:	01c12d83          	lw	s11,28(sp)
   168e8:	05010113          	addi	sp,sp,80
   168ec:	00008067          	ret
   168f0:	0007a023          	sw	zero,0(a5)
   168f4:	00478793          	addi	a5,a5,4
   168f8:	f71ff06f          	j	16868 <__multiply+0x88>
   168fc:	0004a783          	lw	a5,0(s1)
   16900:	0157f7b3          	and	a5,a5,s5
   16904:	08078463          	beqz	a5,1698c <__multiply+0x1ac>
   16908:	000b8d93          	mv	s11,s7
   1690c:	000a0993          	mv	s3,s4
   16910:	00000913          	li	s2,0
   16914:	0009a603          	lw	a2,0(s3)
   16918:	00078593          	mv	a1,a5
   1691c:	000da403          	lw	s0,0(s11)
   16920:	01567533          	and	a0,a2,s5
   16924:	00f12423          	sw	a5,8(sp)
   16928:	00c12623          	sw	a2,12(sp)
   1692c:	4810a0ef          	jal	ra,215ac <__mulsi3>
   16930:	00812783          	lw	a5,8(sp)
   16934:	00c12603          	lw	a2,12(sp)
   16938:	01547b33          	and	s6,s0,s5
   1693c:	01650b33          	add	s6,a0,s6
   16940:	00078593          	mv	a1,a5
   16944:	01065513          	srli	a0,a2,0x10
   16948:	4650a0ef          	jal	ra,215ac <__mulsi3>
   1694c:	012b0b33          	add	s6,s6,s2
   16950:	01045413          	srli	s0,s0,0x10
   16954:	00850533          	add	a0,a0,s0
   16958:	010b5413          	srli	s0,s6,0x10
   1695c:	00850533          	add	a0,a0,s0
   16960:	01055913          	srli	s2,a0,0x10
   16964:	015b7b33          	and	s6,s6,s5
   16968:	01051513          	slli	a0,a0,0x10
   1696c:	00012703          	lw	a4,0(sp)
   16970:	004d8d93          	addi	s11,s11,4
   16974:	01656533          	or	a0,a0,s6
   16978:	00498993          	addi	s3,s3,4
   1697c:	feadae23          	sw	a0,-4(s11)
   16980:	00812783          	lw	a5,8(sp)
   16984:	f8e9e8e3          	bltu	s3,a4,16914 <__multiply+0x134>
   16988:	012da023          	sw	s2,0(s11)
   1698c:	0024d903          	lhu	s2,2(s1)
   16990:	08090063          	beqz	s2,16a10 <__multiply+0x230>
   16994:	000ba403          	lw	s0,0(s7)
   16998:	000b8d93          	mv	s11,s7
   1699c:	000a0993          	mv	s3,s4
   169a0:	00000693          	li	a3,0
   169a4:	0009a503          	lw	a0,0(s3)
   169a8:	00090593          	mv	a1,s2
   169ac:	00d12423          	sw	a3,8(sp)
   169b0:	01557533          	and	a0,a0,s5
   169b4:	3f90a0ef          	jal	ra,215ac <__mulsi3>
   169b8:	002ddb03          	lhu	s6,2(s11)
   169bc:	00812683          	lw	a3,8(sp)
   169c0:	01547433          	and	s0,s0,s5
   169c4:	01650b33          	add	s6,a0,s6
   169c8:	00db0b33          	add	s6,s6,a3
   169cc:	010b1513          	slli	a0,s6,0x10
   169d0:	00856433          	or	s0,a0,s0
   169d4:	004d8d93          	addi	s11,s11,4
   169d8:	fe8dae23          	sw	s0,-4(s11)
   169dc:	00498993          	addi	s3,s3,4
   169e0:	ffe9d503          	lhu	a0,-2(s3)
   169e4:	00090593          	mv	a1,s2
   169e8:	010b5b13          	srli	s6,s6,0x10
   169ec:	3c10a0ef          	jal	ra,215ac <__mulsi3>
   169f0:	000da403          	lw	s0,0(s11)
   169f4:	00012783          	lw	a5,0(sp)
   169f8:	01547433          	and	s0,s0,s5
   169fc:	00850433          	add	s0,a0,s0
   16a00:	01640433          	add	s0,s0,s6
   16a04:	01045693          	srli	a3,s0,0x10
   16a08:	f8f9eee3          	bltu	s3,a5,169a4 <__multiply+0x1c4>
   16a0c:	008da023          	sw	s0,0(s11)
   16a10:	00448493          	addi	s1,s1,4
   16a14:	004b8b93          	addi	s7,s7,4
   16a18:	e7dff06f          	j	16894 <__multiply+0xb4>
   16a1c:	fffc0c13          	addi	s8,s8,-1
   16a20:	e7dff06f          	j	1689c <__multiply+0xbc>

00016a24 <__pow5mult>:
   16a24:	fe010113          	addi	sp,sp,-32
   16a28:	00912a23          	sw	s1,20(sp)
   16a2c:	01212823          	sw	s2,16(sp)
   16a30:	01312623          	sw	s3,12(sp)
   16a34:	00112e23          	sw	ra,28(sp)
   16a38:	00812c23          	sw	s0,24(sp)
   16a3c:	01412423          	sw	s4,8(sp)
   16a40:	00367793          	andi	a5,a2,3
   16a44:	00050913          	mv	s2,a0
   16a48:	00060493          	mv	s1,a2
   16a4c:	00058993          	mv	s3,a1
   16a50:	02078463          	beqz	a5,16a78 <__pow5mult+0x54>
   16a54:	fff78793          	addi	a5,a5,-1
   16a58:	00022737          	lui	a4,0x22
   16a5c:	bc870713          	addi	a4,a4,-1080 # 21bc8 <p05.3200>
   16a60:	00279793          	slli	a5,a5,0x2
   16a64:	00f707b3          	add	a5,a4,a5
   16a68:	0007a603          	lw	a2,0(a5)
   16a6c:	00000693          	li	a3,0
   16a70:	9e1ff0ef          	jal	ra,16450 <__multadd>
   16a74:	00050993          	mv	s3,a0
   16a78:	4024d493          	srai	s1,s1,0x2
   16a7c:	08048063          	beqz	s1,16afc <__pow5mult+0xd8>
   16a80:	04892403          	lw	s0,72(s2)
   16a84:	00041e63          	bnez	s0,16aa0 <__pow5mult+0x7c>
   16a88:	27100593          	li	a1,625
   16a8c:	00090513          	mv	a0,s2
   16a90:	d1dff0ef          	jal	ra,167ac <__i2b>
   16a94:	04a92423          	sw	a0,72(s2)
   16a98:	00050413          	mv	s0,a0
   16a9c:	00052023          	sw	zero,0(a0)
   16aa0:	0014f793          	andi	a5,s1,1
   16aa4:	02078463          	beqz	a5,16acc <__pow5mult+0xa8>
   16aa8:	00098593          	mv	a1,s3
   16aac:	00040613          	mv	a2,s0
   16ab0:	00090513          	mv	a0,s2
   16ab4:	d2dff0ef          	jal	ra,167e0 <__multiply>
   16ab8:	00050a13          	mv	s4,a0
   16abc:	00098593          	mv	a1,s3
   16ac0:	00090513          	mv	a0,s2
   16ac4:	969ff0ef          	jal	ra,1642c <_Bfree>
   16ac8:	000a0993          	mv	s3,s4
   16acc:	4014d493          	srai	s1,s1,0x1
   16ad0:	02048663          	beqz	s1,16afc <__pow5mult+0xd8>
   16ad4:	00042503          	lw	a0,0(s0)
   16ad8:	00051e63          	bnez	a0,16af4 <__pow5mult+0xd0>
   16adc:	00040613          	mv	a2,s0
   16ae0:	00040593          	mv	a1,s0
   16ae4:	00090513          	mv	a0,s2
   16ae8:	cf9ff0ef          	jal	ra,167e0 <__multiply>
   16aec:	00a42023          	sw	a0,0(s0)
   16af0:	00052023          	sw	zero,0(a0)
   16af4:	00050413          	mv	s0,a0
   16af8:	fa9ff06f          	j	16aa0 <__pow5mult+0x7c>
   16afc:	01c12083          	lw	ra,28(sp)
   16b00:	01812403          	lw	s0,24(sp)
   16b04:	00098513          	mv	a0,s3
   16b08:	01412483          	lw	s1,20(sp)
   16b0c:	01012903          	lw	s2,16(sp)
   16b10:	00c12983          	lw	s3,12(sp)
   16b14:	00812a03          	lw	s4,8(sp)
   16b18:	02010113          	addi	sp,sp,32
   16b1c:	00008067          	ret

00016b20 <__lshift>:
   16b20:	fd010113          	addi	sp,sp,-48
   16b24:	02912223          	sw	s1,36(sp)
   16b28:	00058493          	mv	s1,a1
   16b2c:	01312e23          	sw	s3,28(sp)
   16b30:	0104a983          	lw	s3,16(s1)
   16b34:	02812423          	sw	s0,40(sp)
   16b38:	0045a583          	lw	a1,4(a1)
   16b3c:	40565413          	srai	s0,a2,0x5
   16b40:	0084a783          	lw	a5,8(s1)
   16b44:	013409b3          	add	s3,s0,s3
   16b48:	03212023          	sw	s2,32(sp)
   16b4c:	01512a23          	sw	s5,20(sp)
   16b50:	02112623          	sw	ra,44(sp)
   16b54:	01412c23          	sw	s4,24(sp)
   16b58:	00050a93          	mv	s5,a0
   16b5c:	00198913          	addi	s2,s3,1
   16b60:	0d27c663          	blt	a5,s2,16c2c <__lshift+0x10c>
   16b64:	000a8513          	mv	a0,s5
   16b68:	00c12623          	sw	a2,12(sp)
   16b6c:	819ff0ef          	jal	ra,16384 <_Balloc>
   16b70:	00c12603          	lw	a2,12(sp)
   16b74:	01450793          	addi	a5,a0,20
   16b78:	00050a13          	mv	s4,a0
   16b7c:	00078693          	mv	a3,a5
   16b80:	00000713          	li	a4,0
   16b84:	00468693          	addi	a3,a3,4
   16b88:	0a874863          	blt	a4,s0,16c38 <__lshift+0x118>
   16b8c:	00045463          	bgez	s0,16b94 <__lshift+0x74>
   16b90:	00000413          	li	s0,0
   16b94:	0104a683          	lw	a3,16(s1)
   16b98:	00241413          	slli	s0,s0,0x2
   16b9c:	00878733          	add	a4,a5,s0
   16ba0:	00269693          	slli	a3,a3,0x2
   16ba4:	01448793          	addi	a5,s1,20
   16ba8:	01f67613          	andi	a2,a2,31
   16bac:	00d786b3          	add	a3,a5,a3
   16bb0:	08060a63          	beqz	a2,16c44 <__lshift+0x124>
   16bb4:	02000813          	li	a6,32
   16bb8:	40c80833          	sub	a6,a6,a2
   16bbc:	00000593          	li	a1,0
   16bc0:	0007a503          	lw	a0,0(a5)
   16bc4:	00470713          	addi	a4,a4,4
   16bc8:	00478793          	addi	a5,a5,4
   16bcc:	00c51533          	sll	a0,a0,a2
   16bd0:	00b565b3          	or	a1,a0,a1
   16bd4:	feb72e23          	sw	a1,-4(a4)
   16bd8:	ffc7a583          	lw	a1,-4(a5)
   16bdc:	0105d5b3          	srl	a1,a1,a6
   16be0:	fed7e0e3          	bltu	a5,a3,16bc0 <__lshift+0xa0>
   16be4:	00b72023          	sw	a1,0(a4)
   16be8:	00058463          	beqz	a1,16bf0 <__lshift+0xd0>
   16bec:	00298913          	addi	s2,s3,2
   16bf0:	fff90913          	addi	s2,s2,-1
   16bf4:	012a2823          	sw	s2,16(s4)
   16bf8:	000a8513          	mv	a0,s5
   16bfc:	00048593          	mv	a1,s1
   16c00:	82dff0ef          	jal	ra,1642c <_Bfree>
   16c04:	02c12083          	lw	ra,44(sp)
   16c08:	02812403          	lw	s0,40(sp)
   16c0c:	000a0513          	mv	a0,s4
   16c10:	02412483          	lw	s1,36(sp)
   16c14:	02012903          	lw	s2,32(sp)
   16c18:	01c12983          	lw	s3,28(sp)
   16c1c:	01812a03          	lw	s4,24(sp)
   16c20:	01412a83          	lw	s5,20(sp)
   16c24:	03010113          	addi	sp,sp,48
   16c28:	00008067          	ret
   16c2c:	00158593          	addi	a1,a1,1
   16c30:	00179793          	slli	a5,a5,0x1
   16c34:	f2dff06f          	j	16b60 <__lshift+0x40>
   16c38:	fe06ae23          	sw	zero,-4(a3)
   16c3c:	00170713          	addi	a4,a4,1
   16c40:	f45ff06f          	j	16b84 <__lshift+0x64>
   16c44:	00478793          	addi	a5,a5,4
   16c48:	ffc7a603          	lw	a2,-4(a5)
   16c4c:	00470713          	addi	a4,a4,4
   16c50:	fec72e23          	sw	a2,-4(a4)
   16c54:	fed7e8e3          	bltu	a5,a3,16c44 <__lshift+0x124>
   16c58:	f99ff06f          	j	16bf0 <__lshift+0xd0>

00016c5c <__mcmp>:
   16c5c:	01052783          	lw	a5,16(a0)
   16c60:	0105a703          	lw	a4,16(a1)
   16c64:	40e787b3          	sub	a5,a5,a4
   16c68:	02079c63          	bnez	a5,16ca0 <__mcmp+0x44>
   16c6c:	00271713          	slli	a4,a4,0x2
   16c70:	01450513          	addi	a0,a0,20
   16c74:	01458593          	addi	a1,a1,20
   16c78:	00e506b3          	add	a3,a0,a4
   16c7c:	00e585b3          	add	a1,a1,a4
   16c80:	ffc68693          	addi	a3,a3,-4
   16c84:	ffc58593          	addi	a1,a1,-4
   16c88:	0006a603          	lw	a2,0(a3)
   16c8c:	0005a703          	lw	a4,0(a1)
   16c90:	00e60c63          	beq	a2,a4,16ca8 <__mcmp+0x4c>
   16c94:	fff00793          	li	a5,-1
   16c98:	00e66463          	bltu	a2,a4,16ca0 <__mcmp+0x44>
   16c9c:	00100793          	li	a5,1
   16ca0:	00078513          	mv	a0,a5
   16ca4:	00008067          	ret
   16ca8:	fcd56ce3          	bltu	a0,a3,16c80 <__mcmp+0x24>
   16cac:	ff5ff06f          	j	16ca0 <__mcmp+0x44>

00016cb0 <__mdiff>:
   16cb0:	fe010113          	addi	sp,sp,-32
   16cb4:	00912a23          	sw	s1,20(sp)
   16cb8:	00058493          	mv	s1,a1
   16cbc:	01312623          	sw	s3,12(sp)
   16cc0:	00060593          	mv	a1,a2
   16cc4:	00050993          	mv	s3,a0
   16cc8:	00048513          	mv	a0,s1
   16ccc:	00812c23          	sw	s0,24(sp)
   16cd0:	00112e23          	sw	ra,28(sp)
   16cd4:	01212823          	sw	s2,16(sp)
   16cd8:	00060413          	mv	s0,a2
   16cdc:	f81ff0ef          	jal	ra,16c5c <__mcmp>
   16ce0:	02051c63          	bnez	a0,16d18 <__mdiff+0x68>
   16ce4:	00000593          	li	a1,0
   16ce8:	00098513          	mv	a0,s3
   16cec:	e98ff0ef          	jal	ra,16384 <_Balloc>
   16cf0:	00100793          	li	a5,1
   16cf4:	00f52823          	sw	a5,16(a0)
   16cf8:	00052a23          	sw	zero,20(a0)
   16cfc:	01c12083          	lw	ra,28(sp)
   16d00:	01812403          	lw	s0,24(sp)
   16d04:	01412483          	lw	s1,20(sp)
   16d08:	01012903          	lw	s2,16(sp)
   16d0c:	00c12983          	lw	s3,12(sp)
   16d10:	02010113          	addi	sp,sp,32
   16d14:	00008067          	ret
   16d18:	00100913          	li	s2,1
   16d1c:	00054a63          	bltz	a0,16d30 <__mdiff+0x80>
   16d20:	00040793          	mv	a5,s0
   16d24:	00000913          	li	s2,0
   16d28:	00048413          	mv	s0,s1
   16d2c:	00078493          	mv	s1,a5
   16d30:	00442583          	lw	a1,4(s0)
   16d34:	00098513          	mv	a0,s3
   16d38:	e4cff0ef          	jal	ra,16384 <_Balloc>
   16d3c:	01042303          	lw	t1,16(s0)
   16d40:	0104a883          	lw	a7,16(s1)
   16d44:	01440613          	addi	a2,s0,20
   16d48:	00231e13          	slli	t3,t1,0x2
   16d4c:	01448813          	addi	a6,s1,20
   16d50:	00289893          	slli	a7,a7,0x2
   16d54:	00010eb7          	lui	t4,0x10
   16d58:	01252623          	sw	s2,12(a0)
   16d5c:	01c60e33          	add	t3,a2,t3
   16d60:	011808b3          	add	a7,a6,a7
   16d64:	01450693          	addi	a3,a0,20
   16d68:	00000f13          	li	t5,0
   16d6c:	fffe8e93          	addi	t4,t4,-1 # ffff <main-0x75>
   16d70:	00062703          	lw	a4,0(a2)
   16d74:	00082f83          	lw	t6,0(a6)
   16d78:	00468693          	addi	a3,a3,4
   16d7c:	01d775b3          	and	a1,a4,t4
   16d80:	01dff7b3          	and	a5,t6,t4
   16d84:	01e585b3          	add	a1,a1,t5
   16d88:	40f585b3          	sub	a1,a1,a5
   16d8c:	010fdf93          	srli	t6,t6,0x10
   16d90:	01075793          	srli	a5,a4,0x10
   16d94:	41f787b3          	sub	a5,a5,t6
   16d98:	4105d713          	srai	a4,a1,0x10
   16d9c:	00e787b3          	add	a5,a5,a4
   16da0:	4107df13          	srai	t5,a5,0x10
   16da4:	01d5f5b3          	and	a1,a1,t4
   16da8:	01079793          	slli	a5,a5,0x10
   16dac:	00b7e7b3          	or	a5,a5,a1
   16db0:	00480813          	addi	a6,a6,4
   16db4:	fef6ae23          	sw	a5,-4(a3)
   16db8:	00460613          	addi	a2,a2,4
   16dbc:	fb186ae3          	bltu	a6,a7,16d70 <__mdiff+0xc0>
   16dc0:	000105b7          	lui	a1,0x10
   16dc4:	fff58593          	addi	a1,a1,-1 # ffff <main-0x75>
   16dc8:	01c66c63          	bltu	a2,t3,16de0 <__mdiff+0x130>
   16dcc:	ffc68693          	addi	a3,a3,-4
   16dd0:	0006a783          	lw	a5,0(a3)
   16dd4:	04078263          	beqz	a5,16e18 <__mdiff+0x168>
   16dd8:	00652823          	sw	t1,16(a0)
   16ddc:	f21ff06f          	j	16cfc <__mdiff+0x4c>
   16de0:	00062783          	lw	a5,0(a2)
   16de4:	00468693          	addi	a3,a3,4
   16de8:	00460613          	addi	a2,a2,4
   16dec:	00b7f733          	and	a4,a5,a1
   16df0:	01e70733          	add	a4,a4,t5
   16df4:	41075813          	srai	a6,a4,0x10
   16df8:	0107d793          	srli	a5,a5,0x10
   16dfc:	010787b3          	add	a5,a5,a6
   16e00:	4107df13          	srai	t5,a5,0x10
   16e04:	00b77733          	and	a4,a4,a1
   16e08:	01079793          	slli	a5,a5,0x10
   16e0c:	00e7e7b3          	or	a5,a5,a4
   16e10:	fef6ae23          	sw	a5,-4(a3)
   16e14:	fb5ff06f          	j	16dc8 <__mdiff+0x118>
   16e18:	fff30313          	addi	t1,t1,-1
   16e1c:	fb1ff06f          	j	16dcc <__mdiff+0x11c>

00016e20 <__ulp>:
   16e20:	7ff007b7          	lui	a5,0x7ff00
   16e24:	00b7f5b3          	and	a1,a5,a1
   16e28:	fcc007b7          	lui	a5,0xfcc00
   16e2c:	00f585b3          	add	a1,a1,a5
   16e30:	00b05863          	blez	a1,16e40 <__ulp+0x20>
   16e34:	00000793          	li	a5,0
   16e38:	00078513          	mv	a0,a5
   16e3c:	00008067          	ret
   16e40:	40b005b3          	neg	a1,a1
   16e44:	4145d793          	srai	a5,a1,0x14
   16e48:	01300713          	li	a4,19
   16e4c:	00f74863          	blt	a4,a5,16e5c <__ulp+0x3c>
   16e50:	000805b7          	lui	a1,0x80
   16e54:	40f5d5b3          	sra	a1,a1,a5
   16e58:	fddff06f          	j	16e34 <__ulp+0x14>
   16e5c:	fec78793          	addi	a5,a5,-20 # fcbfffec <__global_pointer$+0xfcbdb88c>
   16e60:	01e00693          	li	a3,30
   16e64:	00000593          	li	a1,0
   16e68:	00100713          	li	a4,1
   16e6c:	00f6c663          	blt	a3,a5,16e78 <__ulp+0x58>
   16e70:	fff7c793          	not	a5,a5
   16e74:	00f71733          	sll	a4,a4,a5
   16e78:	00070793          	mv	a5,a4
   16e7c:	fbdff06f          	j	16e38 <__ulp+0x18>

00016e80 <__b2d>:
   16e80:	fd010113          	addi	sp,sp,-48
   16e84:	02912223          	sw	s1,36(sp)
   16e88:	01052483          	lw	s1,16(a0)
   16e8c:	01312e23          	sw	s3,28(sp)
   16e90:	01450993          	addi	s3,a0,20
   16e94:	00249493          	slli	s1,s1,0x2
   16e98:	009984b3          	add	s1,s3,s1
   16e9c:	02812423          	sw	s0,40(sp)
   16ea0:	ffc4a403          	lw	s0,-4(s1)
   16ea4:	03212023          	sw	s2,32(sp)
   16ea8:	00b12623          	sw	a1,12(sp)
   16eac:	00040513          	mv	a0,s0
   16eb0:	02112623          	sw	ra,44(sp)
   16eb4:	fd4ff0ef          	jal	ra,16688 <__hi0bits>
   16eb8:	00c12583          	lw	a1,12(sp)
   16ebc:	02000793          	li	a5,32
   16ec0:	40a787b3          	sub	a5,a5,a0
   16ec4:	00f5a023          	sw	a5,0(a1) # 80000 <__global_pointer$+0x5b8a0>
   16ec8:	00a00793          	li	a5,10
   16ecc:	ffc48913          	addi	s2,s1,-4
   16ed0:	04a7cc63          	blt	a5,a0,16f28 <__b2d+0xa8>
   16ed4:	00b00793          	li	a5,11
   16ed8:	40a787b3          	sub	a5,a5,a0
   16edc:	3ff00737          	lui	a4,0x3ff00
   16ee0:	00f456b3          	srl	a3,s0,a5
   16ee4:	00e6e6b3          	or	a3,a3,a4
   16ee8:	00000713          	li	a4,0
   16eec:	0129f463          	bleu	s2,s3,16ef4 <__b2d+0x74>
   16ef0:	ff84a703          	lw	a4,-8(s1)
   16ef4:	01550513          	addi	a0,a0,21
   16ef8:	00a41533          	sll	a0,s0,a0
   16efc:	00f757b3          	srl	a5,a4,a5
   16f00:	00f567b3          	or	a5,a0,a5
   16f04:	02c12083          	lw	ra,44(sp)
   16f08:	02812403          	lw	s0,40(sp)
   16f0c:	02412483          	lw	s1,36(sp)
   16f10:	02012903          	lw	s2,32(sp)
   16f14:	01c12983          	lw	s3,28(sp)
   16f18:	00078513          	mv	a0,a5
   16f1c:	00068593          	mv	a1,a3
   16f20:	03010113          	addi	sp,sp,48
   16f24:	00008067          	ret
   16f28:	00000793          	li	a5,0
   16f2c:	0129f663          	bleu	s2,s3,16f38 <__b2d+0xb8>
   16f30:	ff84a783          	lw	a5,-8(s1)
   16f34:	ff848913          	addi	s2,s1,-8
   16f38:	ff550513          	addi	a0,a0,-11
   16f3c:	02050e63          	beqz	a0,16f78 <__b2d+0xf8>
   16f40:	02000713          	li	a4,32
   16f44:	40a70633          	sub	a2,a4,a0
   16f48:	00a41433          	sll	s0,s0,a0
   16f4c:	3ff00737          	lui	a4,0x3ff00
   16f50:	00e46433          	or	s0,s0,a4
   16f54:	00c7d6b3          	srl	a3,a5,a2
   16f58:	00d466b3          	or	a3,s0,a3
   16f5c:	00000713          	li	a4,0
   16f60:	0129f463          	bleu	s2,s3,16f68 <__b2d+0xe8>
   16f64:	ffc92703          	lw	a4,-4(s2)
   16f68:	00a797b3          	sll	a5,a5,a0
   16f6c:	00c75733          	srl	a4,a4,a2
   16f70:	00e7e7b3          	or	a5,a5,a4
   16f74:	f91ff06f          	j	16f04 <__b2d+0x84>
   16f78:	3ff006b7          	lui	a3,0x3ff00
   16f7c:	00d466b3          	or	a3,s0,a3
   16f80:	f85ff06f          	j	16f04 <__b2d+0x84>

00016f84 <__d2b>:
   16f84:	fd010113          	addi	sp,sp,-48
   16f88:	02812423          	sw	s0,40(sp)
   16f8c:	00058413          	mv	s0,a1
   16f90:	00100593          	li	a1,1
   16f94:	02912223          	sw	s1,36(sp)
   16f98:	03212023          	sw	s2,32(sp)
   16f9c:	00060493          	mv	s1,a2
   16fa0:	01312e23          	sw	s3,28(sp)
   16fa4:	01412c23          	sw	s4,24(sp)
   16fa8:	00070913          	mv	s2,a4
   16fac:	02112623          	sw	ra,44(sp)
   16fb0:	00068a13          	mv	s4,a3
   16fb4:	bd0ff0ef          	jal	ra,16384 <_Balloc>
   16fb8:	00100737          	lui	a4,0x100
   16fbc:	fff70793          	addi	a5,a4,-1 # fffff <__global_pointer$+0xdb89f>
   16fc0:	0097f7b3          	and	a5,a5,s1
   16fc4:	0144d493          	srli	s1,s1,0x14
   16fc8:	7ff4f493          	andi	s1,s1,2047
   16fcc:	00050993          	mv	s3,a0
   16fd0:	08049a63          	bnez	s1,17064 <__d2b+0xe0>
   16fd4:	00f12623          	sw	a5,12(sp)
   16fd8:	08040e63          	beqz	s0,17074 <__d2b+0xf0>
   16fdc:	00810513          	addi	a0,sp,8
   16fe0:	00812423          	sw	s0,8(sp)
   16fe4:	f18ff0ef          	jal	ra,166fc <__lo0bits>
   16fe8:	00812683          	lw	a3,8(sp)
   16fec:	08050063          	beqz	a0,1706c <__d2b+0xe8>
   16ff0:	00c12703          	lw	a4,12(sp)
   16ff4:	02000793          	li	a5,32
   16ff8:	40a787b3          	sub	a5,a5,a0
   16ffc:	00f717b3          	sll	a5,a4,a5
   17000:	00d7e7b3          	or	a5,a5,a3
   17004:	00a75733          	srl	a4,a4,a0
   17008:	00f9aa23          	sw	a5,20(s3)
   1700c:	00e12623          	sw	a4,12(sp)
   17010:	00c12403          	lw	s0,12(sp)
   17014:	0089ac23          	sw	s0,24(s3)
   17018:	00803433          	snez	s0,s0
   1701c:	00140413          	addi	s0,s0,1
   17020:	0089a823          	sw	s0,16(s3)
   17024:	06048a63          	beqz	s1,17098 <__d2b+0x114>
   17028:	bcd48493          	addi	s1,s1,-1075
   1702c:	00a484b3          	add	s1,s1,a0
   17030:	03500793          	li	a5,53
   17034:	009a2023          	sw	s1,0(s4)
   17038:	40a78533          	sub	a0,a5,a0
   1703c:	00a92023          	sw	a0,0(s2)
   17040:	02c12083          	lw	ra,44(sp)
   17044:	02812403          	lw	s0,40(sp)
   17048:	00098513          	mv	a0,s3
   1704c:	02412483          	lw	s1,36(sp)
   17050:	02012903          	lw	s2,32(sp)
   17054:	01c12983          	lw	s3,28(sp)
   17058:	01812a03          	lw	s4,24(sp)
   1705c:	03010113          	addi	sp,sp,48
   17060:	00008067          	ret
   17064:	00e7e7b3          	or	a5,a5,a4
   17068:	f6dff06f          	j	16fd4 <__d2b+0x50>
   1706c:	00d9aa23          	sw	a3,20(s3)
   17070:	fa1ff06f          	j	17010 <__d2b+0x8c>
   17074:	00c10513          	addi	a0,sp,12
   17078:	e84ff0ef          	jal	ra,166fc <__lo0bits>
   1707c:	00c12783          	lw	a5,12(sp)
   17080:	02050513          	addi	a0,a0,32
   17084:	00100413          	li	s0,1
   17088:	00f9aa23          	sw	a5,20(s3)
   1708c:	00100793          	li	a5,1
   17090:	00f9a823          	sw	a5,16(s3)
   17094:	f91ff06f          	j	17024 <__d2b+0xa0>
   17098:	00241793          	slli	a5,s0,0x2
   1709c:	bce50513          	addi	a0,a0,-1074
   170a0:	00f987b3          	add	a5,s3,a5
   170a4:	00aa2023          	sw	a0,0(s4)
   170a8:	0107a503          	lw	a0,16(a5)
   170ac:	00541413          	slli	s0,s0,0x5
   170b0:	dd8ff0ef          	jal	ra,16688 <__hi0bits>
   170b4:	40a40433          	sub	s0,s0,a0
   170b8:	00892023          	sw	s0,0(s2)
   170bc:	f85ff06f          	j	17040 <__d2b+0xbc>

000170c0 <__ratio>:
   170c0:	fd010113          	addi	sp,sp,-48
   170c4:	01412c23          	sw	s4,24(sp)
   170c8:	00058a13          	mv	s4,a1
   170cc:	00810593          	addi	a1,sp,8
   170d0:	02112623          	sw	ra,44(sp)
   170d4:	02812423          	sw	s0,40(sp)
   170d8:	02912223          	sw	s1,36(sp)
   170dc:	01312e23          	sw	s3,28(sp)
   170e0:	01512a23          	sw	s5,20(sp)
   170e4:	01612823          	sw	s6,16(sp)
   170e8:	03212023          	sw	s2,32(sp)
   170ec:	00050b13          	mv	s6,a0
   170f0:	d91ff0ef          	jal	ra,16e80 <__b2d>
   170f4:	00050413          	mv	s0,a0
   170f8:	00058993          	mv	s3,a1
   170fc:	00058493          	mv	s1,a1
   17100:	000a0513          	mv	a0,s4
   17104:	00c10593          	addi	a1,sp,12
   17108:	d79ff0ef          	jal	ra,16e80 <__b2d>
   1710c:	00050a93          	mv	s5,a0
   17110:	010b2783          	lw	a5,16(s6)
   17114:	010a2503          	lw	a0,16(s4)
   17118:	00c12703          	lw	a4,12(sp)
   1711c:	40a787b3          	sub	a5,a5,a0
   17120:	00812503          	lw	a0,8(sp)
   17124:	00579793          	slli	a5,a5,0x5
   17128:	40e50533          	sub	a0,a0,a4
   1712c:	00a78533          	add	a0,a5,a0
   17130:	04a05863          	blez	a0,17180 <__ratio+0xc0>
   17134:	01451513          	slli	a0,a0,0x14
   17138:	00058693          	mv	a3,a1
   1713c:	013504b3          	add	s1,a0,s3
   17140:	00068793          	mv	a5,a3
   17144:	000a8613          	mv	a2,s5
   17148:	00040513          	mv	a0,s0
   1714c:	00048593          	mv	a1,s1
   17150:	00078693          	mv	a3,a5
   17154:	014060ef          	jal	ra,1d168 <__divdf3>
   17158:	02c12083          	lw	ra,44(sp)
   1715c:	02812403          	lw	s0,40(sp)
   17160:	02412483          	lw	s1,36(sp)
   17164:	02012903          	lw	s2,32(sp)
   17168:	01c12983          	lw	s3,28(sp)
   1716c:	01812a03          	lw	s4,24(sp)
   17170:	01412a83          	lw	s5,20(sp)
   17174:	01012b03          	lw	s6,16(sp)
   17178:	03010113          	addi	sp,sp,48
   1717c:	00008067          	ret
   17180:	00058913          	mv	s2,a1
   17184:	fff005b7          	lui	a1,0xfff00
   17188:	4240a0ef          	jal	ra,215ac <__mulsi3>
   1718c:	012506b3          	add	a3,a0,s2
   17190:	fb1ff06f          	j	17140 <__ratio+0x80>

00017194 <_mprec_log10>:
   17194:	ff010113          	addi	sp,sp,-16
   17198:	00812423          	sw	s0,8(sp)
   1719c:	00112623          	sw	ra,12(sp)
   171a0:	01212223          	sw	s2,4(sp)
   171a4:	01312023          	sw	s3,0(sp)
   171a8:	01700793          	li	a5,23
   171ac:	00050413          	mv	s0,a0
   171b0:	02a7ca63          	blt	a5,a0,171e4 <_mprec_log10+0x50>
   171b4:	000227b7          	lui	a5,0x22
   171b8:	00351413          	slli	s0,a0,0x3
   171bc:	bc878793          	addi	a5,a5,-1080 # 21bc8 <p05.3200>
   171c0:	00878433          	add	s0,a5,s0
   171c4:	01042503          	lw	a0,16(s0)
   171c8:	01442583          	lw	a1,20(s0)
   171cc:	00c12083          	lw	ra,12(sp)
   171d0:	00812403          	lw	s0,8(sp)
   171d4:	00412903          	lw	s2,4(sp)
   171d8:	00012983          	lw	s3,0(sp)
   171dc:	01010113          	addi	sp,sp,16
   171e0:	00008067          	ret
   171e4:	000247b7          	lui	a5,0x24
   171e8:	f6078793          	addi	a5,a5,-160 # 23f60 <__TMC_END__+0x4>
   171ec:	0007a503          	lw	a0,0(a5)
   171f0:	0047a583          	lw	a1,4(a5)
   171f4:	000247b7          	lui	a5,0x24
   171f8:	f6878793          	addi	a5,a5,-152 # 23f68 <__TMC_END__+0xc>
   171fc:	0007a903          	lw	s2,0(a5)
   17200:	0047a983          	lw	s3,4(a5)
   17204:	00090613          	mv	a2,s2
   17208:	00098693          	mv	a3,s3
   1720c:	fff40413          	addi	s0,s0,-1
   17210:	764060ef          	jal	ra,1d974 <__muldf3>
   17214:	fe0418e3          	bnez	s0,17204 <_mprec_log10+0x70>
   17218:	fb5ff06f          	j	171cc <_mprec_log10+0x38>

0001721c <__copybits>:
   1721c:	fff58793          	addi	a5,a1,-1 # ffefffff <__global_pointer$+0xffedb89f>
   17220:	01062703          	lw	a4,16(a2)
   17224:	4057d793          	srai	a5,a5,0x5
   17228:	00178793          	addi	a5,a5,1
   1722c:	00279793          	slli	a5,a5,0x2
   17230:	01460693          	addi	a3,a2,20
   17234:	00271713          	slli	a4,a4,0x2
   17238:	00f507b3          	add	a5,a0,a5
   1723c:	00e68733          	add	a4,a3,a4
   17240:	00e6e663          	bltu	a3,a4,1724c <__copybits+0x30>
   17244:	00f56e63          	bltu	a0,a5,17260 <__copybits+0x44>
   17248:	00008067          	ret
   1724c:	00468693          	addi	a3,a3,4 # 3ff00004 <__global_pointer$+0x3fedb8a4>
   17250:	ffc6a603          	lw	a2,-4(a3)
   17254:	00450513          	addi	a0,a0,4
   17258:	fec52e23          	sw	a2,-4(a0)
   1725c:	fe5ff06f          	j	17240 <__copybits+0x24>
   17260:	00450513          	addi	a0,a0,4
   17264:	fe052e23          	sw	zero,-4(a0)
   17268:	fddff06f          	j	17244 <__copybits+0x28>

0001726c <__any_on>:
   1726c:	01052683          	lw	a3,16(a0)
   17270:	4055d793          	srai	a5,a1,0x5
   17274:	01450713          	addi	a4,a0,20
   17278:	04f6c063          	blt	a3,a5,172b8 <__any_on+0x4c>
   1727c:	02d7d463          	ble	a3,a5,172a4 <__any_on+0x38>
   17280:	01f5f593          	andi	a1,a1,31
   17284:	02058063          	beqz	a1,172a4 <__any_on+0x38>
   17288:	00279693          	slli	a3,a5,0x2
   1728c:	00d706b3          	add	a3,a4,a3
   17290:	0006a603          	lw	a2,0(a3)
   17294:	00100513          	li	a0,1
   17298:	00b656b3          	srl	a3,a2,a1
   1729c:	00b695b3          	sll	a1,a3,a1
   172a0:	02b61863          	bne	a2,a1,172d0 <__any_on+0x64>
   172a4:	00279793          	slli	a5,a5,0x2
   172a8:	00f707b3          	add	a5,a4,a5
   172ac:	00f76a63          	bltu	a4,a5,172c0 <__any_on+0x54>
   172b0:	00000513          	li	a0,0
   172b4:	00008067          	ret
   172b8:	00068793          	mv	a5,a3
   172bc:	fe9ff06f          	j	172a4 <__any_on+0x38>
   172c0:	ffc78793          	addi	a5,a5,-4
   172c4:	0007a683          	lw	a3,0(a5)
   172c8:	fe0682e3          	beqz	a3,172ac <__any_on+0x40>
   172cc:	00100513          	li	a0,1
   172d0:	00008067          	ret

000172d4 <_realloc_r>:
   172d4:	fc010113          	addi	sp,sp,-64
   172d8:	02812c23          	sw	s0,56(sp)
   172dc:	02112e23          	sw	ra,60(sp)
   172e0:	00058413          	mv	s0,a1
   172e4:	02912a23          	sw	s1,52(sp)
   172e8:	03212823          	sw	s2,48(sp)
   172ec:	03312623          	sw	s3,44(sp)
   172f0:	03412423          	sw	s4,40(sp)
   172f4:	03512223          	sw	s5,36(sp)
   172f8:	03612023          	sw	s6,32(sp)
   172fc:	01712e23          	sw	s7,28(sp)
   17300:	01812c23          	sw	s8,24(sp)
   17304:	00060593          	mv	a1,a2
   17308:	02041a63          	bnez	s0,1733c <_realloc_r+0x68>
   1730c:	03812403          	lw	s0,56(sp)
   17310:	03c12083          	lw	ra,60(sp)
   17314:	03412483          	lw	s1,52(sp)
   17318:	03012903          	lw	s2,48(sp)
   1731c:	02c12983          	lw	s3,44(sp)
   17320:	02812a03          	lw	s4,40(sp)
   17324:	02412a83          	lw	s5,36(sp)
   17328:	02012b03          	lw	s6,32(sp)
   1732c:	01c12b83          	lw	s7,28(sp)
   17330:	01812c03          	lw	s8,24(sp)
   17334:	04010113          	addi	sp,sp,64
   17338:	874f906f          	j	103ac <_malloc_r>
   1733c:	00050a93          	mv	s5,a0
   17340:	00c12623          	sw	a2,12(sp)
   17344:	f88f90ef          	jal	ra,10acc <__malloc_lock>
   17348:	00c12583          	lw	a1,12(sp)
   1734c:	ffc42683          	lw	a3,-4(s0)
   17350:	01600793          	li	a5,22
   17354:	00b58993          	addi	s3,a1,11
   17358:	ff840b93          	addi	s7,s0,-8
   1735c:	ffc6f913          	andi	s2,a3,-4
   17360:	0537f663          	bleu	s3,a5,173ac <_realloc_r+0xd8>
   17364:	ff89fb13          	andi	s6,s3,-8
   17368:	040b5463          	bgez	s6,173b0 <_realloc_r+0xdc>
   1736c:	00c00793          	li	a5,12
   17370:	00faa023          	sw	a5,0(s5)
   17374:	00000a13          	li	s4,0
   17378:	03c12083          	lw	ra,60(sp)
   1737c:	03812403          	lw	s0,56(sp)
   17380:	000a0513          	mv	a0,s4
   17384:	03412483          	lw	s1,52(sp)
   17388:	03012903          	lw	s2,48(sp)
   1738c:	02c12983          	lw	s3,44(sp)
   17390:	02812a03          	lw	s4,40(sp)
   17394:	02412a83          	lw	s5,36(sp)
   17398:	02012b03          	lw	s6,32(sp)
   1739c:	01c12b83          	lw	s7,28(sp)
   173a0:	01812c03          	lw	s8,24(sp)
   173a4:	04010113          	addi	sp,sp,64
   173a8:	00008067          	ret
   173ac:	01000b13          	li	s6,16
   173b0:	fabb6ee3          	bltu	s6,a1,1736c <_realloc_r+0x98>
   173b4:	45695c63          	ble	s6,s2,1780c <_realloc_r+0x538>
   173b8:	00024c37          	lui	s8,0x24
   173bc:	9e8c0713          	addi	a4,s8,-1560 # 239e8 <__malloc_av_>
   173c0:	00872603          	lw	a2,8(a4)
   173c4:	012b87b3          	add	a5,s7,s2
   173c8:	0047a703          	lw	a4,4(a5)
   173cc:	9e8c0c13          	addi	s8,s8,-1560
   173d0:	00f60c63          	beq	a2,a5,173e8 <_realloc_r+0x114>
   173d4:	ffe77513          	andi	a0,a4,-2
   173d8:	00a78533          	add	a0,a5,a0
   173dc:	00452503          	lw	a0,4(a0)
   173e0:	00157513          	andi	a0,a0,1
   173e4:	0a051a63          	bnez	a0,17498 <_realloc_r+0x1c4>
   173e8:	ffc77713          	andi	a4,a4,-4
   173ec:	00e909b3          	add	s3,s2,a4
   173f0:	04f61063          	bne	a2,a5,17430 <_realloc_r+0x15c>
   173f4:	010b0513          	addi	a0,s6,16
   173f8:	0aa9c463          	blt	s3,a0,174a0 <_realloc_r+0x1cc>
   173fc:	016b8bb3          	add	s7,s7,s6
   17400:	416989b3          	sub	s3,s3,s6
   17404:	017c2423          	sw	s7,8(s8)
   17408:	0019e993          	ori	s3,s3,1
   1740c:	013ba223          	sw	s3,4(s7)
   17410:	ffc42983          	lw	s3,-4(s0)
   17414:	000a8513          	mv	a0,s5
   17418:	00040a13          	mv	s4,s0
   1741c:	0019f993          	andi	s3,s3,1
   17420:	0169e9b3          	or	s3,s3,s6
   17424:	ff342e23          	sw	s3,-4(s0)
   17428:	ea8f90ef          	jal	ra,10ad0 <__malloc_unlock>
   1742c:	f4dff06f          	j	17378 <_realloc_r+0xa4>
   17430:	0769c863          	blt	s3,s6,174a0 <_realloc_r+0x1cc>
   17434:	00c7a703          	lw	a4,12(a5)
   17438:	0087a783          	lw	a5,8(a5)
   1743c:	00e7a623          	sw	a4,12(a5)
   17440:	00f72423          	sw	a5,8(a4)
   17444:	004ba703          	lw	a4,4(s7)
   17448:	416986b3          	sub	a3,s3,s6
   1744c:	00f00613          	li	a2,15
   17450:	00177713          	andi	a4,a4,1
   17454:	013b87b3          	add	a5,s7,s3
   17458:	3ad67e63          	bleu	a3,a2,17814 <_realloc_r+0x540>
   1745c:	00eb69b3          	or	s3,s6,a4
   17460:	013ba223          	sw	s3,4(s7)
   17464:	016b85b3          	add	a1,s7,s6
   17468:	0016e693          	ori	a3,a3,1
   1746c:	00d5a223          	sw	a3,4(a1)
   17470:	0047a703          	lw	a4,4(a5)
   17474:	00858593          	addi	a1,a1,8
   17478:	000a8513          	mv	a0,s5
   1747c:	00176713          	ori	a4,a4,1
   17480:	00e7a223          	sw	a4,4(a5)
   17484:	a0cfc0ef          	jal	ra,13690 <_free_r>
   17488:	000a8513          	mv	a0,s5
   1748c:	e44f90ef          	jal	ra,10ad0 <__malloc_unlock>
   17490:	008b8a13          	addi	s4,s7,8
   17494:	ee5ff06f          	j	17378 <_realloc_r+0xa4>
   17498:	00000713          	li	a4,0
   1749c:	00000793          	li	a5,0
   174a0:	0016f693          	andi	a3,a3,1
   174a4:	28069263          	bnez	a3,17728 <_realloc_r+0x454>
   174a8:	ff842483          	lw	s1,-8(s0)
   174ac:	409b84b3          	sub	s1,s7,s1
   174b0:	0044aa03          	lw	s4,4(s1)
   174b4:	ffca7a13          	andi	s4,s4,-4
   174b8:	012a0a33          	add	s4,s4,s2
   174bc:	1a078c63          	beqz	a5,17674 <_realloc_r+0x3a0>
   174c0:	014709b3          	add	s3,a4,s4
   174c4:	0ef61663          	bne	a2,a5,175b0 <_realloc_r+0x2dc>
   174c8:	010b0793          	addi	a5,s6,16
   174cc:	1af9c463          	blt	s3,a5,17674 <_realloc_r+0x3a0>
   174d0:	0084a703          	lw	a4,8(s1)
   174d4:	00c4a783          	lw	a5,12(s1)
   174d8:	ffc90613          	addi	a2,s2,-4
   174dc:	00848a13          	addi	s4,s1,8
   174e0:	00f72623          	sw	a5,12(a4)
   174e4:	00e7a423          	sw	a4,8(a5)
   174e8:	02400713          	li	a4,36
   174ec:	0ac76a63          	bltu	a4,a2,175a0 <_realloc_r+0x2cc>
   174f0:	01300693          	li	a3,19
   174f4:	000a0793          	mv	a5,s4
   174f8:	02c6f263          	bleu	a2,a3,1751c <_realloc_r+0x248>
   174fc:	00042783          	lw	a5,0(s0)
   17500:	00f4a423          	sw	a5,8(s1)
   17504:	00442783          	lw	a5,4(s0)
   17508:	00f4a623          	sw	a5,12(s1)
   1750c:	01b00793          	li	a5,27
   17510:	04c7ea63          	bltu	a5,a2,17564 <_realloc_r+0x290>
   17514:	00840413          	addi	s0,s0,8
   17518:	01048793          	addi	a5,s1,16
   1751c:	00042703          	lw	a4,0(s0)
   17520:	00e7a023          	sw	a4,0(a5)
   17524:	00442703          	lw	a4,4(s0)
   17528:	00e7a223          	sw	a4,4(a5)
   1752c:	00842703          	lw	a4,8(s0)
   17530:	00e7a423          	sw	a4,8(a5)
   17534:	016487b3          	add	a5,s1,s6
   17538:	416989b3          	sub	s3,s3,s6
   1753c:	00fc2423          	sw	a5,8(s8)
   17540:	0019e993          	ori	s3,s3,1
   17544:	0137a223          	sw	s3,4(a5)
   17548:	0044a783          	lw	a5,4(s1)
   1754c:	0017f793          	andi	a5,a5,1
   17550:	0167e9b3          	or	s3,a5,s6
   17554:	0134a223          	sw	s3,4(s1)
   17558:	000a8513          	mv	a0,s5
   1755c:	d74f90ef          	jal	ra,10ad0 <__malloc_unlock>
   17560:	e19ff06f          	j	17378 <_realloc_r+0xa4>
   17564:	00842783          	lw	a5,8(s0)
   17568:	00f4a823          	sw	a5,16(s1)
   1756c:	00c42783          	lw	a5,12(s0)
   17570:	00f4aa23          	sw	a5,20(s1)
   17574:	00e60863          	beq	a2,a4,17584 <_realloc_r+0x2b0>
   17578:	01040413          	addi	s0,s0,16
   1757c:	01848793          	addi	a5,s1,24
   17580:	f9dff06f          	j	1751c <_realloc_r+0x248>
   17584:	01042783          	lw	a5,16(s0)
   17588:	01840413          	addi	s0,s0,24
   1758c:	00f4ac23          	sw	a5,24(s1)
   17590:	ffc42703          	lw	a4,-4(s0)
   17594:	02048793          	addi	a5,s1,32
   17598:	00e4ae23          	sw	a4,28(s1)
   1759c:	f81ff06f          	j	1751c <_realloc_r+0x248>
   175a0:	00040593          	mv	a1,s0
   175a4:	000a0513          	mv	a0,s4
   175a8:	d89fe0ef          	jal	ra,16330 <memmove>
   175ac:	f89ff06f          	j	17534 <_realloc_r+0x260>
   175b0:	0d69c263          	blt	s3,s6,17674 <_realloc_r+0x3a0>
   175b4:	00c7a703          	lw	a4,12(a5)
   175b8:	0087a783          	lw	a5,8(a5)
   175bc:	ffc90613          	addi	a2,s2,-4
   175c0:	00848513          	addi	a0,s1,8
   175c4:	00e7a623          	sw	a4,12(a5)
   175c8:	00f72423          	sw	a5,8(a4)
   175cc:	0084a703          	lw	a4,8(s1)
   175d0:	00c4a783          	lw	a5,12(s1)
   175d4:	00f72623          	sw	a5,12(a4)
   175d8:	00e7a423          	sw	a4,8(a5)
   175dc:	02400793          	li	a5,36
   175e0:	08c7e463          	bltu	a5,a2,17668 <_realloc_r+0x394>
   175e4:	01300713          	li	a4,19
   175e8:	02c77263          	bleu	a2,a4,1760c <_realloc_r+0x338>
   175ec:	00042703          	lw	a4,0(s0)
   175f0:	00e4a423          	sw	a4,8(s1)
   175f4:	00442703          	lw	a4,4(s0)
   175f8:	00e4a623          	sw	a4,12(s1)
   175fc:	01b00713          	li	a4,27
   17600:	02c76663          	bltu	a4,a2,1762c <_realloc_r+0x358>
   17604:	00840413          	addi	s0,s0,8
   17608:	01048513          	addi	a0,s1,16
   1760c:	00042783          	lw	a5,0(s0)
   17610:	00f52023          	sw	a5,0(a0)
   17614:	00442783          	lw	a5,4(s0)
   17618:	00f52223          	sw	a5,4(a0)
   1761c:	00842783          	lw	a5,8(s0)
   17620:	00f52423          	sw	a5,8(a0)
   17624:	00048b93          	mv	s7,s1
   17628:	e1dff06f          	j	17444 <_realloc_r+0x170>
   1762c:	00842703          	lw	a4,8(s0)
   17630:	00e4a823          	sw	a4,16(s1)
   17634:	00c42703          	lw	a4,12(s0)
   17638:	00e4aa23          	sw	a4,20(s1)
   1763c:	00f60863          	beq	a2,a5,1764c <_realloc_r+0x378>
   17640:	01040413          	addi	s0,s0,16
   17644:	01848513          	addi	a0,s1,24
   17648:	fc5ff06f          	j	1760c <_realloc_r+0x338>
   1764c:	01042783          	lw	a5,16(s0)
   17650:	02048513          	addi	a0,s1,32
   17654:	01840413          	addi	s0,s0,24
   17658:	00f4ac23          	sw	a5,24(s1)
   1765c:	ffc42783          	lw	a5,-4(s0)
   17660:	00f4ae23          	sw	a5,28(s1)
   17664:	fa9ff06f          	j	1760c <_realloc_r+0x338>
   17668:	00040593          	mv	a1,s0
   1766c:	cc5fe0ef          	jal	ra,16330 <memmove>
   17670:	fb5ff06f          	j	17624 <_realloc_r+0x350>
   17674:	0b6a4a63          	blt	s4,s6,17728 <_realloc_r+0x454>
   17678:	00c4a783          	lw	a5,12(s1)
   1767c:	0084a703          	lw	a4,8(s1)
   17680:	ffc90613          	addi	a2,s2,-4
   17684:	00848513          	addi	a0,s1,8
   17688:	00f72623          	sw	a5,12(a4)
   1768c:	00e7a423          	sw	a4,8(a5)
   17690:	02400793          	li	a5,36
   17694:	08c7e463          	bltu	a5,a2,1771c <_realloc_r+0x448>
   17698:	01300713          	li	a4,19
   1769c:	02c77263          	bleu	a2,a4,176c0 <_realloc_r+0x3ec>
   176a0:	00042703          	lw	a4,0(s0)
   176a4:	00e4a423          	sw	a4,8(s1)
   176a8:	00442703          	lw	a4,4(s0)
   176ac:	00e4a623          	sw	a4,12(s1)
   176b0:	01b00713          	li	a4,27
   176b4:	02c76663          	bltu	a4,a2,176e0 <_realloc_r+0x40c>
   176b8:	00840413          	addi	s0,s0,8
   176bc:	01048513          	addi	a0,s1,16
   176c0:	00042783          	lw	a5,0(s0)
   176c4:	00f52023          	sw	a5,0(a0)
   176c8:	00442783          	lw	a5,4(s0)
   176cc:	00f52223          	sw	a5,4(a0)
   176d0:	00842783          	lw	a5,8(s0)
   176d4:	00f52423          	sw	a5,8(a0)
   176d8:	000a0993          	mv	s3,s4
   176dc:	f49ff06f          	j	17624 <_realloc_r+0x350>
   176e0:	00842703          	lw	a4,8(s0)
   176e4:	00e4a823          	sw	a4,16(s1)
   176e8:	00c42703          	lw	a4,12(s0)
   176ec:	00e4aa23          	sw	a4,20(s1)
   176f0:	00f60863          	beq	a2,a5,17700 <_realloc_r+0x42c>
   176f4:	01040413          	addi	s0,s0,16
   176f8:	01848513          	addi	a0,s1,24
   176fc:	fc5ff06f          	j	176c0 <_realloc_r+0x3ec>
   17700:	01042783          	lw	a5,16(s0)
   17704:	02048513          	addi	a0,s1,32
   17708:	01840413          	addi	s0,s0,24
   1770c:	00f4ac23          	sw	a5,24(s1)
   17710:	ffc42783          	lw	a5,-4(s0)
   17714:	00f4ae23          	sw	a5,28(s1)
   17718:	fa9ff06f          	j	176c0 <_realloc_r+0x3ec>
   1771c:	00040593          	mv	a1,s0
   17720:	c11fe0ef          	jal	ra,16330 <memmove>
   17724:	fb5ff06f          	j	176d8 <_realloc_r+0x404>
   17728:	000a8513          	mv	a0,s5
   1772c:	c81f80ef          	jal	ra,103ac <_malloc_r>
   17730:	00050a13          	mv	s4,a0
   17734:	e20502e3          	beqz	a0,17558 <_realloc_r+0x284>
   17738:	ffc42783          	lw	a5,-4(s0)
   1773c:	ff850713          	addi	a4,a0,-8
   17740:	ffe7f793          	andi	a5,a5,-2
   17744:	00fb87b3          	add	a5,s7,a5
   17748:	00e79a63          	bne	a5,a4,1775c <_realloc_r+0x488>
   1774c:	ffc52983          	lw	s3,-4(a0)
   17750:	ffc9f993          	andi	s3,s3,-4
   17754:	012989b3          	add	s3,s3,s2
   17758:	cedff06f          	j	17444 <_realloc_r+0x170>
   1775c:	ffc90613          	addi	a2,s2,-4
   17760:	02400793          	li	a5,36
   17764:	08c7ee63          	bltu	a5,a2,17800 <_realloc_r+0x52c>
   17768:	01300713          	li	a4,19
   1776c:	08c77463          	bleu	a2,a4,177f4 <_realloc_r+0x520>
   17770:	00042703          	lw	a4,0(s0)
   17774:	00e52023          	sw	a4,0(a0)
   17778:	00442703          	lw	a4,4(s0)
   1777c:	00e52223          	sw	a4,4(a0)
   17780:	01b00713          	li	a4,27
   17784:	02c76a63          	bltu	a4,a2,177b8 <_realloc_r+0x4e4>
   17788:	00840713          	addi	a4,s0,8
   1778c:	00850793          	addi	a5,a0,8
   17790:	00072683          	lw	a3,0(a4)
   17794:	00d7a023          	sw	a3,0(a5)
   17798:	00472683          	lw	a3,4(a4)
   1779c:	00d7a223          	sw	a3,4(a5)
   177a0:	00872703          	lw	a4,8(a4)
   177a4:	00e7a423          	sw	a4,8(a5)
   177a8:	00040593          	mv	a1,s0
   177ac:	000a8513          	mv	a0,s5
   177b0:	ee1fb0ef          	jal	ra,13690 <_free_r>
   177b4:	da5ff06f          	j	17558 <_realloc_r+0x284>
   177b8:	00842703          	lw	a4,8(s0)
   177bc:	00e52423          	sw	a4,8(a0)
   177c0:	00c42703          	lw	a4,12(s0)
   177c4:	00e52623          	sw	a4,12(a0)
   177c8:	00f60863          	beq	a2,a5,177d8 <_realloc_r+0x504>
   177cc:	01040713          	addi	a4,s0,16
   177d0:	01050793          	addi	a5,a0,16
   177d4:	fbdff06f          	j	17790 <_realloc_r+0x4bc>
   177d8:	01042783          	lw	a5,16(s0)
   177dc:	01840713          	addi	a4,s0,24
   177e0:	00f52823          	sw	a5,16(a0)
   177e4:	01442683          	lw	a3,20(s0)
   177e8:	01850793          	addi	a5,a0,24
   177ec:	00d52a23          	sw	a3,20(a0)
   177f0:	fa1ff06f          	j	17790 <_realloc_r+0x4bc>
   177f4:	00050793          	mv	a5,a0
   177f8:	00040713          	mv	a4,s0
   177fc:	f95ff06f          	j	17790 <_realloc_r+0x4bc>
   17800:	00040593          	mv	a1,s0
   17804:	b2dfe0ef          	jal	ra,16330 <memmove>
   17808:	fa1ff06f          	j	177a8 <_realloc_r+0x4d4>
   1780c:	00090993          	mv	s3,s2
   17810:	c35ff06f          	j	17444 <_realloc_r+0x170>
   17814:	00e9e9b3          	or	s3,s3,a4
   17818:	013ba223          	sw	s3,4(s7)
   1781c:	0047a703          	lw	a4,4(a5)
   17820:	00176713          	ori	a4,a4,1
   17824:	00e7a223          	sw	a4,4(a5)
   17828:	c61ff06f          	j	17488 <_realloc_r+0x1b4>

0001782c <cleanup_glue>:
   1782c:	ff010113          	addi	sp,sp,-16
   17830:	00812423          	sw	s0,8(sp)
   17834:	00058413          	mv	s0,a1
   17838:	0005a583          	lw	a1,0(a1)
   1783c:	00912223          	sw	s1,4(sp)
   17840:	00112623          	sw	ra,12(sp)
   17844:	00050493          	mv	s1,a0
   17848:	00058463          	beqz	a1,17850 <cleanup_glue+0x24>
   1784c:	fe1ff0ef          	jal	ra,1782c <cleanup_glue>
   17850:	00040593          	mv	a1,s0
   17854:	00812403          	lw	s0,8(sp)
   17858:	00c12083          	lw	ra,12(sp)
   1785c:	00048513          	mv	a0,s1
   17860:	00412483          	lw	s1,4(sp)
   17864:	01010113          	addi	sp,sp,16
   17868:	e29fb06f          	j	13690 <_free_r>

0001786c <_reclaim_reent>:
   1786c:	8201a783          	lw	a5,-2016(gp) # 23f80 <_impure_ptr>
   17870:	10a78263          	beq	a5,a0,17974 <_reclaim_reent+0x108>
   17874:	04c52783          	lw	a5,76(a0)
   17878:	fe010113          	addi	sp,sp,-32
   1787c:	00812c23          	sw	s0,24(sp)
   17880:	00912a23          	sw	s1,20(sp)
   17884:	01212823          	sw	s2,16(sp)
   17888:	00112e23          	sw	ra,28(sp)
   1788c:	01312623          	sw	s3,12(sp)
   17890:	00050413          	mv	s0,a0
   17894:	00000493          	li	s1,0
   17898:	08000913          	li	s2,128
   1789c:	04079463          	bnez	a5,178e4 <_reclaim_reent+0x78>
   178a0:	04042583          	lw	a1,64(s0)
   178a4:	00058663          	beqz	a1,178b0 <_reclaim_reent+0x44>
   178a8:	00040513          	mv	a0,s0
   178ac:	de5fb0ef          	jal	ra,13690 <_free_r>
   178b0:	14842583          	lw	a1,328(s0)
   178b4:	04058c63          	beqz	a1,1790c <_reclaim_reent+0xa0>
   178b8:	14c40493          	addi	s1,s0,332
   178bc:	04958863          	beq	a1,s1,1790c <_reclaim_reent+0xa0>
   178c0:	0005a903          	lw	s2,0(a1)
   178c4:	00040513          	mv	a0,s0
   178c8:	dc9fb0ef          	jal	ra,13690 <_free_r>
   178cc:	00090593          	mv	a1,s2
   178d0:	fedff06f          	j	178bc <_reclaim_reent+0x50>
   178d4:	009585b3          	add	a1,a1,s1
   178d8:	0005a583          	lw	a1,0(a1)
   178dc:	00059e63          	bnez	a1,178f8 <_reclaim_reent+0x8c>
   178e0:	00448493          	addi	s1,s1,4
   178e4:	04c42583          	lw	a1,76(s0)
   178e8:	ff2496e3          	bne	s1,s2,178d4 <_reclaim_reent+0x68>
   178ec:	00040513          	mv	a0,s0
   178f0:	da1fb0ef          	jal	ra,13690 <_free_r>
   178f4:	fadff06f          	j	178a0 <_reclaim_reent+0x34>
   178f8:	0005a983          	lw	s3,0(a1)
   178fc:	00040513          	mv	a0,s0
   17900:	d91fb0ef          	jal	ra,13690 <_free_r>
   17904:	00098593          	mv	a1,s3
   17908:	fd5ff06f          	j	178dc <_reclaim_reent+0x70>
   1790c:	05442583          	lw	a1,84(s0)
   17910:	00058663          	beqz	a1,1791c <_reclaim_reent+0xb0>
   17914:	00040513          	mv	a0,s0
   17918:	d79fb0ef          	jal	ra,13690 <_free_r>
   1791c:	03842783          	lw	a5,56(s0)
   17920:	02078c63          	beqz	a5,17958 <_reclaim_reent+0xec>
   17924:	03c42783          	lw	a5,60(s0)
   17928:	00040513          	mv	a0,s0
   1792c:	000780e7          	jalr	a5
   17930:	2e042583          	lw	a1,736(s0)
   17934:	02058263          	beqz	a1,17958 <_reclaim_reent+0xec>
   17938:	00040513          	mv	a0,s0
   1793c:	01812403          	lw	s0,24(sp)
   17940:	01c12083          	lw	ra,28(sp)
   17944:	01412483          	lw	s1,20(sp)
   17948:	01012903          	lw	s2,16(sp)
   1794c:	00c12983          	lw	s3,12(sp)
   17950:	02010113          	addi	sp,sp,32
   17954:	ed9ff06f          	j	1782c <cleanup_glue>
   17958:	01c12083          	lw	ra,28(sp)
   1795c:	01812403          	lw	s0,24(sp)
   17960:	01412483          	lw	s1,20(sp)
   17964:	01012903          	lw	s2,16(sp)
   17968:	00c12983          	lw	s3,12(sp)
   1796c:	02010113          	addi	sp,sp,32
   17970:	00008067          	ret
   17974:	00008067          	ret

00017978 <frexp>:
   17978:	ff010113          	addi	sp,sp,-16
   1797c:	00912223          	sw	s1,4(sp)
   17980:	800004b7          	lui	s1,0x80000
   17984:	00812423          	sw	s0,8(sp)
   17988:	00112623          	sw	ra,12(sp)
   1798c:	fff4c493          	not	s1,s1
   17990:	00b4f733          	and	a4,s1,a1
   17994:	00062023          	sw	zero,0(a2)
   17998:	7ff00837          	lui	a6,0x7ff00
   1799c:	00050693          	mv	a3,a0
   179a0:	00058793          	mv	a5,a1
   179a4:	00060413          	mv	s0,a2
   179a8:	07075463          	ble	a6,a4,17a10 <frexp+0x98>
   179ac:	00a76833          	or	a6,a4,a0
   179b0:	06080063          	beqz	a6,17a10 <frexp+0x98>
   179b4:	001007b7          	lui	a5,0x100
   179b8:	00058613          	mv	a2,a1
   179bc:	02f75663          	ble	a5,a4,179e8 <frexp+0x70>
   179c0:	000247b7          	lui	a5,0x24
   179c4:	f7078793          	addi	a5,a5,-144 # 23f70 <__TMC_END__+0x14>
   179c8:	0007a603          	lw	a2,0(a5)
   179cc:	0047a683          	lw	a3,4(a5)
   179d0:	7a5050ef          	jal	ra,1d974 <__muldf3>
   179d4:	fca00793          	li	a5,-54
   179d8:	00050693          	mv	a3,a0
   179dc:	00058613          	mv	a2,a1
   179e0:	00b4f733          	and	a4,s1,a1
   179e4:	00f42023          	sw	a5,0(s0)
   179e8:	00042783          	lw	a5,0(s0)
   179ec:	41475713          	srai	a4,a4,0x14
   179f0:	c0270713          	addi	a4,a4,-1022
   179f4:	00e78733          	add	a4,a5,a4
   179f8:	801007b7          	lui	a5,0x80100
   179fc:	fff78793          	addi	a5,a5,-1 # 800fffff <__global_pointer$+0x800db89f>
   17a00:	00f67633          	and	a2,a2,a5
   17a04:	3fe007b7          	lui	a5,0x3fe00
   17a08:	00e42023          	sw	a4,0(s0)
   17a0c:	00f667b3          	or	a5,a2,a5
   17a10:	00c12083          	lw	ra,12(sp)
   17a14:	00812403          	lw	s0,8(sp)
   17a18:	00412483          	lw	s1,4(sp)
   17a1c:	00068513          	mv	a0,a3
   17a20:	00078593          	mv	a1,a5
   17a24:	01010113          	addi	sp,sp,16
   17a28:	00008067          	ret

00017a2c <_sprintf_r>:
   17a2c:	f6010113          	addi	sp,sp,-160
   17a30:	08f12a23          	sw	a5,148(sp)
   17a34:	800007b7          	lui	a5,0x80000
   17a38:	fff7c793          	not	a5,a5
   17a3c:	00f12e23          	sw	a5,28(sp)
   17a40:	00f12823          	sw	a5,16(sp)
   17a44:	ffff07b7          	lui	a5,0xffff0
   17a48:	08d12623          	sw	a3,140(sp)
   17a4c:	00b12423          	sw	a1,8(sp)
   17a50:	00b12c23          	sw	a1,24(sp)
   17a54:	20878793          	addi	a5,a5,520 # ffff0208 <__global_pointer$+0xfffcbaa8>
   17a58:	08c10693          	addi	a3,sp,140
   17a5c:	00810593          	addi	a1,sp,8
   17a60:	06112e23          	sw	ra,124(sp)
   17a64:	00f12a23          	sw	a5,20(sp)
   17a68:	08e12823          	sw	a4,144(sp)
   17a6c:	09012c23          	sw	a6,152(sp)
   17a70:	09112e23          	sw	a7,156(sp)
   17a74:	00d12223          	sw	a3,4(sp)
   17a78:	3a4000ef          	jal	ra,17e1c <_svfprintf_r>
   17a7c:	00812783          	lw	a5,8(sp)
   17a80:	00078023          	sb	zero,0(a5)
   17a84:	07c12083          	lw	ra,124(sp)
   17a88:	0a010113          	addi	sp,sp,160
   17a8c:	00008067          	ret

00017a90 <sprintf>:
   17a90:	f6010113          	addi	sp,sp,-160
   17a94:	08f12a23          	sw	a5,148(sp)
   17a98:	800007b7          	lui	a5,0x80000
   17a9c:	fff7c793          	not	a5,a5
   17aa0:	00f12e23          	sw	a5,28(sp)
   17aa4:	00f12823          	sw	a5,16(sp)
   17aa8:	ffff07b7          	lui	a5,0xffff0
   17aac:	20878793          	addi	a5,a5,520 # ffff0208 <__global_pointer$+0xfffcbaa8>
   17ab0:	00f12a23          	sw	a5,20(sp)
   17ab4:	00a12423          	sw	a0,8(sp)
   17ab8:	00a12c23          	sw	a0,24(sp)
   17abc:	8201a503          	lw	a0,-2016(gp) # 23f80 <_impure_ptr>
   17ac0:	08c12423          	sw	a2,136(sp)
   17ac4:	08d12623          	sw	a3,140(sp)
   17ac8:	00058613          	mv	a2,a1
   17acc:	08810693          	addi	a3,sp,136
   17ad0:	00810593          	addi	a1,sp,8
   17ad4:	06112e23          	sw	ra,124(sp)
   17ad8:	08e12823          	sw	a4,144(sp)
   17adc:	09012c23          	sw	a6,152(sp)
   17ae0:	09112e23          	sw	a7,156(sp)
   17ae4:	00d12223          	sw	a3,4(sp)
   17ae8:	334000ef          	jal	ra,17e1c <_svfprintf_r>
   17aec:	00812783          	lw	a5,8(sp)
   17af0:	00078023          	sb	zero,0(a5)
   17af4:	07c12083          	lw	ra,124(sp)
   17af8:	0a010113          	addi	sp,sp,160
   17afc:	00008067          	ret

00017b00 <__sread>:
   17b00:	ff010113          	addi	sp,sp,-16
   17b04:	00812423          	sw	s0,8(sp)
   17b08:	00058413          	mv	s0,a1
   17b0c:	00e59583          	lh	a1,14(a1)
   17b10:	00112623          	sw	ra,12(sp)
   17b14:	5fc030ef          	jal	ra,1b110 <_read_r>
   17b18:	02054063          	bltz	a0,17b38 <__sread+0x38>
   17b1c:	05042783          	lw	a5,80(s0)
   17b20:	00a787b3          	add	a5,a5,a0
   17b24:	04f42823          	sw	a5,80(s0)
   17b28:	00c12083          	lw	ra,12(sp)
   17b2c:	00812403          	lw	s0,8(sp)
   17b30:	01010113          	addi	sp,sp,16
   17b34:	00008067          	ret
   17b38:	00c45783          	lhu	a5,12(s0)
   17b3c:	fffff737          	lui	a4,0xfffff
   17b40:	fff70713          	addi	a4,a4,-1 # ffffefff <__global_pointer$+0xfffda89f>
   17b44:	00e7f7b3          	and	a5,a5,a4
   17b48:	00f41623          	sh	a5,12(s0)
   17b4c:	fddff06f          	j	17b28 <__sread+0x28>

00017b50 <__seofread>:
   17b50:	00000513          	li	a0,0
   17b54:	00008067          	ret

00017b58 <__swrite>:
   17b58:	00c5d783          	lhu	a5,12(a1)
   17b5c:	fe010113          	addi	sp,sp,-32
   17b60:	00812c23          	sw	s0,24(sp)
   17b64:	00912a23          	sw	s1,20(sp)
   17b68:	01212823          	sw	s2,16(sp)
   17b6c:	01312623          	sw	s3,12(sp)
   17b70:	00112e23          	sw	ra,28(sp)
   17b74:	1007f793          	andi	a5,a5,256
   17b78:	00050493          	mv	s1,a0
   17b7c:	00058413          	mv	s0,a1
   17b80:	00060913          	mv	s2,a2
   17b84:	00068993          	mv	s3,a3
   17b88:	00078a63          	beqz	a5,17b9c <__swrite+0x44>
   17b8c:	00e59583          	lh	a1,14(a1)
   17b90:	00200693          	li	a3,2
   17b94:	00000613          	li	a2,0
   17b98:	528030ef          	jal	ra,1b0c0 <_lseek_r>
   17b9c:	00c45783          	lhu	a5,12(s0)
   17ba0:	fffff737          	lui	a4,0xfffff
   17ba4:	fff70713          	addi	a4,a4,-1 # ffffefff <__global_pointer$+0xfffda89f>
   17ba8:	00e7f7b3          	and	a5,a5,a4
   17bac:	00f41623          	sh	a5,12(s0)
   17bb0:	00e41583          	lh	a1,14(s0)
   17bb4:	01812403          	lw	s0,24(sp)
   17bb8:	01c12083          	lw	ra,28(sp)
   17bbc:	00098693          	mv	a3,s3
   17bc0:	00090613          	mv	a2,s2
   17bc4:	00c12983          	lw	s3,12(sp)
   17bc8:	01012903          	lw	s2,16(sp)
   17bcc:	00048513          	mv	a0,s1
   17bd0:	01412483          	lw	s1,20(sp)
   17bd4:	02010113          	addi	sp,sp,32
   17bd8:	0900306f          	j	1ac68 <_write_r>

00017bdc <__sseek>:
   17bdc:	ff010113          	addi	sp,sp,-16
   17be0:	00812423          	sw	s0,8(sp)
   17be4:	00058413          	mv	s0,a1
   17be8:	00e59583          	lh	a1,14(a1)
   17bec:	00112623          	sw	ra,12(sp)
   17bf0:	4d0030ef          	jal	ra,1b0c0 <_lseek_r>
   17bf4:	fff00793          	li	a5,-1
   17bf8:	00c45703          	lhu	a4,12(s0)
   17bfc:	02f51263          	bne	a0,a5,17c20 <__sseek+0x44>
   17c00:	fffff7b7          	lui	a5,0xfffff
   17c04:	fff78793          	addi	a5,a5,-1 # ffffefff <__global_pointer$+0xfffda89f>
   17c08:	00e7f7b3          	and	a5,a5,a4
   17c0c:	00f41623          	sh	a5,12(s0)
   17c10:	00c12083          	lw	ra,12(sp)
   17c14:	00812403          	lw	s0,8(sp)
   17c18:	01010113          	addi	sp,sp,16
   17c1c:	00008067          	ret
   17c20:	000017b7          	lui	a5,0x1
   17c24:	00f767b3          	or	a5,a4,a5
   17c28:	00f41623          	sh	a5,12(s0)
   17c2c:	04a42823          	sw	a0,80(s0)
   17c30:	fe1ff06f          	j	17c10 <__sseek+0x34>

00017c34 <__sclose>:
   17c34:	00e59583          	lh	a1,14(a1)
   17c38:	1300306f          	j	1ad68 <_close_r>

00017c3c <strcmp>:
   17c3c:	00b56733          	or	a4,a0,a1
   17c40:	fff00393          	li	t2,-1
   17c44:	00377713          	andi	a4,a4,3
   17c48:	10071063          	bnez	a4,17d48 <strcmp+0x10c>
   17c4c:	7f7f8e37          	lui	t3,0x7f7f8
   17c50:	f7fe0e13          	addi	t3,t3,-129 # 7f7f7f7f <__global_pointer$+0x7f7d381f>
   17c54:	00052603          	lw	a2,0(a0)
   17c58:	0005a683          	lw	a3,0(a1)
   17c5c:	01c672b3          	and	t0,a2,t3
   17c60:	01c66333          	or	t1,a2,t3
   17c64:	01c282b3          	add	t0,t0,t3
   17c68:	0062e2b3          	or	t0,t0,t1
   17c6c:	10729263          	bne	t0,t2,17d70 <strcmp+0x134>
   17c70:	08d61663          	bne	a2,a3,17cfc <strcmp+0xc0>
   17c74:	00452603          	lw	a2,4(a0)
   17c78:	0045a683          	lw	a3,4(a1)
   17c7c:	01c672b3          	and	t0,a2,t3
   17c80:	01c66333          	or	t1,a2,t3
   17c84:	01c282b3          	add	t0,t0,t3
   17c88:	0062e2b3          	or	t0,t0,t1
   17c8c:	0c729e63          	bne	t0,t2,17d68 <strcmp+0x12c>
   17c90:	06d61663          	bne	a2,a3,17cfc <strcmp+0xc0>
   17c94:	00852603          	lw	a2,8(a0)
   17c98:	0085a683          	lw	a3,8(a1)
   17c9c:	01c672b3          	and	t0,a2,t3
   17ca0:	01c66333          	or	t1,a2,t3
   17ca4:	01c282b3          	add	t0,t0,t3
   17ca8:	0062e2b3          	or	t0,t0,t1
   17cac:	0c729863          	bne	t0,t2,17d7c <strcmp+0x140>
   17cb0:	04d61663          	bne	a2,a3,17cfc <strcmp+0xc0>
   17cb4:	00c52603          	lw	a2,12(a0)
   17cb8:	00c5a683          	lw	a3,12(a1)
   17cbc:	01c672b3          	and	t0,a2,t3
   17cc0:	01c66333          	or	t1,a2,t3
   17cc4:	01c282b3          	add	t0,t0,t3
   17cc8:	0062e2b3          	or	t0,t0,t1
   17ccc:	0c729263          	bne	t0,t2,17d90 <strcmp+0x154>
   17cd0:	02d61663          	bne	a2,a3,17cfc <strcmp+0xc0>
   17cd4:	01052603          	lw	a2,16(a0)
   17cd8:	0105a683          	lw	a3,16(a1)
   17cdc:	01c672b3          	and	t0,a2,t3
   17ce0:	01c66333          	or	t1,a2,t3
   17ce4:	01c282b3          	add	t0,t0,t3
   17ce8:	0062e2b3          	or	t0,t0,t1
   17cec:	0a729c63          	bne	t0,t2,17da4 <strcmp+0x168>
   17cf0:	01450513          	addi	a0,a0,20
   17cf4:	01458593          	addi	a1,a1,20
   17cf8:	f4d60ee3          	beq	a2,a3,17c54 <strcmp+0x18>
   17cfc:	01061713          	slli	a4,a2,0x10
   17d00:	01069793          	slli	a5,a3,0x10
   17d04:	00f71e63          	bne	a4,a5,17d20 <strcmp+0xe4>
   17d08:	01065713          	srli	a4,a2,0x10
   17d0c:	0106d793          	srli	a5,a3,0x10
   17d10:	40f70533          	sub	a0,a4,a5
   17d14:	0ff57593          	andi	a1,a0,255
   17d18:	02059063          	bnez	a1,17d38 <strcmp+0xfc>
   17d1c:	00008067          	ret
   17d20:	01075713          	srli	a4,a4,0x10
   17d24:	0107d793          	srli	a5,a5,0x10
   17d28:	40f70533          	sub	a0,a4,a5
   17d2c:	0ff57593          	andi	a1,a0,255
   17d30:	00059463          	bnez	a1,17d38 <strcmp+0xfc>
   17d34:	00008067          	ret
   17d38:	0ff77713          	andi	a4,a4,255
   17d3c:	0ff7f793          	andi	a5,a5,255
   17d40:	40f70533          	sub	a0,a4,a5
   17d44:	00008067          	ret
   17d48:	00054603          	lbu	a2,0(a0)
   17d4c:	0005c683          	lbu	a3,0(a1)
   17d50:	00150513          	addi	a0,a0,1
   17d54:	00158593          	addi	a1,a1,1
   17d58:	00d61463          	bne	a2,a3,17d60 <strcmp+0x124>
   17d5c:	fe0616e3          	bnez	a2,17d48 <strcmp+0x10c>
   17d60:	40d60533          	sub	a0,a2,a3
   17d64:	00008067          	ret
   17d68:	00450513          	addi	a0,a0,4
   17d6c:	00458593          	addi	a1,a1,4
   17d70:	fcd61ce3          	bne	a2,a3,17d48 <strcmp+0x10c>
   17d74:	00000513          	li	a0,0
   17d78:	00008067          	ret
   17d7c:	00850513          	addi	a0,a0,8
   17d80:	00858593          	addi	a1,a1,8
   17d84:	fcd612e3          	bne	a2,a3,17d48 <strcmp+0x10c>
   17d88:	00000513          	li	a0,0
   17d8c:	00008067          	ret
   17d90:	00c50513          	addi	a0,a0,12
   17d94:	00c58593          	addi	a1,a1,12
   17d98:	fad618e3          	bne	a2,a3,17d48 <strcmp+0x10c>
   17d9c:	00000513          	li	a0,0
   17da0:	00008067          	ret
   17da4:	01050513          	addi	a0,a0,16
   17da8:	01058593          	addi	a1,a1,16
   17dac:	f8d61ee3          	bne	a2,a3,17d48 <strcmp+0x10c>
   17db0:	00000513          	li	a0,0
   17db4:	00008067          	ret

00017db8 <strcpy>:
   17db8:	00050793          	mv	a5,a0
   17dbc:	0005c703          	lbu	a4,0(a1)
   17dc0:	00178793          	addi	a5,a5,1 # 1001 <main-0xf073>
   17dc4:	00158593          	addi	a1,a1,1
   17dc8:	fee78fa3          	sb	a4,-1(a5)
   17dcc:	fe0718e3          	bnez	a4,17dbc <strcpy+0x4>
   17dd0:	00008067          	ret

00017dd4 <strncpy>:
   17dd4:	00050713          	mv	a4,a0
   17dd8:	00061463          	bnez	a2,17de0 <strncpy+0xc>
   17ddc:	00008067          	ret
   17de0:	00158593          	addi	a1,a1,1
   17de4:	fff5c683          	lbu	a3,-1(a1)
   17de8:	00170793          	addi	a5,a4,1
   17dec:	fff60813          	addi	a6,a2,-1
   17df0:	fed78fa3          	sb	a3,-1(a5)
   17df4:	00069863          	bnez	a3,17e04 <strncpy+0x30>
   17df8:	00c70733          	add	a4,a4,a2
   17dfc:	00e79a63          	bne	a5,a4,17e10 <strncpy+0x3c>
   17e00:	00008067          	ret
   17e04:	00078713          	mv	a4,a5
   17e08:	00080613          	mv	a2,a6
   17e0c:	fcdff06f          	j	17dd8 <strncpy+0x4>
   17e10:	00178793          	addi	a5,a5,1
   17e14:	fe078fa3          	sb	zero,-1(a5)
   17e18:	fe5ff06f          	j	17dfc <strncpy+0x28>

00017e1c <_svfprintf_r>:
   17e1c:	e1010113          	addi	sp,sp,-496
   17e20:	1e112623          	sw	ra,492(sp)
   17e24:	1e912223          	sw	s1,484(sp)
   17e28:	1f212023          	sw	s2,480(sp)
   17e2c:	1d312e23          	sw	s3,476(sp)
   17e30:	1d812423          	sw	s8,456(sp)
   17e34:	00058993          	mv	s3,a1
   17e38:	00060493          	mv	s1,a2
   17e3c:	00068c13          	mv	s8,a3
   17e40:	1e812423          	sw	s0,488(sp)
   17e44:	1d412c23          	sw	s4,472(sp)
   17e48:	1d512a23          	sw	s5,468(sp)
   17e4c:	1d612823          	sw	s6,464(sp)
   17e50:	1d712623          	sw	s7,460(sp)
   17e54:	1d912223          	sw	s9,452(sp)
   17e58:	1da12023          	sw	s10,448(sp)
   17e5c:	1bb12e23          	sw	s11,444(sp)
   17e60:	00050913          	mv	s2,a0
   17e64:	8c0fe0ef          	jal	ra,15f24 <_localeconv_r>
   17e68:	00052783          	lw	a5,0(a0)
   17e6c:	00078513          	mv	a0,a5
   17e70:	02f12c23          	sw	a5,56(sp)
   17e74:	e09f80ef          	jal	ra,10c7c <strlen>
   17e78:	00c9d783          	lhu	a5,12(s3)
   17e7c:	02a12223          	sw	a0,36(sp)
   17e80:	0e012823          	sw	zero,240(sp)
   17e84:	0e012a23          	sw	zero,244(sp)
   17e88:	0e012c23          	sw	zero,248(sp)
   17e8c:	0e012e23          	sw	zero,252(sp)
   17e90:	0807f793          	andi	a5,a5,128
   17e94:	04078063          	beqz	a5,17ed4 <_svfprintf_r+0xb8>
   17e98:	0109a783          	lw	a5,16(s3)
   17e9c:	02079c63          	bnez	a5,17ed4 <_svfprintf_r+0xb8>
   17ea0:	04000593          	li	a1,64
   17ea4:	00090513          	mv	a0,s2
   17ea8:	d04f80ef          	jal	ra,103ac <_malloc_r>
   17eac:	00a9a023          	sw	a0,0(s3)
   17eb0:	00a9a823          	sw	a0,16(s3)
   17eb4:	00051c63          	bnez	a0,17ecc <_svfprintf_r+0xb0>
   17eb8:	00c00793          	li	a5,12
   17ebc:	00f92023          	sw	a5,0(s2)
   17ec0:	fff00793          	li	a5,-1
   17ec4:	02f12423          	sw	a5,40(sp)
   17ec8:	0390006f          	j	18700 <_svfprintf_r+0x8e4>
   17ecc:	04000793          	li	a5,64
   17ed0:	00f9aa23          	sw	a5,20(s3)
   17ed4:	000227b7          	lui	a5,0x22
   17ed8:	cf078793          	addi	a5,a5,-784 # 21cf0 <__mprec_bigtens+0x28>
   17edc:	06f12023          	sw	a5,96(sp)
   17ee0:	000227b7          	lui	a5,0x22
   17ee4:	10c10893          	addi	a7,sp,268
   17ee8:	e6c78793          	addi	a5,a5,-404 # 21e6c <zeroes.4362>
   17eec:	0f112223          	sw	a7,228(sp)
   17ef0:	0e012623          	sw	zero,236(sp)
   17ef4:	0e012423          	sw	zero,232(sp)
   17ef8:	00000a13          	li	s4,0
   17efc:	00088d13          	mv	s10,a7
   17f00:	04012223          	sw	zero,68(sp)
   17f04:	04012023          	sw	zero,64(sp)
   17f08:	00012a23          	sw	zero,20(sp)
   17f0c:	02012a23          	sw	zero,52(sp)
   17f10:	02012e23          	sw	zero,60(sp)
   17f14:	02012423          	sw	zero,40(sp)
   17f18:	00f12c23          	sw	a5,24(sp)
   17f1c:	00048413          	mv	s0,s1
   17f20:	02500713          	li	a4,37
   17f24:	00044783          	lbu	a5,0(s0)
   17f28:	00078463          	beqz	a5,17f30 <_svfprintf_r+0x114>
   17f2c:	0ce79263          	bne	a5,a4,17ff0 <_svfprintf_r+0x1d4>
   17f30:	40940ab3          	sub	s5,s0,s1
   17f34:	040a8a63          	beqz	s5,17f88 <_svfprintf_r+0x16c>
   17f38:	0ec12783          	lw	a5,236(sp)
   17f3c:	009d2023          	sw	s1,0(s10)
   17f40:	015d2223          	sw	s5,4(s10)
   17f44:	015787b3          	add	a5,a5,s5
   17f48:	0ef12623          	sw	a5,236(sp)
   17f4c:	0e812783          	lw	a5,232(sp)
   17f50:	00700713          	li	a4,7
   17f54:	008d0d13          	addi	s10,s10,8
   17f58:	00178793          	addi	a5,a5,1
   17f5c:	0ef12423          	sw	a5,232(sp)
   17f60:	00f75e63          	ble	a5,a4,17f7c <_svfprintf_r+0x160>
   17f64:	0e410613          	addi	a2,sp,228
   17f68:	00098593          	mv	a1,s3
   17f6c:	00090513          	mv	a0,s2
   17f70:	1f0030ef          	jal	ra,1b160 <__ssprint_r>
   17f74:	78051063          	bnez	a0,186f4 <_svfprintf_r+0x8d8>
   17f78:	10c10d13          	addi	s10,sp,268
   17f7c:	02812783          	lw	a5,40(sp)
   17f80:	015787b3          	add	a5,a5,s5
   17f84:	02f12423          	sw	a5,40(sp)
   17f88:	00044783          	lbu	a5,0(s0)
   17f8c:	00079463          	bnez	a5,17f94 <_svfprintf_r+0x178>
   17f90:	62d0106f          	j	19dbc <_svfprintf_r+0x1fa0>
   17f94:	00140793          	addi	a5,s0,1
   17f98:	02f12023          	sw	a5,32(sp)
   17f9c:	0c0103a3          	sb	zero,199(sp)
   17fa0:	fff00b13          	li	s6,-1
   17fa4:	02012623          	sw	zero,44(sp)
   17fa8:	00000413          	li	s0,0
   17fac:	00900a93          	li	s5,9
   17fb0:	05a00b93          	li	s7,90
   17fb4:	02012783          	lw	a5,32(sp)
   17fb8:	0007c783          	lbu	a5,0(a5)
   17fbc:	00f12623          	sw	a5,12(sp)
   17fc0:	02012783          	lw	a5,32(sp)
   17fc4:	00178793          	addi	a5,a5,1
   17fc8:	02f12023          	sw	a5,32(sp)
   17fcc:	00c12783          	lw	a5,12(sp)
   17fd0:	fe078793          	addi	a5,a5,-32
   17fd4:	00fbf463          	bleu	a5,s7,17fdc <_svfprintf_r+0x1c0>
   17fd8:	2e80106f          	j	192c0 <_svfprintf_r+0x14a4>
   17fdc:	06012703          	lw	a4,96(sp)
   17fe0:	00279793          	slli	a5,a5,0x2
   17fe4:	00e787b3          	add	a5,a5,a4
   17fe8:	0007a783          	lw	a5,0(a5)
   17fec:	00078067          	jr	a5
   17ff0:	00140413          	addi	s0,s0,1
   17ff4:	f31ff06f          	j	17f24 <_svfprintf_r+0x108>
   17ff8:	000227b7          	lui	a5,0x22
   17ffc:	92478793          	addi	a5,a5,-1756 # 21924 <zeroes.4377+0x6c>
   18000:	04f12223          	sw	a5,68(sp)
   18004:	02047793          	andi	a5,s0,32
   18008:	00079463          	bnez	a5,18010 <_svfprintf_r+0x1f4>
   1800c:	0e80106f          	j	190f4 <_svfprintf_r+0x12d8>
   18010:	007c0c13          	addi	s8,s8,7
   18014:	ff8c7c13          	andi	s8,s8,-8
   18018:	008c0793          	addi	a5,s8,8
   1801c:	000c2c83          	lw	s9,0(s8)
   18020:	004c2c03          	lw	s8,4(s8)
   18024:	00f12e23          	sw	a5,28(sp)
   18028:	00147793          	andi	a5,s0,1
   1802c:	02078063          	beqz	a5,1804c <_svfprintf_r+0x230>
   18030:	018ce7b3          	or	a5,s9,s8
   18034:	00078c63          	beqz	a5,1804c <_svfprintf_r+0x230>
   18038:	03000793          	li	a5,48
   1803c:	0cf10423          	sb	a5,200(sp)
   18040:	00c14783          	lbu	a5,12(sp)
   18044:	00246413          	ori	s0,s0,2
   18048:	0cf104a3          	sb	a5,201(sp)
   1804c:	bff47413          	andi	s0,s0,-1025
   18050:	00200793          	li	a5,2
   18054:	73d0006f          	j	18f90 <_svfprintf_r+0x1174>
   18058:	00090513          	mv	a0,s2
   1805c:	ec9fd0ef          	jal	ra,15f24 <_localeconv_r>
   18060:	00452783          	lw	a5,4(a0)
   18064:	00078513          	mv	a0,a5
   18068:	02f12e23          	sw	a5,60(sp)
   1806c:	c11f80ef          	jal	ra,10c7c <strlen>
   18070:	02a12a23          	sw	a0,52(sp)
   18074:	00090513          	mv	a0,s2
   18078:	eadfd0ef          	jal	ra,15f24 <_localeconv_r>
   1807c:	00852783          	lw	a5,8(a0)
   18080:	00f12a23          	sw	a5,20(sp)
   18084:	03412783          	lw	a5,52(sp)
   18088:	f20784e3          	beqz	a5,17fb0 <_svfprintf_r+0x194>
   1808c:	01412783          	lw	a5,20(sp)
   18090:	f20780e3          	beqz	a5,17fb0 <_svfprintf_r+0x194>
   18094:	0007c783          	lbu	a5,0(a5)
   18098:	f0078ce3          	beqz	a5,17fb0 <_svfprintf_r+0x194>
   1809c:	40046413          	ori	s0,s0,1024
   180a0:	f11ff06f          	j	17fb0 <_svfprintf_r+0x194>
   180a4:	0c714783          	lbu	a5,199(sp)
   180a8:	f00794e3          	bnez	a5,17fb0 <_svfprintf_r+0x194>
   180ac:	02000793          	li	a5,32
   180b0:	0cf103a3          	sb	a5,199(sp)
   180b4:	efdff06f          	j	17fb0 <_svfprintf_r+0x194>
   180b8:	00146413          	ori	s0,s0,1
   180bc:	ef5ff06f          	j	17fb0 <_svfprintf_r+0x194>
   180c0:	000c2783          	lw	a5,0(s8)
   180c4:	004c0c13          	addi	s8,s8,4
   180c8:	02f12623          	sw	a5,44(sp)
   180cc:	ee07d2e3          	bgez	a5,17fb0 <_svfprintf_r+0x194>
   180d0:	40f007b3          	neg	a5,a5
   180d4:	02f12623          	sw	a5,44(sp)
   180d8:	00446413          	ori	s0,s0,4
   180dc:	ed5ff06f          	j	17fb0 <_svfprintf_r+0x194>
   180e0:	02b00793          	li	a5,43
   180e4:	fcdff06f          	j	180b0 <_svfprintf_r+0x294>
   180e8:	02012783          	lw	a5,32(sp)
   180ec:	02a00713          	li	a4,42
   180f0:	00178c93          	addi	s9,a5,1
   180f4:	0007c783          	lbu	a5,0(a5)
   180f8:	00f12623          	sw	a5,12(sp)
   180fc:	04e79863          	bne	a5,a4,1814c <_svfprintf_r+0x330>
   18100:	000c2b03          	lw	s6,0(s8)
   18104:	004c0793          	addi	a5,s8,4
   18108:	000b5463          	bgez	s6,18110 <_svfprintf_r+0x2f4>
   1810c:	fff00b13          	li	s6,-1
   18110:	00078c13          	mv	s8,a5
   18114:	03912023          	sw	s9,32(sp)
   18118:	e99ff06f          	j	17fb0 <_svfprintf_r+0x194>
   1811c:	000b0513          	mv	a0,s6
   18120:	00a00593          	li	a1,10
   18124:	488090ef          	jal	ra,215ac <__mulsi3>
   18128:	001c8c93          	addi	s9,s9,1
   1812c:	fffcc783          	lbu	a5,-1(s9)
   18130:	01b50b33          	add	s6,a0,s11
   18134:	00f12623          	sw	a5,12(sp)
   18138:	00c12783          	lw	a5,12(sp)
   1813c:	fd078d93          	addi	s11,a5,-48
   18140:	fdbafee3          	bleu	s11,s5,1811c <_svfprintf_r+0x300>
   18144:	03912023          	sw	s9,32(sp)
   18148:	e85ff06f          	j	17fcc <_svfprintf_r+0x1b0>
   1814c:	00000b13          	li	s6,0
   18150:	fe9ff06f          	j	18138 <_svfprintf_r+0x31c>
   18154:	08046413          	ori	s0,s0,128
   18158:	e59ff06f          	j	17fb0 <_svfprintf_r+0x194>
   1815c:	02012c83          	lw	s9,32(sp)
   18160:	02012623          	sw	zero,44(sp)
   18164:	02c12503          	lw	a0,44(sp)
   18168:	00a00593          	li	a1,10
   1816c:	001c8c93          	addi	s9,s9,1
   18170:	43c090ef          	jal	ra,215ac <__mulsi3>
   18174:	00c12783          	lw	a5,12(sp)
   18178:	fd078793          	addi	a5,a5,-48
   1817c:	00a787b3          	add	a5,a5,a0
   18180:	02f12623          	sw	a5,44(sp)
   18184:	fffcc783          	lbu	a5,-1(s9)
   18188:	00f12623          	sw	a5,12(sp)
   1818c:	fd078793          	addi	a5,a5,-48
   18190:	fcfafae3          	bleu	a5,s5,18164 <_svfprintf_r+0x348>
   18194:	fb1ff06f          	j	18144 <_svfprintf_r+0x328>
   18198:	00846413          	ori	s0,s0,8
   1819c:	e15ff06f          	j	17fb0 <_svfprintf_r+0x194>
   181a0:	02012783          	lw	a5,32(sp)
   181a4:	0007c703          	lbu	a4,0(a5)
   181a8:	06800793          	li	a5,104
   181ac:	00f71c63          	bne	a4,a5,181c4 <_svfprintf_r+0x3a8>
   181b0:	02012783          	lw	a5,32(sp)
   181b4:	20046413          	ori	s0,s0,512
   181b8:	00178793          	addi	a5,a5,1
   181bc:	02f12023          	sw	a5,32(sp)
   181c0:	df1ff06f          	j	17fb0 <_svfprintf_r+0x194>
   181c4:	04046413          	ori	s0,s0,64
   181c8:	de9ff06f          	j	17fb0 <_svfprintf_r+0x194>
   181cc:	02012783          	lw	a5,32(sp)
   181d0:	0007c703          	lbu	a4,0(a5)
   181d4:	06c00793          	li	a5,108
   181d8:	00f71c63          	bne	a4,a5,181f0 <_svfprintf_r+0x3d4>
   181dc:	02012783          	lw	a5,32(sp)
   181e0:	00178793          	addi	a5,a5,1
   181e4:	02f12023          	sw	a5,32(sp)
   181e8:	02046413          	ori	s0,s0,32
   181ec:	dc5ff06f          	j	17fb0 <_svfprintf_r+0x194>
   181f0:	01046413          	ori	s0,s0,16
   181f4:	dbdff06f          	j	17fb0 <_svfprintf_r+0x194>
   181f8:	004c0793          	addi	a5,s8,4
   181fc:	00f12e23          	sw	a5,28(sp)
   18200:	000c2783          	lw	a5,0(s8)
   18204:	0c0103a3          	sb	zero,199(sp)
   18208:	14f10623          	sb	a5,332(sp)
   1820c:	00012823          	sw	zero,16(sp)
   18210:	00100b13          	li	s6,1
   18214:	00000a93          	li	s5,0
   18218:	00000c13          	li	s8,0
   1821c:	00000b93          	li	s7,0
   18220:	00000c93          	li	s9,0
   18224:	14c10493          	addi	s1,sp,332
   18228:	03512823          	sw	s5,48(sp)
   1822c:	016ad463          	ble	s6,s5,18234 <_svfprintf_r+0x418>
   18230:	03612823          	sw	s6,48(sp)
   18234:	0c714703          	lbu	a4,199(sp)
   18238:	00070863          	beqz	a4,18248 <_svfprintf_r+0x42c>
   1823c:	03012783          	lw	a5,48(sp)
   18240:	00178793          	addi	a5,a5,1
   18244:	02f12823          	sw	a5,48(sp)
   18248:	00247d93          	andi	s11,s0,2
   1824c:	000d8863          	beqz	s11,1825c <_svfprintf_r+0x440>
   18250:	03012783          	lw	a5,48(sp)
   18254:	00278793          	addi	a5,a5,2
   18258:	02f12823          	sw	a5,48(sp)
   1825c:	08447793          	andi	a5,s0,132
   18260:	04f12423          	sw	a5,72(sp)
   18264:	06079c63          	bnez	a5,182dc <_svfprintf_r+0x4c0>
   18268:	02c12783          	lw	a5,44(sp)
   1826c:	03012703          	lw	a4,48(sp)
   18270:	40e78e33          	sub	t3,a5,a4
   18274:	07c05463          	blez	t3,182dc <_svfprintf_r+0x4c0>
   18278:	00022eb7          	lui	t4,0x22
   1827c:	01000f13          	li	t5,16
   18280:	e5ce8e93          	addi	t4,t4,-420 # 21e5c <blanks.4361>
   18284:	00700f93          	li	t6,7
   18288:	0e812683          	lw	a3,232(sp)
   1828c:	01dd2023          	sw	t4,0(s10)
   18290:	0ec12703          	lw	a4,236(sp)
   18294:	00168693          	addi	a3,a3,1
   18298:	008d0613          	addi	a2,s10,8
   1829c:	01cf5463          	ble	t3,t5,182a4 <_svfprintf_r+0x488>
   182a0:	03c0106f          	j	192dc <_svfprintf_r+0x14c0>
   182a4:	00ee0733          	add	a4,t3,a4
   182a8:	01cd2223          	sw	t3,4(s10)
   182ac:	0ee12623          	sw	a4,236(sp)
   182b0:	0ed12423          	sw	a3,232(sp)
   182b4:	00700713          	li	a4,7
   182b8:	00060d13          	mv	s10,a2
   182bc:	02d75063          	ble	a3,a4,182dc <_svfprintf_r+0x4c0>
   182c0:	0e410613          	addi	a2,sp,228
   182c4:	00098593          	mv	a1,s3
   182c8:	00090513          	mv	a0,s2
   182cc:	695020ef          	jal	ra,1b160 <__ssprint_r>
   182d0:	00050463          	beqz	a0,182d8 <_svfprintf_r+0x4bc>
   182d4:	2850106f          	j	19d58 <_svfprintf_r+0x1f3c>
   182d8:	10c10d13          	addi	s10,sp,268
   182dc:	0c714703          	lbu	a4,199(sp)
   182e0:	04070a63          	beqz	a4,18334 <_svfprintf_r+0x518>
   182e4:	0c710713          	addi	a4,sp,199
   182e8:	00ed2023          	sw	a4,0(s10)
   182ec:	00100713          	li	a4,1
   182f0:	00ed2223          	sw	a4,4(s10)
   182f4:	0ec12703          	lw	a4,236(sp)
   182f8:	00700693          	li	a3,7
   182fc:	008d0d13          	addi	s10,s10,8
   18300:	00170713          	addi	a4,a4,1
   18304:	0ee12623          	sw	a4,236(sp)
   18308:	0e812703          	lw	a4,232(sp)
   1830c:	00170713          	addi	a4,a4,1
   18310:	0ee12423          	sw	a4,232(sp)
   18314:	02e6d063          	ble	a4,a3,18334 <_svfprintf_r+0x518>
   18318:	0e410613          	addi	a2,sp,228
   1831c:	00098593          	mv	a1,s3
   18320:	00090513          	mv	a0,s2
   18324:	63d020ef          	jal	ra,1b160 <__ssprint_r>
   18328:	00050463          	beqz	a0,18330 <_svfprintf_r+0x514>
   1832c:	22d0106f          	j	19d58 <_svfprintf_r+0x1f3c>
   18330:	10c10d13          	addi	s10,sp,268
   18334:	040d8a63          	beqz	s11,18388 <_svfprintf_r+0x56c>
   18338:	0c810713          	addi	a4,sp,200
   1833c:	00ed2023          	sw	a4,0(s10)
   18340:	00200713          	li	a4,2
   18344:	00ed2223          	sw	a4,4(s10)
   18348:	0ec12703          	lw	a4,236(sp)
   1834c:	00700693          	li	a3,7
   18350:	008d0d13          	addi	s10,s10,8
   18354:	00270713          	addi	a4,a4,2
   18358:	0ee12623          	sw	a4,236(sp)
   1835c:	0e812703          	lw	a4,232(sp)
   18360:	00170713          	addi	a4,a4,1
   18364:	0ee12423          	sw	a4,232(sp)
   18368:	02e6d063          	ble	a4,a3,18388 <_svfprintf_r+0x56c>
   1836c:	0e410613          	addi	a2,sp,228
   18370:	00098593          	mv	a1,s3
   18374:	00090513          	mv	a0,s2
   18378:	5e9020ef          	jal	ra,1b160 <__ssprint_r>
   1837c:	00050463          	beqz	a0,18384 <_svfprintf_r+0x568>
   18380:	1d90106f          	j	19d58 <_svfprintf_r+0x1f3c>
   18384:	10c10d13          	addi	s10,sp,268
   18388:	04812783          	lw	a5,72(sp)
   1838c:	08000713          	li	a4,128
   18390:	06e79863          	bne	a5,a4,18400 <_svfprintf_r+0x5e4>
   18394:	02c12783          	lw	a5,44(sp)
   18398:	03012703          	lw	a4,48(sp)
   1839c:	40e78db3          	sub	s11,a5,a4
   183a0:	07b05063          	blez	s11,18400 <_svfprintf_r+0x5e4>
   183a4:	01000793          	li	a5,16
   183a8:	00700e13          	li	t3,7
   183ac:	0e812703          	lw	a4,232(sp)
   183b0:	0ec12683          	lw	a3,236(sp)
   183b4:	008d0613          	addi	a2,s10,8
   183b8:	00170713          	addi	a4,a4,1
   183bc:	77b7cce3          	blt	a5,s11,19334 <_svfprintf_r+0x1518>
   183c0:	01812783          	lw	a5,24(sp)
   183c4:	01bd2223          	sw	s11,4(s10)
   183c8:	00dd8db3          	add	s11,s11,a3
   183cc:	00fd2023          	sw	a5,0(s10)
   183d0:	0fb12623          	sw	s11,236(sp)
   183d4:	0ee12423          	sw	a4,232(sp)
   183d8:	00700693          	li	a3,7
   183dc:	00060d13          	mv	s10,a2
   183e0:	02e6d063          	ble	a4,a3,18400 <_svfprintf_r+0x5e4>
   183e4:	0e410613          	addi	a2,sp,228
   183e8:	00098593          	mv	a1,s3
   183ec:	00090513          	mv	a0,s2
   183f0:	571020ef          	jal	ra,1b160 <__ssprint_r>
   183f4:	00050463          	beqz	a0,183fc <_svfprintf_r+0x5e0>
   183f8:	1610106f          	j	19d58 <_svfprintf_r+0x1f3c>
   183fc:	10c10d13          	addi	s10,sp,268
   18400:	416a8ab3          	sub	s5,s5,s6
   18404:	07505063          	blez	s5,18464 <_svfprintf_r+0x648>
   18408:	01000d93          	li	s11,16
   1840c:	00700813          	li	a6,7
   18410:	01812783          	lw	a5,24(sp)
   18414:	0e812703          	lw	a4,232(sp)
   18418:	0ec12683          	lw	a3,236(sp)
   1841c:	00fd2023          	sw	a5,0(s10)
   18420:	00170713          	addi	a4,a4,1
   18424:	008d0613          	addi	a2,s10,8
   18428:	755dcee3          	blt	s11,s5,19384 <_svfprintf_r+0x1568>
   1842c:	015d2223          	sw	s5,4(s10)
   18430:	00da8ab3          	add	s5,s5,a3
   18434:	0f512623          	sw	s5,236(sp)
   18438:	0ee12423          	sw	a4,232(sp)
   1843c:	00700693          	li	a3,7
   18440:	00060d13          	mv	s10,a2
   18444:	02e6d063          	ble	a4,a3,18464 <_svfprintf_r+0x648>
   18448:	0e410613          	addi	a2,sp,228
   1844c:	00098593          	mv	a1,s3
   18450:	00090513          	mv	a0,s2
   18454:	50d020ef          	jal	ra,1b160 <__ssprint_r>
   18458:	00050463          	beqz	a0,18460 <_svfprintf_r+0x644>
   1845c:	0fd0106f          	j	19d58 <_svfprintf_r+0x1f3c>
   18460:	10c10d13          	addi	s10,sp,268
   18464:	10047713          	andi	a4,s0,256
   18468:	0ec12d83          	lw	s11,236(sp)
   1846c:	74071ce3          	bnez	a4,193c4 <_svfprintf_r+0x15a8>
   18470:	0e812783          	lw	a5,232(sp)
   18474:	01bb0333          	add	t1,s6,s11
   18478:	009d2023          	sw	s1,0(s10)
   1847c:	00178793          	addi	a5,a5,1
   18480:	016d2223          	sw	s6,4(s10)
   18484:	0e612623          	sw	t1,236(sp)
   18488:	0ef12423          	sw	a5,232(sp)
   1848c:	00700713          	li	a4,7
   18490:	008d0d13          	addi	s10,s10,8
   18494:	00f74463          	blt	a4,a5,1849c <_svfprintf_r+0x680>
   18498:	1f40106f          	j	1968c <_svfprintf_r+0x1870>
   1849c:	0e410613          	addi	a2,sp,228
   184a0:	00098593          	mv	a1,s3
   184a4:	00090513          	mv	a0,s2
   184a8:	4b9020ef          	jal	ra,1b160 <__ssprint_r>
   184ac:	00050463          	beqz	a0,184b4 <_svfprintf_r+0x698>
   184b0:	0a90106f          	j	19d58 <_svfprintf_r+0x1f3c>
   184b4:	10c10d13          	addi	s10,sp,268
   184b8:	1d40106f          	j	1968c <_svfprintf_r+0x1870>
   184bc:	01046413          	ori	s0,s0,16
   184c0:	02047793          	andi	a5,s0,32
   184c4:	04078e63          	beqz	a5,18520 <_svfprintf_r+0x704>
   184c8:	007c0c13          	addi	s8,s8,7
   184cc:	ff8c7c13          	andi	s8,s8,-8
   184d0:	008c0793          	addi	a5,s8,8
   184d4:	000c2c83          	lw	s9,0(s8)
   184d8:	004c2c03          	lw	s8,4(s8)
   184dc:	00f12e23          	sw	a5,28(sp)
   184e0:	000c5e63          	bgez	s8,184fc <_svfprintf_r+0x6e0>
   184e4:	41900cb3          	neg	s9,s9
   184e8:	019037b3          	snez	a5,s9
   184ec:	41800c33          	neg	s8,s8
   184f0:	40fc0c33          	sub	s8,s8,a5
   184f4:	02d00793          	li	a5,45
   184f8:	0cf103a3          	sb	a5,199(sp)
   184fc:	fff00793          	li	a5,-1
   18500:	42fb18e3          	bne	s6,a5,19130 <_svfprintf_r+0x1314>
   18504:	4a0c1ae3          	bnez	s8,191b8 <_svfprintf_r+0x139c>
   18508:	00900793          	li	a5,9
   1850c:	4b97e6e3          	bltu	a5,s9,191b8 <_svfprintf_r+0x139c>
   18510:	030c8c93          	addi	s9,s9,48
   18514:	1b9107a3          	sb	s9,431(sp)
   18518:	1af10493          	addi	s1,sp,431
   1851c:	4750006f          	j	19190 <_svfprintf_r+0x1374>
   18520:	004c0793          	addi	a5,s8,4
   18524:	00f12e23          	sw	a5,28(sp)
   18528:	01047793          	andi	a5,s0,16
   1852c:	00078863          	beqz	a5,1853c <_svfprintf_r+0x720>
   18530:	000c2c83          	lw	s9,0(s8)
   18534:	41fcdc13          	srai	s8,s9,0x1f
   18538:	fa9ff06f          	j	184e0 <_svfprintf_r+0x6c4>
   1853c:	04047793          	andi	a5,s0,64
   18540:	000c2c83          	lw	s9,0(s8)
   18544:	00078863          	beqz	a5,18554 <_svfprintf_r+0x738>
   18548:	010c9c93          	slli	s9,s9,0x10
   1854c:	410cdc93          	srai	s9,s9,0x10
   18550:	fe5ff06f          	j	18534 <_svfprintf_r+0x718>
   18554:	20047793          	andi	a5,s0,512
   18558:	fc078ee3          	beqz	a5,18534 <_svfprintf_r+0x718>
   1855c:	018c9c93          	slli	s9,s9,0x18
   18560:	418cdc93          	srai	s9,s9,0x18
   18564:	fd1ff06f          	j	18534 <_svfprintf_r+0x718>
   18568:	00847793          	andi	a5,s0,8
   1856c:	0a078a63          	beqz	a5,18620 <_svfprintf_r+0x804>
   18570:	004c0793          	addi	a5,s8,4
   18574:	00f12e23          	sw	a5,28(sp)
   18578:	000c2783          	lw	a5,0(s8)
   1857c:	0007a603          	lw	a2,0(a5)
   18580:	0047a683          	lw	a3,4(a5)
   18584:	0087a703          	lw	a4,8(a5)
   18588:	00c7a783          	lw	a5,12(a5)
   1858c:	0ec12823          	sw	a2,240(sp)
   18590:	0ed12a23          	sw	a3,244(sp)
   18594:	0ee12c23          	sw	a4,248(sp)
   18598:	0f010513          	addi	a0,sp,240
   1859c:	0ef12e23          	sw	a5,252(sp)
   185a0:	919fd0ef          	jal	ra,15eb8 <_ldcheck>
   185a4:	0ca12623          	sw	a0,204(sp)
   185a8:	00200793          	li	a5,2
   185ac:	0cf51063          	bne	a0,a5,1866c <_svfprintf_r+0x850>
   185b0:	0f012783          	lw	a5,240(sp)
   185b4:	0a010593          	addi	a1,sp,160
   185b8:	0b010513          	addi	a0,sp,176
   185bc:	0af12823          	sw	a5,176(sp)
   185c0:	0f412783          	lw	a5,244(sp)
   185c4:	0a012023          	sw	zero,160(sp)
   185c8:	0a012223          	sw	zero,164(sp)
   185cc:	0af12a23          	sw	a5,180(sp)
   185d0:	0f812783          	lw	a5,248(sp)
   185d4:	0a012423          	sw	zero,168(sp)
   185d8:	0a012623          	sw	zero,172(sp)
   185dc:	0af12c23          	sw	a5,184(sp)
   185e0:	0fc12783          	lw	a5,252(sp)
   185e4:	0af12e23          	sw	a5,188(sp)
   185e8:	4a5050ef          	jal	ra,1e28c <__letf2>
   185ec:	00055663          	bgez	a0,185f8 <_svfprintf_r+0x7dc>
   185f0:	02d00793          	li	a5,45
   185f4:	0cf103a3          	sb	a5,199(sp)
   185f8:	00c12703          	lw	a4,12(sp)
   185fc:	04700793          	li	a5,71
   18600:	06e7c063          	blt	a5,a4,18660 <_svfprintf_r+0x844>
   18604:	000224b7          	lui	s1,0x22
   18608:	90048493          	addi	s1,s1,-1792 # 21900 <zeroes.4377+0x48>
   1860c:	f7f47413          	andi	s0,s0,-129
   18610:	00012823          	sw	zero,16(sp)
   18614:	00300b13          	li	s6,3
   18618:	00000a93          	li	s5,0
   1861c:	3850006f          	j	191a0 <_svfprintf_r+0x1384>
   18620:	007c0c13          	addi	s8,s8,7
   18624:	ff8c7c13          	andi	s8,s8,-8
   18628:	000c2583          	lw	a1,0(s8)
   1862c:	004c2603          	lw	a2,4(s8)
   18630:	008c0793          	addi	a5,s8,8
   18634:	0b010513          	addi	a0,sp,176
   18638:	00f12e23          	sw	a5,28(sp)
   1863c:	1c9080ef          	jal	ra,21004 <__extenddftf2>
   18640:	0b012783          	lw	a5,176(sp)
   18644:	0ef12823          	sw	a5,240(sp)
   18648:	0b412783          	lw	a5,180(sp)
   1864c:	0ef12a23          	sw	a5,244(sp)
   18650:	0b812783          	lw	a5,184(sp)
   18654:	0ef12c23          	sw	a5,248(sp)
   18658:	0bc12783          	lw	a5,188(sp)
   1865c:	f3dff06f          	j	18598 <_svfprintf_r+0x77c>
   18660:	000224b7          	lui	s1,0x22
   18664:	90448493          	addi	s1,s1,-1788 # 21904 <zeroes.4377+0x4c>
   18668:	fa5ff06f          	j	1860c <_svfprintf_r+0x7f0>
   1866c:	00100793          	li	a5,1
   18670:	02f51463          	bne	a0,a5,18698 <_svfprintf_r+0x87c>
   18674:	00c12703          	lw	a4,12(sp)
   18678:	04700793          	li	a5,71
   1867c:	00e7c863          	blt	a5,a4,1868c <_svfprintf_r+0x870>
   18680:	000224b7          	lui	s1,0x22
   18684:	90848493          	addi	s1,s1,-1784 # 21908 <zeroes.4377+0x50>
   18688:	f85ff06f          	j	1860c <_svfprintf_r+0x7f0>
   1868c:	000224b7          	lui	s1,0x22
   18690:	90c48493          	addi	s1,s1,-1780 # 2190c <zeroes.4377+0x54>
   18694:	f79ff06f          	j	1860c <_svfprintf_r+0x7f0>
   18698:	00c12783          	lw	a5,12(sp)
   1869c:	fdf7fb93          	andi	s7,a5,-33
   186a0:	04100793          	li	a5,65
   186a4:	08fb9e63          	bne	s7,a5,18740 <_svfprintf_r+0x924>
   186a8:	00c12683          	lw	a3,12(sp)
   186ac:	03000793          	li	a5,48
   186b0:	0cf10423          	sb	a5,200(sp)
   186b4:	06100713          	li	a4,97
   186b8:	05800793          	li	a5,88
   186bc:	00e69463          	bne	a3,a4,186c4 <_svfprintf_r+0x8a8>
   186c0:	07800793          	li	a5,120
   186c4:	0cf104a3          	sb	a5,201(sp)
   186c8:	06300793          	li	a5,99
   186cc:	00246413          	ori	s0,s0,2
   186d0:	5567d463          	ble	s6,a5,18c18 <_svfprintf_r+0xdfc>
   186d4:	001b0593          	addi	a1,s6,1
   186d8:	00090513          	mv	a0,s2
   186dc:	cd1f70ef          	jal	ra,103ac <_malloc_r>
   186e0:	00050493          	mv	s1,a0
   186e4:	54051063          	bnez	a0,18c24 <_svfprintf_r+0xe08>
   186e8:	00c9d783          	lhu	a5,12(s3)
   186ec:	0407e793          	ori	a5,a5,64
   186f0:	00f99623          	sh	a5,12(s3)
   186f4:	00c9d783          	lhu	a5,12(s3)
   186f8:	0407f793          	andi	a5,a5,64
   186fc:	fc079263          	bnez	a5,17ec0 <_svfprintf_r+0xa4>
   18700:	1ec12083          	lw	ra,492(sp)
   18704:	1e812403          	lw	s0,488(sp)
   18708:	02812503          	lw	a0,40(sp)
   1870c:	1e412483          	lw	s1,484(sp)
   18710:	1e012903          	lw	s2,480(sp)
   18714:	1dc12983          	lw	s3,476(sp)
   18718:	1d812a03          	lw	s4,472(sp)
   1871c:	1d412a83          	lw	s5,468(sp)
   18720:	1d012b03          	lw	s6,464(sp)
   18724:	1cc12b83          	lw	s7,460(sp)
   18728:	1c812c03          	lw	s8,456(sp)
   1872c:	1c412c83          	lw	s9,452(sp)
   18730:	1c012d03          	lw	s10,448(sp)
   18734:	1bc12d83          	lw	s11,444(sp)
   18738:	1f010113          	addi	sp,sp,496
   1873c:	00008067          	ret
   18740:	fff00793          	li	a5,-1
   18744:	4efb0463          	beq	s6,a5,18c2c <_svfprintf_r+0xe10>
   18748:	04700793          	li	a5,71
   1874c:	00012823          	sw	zero,16(sp)
   18750:	00fb9463          	bne	s7,a5,18758 <_svfprintf_r+0x93c>
   18754:	4e0b0263          	beqz	s6,18c38 <_svfprintf_r+0xe1c>
   18758:	0fc12a83          	lw	s5,252(sp)
   1875c:	10046793          	ori	a5,s0,256
   18760:	02f12823          	sw	a5,48(sp)
   18764:	04012423          	sw	zero,72(sp)
   18768:	0f012e03          	lw	t3,240(sp)
   1876c:	0f412d83          	lw	s11,244(sp)
   18770:	0f812c83          	lw	s9,248(sp)
   18774:	000ada63          	bgez	s5,18788 <_svfprintf_r+0x96c>
   18778:	800007b7          	lui	a5,0x80000
   1877c:	0157cab3          	xor	s5,a5,s5
   18780:	02d00793          	li	a5,45
   18784:	04f12423          	sw	a5,72(sp)
   18788:	04100793          	li	a5,65
   1878c:	50fb9063          	bne	s7,a5,18c8c <_svfprintf_r+0xe70>
   18790:	0b010513          	addi	a0,sp,176
   18794:	0bc12823          	sw	t3,176(sp)
   18798:	0bb12a23          	sw	s11,180(sp)
   1879c:	0b912c23          	sw	s9,184(sp)
   187a0:	0b512e23          	sw	s5,188(sp)
   187a4:	2b1080ef          	jal	ra,21254 <__trunctfdf2>
   187a8:	0cc10613          	addi	a2,sp,204
   187ac:	9ccff0ef          	jal	ra,17978 <frexp>
   187b0:	00058613          	mv	a2,a1
   187b4:	00050593          	mv	a1,a0
   187b8:	0b010513          	addi	a0,sp,176
   187bc:	049080ef          	jal	ra,21004 <__extenddftf2>
   187c0:	0b012583          	lw	a1,176(sp)
   187c4:	000227b7          	lui	a5,0x22
   187c8:	8d078793          	addi	a5,a5,-1840 # 218d0 <zeroes.4377+0x18>
   187cc:	08b12823          	sw	a1,144(sp)
   187d0:	0b412583          	lw	a1,180(sp)
   187d4:	0007a603          	lw	a2,0(a5)
   187d8:	0047a683          	lw	a3,4(a5)
   187dc:	08b12a23          	sw	a1,148(sp)
   187e0:	0b812583          	lw	a1,184(sp)
   187e4:	0087a703          	lw	a4,8(a5)
   187e8:	00c7a783          	lw	a5,12(a5)
   187ec:	08b12c23          	sw	a1,152(sp)
   187f0:	0bc12583          	lw	a1,188(sp)
   187f4:	08c12023          	sw	a2,128(sp)
   187f8:	0a010513          	addi	a0,sp,160
   187fc:	08b12e23          	sw	a1,156(sp)
   18800:	08010613          	addi	a2,sp,128
   18804:	09010593          	addi	a1,sp,144
   18808:	08d12223          	sw	a3,132(sp)
   1880c:	08e12423          	sw	a4,136(sp)
   18810:	08f12623          	sw	a5,140(sp)
   18814:	3d9050ef          	jal	ra,1e3ec <__multf3>
   18818:	0a012383          	lw	t2,160(sp)
   1881c:	0a412803          	lw	a6,164(sp)
   18820:	0a812d83          	lw	s11,168(sp)
   18824:	0ac12c83          	lw	s9,172(sp)
   18828:	0a010593          	addi	a1,sp,160
   1882c:	0b010513          	addi	a0,sp,176
   18830:	0a712823          	sw	t2,176(sp)
   18834:	04712823          	sw	t2,80(sp)
   18838:	0b012a23          	sw	a6,180(sp)
   1883c:	05012623          	sw	a6,76(sp)
   18840:	0bb12c23          	sw	s11,184(sp)
   18844:	0b912e23          	sw	s9,188(sp)
   18848:	0a012023          	sw	zero,160(sp)
   1884c:	0a012223          	sw	zero,164(sp)
   18850:	0a012423          	sw	zero,168(sp)
   18854:	0a012623          	sw	zero,172(sp)
   18858:	009050ef          	jal	ra,1e060 <__eqtf2>
   1885c:	04c12803          	lw	a6,76(sp)
   18860:	05012383          	lw	t2,80(sp)
   18864:	00051663          	bnez	a0,18870 <_svfprintf_r+0xa54>
   18868:	00100793          	li	a5,1
   1886c:	0cf12623          	sw	a5,204(sp)
   18870:	00c12703          	lw	a4,12(sp)
   18874:	06100793          	li	a5,97
   18878:	3cf71663          	bne	a4,a5,18c44 <_svfprintf_r+0xe28>
   1887c:	00022ab7          	lui	s5,0x22
   18880:	910a8a93          	addi	s5,s5,-1776 # 21910 <zeroes.4377+0x58>
   18884:	00022737          	lui	a4,0x22
   18888:	8e070713          	addi	a4,a4,-1824 # 218e0 <zeroes.4377+0x28>
   1888c:	00072783          	lw	a5,0(a4)
   18890:	fffb0e13          	addi	t3,s6,-1
   18894:	00048c13          	mv	s8,s1
   18898:	04f12823          	sw	a5,80(sp)
   1889c:	00472783          	lw	a5,4(a4)
   188a0:	04f12a23          	sw	a5,84(sp)
   188a4:	00872783          	lw	a5,8(a4)
   188a8:	04f12c23          	sw	a5,88(sp)
   188ac:	00c72783          	lw	a5,12(a4)
   188b0:	04f12e23          	sw	a5,92(sp)
   188b4:	05012783          	lw	a5,80(sp)
   188b8:	0a010593          	addi	a1,sp,160
   188bc:	09010613          	addi	a2,sp,144
   188c0:	08f12823          	sw	a5,144(sp)
   188c4:	05412783          	lw	a5,84(sp)
   188c8:	0b010513          	addi	a0,sp,176
   188cc:	07c12423          	sw	t3,104(sp)
   188d0:	08f12a23          	sw	a5,148(sp)
   188d4:	05812783          	lw	a5,88(sp)
   188d8:	0a712023          	sw	t2,160(sp)
   188dc:	0b012223          	sw	a6,164(sp)
   188e0:	08f12c23          	sw	a5,152(sp)
   188e4:	05c12783          	lw	a5,92(sp)
   188e8:	0bb12423          	sw	s11,168(sp)
   188ec:	0b912623          	sw	s9,172(sp)
   188f0:	08f12e23          	sw	a5,156(sp)
   188f4:	2f9050ef          	jal	ra,1e3ec <__multf3>
   188f8:	0b012603          	lw	a2,176(sp)
   188fc:	0b412683          	lw	a3,180(sp)
   18900:	0b010513          	addi	a0,sp,176
   18904:	06c12223          	sw	a2,100(sp)
   18908:	04d12623          	sw	a3,76(sp)
   1890c:	414080ef          	jal	ra,20d20 <__fixtfsi>
   18910:	00050593          	mv	a1,a0
   18914:	00050a13          	mv	s4,a0
   18918:	0b010513          	addi	a0,sp,176
   1891c:	0b812d83          	lw	s11,184(sp)
   18920:	0bc12c83          	lw	s9,188(sp)
   18924:	560080ef          	jal	ra,20e84 <__floatsitf>
   18928:	0b012703          	lw	a4,176(sp)
   1892c:	06412603          	lw	a2,100(sp)
   18930:	04c12683          	lw	a3,76(sp)
   18934:	08e12023          	sw	a4,128(sp)
   18938:	0b412703          	lw	a4,180(sp)
   1893c:	08c12823          	sw	a2,144(sp)
   18940:	09010593          	addi	a1,sp,144
   18944:	08e12223          	sw	a4,132(sp)
   18948:	0b812703          	lw	a4,184(sp)
   1894c:	08010613          	addi	a2,sp,128
   18950:	0a010513          	addi	a0,sp,160
   18954:	08e12423          	sw	a4,136(sp)
   18958:	0bc12703          	lw	a4,188(sp)
   1895c:	09b12c23          	sw	s11,152(sp)
   18960:	09912e23          	sw	s9,156(sp)
   18964:	08e12623          	sw	a4,140(sp)
   18968:	08d12a23          	sw	a3,148(sp)
   1896c:	6b1060ef          	jal	ra,1f81c <__subtf3>
   18970:	014a8733          	add	a4,s5,s4
   18974:	00074703          	lbu	a4,0(a4)
   18978:	06812e03          	lw	t3,104(sp)
   1897c:	0a812f03          	lw	t5,168(sp)
   18980:	0ac12e83          	lw	t4,172(sp)
   18984:	001c0c13          	addi	s8,s8,1
   18988:	0a012283          	lw	t0,160(sp)
   1898c:	0a412f83          	lw	t6,164(sp)
   18990:	05c12623          	sw	t3,76(sp)
   18994:	feec0fa3          	sb	a4,-1(s8)
   18998:	fff00713          	li	a4,-1
   1899c:	000f0d93          	mv	s11,t5
   189a0:	000e8c93          	mv	s9,t4
   189a4:	06ee0863          	beq	t3,a4,18a14 <_svfprintf_r+0xbf8>
   189a8:	fffe0e13          	addi	t3,t3,-1
   189ac:	0a010593          	addi	a1,sp,160
   189b0:	0b010513          	addi	a0,sp,176
   189b4:	07d12e23          	sw	t4,124(sp)
   189b8:	07e12c23          	sw	t5,120(sp)
   189bc:	07f12a23          	sw	t6,116(sp)
   189c0:	06512823          	sw	t0,112(sp)
   189c4:	07c12623          	sw	t3,108(sp)
   189c8:	0a512823          	sw	t0,176(sp)
   189cc:	06512423          	sw	t0,104(sp)
   189d0:	0bf12a23          	sw	t6,180(sp)
   189d4:	07f12223          	sw	t6,100(sp)
   189d8:	0be12c23          	sw	t5,184(sp)
   189dc:	0bd12e23          	sw	t4,188(sp)
   189e0:	0a012023          	sw	zero,160(sp)
   189e4:	0a012223          	sw	zero,164(sp)
   189e8:	0a012423          	sw	zero,168(sp)
   189ec:	0a012623          	sw	zero,172(sp)
   189f0:	670050ef          	jal	ra,1e060 <__eqtf2>
   189f4:	06412803          	lw	a6,100(sp)
   189f8:	06812383          	lw	t2,104(sp)
   189fc:	06c12e03          	lw	t3,108(sp)
   18a00:	07012283          	lw	t0,112(sp)
   18a04:	07412f83          	lw	t6,116(sp)
   18a08:	07812f03          	lw	t5,120(sp)
   18a0c:	07c12e83          	lw	t4,124(sp)
   18a10:	ea0512e3          	bnez	a0,188b4 <_svfprintf_r+0xa98>
   18a14:	00022737          	lui	a4,0x22
   18a18:	8f070713          	addi	a4,a4,-1808 # 218f0 <zeroes.4377+0x38>
   18a1c:	00072603          	lw	a2,0(a4)
   18a20:	00472683          	lw	a3,4(a4)
   18a24:	00872d83          	lw	s11,8(a4)
   18a28:	00c72c83          	lw	s9,12(a4)
   18a2c:	0a010593          	addi	a1,sp,160
   18a30:	0b010513          	addi	a0,sp,176
   18a34:	0a512823          	sw	t0,176(sp)
   18a38:	06512423          	sw	t0,104(sp)
   18a3c:	0bf12a23          	sw	t6,180(sp)
   18a40:	07f12223          	sw	t6,100(sp)
   18a44:	0be12c23          	sw	t5,184(sp)
   18a48:	05e12e23          	sw	t5,92(sp)
   18a4c:	0bd12e23          	sw	t4,188(sp)
   18a50:	05d12c23          	sw	t4,88(sp)
   18a54:	0ac12023          	sw	a2,160(sp)
   18a58:	04c12a23          	sw	a2,84(sp)
   18a5c:	0ad12223          	sw	a3,164(sp)
   18a60:	04d12823          	sw	a3,80(sp)
   18a64:	0bb12423          	sw	s11,168(sp)
   18a68:	0b912623          	sw	s9,172(sp)
   18a6c:	6c0050ef          	jal	ra,1e12c <__getf2>
   18a70:	04a04a63          	bgtz	a0,18ac4 <_svfprintf_r+0xca8>
   18a74:	06812283          	lw	t0,104(sp)
   18a78:	06412f83          	lw	t6,100(sp)
   18a7c:	05c12f03          	lw	t5,92(sp)
   18a80:	05812e83          	lw	t4,88(sp)
   18a84:	05412603          	lw	a2,84(sp)
   18a88:	05012683          	lw	a3,80(sp)
   18a8c:	0a010593          	addi	a1,sp,160
   18a90:	0b010513          	addi	a0,sp,176
   18a94:	0a512823          	sw	t0,176(sp)
   18a98:	0bf12a23          	sw	t6,180(sp)
   18a9c:	0be12c23          	sw	t5,184(sp)
   18aa0:	0bd12e23          	sw	t4,188(sp)
   18aa4:	0ac12023          	sw	a2,160(sp)
   18aa8:	0ad12223          	sw	a3,164(sp)
   18aac:	0bb12423          	sw	s11,168(sp)
   18ab0:	0b912623          	sw	s9,172(sp)
   18ab4:	5ac050ef          	jal	ra,1e060 <__eqtf2>
   18ab8:	1c051063          	bnez	a0,18c78 <_svfprintf_r+0xe5c>
   18abc:	001a7a13          	andi	s4,s4,1
   18ac0:	1a0a0c63          	beqz	s4,18c78 <_svfprintf_r+0xe5c>
   18ac4:	00fac603          	lbu	a2,15(s5)
   18ac8:	0d812e23          	sw	s8,220(sp)
   18acc:	03000593          	li	a1,48
   18ad0:	0dc12683          	lw	a3,220(sp)
   18ad4:	fff68713          	addi	a4,a3,-1
   18ad8:	0ce12e23          	sw	a4,220(sp)
   18adc:	fff6c703          	lbu	a4,-1(a3)
   18ae0:	16c70863          	beq	a4,a2,18c50 <_svfprintf_r+0xe34>
   18ae4:	03900613          	li	a2,57
   18ae8:	16c71863          	bne	a4,a2,18c58 <_svfprintf_r+0xe3c>
   18aec:	00aac703          	lbu	a4,10(s5)
   18af0:	fee68fa3          	sb	a4,-1(a3)
   18af4:	000c0a13          	mv	s4,s8
   18af8:	04700713          	li	a4,71
   18afc:	409a0a33          	sub	s4,s4,s1
   18b00:	0cc12c83          	lw	s9,204(sp)
   18b04:	2aeb9a63          	bne	s7,a4,18db8 <_svfprintf_r+0xf9c>
   18b08:	ffd00713          	li	a4,-3
   18b0c:	00ecc463          	blt	s9,a4,18b14 <_svfprintf_r+0xcf8>
   18b10:	339b5863          	ble	s9,s6,18e40 <_svfprintf_r+0x1024>
   18b14:	00c12783          	lw	a5,12(sp)
   18b18:	ffe78793          	addi	a5,a5,-2
   18b1c:	00f12623          	sw	a5,12(sp)
   18b20:	00c12783          	lw	a5,12(sp)
   18b24:	fffc8a93          	addi	s5,s9,-1
   18b28:	0d512623          	sw	s5,204(sp)
   18b2c:	fdf7f693          	andi	a3,a5,-33
   18b30:	04100593          	li	a1,65
   18b34:	00c14703          	lbu	a4,12(sp)
   18b38:	00000613          	li	a2,0
   18b3c:	00b69863          	bne	a3,a1,18b4c <_svfprintf_r+0xd30>
   18b40:	00f70713          	addi	a4,a4,15
   18b44:	0ff77713          	andi	a4,a4,255
   18b48:	00100613          	li	a2,1
   18b4c:	0ce10a23          	sb	a4,212(sp)
   18b50:	02b00793          	li	a5,43
   18b54:	000ad863          	bgez	s5,18b64 <_svfprintf_r+0xd48>
   18b58:	00100a93          	li	s5,1
   18b5c:	419a8ab3          	sub	s5,s5,s9
   18b60:	02d00793          	li	a5,45
   18b64:	0cf10aa3          	sb	a5,213(sp)
   18b68:	00900793          	li	a5,9
   18b6c:	2957dc63          	ble	s5,a5,18e04 <_svfprintf_r+0xfe8>
   18b70:	0e310b93          	addi	s7,sp,227
   18b74:	000b8c93          	mv	s9,s7
   18b78:	00900d93          	li	s11,9
   18b7c:	00a00593          	li	a1,10
   18b80:	000a8513          	mv	a0,s5
   18b84:	2d1080ef          	jal	ra,21654 <__modsi3>
   18b88:	03050513          	addi	a0,a0,48
   18b8c:	feab8fa3          	sb	a0,-1(s7)
   18b90:	00a00593          	li	a1,10
   18b94:	000a8513          	mv	a0,s5
   18b98:	239080ef          	jal	ra,215d0 <__divsi3>
   18b9c:	fffb8c13          	addi	s8,s7,-1
   18ba0:	00050a93          	mv	s5,a0
   18ba4:	24adc263          	blt	s11,a0,18de8 <_svfprintf_r+0xfcc>
   18ba8:	03050a93          	addi	s5,a0,48
   18bac:	ffeb8b93          	addi	s7,s7,-2
   18bb0:	ff5c0fa3          	sb	s5,-1(s8)
   18bb4:	0d610793          	addi	a5,sp,214
   18bb8:	239bec63          	bltu	s7,s9,18df0 <_svfprintf_r+0xfd4>
   18bbc:	0d410713          	addi	a4,sp,212
   18bc0:	40e787b3          	sub	a5,a5,a4
   18bc4:	04f12023          	sw	a5,64(sp)
   18bc8:	01478b33          	add	s6,a5,s4
   18bcc:	00100793          	li	a5,1
   18bd0:	0147c663          	blt	a5,s4,18bdc <_svfprintf_r+0xdc0>
   18bd4:	00147793          	andi	a5,s0,1
   18bd8:	00078663          	beqz	a5,18be4 <_svfprintf_r+0xdc8>
   18bdc:	02412783          	lw	a5,36(sp)
   18be0:	00fb0b33          	add	s6,s6,a5
   18be4:	bff47413          	andi	s0,s0,-1025
   18be8:	10046793          	ori	a5,s0,256
   18bec:	02f12823          	sw	a5,48(sp)
   18bf0:	00000c13          	li	s8,0
   18bf4:	00000b93          	li	s7,0
   18bf8:	00000c93          	li	s9,0
   18bfc:	04812783          	lw	a5,72(sp)
   18c00:	00078663          	beqz	a5,18c0c <_svfprintf_r+0xdf0>
   18c04:	02d00713          	li	a4,45
   18c08:	0ce103a3          	sb	a4,199(sp)
   18c0c:	03012403          	lw	s0,48(sp)
   18c10:	00000a93          	li	s5,0
   18c14:	e14ff06f          	j	18228 <_svfprintf_r+0x40c>
   18c18:	00012823          	sw	zero,16(sp)
   18c1c:	14c10493          	addi	s1,sp,332
   18c20:	b39ff06f          	j	18758 <_svfprintf_r+0x93c>
   18c24:	00a12823          	sw	a0,16(sp)
   18c28:	b31ff06f          	j	18758 <_svfprintf_r+0x93c>
   18c2c:	00012823          	sw	zero,16(sp)
   18c30:	00600b13          	li	s6,6
   18c34:	b25ff06f          	j	18758 <_svfprintf_r+0x93c>
   18c38:	01612823          	sw	s6,16(sp)
   18c3c:	00100b13          	li	s6,1
   18c40:	b19ff06f          	j	18758 <_svfprintf_r+0x93c>
   18c44:	00022ab7          	lui	s5,0x22
   18c48:	924a8a93          	addi	s5,s5,-1756 # 21924 <zeroes.4377+0x6c>
   18c4c:	c39ff06f          	j	18884 <_svfprintf_r+0xa68>
   18c50:	feb68fa3          	sb	a1,-1(a3)
   18c54:	e7dff06f          	j	18ad0 <_svfprintf_r+0xcb4>
   18c58:	00170713          	addi	a4,a4,1
   18c5c:	0ff77713          	andi	a4,a4,255
   18c60:	e91ff06f          	j	18af0 <_svfprintf_r+0xcd4>
   18c64:	001a0a13          	addi	s4,s4,1
   18c68:	feea0fa3          	sb	a4,-1(s4)
   18c6c:	414c07b3          	sub	a5,s8,s4
   18c70:	fe07dae3          	bgez	a5,18c64 <_svfprintf_r+0xe48>
   18c74:	e85ff06f          	j	18af8 <_svfprintf_r+0xcdc>
   18c78:	04c12783          	lw	a5,76(sp)
   18c7c:	000c0a13          	mv	s4,s8
   18c80:	03000713          	li	a4,48
   18c84:	00fc0c33          	add	s8,s8,a5
   18c88:	fe5ff06f          	j	18c6c <_svfprintf_r+0xe50>
   18c8c:	04600793          	li	a5,70
   18c90:	00fb8e63          	beq	s7,a5,18cac <_svfprintf_r+0xe90>
   18c94:	04500793          	li	a5,69
   18c98:	001b0c13          	addi	s8,s6,1
   18c9c:	00fb8463          	beq	s7,a5,18ca4 <_svfprintf_r+0xe88>
   18ca0:	000b0c13          	mv	s8,s6
   18ca4:	00200613          	li	a2,2
   18ca8:	00c0006f          	j	18cb4 <_svfprintf_r+0xe98>
   18cac:	000b0c13          	mv	s8,s6
   18cb0:	00300613          	li	a2,3
   18cb4:	0d010793          	addi	a5,sp,208
   18cb8:	0dc10813          	addi	a6,sp,220
   18cbc:	0cc10713          	addi	a4,sp,204
   18cc0:	000c0693          	mv	a3,s8
   18cc4:	0b010593          	addi	a1,sp,176
   18cc8:	00090513          	mv	a0,s2
   18ccc:	0bc12823          	sw	t3,176(sp)
   18cd0:	05c12623          	sw	t3,76(sp)
   18cd4:	0bb12a23          	sw	s11,180(sp)
   18cd8:	0b912c23          	sw	s9,184(sp)
   18cdc:	0b512e23          	sw	s5,188(sp)
   18ce0:	d84fc0ef          	jal	ra,15264 <_ldtoa_r>
   18ce4:	04700793          	li	a5,71
   18ce8:	00050493          	mv	s1,a0
   18cec:	04c12e03          	lw	t3,76(sp)
   18cf0:	00fb9663          	bne	s7,a5,18cfc <_svfprintf_r+0xee0>
   18cf4:	00147793          	andi	a5,s0,1
   18cf8:	0a078063          	beqz	a5,18d98 <_svfprintf_r+0xf7c>
   18cfc:	04600793          	li	a5,70
   18d00:	01848a33          	add	s4,s1,s8
   18d04:	04fb9e63          	bne	s7,a5,18d60 <_svfprintf_r+0xf44>
   18d08:	0004c703          	lbu	a4,0(s1)
   18d0c:	03000793          	li	a5,48
   18d10:	04f71463          	bne	a4,a5,18d58 <_svfprintf_r+0xf3c>
   18d14:	0a010593          	addi	a1,sp,160
   18d18:	0b010513          	addi	a0,sp,176
   18d1c:	0bc12823          	sw	t3,176(sp)
   18d20:	05c12623          	sw	t3,76(sp)
   18d24:	0bb12a23          	sw	s11,180(sp)
   18d28:	0b912c23          	sw	s9,184(sp)
   18d2c:	0b512e23          	sw	s5,188(sp)
   18d30:	0a012023          	sw	zero,160(sp)
   18d34:	0a012223          	sw	zero,164(sp)
   18d38:	0a012423          	sw	zero,168(sp)
   18d3c:	0a012623          	sw	zero,172(sp)
   18d40:	320050ef          	jal	ra,1e060 <__eqtf2>
   18d44:	04c12e03          	lw	t3,76(sp)
   18d48:	00050863          	beqz	a0,18d58 <_svfprintf_r+0xf3c>
   18d4c:	00100793          	li	a5,1
   18d50:	41878c33          	sub	s8,a5,s8
   18d54:	0d812623          	sw	s8,204(sp)
   18d58:	0cc12783          	lw	a5,204(sp)
   18d5c:	00fa0a33          	add	s4,s4,a5
   18d60:	0a010593          	addi	a1,sp,160
   18d64:	0b010513          	addi	a0,sp,176
   18d68:	0bc12823          	sw	t3,176(sp)
   18d6c:	0bb12a23          	sw	s11,180(sp)
   18d70:	0b912c23          	sw	s9,184(sp)
   18d74:	0b512e23          	sw	s5,188(sp)
   18d78:	0a012023          	sw	zero,160(sp)
   18d7c:	0a012223          	sw	zero,164(sp)
   18d80:	0a012423          	sw	zero,168(sp)
   18d84:	0a012623          	sw	zero,172(sp)
   18d88:	2d8050ef          	jal	ra,1e060 <__eqtf2>
   18d8c:	03000713          	li	a4,48
   18d90:	00051e63          	bnez	a0,18dac <_svfprintf_r+0xf90>
   18d94:	0d412e23          	sw	s4,220(sp)
   18d98:	0dc12a03          	lw	s4,220(sp)
   18d9c:	d5dff06f          	j	18af8 <_svfprintf_r+0xcdc>
   18da0:	00178693          	addi	a3,a5,1
   18da4:	0cd12e23          	sw	a3,220(sp)
   18da8:	00e78023          	sb	a4,0(a5)
   18dac:	0dc12783          	lw	a5,220(sp)
   18db0:	ff47e8e3          	bltu	a5,s4,18da0 <_svfprintf_r+0xf84>
   18db4:	fe5ff06f          	j	18d98 <_svfprintf_r+0xf7c>
   18db8:	04600713          	li	a4,70
   18dbc:	d6eb92e3          	bne	s7,a4,18b20 <_svfprintf_r+0xd04>
   18dc0:	07905463          	blez	s9,18e28 <_svfprintf_r+0x100c>
   18dc4:	000b1663          	bnez	s6,18dd0 <_svfprintf_r+0xfb4>
   18dc8:	00147713          	andi	a4,s0,1
   18dcc:	0c070663          	beqz	a4,18e98 <_svfprintf_r+0x107c>
   18dd0:	02412783          	lw	a5,36(sp)
   18dd4:	00fc8733          	add	a4,s9,a5
   18dd8:	00eb0b33          	add	s6,s6,a4
   18ddc:	06600793          	li	a5,102
   18de0:	00f12623          	sw	a5,12(sp)
   18de4:	0980006f          	j	18e7c <_svfprintf_r+0x1060>
   18de8:	000c0b93          	mv	s7,s8
   18dec:	d91ff06f          	j	18b7c <_svfprintf_r+0xd60>
   18df0:	001b8b93          	addi	s7,s7,1
   18df4:	fffbc703          	lbu	a4,-1(s7)
   18df8:	00178793          	addi	a5,a5,1
   18dfc:	fee78fa3          	sb	a4,-1(a5)
   18e00:	db9ff06f          	j	18bb8 <_svfprintf_r+0xd9c>
   18e04:	0d610713          	addi	a4,sp,214
   18e08:	00061863          	bnez	a2,18e18 <_svfprintf_r+0xffc>
   18e0c:	03000793          	li	a5,48
   18e10:	0cf10b23          	sb	a5,214(sp)
   18e14:	0d710713          	addi	a4,sp,215
   18e18:	030a8a93          	addi	s5,s5,48
   18e1c:	00170793          	addi	a5,a4,1
   18e20:	01570023          	sb	s5,0(a4)
   18e24:	d99ff06f          	j	18bbc <_svfprintf_r+0xda0>
   18e28:	000b1663          	bnez	s6,18e34 <_svfprintf_r+0x1018>
   18e2c:	00147713          	andi	a4,s0,1
   18e30:	06070863          	beqz	a4,18ea0 <_svfprintf_r+0x1084>
   18e34:	02412783          	lw	a5,36(sp)
   18e38:	00178713          	addi	a4,a5,1
   18e3c:	f9dff06f          	j	18dd8 <_svfprintf_r+0xfbc>
   18e40:	034cc063          	blt	s9,s4,18e60 <_svfprintf_r+0x1044>
   18e44:	00147713          	andi	a4,s0,1
   18e48:	000c8b13          	mv	s6,s9
   18e4c:	00070663          	beqz	a4,18e58 <_svfprintf_r+0x103c>
   18e50:	02412783          	lw	a5,36(sp)
   18e54:	00fc8b33          	add	s6,s9,a5
   18e58:	06700793          	li	a5,103
   18e5c:	f85ff06f          	j	18de0 <_svfprintf_r+0xfc4>
   18e60:	02412783          	lw	a5,36(sp)
   18e64:	00fa0b33          	add	s6,s4,a5
   18e68:	06700793          	li	a5,103
   18e6c:	00f12623          	sw	a5,12(sp)
   18e70:	01904663          	bgtz	s9,18e7c <_svfprintf_r+0x1060>
   18e74:	419b0333          	sub	t1,s6,s9
   18e78:	00130b13          	addi	s6,t1,1
   18e7c:	40047b93          	andi	s7,s0,1024
   18e80:	00000c13          	li	s8,0
   18e84:	d60b8ce3          	beqz	s7,18bfc <_svfprintf_r+0xde0>
   18e88:	00000b93          	li	s7,0
   18e8c:	d79058e3          	blez	s9,18bfc <_svfprintf_r+0xde0>
   18e90:	0ff00693          	li	a3,255
   18e94:	03c0006f          	j	18ed0 <_svfprintf_r+0x10b4>
   18e98:	000c8b13          	mv	s6,s9
   18e9c:	f41ff06f          	j	18ddc <_svfprintf_r+0xfc0>
   18ea0:	06600793          	li	a5,102
   18ea4:	00f12623          	sw	a5,12(sp)
   18ea8:	00100b13          	li	s6,1
   18eac:	fd1ff06f          	j	18e7c <_svfprintf_r+0x1060>
   18eb0:	03975663          	ble	s9,a4,18edc <_svfprintf_r+0x10c0>
   18eb4:	01412783          	lw	a5,20(sp)
   18eb8:	40ec8cb3          	sub	s9,s9,a4
   18ebc:	0017c703          	lbu	a4,1(a5)
   18ec0:	02070863          	beqz	a4,18ef0 <_svfprintf_r+0x10d4>
   18ec4:	00178793          	addi	a5,a5,1
   18ec8:	001b8b93          	addi	s7,s7,1
   18ecc:	00f12a23          	sw	a5,20(sp)
   18ed0:	01412783          	lw	a5,20(sp)
   18ed4:	0007c703          	lbu	a4,0(a5)
   18ed8:	fcd71ce3          	bne	a4,a3,18eb0 <_svfprintf_r+0x1094>
   18edc:	03412583          	lw	a1,52(sp)
   18ee0:	018b8533          	add	a0,s7,s8
   18ee4:	6c8080ef          	jal	ra,215ac <__mulsi3>
   18ee8:	01650b33          	add	s6,a0,s6
   18eec:	d11ff06f          	j	18bfc <_svfprintf_r+0xde0>
   18ef0:	001c0c13          	addi	s8,s8,1
   18ef4:	fddff06f          	j	18ed0 <_svfprintf_r+0x10b4>
   18ef8:	004c0713          	addi	a4,s8,4
   18efc:	00e12e23          	sw	a4,28(sp)
   18f00:	02047713          	andi	a4,s0,32
   18f04:	000c2783          	lw	a5,0(s8)
   18f08:	02070063          	beqz	a4,18f28 <_svfprintf_r+0x110c>
   18f0c:	02812703          	lw	a4,40(sp)
   18f10:	00e7a023          	sw	a4,0(a5)
   18f14:	41f75713          	srai	a4,a4,0x1f
   18f18:	00e7a223          	sw	a4,4(a5)
   18f1c:	01c12c03          	lw	s8,28(sp)
   18f20:	02012483          	lw	s1,32(sp)
   18f24:	ff9fe06f          	j	17f1c <_svfprintf_r+0x100>
   18f28:	01047713          	andi	a4,s0,16
   18f2c:	00070863          	beqz	a4,18f3c <_svfprintf_r+0x1120>
   18f30:	02812703          	lw	a4,40(sp)
   18f34:	00e7a023          	sw	a4,0(a5)
   18f38:	fe5ff06f          	j	18f1c <_svfprintf_r+0x1100>
   18f3c:	04047713          	andi	a4,s0,64
   18f40:	00070863          	beqz	a4,18f50 <_svfprintf_r+0x1134>
   18f44:	02815703          	lhu	a4,40(sp)
   18f48:	00e79023          	sh	a4,0(a5)
   18f4c:	fd1ff06f          	j	18f1c <_svfprintf_r+0x1100>
   18f50:	20047413          	andi	s0,s0,512
   18f54:	fc040ee3          	beqz	s0,18f30 <_svfprintf_r+0x1114>
   18f58:	02814703          	lbu	a4,40(sp)
   18f5c:	00e78023          	sb	a4,0(a5)
   18f60:	fbdff06f          	j	18f1c <_svfprintf_r+0x1100>
   18f64:	01046413          	ori	s0,s0,16
   18f68:	02047793          	andi	a5,s0,32
   18f6c:	04078863          	beqz	a5,18fbc <_svfprintf_r+0x11a0>
   18f70:	007c0c13          	addi	s8,s8,7
   18f74:	ff8c7c13          	andi	s8,s8,-8
   18f78:	008c0793          	addi	a5,s8,8
   18f7c:	000c2c83          	lw	s9,0(s8)
   18f80:	004c2c03          	lw	s8,4(s8)
   18f84:	00f12e23          	sw	a5,28(sp)
   18f88:	bff47413          	andi	s0,s0,-1025
   18f8c:	00000793          	li	a5,0
   18f90:	0c0103a3          	sb	zero,199(sp)
   18f94:	fff00713          	li	a4,-1
   18f98:	1aeb0263          	beq	s6,a4,1913c <_svfprintf_r+0x1320>
   18f9c:	00040713          	mv	a4,s0
   18fa0:	018ce6b3          	or	a3,s9,s8
   18fa4:	f7f47413          	andi	s0,s0,-129
   18fa8:	18069a63          	bnez	a3,1913c <_svfprintf_r+0x1320>
   18fac:	2e0b0c63          	beqz	s6,192a4 <_svfprintf_r+0x1488>
   18fb0:	00100713          	li	a4,1
   18fb4:	18e79863          	bne	a5,a4,19144 <_svfprintf_r+0x1328>
   18fb8:	d58ff06f          	j	18510 <_svfprintf_r+0x6f4>
   18fbc:	004c0793          	addi	a5,s8,4
   18fc0:	00f12e23          	sw	a5,28(sp)
   18fc4:	01047793          	andi	a5,s0,16
   18fc8:	00078663          	beqz	a5,18fd4 <_svfprintf_r+0x11b8>
   18fcc:	000c2c83          	lw	s9,0(s8)
   18fd0:	0100006f          	j	18fe0 <_svfprintf_r+0x11c4>
   18fd4:	04047793          	andi	a5,s0,64
   18fd8:	00078863          	beqz	a5,18fe8 <_svfprintf_r+0x11cc>
   18fdc:	000c5c83          	lhu	s9,0(s8)
   18fe0:	00000c13          	li	s8,0
   18fe4:	fa5ff06f          	j	18f88 <_svfprintf_r+0x116c>
   18fe8:	20047793          	andi	a5,s0,512
   18fec:	fe0780e3          	beqz	a5,18fcc <_svfprintf_r+0x11b0>
   18ff0:	000c4c83          	lbu	s9,0(s8)
   18ff4:	fedff06f          	j	18fe0 <_svfprintf_r+0x11c4>
   18ff8:	004c0793          	addi	a5,s8,4
   18ffc:	00f12e23          	sw	a5,28(sp)
   19000:	ffff87b7          	lui	a5,0xffff8
   19004:	8307c793          	xori	a5,a5,-2000
   19008:	0cf11423          	sh	a5,200(sp)
   1900c:	000227b7          	lui	a5,0x22
   19010:	91078793          	addi	a5,a5,-1776 # 21910 <zeroes.4377+0x58>
   19014:	07800713          	li	a4,120
   19018:	000c2c83          	lw	s9,0(s8)
   1901c:	04f12223          	sw	a5,68(sp)
   19020:	00000c13          	li	s8,0
   19024:	00246413          	ori	s0,s0,2
   19028:	00200793          	li	a5,2
   1902c:	00e12623          	sw	a4,12(sp)
   19030:	f61ff06f          	j	18f90 <_svfprintf_r+0x1174>
   19034:	004c0793          	addi	a5,s8,4
   19038:	00f12e23          	sw	a5,28(sp)
   1903c:	0c0103a3          	sb	zero,199(sp)
   19040:	fff00793          	li	a5,-1
   19044:	000c2483          	lw	s1,0(s8)
   19048:	02fb0463          	beq	s6,a5,19070 <_svfprintf_r+0x1254>
   1904c:	000b0613          	mv	a2,s6
   19050:	00000593          	li	a1,0
   19054:	00048513          	mv	a0,s1
   19058:	9ccfd0ef          	jal	ra,16224 <memchr>
   1905c:	00a12823          	sw	a0,16(sp)
   19060:	da050c63          	beqz	a0,18618 <_svfprintf_r+0x7fc>
   19064:	40950b33          	sub	s6,a0,s1
   19068:	00012823          	sw	zero,16(sp)
   1906c:	dacff06f          	j	18618 <_svfprintf_r+0x7fc>
   19070:	00048513          	mv	a0,s1
   19074:	c09f70ef          	jal	ra,10c7c <strlen>
   19078:	00050b13          	mv	s6,a0
   1907c:	fedff06f          	j	19068 <_svfprintf_r+0x124c>
   19080:	01046413          	ori	s0,s0,16
   19084:	02047793          	andi	a5,s0,32
   19088:	02078263          	beqz	a5,190ac <_svfprintf_r+0x1290>
   1908c:	007c0c13          	addi	s8,s8,7
   19090:	ff8c7c13          	andi	s8,s8,-8
   19094:	008c0793          	addi	a5,s8,8
   19098:	000c2c83          	lw	s9,0(s8)
   1909c:	004c2c03          	lw	s8,4(s8)
   190a0:	00f12e23          	sw	a5,28(sp)
   190a4:	00100793          	li	a5,1
   190a8:	ee9ff06f          	j	18f90 <_svfprintf_r+0x1174>
   190ac:	004c0793          	addi	a5,s8,4
   190b0:	00f12e23          	sw	a5,28(sp)
   190b4:	01047793          	andi	a5,s0,16
   190b8:	00078663          	beqz	a5,190c4 <_svfprintf_r+0x12a8>
   190bc:	000c2c83          	lw	s9,0(s8)
   190c0:	0100006f          	j	190d0 <_svfprintf_r+0x12b4>
   190c4:	04047793          	andi	a5,s0,64
   190c8:	00078863          	beqz	a5,190d8 <_svfprintf_r+0x12bc>
   190cc:	000c5c83          	lhu	s9,0(s8)
   190d0:	00000c13          	li	s8,0
   190d4:	fd1ff06f          	j	190a4 <_svfprintf_r+0x1288>
   190d8:	20047793          	andi	a5,s0,512
   190dc:	fe0780e3          	beqz	a5,190bc <_svfprintf_r+0x12a0>
   190e0:	000c4c83          	lbu	s9,0(s8)
   190e4:	fedff06f          	j	190d0 <_svfprintf_r+0x12b4>
   190e8:	000227b7          	lui	a5,0x22
   190ec:	91078793          	addi	a5,a5,-1776 # 21910 <zeroes.4377+0x58>
   190f0:	f11fe06f          	j	18000 <_svfprintf_r+0x1e4>
   190f4:	004c0793          	addi	a5,s8,4
   190f8:	00f12e23          	sw	a5,28(sp)
   190fc:	01047793          	andi	a5,s0,16
   19100:	00078663          	beqz	a5,1910c <_svfprintf_r+0x12f0>
   19104:	000c2c83          	lw	s9,0(s8)
   19108:	0100006f          	j	19118 <_svfprintf_r+0x12fc>
   1910c:	04047793          	andi	a5,s0,64
   19110:	00078863          	beqz	a5,19120 <_svfprintf_r+0x1304>
   19114:	000c5c83          	lhu	s9,0(s8)
   19118:	00000c13          	li	s8,0
   1911c:	f0dfe06f          	j	18028 <_svfprintf_r+0x20c>
   19120:	20047793          	andi	a5,s0,512
   19124:	fe0780e3          	beqz	a5,19104 <_svfprintf_r+0x12e8>
   19128:	000c4c83          	lbu	s9,0(s8)
   1912c:	fedff06f          	j	19118 <_svfprintf_r+0x12fc>
   19130:	00040713          	mv	a4,s0
   19134:	00100793          	li	a5,1
   19138:	e69ff06f          	j	18fa0 <_svfprintf_r+0x1184>
   1913c:	00100713          	li	a4,1
   19140:	bce78263          	beq	a5,a4,18504 <_svfprintf_r+0x6e8>
   19144:	00200713          	li	a4,2
   19148:	12e78263          	beq	a5,a4,1926c <_svfprintf_r+0x1450>
   1914c:	1b010793          	addi	a5,sp,432
   19150:	01dc1693          	slli	a3,s8,0x1d
   19154:	007cf713          	andi	a4,s9,7
   19158:	003cdc93          	srli	s9,s9,0x3
   1915c:	03070713          	addi	a4,a4,48
   19160:	0196ecb3          	or	s9,a3,s9
   19164:	003c5c13          	srli	s8,s8,0x3
   19168:	fee78fa3          	sb	a4,-1(a5)
   1916c:	018ce6b3          	or	a3,s9,s8
   19170:	fff78493          	addi	s1,a5,-1
   19174:	02069e63          	bnez	a3,191b0 <_svfprintf_r+0x1394>
   19178:	00147693          	andi	a3,s0,1
   1917c:	00068a63          	beqz	a3,19190 <_svfprintf_r+0x1374>
   19180:	03000693          	li	a3,48
   19184:	00d70663          	beq	a4,a3,19190 <_svfprintf_r+0x1374>
   19188:	fed48fa3          	sb	a3,-1(s1)
   1918c:	ffe78493          	addi	s1,a5,-2
   19190:	1b010793          	addi	a5,sp,432
   19194:	000b0a93          	mv	s5,s6
   19198:	00012823          	sw	zero,16(sp)
   1919c:	40978b33          	sub	s6,a5,s1
   191a0:	00000c13          	li	s8,0
   191a4:	00000b93          	li	s7,0
   191a8:	00000c93          	li	s9,0
   191ac:	87cff06f          	j	18228 <_svfprintf_r+0x40c>
   191b0:	00048793          	mv	a5,s1
   191b4:	f9dff06f          	j	19150 <_svfprintf_r+0x1334>
   191b8:	00000a13          	li	s4,0
   191bc:	1b010d93          	addi	s11,sp,432
   191c0:	40047a93          	andi	s5,s0,1024
   191c4:	00900b93          	li	s7,9
   191c8:	00a00613          	li	a2,10
   191cc:	00000693          	li	a3,0
   191d0:	000c8513          	mv	a0,s9
   191d4:	000c0593          	mv	a1,s8
   191d8:	291030ef          	jal	ra,1cc68 <__umoddi3>
   191dc:	03050513          	addi	a0,a0,48
   191e0:	fead8fa3          	sb	a0,-1(s11)
   191e4:	fffd8493          	addi	s1,s11,-1
   191e8:	001a0a13          	addi	s4,s4,1
   191ec:	040a8a63          	beqz	s5,19240 <_svfprintf_r+0x1424>
   191f0:	01412783          	lw	a5,20(sp)
   191f4:	0007c783          	lbu	a5,0(a5)
   191f8:	04fa1463          	bne	s4,a5,19240 <_svfprintf_r+0x1424>
   191fc:	0ff00793          	li	a5,255
   19200:	04fa0063          	beq	s4,a5,19240 <_svfprintf_r+0x1424>
   19204:	000c1463          	bnez	s8,1920c <_svfprintf_r+0x13f0>
   19208:	039bfc63          	bleu	s9,s7,19240 <_svfprintf_r+0x1424>
   1920c:	03412783          	lw	a5,52(sp)
   19210:	03c12583          	lw	a1,60(sp)
   19214:	00000a13          	li	s4,0
   19218:	40f484b3          	sub	s1,s1,a5
   1921c:	00078613          	mv	a2,a5
   19220:	00048513          	mv	a0,s1
   19224:	bb1fe0ef          	jal	ra,17dd4 <strncpy>
   19228:	01412783          	lw	a5,20(sp)
   1922c:	0017c783          	lbu	a5,1(a5)
   19230:	00078863          	beqz	a5,19240 <_svfprintf_r+0x1424>
   19234:	01412783          	lw	a5,20(sp)
   19238:	00178793          	addi	a5,a5,1
   1923c:	00f12a23          	sw	a5,20(sp)
   19240:	000c8513          	mv	a0,s9
   19244:	000c0593          	mv	a1,s8
   19248:	00a00613          	li	a2,10
   1924c:	00000693          	li	a3,0
   19250:	43c030ef          	jal	ra,1c68c <__udivdi3>
   19254:	00058c13          	mv	s8,a1
   19258:	00a5e5b3          	or	a1,a1,a0
   1925c:	00050c93          	mv	s9,a0
   19260:	f20588e3          	beqz	a1,19190 <_svfprintf_r+0x1374>
   19264:	00048d93          	mv	s11,s1
   19268:	f61ff06f          	j	191c8 <_svfprintf_r+0x13ac>
   1926c:	1b010493          	addi	s1,sp,432
   19270:	04412703          	lw	a4,68(sp)
   19274:	00fcf793          	andi	a5,s9,15
   19278:	fff48493          	addi	s1,s1,-1
   1927c:	00f707b3          	add	a5,a4,a5
   19280:	0007c783          	lbu	a5,0(a5)
   19284:	004cdc93          	srli	s9,s9,0x4
   19288:	00f48023          	sb	a5,0(s1)
   1928c:	01cc1793          	slli	a5,s8,0x1c
   19290:	0197ecb3          	or	s9,a5,s9
   19294:	004c5c13          	srli	s8,s8,0x4
   19298:	018ce7b3          	or	a5,s9,s8
   1929c:	fc079ae3          	bnez	a5,19270 <_svfprintf_r+0x1454>
   192a0:	ef1ff06f          	j	19190 <_svfprintf_r+0x1374>
   192a4:	1b010493          	addi	s1,sp,432
   192a8:	ee0794e3          	bnez	a5,19190 <_svfprintf_r+0x1374>
   192ac:	00177713          	andi	a4,a4,1
   192b0:	ee0700e3          	beqz	a4,19190 <_svfprintf_r+0x1374>
   192b4:	03000793          	li	a5,48
   192b8:	1af107a3          	sb	a5,431(sp)
   192bc:	a5cff06f          	j	18518 <_svfprintf_r+0x6fc>
   192c0:	00c12783          	lw	a5,12(sp)
   192c4:	2e078ce3          	beqz	a5,19dbc <_svfprintf_r+0x1fa0>
   192c8:	00c14783          	lbu	a5,12(sp)
   192cc:	0c0103a3          	sb	zero,199(sp)
   192d0:	01812e23          	sw	s8,28(sp)
   192d4:	14f10623          	sb	a5,332(sp)
   192d8:	f35fe06f          	j	1820c <_svfprintf_r+0x3f0>
   192dc:	01070713          	addi	a4,a4,16
   192e0:	01ed2223          	sw	t5,4(s10)
   192e4:	0ee12623          	sw	a4,236(sp)
   192e8:	0ed12423          	sw	a3,232(sp)
   192ec:	02dfde63          	ble	a3,t6,19328 <_svfprintf_r+0x150c>
   192f0:	0e410613          	addi	a2,sp,228
   192f4:	00098593          	mv	a1,s3
   192f8:	00090513          	mv	a0,s2
   192fc:	05f12c23          	sw	t6,88(sp)
   19300:	05d12a23          	sw	t4,84(sp)
   19304:	05e12823          	sw	t5,80(sp)
   19308:	05c12623          	sw	t3,76(sp)
   1930c:	655010ef          	jal	ra,1b160 <__ssprint_r>
   19310:	240514e3          	bnez	a0,19d58 <_svfprintf_r+0x1f3c>
   19314:	05812f83          	lw	t6,88(sp)
   19318:	05412e83          	lw	t4,84(sp)
   1931c:	05012f03          	lw	t5,80(sp)
   19320:	04c12e03          	lw	t3,76(sp)
   19324:	10c10613          	addi	a2,sp,268
   19328:	ff0e0e13          	addi	t3,t3,-16
   1932c:	00060d13          	mv	s10,a2
   19330:	f59fe06f          	j	18288 <_svfprintf_r+0x46c>
   19334:	01812583          	lw	a1,24(sp)
   19338:	01068693          	addi	a3,a3,16
   1933c:	00fd2223          	sw	a5,4(s10)
   19340:	00bd2023          	sw	a1,0(s10)
   19344:	0ed12623          	sw	a3,236(sp)
   19348:	0ee12423          	sw	a4,232(sp)
   1934c:	02ee5663          	ble	a4,t3,19378 <_svfprintf_r+0x155c>
   19350:	0e410613          	addi	a2,sp,228
   19354:	00098593          	mv	a1,s3
   19358:	00090513          	mv	a0,s2
   1935c:	05c12623          	sw	t3,76(sp)
   19360:	04f12423          	sw	a5,72(sp)
   19364:	5fd010ef          	jal	ra,1b160 <__ssprint_r>
   19368:	1e0518e3          	bnez	a0,19d58 <_svfprintf_r+0x1f3c>
   1936c:	04c12e03          	lw	t3,76(sp)
   19370:	04812783          	lw	a5,72(sp)
   19374:	10c10613          	addi	a2,sp,268
   19378:	ff0d8d93          	addi	s11,s11,-16
   1937c:	00060d13          	mv	s10,a2
   19380:	82cff06f          	j	183ac <_svfprintf_r+0x590>
   19384:	01068693          	addi	a3,a3,16
   19388:	01bd2223          	sw	s11,4(s10)
   1938c:	0ed12623          	sw	a3,236(sp)
   19390:	0ee12423          	sw	a4,232(sp)
   19394:	02e85263          	ble	a4,a6,193b8 <_svfprintf_r+0x159c>
   19398:	0e410613          	addi	a2,sp,228
   1939c:	00098593          	mv	a1,s3
   193a0:	00090513          	mv	a0,s2
   193a4:	05012423          	sw	a6,72(sp)
   193a8:	5b9010ef          	jal	ra,1b160 <__ssprint_r>
   193ac:	1a0516e3          	bnez	a0,19d58 <_svfprintf_r+0x1f3c>
   193b0:	04812803          	lw	a6,72(sp)
   193b4:	10c10613          	addi	a2,sp,268
   193b8:	ff0a8a93          	addi	s5,s5,-16
   193bc:	00060d13          	mv	s10,a2
   193c0:	850ff06f          	j	18410 <_svfprintf_r+0x5f4>
   193c4:	00c12783          	lw	a5,12(sp)
   193c8:	06500713          	li	a4,101
   193cc:	72f75463          	ble	a5,a4,19af4 <_svfprintf_r+0x1cd8>
   193d0:	0f012703          	lw	a4,240(sp)
   193d4:	0a010593          	addi	a1,sp,160
   193d8:	0b010513          	addi	a0,sp,176
   193dc:	0ae12823          	sw	a4,176(sp)
   193e0:	0f412703          	lw	a4,244(sp)
   193e4:	0a012023          	sw	zero,160(sp)
   193e8:	0a012223          	sw	zero,164(sp)
   193ec:	0ae12a23          	sw	a4,180(sp)
   193f0:	0f812703          	lw	a4,248(sp)
   193f4:	0a012423          	sw	zero,168(sp)
   193f8:	0a012623          	sw	zero,172(sp)
   193fc:	0ae12c23          	sw	a4,184(sp)
   19400:	0fc12703          	lw	a4,252(sp)
   19404:	0ae12e23          	sw	a4,188(sp)
   19408:	459040ef          	jal	ra,1e060 <__eqtf2>
   1940c:	12051a63          	bnez	a0,19540 <_svfprintf_r+0x1724>
   19410:	000227b7          	lui	a5,0x22
   19414:	93878793          	addi	a5,a5,-1736 # 21938 <zeroes.4377+0x80>
   19418:	00fd2023          	sw	a5,0(s10)
   1941c:	00100793          	li	a5,1
   19420:	00fd2223          	sw	a5,4(s10)
   19424:	0e812783          	lw	a5,232(sp)
   19428:	001d8d93          	addi	s11,s11,1
   1942c:	0fb12623          	sw	s11,236(sp)
   19430:	00178793          	addi	a5,a5,1
   19434:	0ef12423          	sw	a5,232(sp)
   19438:	00700713          	li	a4,7
   1943c:	008d0d13          	addi	s10,s10,8
   19440:	00f75e63          	ble	a5,a4,1945c <_svfprintf_r+0x1640>
   19444:	0e410613          	addi	a2,sp,228
   19448:	00098593          	mv	a1,s3
   1944c:	00090513          	mv	a0,s2
   19450:	511010ef          	jal	ra,1b160 <__ssprint_r>
   19454:	100512e3          	bnez	a0,19d58 <_svfprintf_r+0x1f3c>
   19458:	10c10d13          	addi	s10,sp,268
   1945c:	0cc12783          	lw	a5,204(sp)
   19460:	0147c663          	blt	a5,s4,1946c <_svfprintf_r+0x1650>
   19464:	00147793          	andi	a5,s0,1
   19468:	22078263          	beqz	a5,1968c <_svfprintf_r+0x1870>
   1946c:	03812783          	lw	a5,56(sp)
   19470:	02412703          	lw	a4,36(sp)
   19474:	008d0d13          	addi	s10,s10,8
   19478:	fefd2c23          	sw	a5,-8(s10)
   1947c:	02412783          	lw	a5,36(sp)
   19480:	fefd2e23          	sw	a5,-4(s10)
   19484:	0ec12783          	lw	a5,236(sp)
   19488:	00e787b3          	add	a5,a5,a4
   1948c:	0ef12623          	sw	a5,236(sp)
   19490:	0e812783          	lw	a5,232(sp)
   19494:	00700713          	li	a4,7
   19498:	00178793          	addi	a5,a5,1
   1949c:	0ef12423          	sw	a5,232(sp)
   194a0:	00f75e63          	ble	a5,a4,194bc <_svfprintf_r+0x16a0>
   194a4:	0e410613          	addi	a2,sp,228
   194a8:	00098593          	mv	a1,s3
   194ac:	00090513          	mv	a0,s2
   194b0:	4b1010ef          	jal	ra,1b160 <__ssprint_r>
   194b4:	0a0512e3          	bnez	a0,19d58 <_svfprintf_r+0x1f3c>
   194b8:	10c10d13          	addi	s10,sp,268
   194bc:	fffa0493          	addi	s1,s4,-1
   194c0:	1c905663          	blez	s1,1968c <_svfprintf_r+0x1870>
   194c4:	01000a93          	li	s5,16
   194c8:	00700b93          	li	s7,7
   194cc:	01812603          	lw	a2,24(sp)
   194d0:	0e812783          	lw	a5,232(sp)
   194d4:	0ec12703          	lw	a4,236(sp)
   194d8:	00cd2023          	sw	a2,0(s10)
   194dc:	00178793          	addi	a5,a5,1
   194e0:	008d0693          	addi	a3,s10,8
   194e4:	029ac263          	blt	s5,s1,19508 <_svfprintf_r+0x16ec>
   194e8:	009d2223          	sw	s1,4(s10)
   194ec:	00e484b3          	add	s1,s1,a4
   194f0:	0e912623          	sw	s1,236(sp)
   194f4:	0ef12423          	sw	a5,232(sp)
   194f8:	00700713          	li	a4,7
   194fc:	00068d13          	mv	s10,a3
   19500:	18f75663          	ble	a5,a4,1968c <_svfprintf_r+0x1870>
   19504:	f99fe06f          	j	1849c <_svfprintf_r+0x680>
   19508:	01070713          	addi	a4,a4,16
   1950c:	015d2223          	sw	s5,4(s10)
   19510:	0ee12623          	sw	a4,236(sp)
   19514:	0ef12423          	sw	a5,232(sp)
   19518:	00fbde63          	ble	a5,s7,19534 <_svfprintf_r+0x1718>
   1951c:	0e410613          	addi	a2,sp,228
   19520:	00098593          	mv	a1,s3
   19524:	00090513          	mv	a0,s2
   19528:	439010ef          	jal	ra,1b160 <__ssprint_r>
   1952c:	020516e3          	bnez	a0,19d58 <_svfprintf_r+0x1f3c>
   19530:	10c10693          	addi	a3,sp,268
   19534:	ff048493          	addi	s1,s1,-16
   19538:	00068d13          	mv	s10,a3
   1953c:	f91ff06f          	j	194cc <_svfprintf_r+0x16b0>
   19540:	0cc12703          	lw	a4,204(sp)
   19544:	1ce04a63          	bgtz	a4,19718 <_svfprintf_r+0x18fc>
   19548:	000227b7          	lui	a5,0x22
   1954c:	93878793          	addi	a5,a5,-1736 # 21938 <zeroes.4377+0x80>
   19550:	00fd2023          	sw	a5,0(s10)
   19554:	00100793          	li	a5,1
   19558:	00fd2223          	sw	a5,4(s10)
   1955c:	0e812783          	lw	a5,232(sp)
   19560:	001d8d93          	addi	s11,s11,1
   19564:	0fb12623          	sw	s11,236(sp)
   19568:	00178793          	addi	a5,a5,1
   1956c:	0ef12423          	sw	a5,232(sp)
   19570:	00700713          	li	a4,7
   19574:	008d0d13          	addi	s10,s10,8
   19578:	00f75e63          	ble	a5,a4,19594 <_svfprintf_r+0x1778>
   1957c:	0e410613          	addi	a2,sp,228
   19580:	00098593          	mv	a1,s3
   19584:	00090513          	mv	a0,s2
   19588:	3d9010ef          	jal	ra,1b160 <__ssprint_r>
   1958c:	7c051663          	bnez	a0,19d58 <_svfprintf_r+0x1f3c>
   19590:	10c10d13          	addi	s10,sp,268
   19594:	0cc12783          	lw	a5,204(sp)
   19598:	00079863          	bnez	a5,195a8 <_svfprintf_r+0x178c>
   1959c:	000a1663          	bnez	s4,195a8 <_svfprintf_r+0x178c>
   195a0:	00147793          	andi	a5,s0,1
   195a4:	0e078463          	beqz	a5,1968c <_svfprintf_r+0x1870>
   195a8:	03812783          	lw	a5,56(sp)
   195ac:	02412703          	lw	a4,36(sp)
   195b0:	008d0893          	addi	a7,s10,8
   195b4:	00fd2023          	sw	a5,0(s10)
   195b8:	02412783          	lw	a5,36(sp)
   195bc:	00fd2223          	sw	a5,4(s10)
   195c0:	0ec12783          	lw	a5,236(sp)
   195c4:	00e787b3          	add	a5,a5,a4
   195c8:	0ef12623          	sw	a5,236(sp)
   195cc:	0e812783          	lw	a5,232(sp)
   195d0:	00700713          	li	a4,7
   195d4:	00178793          	addi	a5,a5,1
   195d8:	0ef12423          	sw	a5,232(sp)
   195dc:	00f75e63          	ble	a5,a4,195f8 <_svfprintf_r+0x17dc>
   195e0:	0e410613          	addi	a2,sp,228
   195e4:	00098593          	mv	a1,s3
   195e8:	00090513          	mv	a0,s2
   195ec:	375010ef          	jal	ra,1b160 <__ssprint_r>
   195f0:	76051463          	bnez	a0,19d58 <_svfprintf_r+0x1f3c>
   195f4:	10c10893          	addi	a7,sp,268
   195f8:	0cc12a83          	lw	s5,204(sp)
   195fc:	060ad063          	bgez	s5,1965c <_svfprintf_r+0x1840>
   19600:	41500ab3          	neg	s5,s5
   19604:	00088713          	mv	a4,a7
   19608:	01000b93          	li	s7,16
   1960c:	00700c13          	li	s8,7
   19610:	01812603          	lw	a2,24(sp)
   19614:	0e812783          	lw	a5,232(sp)
   19618:	0ec12683          	lw	a3,236(sp)
   1961c:	00c72023          	sw	a2,0(a4)
   19620:	00178793          	addi	a5,a5,1
   19624:	00888893          	addi	a7,a7,8
   19628:	0b5bcc63          	blt	s7,s5,196e0 <_svfprintf_r+0x18c4>
   1962c:	01572223          	sw	s5,4(a4)
   19630:	00da8ab3          	add	s5,s5,a3
   19634:	0f512623          	sw	s5,236(sp)
   19638:	0ef12423          	sw	a5,232(sp)
   1963c:	00700713          	li	a4,7
   19640:	00f75e63          	ble	a5,a4,1965c <_svfprintf_r+0x1840>
   19644:	0e410613          	addi	a2,sp,228
   19648:	00098593          	mv	a1,s3
   1964c:	00090513          	mv	a0,s2
   19650:	311010ef          	jal	ra,1b160 <__ssprint_r>
   19654:	70051263          	bnez	a0,19d58 <_svfprintf_r+0x1f3c>
   19658:	10c10893          	addi	a7,sp,268
   1965c:	0ec12783          	lw	a5,236(sp)
   19660:	0098a023          	sw	s1,0(a7)
   19664:	0148a223          	sw	s4,4(a7)
   19668:	014787b3          	add	a5,a5,s4
   1966c:	0ef12623          	sw	a5,236(sp)
   19670:	0e812783          	lw	a5,232(sp)
   19674:	00700713          	li	a4,7
   19678:	00888d13          	addi	s10,a7,8
   1967c:	00178793          	addi	a5,a5,1
   19680:	0ef12423          	sw	a5,232(sp)
   19684:	00f75463          	ble	a5,a4,1968c <_svfprintf_r+0x1870>
   19688:	e15fe06f          	j	1849c <_svfprintf_r+0x680>
   1968c:	00447413          	andi	s0,s0,4
   19690:	66041463          	bnez	s0,19cf8 <_svfprintf_r+0x1edc>
   19694:	02c12d03          	lw	s10,44(sp)
   19698:	03012783          	lw	a5,48(sp)
   1969c:	00fd5463          	ble	a5,s10,196a4 <_svfprintf_r+0x1888>
   196a0:	00078d13          	mv	s10,a5
   196a4:	02812783          	lw	a5,40(sp)
   196a8:	01a787b3          	add	a5,a5,s10
   196ac:	02f12423          	sw	a5,40(sp)
   196b0:	0ec12783          	lw	a5,236(sp)
   196b4:	00078c63          	beqz	a5,196cc <_svfprintf_r+0x18b0>
   196b8:	0e410613          	addi	a2,sp,228
   196bc:	00098593          	mv	a1,s3
   196c0:	00090513          	mv	a0,s2
   196c4:	29d010ef          	jal	ra,1b160 <__ssprint_r>
   196c8:	68051863          	bnez	a0,19d58 <_svfprintf_r+0x1f3c>
   196cc:	01012783          	lw	a5,16(sp)
   196d0:	0e012423          	sw	zero,232(sp)
   196d4:	6c079c63          	bnez	a5,19dac <_svfprintf_r+0x1f90>
   196d8:	10c10d13          	addi	s10,sp,268
   196dc:	841ff06f          	j	18f1c <_svfprintf_r+0x1100>
   196e0:	01068693          	addi	a3,a3,16
   196e4:	01772223          	sw	s7,4(a4)
   196e8:	0ed12623          	sw	a3,236(sp)
   196ec:	0ef12423          	sw	a5,232(sp)
   196f0:	00fc5e63          	ble	a5,s8,1970c <_svfprintf_r+0x18f0>
   196f4:	0e410613          	addi	a2,sp,228
   196f8:	00098593          	mv	a1,s3
   196fc:	00090513          	mv	a0,s2
   19700:	261010ef          	jal	ra,1b160 <__ssprint_r>
   19704:	64051a63          	bnez	a0,19d58 <_svfprintf_r+0x1f3c>
   19708:	10c10893          	addi	a7,sp,268
   1970c:	ff0a8a93          	addi	s5,s5,-16
   19710:	00088713          	mv	a4,a7
   19714:	efdff06f          	j	19610 <_svfprintf_r+0x17f4>
   19718:	000c8a93          	mv	s5,s9
   1971c:	019a5463          	ble	s9,s4,19724 <_svfprintf_r+0x1908>
   19720:	000a0a93          	mv	s5,s4
   19724:	05505263          	blez	s5,19768 <_svfprintf_r+0x194c>
   19728:	0e812703          	lw	a4,232(sp)
   1972c:	01ba8db3          	add	s11,s5,s11
   19730:	009d2023          	sw	s1,0(s10)
   19734:	00170713          	addi	a4,a4,1
   19738:	015d2223          	sw	s5,4(s10)
   1973c:	0fb12623          	sw	s11,236(sp)
   19740:	0ee12423          	sw	a4,232(sp)
   19744:	00700693          	li	a3,7
   19748:	008d0d13          	addi	s10,s10,8
   1974c:	00e6de63          	ble	a4,a3,19768 <_svfprintf_r+0x194c>
   19750:	0e410613          	addi	a2,sp,228
   19754:	00098593          	mv	a1,s3
   19758:	00090513          	mv	a0,s2
   1975c:	205010ef          	jal	ra,1b160 <__ssprint_r>
   19760:	5e051c63          	bnez	a0,19d58 <_svfprintf_r+0x1f3c>
   19764:	10c10d13          	addi	s10,sp,268
   19768:	000ad463          	bgez	s5,19770 <_svfprintf_r+0x1954>
   1976c:	00000a93          	li	s5,0
   19770:	415c8ab3          	sub	s5,s9,s5
   19774:	05505e63          	blez	s5,197d0 <_svfprintf_r+0x19b4>
   19778:	01000b13          	li	s6,16
   1977c:	00700d93          	li	s11,7
   19780:	01812783          	lw	a5,24(sp)
   19784:	0e812703          	lw	a4,232(sp)
   19788:	0ec12683          	lw	a3,236(sp)
   1978c:	00fd2023          	sw	a5,0(s10)
   19790:	00170713          	addi	a4,a4,1
   19794:	008d0613          	addi	a2,s10,8
   19798:	195b4c63          	blt	s6,s5,19930 <_svfprintf_r+0x1b14>
   1979c:	015d2223          	sw	s5,4(s10)
   197a0:	00da8ab3          	add	s5,s5,a3
   197a4:	0f512623          	sw	s5,236(sp)
   197a8:	0ee12423          	sw	a4,232(sp)
   197ac:	00700693          	li	a3,7
   197b0:	00060d13          	mv	s10,a2
   197b4:	00e6de63          	ble	a4,a3,197d0 <_svfprintf_r+0x19b4>
   197b8:	0e410613          	addi	a2,sp,228
   197bc:	00098593          	mv	a1,s3
   197c0:	00090513          	mv	a0,s2
   197c4:	19d010ef          	jal	ra,1b160 <__ssprint_r>
   197c8:	58051863          	bnez	a0,19d58 <_svfprintf_r+0x1f3c>
   197cc:	10c10d13          	addi	s10,sp,268
   197d0:	40047793          	andi	a5,s0,1024
   197d4:	01948ab3          	add	s5,s1,s9
   197d8:	02078063          	beqz	a5,197f8 <_svfprintf_r+0x19dc>
   197dc:	00700b13          	li	s6,7
   197e0:	01448db3          	add	s11,s1,s4
   197e4:	180b9263          	bnez	s7,19968 <_svfprintf_r+0x1b4c>
   197e8:	180c1263          	bnez	s8,1996c <_svfprintf_r+0x1b50>
   197ec:	014487b3          	add	a5,s1,s4
   197f0:	0157f463          	bleu	s5,a5,197f8 <_svfprintf_r+0x19dc>
   197f4:	00078a93          	mv	s5,a5
   197f8:	0cc12783          	lw	a5,204(sp)
   197fc:	0147c663          	blt	a5,s4,19808 <_svfprintf_r+0x19ec>
   19800:	00147793          	andi	a5,s0,1
   19804:	04078a63          	beqz	a5,19858 <_svfprintf_r+0x1a3c>
   19808:	03812783          	lw	a5,56(sp)
   1980c:	02412703          	lw	a4,36(sp)
   19810:	008d0d13          	addi	s10,s10,8
   19814:	fefd2c23          	sw	a5,-8(s10)
   19818:	02412783          	lw	a5,36(sp)
   1981c:	fefd2e23          	sw	a5,-4(s10)
   19820:	0ec12783          	lw	a5,236(sp)
   19824:	00e787b3          	add	a5,a5,a4
   19828:	0ef12623          	sw	a5,236(sp)
   1982c:	0e812783          	lw	a5,232(sp)
   19830:	00700713          	li	a4,7
   19834:	00178793          	addi	a5,a5,1
   19838:	0ef12423          	sw	a5,232(sp)
   1983c:	00f75e63          	ble	a5,a4,19858 <_svfprintf_r+0x1a3c>
   19840:	0e410613          	addi	a2,sp,228
   19844:	00098593          	mv	a1,s3
   19848:	00090513          	mv	a0,s2
   1984c:	115010ef          	jal	ra,1b160 <__ssprint_r>
   19850:	50051463          	bnez	a0,19d58 <_svfprintf_r+0x1f3c>
   19854:	10c10d13          	addi	s10,sp,268
   19858:	014484b3          	add	s1,s1,s4
   1985c:	415487b3          	sub	a5,s1,s5
   19860:	0cc12483          	lw	s1,204(sp)
   19864:	409a04b3          	sub	s1,s4,s1
   19868:	0097d463          	ble	s1,a5,19870 <_svfprintf_r+0x1a54>
   1986c:	00078493          	mv	s1,a5
   19870:	04905463          	blez	s1,198b8 <_svfprintf_r+0x1a9c>
   19874:	0ec12783          	lw	a5,236(sp)
   19878:	015d2023          	sw	s5,0(s10)
   1987c:	009d2223          	sw	s1,4(s10)
   19880:	00f487b3          	add	a5,s1,a5
   19884:	0ef12623          	sw	a5,236(sp)
   19888:	0e812783          	lw	a5,232(sp)
   1988c:	00700713          	li	a4,7
   19890:	008d0d13          	addi	s10,s10,8
   19894:	00178793          	addi	a5,a5,1
   19898:	0ef12423          	sw	a5,232(sp)
   1989c:	00f75e63          	ble	a5,a4,198b8 <_svfprintf_r+0x1a9c>
   198a0:	0e410613          	addi	a2,sp,228
   198a4:	00098593          	mv	a1,s3
   198a8:	00090513          	mv	a0,s2
   198ac:	0b5010ef          	jal	ra,1b160 <__ssprint_r>
   198b0:	4a051463          	bnez	a0,19d58 <_svfprintf_r+0x1f3c>
   198b4:	10c10d13          	addi	s10,sp,268
   198b8:	00048793          	mv	a5,s1
   198bc:	0004d463          	bgez	s1,198c4 <_svfprintf_r+0x1aa8>
   198c0:	00000793          	li	a5,0
   198c4:	0cc12483          	lw	s1,204(sp)
   198c8:	409a04b3          	sub	s1,s4,s1
   198cc:	40f484b3          	sub	s1,s1,a5
   198d0:	da905ee3          	blez	s1,1968c <_svfprintf_r+0x1870>
   198d4:	01000a93          	li	s5,16
   198d8:	00700b93          	li	s7,7
   198dc:	01812603          	lw	a2,24(sp)
   198e0:	0e812783          	lw	a5,232(sp)
   198e4:	0ec12703          	lw	a4,236(sp)
   198e8:	00cd2023          	sw	a2,0(s10)
   198ec:	00178793          	addi	a5,a5,1
   198f0:	008d0693          	addi	a3,s10,8
   198f4:	be9adae3          	ble	s1,s5,194e8 <_svfprintf_r+0x16cc>
   198f8:	01070713          	addi	a4,a4,16
   198fc:	015d2223          	sw	s5,4(s10)
   19900:	0ee12623          	sw	a4,236(sp)
   19904:	0ef12423          	sw	a5,232(sp)
   19908:	00fbde63          	ble	a5,s7,19924 <_svfprintf_r+0x1b08>
   1990c:	0e410613          	addi	a2,sp,228
   19910:	00098593          	mv	a1,s3
   19914:	00090513          	mv	a0,s2
   19918:	049010ef          	jal	ra,1b160 <__ssprint_r>
   1991c:	42051e63          	bnez	a0,19d58 <_svfprintf_r+0x1f3c>
   19920:	10c10693          	addi	a3,sp,268
   19924:	ff048493          	addi	s1,s1,-16
   19928:	00068d13          	mv	s10,a3
   1992c:	fb1ff06f          	j	198dc <_svfprintf_r+0x1ac0>
   19930:	01068693          	addi	a3,a3,16
   19934:	016d2223          	sw	s6,4(s10)
   19938:	0ed12623          	sw	a3,236(sp)
   1993c:	0ee12423          	sw	a4,232(sp)
   19940:	00edde63          	ble	a4,s11,1995c <_svfprintf_r+0x1b40>
   19944:	0e410613          	addi	a2,sp,228
   19948:	00098593          	mv	a1,s3
   1994c:	00090513          	mv	a0,s2
   19950:	011010ef          	jal	ra,1b160 <__ssprint_r>
   19954:	40051263          	bnez	a0,19d58 <_svfprintf_r+0x1f3c>
   19958:	10c10613          	addi	a2,sp,268
   1995c:	ff0a8a93          	addi	s5,s5,-16
   19960:	00060d13          	mv	s10,a2
   19964:	e1dff06f          	j	19780 <_svfprintf_r+0x1964>
   19968:	0e0c0263          	beqz	s8,19a4c <_svfprintf_r+0x1c30>
   1996c:	fffc0c13          	addi	s8,s8,-1
   19970:	03c12783          	lw	a5,60(sp)
   19974:	03412703          	lw	a4,52(sp)
   19978:	008d0d13          	addi	s10,s10,8
   1997c:	fefd2c23          	sw	a5,-8(s10)
   19980:	03412783          	lw	a5,52(sp)
   19984:	fefd2e23          	sw	a5,-4(s10)
   19988:	0ec12783          	lw	a5,236(sp)
   1998c:	00e787b3          	add	a5,a5,a4
   19990:	0ef12623          	sw	a5,236(sp)
   19994:	0e812783          	lw	a5,232(sp)
   19998:	00178793          	addi	a5,a5,1
   1999c:	0ef12423          	sw	a5,232(sp)
   199a0:	00fb5e63          	ble	a5,s6,199bc <_svfprintf_r+0x1ba0>
   199a4:	0e410613          	addi	a2,sp,228
   199a8:	00098593          	mv	a1,s3
   199ac:	00090513          	mv	a0,s2
   199b0:	7b0010ef          	jal	ra,1b160 <__ssprint_r>
   199b4:	3a051263          	bnez	a0,19d58 <_svfprintf_r+0x1f3c>
   199b8:	10c10d13          	addi	s10,sp,268
   199bc:	01412783          	lw	a5,20(sp)
   199c0:	415d8733          	sub	a4,s11,s5
   199c4:	0007c783          	lbu	a5,0(a5)
   199c8:	00f75463          	ble	a5,a4,199d0 <_svfprintf_r+0x1bb4>
   199cc:	00070793          	mv	a5,a4
   199d0:	04f05663          	blez	a5,19a1c <_svfprintf_r+0x1c00>
   199d4:	0ec12703          	lw	a4,236(sp)
   199d8:	015d2023          	sw	s5,0(s10)
   199dc:	00fd2223          	sw	a5,4(s10)
   199e0:	00e78733          	add	a4,a5,a4
   199e4:	0ee12623          	sw	a4,236(sp)
   199e8:	0e812703          	lw	a4,232(sp)
   199ec:	008d0d13          	addi	s10,s10,8
   199f0:	00170713          	addi	a4,a4,1
   199f4:	0ee12423          	sw	a4,232(sp)
   199f8:	02eb5263          	ble	a4,s6,19a1c <_svfprintf_r+0x1c00>
   199fc:	0e410613          	addi	a2,sp,228
   19a00:	00098593          	mv	a1,s3
   19a04:	00090513          	mv	a0,s2
   19a08:	00f12623          	sw	a5,12(sp)
   19a0c:	754010ef          	jal	ra,1b160 <__ssprint_r>
   19a10:	34051463          	bnez	a0,19d58 <_svfprintf_r+0x1f3c>
   19a14:	00c12783          	lw	a5,12(sp)
   19a18:	10c10d13          	addi	s10,sp,268
   19a1c:	00078713          	mv	a4,a5
   19a20:	0007d463          	bgez	a5,19a28 <_svfprintf_r+0x1c0c>
   19a24:	00000713          	li	a4,0
   19a28:	01412783          	lw	a5,20(sp)
   19a2c:	01000813          	li	a6,16
   19a30:	0007c783          	lbu	a5,0(a5)
   19a34:	40e787b3          	sub	a5,a5,a4
   19a38:	06f04663          	bgtz	a5,19aa4 <_svfprintf_r+0x1c88>
   19a3c:	01412783          	lw	a5,20(sp)
   19a40:	0007c783          	lbu	a5,0(a5)
   19a44:	00fa8ab3          	add	s5,s5,a5
   19a48:	d9dff06f          	j	197e4 <_svfprintf_r+0x19c8>
   19a4c:	01412783          	lw	a5,20(sp)
   19a50:	fffb8b93          	addi	s7,s7,-1
   19a54:	fff78793          	addi	a5,a5,-1
   19a58:	00f12a23          	sw	a5,20(sp)
   19a5c:	f15ff06f          	j	19970 <_svfprintf_r+0x1b54>
   19a60:	01068693          	addi	a3,a3,16
   19a64:	010d2223          	sw	a6,4(s10)
   19a68:	0ed12623          	sw	a3,236(sp)
   19a6c:	0ee12423          	sw	a4,232(sp)
   19a70:	02eb5663          	ble	a4,s6,19a9c <_svfprintf_r+0x1c80>
   19a74:	0e410613          	addi	a2,sp,228
   19a78:	00098593          	mv	a1,s3
   19a7c:	00090513          	mv	a0,s2
   19a80:	05012423          	sw	a6,72(sp)
   19a84:	00f12623          	sw	a5,12(sp)
   19a88:	6d8010ef          	jal	ra,1b160 <__ssprint_r>
   19a8c:	2c051663          	bnez	a0,19d58 <_svfprintf_r+0x1f3c>
   19a90:	04812803          	lw	a6,72(sp)
   19a94:	00c12783          	lw	a5,12(sp)
   19a98:	10c10613          	addi	a2,sp,268
   19a9c:	ff078793          	addi	a5,a5,-16
   19aa0:	00060d13          	mv	s10,a2
   19aa4:	01812583          	lw	a1,24(sp)
   19aa8:	0e812703          	lw	a4,232(sp)
   19aac:	0ec12683          	lw	a3,236(sp)
   19ab0:	00bd2023          	sw	a1,0(s10)
   19ab4:	00170713          	addi	a4,a4,1
   19ab8:	008d0613          	addi	a2,s10,8
   19abc:	faf842e3          	blt	a6,a5,19a60 <_svfprintf_r+0x1c44>
   19ac0:	00fd2223          	sw	a5,4(s10)
   19ac4:	00d787b3          	add	a5,a5,a3
   19ac8:	0ef12623          	sw	a5,236(sp)
   19acc:	0ee12423          	sw	a4,232(sp)
   19ad0:	00060d13          	mv	s10,a2
   19ad4:	f6eb54e3          	ble	a4,s6,19a3c <_svfprintf_r+0x1c20>
   19ad8:	0e410613          	addi	a2,sp,228
   19adc:	00098593          	mv	a1,s3
   19ae0:	00090513          	mv	a0,s2
   19ae4:	67c010ef          	jal	ra,1b160 <__ssprint_r>
   19ae8:	26051863          	bnez	a0,19d58 <_svfprintf_r+0x1f3c>
   19aec:	10c10d13          	addi	s10,sp,268
   19af0:	f4dff06f          	j	19a3c <_svfprintf_r+0x1c20>
   19af4:	0e812783          	lw	a5,232(sp)
   19af8:	00100713          	li	a4,1
   19afc:	009d2023          	sw	s1,0(s10)
   19b00:	001d8d93          	addi	s11,s11,1
   19b04:	00178793          	addi	a5,a5,1
   19b08:	008d0b93          	addi	s7,s10,8
   19b0c:	01474663          	blt	a4,s4,19b18 <_svfprintf_r+0x1cfc>
   19b10:	00147693          	andi	a3,s0,1
   19b14:	1c068663          	beqz	a3,19ce0 <_svfprintf_r+0x1ec4>
   19b18:	00100713          	li	a4,1
   19b1c:	00ed2223          	sw	a4,4(s10)
   19b20:	0fb12623          	sw	s11,236(sp)
   19b24:	0ef12423          	sw	a5,232(sp)
   19b28:	00700713          	li	a4,7
   19b2c:	00f75e63          	ble	a5,a4,19b48 <_svfprintf_r+0x1d2c>
   19b30:	0e410613          	addi	a2,sp,228
   19b34:	00098593          	mv	a1,s3
   19b38:	00090513          	mv	a0,s2
   19b3c:	624010ef          	jal	ra,1b160 <__ssprint_r>
   19b40:	20051c63          	bnez	a0,19d58 <_svfprintf_r+0x1f3c>
   19b44:	10c10b93          	addi	s7,sp,268
   19b48:	03812783          	lw	a5,56(sp)
   19b4c:	02412703          	lw	a4,36(sp)
   19b50:	008b8b93          	addi	s7,s7,8
   19b54:	fefbac23          	sw	a5,-8(s7)
   19b58:	02412783          	lw	a5,36(sp)
   19b5c:	fefbae23          	sw	a5,-4(s7)
   19b60:	0ec12783          	lw	a5,236(sp)
   19b64:	00e787b3          	add	a5,a5,a4
   19b68:	0ef12623          	sw	a5,236(sp)
   19b6c:	0e812783          	lw	a5,232(sp)
   19b70:	00700713          	li	a4,7
   19b74:	00178793          	addi	a5,a5,1
   19b78:	0ef12423          	sw	a5,232(sp)
   19b7c:	00f75e63          	ble	a5,a4,19b98 <_svfprintf_r+0x1d7c>
   19b80:	0e410613          	addi	a2,sp,228
   19b84:	00098593          	mv	a1,s3
   19b88:	00090513          	mv	a0,s2
   19b8c:	5d4010ef          	jal	ra,1b160 <__ssprint_r>
   19b90:	1c051463          	bnez	a0,19d58 <_svfprintf_r+0x1f3c>
   19b94:	10c10b93          	addi	s7,sp,268
   19b98:	0f012783          	lw	a5,240(sp)
   19b9c:	0a010593          	addi	a1,sp,160
   19ba0:	0b010513          	addi	a0,sp,176
   19ba4:	0af12823          	sw	a5,176(sp)
   19ba8:	0f412783          	lw	a5,244(sp)
   19bac:	fffa0a93          	addi	s5,s4,-1
   19bb0:	0a012023          	sw	zero,160(sp)
   19bb4:	0af12a23          	sw	a5,180(sp)
   19bb8:	0f812783          	lw	a5,248(sp)
   19bbc:	0a012223          	sw	zero,164(sp)
   19bc0:	0a012423          	sw	zero,168(sp)
   19bc4:	0af12c23          	sw	a5,184(sp)
   19bc8:	0fc12783          	lw	a5,252(sp)
   19bcc:	0a012623          	sw	zero,172(sp)
   19bd0:	0af12e23          	sw	a5,188(sp)
   19bd4:	48c040ef          	jal	ra,1e060 <__eqtf2>
   19bd8:	08050663          	beqz	a0,19c64 <_svfprintf_r+0x1e48>
   19bdc:	0ec12783          	lw	a5,236(sp)
   19be0:	0e812703          	lw	a4,232(sp)
   19be4:	00148493          	addi	s1,s1,1
   19be8:	fff78793          	addi	a5,a5,-1
   19bec:	014787b3          	add	a5,a5,s4
   19bf0:	00170713          	addi	a4,a4,1
   19bf4:	009ba023          	sw	s1,0(s7)
   19bf8:	015ba223          	sw	s5,4(s7)
   19bfc:	0ef12623          	sw	a5,236(sp)
   19c00:	0ee12423          	sw	a4,232(sp)
   19c04:	00700793          	li	a5,7
   19c08:	008b8b93          	addi	s7,s7,8
   19c0c:	00e7de63          	ble	a4,a5,19c28 <_svfprintf_r+0x1e0c>
   19c10:	0e410613          	addi	a2,sp,228
   19c14:	00098593          	mv	a1,s3
   19c18:	00090513          	mv	a0,s2
   19c1c:	544010ef          	jal	ra,1b160 <__ssprint_r>
   19c20:	12051c63          	bnez	a0,19d58 <_svfprintf_r+0x1f3c>
   19c24:	10c10b93          	addi	s7,sp,268
   19c28:	0d410793          	addi	a5,sp,212
   19c2c:	00fba023          	sw	a5,0(s7)
   19c30:	04012783          	lw	a5,64(sp)
   19c34:	04012703          	lw	a4,64(sp)
   19c38:	008b8d13          	addi	s10,s7,8
   19c3c:	00fba223          	sw	a5,4(s7)
   19c40:	0ec12783          	lw	a5,236(sp)
   19c44:	00e787b3          	add	a5,a5,a4
   19c48:	0ef12623          	sw	a5,236(sp)
   19c4c:	0e812783          	lw	a5,232(sp)
   19c50:	00700713          	li	a4,7
   19c54:	00178793          	addi	a5,a5,1
   19c58:	0ef12423          	sw	a5,232(sp)
   19c5c:	a2f758e3          	ble	a5,a4,1968c <_svfprintf_r+0x1870>
   19c60:	83dfe06f          	j	1849c <_svfprintf_r+0x680>
   19c64:	fd5052e3          	blez	s5,19c28 <_svfprintf_r+0x1e0c>
   19c68:	01000493          	li	s1,16
   19c6c:	00700c13          	li	s8,7
   19c70:	01812603          	lw	a2,24(sp)
   19c74:	0e812703          	lw	a4,232(sp)
   19c78:	0ec12783          	lw	a5,236(sp)
   19c7c:	00cba023          	sw	a2,0(s7)
   19c80:	00170713          	addi	a4,a4,1
   19c84:	008b8693          	addi	a3,s7,8
   19c88:	0354c063          	blt	s1,s5,19ca8 <_svfprintf_r+0x1e8c>
   19c8c:	00fa87b3          	add	a5,s5,a5
   19c90:	015ba223          	sw	s5,4(s7)
   19c94:	0ef12623          	sw	a5,236(sp)
   19c98:	0ee12423          	sw	a4,232(sp)
   19c9c:	00700793          	li	a5,7
   19ca0:	00068b93          	mv	s7,a3
   19ca4:	f69ff06f          	j	19c0c <_svfprintf_r+0x1df0>
   19ca8:	01078793          	addi	a5,a5,16
   19cac:	009ba223          	sw	s1,4(s7)
   19cb0:	0ef12623          	sw	a5,236(sp)
   19cb4:	0ee12423          	sw	a4,232(sp)
   19cb8:	00ec5e63          	ble	a4,s8,19cd4 <_svfprintf_r+0x1eb8>
   19cbc:	0e410613          	addi	a2,sp,228
   19cc0:	00098593          	mv	a1,s3
   19cc4:	00090513          	mv	a0,s2
   19cc8:	498010ef          	jal	ra,1b160 <__ssprint_r>
   19ccc:	08051663          	bnez	a0,19d58 <_svfprintf_r+0x1f3c>
   19cd0:	10c10693          	addi	a3,sp,268
   19cd4:	ff0a8a93          	addi	s5,s5,-16
   19cd8:	00068b93          	mv	s7,a3
   19cdc:	f95ff06f          	j	19c70 <_svfprintf_r+0x1e54>
   19ce0:	00ed2223          	sw	a4,4(s10)
   19ce4:	0fb12623          	sw	s11,236(sp)
   19ce8:	0ef12423          	sw	a5,232(sp)
   19cec:	00700713          	li	a4,7
   19cf0:	f2f75ce3          	ble	a5,a4,19c28 <_svfprintf_r+0x1e0c>
   19cf4:	f1dff06f          	j	19c10 <_svfprintf_r+0x1df4>
   19cf8:	02c12783          	lw	a5,44(sp)
   19cfc:	03012703          	lw	a4,48(sp)
   19d00:	40e78433          	sub	s0,a5,a4
   19d04:	988058e3          	blez	s0,19694 <_svfprintf_r+0x1878>
   19d08:	000224b7          	lui	s1,0x22
   19d0c:	01000a93          	li	s5,16
   19d10:	e5c48493          	addi	s1,s1,-420 # 21e5c <blanks.4361>
   19d14:	00700b93          	li	s7,7
   19d18:	0e812783          	lw	a5,232(sp)
   19d1c:	009d2023          	sw	s1,0(s10)
   19d20:	0ec12703          	lw	a4,236(sp)
   19d24:	00178793          	addi	a5,a5,1
   19d28:	048ac663          	blt	s5,s0,19d74 <_svfprintf_r+0x1f58>
   19d2c:	008d2223          	sw	s0,4(s10)
   19d30:	00e40433          	add	s0,s0,a4
   19d34:	0e812623          	sw	s0,236(sp)
   19d38:	0ef12423          	sw	a5,232(sp)
   19d3c:	00700713          	li	a4,7
   19d40:	94f75ae3          	ble	a5,a4,19694 <_svfprintf_r+0x1878>
   19d44:	0e410613          	addi	a2,sp,228
   19d48:	00098593          	mv	a1,s3
   19d4c:	00090513          	mv	a0,s2
   19d50:	410010ef          	jal	ra,1b160 <__ssprint_r>
   19d54:	940500e3          	beqz	a0,19694 <_svfprintf_r+0x1878>
   19d58:	01012783          	lw	a5,16(sp)
   19d5c:	00079463          	bnez	a5,19d64 <_svfprintf_r+0x1f48>
   19d60:	995fe06f          	j	186f4 <_svfprintf_r+0x8d8>
   19d64:	00078593          	mv	a1,a5
   19d68:	00090513          	mv	a0,s2
   19d6c:	925f90ef          	jal	ra,13690 <_free_r>
   19d70:	985fe06f          	j	186f4 <_svfprintf_r+0x8d8>
   19d74:	01070713          	addi	a4,a4,16
   19d78:	015d2223          	sw	s5,4(s10)
   19d7c:	0ee12623          	sw	a4,236(sp)
   19d80:	0ef12423          	sw	a5,232(sp)
   19d84:	008d0d13          	addi	s10,s10,8
   19d88:	00fbde63          	ble	a5,s7,19da4 <_svfprintf_r+0x1f88>
   19d8c:	0e410613          	addi	a2,sp,228
   19d90:	00098593          	mv	a1,s3
   19d94:	00090513          	mv	a0,s2
   19d98:	3c8010ef          	jal	ra,1b160 <__ssprint_r>
   19d9c:	fa051ee3          	bnez	a0,19d58 <_svfprintf_r+0x1f3c>
   19da0:	10c10d13          	addi	s10,sp,268
   19da4:	ff040413          	addi	s0,s0,-16
   19da8:	f71ff06f          	j	19d18 <_svfprintf_r+0x1efc>
   19dac:	01012583          	lw	a1,16(sp)
   19db0:	00090513          	mv	a0,s2
   19db4:	8ddf90ef          	jal	ra,13690 <_free_r>
   19db8:	921ff06f          	j	196d8 <_svfprintf_r+0x18bc>
   19dbc:	0ec12783          	lw	a5,236(sp)
   19dc0:	00079463          	bnez	a5,19dc8 <_svfprintf_r+0x1fac>
   19dc4:	931fe06f          	j	186f4 <_svfprintf_r+0x8d8>
   19dc8:	0e410613          	addi	a2,sp,228
   19dcc:	00098593          	mv	a1,s3
   19dd0:	00090513          	mv	a0,s2
   19dd4:	38c010ef          	jal	ra,1b160 <__ssprint_r>
   19dd8:	91dfe06f          	j	186f4 <_svfprintf_r+0x8d8>

00019ddc <__sprint_r>:
   19ddc:	00862783          	lw	a5,8(a2)
   19de0:	fd010113          	addi	sp,sp,-48
   19de4:	02812423          	sw	s0,40(sp)
   19de8:	02112623          	sw	ra,44(sp)
   19dec:	02912223          	sw	s1,36(sp)
   19df0:	03212023          	sw	s2,32(sp)
   19df4:	01312e23          	sw	s3,28(sp)
   19df8:	01412c23          	sw	s4,24(sp)
   19dfc:	01512a23          	sw	s5,20(sp)
   19e00:	01612823          	sw	s6,16(sp)
   19e04:	01712623          	sw	s7,12(sp)
   19e08:	01812423          	sw	s8,8(sp)
   19e0c:	00060413          	mv	s0,a2
   19e10:	02079e63          	bnez	a5,19e4c <__sprint_r+0x70>
   19e14:	00062223          	sw	zero,4(a2)
   19e18:	00000513          	li	a0,0
   19e1c:	02c12083          	lw	ra,44(sp)
   19e20:	02812403          	lw	s0,40(sp)
   19e24:	02412483          	lw	s1,36(sp)
   19e28:	02012903          	lw	s2,32(sp)
   19e2c:	01c12983          	lw	s3,28(sp)
   19e30:	01812a03          	lw	s4,24(sp)
   19e34:	01412a83          	lw	s5,20(sp)
   19e38:	01012b03          	lw	s6,16(sp)
   19e3c:	00c12b83          	lw	s7,12(sp)
   19e40:	00812c03          	lw	s8,8(sp)
   19e44:	03010113          	addi	sp,sp,48
   19e48:	00008067          	ret
   19e4c:	0645a783          	lw	a5,100(a1)
   19e50:	00058913          	mv	s2,a1
   19e54:	01279713          	slli	a4,a5,0x12
   19e58:	06075a63          	bgez	a4,19ecc <__sprint_r+0xf0>
   19e5c:	00062483          	lw	s1,0(a2)
   19e60:	00050a13          	mv	s4,a0
   19e64:	fff00b93          	li	s7,-1
   19e68:	00842783          	lw	a5,8(s0)
   19e6c:	00079a63          	bnez	a5,19e80 <__sprint_r+0xa4>
   19e70:	00000513          	li	a0,0
   19e74:	00042423          	sw	zero,8(s0)
   19e78:	00042223          	sw	zero,4(s0)
   19e7c:	fa1ff06f          	j	19e1c <__sprint_r+0x40>
   19e80:	0044a983          	lw	s3,4(s1)
   19e84:	0004ab03          	lw	s6,0(s1)
   19e88:	00000a93          	li	s5,0
   19e8c:	0029dc13          	srli	s8,s3,0x2
   19e90:	018ace63          	blt	s5,s8,19eac <__sprint_r+0xd0>
   19e94:	00842783          	lw	a5,8(s0)
   19e98:	ffc9f993          	andi	s3,s3,-4
   19e9c:	00848493          	addi	s1,s1,8
   19ea0:	413789b3          	sub	s3,a5,s3
   19ea4:	01342423          	sw	s3,8(s0)
   19ea8:	fc1ff06f          	j	19e68 <__sprint_r+0x8c>
   19eac:	000b2583          	lw	a1,0(s6)
   19eb0:	00090613          	mv	a2,s2
   19eb4:	000a0513          	mv	a0,s4
   19eb8:	0f4010ef          	jal	ra,1afac <_fputwc_r>
   19ebc:	004b0b13          	addi	s6,s6,4
   19ec0:	01750a63          	beq	a0,s7,19ed4 <__sprint_r+0xf8>
   19ec4:	001a8a93          	addi	s5,s5,1
   19ec8:	fc9ff06f          	j	19e90 <__sprint_r+0xb4>
   19ecc:	a21f90ef          	jal	ra,138ec <__sfvwrite_r>
   19ed0:	fa5ff06f          	j	19e74 <__sprint_r+0x98>
   19ed4:	fff00513          	li	a0,-1
   19ed8:	f9dff06f          	j	19e74 <__sprint_r+0x98>

00019edc <_vfiprintf_r>:
   19edc:	ed010113          	addi	sp,sp,-304
   19ee0:	12812423          	sw	s0,296(sp)
   19ee4:	11312e23          	sw	s3,284(sp)
   19ee8:	11412c23          	sw	s4,280(sp)
   19eec:	11a12023          	sw	s10,256(sp)
   19ef0:	12112623          	sw	ra,300(sp)
   19ef4:	12912223          	sw	s1,292(sp)
   19ef8:	13212023          	sw	s2,288(sp)
   19efc:	11512a23          	sw	s5,276(sp)
   19f00:	11612823          	sw	s6,272(sp)
   19f04:	11712623          	sw	s7,268(sp)
   19f08:	11812423          	sw	s8,264(sp)
   19f0c:	11912223          	sw	s9,260(sp)
   19f10:	0fb12e23          	sw	s11,252(sp)
   19f14:	00050993          	mv	s3,a0
   19f18:	00058413          	mv	s0,a1
   19f1c:	00060a13          	mv	s4,a2
   19f20:	00068d13          	mv	s10,a3
   19f24:	00050863          	beqz	a0,19f34 <_vfiprintf_r+0x58>
   19f28:	03852783          	lw	a5,56(a0)
   19f2c:	00079463          	bnez	a5,19f34 <_vfiprintf_r+0x58>
   19f30:	cb4f90ef          	jal	ra,133e4 <__sinit>
   19f34:	00c41783          	lh	a5,12(s0)
   19f38:	01279713          	slli	a4,a5,0x12
   19f3c:	02074263          	bltz	a4,19f60 <_vfiprintf_r+0x84>
   19f40:	000026b7          	lui	a3,0x2
   19f44:	06442703          	lw	a4,100(s0)
   19f48:	00d7e7b3          	or	a5,a5,a3
   19f4c:	00f41623          	sh	a5,12(s0)
   19f50:	ffffe7b7          	lui	a5,0xffffe
   19f54:	fff78793          	addi	a5,a5,-1 # ffffdfff <__global_pointer$+0xfffd989f>
   19f58:	00f777b3          	and	a5,a4,a5
   19f5c:	06f42223          	sw	a5,100(s0)
   19f60:	00c45783          	lhu	a5,12(s0)
   19f64:	0087f793          	andi	a5,a5,8
   19f68:	06078e63          	beqz	a5,19fe4 <_vfiprintf_r+0x108>
   19f6c:	01042783          	lw	a5,16(s0)
   19f70:	06078a63          	beqz	a5,19fe4 <_vfiprintf_r+0x108>
   19f74:	00c45783          	lhu	a5,12(s0)
   19f78:	00a00713          	li	a4,10
   19f7c:	01a7f793          	andi	a5,a5,26
   19f80:	08e79063          	bne	a5,a4,1a000 <_vfiprintf_r+0x124>
   19f84:	00e41783          	lh	a5,14(s0)
   19f88:	0607cc63          	bltz	a5,1a000 <_vfiprintf_r+0x124>
   19f8c:	000d0693          	mv	a3,s10
   19f90:	000a0613          	mv	a2,s4
   19f94:	00040593          	mv	a1,s0
   19f98:	00098513          	mv	a0,s3
   19f9c:	3c5000ef          	jal	ra,1ab60 <__sbprintf>
   19fa0:	00a12023          	sw	a0,0(sp)
   19fa4:	12c12083          	lw	ra,300(sp)
   19fa8:	12812403          	lw	s0,296(sp)
   19fac:	00012503          	lw	a0,0(sp)
   19fb0:	12412483          	lw	s1,292(sp)
   19fb4:	12012903          	lw	s2,288(sp)
   19fb8:	11c12983          	lw	s3,284(sp)
   19fbc:	11812a03          	lw	s4,280(sp)
   19fc0:	11412a83          	lw	s5,276(sp)
   19fc4:	11012b03          	lw	s6,272(sp)
   19fc8:	10c12b83          	lw	s7,268(sp)
   19fcc:	10812c03          	lw	s8,264(sp)
   19fd0:	10412c83          	lw	s9,260(sp)
   19fd4:	10012d03          	lw	s10,256(sp)
   19fd8:	0fc12d83          	lw	s11,252(sp)
   19fdc:	13010113          	addi	sp,sp,304
   19fe0:	00008067          	ret
   19fe4:	00040593          	mv	a1,s0
   19fe8:	00098513          	mv	a0,s3
   19fec:	d99f80ef          	jal	ra,12d84 <__swsetup_r>
   19ff0:	f80502e3          	beqz	a0,19f74 <_vfiprintf_r+0x98>
   19ff4:	fff00793          	li	a5,-1
   19ff8:	00f12023          	sw	a5,0(sp)
   19ffc:	fa9ff06f          	j	19fa4 <_vfiprintf_r+0xc8>
   1a000:	04c10793          	addi	a5,sp,76
   1a004:	04f12023          	sw	a5,64(sp)
   1a008:	00078b93          	mv	s7,a5
   1a00c:	000227b7          	lui	a5,0x22
   1a010:	e7c78793          	addi	a5,a5,-388 # 21e7c <zeroes.4362+0x10>
   1a014:	00f12e23          	sw	a5,28(sp)
   1a018:	000227b7          	lui	a5,0x22
   1a01c:	ff878793          	addi	a5,a5,-8 # 21ff8 <zeroes.4353>
   1a020:	04012423          	sw	zero,72(sp)
   1a024:	04012223          	sw	zero,68(sp)
   1a028:	00012623          	sw	zero,12(sp)
   1a02c:	00012223          	sw	zero,4(sp)
   1a030:	00012423          	sw	zero,8(sp)
   1a034:	00012a23          	sw	zero,20(sp)
   1a038:	00012023          	sw	zero,0(sp)
   1a03c:	00f12823          	sw	a5,16(sp)
   1a040:	000a0493          	mv	s1,s4
   1a044:	02500693          	li	a3,37
   1a048:	0004c783          	lbu	a5,0(s1)
   1a04c:	00078463          	beqz	a5,1a054 <_vfiprintf_r+0x178>
   1a050:	0ad79263          	bne	a5,a3,1a0f4 <_vfiprintf_r+0x218>
   1a054:	41448933          	sub	s2,s1,s4
   1a058:	04090a63          	beqz	s2,1a0ac <_vfiprintf_r+0x1d0>
   1a05c:	04812783          	lw	a5,72(sp)
   1a060:	014ba023          	sw	s4,0(s7)
   1a064:	012ba223          	sw	s2,4(s7)
   1a068:	012787b3          	add	a5,a5,s2
   1a06c:	04f12423          	sw	a5,72(sp)
   1a070:	04412783          	lw	a5,68(sp)
   1a074:	00700693          	li	a3,7
   1a078:	008b8b93          	addi	s7,s7,8
   1a07c:	00178793          	addi	a5,a5,1
   1a080:	04f12223          	sw	a5,68(sp)
   1a084:	00f6de63          	ble	a5,a3,1a0a0 <_vfiprintf_r+0x1c4>
   1a088:	04010613          	addi	a2,sp,64
   1a08c:	00040593          	mv	a1,s0
   1a090:	00098513          	mv	a0,s3
   1a094:	d49ff0ef          	jal	ra,19ddc <__sprint_r>
   1a098:	240518e3          	bnez	a0,1aae8 <_vfiprintf_r+0xc0c>
   1a09c:	04c10b93          	addi	s7,sp,76
   1a0a0:	00012783          	lw	a5,0(sp)
   1a0a4:	012787b3          	add	a5,a5,s2
   1a0a8:	00f12023          	sw	a5,0(sp)
   1a0ac:	0004c783          	lbu	a5,0(s1)
   1a0b0:	280780e3          	beqz	a5,1ab30 <_vfiprintf_r+0xc54>
   1a0b4:	00148a13          	addi	s4,s1,1
   1a0b8:	02010da3          	sb	zero,59(sp)
   1a0bc:	fff00913          	li	s2,-1
   1a0c0:	00000a93          	li	s5,0
   1a0c4:	00000b13          	li	s6,0
   1a0c8:	00900493          	li	s1,9
   1a0cc:	05a00c93          	li	s9,90
   1a0d0:	000a4d83          	lbu	s11,0(s4)
   1a0d4:	001a0a13          	addi	s4,s4,1
   1a0d8:	fe0d8693          	addi	a3,s11,-32
   1a0dc:	0cdce0e3          	bltu	s9,a3,1a99c <_vfiprintf_r+0xac0>
   1a0e0:	01c12783          	lw	a5,28(sp)
   1a0e4:	00269693          	slli	a3,a3,0x2
   1a0e8:	00f686b3          	add	a3,a3,a5
   1a0ec:	0006a683          	lw	a3,0(a3) # 2000 <main-0xe074>
   1a0f0:	00068067          	jr	a3
   1a0f4:	00148493          	addi	s1,s1,1
   1a0f8:	f51ff06f          	j	1a048 <_vfiprintf_r+0x16c>
   1a0fc:	000226b7          	lui	a3,0x22
   1a100:	92468793          	addi	a5,a3,-1756 # 21924 <zeroes.4377+0x6c>
   1a104:	00f12623          	sw	a5,12(sp)
   1a108:	020b7693          	andi	a3,s6,32
   1a10c:	6a068e63          	beqz	a3,1a7c8 <_vfiprintf_r+0x8ec>
   1a110:	007d0d13          	addi	s10,s10,7
   1a114:	ff8d7d13          	andi	s10,s10,-8
   1a118:	000d2883          	lw	a7,0(s10)
   1a11c:	004d2c83          	lw	s9,4(s10)
   1a120:	008d0c13          	addi	s8,s10,8
   1a124:	001b7693          	andi	a3,s6,1
   1a128:	00068e63          	beqz	a3,1a144 <_vfiprintf_r+0x268>
   1a12c:	0198e6b3          	or	a3,a7,s9
   1a130:	00068a63          	beqz	a3,1a144 <_vfiprintf_r+0x268>
   1a134:	03000693          	li	a3,48
   1a138:	02d10e23          	sb	a3,60(sp)
   1a13c:	03b10ea3          	sb	s11,61(sp)
   1a140:	002b6b13          	ori	s6,s6,2
   1a144:	bffb7b13          	andi	s6,s6,-1025
   1a148:	3380006f          	j	1a480 <_vfiprintf_r+0x5a4>
   1a14c:	00098513          	mv	a0,s3
   1a150:	dd5fb0ef          	jal	ra,15f24 <_localeconv_r>
   1a154:	00452783          	lw	a5,4(a0)
   1a158:	00078513          	mv	a0,a5
   1a15c:	00f12a23          	sw	a5,20(sp)
   1a160:	b1df60ef          	jal	ra,10c7c <strlen>
   1a164:	00a12423          	sw	a0,8(sp)
   1a168:	00098513          	mv	a0,s3
   1a16c:	db9fb0ef          	jal	ra,15f24 <_localeconv_r>
   1a170:	00852783          	lw	a5,8(a0)
   1a174:	00f12223          	sw	a5,4(sp)
   1a178:	00812783          	lw	a5,8(sp)
   1a17c:	f40788e3          	beqz	a5,1a0cc <_vfiprintf_r+0x1f0>
   1a180:	00412783          	lw	a5,4(sp)
   1a184:	f40784e3          	beqz	a5,1a0cc <_vfiprintf_r+0x1f0>
   1a188:	0007c683          	lbu	a3,0(a5)
   1a18c:	f40680e3          	beqz	a3,1a0cc <_vfiprintf_r+0x1f0>
   1a190:	400b6b13          	ori	s6,s6,1024
   1a194:	f39ff06f          	j	1a0cc <_vfiprintf_r+0x1f0>
   1a198:	03b14683          	lbu	a3,59(sp)
   1a19c:	f20698e3          	bnez	a3,1a0cc <_vfiprintf_r+0x1f0>
   1a1a0:	02000693          	li	a3,32
   1a1a4:	02d10da3          	sb	a3,59(sp)
   1a1a8:	f25ff06f          	j	1a0cc <_vfiprintf_r+0x1f0>
   1a1ac:	001b6b13          	ori	s6,s6,1
   1a1b0:	f1dff06f          	j	1a0cc <_vfiprintf_r+0x1f0>
   1a1b4:	000d2a83          	lw	s5,0(s10)
   1a1b8:	004d0d13          	addi	s10,s10,4
   1a1bc:	f00ad8e3          	bgez	s5,1a0cc <_vfiprintf_r+0x1f0>
   1a1c0:	41500ab3          	neg	s5,s5
   1a1c4:	004b6b13          	ori	s6,s6,4
   1a1c8:	f05ff06f          	j	1a0cc <_vfiprintf_r+0x1f0>
   1a1cc:	02b00693          	li	a3,43
   1a1d0:	fd5ff06f          	j	1a1a4 <_vfiprintf_r+0x2c8>
   1a1d4:	000a4d83          	lbu	s11,0(s4)
   1a1d8:	02a00793          	li	a5,42
   1a1dc:	001a0c13          	addi	s8,s4,1
   1a1e0:	04fd9463          	bne	s11,a5,1a228 <_vfiprintf_r+0x34c>
   1a1e4:	000d2903          	lw	s2,0(s10)
   1a1e8:	004d0613          	addi	a2,s10,4
   1a1ec:	00095463          	bgez	s2,1a1f4 <_vfiprintf_r+0x318>
   1a1f0:	fff00913          	li	s2,-1
   1a1f4:	00060d13          	mv	s10,a2
   1a1f8:	000c0a13          	mv	s4,s8
   1a1fc:	ed1ff06f          	j	1a0cc <_vfiprintf_r+0x1f0>
   1a200:	00090513          	mv	a0,s2
   1a204:	00a00593          	li	a1,10
   1a208:	001c0c13          	addi	s8,s8,1
   1a20c:	3a0070ef          	jal	ra,215ac <__mulsi3>
   1a210:	fffc4d83          	lbu	s11,-1(s8)
   1a214:	01450933          	add	s2,a0,s4
   1a218:	fd0d8a13          	addi	s4,s11,-48
   1a21c:	ff44f2e3          	bleu	s4,s1,1a200 <_vfiprintf_r+0x324>
   1a220:	000c0a13          	mv	s4,s8
   1a224:	eb5ff06f          	j	1a0d8 <_vfiprintf_r+0x1fc>
   1a228:	00000913          	li	s2,0
   1a22c:	fedff06f          	j	1a218 <_vfiprintf_r+0x33c>
   1a230:	080b6b13          	ori	s6,s6,128
   1a234:	e99ff06f          	j	1a0cc <_vfiprintf_r+0x1f0>
   1a238:	000a0c13          	mv	s8,s4
   1a23c:	00000a93          	li	s5,0
   1a240:	000a8513          	mv	a0,s5
   1a244:	00a00593          	li	a1,10
   1a248:	001c0c13          	addi	s8,s8,1
   1a24c:	360070ef          	jal	ra,215ac <__mulsi3>
   1a250:	fd0d8a93          	addi	s5,s11,-48
   1a254:	fffc4d83          	lbu	s11,-1(s8)
   1a258:	00aa8ab3          	add	s5,s5,a0
   1a25c:	fd0d8613          	addi	a2,s11,-48
   1a260:	fec4f0e3          	bleu	a2,s1,1a240 <_vfiprintf_r+0x364>
   1a264:	fbdff06f          	j	1a220 <_vfiprintf_r+0x344>
   1a268:	000a4603          	lbu	a2,0(s4)
   1a26c:	06800693          	li	a3,104
   1a270:	00d61863          	bne	a2,a3,1a280 <_vfiprintf_r+0x3a4>
   1a274:	001a0a13          	addi	s4,s4,1
   1a278:	200b6b13          	ori	s6,s6,512
   1a27c:	e51ff06f          	j	1a0cc <_vfiprintf_r+0x1f0>
   1a280:	040b6b13          	ori	s6,s6,64
   1a284:	e49ff06f          	j	1a0cc <_vfiprintf_r+0x1f0>
   1a288:	000a4603          	lbu	a2,0(s4)
   1a28c:	06c00693          	li	a3,108
   1a290:	00d61863          	bne	a2,a3,1a2a0 <_vfiprintf_r+0x3c4>
   1a294:	001a0a13          	addi	s4,s4,1
   1a298:	020b6b13          	ori	s6,s6,32
   1a29c:	e31ff06f          	j	1a0cc <_vfiprintf_r+0x1f0>
   1a2a0:	010b6b13          	ori	s6,s6,16
   1a2a4:	e29ff06f          	j	1a0cc <_vfiprintf_r+0x1f0>
   1a2a8:	000d2683          	lw	a3,0(s10)
   1a2ac:	004d0c13          	addi	s8,s10,4
   1a2b0:	02010da3          	sb	zero,59(sp)
   1a2b4:	08d10623          	sb	a3,140(sp)
   1a2b8:	00100913          	li	s2,1
   1a2bc:	00000c93          	li	s9,0
   1a2c0:	08c10493          	addi	s1,sp,140
   1a2c4:	1f40006f          	j	1a4b8 <_vfiprintf_r+0x5dc>
   1a2c8:	010b6b13          	ori	s6,s6,16
   1a2cc:	020b7693          	andi	a3,s6,32
   1a2d0:	04068c63          	beqz	a3,1a328 <_vfiprintf_r+0x44c>
   1a2d4:	007d0d13          	addi	s10,s10,7
   1a2d8:	ff8d7d13          	andi	s10,s10,-8
   1a2dc:	000d2883          	lw	a7,0(s10)
   1a2e0:	004d2c83          	lw	s9,4(s10)
   1a2e4:	008d0c13          	addi	s8,s10,8
   1a2e8:	000cde63          	bgez	s9,1a304 <_vfiprintf_r+0x428>
   1a2ec:	411008b3          	neg	a7,a7
   1a2f0:	011036b3          	snez	a3,a7
   1a2f4:	41900333          	neg	t1,s9
   1a2f8:	40d30cb3          	sub	s9,t1,a3
   1a2fc:	02d00693          	li	a3,45
   1a300:	02d10da3          	sb	a3,59(sp)
   1a304:	fff00693          	li	a3,-1
   1a308:	4ed91c63          	bne	s2,a3,1a800 <_vfiprintf_r+0x924>
   1a30c:	560c9663          	bnez	s9,1a878 <_vfiprintf_r+0x99c>
   1a310:	00900693          	li	a3,9
   1a314:	5716e263          	bltu	a3,a7,1a878 <_vfiprintf_r+0x99c>
   1a318:	03088893          	addi	a7,a7,48
   1a31c:	0f1107a3          	sb	a7,239(sp)
   1a320:	0ef10493          	addi	s1,sp,239
   1a324:	53c0006f          	j	1a860 <_vfiprintf_r+0x984>
   1a328:	010b7693          	andi	a3,s6,16
   1a32c:	004d0c13          	addi	s8,s10,4
   1a330:	00068863          	beqz	a3,1a340 <_vfiprintf_r+0x464>
   1a334:	000d2883          	lw	a7,0(s10)
   1a338:	41f8dc93          	srai	s9,a7,0x1f
   1a33c:	fadff06f          	j	1a2e8 <_vfiprintf_r+0x40c>
   1a340:	040b7693          	andi	a3,s6,64
   1a344:	000d2883          	lw	a7,0(s10)
   1a348:	00068863          	beqz	a3,1a358 <_vfiprintf_r+0x47c>
   1a34c:	01089893          	slli	a7,a7,0x10
   1a350:	4108d893          	srai	a7,a7,0x10
   1a354:	fe5ff06f          	j	1a338 <_vfiprintf_r+0x45c>
   1a358:	200b7693          	andi	a3,s6,512
   1a35c:	fc068ee3          	beqz	a3,1a338 <_vfiprintf_r+0x45c>
   1a360:	01889893          	slli	a7,a7,0x18
   1a364:	4188d893          	srai	a7,a7,0x18
   1a368:	fd1ff06f          	j	1a338 <_vfiprintf_r+0x45c>
   1a36c:	020b7613          	andi	a2,s6,32
   1a370:	000d2683          	lw	a3,0(s10)
   1a374:	004d0d13          	addi	s10,s10,4
   1a378:	00060c63          	beqz	a2,1a390 <_vfiprintf_r+0x4b4>
   1a37c:	00012783          	lw	a5,0(sp)
   1a380:	00f6a023          	sw	a5,0(a3)
   1a384:	41f7d793          	srai	a5,a5,0x1f
   1a388:	00f6a223          	sw	a5,4(a3)
   1a38c:	cb5ff06f          	j	1a040 <_vfiprintf_r+0x164>
   1a390:	010b7613          	andi	a2,s6,16
   1a394:	00060863          	beqz	a2,1a3a4 <_vfiprintf_r+0x4c8>
   1a398:	00012783          	lw	a5,0(sp)
   1a39c:	00f6a023          	sw	a5,0(a3)
   1a3a0:	ca1ff06f          	j	1a040 <_vfiprintf_r+0x164>
   1a3a4:	040b7613          	andi	a2,s6,64
   1a3a8:	00060863          	beqz	a2,1a3b8 <_vfiprintf_r+0x4dc>
   1a3ac:	00015783          	lhu	a5,0(sp)
   1a3b0:	00f69023          	sh	a5,0(a3)
   1a3b4:	c8dff06f          	j	1a040 <_vfiprintf_r+0x164>
   1a3b8:	200b7793          	andi	a5,s6,512
   1a3bc:	fc078ee3          	beqz	a5,1a398 <_vfiprintf_r+0x4bc>
   1a3c0:	00014783          	lbu	a5,0(sp)
   1a3c4:	00f68023          	sb	a5,0(a3)
   1a3c8:	c79ff06f          	j	1a040 <_vfiprintf_r+0x164>
   1a3cc:	010b6b13          	ori	s6,s6,16
   1a3d0:	020b7693          	andi	a3,s6,32
   1a3d4:	04068663          	beqz	a3,1a420 <_vfiprintf_r+0x544>
   1a3d8:	007d0d13          	addi	s10,s10,7
   1a3dc:	ff8d7d13          	andi	s10,s10,-8
   1a3e0:	000d2883          	lw	a7,0(s10)
   1a3e4:	004d2c83          	lw	s9,4(s10)
   1a3e8:	008d0c13          	addi	s8,s10,8
   1a3ec:	bffb7b13          	andi	s6,s6,-1025
   1a3f0:	00000693          	li	a3,0
   1a3f4:	02010da3          	sb	zero,59(sp)
   1a3f8:	fff00613          	li	a2,-1
   1a3fc:	40c90863          	beq	s2,a2,1a80c <_vfiprintf_r+0x930>
   1a400:	000b0613          	mv	a2,s6
   1a404:	0198e5b3          	or	a1,a7,s9
   1a408:	f7fb7b13          	andi	s6,s6,-129
   1a40c:	40059063          	bnez	a1,1a80c <_vfiprintf_r+0x930>
   1a410:	56090863          	beqz	s2,1a980 <_vfiprintf_r+0xaa4>
   1a414:	00100613          	li	a2,1
   1a418:	3ec69e63          	bne	a3,a2,1a814 <_vfiprintf_r+0x938>
   1a41c:	efdff06f          	j	1a318 <_vfiprintf_r+0x43c>
   1a420:	010b7693          	andi	a3,s6,16
   1a424:	004d0c13          	addi	s8,s10,4
   1a428:	00068663          	beqz	a3,1a434 <_vfiprintf_r+0x558>
   1a42c:	000d2883          	lw	a7,0(s10)
   1a430:	0100006f          	j	1a440 <_vfiprintf_r+0x564>
   1a434:	040b7693          	andi	a3,s6,64
   1a438:	00068863          	beqz	a3,1a448 <_vfiprintf_r+0x56c>
   1a43c:	000d5883          	lhu	a7,0(s10)
   1a440:	00000c93          	li	s9,0
   1a444:	fa9ff06f          	j	1a3ec <_vfiprintf_r+0x510>
   1a448:	200b7693          	andi	a3,s6,512
   1a44c:	fe0680e3          	beqz	a3,1a42c <_vfiprintf_r+0x550>
   1a450:	000d4883          	lbu	a7,0(s10)
   1a454:	fedff06f          	j	1a440 <_vfiprintf_r+0x564>
   1a458:	ffff86b7          	lui	a3,0xffff8
   1a45c:	8306c693          	xori	a3,a3,-2000
   1a460:	02d11e23          	sh	a3,60(sp)
   1a464:	000d2883          	lw	a7,0(s10)
   1a468:	000226b7          	lui	a3,0x22
   1a46c:	91068793          	addi	a5,a3,-1776 # 21910 <zeroes.4377+0x58>
   1a470:	004d0c13          	addi	s8,s10,4
   1a474:	00000c93          	li	s9,0
   1a478:	002b6b13          	ori	s6,s6,2
   1a47c:	00f12623          	sw	a5,12(sp)
   1a480:	00200693          	li	a3,2
   1a484:	f71ff06f          	j	1a3f4 <_vfiprintf_r+0x518>
   1a488:	02010da3          	sb	zero,59(sp)
   1a48c:	fff00693          	li	a3,-1
   1a490:	004d0c13          	addi	s8,s10,4
   1a494:	000d2483          	lw	s1,0(s10)
   1a498:	2ad90863          	beq	s2,a3,1a748 <_vfiprintf_r+0x86c>
   1a49c:	00090613          	mv	a2,s2
   1a4a0:	00000593          	li	a1,0
   1a4a4:	00048513          	mv	a0,s1
   1a4a8:	d7dfb0ef          	jal	ra,16224 <memchr>
   1a4ac:	00000c93          	li	s9,0
   1a4b0:	00050463          	beqz	a0,1a4b8 <_vfiprintf_r+0x5dc>
   1a4b4:	40950933          	sub	s2,a0,s1
   1a4b8:	000c8d13          	mv	s10,s9
   1a4bc:	012cd463          	ble	s2,s9,1a4c4 <_vfiprintf_r+0x5e8>
   1a4c0:	00090d13          	mv	s10,s2
   1a4c4:	03b14683          	lbu	a3,59(sp)
   1a4c8:	00068463          	beqz	a3,1a4d0 <_vfiprintf_r+0x5f4>
   1a4cc:	001d0d13          	addi	s10,s10,1
   1a4d0:	002b7d93          	andi	s11,s6,2
   1a4d4:	000d8463          	beqz	s11,1a4dc <_vfiprintf_r+0x600>
   1a4d8:	002d0d13          	addi	s10,s10,2
   1a4dc:	084b7793          	andi	a5,s6,132
   1a4e0:	00f12c23          	sw	a5,24(sp)
   1a4e4:	06079463          	bnez	a5,1a54c <_vfiprintf_r+0x670>
   1a4e8:	41aa86b3          	sub	a3,s5,s10
   1a4ec:	06d05063          	blez	a3,1a54c <_vfiprintf_r+0x670>
   1a4f0:	000227b7          	lui	a5,0x22
   1a4f4:	01000893          	li	a7,16
   1a4f8:	fe878813          	addi	a6,a5,-24 # 21fe8 <blanks.4352>
   1a4fc:	00700313          	li	t1,7
   1a500:	04412603          	lw	a2,68(sp)
   1a504:	010ba023          	sw	a6,0(s7)
   1a508:	04812583          	lw	a1,72(sp)
   1a50c:	00160613          	addi	a2,a2,1
   1a510:	008b8513          	addi	a0,s7,8
   1a514:	48d8ce63          	blt	a7,a3,1a9b0 <_vfiprintf_r+0xad4>
   1a518:	00dba223          	sw	a3,4(s7)
   1a51c:	00b686b3          	add	a3,a3,a1
   1a520:	04d12423          	sw	a3,72(sp)
   1a524:	04c12223          	sw	a2,68(sp)
   1a528:	00700693          	li	a3,7
   1a52c:	00050b93          	mv	s7,a0
   1a530:	00c6de63          	ble	a2,a3,1a54c <_vfiprintf_r+0x670>
   1a534:	04010613          	addi	a2,sp,64
   1a538:	00040593          	mv	a1,s0
   1a53c:	00098513          	mv	a0,s3
   1a540:	89dff0ef          	jal	ra,19ddc <__sprint_r>
   1a544:	5a051263          	bnez	a0,1aae8 <_vfiprintf_r+0xc0c>
   1a548:	04c10b93          	addi	s7,sp,76
   1a54c:	03b14683          	lbu	a3,59(sp)
   1a550:	04068863          	beqz	a3,1a5a0 <_vfiprintf_r+0x6c4>
   1a554:	03b10613          	addi	a2,sp,59
   1a558:	00cba023          	sw	a2,0(s7)
   1a55c:	00100613          	li	a2,1
   1a560:	04412683          	lw	a3,68(sp)
   1a564:	00cba223          	sw	a2,4(s7)
   1a568:	04812603          	lw	a2,72(sp)
   1a56c:	00168693          	addi	a3,a3,1
   1a570:	04d12223          	sw	a3,68(sp)
   1a574:	00160613          	addi	a2,a2,1
   1a578:	04c12423          	sw	a2,72(sp)
   1a57c:	00700613          	li	a2,7
   1a580:	008b8b93          	addi	s7,s7,8
   1a584:	00d65e63          	ble	a3,a2,1a5a0 <_vfiprintf_r+0x6c4>
   1a588:	04010613          	addi	a2,sp,64
   1a58c:	00040593          	mv	a1,s0
   1a590:	00098513          	mv	a0,s3
   1a594:	849ff0ef          	jal	ra,19ddc <__sprint_r>
   1a598:	54051863          	bnez	a0,1aae8 <_vfiprintf_r+0xc0c>
   1a59c:	04c10b93          	addi	s7,sp,76
   1a5a0:	040d8863          	beqz	s11,1a5f0 <_vfiprintf_r+0x714>
   1a5a4:	03c10613          	addi	a2,sp,60
   1a5a8:	00cba023          	sw	a2,0(s7)
   1a5ac:	00200613          	li	a2,2
   1a5b0:	04412683          	lw	a3,68(sp)
   1a5b4:	00cba223          	sw	a2,4(s7)
   1a5b8:	04812603          	lw	a2,72(sp)
   1a5bc:	00168693          	addi	a3,a3,1
   1a5c0:	04d12223          	sw	a3,68(sp)
   1a5c4:	00260613          	addi	a2,a2,2
   1a5c8:	04c12423          	sw	a2,72(sp)
   1a5cc:	00700613          	li	a2,7
   1a5d0:	008b8b93          	addi	s7,s7,8
   1a5d4:	00d65e63          	ble	a3,a2,1a5f0 <_vfiprintf_r+0x714>
   1a5d8:	04010613          	addi	a2,sp,64
   1a5dc:	00040593          	mv	a1,s0
   1a5e0:	00098513          	mv	a0,s3
   1a5e4:	ff8ff0ef          	jal	ra,19ddc <__sprint_r>
   1a5e8:	50051063          	bnez	a0,1aae8 <_vfiprintf_r+0xc0c>
   1a5ec:	04c10b93          	addi	s7,sp,76
   1a5f0:	01812783          	lw	a5,24(sp)
   1a5f4:	08000693          	li	a3,128
   1a5f8:	06d79263          	bne	a5,a3,1a65c <_vfiprintf_r+0x780>
   1a5fc:	41aa8db3          	sub	s11,s5,s10
   1a600:	05b05e63          	blez	s11,1a65c <_vfiprintf_r+0x780>
   1a604:	01000813          	li	a6,16
   1a608:	00700893          	li	a7,7
   1a60c:	01012783          	lw	a5,16(sp)
   1a610:	04412683          	lw	a3,68(sp)
   1a614:	04812603          	lw	a2,72(sp)
   1a618:	00fba023          	sw	a5,0(s7)
   1a61c:	00168693          	addi	a3,a3,1
   1a620:	008b8593          	addi	a1,s7,8
   1a624:	3fb84263          	blt	a6,s11,1aa08 <_vfiprintf_r+0xb2c>
   1a628:	01bba223          	sw	s11,4(s7)
   1a62c:	00cd8db3          	add	s11,s11,a2
   1a630:	05b12423          	sw	s11,72(sp)
   1a634:	04d12223          	sw	a3,68(sp)
   1a638:	00700613          	li	a2,7
   1a63c:	00058b93          	mv	s7,a1
   1a640:	00d65e63          	ble	a3,a2,1a65c <_vfiprintf_r+0x780>
   1a644:	04010613          	addi	a2,sp,64
   1a648:	00040593          	mv	a1,s0
   1a64c:	00098513          	mv	a0,s3
   1a650:	f8cff0ef          	jal	ra,19ddc <__sprint_r>
   1a654:	48051a63          	bnez	a0,1aae8 <_vfiprintf_r+0xc0c>
   1a658:	04c10b93          	addi	s7,sp,76
   1a65c:	412c8cb3          	sub	s9,s9,s2
   1a660:	05905e63          	blez	s9,1a6bc <_vfiprintf_r+0x7e0>
   1a664:	01000d93          	li	s11,16
   1a668:	00700813          	li	a6,7
   1a66c:	01012783          	lw	a5,16(sp)
   1a670:	04412683          	lw	a3,68(sp)
   1a674:	04812603          	lw	a2,72(sp)
   1a678:	00fba023          	sw	a5,0(s7)
   1a67c:	00168693          	addi	a3,a3,1
   1a680:	008b8593          	addi	a1,s7,8
   1a684:	3d9dc663          	blt	s11,s9,1aa50 <_vfiprintf_r+0xb74>
   1a688:	019ba223          	sw	s9,4(s7)
   1a68c:	00cc8cb3          	add	s9,s9,a2
   1a690:	05912423          	sw	s9,72(sp)
   1a694:	04d12223          	sw	a3,68(sp)
   1a698:	00700613          	li	a2,7
   1a69c:	00058b93          	mv	s7,a1
   1a6a0:	00d65e63          	ble	a3,a2,1a6bc <_vfiprintf_r+0x7e0>
   1a6a4:	04010613          	addi	a2,sp,64
   1a6a8:	00040593          	mv	a1,s0
   1a6ac:	00098513          	mv	a0,s3
   1a6b0:	f2cff0ef          	jal	ra,19ddc <__sprint_r>
   1a6b4:	42051a63          	bnez	a0,1aae8 <_vfiprintf_r+0xc0c>
   1a6b8:	04c10b93          	addi	s7,sp,76
   1a6bc:	04812683          	lw	a3,72(sp)
   1a6c0:	012ba223          	sw	s2,4(s7)
   1a6c4:	009ba023          	sw	s1,0(s7)
   1a6c8:	01268933          	add	s2,a3,s2
   1a6cc:	04412683          	lw	a3,68(sp)
   1a6d0:	05212423          	sw	s2,72(sp)
   1a6d4:	00700613          	li	a2,7
   1a6d8:	00168693          	addi	a3,a3,1
   1a6dc:	04d12223          	sw	a3,68(sp)
   1a6e0:	008b8713          	addi	a4,s7,8
   1a6e4:	00d65e63          	ble	a3,a2,1a700 <_vfiprintf_r+0x824>
   1a6e8:	04010613          	addi	a2,sp,64
   1a6ec:	00040593          	mv	a1,s0
   1a6f0:	00098513          	mv	a0,s3
   1a6f4:	ee8ff0ef          	jal	ra,19ddc <__sprint_r>
   1a6f8:	3e051863          	bnez	a0,1aae8 <_vfiprintf_r+0xc0c>
   1a6fc:	04c10713          	addi	a4,sp,76
   1a700:	004b7793          	andi	a5,s6,4
   1a704:	38079663          	bnez	a5,1aa90 <_vfiprintf_r+0xbb4>
   1a708:	01aad463          	ble	s10,s5,1a710 <_vfiprintf_r+0x834>
   1a70c:	000d0a93          	mv	s5,s10
   1a710:	00012783          	lw	a5,0(sp)
   1a714:	015787b3          	add	a5,a5,s5
   1a718:	00f12023          	sw	a5,0(sp)
   1a71c:	04812783          	lw	a5,72(sp)
   1a720:	00078c63          	beqz	a5,1a738 <_vfiprintf_r+0x85c>
   1a724:	04010613          	addi	a2,sp,64
   1a728:	00040593          	mv	a1,s0
   1a72c:	00098513          	mv	a0,s3
   1a730:	eacff0ef          	jal	ra,19ddc <__sprint_r>
   1a734:	3a051a63          	bnez	a0,1aae8 <_vfiprintf_r+0xc0c>
   1a738:	04012223          	sw	zero,68(sp)
   1a73c:	000c0d13          	mv	s10,s8
   1a740:	04c10b93          	addi	s7,sp,76
   1a744:	8fdff06f          	j	1a040 <_vfiprintf_r+0x164>
   1a748:	00048513          	mv	a0,s1
   1a74c:	d30f60ef          	jal	ra,10c7c <strlen>
   1a750:	00050913          	mv	s2,a0
   1a754:	00000c93          	li	s9,0
   1a758:	d61ff06f          	j	1a4b8 <_vfiprintf_r+0x5dc>
   1a75c:	010b6b13          	ori	s6,s6,16
   1a760:	020b7693          	andi	a3,s6,32
   1a764:	02068063          	beqz	a3,1a784 <_vfiprintf_r+0x8a8>
   1a768:	007d0d13          	addi	s10,s10,7
   1a76c:	ff8d7d13          	andi	s10,s10,-8
   1a770:	000d2883          	lw	a7,0(s10)
   1a774:	004d2c83          	lw	s9,4(s10)
   1a778:	008d0c13          	addi	s8,s10,8
   1a77c:	00100693          	li	a3,1
   1a780:	c75ff06f          	j	1a3f4 <_vfiprintf_r+0x518>
   1a784:	010b7693          	andi	a3,s6,16
   1a788:	004d0c13          	addi	s8,s10,4
   1a78c:	00068663          	beqz	a3,1a798 <_vfiprintf_r+0x8bc>
   1a790:	000d2883          	lw	a7,0(s10)
   1a794:	0100006f          	j	1a7a4 <_vfiprintf_r+0x8c8>
   1a798:	040b7693          	andi	a3,s6,64
   1a79c:	00068863          	beqz	a3,1a7ac <_vfiprintf_r+0x8d0>
   1a7a0:	000d5883          	lhu	a7,0(s10)
   1a7a4:	00000c93          	li	s9,0
   1a7a8:	fd5ff06f          	j	1a77c <_vfiprintf_r+0x8a0>
   1a7ac:	200b7693          	andi	a3,s6,512
   1a7b0:	fe0680e3          	beqz	a3,1a790 <_vfiprintf_r+0x8b4>
   1a7b4:	000d4883          	lbu	a7,0(s10)
   1a7b8:	fedff06f          	j	1a7a4 <_vfiprintf_r+0x8c8>
   1a7bc:	000226b7          	lui	a3,0x22
   1a7c0:	91068793          	addi	a5,a3,-1776 # 21910 <zeroes.4377+0x58>
   1a7c4:	941ff06f          	j	1a104 <_vfiprintf_r+0x228>
   1a7c8:	010b7693          	andi	a3,s6,16
   1a7cc:	004d0c13          	addi	s8,s10,4
   1a7d0:	00068663          	beqz	a3,1a7dc <_vfiprintf_r+0x900>
   1a7d4:	000d2883          	lw	a7,0(s10)
   1a7d8:	0100006f          	j	1a7e8 <_vfiprintf_r+0x90c>
   1a7dc:	040b7693          	andi	a3,s6,64
   1a7e0:	00068863          	beqz	a3,1a7f0 <_vfiprintf_r+0x914>
   1a7e4:	000d5883          	lhu	a7,0(s10)
   1a7e8:	00000c93          	li	s9,0
   1a7ec:	939ff06f          	j	1a124 <_vfiprintf_r+0x248>
   1a7f0:	200b7693          	andi	a3,s6,512
   1a7f4:	fe0680e3          	beqz	a3,1a7d4 <_vfiprintf_r+0x8f8>
   1a7f8:	000d4883          	lbu	a7,0(s10)
   1a7fc:	fedff06f          	j	1a7e8 <_vfiprintf_r+0x90c>
   1a800:	000b0613          	mv	a2,s6
   1a804:	00100693          	li	a3,1
   1a808:	bfdff06f          	j	1a404 <_vfiprintf_r+0x528>
   1a80c:	00100613          	li	a2,1
   1a810:	aec68ee3          	beq	a3,a2,1a30c <_vfiprintf_r+0x430>
   1a814:	00200613          	li	a2,2
   1a818:	12c68863          	beq	a3,a2,1a948 <_vfiprintf_r+0xa6c>
   1a81c:	0f010693          	addi	a3,sp,240
   1a820:	01dc9593          	slli	a1,s9,0x1d
   1a824:	0078f613          	andi	a2,a7,7
   1a828:	0038d893          	srli	a7,a7,0x3
   1a82c:	03060613          	addi	a2,a2,48
   1a830:	0115e8b3          	or	a7,a1,a7
   1a834:	003cdc93          	srli	s9,s9,0x3
   1a838:	fec68fa3          	sb	a2,-1(a3)
   1a83c:	0198e5b3          	or	a1,a7,s9
   1a840:	fff68493          	addi	s1,a3,-1
   1a844:	02059663          	bnez	a1,1a870 <_vfiprintf_r+0x994>
   1a848:	001b7593          	andi	a1,s6,1
   1a84c:	00058a63          	beqz	a1,1a860 <_vfiprintf_r+0x984>
   1a850:	03000593          	li	a1,48
   1a854:	00b60663          	beq	a2,a1,1a860 <_vfiprintf_r+0x984>
   1a858:	feb48fa3          	sb	a1,-1(s1)
   1a85c:	ffe68493          	addi	s1,a3,-2
   1a860:	0f010793          	addi	a5,sp,240
   1a864:	00090c93          	mv	s9,s2
   1a868:	40978933          	sub	s2,a5,s1
   1a86c:	c4dff06f          	j	1a4b8 <_vfiprintf_r+0x5dc>
   1a870:	00048693          	mv	a3,s1
   1a874:	fadff06f          	j	1a820 <_vfiprintf_r+0x944>
   1a878:	400b7793          	andi	a5,s6,1024
   1a87c:	00000d13          	li	s10,0
   1a880:	0f010e13          	addi	t3,sp,240
   1a884:	00f12c23          	sw	a5,24(sp)
   1a888:	00900d93          	li	s11,9
   1a88c:	00088513          	mv	a0,a7
   1a890:	00a00613          	li	a2,10
   1a894:	00000693          	li	a3,0
   1a898:	000c8593          	mv	a1,s9
   1a89c:	fffe0493          	addi	s1,t3,-1
   1a8a0:	03c12223          	sw	t3,36(sp)
   1a8a4:	03112023          	sw	a7,32(sp)
   1a8a8:	3c0020ef          	jal	ra,1cc68 <__umoddi3>
   1a8ac:	02412e03          	lw	t3,36(sp)
   1a8b0:	01812783          	lw	a5,24(sp)
   1a8b4:	03050513          	addi	a0,a0,48
   1a8b8:	feae0fa3          	sb	a0,-1(t3)
   1a8bc:	001d0d13          	addi	s10,s10,1
   1a8c0:	02012883          	lw	a7,32(sp)
   1a8c4:	04078c63          	beqz	a5,1a91c <_vfiprintf_r+0xa40>
   1a8c8:	00412783          	lw	a5,4(sp)
   1a8cc:	0007c683          	lbu	a3,0(a5)
   1a8d0:	05a69663          	bne	a3,s10,1a91c <_vfiprintf_r+0xa40>
   1a8d4:	0ff00793          	li	a5,255
   1a8d8:	04fd0263          	beq	s10,a5,1a91c <_vfiprintf_r+0xa40>
   1a8dc:	000c9463          	bnez	s9,1a8e4 <_vfiprintf_r+0xa08>
   1a8e0:	031dfe63          	bleu	a7,s11,1a91c <_vfiprintf_r+0xa40>
   1a8e4:	00812783          	lw	a5,8(sp)
   1a8e8:	01412583          	lw	a1,20(sp)
   1a8ec:	03112023          	sw	a7,32(sp)
   1a8f0:	40f484b3          	sub	s1,s1,a5
   1a8f4:	00078613          	mv	a2,a5
   1a8f8:	00048513          	mv	a0,s1
   1a8fc:	cd8fd0ef          	jal	ra,17dd4 <strncpy>
   1a900:	00412783          	lw	a5,4(sp)
   1a904:	00000d13          	li	s10,0
   1a908:	02012883          	lw	a7,32(sp)
   1a90c:	0017c683          	lbu	a3,1(a5)
   1a910:	00068663          	beqz	a3,1a91c <_vfiprintf_r+0xa40>
   1a914:	00178793          	addi	a5,a5,1
   1a918:	00f12223          	sw	a5,4(sp)
   1a91c:	00088513          	mv	a0,a7
   1a920:	000c8593          	mv	a1,s9
   1a924:	00a00613          	li	a2,10
   1a928:	00000693          	li	a3,0
   1a92c:	561010ef          	jal	ra,1c68c <__udivdi3>
   1a930:	00058c93          	mv	s9,a1
   1a934:	00a5e5b3          	or	a1,a1,a0
   1a938:	00050893          	mv	a7,a0
   1a93c:	f20582e3          	beqz	a1,1a860 <_vfiprintf_r+0x984>
   1a940:	00048e13          	mv	t3,s1
   1a944:	f49ff06f          	j	1a88c <_vfiprintf_r+0x9b0>
   1a948:	0f010493          	addi	s1,sp,240
   1a94c:	00c12783          	lw	a5,12(sp)
   1a950:	00f8f693          	andi	a3,a7,15
   1a954:	fff48493          	addi	s1,s1,-1
   1a958:	00d786b3          	add	a3,a5,a3
   1a95c:	0006c683          	lbu	a3,0(a3)
   1a960:	0048d893          	srli	a7,a7,0x4
   1a964:	00d48023          	sb	a3,0(s1)
   1a968:	01cc9693          	slli	a3,s9,0x1c
   1a96c:	0116e8b3          	or	a7,a3,a7
   1a970:	004cdc93          	srli	s9,s9,0x4
   1a974:	0198e6b3          	or	a3,a7,s9
   1a978:	fc069ae3          	bnez	a3,1a94c <_vfiprintf_r+0xa70>
   1a97c:	ee5ff06f          	j	1a860 <_vfiprintf_r+0x984>
   1a980:	0f010493          	addi	s1,sp,240
   1a984:	ec069ee3          	bnez	a3,1a860 <_vfiprintf_r+0x984>
   1a988:	00167613          	andi	a2,a2,1
   1a98c:	ec060ae3          	beqz	a2,1a860 <_vfiprintf_r+0x984>
   1a990:	03000693          	li	a3,48
   1a994:	0ed107a3          	sb	a3,239(sp)
   1a998:	989ff06f          	j	1a320 <_vfiprintf_r+0x444>
   1a99c:	180d8a63          	beqz	s11,1ab30 <_vfiprintf_r+0xc54>
   1a9a0:	09b10623          	sb	s11,140(sp)
   1a9a4:	02010da3          	sb	zero,59(sp)
   1a9a8:	000d0c13          	mv	s8,s10
   1a9ac:	90dff06f          	j	1a2b8 <_vfiprintf_r+0x3dc>
   1a9b0:	01058593          	addi	a1,a1,16
   1a9b4:	011ba223          	sw	a7,4(s7)
   1a9b8:	04b12423          	sw	a1,72(sp)
   1a9bc:	04c12223          	sw	a2,68(sp)
   1a9c0:	02c35e63          	ble	a2,t1,1a9fc <_vfiprintf_r+0xb20>
   1a9c4:	04010613          	addi	a2,sp,64
   1a9c8:	00040593          	mv	a1,s0
   1a9cc:	00098513          	mv	a0,s3
   1a9d0:	02612623          	sw	t1,44(sp)
   1a9d4:	03012423          	sw	a6,40(sp)
   1a9d8:	03112223          	sw	a7,36(sp)
   1a9dc:	02d12023          	sw	a3,32(sp)
   1a9e0:	bfcff0ef          	jal	ra,19ddc <__sprint_r>
   1a9e4:	10051263          	bnez	a0,1aae8 <_vfiprintf_r+0xc0c>
   1a9e8:	02c12303          	lw	t1,44(sp)
   1a9ec:	02812803          	lw	a6,40(sp)
   1a9f0:	02412883          	lw	a7,36(sp)
   1a9f4:	02012683          	lw	a3,32(sp)
   1a9f8:	04c10513          	addi	a0,sp,76
   1a9fc:	ff068693          	addi	a3,a3,-16
   1aa00:	00050b93          	mv	s7,a0
   1aa04:	afdff06f          	j	1a500 <_vfiprintf_r+0x624>
   1aa08:	01060613          	addi	a2,a2,16
   1aa0c:	010ba223          	sw	a6,4(s7)
   1aa10:	04c12423          	sw	a2,72(sp)
   1aa14:	04d12223          	sw	a3,68(sp)
   1aa18:	02d8d663          	ble	a3,a7,1aa44 <_vfiprintf_r+0xb68>
   1aa1c:	04010613          	addi	a2,sp,64
   1aa20:	00040593          	mv	a1,s0
   1aa24:	00098513          	mv	a0,s3
   1aa28:	03112023          	sw	a7,32(sp)
   1aa2c:	01012c23          	sw	a6,24(sp)
   1aa30:	bacff0ef          	jal	ra,19ddc <__sprint_r>
   1aa34:	0a051a63          	bnez	a0,1aae8 <_vfiprintf_r+0xc0c>
   1aa38:	02012883          	lw	a7,32(sp)
   1aa3c:	01812803          	lw	a6,24(sp)
   1aa40:	04c10593          	addi	a1,sp,76
   1aa44:	ff0d8d93          	addi	s11,s11,-16
   1aa48:	00058b93          	mv	s7,a1
   1aa4c:	bc1ff06f          	j	1a60c <_vfiprintf_r+0x730>
   1aa50:	01060613          	addi	a2,a2,16
   1aa54:	01bba223          	sw	s11,4(s7)
   1aa58:	04c12423          	sw	a2,72(sp)
   1aa5c:	04d12223          	sw	a3,68(sp)
   1aa60:	02d85263          	ble	a3,a6,1aa84 <_vfiprintf_r+0xba8>
   1aa64:	04010613          	addi	a2,sp,64
   1aa68:	00040593          	mv	a1,s0
   1aa6c:	00098513          	mv	a0,s3
   1aa70:	01012c23          	sw	a6,24(sp)
   1aa74:	b68ff0ef          	jal	ra,19ddc <__sprint_r>
   1aa78:	06051863          	bnez	a0,1aae8 <_vfiprintf_r+0xc0c>
   1aa7c:	01812803          	lw	a6,24(sp)
   1aa80:	04c10593          	addi	a1,sp,76
   1aa84:	ff0c8c93          	addi	s9,s9,-16
   1aa88:	00058b93          	mv	s7,a1
   1aa8c:	be1ff06f          	j	1a66c <_vfiprintf_r+0x790>
   1aa90:	41aa84b3          	sub	s1,s5,s10
   1aa94:	c6905ae3          	blez	s1,1a708 <_vfiprintf_r+0x82c>
   1aa98:	000227b7          	lui	a5,0x22
   1aa9c:	01000c93          	li	s9,16
   1aaa0:	fe878913          	addi	s2,a5,-24 # 21fe8 <blanks.4352>
   1aaa4:	00700d93          	li	s11,7
   1aaa8:	04412783          	lw	a5,68(sp)
   1aaac:	01272023          	sw	s2,0(a4)
   1aab0:	04812683          	lw	a3,72(sp)
   1aab4:	00178793          	addi	a5,a5,1
   1aab8:	049cc063          	blt	s9,s1,1aaf8 <_vfiprintf_r+0xc1c>
   1aabc:	00972223          	sw	s1,4(a4)
   1aac0:	00d484b3          	add	s1,s1,a3
   1aac4:	04912423          	sw	s1,72(sp)
   1aac8:	04f12223          	sw	a5,68(sp)
   1aacc:	00700713          	li	a4,7
   1aad0:	c2f75ce3          	ble	a5,a4,1a708 <_vfiprintf_r+0x82c>
   1aad4:	04010613          	addi	a2,sp,64
   1aad8:	00040593          	mv	a1,s0
   1aadc:	00098513          	mv	a0,s3
   1aae0:	afcff0ef          	jal	ra,19ddc <__sprint_r>
   1aae4:	c20502e3          	beqz	a0,1a708 <_vfiprintf_r+0x82c>
   1aae8:	00c45783          	lhu	a5,12(s0)
   1aaec:	0407f793          	andi	a5,a5,64
   1aaf0:	ca078a63          	beqz	a5,19fa4 <_vfiprintf_r+0xc8>
   1aaf4:	d00ff06f          	j	19ff4 <_vfiprintf_r+0x118>
   1aaf8:	01068693          	addi	a3,a3,16
   1aafc:	01972223          	sw	s9,4(a4)
   1ab00:	04d12423          	sw	a3,72(sp)
   1ab04:	04f12223          	sw	a5,68(sp)
   1ab08:	00870713          	addi	a4,a4,8
   1ab0c:	00fdde63          	ble	a5,s11,1ab28 <_vfiprintf_r+0xc4c>
   1ab10:	04010613          	addi	a2,sp,64
   1ab14:	00040593          	mv	a1,s0
   1ab18:	00098513          	mv	a0,s3
   1ab1c:	ac0ff0ef          	jal	ra,19ddc <__sprint_r>
   1ab20:	fc0514e3          	bnez	a0,1aae8 <_vfiprintf_r+0xc0c>
   1ab24:	04c10713          	addi	a4,sp,76
   1ab28:	ff048493          	addi	s1,s1,-16
   1ab2c:	f7dff06f          	j	1aaa8 <_vfiprintf_r+0xbcc>
   1ab30:	04812783          	lw	a5,72(sp)
   1ab34:	fa078ae3          	beqz	a5,1aae8 <_vfiprintf_r+0xc0c>
   1ab38:	04010613          	addi	a2,sp,64
   1ab3c:	00040593          	mv	a1,s0
   1ab40:	00098513          	mv	a0,s3
   1ab44:	a98ff0ef          	jal	ra,19ddc <__sprint_r>
   1ab48:	fa1ff06f          	j	1aae8 <_vfiprintf_r+0xc0c>

0001ab4c <vfiprintf>:
   1ab4c:	00060693          	mv	a3,a2
   1ab50:	00058613          	mv	a2,a1
   1ab54:	00050593          	mv	a1,a0
   1ab58:	8201a503          	lw	a0,-2016(gp) # 23f80 <_impure_ptr>
   1ab5c:	b80ff06f          	j	19edc <_vfiprintf_r>

0001ab60 <__sbprintf>:
   1ab60:	00c5d783          	lhu	a5,12(a1)
   1ab64:	b8010113          	addi	sp,sp,-1152
   1ab68:	46812c23          	sw	s0,1144(sp)
   1ab6c:	ffd7f793          	andi	a5,a5,-3
   1ab70:	00f11a23          	sh	a5,20(sp)
   1ab74:	0645a783          	lw	a5,100(a1)
   1ab78:	00058413          	mv	s0,a1
   1ab7c:	46912a23          	sw	s1,1140(sp)
   1ab80:	06f12623          	sw	a5,108(sp)
   1ab84:	00e5d783          	lhu	a5,14(a1)
   1ab88:	47212823          	sw	s2,1136(sp)
   1ab8c:	46112e23          	sw	ra,1148(sp)
   1ab90:	00f11b23          	sh	a5,22(sp)
   1ab94:	01c5a783          	lw	a5,28(a1)
   1ab98:	00050913          	mv	s2,a0
   1ab9c:	02012023          	sw	zero,32(sp)
   1aba0:	02f12223          	sw	a5,36(sp)
   1aba4:	0245a783          	lw	a5,36(a1)
   1aba8:	00810593          	addi	a1,sp,8
   1abac:	02f12623          	sw	a5,44(sp)
   1abb0:	07010793          	addi	a5,sp,112
   1abb4:	00f12423          	sw	a5,8(sp)
   1abb8:	00f12c23          	sw	a5,24(sp)
   1abbc:	40000793          	li	a5,1024
   1abc0:	00f12823          	sw	a5,16(sp)
   1abc4:	00f12e23          	sw	a5,28(sp)
   1abc8:	b14ff0ef          	jal	ra,19edc <_vfiprintf_r>
   1abcc:	00050493          	mv	s1,a0
   1abd0:	00054c63          	bltz	a0,1abe8 <__sbprintf+0x88>
   1abd4:	00810593          	addi	a1,sp,8
   1abd8:	00090513          	mv	a0,s2
   1abdc:	e6cf80ef          	jal	ra,13248 <_fflush_r>
   1abe0:	00050463          	beqz	a0,1abe8 <__sbprintf+0x88>
   1abe4:	fff00493          	li	s1,-1
   1abe8:	01415783          	lhu	a5,20(sp)
   1abec:	0407f793          	andi	a5,a5,64
   1abf0:	00078863          	beqz	a5,1ac00 <__sbprintf+0xa0>
   1abf4:	00c45783          	lhu	a5,12(s0)
   1abf8:	0407e793          	ori	a5,a5,64
   1abfc:	00f41623          	sh	a5,12(s0)
   1ac00:	47c12083          	lw	ra,1148(sp)
   1ac04:	47812403          	lw	s0,1144(sp)
   1ac08:	00048513          	mv	a0,s1
   1ac0c:	47012903          	lw	s2,1136(sp)
   1ac10:	47412483          	lw	s1,1140(sp)
   1ac14:	48010113          	addi	sp,sp,1152
   1ac18:	00008067          	ret

0001ac1c <_wctomb_r>:
   1ac1c:	8201a783          	lw	a5,-2016(gp) # 23f80 <_impure_ptr>
   1ac20:	0347a783          	lw	a5,52(a5)
   1ac24:	00079663          	bnez	a5,1ac30 <_wctomb_r+0x14>
   1ac28:	000247b7          	lui	a5,0x24
   1ac2c:	df078793          	addi	a5,a5,-528 # 23df0 <__global_locale>
   1ac30:	0e07a303          	lw	t1,224(a5)
   1ac34:	00030067          	jr	t1

0001ac38 <__ascii_wctomb>:
   1ac38:	02058463          	beqz	a1,1ac60 <__ascii_wctomb+0x28>
   1ac3c:	0ff00793          	li	a5,255
   1ac40:	00c7fa63          	bleu	a2,a5,1ac54 <__ascii_wctomb+0x1c>
   1ac44:	08a00793          	li	a5,138
   1ac48:	00f52023          	sw	a5,0(a0)
   1ac4c:	fff00513          	li	a0,-1
   1ac50:	00008067          	ret
   1ac54:	00c58023          	sb	a2,0(a1)
   1ac58:	00100513          	li	a0,1
   1ac5c:	00008067          	ret
   1ac60:	00000513          	li	a0,0
   1ac64:	00008067          	ret

0001ac68 <_write_r>:
   1ac68:	ff010113          	addi	sp,sp,-16
   1ac6c:	00812423          	sw	s0,8(sp)
   1ac70:	00912223          	sw	s1,4(sp)
   1ac74:	00050493          	mv	s1,a0
   1ac78:	00058513          	mv	a0,a1
   1ac7c:	00060593          	mv	a1,a2
   1ac80:	00068613          	mv	a2,a3
   1ac84:	00112623          	sw	ra,12(sp)
   1ac88:	8801a623          	sw	zero,-1908(gp) # 23fec <errno>
   1ac8c:	5ac010ef          	jal	ra,1c238 <write>
   1ac90:	fff00793          	li	a5,-1
   1ac94:	00f51863          	bne	a0,a5,1aca4 <_write_r+0x3c>
   1ac98:	88c1a783          	lw	a5,-1908(gp) # 23fec <errno>
   1ac9c:	00078463          	beqz	a5,1aca4 <_write_r+0x3c>
   1aca0:	00f4a023          	sw	a5,0(s1)
   1aca4:	00c12083          	lw	ra,12(sp)
   1aca8:	00812403          	lw	s0,8(sp)
   1acac:	00412483          	lw	s1,4(sp)
   1acb0:	01010113          	addi	sp,sp,16
   1acb4:	00008067          	ret

0001acb8 <_calloc_r>:
   1acb8:	ff010113          	addi	sp,sp,-16
   1acbc:	00812423          	sw	s0,8(sp)
   1acc0:	00050413          	mv	s0,a0
   1acc4:	00058513          	mv	a0,a1
   1acc8:	00060593          	mv	a1,a2
   1accc:	00112623          	sw	ra,12(sp)
   1acd0:	0dd060ef          	jal	ra,215ac <__mulsi3>
   1acd4:	00050593          	mv	a1,a0
   1acd8:	00040513          	mv	a0,s0
   1acdc:	ed0f50ef          	jal	ra,103ac <_malloc_r>
   1ace0:	00050413          	mv	s0,a0
   1ace4:	04050263          	beqz	a0,1ad28 <_calloc_r+0x70>
   1ace8:	ffc52603          	lw	a2,-4(a0)
   1acec:	02400713          	li	a4,36
   1acf0:	ffc67613          	andi	a2,a2,-4
   1acf4:	ffc60613          	addi	a2,a2,-4
   1acf8:	06c76263          	bltu	a4,a2,1ad5c <_calloc_r+0xa4>
   1acfc:	01300693          	li	a3,19
   1ad00:	00050793          	mv	a5,a0
   1ad04:	00c6fc63          	bleu	a2,a3,1ad1c <_calloc_r+0x64>
   1ad08:	00052023          	sw	zero,0(a0)
   1ad0c:	00052223          	sw	zero,4(a0)
   1ad10:	01b00793          	li	a5,27
   1ad14:	02c7e463          	bltu	a5,a2,1ad3c <_calloc_r+0x84>
   1ad18:	00850793          	addi	a5,a0,8
   1ad1c:	0007a023          	sw	zero,0(a5)
   1ad20:	0007a223          	sw	zero,4(a5)
   1ad24:	0007a423          	sw	zero,8(a5)
   1ad28:	00040513          	mv	a0,s0
   1ad2c:	00c12083          	lw	ra,12(sp)
   1ad30:	00812403          	lw	s0,8(sp)
   1ad34:	01010113          	addi	sp,sp,16
   1ad38:	00008067          	ret
   1ad3c:	00052423          	sw	zero,8(a0)
   1ad40:	00052623          	sw	zero,12(a0)
   1ad44:	01050793          	addi	a5,a0,16
   1ad48:	fce61ae3          	bne	a2,a4,1ad1c <_calloc_r+0x64>
   1ad4c:	00052823          	sw	zero,16(a0)
   1ad50:	01850793          	addi	a5,a0,24
   1ad54:	00052a23          	sw	zero,20(a0)
   1ad58:	fc5ff06f          	j	1ad1c <_calloc_r+0x64>
   1ad5c:	00000593          	li	a1,0
   1ad60:	c91f50ef          	jal	ra,109f0 <memset>
   1ad64:	fc5ff06f          	j	1ad28 <_calloc_r+0x70>

0001ad68 <_close_r>:
   1ad68:	ff010113          	addi	sp,sp,-16
   1ad6c:	00812423          	sw	s0,8(sp)
   1ad70:	00912223          	sw	s1,4(sp)
   1ad74:	00050493          	mv	s1,a0
   1ad78:	00058513          	mv	a0,a1
   1ad7c:	00112623          	sw	ra,12(sp)
   1ad80:	8801a623          	sw	zero,-1908(gp) # 23fec <errno>
   1ad84:	64c010ef          	jal	ra,1c3d0 <close>
   1ad88:	fff00793          	li	a5,-1
   1ad8c:	00f51863          	bne	a0,a5,1ad9c <_close_r+0x34>
   1ad90:	88c1a783          	lw	a5,-1908(gp) # 23fec <errno>
   1ad94:	00078463          	beqz	a5,1ad9c <_close_r+0x34>
   1ad98:	00f4a023          	sw	a5,0(s1)
   1ad9c:	00c12083          	lw	ra,12(sp)
   1ada0:	00812403          	lw	s0,8(sp)
   1ada4:	00412483          	lw	s1,4(sp)
   1ada8:	01010113          	addi	sp,sp,16
   1adac:	00008067          	ret

0001adb0 <_fclose_r>:
   1adb0:	ff010113          	addi	sp,sp,-16
   1adb4:	00112623          	sw	ra,12(sp)
   1adb8:	00812423          	sw	s0,8(sp)
   1adbc:	00912223          	sw	s1,4(sp)
   1adc0:	01212023          	sw	s2,0(sp)
   1adc4:	02059263          	bnez	a1,1ade8 <_fclose_r+0x38>
   1adc8:	00000913          	li	s2,0
   1adcc:	00c12083          	lw	ra,12(sp)
   1add0:	00812403          	lw	s0,8(sp)
   1add4:	00090513          	mv	a0,s2
   1add8:	00412483          	lw	s1,4(sp)
   1addc:	00012903          	lw	s2,0(sp)
   1ade0:	01010113          	addi	sp,sp,16
   1ade4:	00008067          	ret
   1ade8:	00050493          	mv	s1,a0
   1adec:	00058413          	mv	s0,a1
   1adf0:	00050863          	beqz	a0,1ae00 <_fclose_r+0x50>
   1adf4:	03852783          	lw	a5,56(a0)
   1adf8:	00079463          	bnez	a5,1ae00 <_fclose_r+0x50>
   1adfc:	de8f80ef          	jal	ra,133e4 <__sinit>
   1ae00:	00c41783          	lh	a5,12(s0)
   1ae04:	fc0782e3          	beqz	a5,1adc8 <_fclose_r+0x18>
   1ae08:	00040593          	mv	a1,s0
   1ae0c:	00048513          	mv	a0,s1
   1ae10:	a30f80ef          	jal	ra,13040 <__sflush_r>
   1ae14:	02c42783          	lw	a5,44(s0)
   1ae18:	00050913          	mv	s2,a0
   1ae1c:	00078c63          	beqz	a5,1ae34 <_fclose_r+0x84>
   1ae20:	01c42583          	lw	a1,28(s0)
   1ae24:	00048513          	mv	a0,s1
   1ae28:	000780e7          	jalr	a5
   1ae2c:	00055463          	bgez	a0,1ae34 <_fclose_r+0x84>
   1ae30:	fff00913          	li	s2,-1
   1ae34:	00c45783          	lhu	a5,12(s0)
   1ae38:	0807f793          	andi	a5,a5,128
   1ae3c:	00078863          	beqz	a5,1ae4c <_fclose_r+0x9c>
   1ae40:	01042583          	lw	a1,16(s0)
   1ae44:	00048513          	mv	a0,s1
   1ae48:	849f80ef          	jal	ra,13690 <_free_r>
   1ae4c:	03042583          	lw	a1,48(s0)
   1ae50:	00058c63          	beqz	a1,1ae68 <_fclose_r+0xb8>
   1ae54:	04040793          	addi	a5,s0,64
   1ae58:	00f58663          	beq	a1,a5,1ae64 <_fclose_r+0xb4>
   1ae5c:	00048513          	mv	a0,s1
   1ae60:	831f80ef          	jal	ra,13690 <_free_r>
   1ae64:	02042823          	sw	zero,48(s0)
   1ae68:	04442583          	lw	a1,68(s0)
   1ae6c:	00058863          	beqz	a1,1ae7c <_fclose_r+0xcc>
   1ae70:	00048513          	mv	a0,s1
   1ae74:	81df80ef          	jal	ra,13690 <_free_r>
   1ae78:	04042223          	sw	zero,68(s0)
   1ae7c:	ed4f80ef          	jal	ra,13550 <__sfp_lock_acquire>
   1ae80:	00041623          	sh	zero,12(s0)
   1ae84:	ed0f80ef          	jal	ra,13554 <__sfp_lock_release>
   1ae88:	f45ff06f          	j	1adcc <_fclose_r+0x1c>

0001ae8c <fclose>:
   1ae8c:	00050593          	mv	a1,a0
   1ae90:	8201a503          	lw	a0,-2016(gp) # 23f80 <_impure_ptr>
   1ae94:	f1dff06f          	j	1adb0 <_fclose_r>

0001ae98 <__fputwc>:
   1ae98:	fd010113          	addi	sp,sp,-48
   1ae9c:	02812423          	sw	s0,40(sp)
   1aea0:	02912223          	sw	s1,36(sp)
   1aea4:	01412c23          	sw	s4,24(sp)
   1aea8:	02112623          	sw	ra,44(sp)
   1aeac:	03212023          	sw	s2,32(sp)
   1aeb0:	01312e23          	sw	s3,28(sp)
   1aeb4:	01512a23          	sw	s5,20(sp)
   1aeb8:	01612823          	sw	s6,16(sp)
   1aebc:	00050a13          	mv	s4,a0
   1aec0:	00058493          	mv	s1,a1
   1aec4:	00060413          	mv	s0,a2
   1aec8:	908fb0ef          	jal	ra,15fd0 <__locale_mb_cur_max>
   1aecc:	00100793          	li	a5,1
   1aed0:	04f51a63          	bne	a0,a5,1af24 <__fputwc+0x8c>
   1aed4:	fff48793          	addi	a5,s1,-1
   1aed8:	0fe00713          	li	a4,254
   1aedc:	04f76463          	bltu	a4,a5,1af24 <__fputwc+0x8c>
   1aee0:	00910623          	sb	s1,12(sp)
   1aee4:	00100993          	li	s3,1
   1aee8:	00000913          	li	s2,0
   1aeec:	fff00a93          	li	s5,-1
   1aef0:	00a00b13          	li	s6,10
   1aef4:	07391263          	bne	s2,s3,1af58 <__fputwc+0xc0>
   1aef8:	00048513          	mv	a0,s1
   1aefc:	02c12083          	lw	ra,44(sp)
   1af00:	02812403          	lw	s0,40(sp)
   1af04:	02412483          	lw	s1,36(sp)
   1af08:	02012903          	lw	s2,32(sp)
   1af0c:	01c12983          	lw	s3,28(sp)
   1af10:	01812a03          	lw	s4,24(sp)
   1af14:	01412a83          	lw	s5,20(sp)
   1af18:	01012b03          	lw	s6,16(sp)
   1af1c:	03010113          	addi	sp,sp,48
   1af20:	00008067          	ret
   1af24:	05c40693          	addi	a3,s0,92
   1af28:	00048613          	mv	a2,s1
   1af2c:	00c10593          	addi	a1,sp,12
   1af30:	000a0513          	mv	a0,s4
   1af34:	148010ef          	jal	ra,1c07c <_wcrtomb_r>
   1af38:	fff00793          	li	a5,-1
   1af3c:	00050993          	mv	s3,a0
   1af40:	faf514e3          	bne	a0,a5,1aee8 <__fputwc+0x50>
   1af44:	00c45783          	lhu	a5,12(s0)
   1af48:	0407e793          	ori	a5,a5,64
   1af4c:	00f41623          	sh	a5,12(s0)
   1af50:	fff00513          	li	a0,-1
   1af54:	fa9ff06f          	j	1aefc <__fputwc+0x64>
   1af58:	00c10793          	addi	a5,sp,12
   1af5c:	012787b3          	add	a5,a5,s2
   1af60:	0007c583          	lbu	a1,0(a5)
   1af64:	00842783          	lw	a5,8(s0)
   1af68:	fff78793          	addi	a5,a5,-1
   1af6c:	00f42423          	sw	a5,8(s0)
   1af70:	0007d863          	bgez	a5,1af80 <__fputwc+0xe8>
   1af74:	01842703          	lw	a4,24(s0)
   1af78:	02e7c063          	blt	a5,a4,1af98 <__fputwc+0x100>
   1af7c:	01658e63          	beq	a1,s6,1af98 <__fputwc+0x100>
   1af80:	00042783          	lw	a5,0(s0)
   1af84:	00178713          	addi	a4,a5,1
   1af88:	00e42023          	sw	a4,0(s0)
   1af8c:	00b78023          	sb	a1,0(a5)
   1af90:	00190913          	addi	s2,s2,1
   1af94:	f61ff06f          	j	1aef4 <__fputwc+0x5c>
   1af98:	00040613          	mv	a2,s0
   1af9c:	000a0513          	mv	a0,s4
   1afa0:	79d000ef          	jal	ra,1bf3c <__swbuf_r>
   1afa4:	ff5516e3          	bne	a0,s5,1af90 <__fputwc+0xf8>
   1afa8:	fa9ff06f          	j	1af50 <__fputwc+0xb8>

0001afac <_fputwc_r>:
   1afac:	00c61783          	lh	a5,12(a2)
   1afb0:	01279713          	slli	a4,a5,0x12
   1afb4:	02074063          	bltz	a4,1afd4 <_fputwc_r+0x28>
   1afb8:	06462703          	lw	a4,100(a2)
   1afbc:	000026b7          	lui	a3,0x2
   1afc0:	00d7e7b3          	or	a5,a5,a3
   1afc4:	00f61623          	sh	a5,12(a2)
   1afc8:	000027b7          	lui	a5,0x2
   1afcc:	00f767b3          	or	a5,a4,a5
   1afd0:	06f62223          	sw	a5,100(a2)
   1afd4:	ec5ff06f          	j	1ae98 <__fputwc>

0001afd8 <fputwc>:
   1afd8:	fe010113          	addi	sp,sp,-32
   1afdc:	00812c23          	sw	s0,24(sp)
   1afe0:	8201a403          	lw	s0,-2016(gp) # 23f80 <_impure_ptr>
   1afe4:	00912a23          	sw	s1,20(sp)
   1afe8:	00112e23          	sw	ra,28(sp)
   1afec:	00050493          	mv	s1,a0
   1aff0:	00058613          	mv	a2,a1
   1aff4:	00040e63          	beqz	s0,1b010 <fputwc+0x38>
   1aff8:	03842783          	lw	a5,56(s0)
   1affc:	00079a63          	bnez	a5,1b010 <fputwc+0x38>
   1b000:	00040513          	mv	a0,s0
   1b004:	00b12623          	sw	a1,12(sp)
   1b008:	bdcf80ef          	jal	ra,133e4 <__sinit>
   1b00c:	00c12603          	lw	a2,12(sp)
   1b010:	00040513          	mv	a0,s0
   1b014:	01812403          	lw	s0,24(sp)
   1b018:	01c12083          	lw	ra,28(sp)
   1b01c:	00048593          	mv	a1,s1
   1b020:	01412483          	lw	s1,20(sp)
   1b024:	02010113          	addi	sp,sp,32
   1b028:	f85ff06f          	j	1afac <_fputwc_r>

0001b02c <_fstat_r>:
   1b02c:	ff010113          	addi	sp,sp,-16
   1b030:	00812423          	sw	s0,8(sp)
   1b034:	00912223          	sw	s1,4(sp)
   1b038:	00050493          	mv	s1,a0
   1b03c:	00058513          	mv	a0,a1
   1b040:	00060593          	mv	a1,a2
   1b044:	00112623          	sw	ra,12(sp)
   1b048:	8801a623          	sw	zero,-1908(gp) # 23fec <errno>
   1b04c:	204010ef          	jal	ra,1c250 <fstat>
   1b050:	fff00793          	li	a5,-1
   1b054:	00f51863          	bne	a0,a5,1b064 <_fstat_r+0x38>
   1b058:	88c1a783          	lw	a5,-1908(gp) # 23fec <errno>
   1b05c:	00078463          	beqz	a5,1b064 <_fstat_r+0x38>
   1b060:	00f4a023          	sw	a5,0(s1)
   1b064:	00c12083          	lw	ra,12(sp)
   1b068:	00812403          	lw	s0,8(sp)
   1b06c:	00412483          	lw	s1,4(sp)
   1b070:	01010113          	addi	sp,sp,16
   1b074:	00008067          	ret

0001b078 <_isatty_r>:
   1b078:	ff010113          	addi	sp,sp,-16
   1b07c:	00812423          	sw	s0,8(sp)
   1b080:	00912223          	sw	s1,4(sp)
   1b084:	00050493          	mv	s1,a0
   1b088:	00058513          	mv	a0,a1
   1b08c:	00112623          	sw	ra,12(sp)
   1b090:	8801a623          	sw	zero,-1908(gp) # 23fec <errno>
   1b094:	41c010ef          	jal	ra,1c4b0 <isatty>
   1b098:	fff00793          	li	a5,-1
   1b09c:	00f51863          	bne	a0,a5,1b0ac <_isatty_r+0x34>
   1b0a0:	88c1a783          	lw	a5,-1908(gp) # 23fec <errno>
   1b0a4:	00078463          	beqz	a5,1b0ac <_isatty_r+0x34>
   1b0a8:	00f4a023          	sw	a5,0(s1)
   1b0ac:	00c12083          	lw	ra,12(sp)
   1b0b0:	00812403          	lw	s0,8(sp)
   1b0b4:	00412483          	lw	s1,4(sp)
   1b0b8:	01010113          	addi	sp,sp,16
   1b0bc:	00008067          	ret

0001b0c0 <_lseek_r>:
   1b0c0:	ff010113          	addi	sp,sp,-16
   1b0c4:	00812423          	sw	s0,8(sp)
   1b0c8:	00912223          	sw	s1,4(sp)
   1b0cc:	00050493          	mv	s1,a0
   1b0d0:	00058513          	mv	a0,a1
   1b0d4:	00060593          	mv	a1,a2
   1b0d8:	00068613          	mv	a2,a3
   1b0dc:	00112623          	sw	ra,12(sp)
   1b0e0:	8801a623          	sw	zero,-1908(gp) # 23fec <errno>
   1b0e4:	124010ef          	jal	ra,1c208 <lseek>
   1b0e8:	fff00793          	li	a5,-1
   1b0ec:	00f51863          	bne	a0,a5,1b0fc <_lseek_r+0x3c>
   1b0f0:	88c1a783          	lw	a5,-1908(gp) # 23fec <errno>
   1b0f4:	00078463          	beqz	a5,1b0fc <_lseek_r+0x3c>
   1b0f8:	00f4a023          	sw	a5,0(s1)
   1b0fc:	00c12083          	lw	ra,12(sp)
   1b100:	00812403          	lw	s0,8(sp)
   1b104:	00412483          	lw	s1,4(sp)
   1b108:	01010113          	addi	sp,sp,16
   1b10c:	00008067          	ret

0001b110 <_read_r>:
   1b110:	ff010113          	addi	sp,sp,-16
   1b114:	00812423          	sw	s0,8(sp)
   1b118:	00912223          	sw	s1,4(sp)
   1b11c:	00050493          	mv	s1,a0
   1b120:	00058513          	mv	a0,a1
   1b124:	00060593          	mv	a1,a2
   1b128:	00068613          	mv	a2,a3
   1b12c:	00112623          	sw	ra,12(sp)
   1b130:	8801a623          	sw	zero,-1908(gp) # 23fec <errno>
   1b134:	0ec010ef          	jal	ra,1c220 <read>
   1b138:	fff00793          	li	a5,-1
   1b13c:	00f51863          	bne	a0,a5,1b14c <_read_r+0x3c>
   1b140:	88c1a783          	lw	a5,-1908(gp) # 23fec <errno>
   1b144:	00078463          	beqz	a5,1b14c <_read_r+0x3c>
   1b148:	00f4a023          	sw	a5,0(s1)
   1b14c:	00c12083          	lw	ra,12(sp)
   1b150:	00812403          	lw	s0,8(sp)
   1b154:	00412483          	lw	s1,4(sp)
   1b158:	01010113          	addi	sp,sp,16
   1b15c:	00008067          	ret

0001b160 <__ssprint_r>:
   1b160:	00862783          	lw	a5,8(a2)
   1b164:	fd010113          	addi	sp,sp,-48
   1b168:	01312e23          	sw	s3,28(sp)
   1b16c:	02112623          	sw	ra,44(sp)
   1b170:	02812423          	sw	s0,40(sp)
   1b174:	02912223          	sw	s1,36(sp)
   1b178:	03212023          	sw	s2,32(sp)
   1b17c:	01412c23          	sw	s4,24(sp)
   1b180:	01512a23          	sw	s5,20(sp)
   1b184:	01612823          	sw	s6,16(sp)
   1b188:	01712623          	sw	s7,12(sp)
   1b18c:	01812423          	sw	s8,8(sp)
   1b190:	01912223          	sw	s9,4(sp)
   1b194:	00060993          	mv	s3,a2
   1b198:	12078663          	beqz	a5,1b2c4 <__ssprint_r+0x164>
   1b19c:	00062b03          	lw	s6,0(a2)
   1b1a0:	00050a93          	mv	s5,a0
   1b1a4:	00058413          	mv	s0,a1
   1b1a8:	00000b93          	li	s7,0
   1b1ac:	00000913          	li	s2,0
   1b1b0:	08090663          	beqz	s2,1b23c <__ssprint_r+0xdc>
   1b1b4:	00842a03          	lw	s4,8(s0)
   1b1b8:	0d496663          	bltu	s2,s4,1b284 <__ssprint_r+0x124>
   1b1bc:	00c45c83          	lhu	s9,12(s0)
   1b1c0:	480cf793          	andi	a5,s9,1152
   1b1c4:	0c078063          	beqz	a5,1b284 <__ssprint_r+0x124>
   1b1c8:	01442503          	lw	a0,20(s0)
   1b1cc:	00042483          	lw	s1,0(s0)
   1b1d0:	01042a03          	lw	s4,16(s0)
   1b1d4:	00300593          	li	a1,3
   1b1d8:	3d4060ef          	jal	ra,215ac <__mulsi3>
   1b1dc:	41448c33          	sub	s8,s1,s4
   1b1e0:	01f55493          	srli	s1,a0,0x1f
   1b1e4:	00a484b3          	add	s1,s1,a0
   1b1e8:	001c0793          	addi	a5,s8,1
   1b1ec:	4014d493          	srai	s1,s1,0x1
   1b1f0:	012787b3          	add	a5,a5,s2
   1b1f4:	00f4f463          	bleu	a5,s1,1b1fc <__ssprint_r+0x9c>
   1b1f8:	00078493          	mv	s1,a5
   1b1fc:	400cfc93          	andi	s9,s9,1024
   1b200:	100c8063          	beqz	s9,1b300 <__ssprint_r+0x1a0>
   1b204:	00048593          	mv	a1,s1
   1b208:	000a8513          	mv	a0,s5
   1b20c:	9a0f50ef          	jal	ra,103ac <_malloc_r>
   1b210:	00050a13          	mv	s4,a0
   1b214:	02051c63          	bnez	a0,1b24c <__ssprint_r+0xec>
   1b218:	00c00793          	li	a5,12
   1b21c:	00faa023          	sw	a5,0(s5)
   1b220:	00c45783          	lhu	a5,12(s0)
   1b224:	fff00513          	li	a0,-1
   1b228:	0407e793          	ori	a5,a5,64
   1b22c:	00f41623          	sh	a5,12(s0)
   1b230:	0009a423          	sw	zero,8(s3)
   1b234:	0009a223          	sw	zero,4(s3)
   1b238:	0940006f          	j	1b2cc <__ssprint_r+0x16c>
   1b23c:	000b2b83          	lw	s7,0(s6)
   1b240:	004b2903          	lw	s2,4(s6)
   1b244:	008b0b13          	addi	s6,s6,8
   1b248:	f69ff06f          	j	1b1b0 <__ssprint_r+0x50>
   1b24c:	01042583          	lw	a1,16(s0)
   1b250:	000c0613          	mv	a2,s8
   1b254:	ff5fa0ef          	jal	ra,16248 <memcpy>
   1b258:	00c45783          	lhu	a5,12(s0)
   1b25c:	b7f7f793          	andi	a5,a5,-1153
   1b260:	0807e793          	ori	a5,a5,128
   1b264:	00f41623          	sh	a5,12(s0)
   1b268:	01442823          	sw	s4,16(s0)
   1b26c:	00942a23          	sw	s1,20(s0)
   1b270:	018a0a33          	add	s4,s4,s8
   1b274:	418484b3          	sub	s1,s1,s8
   1b278:	01442023          	sw	s4,0(s0)
   1b27c:	00942423          	sw	s1,8(s0)
   1b280:	00090a13          	mv	s4,s2
   1b284:	01497463          	bleu	s4,s2,1b28c <__ssprint_r+0x12c>
   1b288:	00090a13          	mv	s4,s2
   1b28c:	00042503          	lw	a0,0(s0)
   1b290:	000a0613          	mv	a2,s4
   1b294:	000b8593          	mv	a1,s7
   1b298:	898fb0ef          	jal	ra,16330 <memmove>
   1b29c:	00842783          	lw	a5,8(s0)
   1b2a0:	414787b3          	sub	a5,a5,s4
   1b2a4:	00f42423          	sw	a5,8(s0)
   1b2a8:	00042783          	lw	a5,0(s0)
   1b2ac:	01478a33          	add	s4,a5,s4
   1b2b0:	0089a783          	lw	a5,8(s3)
   1b2b4:	01442023          	sw	s4,0(s0)
   1b2b8:	41278933          	sub	s2,a5,s2
   1b2bc:	0129a423          	sw	s2,8(s3)
   1b2c0:	f6091ee3          	bnez	s2,1b23c <__ssprint_r+0xdc>
   1b2c4:	0009a223          	sw	zero,4(s3)
   1b2c8:	00000513          	li	a0,0
   1b2cc:	02c12083          	lw	ra,44(sp)
   1b2d0:	02812403          	lw	s0,40(sp)
   1b2d4:	02412483          	lw	s1,36(sp)
   1b2d8:	02012903          	lw	s2,32(sp)
   1b2dc:	01c12983          	lw	s3,28(sp)
   1b2e0:	01812a03          	lw	s4,24(sp)
   1b2e4:	01412a83          	lw	s5,20(sp)
   1b2e8:	01012b03          	lw	s6,16(sp)
   1b2ec:	00c12b83          	lw	s7,12(sp)
   1b2f0:	00812c03          	lw	s8,8(sp)
   1b2f4:	00412c83          	lw	s9,4(sp)
   1b2f8:	03010113          	addi	sp,sp,48
   1b2fc:	00008067          	ret
   1b300:	000a0593          	mv	a1,s4
   1b304:	00048613          	mv	a2,s1
   1b308:	000a8513          	mv	a0,s5
   1b30c:	fc9fb0ef          	jal	ra,172d4 <_realloc_r>
   1b310:	00050a13          	mv	s4,a0
   1b314:	f4051ae3          	bnez	a0,1b268 <__ssprint_r+0x108>
   1b318:	01042583          	lw	a1,16(s0)
   1b31c:	000a8513          	mv	a0,s5
   1b320:	b70f80ef          	jal	ra,13690 <_free_r>
   1b324:	ef5ff06f          	j	1b218 <__ssprint_r+0xb8>

0001b328 <_svfiprintf_r>:
   1b328:	00c5d783          	lhu	a5,12(a1)
   1b32c:	ed010113          	addi	sp,sp,-304
   1b330:	13212023          	sw	s2,288(sp)
   1b334:	11312e23          	sw	s3,284(sp)
   1b338:	11412c23          	sw	s4,280(sp)
   1b33c:	11a12023          	sw	s10,256(sp)
   1b340:	12112623          	sw	ra,300(sp)
   1b344:	12812423          	sw	s0,296(sp)
   1b348:	12912223          	sw	s1,292(sp)
   1b34c:	11512a23          	sw	s5,276(sp)
   1b350:	11612823          	sw	s6,272(sp)
   1b354:	11712623          	sw	s7,268(sp)
   1b358:	11812423          	sw	s8,264(sp)
   1b35c:	11912223          	sw	s9,260(sp)
   1b360:	0fb12e23          	sw	s11,252(sp)
   1b364:	0807f793          	andi	a5,a5,128
   1b368:	00050a13          	mv	s4,a0
   1b36c:	00058913          	mv	s2,a1
   1b370:	00060993          	mv	s3,a2
   1b374:	00068d13          	mv	s10,a3
   1b378:	02078e63          	beqz	a5,1b3b4 <_svfiprintf_r+0x8c>
   1b37c:	0105a783          	lw	a5,16(a1)
   1b380:	02079a63          	bnez	a5,1b3b4 <_svfiprintf_r+0x8c>
   1b384:	04000593          	li	a1,64
   1b388:	824f50ef          	jal	ra,103ac <_malloc_r>
   1b38c:	00a92023          	sw	a0,0(s2)
   1b390:	00a92823          	sw	a0,16(s2)
   1b394:	00051c63          	bnez	a0,1b3ac <_svfiprintf_r+0x84>
   1b398:	00c00793          	li	a5,12
   1b39c:	00fa2023          	sw	a5,0(s4)
   1b3a0:	fff00793          	li	a5,-1
   1b3a4:	00f12023          	sw	a5,0(sp)
   1b3a8:	3010006f          	j	1bea8 <_svfiprintf_r+0xb80>
   1b3ac:	04000793          	li	a5,64
   1b3b0:	00f92a23          	sw	a5,20(s2)
   1b3b4:	04c10793          	addi	a5,sp,76
   1b3b8:	04f12023          	sw	a5,64(sp)
   1b3bc:	00078b93          	mv	s7,a5
   1b3c0:	000227b7          	lui	a5,0x22
   1b3c4:	10c78793          	addi	a5,a5,268 # 2210c <_ctype_+0x104>
   1b3c8:	00f12e23          	sw	a5,28(sp)
   1b3cc:	000227b7          	lui	a5,0x22
   1b3d0:	28878793          	addi	a5,a5,648 # 22288 <zeroes.4339>
   1b3d4:	04012423          	sw	zero,72(sp)
   1b3d8:	04012223          	sw	zero,68(sp)
   1b3dc:	00012623          	sw	zero,12(sp)
   1b3e0:	00012223          	sw	zero,4(sp)
   1b3e4:	00012423          	sw	zero,8(sp)
   1b3e8:	00012a23          	sw	zero,20(sp)
   1b3ec:	00012023          	sw	zero,0(sp)
   1b3f0:	00f12823          	sw	a5,16(sp)
   1b3f4:	00098413          	mv	s0,s3
   1b3f8:	02500693          	li	a3,37
   1b3fc:	00044783          	lbu	a5,0(s0)
   1b400:	00078463          	beqz	a5,1b408 <_svfiprintf_r+0xe0>
   1b404:	0ad79263          	bne	a5,a3,1b4a8 <_svfiprintf_r+0x180>
   1b408:	413404b3          	sub	s1,s0,s3
   1b40c:	04048a63          	beqz	s1,1b460 <_svfiprintf_r+0x138>
   1b410:	04812783          	lw	a5,72(sp)
   1b414:	013ba023          	sw	s3,0(s7)
   1b418:	009ba223          	sw	s1,4(s7)
   1b41c:	009787b3          	add	a5,a5,s1
   1b420:	04f12423          	sw	a5,72(sp)
   1b424:	04412783          	lw	a5,68(sp)
   1b428:	00700693          	li	a3,7
   1b42c:	008b8b93          	addi	s7,s7,8
   1b430:	00178793          	addi	a5,a5,1
   1b434:	04f12223          	sw	a5,68(sp)
   1b438:	00f6de63          	ble	a5,a3,1b454 <_svfiprintf_r+0x12c>
   1b43c:	04010613          	addi	a2,sp,64
   1b440:	00090593          	mv	a1,s2
   1b444:	000a0513          	mv	a0,s4
   1b448:	d19ff0ef          	jal	ra,1b160 <__ssprint_r>
   1b44c:	240518e3          	bnez	a0,1be9c <_svfiprintf_r+0xb74>
   1b450:	04c10b93          	addi	s7,sp,76
   1b454:	00012783          	lw	a5,0(sp)
   1b458:	009787b3          	add	a5,a5,s1
   1b45c:	00f12023          	sw	a5,0(sp)
   1b460:	00044783          	lbu	a5,0(s0)
   1b464:	2a078ee3          	beqz	a5,1bf20 <_svfiprintf_r+0xbf8>
   1b468:	00140993          	addi	s3,s0,1
   1b46c:	02010da3          	sb	zero,59(sp)
   1b470:	fff00493          	li	s1,-1
   1b474:	00000a93          	li	s5,0
   1b478:	00000b13          	li	s6,0
   1b47c:	00900413          	li	s0,9
   1b480:	05a00c93          	li	s9,90
   1b484:	0009cd83          	lbu	s11,0(s3)
   1b488:	00198993          	addi	s3,s3,1
   1b48c:	fe0d8693          	addi	a3,s11,-32
   1b490:	0cdce0e3          	bltu	s9,a3,1bd50 <_svfiprintf_r+0xa28>
   1b494:	01c12783          	lw	a5,28(sp)
   1b498:	00269693          	slli	a3,a3,0x2
   1b49c:	00f686b3          	add	a3,a3,a5
   1b4a0:	0006a683          	lw	a3,0(a3) # 2000 <main-0xe074>
   1b4a4:	00068067          	jr	a3
   1b4a8:	00140413          	addi	s0,s0,1
   1b4ac:	f51ff06f          	j	1b3fc <_svfiprintf_r+0xd4>
   1b4b0:	000226b7          	lui	a3,0x22
   1b4b4:	92468793          	addi	a5,a3,-1756 # 21924 <zeroes.4377+0x6c>
   1b4b8:	00f12623          	sw	a5,12(sp)
   1b4bc:	020b7693          	andi	a3,s6,32
   1b4c0:	6a068e63          	beqz	a3,1bb7c <_svfiprintf_r+0x854>
   1b4c4:	007d0d13          	addi	s10,s10,7
   1b4c8:	ff8d7d13          	andi	s10,s10,-8
   1b4cc:	000d2883          	lw	a7,0(s10)
   1b4d0:	004d2c83          	lw	s9,4(s10)
   1b4d4:	008d0c13          	addi	s8,s10,8
   1b4d8:	001b7693          	andi	a3,s6,1
   1b4dc:	00068e63          	beqz	a3,1b4f8 <_svfiprintf_r+0x1d0>
   1b4e0:	0198e6b3          	or	a3,a7,s9
   1b4e4:	00068a63          	beqz	a3,1b4f8 <_svfiprintf_r+0x1d0>
   1b4e8:	03000693          	li	a3,48
   1b4ec:	02d10e23          	sb	a3,60(sp)
   1b4f0:	03b10ea3          	sb	s11,61(sp)
   1b4f4:	002b6b13          	ori	s6,s6,2
   1b4f8:	bffb7b13          	andi	s6,s6,-1025
   1b4fc:	3380006f          	j	1b834 <_svfiprintf_r+0x50c>
   1b500:	000a0513          	mv	a0,s4
   1b504:	a21fa0ef          	jal	ra,15f24 <_localeconv_r>
   1b508:	00452783          	lw	a5,4(a0)
   1b50c:	00078513          	mv	a0,a5
   1b510:	00f12a23          	sw	a5,20(sp)
   1b514:	f68f50ef          	jal	ra,10c7c <strlen>
   1b518:	00a12423          	sw	a0,8(sp)
   1b51c:	000a0513          	mv	a0,s4
   1b520:	a05fa0ef          	jal	ra,15f24 <_localeconv_r>
   1b524:	00852783          	lw	a5,8(a0)
   1b528:	00f12223          	sw	a5,4(sp)
   1b52c:	00812783          	lw	a5,8(sp)
   1b530:	f40788e3          	beqz	a5,1b480 <_svfiprintf_r+0x158>
   1b534:	00412783          	lw	a5,4(sp)
   1b538:	f40784e3          	beqz	a5,1b480 <_svfiprintf_r+0x158>
   1b53c:	0007c683          	lbu	a3,0(a5)
   1b540:	f40680e3          	beqz	a3,1b480 <_svfiprintf_r+0x158>
   1b544:	400b6b13          	ori	s6,s6,1024
   1b548:	f39ff06f          	j	1b480 <_svfiprintf_r+0x158>
   1b54c:	03b14683          	lbu	a3,59(sp)
   1b550:	f20698e3          	bnez	a3,1b480 <_svfiprintf_r+0x158>
   1b554:	02000693          	li	a3,32
   1b558:	02d10da3          	sb	a3,59(sp)
   1b55c:	f25ff06f          	j	1b480 <_svfiprintf_r+0x158>
   1b560:	001b6b13          	ori	s6,s6,1
   1b564:	f1dff06f          	j	1b480 <_svfiprintf_r+0x158>
   1b568:	000d2a83          	lw	s5,0(s10)
   1b56c:	004d0d13          	addi	s10,s10,4
   1b570:	f00ad8e3          	bgez	s5,1b480 <_svfiprintf_r+0x158>
   1b574:	41500ab3          	neg	s5,s5
   1b578:	004b6b13          	ori	s6,s6,4
   1b57c:	f05ff06f          	j	1b480 <_svfiprintf_r+0x158>
   1b580:	02b00693          	li	a3,43
   1b584:	fd5ff06f          	j	1b558 <_svfiprintf_r+0x230>
   1b588:	0009cd83          	lbu	s11,0(s3)
   1b58c:	02a00793          	li	a5,42
   1b590:	00198c13          	addi	s8,s3,1
   1b594:	04fd9463          	bne	s11,a5,1b5dc <_svfiprintf_r+0x2b4>
   1b598:	000d2483          	lw	s1,0(s10)
   1b59c:	004d0613          	addi	a2,s10,4
   1b5a0:	0004d463          	bgez	s1,1b5a8 <_svfiprintf_r+0x280>
   1b5a4:	fff00493          	li	s1,-1
   1b5a8:	00060d13          	mv	s10,a2
   1b5ac:	000c0993          	mv	s3,s8
   1b5b0:	ed1ff06f          	j	1b480 <_svfiprintf_r+0x158>
   1b5b4:	00048513          	mv	a0,s1
   1b5b8:	00a00593          	li	a1,10
   1b5bc:	001c0c13          	addi	s8,s8,1
   1b5c0:	7ed050ef          	jal	ra,215ac <__mulsi3>
   1b5c4:	fffc4d83          	lbu	s11,-1(s8)
   1b5c8:	013504b3          	add	s1,a0,s3
   1b5cc:	fd0d8993          	addi	s3,s11,-48
   1b5d0:	ff3472e3          	bleu	s3,s0,1b5b4 <_svfiprintf_r+0x28c>
   1b5d4:	000c0993          	mv	s3,s8
   1b5d8:	eb5ff06f          	j	1b48c <_svfiprintf_r+0x164>
   1b5dc:	00000493          	li	s1,0
   1b5e0:	fedff06f          	j	1b5cc <_svfiprintf_r+0x2a4>
   1b5e4:	080b6b13          	ori	s6,s6,128
   1b5e8:	e99ff06f          	j	1b480 <_svfiprintf_r+0x158>
   1b5ec:	00098c13          	mv	s8,s3
   1b5f0:	00000a93          	li	s5,0
   1b5f4:	000a8513          	mv	a0,s5
   1b5f8:	00a00593          	li	a1,10
   1b5fc:	001c0c13          	addi	s8,s8,1
   1b600:	7ad050ef          	jal	ra,215ac <__mulsi3>
   1b604:	fd0d8a93          	addi	s5,s11,-48
   1b608:	fffc4d83          	lbu	s11,-1(s8)
   1b60c:	00aa8ab3          	add	s5,s5,a0
   1b610:	fd0d8613          	addi	a2,s11,-48
   1b614:	fec470e3          	bleu	a2,s0,1b5f4 <_svfiprintf_r+0x2cc>
   1b618:	fbdff06f          	j	1b5d4 <_svfiprintf_r+0x2ac>
   1b61c:	0009c603          	lbu	a2,0(s3)
   1b620:	06800693          	li	a3,104
   1b624:	00d61863          	bne	a2,a3,1b634 <_svfiprintf_r+0x30c>
   1b628:	00198993          	addi	s3,s3,1
   1b62c:	200b6b13          	ori	s6,s6,512
   1b630:	e51ff06f          	j	1b480 <_svfiprintf_r+0x158>
   1b634:	040b6b13          	ori	s6,s6,64
   1b638:	e49ff06f          	j	1b480 <_svfiprintf_r+0x158>
   1b63c:	0009c603          	lbu	a2,0(s3)
   1b640:	06c00693          	li	a3,108
   1b644:	00d61863          	bne	a2,a3,1b654 <_svfiprintf_r+0x32c>
   1b648:	00198993          	addi	s3,s3,1
   1b64c:	020b6b13          	ori	s6,s6,32
   1b650:	e31ff06f          	j	1b480 <_svfiprintf_r+0x158>
   1b654:	010b6b13          	ori	s6,s6,16
   1b658:	e29ff06f          	j	1b480 <_svfiprintf_r+0x158>
   1b65c:	000d2683          	lw	a3,0(s10)
   1b660:	004d0c13          	addi	s8,s10,4
   1b664:	02010da3          	sb	zero,59(sp)
   1b668:	08d10623          	sb	a3,140(sp)
   1b66c:	00100493          	li	s1,1
   1b670:	00000c93          	li	s9,0
   1b674:	08c10413          	addi	s0,sp,140
   1b678:	1f40006f          	j	1b86c <_svfiprintf_r+0x544>
   1b67c:	010b6b13          	ori	s6,s6,16
   1b680:	020b7693          	andi	a3,s6,32
   1b684:	04068c63          	beqz	a3,1b6dc <_svfiprintf_r+0x3b4>
   1b688:	007d0d13          	addi	s10,s10,7
   1b68c:	ff8d7d13          	andi	s10,s10,-8
   1b690:	000d2883          	lw	a7,0(s10)
   1b694:	004d2c83          	lw	s9,4(s10)
   1b698:	008d0c13          	addi	s8,s10,8
   1b69c:	000cde63          	bgez	s9,1b6b8 <_svfiprintf_r+0x390>
   1b6a0:	411008b3          	neg	a7,a7
   1b6a4:	011036b3          	snez	a3,a7
   1b6a8:	41900333          	neg	t1,s9
   1b6ac:	40d30cb3          	sub	s9,t1,a3
   1b6b0:	02d00693          	li	a3,45
   1b6b4:	02d10da3          	sb	a3,59(sp)
   1b6b8:	fff00693          	li	a3,-1
   1b6bc:	4ed49c63          	bne	s1,a3,1bbb4 <_svfiprintf_r+0x88c>
   1b6c0:	560c9663          	bnez	s9,1bc2c <_svfiprintf_r+0x904>
   1b6c4:	00900693          	li	a3,9
   1b6c8:	5716e263          	bltu	a3,a7,1bc2c <_svfiprintf_r+0x904>
   1b6cc:	03088893          	addi	a7,a7,48
   1b6d0:	0f1107a3          	sb	a7,239(sp)
   1b6d4:	0ef10413          	addi	s0,sp,239
   1b6d8:	53c0006f          	j	1bc14 <_svfiprintf_r+0x8ec>
   1b6dc:	010b7693          	andi	a3,s6,16
   1b6e0:	004d0c13          	addi	s8,s10,4
   1b6e4:	00068863          	beqz	a3,1b6f4 <_svfiprintf_r+0x3cc>
   1b6e8:	000d2883          	lw	a7,0(s10)
   1b6ec:	41f8dc93          	srai	s9,a7,0x1f
   1b6f0:	fadff06f          	j	1b69c <_svfiprintf_r+0x374>
   1b6f4:	040b7693          	andi	a3,s6,64
   1b6f8:	000d2883          	lw	a7,0(s10)
   1b6fc:	00068863          	beqz	a3,1b70c <_svfiprintf_r+0x3e4>
   1b700:	01089893          	slli	a7,a7,0x10
   1b704:	4108d893          	srai	a7,a7,0x10
   1b708:	fe5ff06f          	j	1b6ec <_svfiprintf_r+0x3c4>
   1b70c:	200b7693          	andi	a3,s6,512
   1b710:	fc068ee3          	beqz	a3,1b6ec <_svfiprintf_r+0x3c4>
   1b714:	01889893          	slli	a7,a7,0x18
   1b718:	4188d893          	srai	a7,a7,0x18
   1b71c:	fd1ff06f          	j	1b6ec <_svfiprintf_r+0x3c4>
   1b720:	020b7613          	andi	a2,s6,32
   1b724:	000d2683          	lw	a3,0(s10)
   1b728:	004d0d13          	addi	s10,s10,4
   1b72c:	00060c63          	beqz	a2,1b744 <_svfiprintf_r+0x41c>
   1b730:	00012783          	lw	a5,0(sp)
   1b734:	00f6a023          	sw	a5,0(a3)
   1b738:	41f7d793          	srai	a5,a5,0x1f
   1b73c:	00f6a223          	sw	a5,4(a3)
   1b740:	cb5ff06f          	j	1b3f4 <_svfiprintf_r+0xcc>
   1b744:	010b7613          	andi	a2,s6,16
   1b748:	00060863          	beqz	a2,1b758 <_svfiprintf_r+0x430>
   1b74c:	00012783          	lw	a5,0(sp)
   1b750:	00f6a023          	sw	a5,0(a3)
   1b754:	ca1ff06f          	j	1b3f4 <_svfiprintf_r+0xcc>
   1b758:	040b7613          	andi	a2,s6,64
   1b75c:	00060863          	beqz	a2,1b76c <_svfiprintf_r+0x444>
   1b760:	00015783          	lhu	a5,0(sp)
   1b764:	00f69023          	sh	a5,0(a3)
   1b768:	c8dff06f          	j	1b3f4 <_svfiprintf_r+0xcc>
   1b76c:	200b7793          	andi	a5,s6,512
   1b770:	fc078ee3          	beqz	a5,1b74c <_svfiprintf_r+0x424>
   1b774:	00014783          	lbu	a5,0(sp)
   1b778:	00f68023          	sb	a5,0(a3)
   1b77c:	c79ff06f          	j	1b3f4 <_svfiprintf_r+0xcc>
   1b780:	010b6b13          	ori	s6,s6,16
   1b784:	020b7693          	andi	a3,s6,32
   1b788:	04068663          	beqz	a3,1b7d4 <_svfiprintf_r+0x4ac>
   1b78c:	007d0d13          	addi	s10,s10,7
   1b790:	ff8d7d13          	andi	s10,s10,-8
   1b794:	000d2883          	lw	a7,0(s10)
   1b798:	004d2c83          	lw	s9,4(s10)
   1b79c:	008d0c13          	addi	s8,s10,8
   1b7a0:	bffb7b13          	andi	s6,s6,-1025
   1b7a4:	00000693          	li	a3,0
   1b7a8:	02010da3          	sb	zero,59(sp)
   1b7ac:	fff00613          	li	a2,-1
   1b7b0:	40c48863          	beq	s1,a2,1bbc0 <_svfiprintf_r+0x898>
   1b7b4:	000b0613          	mv	a2,s6
   1b7b8:	0198e5b3          	or	a1,a7,s9
   1b7bc:	f7fb7b13          	andi	s6,s6,-129
   1b7c0:	40059063          	bnez	a1,1bbc0 <_svfiprintf_r+0x898>
   1b7c4:	56048863          	beqz	s1,1bd34 <_svfiprintf_r+0xa0c>
   1b7c8:	00100613          	li	a2,1
   1b7cc:	3ec69e63          	bne	a3,a2,1bbc8 <_svfiprintf_r+0x8a0>
   1b7d0:	efdff06f          	j	1b6cc <_svfiprintf_r+0x3a4>
   1b7d4:	010b7693          	andi	a3,s6,16
   1b7d8:	004d0c13          	addi	s8,s10,4
   1b7dc:	00068663          	beqz	a3,1b7e8 <_svfiprintf_r+0x4c0>
   1b7e0:	000d2883          	lw	a7,0(s10)
   1b7e4:	0100006f          	j	1b7f4 <_svfiprintf_r+0x4cc>
   1b7e8:	040b7693          	andi	a3,s6,64
   1b7ec:	00068863          	beqz	a3,1b7fc <_svfiprintf_r+0x4d4>
   1b7f0:	000d5883          	lhu	a7,0(s10)
   1b7f4:	00000c93          	li	s9,0
   1b7f8:	fa9ff06f          	j	1b7a0 <_svfiprintf_r+0x478>
   1b7fc:	200b7693          	andi	a3,s6,512
   1b800:	fe0680e3          	beqz	a3,1b7e0 <_svfiprintf_r+0x4b8>
   1b804:	000d4883          	lbu	a7,0(s10)
   1b808:	fedff06f          	j	1b7f4 <_svfiprintf_r+0x4cc>
   1b80c:	ffff86b7          	lui	a3,0xffff8
   1b810:	8306c693          	xori	a3,a3,-2000
   1b814:	02d11e23          	sh	a3,60(sp)
   1b818:	000d2883          	lw	a7,0(s10)
   1b81c:	000226b7          	lui	a3,0x22
   1b820:	91068793          	addi	a5,a3,-1776 # 21910 <zeroes.4377+0x58>
   1b824:	004d0c13          	addi	s8,s10,4
   1b828:	00000c93          	li	s9,0
   1b82c:	002b6b13          	ori	s6,s6,2
   1b830:	00f12623          	sw	a5,12(sp)
   1b834:	00200693          	li	a3,2
   1b838:	f71ff06f          	j	1b7a8 <_svfiprintf_r+0x480>
   1b83c:	02010da3          	sb	zero,59(sp)
   1b840:	fff00693          	li	a3,-1
   1b844:	004d0c13          	addi	s8,s10,4
   1b848:	000d2403          	lw	s0,0(s10)
   1b84c:	2ad48863          	beq	s1,a3,1bafc <_svfiprintf_r+0x7d4>
   1b850:	00048613          	mv	a2,s1
   1b854:	00000593          	li	a1,0
   1b858:	00040513          	mv	a0,s0
   1b85c:	9c9fa0ef          	jal	ra,16224 <memchr>
   1b860:	00000c93          	li	s9,0
   1b864:	00050463          	beqz	a0,1b86c <_svfiprintf_r+0x544>
   1b868:	408504b3          	sub	s1,a0,s0
   1b86c:	000c8d13          	mv	s10,s9
   1b870:	009cd463          	ble	s1,s9,1b878 <_svfiprintf_r+0x550>
   1b874:	00048d13          	mv	s10,s1
   1b878:	03b14683          	lbu	a3,59(sp)
   1b87c:	00068463          	beqz	a3,1b884 <_svfiprintf_r+0x55c>
   1b880:	001d0d13          	addi	s10,s10,1
   1b884:	002b7d93          	andi	s11,s6,2
   1b888:	000d8463          	beqz	s11,1b890 <_svfiprintf_r+0x568>
   1b88c:	002d0d13          	addi	s10,s10,2
   1b890:	084b7793          	andi	a5,s6,132
   1b894:	00f12c23          	sw	a5,24(sp)
   1b898:	06079463          	bnez	a5,1b900 <_svfiprintf_r+0x5d8>
   1b89c:	41aa86b3          	sub	a3,s5,s10
   1b8a0:	06d05063          	blez	a3,1b900 <_svfiprintf_r+0x5d8>
   1b8a4:	000227b7          	lui	a5,0x22
   1b8a8:	01000893          	li	a7,16
   1b8ac:	27878813          	addi	a6,a5,632 # 22278 <blanks.4338>
   1b8b0:	00700313          	li	t1,7
   1b8b4:	04412603          	lw	a2,68(sp)
   1b8b8:	010ba023          	sw	a6,0(s7)
   1b8bc:	04812583          	lw	a1,72(sp)
   1b8c0:	00160613          	addi	a2,a2,1
   1b8c4:	008b8513          	addi	a0,s7,8
   1b8c8:	48d8ce63          	blt	a7,a3,1bd64 <_svfiprintf_r+0xa3c>
   1b8cc:	00dba223          	sw	a3,4(s7)
   1b8d0:	00b686b3          	add	a3,a3,a1
   1b8d4:	04d12423          	sw	a3,72(sp)
   1b8d8:	04c12223          	sw	a2,68(sp)
   1b8dc:	00700693          	li	a3,7
   1b8e0:	00050b93          	mv	s7,a0
   1b8e4:	00c6de63          	ble	a2,a3,1b900 <_svfiprintf_r+0x5d8>
   1b8e8:	04010613          	addi	a2,sp,64
   1b8ec:	00090593          	mv	a1,s2
   1b8f0:	000a0513          	mv	a0,s4
   1b8f4:	86dff0ef          	jal	ra,1b160 <__ssprint_r>
   1b8f8:	5a051263          	bnez	a0,1be9c <_svfiprintf_r+0xb74>
   1b8fc:	04c10b93          	addi	s7,sp,76
   1b900:	03b14683          	lbu	a3,59(sp)
   1b904:	04068863          	beqz	a3,1b954 <_svfiprintf_r+0x62c>
   1b908:	03b10613          	addi	a2,sp,59
   1b90c:	00cba023          	sw	a2,0(s7)
   1b910:	00100613          	li	a2,1
   1b914:	04412683          	lw	a3,68(sp)
   1b918:	00cba223          	sw	a2,4(s7)
   1b91c:	04812603          	lw	a2,72(sp)
   1b920:	00168693          	addi	a3,a3,1
   1b924:	04d12223          	sw	a3,68(sp)
   1b928:	00160613          	addi	a2,a2,1
   1b92c:	04c12423          	sw	a2,72(sp)
   1b930:	00700613          	li	a2,7
   1b934:	008b8b93          	addi	s7,s7,8
   1b938:	00d65e63          	ble	a3,a2,1b954 <_svfiprintf_r+0x62c>
   1b93c:	04010613          	addi	a2,sp,64
   1b940:	00090593          	mv	a1,s2
   1b944:	000a0513          	mv	a0,s4
   1b948:	819ff0ef          	jal	ra,1b160 <__ssprint_r>
   1b94c:	54051863          	bnez	a0,1be9c <_svfiprintf_r+0xb74>
   1b950:	04c10b93          	addi	s7,sp,76
   1b954:	040d8863          	beqz	s11,1b9a4 <_svfiprintf_r+0x67c>
   1b958:	03c10613          	addi	a2,sp,60
   1b95c:	00cba023          	sw	a2,0(s7)
   1b960:	00200613          	li	a2,2
   1b964:	04412683          	lw	a3,68(sp)
   1b968:	00cba223          	sw	a2,4(s7)
   1b96c:	04812603          	lw	a2,72(sp)
   1b970:	00168693          	addi	a3,a3,1
   1b974:	04d12223          	sw	a3,68(sp)
   1b978:	00260613          	addi	a2,a2,2
   1b97c:	04c12423          	sw	a2,72(sp)
   1b980:	00700613          	li	a2,7
   1b984:	008b8b93          	addi	s7,s7,8
   1b988:	00d65e63          	ble	a3,a2,1b9a4 <_svfiprintf_r+0x67c>
   1b98c:	04010613          	addi	a2,sp,64
   1b990:	00090593          	mv	a1,s2
   1b994:	000a0513          	mv	a0,s4
   1b998:	fc8ff0ef          	jal	ra,1b160 <__ssprint_r>
   1b99c:	50051063          	bnez	a0,1be9c <_svfiprintf_r+0xb74>
   1b9a0:	04c10b93          	addi	s7,sp,76
   1b9a4:	01812783          	lw	a5,24(sp)
   1b9a8:	08000693          	li	a3,128
   1b9ac:	06d79263          	bne	a5,a3,1ba10 <_svfiprintf_r+0x6e8>
   1b9b0:	41aa8db3          	sub	s11,s5,s10
   1b9b4:	05b05e63          	blez	s11,1ba10 <_svfiprintf_r+0x6e8>
   1b9b8:	01000813          	li	a6,16
   1b9bc:	00700893          	li	a7,7
   1b9c0:	01012783          	lw	a5,16(sp)
   1b9c4:	04412683          	lw	a3,68(sp)
   1b9c8:	04812603          	lw	a2,72(sp)
   1b9cc:	00fba023          	sw	a5,0(s7)
   1b9d0:	00168693          	addi	a3,a3,1
   1b9d4:	008b8593          	addi	a1,s7,8
   1b9d8:	3fb84263          	blt	a6,s11,1bdbc <_svfiprintf_r+0xa94>
   1b9dc:	01b60633          	add	a2,a2,s11
   1b9e0:	01bba223          	sw	s11,4(s7)
   1b9e4:	04c12423          	sw	a2,72(sp)
   1b9e8:	04d12223          	sw	a3,68(sp)
   1b9ec:	00700613          	li	a2,7
   1b9f0:	00058b93          	mv	s7,a1
   1b9f4:	00d65e63          	ble	a3,a2,1ba10 <_svfiprintf_r+0x6e8>
   1b9f8:	04010613          	addi	a2,sp,64
   1b9fc:	00090593          	mv	a1,s2
   1ba00:	000a0513          	mv	a0,s4
   1ba04:	f5cff0ef          	jal	ra,1b160 <__ssprint_r>
   1ba08:	48051a63          	bnez	a0,1be9c <_svfiprintf_r+0xb74>
   1ba0c:	04c10b93          	addi	s7,sp,76
   1ba10:	409c8cb3          	sub	s9,s9,s1
   1ba14:	05905e63          	blez	s9,1ba70 <_svfiprintf_r+0x748>
   1ba18:	01000d93          	li	s11,16
   1ba1c:	00700813          	li	a6,7
   1ba20:	01012783          	lw	a5,16(sp)
   1ba24:	04412683          	lw	a3,68(sp)
   1ba28:	04812603          	lw	a2,72(sp)
   1ba2c:	00fba023          	sw	a5,0(s7)
   1ba30:	00168693          	addi	a3,a3,1
   1ba34:	008b8593          	addi	a1,s7,8
   1ba38:	3d9dc663          	blt	s11,s9,1be04 <_svfiprintf_r+0xadc>
   1ba3c:	019ba223          	sw	s9,4(s7)
   1ba40:	00cc8cb3          	add	s9,s9,a2
   1ba44:	05912423          	sw	s9,72(sp)
   1ba48:	04d12223          	sw	a3,68(sp)
   1ba4c:	00700613          	li	a2,7
   1ba50:	00058b93          	mv	s7,a1
   1ba54:	00d65e63          	ble	a3,a2,1ba70 <_svfiprintf_r+0x748>
   1ba58:	04010613          	addi	a2,sp,64
   1ba5c:	00090593          	mv	a1,s2
   1ba60:	000a0513          	mv	a0,s4
   1ba64:	efcff0ef          	jal	ra,1b160 <__ssprint_r>
   1ba68:	42051a63          	bnez	a0,1be9c <_svfiprintf_r+0xb74>
   1ba6c:	04c10b93          	addi	s7,sp,76
   1ba70:	04812683          	lw	a3,72(sp)
   1ba74:	009ba223          	sw	s1,4(s7)
   1ba78:	008ba023          	sw	s0,0(s7)
   1ba7c:	009684b3          	add	s1,a3,s1
   1ba80:	04412683          	lw	a3,68(sp)
   1ba84:	04912423          	sw	s1,72(sp)
   1ba88:	00700613          	li	a2,7
   1ba8c:	00168693          	addi	a3,a3,1
   1ba90:	04d12223          	sw	a3,68(sp)
   1ba94:	008b8713          	addi	a4,s7,8
   1ba98:	00d65e63          	ble	a3,a2,1bab4 <_svfiprintf_r+0x78c>
   1ba9c:	04010613          	addi	a2,sp,64
   1baa0:	00090593          	mv	a1,s2
   1baa4:	000a0513          	mv	a0,s4
   1baa8:	eb8ff0ef          	jal	ra,1b160 <__ssprint_r>
   1baac:	3e051863          	bnez	a0,1be9c <_svfiprintf_r+0xb74>
   1bab0:	04c10713          	addi	a4,sp,76
   1bab4:	004b7793          	andi	a5,s6,4
   1bab8:	38079663          	bnez	a5,1be44 <_svfiprintf_r+0xb1c>
   1babc:	01aad463          	ble	s10,s5,1bac4 <_svfiprintf_r+0x79c>
   1bac0:	000d0a93          	mv	s5,s10
   1bac4:	00012783          	lw	a5,0(sp)
   1bac8:	015787b3          	add	a5,a5,s5
   1bacc:	00f12023          	sw	a5,0(sp)
   1bad0:	04812783          	lw	a5,72(sp)
   1bad4:	00078c63          	beqz	a5,1baec <_svfiprintf_r+0x7c4>
   1bad8:	04010613          	addi	a2,sp,64
   1badc:	00090593          	mv	a1,s2
   1bae0:	000a0513          	mv	a0,s4
   1bae4:	e7cff0ef          	jal	ra,1b160 <__ssprint_r>
   1bae8:	3a051a63          	bnez	a0,1be9c <_svfiprintf_r+0xb74>
   1baec:	04012223          	sw	zero,68(sp)
   1baf0:	000c0d13          	mv	s10,s8
   1baf4:	04c10b93          	addi	s7,sp,76
   1baf8:	8fdff06f          	j	1b3f4 <_svfiprintf_r+0xcc>
   1bafc:	00040513          	mv	a0,s0
   1bb00:	97cf50ef          	jal	ra,10c7c <strlen>
   1bb04:	00050493          	mv	s1,a0
   1bb08:	00000c93          	li	s9,0
   1bb0c:	d61ff06f          	j	1b86c <_svfiprintf_r+0x544>
   1bb10:	010b6b13          	ori	s6,s6,16
   1bb14:	020b7693          	andi	a3,s6,32
   1bb18:	02068063          	beqz	a3,1bb38 <_svfiprintf_r+0x810>
   1bb1c:	007d0d13          	addi	s10,s10,7
   1bb20:	ff8d7d13          	andi	s10,s10,-8
   1bb24:	000d2883          	lw	a7,0(s10)
   1bb28:	004d2c83          	lw	s9,4(s10)
   1bb2c:	008d0c13          	addi	s8,s10,8
   1bb30:	00100693          	li	a3,1
   1bb34:	c75ff06f          	j	1b7a8 <_svfiprintf_r+0x480>
   1bb38:	010b7693          	andi	a3,s6,16
   1bb3c:	004d0c13          	addi	s8,s10,4
   1bb40:	00068663          	beqz	a3,1bb4c <_svfiprintf_r+0x824>
   1bb44:	000d2883          	lw	a7,0(s10)
   1bb48:	0100006f          	j	1bb58 <_svfiprintf_r+0x830>
   1bb4c:	040b7693          	andi	a3,s6,64
   1bb50:	00068863          	beqz	a3,1bb60 <_svfiprintf_r+0x838>
   1bb54:	000d5883          	lhu	a7,0(s10)
   1bb58:	00000c93          	li	s9,0
   1bb5c:	fd5ff06f          	j	1bb30 <_svfiprintf_r+0x808>
   1bb60:	200b7693          	andi	a3,s6,512
   1bb64:	fe0680e3          	beqz	a3,1bb44 <_svfiprintf_r+0x81c>
   1bb68:	000d4883          	lbu	a7,0(s10)
   1bb6c:	fedff06f          	j	1bb58 <_svfiprintf_r+0x830>
   1bb70:	000226b7          	lui	a3,0x22
   1bb74:	91068793          	addi	a5,a3,-1776 # 21910 <zeroes.4377+0x58>
   1bb78:	941ff06f          	j	1b4b8 <_svfiprintf_r+0x190>
   1bb7c:	010b7693          	andi	a3,s6,16
   1bb80:	004d0c13          	addi	s8,s10,4
   1bb84:	00068663          	beqz	a3,1bb90 <_svfiprintf_r+0x868>
   1bb88:	000d2883          	lw	a7,0(s10)
   1bb8c:	0100006f          	j	1bb9c <_svfiprintf_r+0x874>
   1bb90:	040b7693          	andi	a3,s6,64
   1bb94:	00068863          	beqz	a3,1bba4 <_svfiprintf_r+0x87c>
   1bb98:	000d5883          	lhu	a7,0(s10)
   1bb9c:	00000c93          	li	s9,0
   1bba0:	939ff06f          	j	1b4d8 <_svfiprintf_r+0x1b0>
   1bba4:	200b7693          	andi	a3,s6,512
   1bba8:	fe0680e3          	beqz	a3,1bb88 <_svfiprintf_r+0x860>
   1bbac:	000d4883          	lbu	a7,0(s10)
   1bbb0:	fedff06f          	j	1bb9c <_svfiprintf_r+0x874>
   1bbb4:	000b0613          	mv	a2,s6
   1bbb8:	00100693          	li	a3,1
   1bbbc:	bfdff06f          	j	1b7b8 <_svfiprintf_r+0x490>
   1bbc0:	00100613          	li	a2,1
   1bbc4:	aec68ee3          	beq	a3,a2,1b6c0 <_svfiprintf_r+0x398>
   1bbc8:	00200613          	li	a2,2
   1bbcc:	12c68863          	beq	a3,a2,1bcfc <_svfiprintf_r+0x9d4>
   1bbd0:	0f010693          	addi	a3,sp,240
   1bbd4:	01dc9593          	slli	a1,s9,0x1d
   1bbd8:	0078f613          	andi	a2,a7,7
   1bbdc:	0038d893          	srli	a7,a7,0x3
   1bbe0:	03060613          	addi	a2,a2,48
   1bbe4:	0115e8b3          	or	a7,a1,a7
   1bbe8:	003cdc93          	srli	s9,s9,0x3
   1bbec:	fec68fa3          	sb	a2,-1(a3)
   1bbf0:	0198e5b3          	or	a1,a7,s9
   1bbf4:	fff68413          	addi	s0,a3,-1
   1bbf8:	02059663          	bnez	a1,1bc24 <_svfiprintf_r+0x8fc>
   1bbfc:	001b7593          	andi	a1,s6,1
   1bc00:	00058a63          	beqz	a1,1bc14 <_svfiprintf_r+0x8ec>
   1bc04:	03000593          	li	a1,48
   1bc08:	00b60663          	beq	a2,a1,1bc14 <_svfiprintf_r+0x8ec>
   1bc0c:	feb40fa3          	sb	a1,-1(s0)
   1bc10:	ffe68413          	addi	s0,a3,-2
   1bc14:	0f010793          	addi	a5,sp,240
   1bc18:	00048c93          	mv	s9,s1
   1bc1c:	408784b3          	sub	s1,a5,s0
   1bc20:	c4dff06f          	j	1b86c <_svfiprintf_r+0x544>
   1bc24:	00040693          	mv	a3,s0
   1bc28:	fadff06f          	j	1bbd4 <_svfiprintf_r+0x8ac>
   1bc2c:	400b7793          	andi	a5,s6,1024
   1bc30:	00000d13          	li	s10,0
   1bc34:	0f010e13          	addi	t3,sp,240
   1bc38:	00f12c23          	sw	a5,24(sp)
   1bc3c:	00900d93          	li	s11,9
   1bc40:	00088513          	mv	a0,a7
   1bc44:	00a00613          	li	a2,10
   1bc48:	00000693          	li	a3,0
   1bc4c:	000c8593          	mv	a1,s9
   1bc50:	fffe0413          	addi	s0,t3,-1
   1bc54:	03c12223          	sw	t3,36(sp)
   1bc58:	03112023          	sw	a7,32(sp)
   1bc5c:	00c010ef          	jal	ra,1cc68 <__umoddi3>
   1bc60:	02412e03          	lw	t3,36(sp)
   1bc64:	01812783          	lw	a5,24(sp)
   1bc68:	03050513          	addi	a0,a0,48
   1bc6c:	feae0fa3          	sb	a0,-1(t3)
   1bc70:	001d0d13          	addi	s10,s10,1
   1bc74:	02012883          	lw	a7,32(sp)
   1bc78:	04078c63          	beqz	a5,1bcd0 <_svfiprintf_r+0x9a8>
   1bc7c:	00412783          	lw	a5,4(sp)
   1bc80:	0007c683          	lbu	a3,0(a5)
   1bc84:	05a69663          	bne	a3,s10,1bcd0 <_svfiprintf_r+0x9a8>
   1bc88:	0ff00793          	li	a5,255
   1bc8c:	04fd0263          	beq	s10,a5,1bcd0 <_svfiprintf_r+0x9a8>
   1bc90:	000c9463          	bnez	s9,1bc98 <_svfiprintf_r+0x970>
   1bc94:	031dfe63          	bleu	a7,s11,1bcd0 <_svfiprintf_r+0x9a8>
   1bc98:	00812783          	lw	a5,8(sp)
   1bc9c:	01412583          	lw	a1,20(sp)
   1bca0:	03112023          	sw	a7,32(sp)
   1bca4:	40f40433          	sub	s0,s0,a5
   1bca8:	00078613          	mv	a2,a5
   1bcac:	00040513          	mv	a0,s0
   1bcb0:	924fc0ef          	jal	ra,17dd4 <strncpy>
   1bcb4:	00412783          	lw	a5,4(sp)
   1bcb8:	00000d13          	li	s10,0
   1bcbc:	02012883          	lw	a7,32(sp)
   1bcc0:	0017c683          	lbu	a3,1(a5)
   1bcc4:	00068663          	beqz	a3,1bcd0 <_svfiprintf_r+0x9a8>
   1bcc8:	00178793          	addi	a5,a5,1
   1bccc:	00f12223          	sw	a5,4(sp)
   1bcd0:	00088513          	mv	a0,a7
   1bcd4:	000c8593          	mv	a1,s9
   1bcd8:	00a00613          	li	a2,10
   1bcdc:	00000693          	li	a3,0
   1bce0:	1ad000ef          	jal	ra,1c68c <__udivdi3>
   1bce4:	00058c93          	mv	s9,a1
   1bce8:	00a5e5b3          	or	a1,a1,a0
   1bcec:	00050893          	mv	a7,a0
   1bcf0:	f20582e3          	beqz	a1,1bc14 <_svfiprintf_r+0x8ec>
   1bcf4:	00040e13          	mv	t3,s0
   1bcf8:	f49ff06f          	j	1bc40 <_svfiprintf_r+0x918>
   1bcfc:	0f010413          	addi	s0,sp,240
   1bd00:	00c12783          	lw	a5,12(sp)
   1bd04:	00f8f693          	andi	a3,a7,15
   1bd08:	fff40413          	addi	s0,s0,-1
   1bd0c:	00d786b3          	add	a3,a5,a3
   1bd10:	0006c683          	lbu	a3,0(a3)
   1bd14:	0048d893          	srli	a7,a7,0x4
   1bd18:	00d40023          	sb	a3,0(s0)
   1bd1c:	01cc9693          	slli	a3,s9,0x1c
   1bd20:	0116e8b3          	or	a7,a3,a7
   1bd24:	004cdc93          	srli	s9,s9,0x4
   1bd28:	0198e6b3          	or	a3,a7,s9
   1bd2c:	fc069ae3          	bnez	a3,1bd00 <_svfiprintf_r+0x9d8>
   1bd30:	ee5ff06f          	j	1bc14 <_svfiprintf_r+0x8ec>
   1bd34:	0f010413          	addi	s0,sp,240
   1bd38:	ec069ee3          	bnez	a3,1bc14 <_svfiprintf_r+0x8ec>
   1bd3c:	00167613          	andi	a2,a2,1
   1bd40:	ec060ae3          	beqz	a2,1bc14 <_svfiprintf_r+0x8ec>
   1bd44:	03000693          	li	a3,48
   1bd48:	0ed107a3          	sb	a3,239(sp)
   1bd4c:	989ff06f          	j	1b6d4 <_svfiprintf_r+0x3ac>
   1bd50:	1c0d8863          	beqz	s11,1bf20 <_svfiprintf_r+0xbf8>
   1bd54:	09b10623          	sb	s11,140(sp)
   1bd58:	02010da3          	sb	zero,59(sp)
   1bd5c:	000d0c13          	mv	s8,s10
   1bd60:	90dff06f          	j	1b66c <_svfiprintf_r+0x344>
   1bd64:	01058593          	addi	a1,a1,16
   1bd68:	011ba223          	sw	a7,4(s7)
   1bd6c:	04b12423          	sw	a1,72(sp)
   1bd70:	04c12223          	sw	a2,68(sp)
   1bd74:	02c35e63          	ble	a2,t1,1bdb0 <_svfiprintf_r+0xa88>
   1bd78:	04010613          	addi	a2,sp,64
   1bd7c:	00090593          	mv	a1,s2
   1bd80:	000a0513          	mv	a0,s4
   1bd84:	02612623          	sw	t1,44(sp)
   1bd88:	03012423          	sw	a6,40(sp)
   1bd8c:	03112223          	sw	a7,36(sp)
   1bd90:	02d12023          	sw	a3,32(sp)
   1bd94:	bccff0ef          	jal	ra,1b160 <__ssprint_r>
   1bd98:	10051263          	bnez	a0,1be9c <_svfiprintf_r+0xb74>
   1bd9c:	02c12303          	lw	t1,44(sp)
   1bda0:	02812803          	lw	a6,40(sp)
   1bda4:	02412883          	lw	a7,36(sp)
   1bda8:	02012683          	lw	a3,32(sp)
   1bdac:	04c10513          	addi	a0,sp,76
   1bdb0:	ff068693          	addi	a3,a3,-16
   1bdb4:	00050b93          	mv	s7,a0
   1bdb8:	afdff06f          	j	1b8b4 <_svfiprintf_r+0x58c>
   1bdbc:	01060613          	addi	a2,a2,16
   1bdc0:	010ba223          	sw	a6,4(s7)
   1bdc4:	04c12423          	sw	a2,72(sp)
   1bdc8:	04d12223          	sw	a3,68(sp)
   1bdcc:	02d8d663          	ble	a3,a7,1bdf8 <_svfiprintf_r+0xad0>
   1bdd0:	04010613          	addi	a2,sp,64
   1bdd4:	00090593          	mv	a1,s2
   1bdd8:	000a0513          	mv	a0,s4
   1bddc:	03112023          	sw	a7,32(sp)
   1bde0:	01012c23          	sw	a6,24(sp)
   1bde4:	b7cff0ef          	jal	ra,1b160 <__ssprint_r>
   1bde8:	0a051a63          	bnez	a0,1be9c <_svfiprintf_r+0xb74>
   1bdec:	02012883          	lw	a7,32(sp)
   1bdf0:	01812803          	lw	a6,24(sp)
   1bdf4:	04c10593          	addi	a1,sp,76
   1bdf8:	ff0d8d93          	addi	s11,s11,-16
   1bdfc:	00058b93          	mv	s7,a1
   1be00:	bc1ff06f          	j	1b9c0 <_svfiprintf_r+0x698>
   1be04:	01060613          	addi	a2,a2,16
   1be08:	01bba223          	sw	s11,4(s7)
   1be0c:	04c12423          	sw	a2,72(sp)
   1be10:	04d12223          	sw	a3,68(sp)
   1be14:	02d85263          	ble	a3,a6,1be38 <_svfiprintf_r+0xb10>
   1be18:	04010613          	addi	a2,sp,64
   1be1c:	00090593          	mv	a1,s2
   1be20:	000a0513          	mv	a0,s4
   1be24:	01012c23          	sw	a6,24(sp)
   1be28:	b38ff0ef          	jal	ra,1b160 <__ssprint_r>
   1be2c:	06051863          	bnez	a0,1be9c <_svfiprintf_r+0xb74>
   1be30:	01812803          	lw	a6,24(sp)
   1be34:	04c10593          	addi	a1,sp,76
   1be38:	ff0c8c93          	addi	s9,s9,-16
   1be3c:	00058b93          	mv	s7,a1
   1be40:	be1ff06f          	j	1ba20 <_svfiprintf_r+0x6f8>
   1be44:	41aa8433          	sub	s0,s5,s10
   1be48:	c6805ae3          	blez	s0,1babc <_svfiprintf_r+0x794>
   1be4c:	000227b7          	lui	a5,0x22
   1be50:	01000c93          	li	s9,16
   1be54:	27878493          	addi	s1,a5,632 # 22278 <blanks.4338>
   1be58:	00700d93          	li	s11,7
   1be5c:	04412783          	lw	a5,68(sp)
   1be60:	00972023          	sw	s1,0(a4)
   1be64:	04812683          	lw	a3,72(sp)
   1be68:	00178793          	addi	a5,a5,1
   1be6c:	068cce63          	blt	s9,s0,1bee8 <_svfiprintf_r+0xbc0>
   1be70:	00872223          	sw	s0,4(a4)
   1be74:	00d40433          	add	s0,s0,a3
   1be78:	04812423          	sw	s0,72(sp)
   1be7c:	04f12223          	sw	a5,68(sp)
   1be80:	00700713          	li	a4,7
   1be84:	c2f75ce3          	ble	a5,a4,1babc <_svfiprintf_r+0x794>
   1be88:	04010613          	addi	a2,sp,64
   1be8c:	00090593          	mv	a1,s2
   1be90:	000a0513          	mv	a0,s4
   1be94:	accff0ef          	jal	ra,1b160 <__ssprint_r>
   1be98:	c20502e3          	beqz	a0,1babc <_svfiprintf_r+0x794>
   1be9c:	00c95783          	lhu	a5,12(s2)
   1bea0:	0407f793          	andi	a5,a5,64
   1bea4:	ce079e63          	bnez	a5,1b3a0 <_svfiprintf_r+0x78>
   1bea8:	12c12083          	lw	ra,300(sp)
   1beac:	12812403          	lw	s0,296(sp)
   1beb0:	00012503          	lw	a0,0(sp)
   1beb4:	12412483          	lw	s1,292(sp)
   1beb8:	12012903          	lw	s2,288(sp)
   1bebc:	11c12983          	lw	s3,284(sp)
   1bec0:	11812a03          	lw	s4,280(sp)
   1bec4:	11412a83          	lw	s5,276(sp)
   1bec8:	11012b03          	lw	s6,272(sp)
   1becc:	10c12b83          	lw	s7,268(sp)
   1bed0:	10812c03          	lw	s8,264(sp)
   1bed4:	10412c83          	lw	s9,260(sp)
   1bed8:	10012d03          	lw	s10,256(sp)
   1bedc:	0fc12d83          	lw	s11,252(sp)
   1bee0:	13010113          	addi	sp,sp,304
   1bee4:	00008067          	ret
   1bee8:	01068693          	addi	a3,a3,16
   1beec:	01972223          	sw	s9,4(a4)
   1bef0:	04d12423          	sw	a3,72(sp)
   1bef4:	04f12223          	sw	a5,68(sp)
   1bef8:	00870713          	addi	a4,a4,8
   1befc:	00fdde63          	ble	a5,s11,1bf18 <_svfiprintf_r+0xbf0>
   1bf00:	04010613          	addi	a2,sp,64
   1bf04:	00090593          	mv	a1,s2
   1bf08:	000a0513          	mv	a0,s4
   1bf0c:	a54ff0ef          	jal	ra,1b160 <__ssprint_r>
   1bf10:	f80516e3          	bnez	a0,1be9c <_svfiprintf_r+0xb74>
   1bf14:	04c10713          	addi	a4,sp,76
   1bf18:	ff040413          	addi	s0,s0,-16
   1bf1c:	f41ff06f          	j	1be5c <_svfiprintf_r+0xb34>
   1bf20:	04812783          	lw	a5,72(sp)
   1bf24:	f6078ce3          	beqz	a5,1be9c <_svfiprintf_r+0xb74>
   1bf28:	04010613          	addi	a2,sp,64
   1bf2c:	00090593          	mv	a1,s2
   1bf30:	000a0513          	mv	a0,s4
   1bf34:	a2cff0ef          	jal	ra,1b160 <__ssprint_r>
   1bf38:	f65ff06f          	j	1be9c <_svfiprintf_r+0xb74>

0001bf3c <__swbuf_r>:
   1bf3c:	fe010113          	addi	sp,sp,-32
   1bf40:	00812c23          	sw	s0,24(sp)
   1bf44:	00912a23          	sw	s1,20(sp)
   1bf48:	01212823          	sw	s2,16(sp)
   1bf4c:	00112e23          	sw	ra,28(sp)
   1bf50:	01312623          	sw	s3,12(sp)
   1bf54:	00050913          	mv	s2,a0
   1bf58:	00058493          	mv	s1,a1
   1bf5c:	00060413          	mv	s0,a2
   1bf60:	00050863          	beqz	a0,1bf70 <__swbuf_r+0x34>
   1bf64:	03852783          	lw	a5,56(a0)
   1bf68:	00079463          	bnez	a5,1bf70 <__swbuf_r+0x34>
   1bf6c:	c78f70ef          	jal	ra,133e4 <__sinit>
   1bf70:	01842783          	lw	a5,24(s0)
   1bf74:	00f42423          	sw	a5,8(s0)
   1bf78:	00c45783          	lhu	a5,12(s0)
   1bf7c:	0087f793          	andi	a5,a5,8
   1bf80:	08078a63          	beqz	a5,1c014 <__swbuf_r+0xd8>
   1bf84:	01042783          	lw	a5,16(s0)
   1bf88:	08078663          	beqz	a5,1c014 <__swbuf_r+0xd8>
   1bf8c:	00c41783          	lh	a5,12(s0)
   1bf90:	0ff4f993          	andi	s3,s1,255
   1bf94:	0ff4f493          	andi	s1,s1,255
   1bf98:	01279713          	slli	a4,a5,0x12
   1bf9c:	0a075663          	bgez	a4,1c048 <__swbuf_r+0x10c>
   1bfa0:	01042783          	lw	a5,16(s0)
   1bfa4:	00042503          	lw	a0,0(s0)
   1bfa8:	40f50533          	sub	a0,a0,a5
   1bfac:	01442783          	lw	a5,20(s0)
   1bfb0:	00f54a63          	blt	a0,a5,1bfc4 <__swbuf_r+0x88>
   1bfb4:	00040593          	mv	a1,s0
   1bfb8:	00090513          	mv	a0,s2
   1bfbc:	a8cf70ef          	jal	ra,13248 <_fflush_r>
   1bfc0:	06051263          	bnez	a0,1c024 <__swbuf_r+0xe8>
   1bfc4:	00842783          	lw	a5,8(s0)
   1bfc8:	00150513          	addi	a0,a0,1
   1bfcc:	fff78793          	addi	a5,a5,-1
   1bfd0:	00f42423          	sw	a5,8(s0)
   1bfd4:	00042783          	lw	a5,0(s0)
   1bfd8:	00178713          	addi	a4,a5,1
   1bfdc:	00e42023          	sw	a4,0(s0)
   1bfe0:	01378023          	sb	s3,0(a5)
   1bfe4:	01442783          	lw	a5,20(s0)
   1bfe8:	00a78c63          	beq	a5,a0,1c000 <__swbuf_r+0xc4>
   1bfec:	00c45783          	lhu	a5,12(s0)
   1bff0:	0017f793          	andi	a5,a5,1
   1bff4:	02078a63          	beqz	a5,1c028 <__swbuf_r+0xec>
   1bff8:	00a00793          	li	a5,10
   1bffc:	02f49663          	bne	s1,a5,1c028 <__swbuf_r+0xec>
   1c000:	00040593          	mv	a1,s0
   1c004:	00090513          	mv	a0,s2
   1c008:	a40f70ef          	jal	ra,13248 <_fflush_r>
   1c00c:	00050e63          	beqz	a0,1c028 <__swbuf_r+0xec>
   1c010:	0140006f          	j	1c024 <__swbuf_r+0xe8>
   1c014:	00040593          	mv	a1,s0
   1c018:	00090513          	mv	a0,s2
   1c01c:	d69f60ef          	jal	ra,12d84 <__swsetup_r>
   1c020:	f60506e3          	beqz	a0,1bf8c <__swbuf_r+0x50>
   1c024:	fff00493          	li	s1,-1
   1c028:	01c12083          	lw	ra,28(sp)
   1c02c:	01812403          	lw	s0,24(sp)
   1c030:	00048513          	mv	a0,s1
   1c034:	01012903          	lw	s2,16(sp)
   1c038:	01412483          	lw	s1,20(sp)
   1c03c:	00c12983          	lw	s3,12(sp)
   1c040:	02010113          	addi	sp,sp,32
   1c044:	00008067          	ret
   1c048:	00002737          	lui	a4,0x2
   1c04c:	00e7e7b3          	or	a5,a5,a4
   1c050:	00f41623          	sh	a5,12(s0)
   1c054:	06442783          	lw	a5,100(s0)
   1c058:	ffffe737          	lui	a4,0xffffe
   1c05c:	fff70713          	addi	a4,a4,-1 # ffffdfff <__global_pointer$+0xfffd989f>
   1c060:	00e7f7b3          	and	a5,a5,a4
   1c064:	06f42223          	sw	a5,100(s0)
   1c068:	f39ff06f          	j	1bfa0 <__swbuf_r+0x64>

0001c06c <__swbuf>:
   1c06c:	00058613          	mv	a2,a1
   1c070:	00050593          	mv	a1,a0
   1c074:	8201a503          	lw	a0,-2016(gp) # 23f80 <_impure_ptr>
   1c078:	ec5ff06f          	j	1bf3c <__swbuf_r>

0001c07c <_wcrtomb_r>:
   1c07c:	8201a783          	lw	a5,-2016(gp) # 23f80 <_impure_ptr>
   1c080:	fe010113          	addi	sp,sp,-32
   1c084:	00812c23          	sw	s0,24(sp)
   1c088:	00912a23          	sw	s1,20(sp)
   1c08c:	00112e23          	sw	ra,28(sp)
   1c090:	00050413          	mv	s0,a0
   1c094:	00068493          	mv	s1,a3
   1c098:	0347a783          	lw	a5,52(a5)
   1c09c:	04059863          	bnez	a1,1c0ec <_wcrtomb_r+0x70>
   1c0a0:	00079663          	bnez	a5,1c0ac <_wcrtomb_r+0x30>
   1c0a4:	000247b7          	lui	a5,0x24
   1c0a8:	df078793          	addi	a5,a5,-528 # 23df0 <__global_locale>
   1c0ac:	0e07a783          	lw	a5,224(a5)
   1c0b0:	00048693          	mv	a3,s1
   1c0b4:	00000613          	li	a2,0
   1c0b8:	00410593          	addi	a1,sp,4
   1c0bc:	00040513          	mv	a0,s0
   1c0c0:	000780e7          	jalr	a5
   1c0c4:	fff00793          	li	a5,-1
   1c0c8:	00f51863          	bne	a0,a5,1c0d8 <_wcrtomb_r+0x5c>
   1c0cc:	0004a023          	sw	zero,0(s1)
   1c0d0:	08a00793          	li	a5,138
   1c0d4:	00f42023          	sw	a5,0(s0)
   1c0d8:	01c12083          	lw	ra,28(sp)
   1c0dc:	01812403          	lw	s0,24(sp)
   1c0e0:	01412483          	lw	s1,20(sp)
   1c0e4:	02010113          	addi	sp,sp,32
   1c0e8:	00008067          	ret
   1c0ec:	00079663          	bnez	a5,1c0f8 <_wcrtomb_r+0x7c>
   1c0f0:	000247b7          	lui	a5,0x24
   1c0f4:	df078793          	addi	a5,a5,-528 # 23df0 <__global_locale>
   1c0f8:	0e07a783          	lw	a5,224(a5)
   1c0fc:	00048693          	mv	a3,s1
   1c100:	fbdff06f          	j	1c0bc <_wcrtomb_r+0x40>

0001c104 <wcrtomb>:
   1c104:	00060693          	mv	a3,a2
   1c108:	00058613          	mv	a2,a1
   1c10c:	00050593          	mv	a1,a0
   1c110:	8201a503          	lw	a0,-2016(gp) # 23f80 <_impure_ptr>
   1c114:	f69ff06f          	j	1c07c <_wcrtomb_r>

0001c118 <conv_stat>:
   1c118:	0005a783          	lw	a5,0(a1)
   1c11c:	00f51023          	sh	a5,0(a0)
   1c120:	0085a783          	lw	a5,8(a1)
   1c124:	00f51123          	sh	a5,2(a0)
   1c128:	0105a783          	lw	a5,16(a1)
   1c12c:	00f52223          	sw	a5,4(a0)
   1c130:	0145a783          	lw	a5,20(a1)
   1c134:	00f51423          	sh	a5,8(a0)
   1c138:	0185a783          	lw	a5,24(a1)
   1c13c:	00f51523          	sh	a5,10(a0)
   1c140:	01c5a783          	lw	a5,28(a1)
   1c144:	00f51623          	sh	a5,12(a0)
   1c148:	0205a783          	lw	a5,32(a1)
   1c14c:	00f51723          	sh	a5,14(a0)
   1c150:	0305a783          	lw	a5,48(a1)
   1c154:	00f52823          	sw	a5,16(a0)
   1c158:	0405a783          	lw	a5,64(a1)
   1c15c:	02f52823          	sw	a5,48(a0)
   1c160:	0385a783          	lw	a5,56(a1)
   1c164:	02f52623          	sw	a5,44(a0)
   1c168:	0485a783          	lw	a5,72(a1)
   1c16c:	00f52a23          	sw	a5,20(a0)
   1c170:	0505a783          	lw	a5,80(a1)
   1c174:	00f52e23          	sw	a5,28(a0)
   1c178:	0585a783          	lw	a5,88(a1)
   1c17c:	02f52223          	sw	a5,36(a0)
   1c180:	00008067          	ret

0001c184 <__syscall_error>:
   1c184:	ff010113          	addi	sp,sp,-16
   1c188:	00812423          	sw	s0,8(sp)
   1c18c:	00112623          	sw	ra,12(sp)
   1c190:	00050413          	mv	s0,a0
   1c194:	4f0000ef          	jal	ra,1c684 <__errno>
   1c198:	408007b3          	neg	a5,s0
   1c19c:	00c12083          	lw	ra,12(sp)
   1c1a0:	00812403          	lw	s0,8(sp)
   1c1a4:	00f52023          	sw	a5,0(a0)
   1c1a8:	fff00513          	li	a0,-1
   1c1ac:	01010113          	addi	sp,sp,16
   1c1b0:	00008067          	ret

0001c1b4 <__internal_syscall>:
   1c1b4:	00050893          	mv	a7,a0
   1c1b8:	00058513          	mv	a0,a1
   1c1bc:	00060593          	mv	a1,a2
   1c1c0:	00068613          	mv	a2,a3
   1c1c4:	00070693          	mv	a3,a4
   1c1c8:	00000073          	ecall
   1c1cc:	00055463          	bgez	a0,1c1d4 <__internal_syscall+0x20>
   1c1d0:	fb5ff06f          	j	1c184 <__syscall_error>
   1c1d4:	00008067          	ret

0001c1d8 <open>:
   1c1d8:	00060693          	mv	a3,a2
   1c1dc:	00000713          	li	a4,0
   1c1e0:	00058613          	mv	a2,a1
   1c1e4:	00050593          	mv	a1,a0
   1c1e8:	40000513          	li	a0,1024
   1c1ec:	fc9ff06f          	j	1c1b4 <__internal_syscall>

0001c1f0 <openat>:
   1c1f0:	00068713          	mv	a4,a3
   1c1f4:	00060693          	mv	a3,a2
   1c1f8:	00058613          	mv	a2,a1
   1c1fc:	00050593          	mv	a1,a0
   1c200:	03800513          	li	a0,56
   1c204:	fb1ff06f          	j	1c1b4 <__internal_syscall>

0001c208 <lseek>:
   1c208:	00060693          	mv	a3,a2
   1c20c:	00000713          	li	a4,0
   1c210:	00058613          	mv	a2,a1
   1c214:	00050593          	mv	a1,a0
   1c218:	03e00513          	li	a0,62
   1c21c:	f99ff06f          	j	1c1b4 <__internal_syscall>

0001c220 <read>:
   1c220:	00060693          	mv	a3,a2
   1c224:	00000713          	li	a4,0
   1c228:	00058613          	mv	a2,a1
   1c22c:	00050593          	mv	a1,a0
   1c230:	03f00513          	li	a0,63
   1c234:	f81ff06f          	j	1c1b4 <__internal_syscall>

0001c238 <write>:
   1c238:	00060693          	mv	a3,a2
   1c23c:	00000713          	li	a4,0
   1c240:	00058613          	mv	a2,a1
   1c244:	00050593          	mv	a1,a0
   1c248:	04000513          	li	a0,64
   1c24c:	f69ff06f          	j	1c1b4 <__internal_syscall>

0001c250 <fstat>:
   1c250:	f8010113          	addi	sp,sp,-128
   1c254:	06912a23          	sw	s1,116(sp)
   1c258:	00810613          	addi	a2,sp,8
   1c25c:	00058493          	mv	s1,a1
   1c260:	00000713          	li	a4,0
   1c264:	00050593          	mv	a1,a0
   1c268:	00000693          	li	a3,0
   1c26c:	05000513          	li	a0,80
   1c270:	06112e23          	sw	ra,124(sp)
   1c274:	06812c23          	sw	s0,120(sp)
   1c278:	f3dff0ef          	jal	ra,1c1b4 <__internal_syscall>
   1c27c:	00050413          	mv	s0,a0
   1c280:	00810593          	addi	a1,sp,8
   1c284:	00048513          	mv	a0,s1
   1c288:	e91ff0ef          	jal	ra,1c118 <conv_stat>
   1c28c:	00040513          	mv	a0,s0
   1c290:	07c12083          	lw	ra,124(sp)
   1c294:	07812403          	lw	s0,120(sp)
   1c298:	07412483          	lw	s1,116(sp)
   1c29c:	08010113          	addi	sp,sp,128
   1c2a0:	00008067          	ret

0001c2a4 <stat>:
   1c2a4:	f8010113          	addi	sp,sp,-128
   1c2a8:	06912a23          	sw	s1,116(sp)
   1c2ac:	00810613          	addi	a2,sp,8
   1c2b0:	00058493          	mv	s1,a1
   1c2b4:	00000713          	li	a4,0
   1c2b8:	00050593          	mv	a1,a0
   1c2bc:	00000693          	li	a3,0
   1c2c0:	40e00513          	li	a0,1038
   1c2c4:	06112e23          	sw	ra,124(sp)
   1c2c8:	06812c23          	sw	s0,120(sp)
   1c2cc:	ee9ff0ef          	jal	ra,1c1b4 <__internal_syscall>
   1c2d0:	00050413          	mv	s0,a0
   1c2d4:	00810593          	addi	a1,sp,8
   1c2d8:	00048513          	mv	a0,s1
   1c2dc:	e3dff0ef          	jal	ra,1c118 <conv_stat>
   1c2e0:	00040513          	mv	a0,s0
   1c2e4:	07c12083          	lw	ra,124(sp)
   1c2e8:	07812403          	lw	s0,120(sp)
   1c2ec:	07412483          	lw	s1,116(sp)
   1c2f0:	08010113          	addi	sp,sp,128
   1c2f4:	00008067          	ret

0001c2f8 <lstat>:
   1c2f8:	f8010113          	addi	sp,sp,-128
   1c2fc:	06912a23          	sw	s1,116(sp)
   1c300:	00810613          	addi	a2,sp,8
   1c304:	00058493          	mv	s1,a1
   1c308:	00000713          	li	a4,0
   1c30c:	00050593          	mv	a1,a0
   1c310:	00000693          	li	a3,0
   1c314:	40f00513          	li	a0,1039
   1c318:	06112e23          	sw	ra,124(sp)
   1c31c:	06812c23          	sw	s0,120(sp)
   1c320:	e95ff0ef          	jal	ra,1c1b4 <__internal_syscall>
   1c324:	00050413          	mv	s0,a0
   1c328:	00810593          	addi	a1,sp,8
   1c32c:	00048513          	mv	a0,s1
   1c330:	de9ff0ef          	jal	ra,1c118 <conv_stat>
   1c334:	00040513          	mv	a0,s0
   1c338:	07c12083          	lw	ra,124(sp)
   1c33c:	07812403          	lw	s0,120(sp)
   1c340:	07412483          	lw	s1,116(sp)
   1c344:	08010113          	addi	sp,sp,128
   1c348:	00008067          	ret

0001c34c <fstatat>:
   1c34c:	f8010113          	addi	sp,sp,-128
   1c350:	06912a23          	sw	s1,116(sp)
   1c354:	00068713          	mv	a4,a3
   1c358:	00060493          	mv	s1,a2
   1c35c:	00810693          	addi	a3,sp,8
   1c360:	00058613          	mv	a2,a1
   1c364:	00050593          	mv	a1,a0
   1c368:	04f00513          	li	a0,79
   1c36c:	06112e23          	sw	ra,124(sp)
   1c370:	06812c23          	sw	s0,120(sp)
   1c374:	e41ff0ef          	jal	ra,1c1b4 <__internal_syscall>
   1c378:	00050413          	mv	s0,a0
   1c37c:	00810593          	addi	a1,sp,8
   1c380:	00048513          	mv	a0,s1
   1c384:	d95ff0ef          	jal	ra,1c118 <conv_stat>
   1c388:	00040513          	mv	a0,s0
   1c38c:	07c12083          	lw	ra,124(sp)
   1c390:	07812403          	lw	s0,120(sp)
   1c394:	07412483          	lw	s1,116(sp)
   1c398:	08010113          	addi	sp,sp,128
   1c39c:	00008067          	ret

0001c3a0 <access>:
   1c3a0:	00058613          	mv	a2,a1
   1c3a4:	00000713          	li	a4,0
   1c3a8:	00050593          	mv	a1,a0
   1c3ac:	00000693          	li	a3,0
   1c3b0:	40900513          	li	a0,1033
   1c3b4:	e01ff06f          	j	1c1b4 <__internal_syscall>

0001c3b8 <faccessat>:
   1c3b8:	00068713          	mv	a4,a3
   1c3bc:	00060693          	mv	a3,a2
   1c3c0:	00058613          	mv	a2,a1
   1c3c4:	00050593          	mv	a1,a0
   1c3c8:	03000513          	li	a0,48
   1c3cc:	de9ff06f          	j	1c1b4 <__internal_syscall>

0001c3d0 <close>:
   1c3d0:	00050593          	mv	a1,a0
   1c3d4:	00000713          	li	a4,0
   1c3d8:	00000693          	li	a3,0
   1c3dc:	00000613          	li	a2,0
   1c3e0:	03900513          	li	a0,57
   1c3e4:	dd1ff06f          	j	1c1b4 <__internal_syscall>

0001c3e8 <link>:
   1c3e8:	00058613          	mv	a2,a1
   1c3ec:	00000713          	li	a4,0
   1c3f0:	00050593          	mv	a1,a0
   1c3f4:	00000693          	li	a3,0
   1c3f8:	40100513          	li	a0,1025
   1c3fc:	db9ff06f          	j	1c1b4 <__internal_syscall>

0001c400 <unlink>:
   1c400:	00050593          	mv	a1,a0
   1c404:	00000713          	li	a4,0
   1c408:	00000693          	li	a3,0
   1c40c:	00000613          	li	a2,0
   1c410:	40200513          	li	a0,1026
   1c414:	da1ff06f          	j	1c1b4 <__internal_syscall>

0001c418 <execve>:
   1c418:	ff010113          	addi	sp,sp,-16
   1c41c:	00112623          	sw	ra,12(sp)
   1c420:	264000ef          	jal	ra,1c684 <__errno>
   1c424:	00c12083          	lw	ra,12(sp)
   1c428:	00c00793          	li	a5,12
   1c42c:	00f52023          	sw	a5,0(a0)
   1c430:	fff00513          	li	a0,-1
   1c434:	01010113          	addi	sp,sp,16
   1c438:	00008067          	ret

0001c43c <fork>:
   1c43c:	ff010113          	addi	sp,sp,-16
   1c440:	00112623          	sw	ra,12(sp)
   1c444:	240000ef          	jal	ra,1c684 <__errno>
   1c448:	00c12083          	lw	ra,12(sp)
   1c44c:	00b00793          	li	a5,11
   1c450:	00f52023          	sw	a5,0(a0)
   1c454:	fff00513          	li	a0,-1
   1c458:	01010113          	addi	sp,sp,16
   1c45c:	00008067          	ret

0001c460 <getpid>:
   1c460:	00100513          	li	a0,1
   1c464:	00008067          	ret

0001c468 <kill>:
   1c468:	ff010113          	addi	sp,sp,-16
   1c46c:	00112623          	sw	ra,12(sp)
   1c470:	214000ef          	jal	ra,1c684 <__errno>
   1c474:	00c12083          	lw	ra,12(sp)
   1c478:	01600793          	li	a5,22
   1c47c:	00f52023          	sw	a5,0(a0)
   1c480:	fff00513          	li	a0,-1
   1c484:	01010113          	addi	sp,sp,16
   1c488:	00008067          	ret

0001c48c <wait>:
   1c48c:	ff010113          	addi	sp,sp,-16
   1c490:	00112623          	sw	ra,12(sp)
   1c494:	1f0000ef          	jal	ra,1c684 <__errno>
   1c498:	00c12083          	lw	ra,12(sp)
   1c49c:	00a00793          	li	a5,10
   1c4a0:	00f52023          	sw	a5,0(a0)
   1c4a4:	fff00513          	li	a0,-1
   1c4a8:	01010113          	addi	sp,sp,16
   1c4ac:	00008067          	ret

0001c4b0 <isatty>:
   1c4b0:	fb010113          	addi	sp,sp,-80
   1c4b4:	00410593          	addi	a1,sp,4
   1c4b8:	04112623          	sw	ra,76(sp)
   1c4bc:	d95ff0ef          	jal	ra,1c250 <fstat>
   1c4c0:	fff00793          	li	a5,-1
   1c4c4:	00f50863          	beq	a0,a5,1c4d4 <isatty+0x24>
   1c4c8:	00812503          	lw	a0,8(sp)
   1c4cc:	00d55513          	srli	a0,a0,0xd
   1c4d0:	00157513          	andi	a0,a0,1
   1c4d4:	04c12083          	lw	ra,76(sp)
   1c4d8:	05010113          	addi	sp,sp,80
   1c4dc:	00008067          	ret

0001c4e0 <gettimeofday>:
   1c4e0:	00050593          	mv	a1,a0
   1c4e4:	00000713          	li	a4,0
   1c4e8:	00000693          	li	a3,0
   1c4ec:	00000613          	li	a2,0
   1c4f0:	0a900513          	li	a0,169
   1c4f4:	cc1ff06f          	j	1c1b4 <__internal_syscall>

0001c4f8 <times>:
   1c4f8:	fe010113          	addi	sp,sp,-32
   1c4fc:	00812c23          	sw	s0,24(sp)
   1c500:	00050413          	mv	s0,a0
   1c504:	8401a783          	lw	a5,-1984(gp) # 23fa0 <t0.2538>
   1c508:	00912a23          	sw	s1,20(sp)
   1c50c:	00112e23          	sw	ra,28(sp)
   1c510:	84018493          	addi	s1,gp,-1984 # 23fa0 <t0.2538>
   1c514:	00079863          	bnez	a5,1c524 <times+0x2c>
   1c518:	00000593          	li	a1,0
   1c51c:	84018513          	addi	a0,gp,-1984 # 23fa0 <t0.2538>
   1c520:	fc1ff0ef          	jal	ra,1c4e0 <gettimeofday>
   1c524:	00000593          	li	a1,0
   1c528:	00810513          	addi	a0,sp,8
   1c52c:	fb5ff0ef          	jal	ra,1c4e0 <gettimeofday>
   1c530:	0004a783          	lw	a5,0(s1)
   1c534:	00812503          	lw	a0,8(sp)
   1c538:	000f45b7          	lui	a1,0xf4
   1c53c:	24058593          	addi	a1,a1,576 # f4240 <__global_pointer$+0xcfae0>
   1c540:	40f50533          	sub	a0,a0,a5
   1c544:	068050ef          	jal	ra,215ac <__mulsi3>
   1c548:	0044a703          	lw	a4,4(s1)
   1c54c:	00c12783          	lw	a5,12(sp)
   1c550:	00042423          	sw	zero,8(s0)
   1c554:	00042623          	sw	zero,12(s0)
   1c558:	40e787b3          	sub	a5,a5,a4
   1c55c:	00f50533          	add	a0,a0,a5
   1c560:	00a42023          	sw	a0,0(s0)
   1c564:	00042223          	sw	zero,4(s0)
   1c568:	01c12083          	lw	ra,28(sp)
   1c56c:	01812403          	lw	s0,24(sp)
   1c570:	01412483          	lw	s1,20(sp)
   1c574:	fff00513          	li	a0,-1
   1c578:	02010113          	addi	sp,sp,32
   1c57c:	00008067          	ret

0001c580 <ftime>:
   1c580:	00051223          	sh	zero,4(a0)
   1c584:	00052023          	sw	zero,0(a0)
   1c588:	00000513          	li	a0,0
   1c58c:	00008067          	ret

0001c590 <utime>:
   1c590:	fff00513          	li	a0,-1
   1c594:	00008067          	ret

0001c598 <chown>:
   1c598:	fff00513          	li	a0,-1
   1c59c:	00008067          	ret

0001c5a0 <chmod>:
   1c5a0:	fff00513          	li	a0,-1
   1c5a4:	00008067          	ret

0001c5a8 <chdir>:
   1c5a8:	fff00513          	li	a0,-1
   1c5ac:	00008067          	ret

0001c5b0 <getcwd>:
   1c5b0:	00000513          	li	a0,0
   1c5b4:	00008067          	ret

0001c5b8 <sysconf>:
   1c5b8:	00200793          	li	a5,2
   1c5bc:	00f50663          	beq	a0,a5,1c5c8 <sysconf+0x10>
   1c5c0:	fff00513          	li	a0,-1
   1c5c4:	00008067          	ret
   1c5c8:	000f4537          	lui	a0,0xf4
   1c5cc:	24050513          	addi	a0,a0,576 # f4240 <__global_pointer$+0xcfae0>
   1c5d0:	00008067          	ret

0001c5d4 <sbrk>:
   1c5d4:	ff010113          	addi	sp,sp,-16
   1c5d8:	00812423          	sw	s0,8(sp)
   1c5dc:	83c1a783          	lw	a5,-1988(gp) # 23f9c <heap_end.2575>
   1c5e0:	00912223          	sw	s1,4(sp)
   1c5e4:	00112623          	sw	ra,12(sp)
   1c5e8:	00050493          	mv	s1,a0
   1c5ec:	04079063          	bnez	a5,1c62c <sbrk+0x58>
   1c5f0:	00000713          	li	a4,0
   1c5f4:	00000693          	li	a3,0
   1c5f8:	00000613          	li	a2,0
   1c5fc:	00000593          	li	a1,0
   1c600:	0d600513          	li	a0,214
   1c604:	bb1ff0ef          	jal	ra,1c1b4 <__internal_syscall>
   1c608:	fff00793          	li	a5,-1
   1c60c:	00f51e63          	bne	a0,a5,1c628 <sbrk+0x54>
   1c610:	fff00513          	li	a0,-1
   1c614:	00c12083          	lw	ra,12(sp)
   1c618:	00812403          	lw	s0,8(sp)
   1c61c:	00412483          	lw	s1,4(sp)
   1c620:	01010113          	addi	sp,sp,16
   1c624:	00008067          	ret
   1c628:	82a1ae23          	sw	a0,-1988(gp) # 23f9c <heap_end.2575>
   1c62c:	83c1a583          	lw	a1,-1988(gp) # 23f9c <heap_end.2575>
   1c630:	00000713          	li	a4,0
   1c634:	00000693          	li	a3,0
   1c638:	00b485b3          	add	a1,s1,a1
   1c63c:	00000613          	li	a2,0
   1c640:	0d600513          	li	a0,214
   1c644:	b71ff0ef          	jal	ra,1c1b4 <__internal_syscall>
   1c648:	83c1a783          	lw	a5,-1988(gp) # 23f9c <heap_end.2575>
   1c64c:	00f484b3          	add	s1,s1,a5
   1c650:	fc9510e3          	bne	a0,s1,1c610 <sbrk+0x3c>
   1c654:	82a1ae23          	sw	a0,-1988(gp) # 23f9c <heap_end.2575>
   1c658:	00078513          	mv	a0,a5
   1c65c:	fb9ff06f          	j	1c614 <sbrk+0x40>

0001c660 <_exit>:
   1c660:	ff010113          	addi	sp,sp,-16
   1c664:	00050593          	mv	a1,a0
   1c668:	00000713          	li	a4,0
   1c66c:	00000693          	li	a3,0
   1c670:	00000613          	li	a2,0
   1c674:	05d00513          	li	a0,93
   1c678:	00112623          	sw	ra,12(sp)
   1c67c:	b39ff0ef          	jal	ra,1c1b4 <__internal_syscall>
   1c680:	0000006f          	j	1c680 <_exit+0x20>

0001c684 <__errno>:
   1c684:	8201a503          	lw	a0,-2016(gp) # 23f80 <_impure_ptr>
   1c688:	00008067          	ret

0001c68c <__udivdi3>:
   1c68c:	fd010113          	addi	sp,sp,-48
   1c690:	01612823          	sw	s6,16(sp)
   1c694:	01712623          	sw	s7,12(sp)
   1c698:	02112623          	sw	ra,44(sp)
   1c69c:	02812423          	sw	s0,40(sp)
   1c6a0:	02912223          	sw	s1,36(sp)
   1c6a4:	03212023          	sw	s2,32(sp)
   1c6a8:	01312e23          	sw	s3,28(sp)
   1c6ac:	01412c23          	sw	s4,24(sp)
   1c6b0:	01512a23          	sw	s5,20(sp)
   1c6b4:	01812423          	sw	s8,8(sp)
   1c6b8:	01912223          	sw	s9,4(sp)
   1c6bc:	01a12023          	sw	s10,0(sp)
   1c6c0:	00050b13          	mv	s6,a0
   1c6c4:	00058b93          	mv	s7,a1
   1c6c8:	38069e63          	bnez	a3,1ca64 <__udivdi3+0x3d8>
   1c6cc:	00022937          	lui	s2,0x22
   1c6d0:	00060493          	mv	s1,a2
   1c6d4:	00050a13          	mv	s4,a0
   1c6d8:	34c90913          	addi	s2,s2,844 # 2234c <__clz_tab>
   1c6dc:	12c5f863          	bleu	a2,a1,1c80c <__udivdi3+0x180>
   1c6e0:	000107b7          	lui	a5,0x10
   1c6e4:	00058413          	mv	s0,a1
   1c6e8:	10f67863          	bleu	a5,a2,1c7f8 <__udivdi3+0x16c>
   1c6ec:	0ff00713          	li	a4,255
   1c6f0:	00c73733          	sltu	a4,a4,a2
   1c6f4:	00371713          	slli	a4,a4,0x3
   1c6f8:	00e657b3          	srl	a5,a2,a4
   1c6fc:	00f90933          	add	s2,s2,a5
   1c700:	00094683          	lbu	a3,0(s2)
   1c704:	00e68733          	add	a4,a3,a4
   1c708:	02000693          	li	a3,32
   1c70c:	40e686b3          	sub	a3,a3,a4
   1c710:	00068c63          	beqz	a3,1c728 <__udivdi3+0x9c>
   1c714:	00db9433          	sll	s0,s7,a3
   1c718:	00eb5733          	srl	a4,s6,a4
   1c71c:	00d614b3          	sll	s1,a2,a3
   1c720:	00876433          	or	s0,a4,s0
   1c724:	00db1a33          	sll	s4,s6,a3
   1c728:	0104da93          	srli	s5,s1,0x10
   1c72c:	000a8593          	mv	a1,s5
   1c730:	00040513          	mv	a0,s0
   1c734:	6ed040ef          	jal	ra,21620 <__umodsi3>
   1c738:	00050993          	mv	s3,a0
   1c73c:	000a8593          	mv	a1,s5
   1c740:	00040513          	mv	a0,s0
   1c744:	01049b13          	slli	s6,s1,0x10
   1c748:	691040ef          	jal	ra,215d8 <__udivsi3>
   1c74c:	010b5b13          	srli	s6,s6,0x10
   1c750:	00050913          	mv	s2,a0
   1c754:	00050593          	mv	a1,a0
   1c758:	000b0513          	mv	a0,s6
   1c75c:	651040ef          	jal	ra,215ac <__mulsi3>
   1c760:	01099993          	slli	s3,s3,0x10
   1c764:	010a5793          	srli	a5,s4,0x10
   1c768:	00f9e7b3          	or	a5,s3,a5
   1c76c:	00090413          	mv	s0,s2
   1c770:	00a7fe63          	bleu	a0,a5,1c78c <__udivdi3+0x100>
   1c774:	009787b3          	add	a5,a5,s1
   1c778:	fff90413          	addi	s0,s2,-1
   1c77c:	0097e863          	bltu	a5,s1,1c78c <__udivdi3+0x100>
   1c780:	00a7f663          	bleu	a0,a5,1c78c <__udivdi3+0x100>
   1c784:	ffe90413          	addi	s0,s2,-2
   1c788:	009787b3          	add	a5,a5,s1
   1c78c:	40a78933          	sub	s2,a5,a0
   1c790:	000a8593          	mv	a1,s5
   1c794:	00090513          	mv	a0,s2
   1c798:	689040ef          	jal	ra,21620 <__umodsi3>
   1c79c:	00050993          	mv	s3,a0
   1c7a0:	000a8593          	mv	a1,s5
   1c7a4:	00090513          	mv	a0,s2
   1c7a8:	631040ef          	jal	ra,215d8 <__udivsi3>
   1c7ac:	010a1a13          	slli	s4,s4,0x10
   1c7b0:	00050913          	mv	s2,a0
   1c7b4:	00050593          	mv	a1,a0
   1c7b8:	01099993          	slli	s3,s3,0x10
   1c7bc:	000b0513          	mv	a0,s6
   1c7c0:	010a5a13          	srli	s4,s4,0x10
   1c7c4:	5e9040ef          	jal	ra,215ac <__mulsi3>
   1c7c8:	0149ea33          	or	s4,s3,s4
   1c7cc:	00090613          	mv	a2,s2
   1c7d0:	00aa7c63          	bleu	a0,s4,1c7e8 <__udivdi3+0x15c>
   1c7d4:	01448a33          	add	s4,s1,s4
   1c7d8:	fff90613          	addi	a2,s2,-1
   1c7dc:	009a6663          	bltu	s4,s1,1c7e8 <__udivdi3+0x15c>
   1c7e0:	00aa7463          	bleu	a0,s4,1c7e8 <__udivdi3+0x15c>
   1c7e4:	ffe90613          	addi	a2,s2,-2
   1c7e8:	01041413          	slli	s0,s0,0x10
   1c7ec:	00c46433          	or	s0,s0,a2
   1c7f0:	00000a93          	li	s5,0
   1c7f4:	1300006f          	j	1c924 <__udivdi3+0x298>
   1c7f8:	010007b7          	lui	a5,0x1000
   1c7fc:	01000713          	li	a4,16
   1c800:	eef66ce3          	bltu	a2,a5,1c6f8 <__udivdi3+0x6c>
   1c804:	01800713          	li	a4,24
   1c808:	ef1ff06f          	j	1c6f8 <__udivdi3+0x6c>
   1c80c:	00068993          	mv	s3,a3
   1c810:	00061a63          	bnez	a2,1c824 <__udivdi3+0x198>
   1c814:	00000593          	li	a1,0
   1c818:	00100513          	li	a0,1
   1c81c:	5bd040ef          	jal	ra,215d8 <__udivsi3>
   1c820:	00050493          	mv	s1,a0
   1c824:	000107b7          	lui	a5,0x10
   1c828:	12f4fe63          	bleu	a5,s1,1c964 <__udivdi3+0x2d8>
   1c82c:	0ff00793          	li	a5,255
   1c830:	0097f463          	bleu	s1,a5,1c838 <__udivdi3+0x1ac>
   1c834:	00800993          	li	s3,8
   1c838:	0134d7b3          	srl	a5,s1,s3
   1c83c:	00f90933          	add	s2,s2,a5
   1c840:	00094703          	lbu	a4,0(s2)
   1c844:	02000693          	li	a3,32
   1c848:	01370733          	add	a4,a4,s3
   1c84c:	40e686b3          	sub	a3,a3,a4
   1c850:	12069463          	bnez	a3,1c978 <__udivdi3+0x2ec>
   1c854:	409b8433          	sub	s0,s7,s1
   1c858:	00100a93          	li	s5,1
   1c85c:	0104db13          	srli	s6,s1,0x10
   1c860:	000b0593          	mv	a1,s6
   1c864:	00040513          	mv	a0,s0
   1c868:	5b9040ef          	jal	ra,21620 <__umodsi3>
   1c86c:	00050993          	mv	s3,a0
   1c870:	000b0593          	mv	a1,s6
   1c874:	00040513          	mv	a0,s0
   1c878:	01049b93          	slli	s7,s1,0x10
   1c87c:	55d040ef          	jal	ra,215d8 <__udivsi3>
   1c880:	010bdb93          	srli	s7,s7,0x10
   1c884:	00050913          	mv	s2,a0
   1c888:	00050593          	mv	a1,a0
   1c88c:	000b8513          	mv	a0,s7
   1c890:	51d040ef          	jal	ra,215ac <__mulsi3>
   1c894:	01099993          	slli	s3,s3,0x10
   1c898:	010a5793          	srli	a5,s4,0x10
   1c89c:	00f9e7b3          	or	a5,s3,a5
   1c8a0:	00090413          	mv	s0,s2
   1c8a4:	00a7fe63          	bleu	a0,a5,1c8c0 <__udivdi3+0x234>
   1c8a8:	009787b3          	add	a5,a5,s1
   1c8ac:	fff90413          	addi	s0,s2,-1
   1c8b0:	0097e863          	bltu	a5,s1,1c8c0 <__udivdi3+0x234>
   1c8b4:	00a7f663          	bleu	a0,a5,1c8c0 <__udivdi3+0x234>
   1c8b8:	ffe90413          	addi	s0,s2,-2
   1c8bc:	009787b3          	add	a5,a5,s1
   1c8c0:	40a78933          	sub	s2,a5,a0
   1c8c4:	000b0593          	mv	a1,s6
   1c8c8:	00090513          	mv	a0,s2
   1c8cc:	555040ef          	jal	ra,21620 <__umodsi3>
   1c8d0:	00050993          	mv	s3,a0
   1c8d4:	000b0593          	mv	a1,s6
   1c8d8:	00090513          	mv	a0,s2
   1c8dc:	4fd040ef          	jal	ra,215d8 <__udivsi3>
   1c8e0:	010a1a13          	slli	s4,s4,0x10
   1c8e4:	00050913          	mv	s2,a0
   1c8e8:	00050593          	mv	a1,a0
   1c8ec:	01099993          	slli	s3,s3,0x10
   1c8f0:	000b8513          	mv	a0,s7
   1c8f4:	010a5a13          	srli	s4,s4,0x10
   1c8f8:	4b5040ef          	jal	ra,215ac <__mulsi3>
   1c8fc:	0149ea33          	or	s4,s3,s4
   1c900:	00090613          	mv	a2,s2
   1c904:	00aa7c63          	bleu	a0,s4,1c91c <__udivdi3+0x290>
   1c908:	01448a33          	add	s4,s1,s4
   1c90c:	fff90613          	addi	a2,s2,-1
   1c910:	009a6663          	bltu	s4,s1,1c91c <__udivdi3+0x290>
   1c914:	00aa7463          	bleu	a0,s4,1c91c <__udivdi3+0x290>
   1c918:	ffe90613          	addi	a2,s2,-2
   1c91c:	01041413          	slli	s0,s0,0x10
   1c920:	00c46433          	or	s0,s0,a2
   1c924:	00040513          	mv	a0,s0
   1c928:	000a8593          	mv	a1,s5
   1c92c:	02c12083          	lw	ra,44(sp)
   1c930:	02812403          	lw	s0,40(sp)
   1c934:	02412483          	lw	s1,36(sp)
   1c938:	02012903          	lw	s2,32(sp)
   1c93c:	01c12983          	lw	s3,28(sp)
   1c940:	01812a03          	lw	s4,24(sp)
   1c944:	01412a83          	lw	s5,20(sp)
   1c948:	01012b03          	lw	s6,16(sp)
   1c94c:	00c12b83          	lw	s7,12(sp)
   1c950:	00812c03          	lw	s8,8(sp)
   1c954:	00412c83          	lw	s9,4(sp)
   1c958:	00012d03          	lw	s10,0(sp)
   1c95c:	03010113          	addi	sp,sp,48
   1c960:	00008067          	ret
   1c964:	010007b7          	lui	a5,0x1000
   1c968:	01000993          	li	s3,16
   1c96c:	ecf4e6e3          	bltu	s1,a5,1c838 <__udivdi3+0x1ac>
   1c970:	01800993          	li	s3,24
   1c974:	ec5ff06f          	j	1c838 <__udivdi3+0x1ac>
   1c978:	00d494b3          	sll	s1,s1,a3
   1c97c:	00ebd9b3          	srl	s3,s7,a4
   1c980:	0104d413          	srli	s0,s1,0x10
   1c984:	00eb5733          	srl	a4,s6,a4
   1c988:	00db9bb3          	sll	s7,s7,a3
   1c98c:	00040593          	mv	a1,s0
   1c990:	00098513          	mv	a0,s3
   1c994:	01776bb3          	or	s7,a4,s7
   1c998:	00db1a33          	sll	s4,s6,a3
   1c99c:	485040ef          	jal	ra,21620 <__umodsi3>
   1c9a0:	00050913          	mv	s2,a0
   1c9a4:	00040593          	mv	a1,s0
   1c9a8:	00098513          	mv	a0,s3
   1c9ac:	01049b13          	slli	s6,s1,0x10
   1c9b0:	429040ef          	jal	ra,215d8 <__udivsi3>
   1c9b4:	010b5b13          	srli	s6,s6,0x10
   1c9b8:	00050993          	mv	s3,a0
   1c9bc:	00050593          	mv	a1,a0
   1c9c0:	000b0513          	mv	a0,s6
   1c9c4:	3e9040ef          	jal	ra,215ac <__mulsi3>
   1c9c8:	01091913          	slli	s2,s2,0x10
   1c9cc:	010bd713          	srli	a4,s7,0x10
   1c9d0:	00e96733          	or	a4,s2,a4
   1c9d4:	00098a93          	mv	s5,s3
   1c9d8:	00a77e63          	bleu	a0,a4,1c9f4 <__udivdi3+0x368>
   1c9dc:	00970733          	add	a4,a4,s1
   1c9e0:	fff98a93          	addi	s5,s3,-1
   1c9e4:	00976863          	bltu	a4,s1,1c9f4 <__udivdi3+0x368>
   1c9e8:	00a77663          	bleu	a0,a4,1c9f4 <__udivdi3+0x368>
   1c9ec:	ffe98a93          	addi	s5,s3,-2
   1c9f0:	00970733          	add	a4,a4,s1
   1c9f4:	40a709b3          	sub	s3,a4,a0
   1c9f8:	00040593          	mv	a1,s0
   1c9fc:	00098513          	mv	a0,s3
   1ca00:	421040ef          	jal	ra,21620 <__umodsi3>
   1ca04:	00040593          	mv	a1,s0
   1ca08:	00050913          	mv	s2,a0
   1ca0c:	00098513          	mv	a0,s3
   1ca10:	3c9040ef          	jal	ra,215d8 <__udivsi3>
   1ca14:	00050413          	mv	s0,a0
   1ca18:	00050593          	mv	a1,a0
   1ca1c:	000b0513          	mv	a0,s6
   1ca20:	38d040ef          	jal	ra,215ac <__mulsi3>
   1ca24:	010b9713          	slli	a4,s7,0x10
   1ca28:	01075713          	srli	a4,a4,0x10
   1ca2c:	01091913          	slli	s2,s2,0x10
   1ca30:	00e967b3          	or	a5,s2,a4
   1ca34:	00040713          	mv	a4,s0
   1ca38:	00a7fe63          	bleu	a0,a5,1ca54 <__udivdi3+0x3c8>
   1ca3c:	009787b3          	add	a5,a5,s1
   1ca40:	fff40713          	addi	a4,s0,-1
   1ca44:	0097e863          	bltu	a5,s1,1ca54 <__udivdi3+0x3c8>
   1ca48:	00a7f663          	bleu	a0,a5,1ca54 <__udivdi3+0x3c8>
   1ca4c:	ffe40713          	addi	a4,s0,-2
   1ca50:	009787b3          	add	a5,a5,s1
   1ca54:	010a9a93          	slli	s5,s5,0x10
   1ca58:	40a78433          	sub	s0,a5,a0
   1ca5c:	00eaeab3          	or	s5,s5,a4
   1ca60:	dfdff06f          	j	1c85c <__udivdi3+0x1d0>
   1ca64:	1ed5ec63          	bltu	a1,a3,1cc5c <__udivdi3+0x5d0>
   1ca68:	000107b7          	lui	a5,0x10
   1ca6c:	04f6f463          	bleu	a5,a3,1cab4 <__udivdi3+0x428>
   1ca70:	0ff00713          	li	a4,255
   1ca74:	00d735b3          	sltu	a1,a4,a3
   1ca78:	00359593          	slli	a1,a1,0x3
   1ca7c:	00022737          	lui	a4,0x22
   1ca80:	34c70713          	addi	a4,a4,844 # 2234c <__clz_tab>
   1ca84:	00b6d7b3          	srl	a5,a3,a1
   1ca88:	00e787b3          	add	a5,a5,a4
   1ca8c:	0007c703          	lbu	a4,0(a5) # 10000 <main-0x74>
   1ca90:	02000a93          	li	s5,32
   1ca94:	00b70733          	add	a4,a4,a1
   1ca98:	40ea8ab3          	sub	s5,s5,a4
   1ca9c:	020a9663          	bnez	s5,1cac8 <__udivdi3+0x43c>
   1caa0:	00100413          	li	s0,1
   1caa4:	e976e0e3          	bltu	a3,s7,1c924 <__udivdi3+0x298>
   1caa8:	00cb3633          	sltu	a2,s6,a2
   1caac:	00164413          	xori	s0,a2,1
   1cab0:	e75ff06f          	j	1c924 <__udivdi3+0x298>
   1cab4:	010007b7          	lui	a5,0x1000
   1cab8:	01000593          	li	a1,16
   1cabc:	fcf6e0e3          	bltu	a3,a5,1ca7c <__udivdi3+0x3f0>
   1cac0:	01800593          	li	a1,24
   1cac4:	fb9ff06f          	j	1ca7c <__udivdi3+0x3f0>
   1cac8:	00e65cb3          	srl	s9,a2,a4
   1cacc:	015696b3          	sll	a3,a3,s5
   1cad0:	00dcecb3          	or	s9,s9,a3
   1cad4:	00ebd4b3          	srl	s1,s7,a4
   1cad8:	015b97b3          	sll	a5,s7,s5
   1cadc:	010cdb93          	srli	s7,s9,0x10
   1cae0:	00eb5733          	srl	a4,s6,a4
   1cae4:	000b8593          	mv	a1,s7
   1cae8:	00048513          	mv	a0,s1
   1caec:	00f76433          	or	s0,a4,a5
   1caf0:	015619b3          	sll	s3,a2,s5
   1caf4:	32d040ef          	jal	ra,21620 <__umodsi3>
   1caf8:	00050913          	mv	s2,a0
   1cafc:	000b8593          	mv	a1,s7
   1cb00:	00048513          	mv	a0,s1
   1cb04:	010c9c13          	slli	s8,s9,0x10
   1cb08:	2d1040ef          	jal	ra,215d8 <__udivsi3>
   1cb0c:	010c5c13          	srli	s8,s8,0x10
   1cb10:	00050493          	mv	s1,a0
   1cb14:	00050593          	mv	a1,a0
   1cb18:	000c0513          	mv	a0,s8
   1cb1c:	291040ef          	jal	ra,215ac <__mulsi3>
   1cb20:	01091913          	slli	s2,s2,0x10
   1cb24:	01045713          	srli	a4,s0,0x10
   1cb28:	00e96733          	or	a4,s2,a4
   1cb2c:	00048a13          	mv	s4,s1
   1cb30:	00a77e63          	bleu	a0,a4,1cb4c <__udivdi3+0x4c0>
   1cb34:	01970733          	add	a4,a4,s9
   1cb38:	fff48a13          	addi	s4,s1,-1
   1cb3c:	01976863          	bltu	a4,s9,1cb4c <__udivdi3+0x4c0>
   1cb40:	00a77663          	bleu	a0,a4,1cb4c <__udivdi3+0x4c0>
   1cb44:	ffe48a13          	addi	s4,s1,-2
   1cb48:	01970733          	add	a4,a4,s9
   1cb4c:	40a704b3          	sub	s1,a4,a0
   1cb50:	000b8593          	mv	a1,s7
   1cb54:	00048513          	mv	a0,s1
   1cb58:	2c9040ef          	jal	ra,21620 <__umodsi3>
   1cb5c:	00050913          	mv	s2,a0
   1cb60:	000b8593          	mv	a1,s7
   1cb64:	00048513          	mv	a0,s1
   1cb68:	271040ef          	jal	ra,215d8 <__udivsi3>
   1cb6c:	00050493          	mv	s1,a0
   1cb70:	00050593          	mv	a1,a0
   1cb74:	000c0513          	mv	a0,s8
   1cb78:	235040ef          	jal	ra,215ac <__mulsi3>
   1cb7c:	01041793          	slli	a5,s0,0x10
   1cb80:	01091913          	slli	s2,s2,0x10
   1cb84:	0107d793          	srli	a5,a5,0x10
   1cb88:	00f967b3          	or	a5,s2,a5
   1cb8c:	00048613          	mv	a2,s1
   1cb90:	00a7fe63          	bleu	a0,a5,1cbac <__udivdi3+0x520>
   1cb94:	019787b3          	add	a5,a5,s9
   1cb98:	fff48613          	addi	a2,s1,-1
   1cb9c:	0197e863          	bltu	a5,s9,1cbac <__udivdi3+0x520>
   1cba0:	00a7f663          	bleu	a0,a5,1cbac <__udivdi3+0x520>
   1cba4:	ffe48613          	addi	a2,s1,-2
   1cba8:	019787b3          	add	a5,a5,s9
   1cbac:	010a1413          	slli	s0,s4,0x10
   1cbb0:	00010bb7          	lui	s7,0x10
   1cbb4:	00c46433          	or	s0,s0,a2
   1cbb8:	fffb8913          	addi	s2,s7,-1 # ffff <main-0x75>
   1cbbc:	01247d33          	and	s10,s0,s2
   1cbc0:	0129f933          	and	s2,s3,s2
   1cbc4:	40a784b3          	sub	s1,a5,a0
   1cbc8:	00090593          	mv	a1,s2
   1cbcc:	000d0513          	mv	a0,s10
   1cbd0:	1dd040ef          	jal	ra,215ac <__mulsi3>
   1cbd4:	01045c93          	srli	s9,s0,0x10
   1cbd8:	00090593          	mv	a1,s2
   1cbdc:	00050a13          	mv	s4,a0
   1cbe0:	000c8513          	mv	a0,s9
   1cbe4:	1c9040ef          	jal	ra,215ac <__mulsi3>
   1cbe8:	0109d993          	srli	s3,s3,0x10
   1cbec:	00050c13          	mv	s8,a0
   1cbf0:	00098593          	mv	a1,s3
   1cbf4:	000c8513          	mv	a0,s9
   1cbf8:	1b5040ef          	jal	ra,215ac <__mulsi3>
   1cbfc:	00050913          	mv	s2,a0
   1cc00:	00098593          	mv	a1,s3
   1cc04:	000d0513          	mv	a0,s10
   1cc08:	1a5040ef          	jal	ra,215ac <__mulsi3>
   1cc0c:	01850533          	add	a0,a0,s8
   1cc10:	010a5793          	srli	a5,s4,0x10
   1cc14:	00a78533          	add	a0,a5,a0
   1cc18:	01857463          	bleu	s8,a0,1cc20 <__udivdi3+0x594>
   1cc1c:	01790933          	add	s2,s2,s7
   1cc20:	01055793          	srli	a5,a0,0x10
   1cc24:	012787b3          	add	a5,a5,s2
   1cc28:	02f4e663          	bltu	s1,a5,1cc54 <__udivdi3+0x5c8>
   1cc2c:	bcf492e3          	bne	s1,a5,1c7f0 <__udivdi3+0x164>
   1cc30:	000107b7          	lui	a5,0x10
   1cc34:	fff78793          	addi	a5,a5,-1 # ffff <main-0x75>
   1cc38:	00f57533          	and	a0,a0,a5
   1cc3c:	01051513          	slli	a0,a0,0x10
   1cc40:	00fa7a33          	and	s4,s4,a5
   1cc44:	015b1633          	sll	a2,s6,s5
   1cc48:	01450533          	add	a0,a0,s4
   1cc4c:	00000a93          	li	s5,0
   1cc50:	cca67ae3          	bleu	a0,a2,1c924 <__udivdi3+0x298>
   1cc54:	fff40413          	addi	s0,s0,-1
   1cc58:	b99ff06f          	j	1c7f0 <__udivdi3+0x164>
   1cc5c:	00000a93          	li	s5,0
   1cc60:	00000413          	li	s0,0
   1cc64:	cc1ff06f          	j	1c924 <__udivdi3+0x298>

0001cc68 <__umoddi3>:
   1cc68:	fb010113          	addi	sp,sp,-80
   1cc6c:	04812423          	sw	s0,72(sp)
   1cc70:	04912223          	sw	s1,68(sp)
   1cc74:	03312e23          	sw	s3,60(sp)
   1cc78:	03912223          	sw	s9,36(sp)
   1cc7c:	04112623          	sw	ra,76(sp)
   1cc80:	05212023          	sw	s2,64(sp)
   1cc84:	03412c23          	sw	s4,56(sp)
   1cc88:	03512a23          	sw	s5,52(sp)
   1cc8c:	03612823          	sw	s6,48(sp)
   1cc90:	03712623          	sw	s7,44(sp)
   1cc94:	03812423          	sw	s8,40(sp)
   1cc98:	03a12023          	sw	s10,32(sp)
   1cc9c:	01b12e23          	sw	s11,28(sp)
   1cca0:	00050c93          	mv	s9,a0
   1cca4:	00058993          	mv	s3,a1
   1cca8:	00050413          	mv	s0,a0
   1ccac:	00058493          	mv	s1,a1
   1ccb0:	26069e63          	bnez	a3,1cf2c <__umoddi3+0x2c4>
   1ccb4:	00022ab7          	lui	s5,0x22
   1ccb8:	00060913          	mv	s2,a2
   1ccbc:	00068a13          	mv	s4,a3
   1ccc0:	34ca8a93          	addi	s5,s5,844 # 2234c <__clz_tab>
   1ccc4:	14c5f463          	bleu	a2,a1,1ce0c <__umoddi3+0x1a4>
   1ccc8:	000107b7          	lui	a5,0x10
   1cccc:	12f67663          	bleu	a5,a2,1cdf8 <__umoddi3+0x190>
   1ccd0:	0ff00793          	li	a5,255
   1ccd4:	00c7f463          	bleu	a2,a5,1ccdc <__umoddi3+0x74>
   1ccd8:	00800a13          	li	s4,8
   1ccdc:	014657b3          	srl	a5,a2,s4
   1cce0:	00fa8ab3          	add	s5,s5,a5
   1cce4:	000ac703          	lbu	a4,0(s5)
   1cce8:	02000513          	li	a0,32
   1ccec:	01470733          	add	a4,a4,s4
   1ccf0:	40e50a33          	sub	s4,a0,a4
   1ccf4:	000a0c63          	beqz	s4,1cd0c <__umoddi3+0xa4>
   1ccf8:	014995b3          	sll	a1,s3,s4
   1ccfc:	00ecd733          	srl	a4,s9,a4
   1cd00:	01461933          	sll	s2,a2,s4
   1cd04:	00b764b3          	or	s1,a4,a1
   1cd08:	014c9433          	sll	s0,s9,s4
   1cd0c:	01095a93          	srli	s5,s2,0x10
   1cd10:	000a8593          	mv	a1,s5
   1cd14:	00048513          	mv	a0,s1
   1cd18:	109040ef          	jal	ra,21620 <__umodsi3>
   1cd1c:	00050993          	mv	s3,a0
   1cd20:	000a8593          	mv	a1,s5
   1cd24:	01091b13          	slli	s6,s2,0x10
   1cd28:	00048513          	mv	a0,s1
   1cd2c:	0ad040ef          	jal	ra,215d8 <__udivsi3>
   1cd30:	010b5b13          	srli	s6,s6,0x10
   1cd34:	00050593          	mv	a1,a0
   1cd38:	000b0513          	mv	a0,s6
   1cd3c:	071040ef          	jal	ra,215ac <__mulsi3>
   1cd40:	01099993          	slli	s3,s3,0x10
   1cd44:	01045793          	srli	a5,s0,0x10
   1cd48:	00f9e7b3          	or	a5,s3,a5
   1cd4c:	00a7fa63          	bleu	a0,a5,1cd60 <__umoddi3+0xf8>
   1cd50:	012787b3          	add	a5,a5,s2
   1cd54:	0127e663          	bltu	a5,s2,1cd60 <__umoddi3+0xf8>
   1cd58:	00a7f463          	bleu	a0,a5,1cd60 <__umoddi3+0xf8>
   1cd5c:	012787b3          	add	a5,a5,s2
   1cd60:	40a784b3          	sub	s1,a5,a0
   1cd64:	000a8593          	mv	a1,s5
   1cd68:	00048513          	mv	a0,s1
   1cd6c:	0b5040ef          	jal	ra,21620 <__umodsi3>
   1cd70:	00050993          	mv	s3,a0
   1cd74:	000a8593          	mv	a1,s5
   1cd78:	00048513          	mv	a0,s1
   1cd7c:	05d040ef          	jal	ra,215d8 <__udivsi3>
   1cd80:	01041413          	slli	s0,s0,0x10
   1cd84:	00050593          	mv	a1,a0
   1cd88:	01099993          	slli	s3,s3,0x10
   1cd8c:	000b0513          	mv	a0,s6
   1cd90:	01045413          	srli	s0,s0,0x10
   1cd94:	019040ef          	jal	ra,215ac <__mulsi3>
   1cd98:	0089e433          	or	s0,s3,s0
   1cd9c:	00a47a63          	bleu	a0,s0,1cdb0 <__umoddi3+0x148>
   1cda0:	01240433          	add	s0,s0,s2
   1cda4:	01246663          	bltu	s0,s2,1cdb0 <__umoddi3+0x148>
   1cda8:	00a47463          	bleu	a0,s0,1cdb0 <__umoddi3+0x148>
   1cdac:	01240433          	add	s0,s0,s2
   1cdb0:	40a40433          	sub	s0,s0,a0
   1cdb4:	01445533          	srl	a0,s0,s4
   1cdb8:	00000593          	li	a1,0
   1cdbc:	04c12083          	lw	ra,76(sp)
   1cdc0:	04812403          	lw	s0,72(sp)
   1cdc4:	04412483          	lw	s1,68(sp)
   1cdc8:	04012903          	lw	s2,64(sp)
   1cdcc:	03c12983          	lw	s3,60(sp)
   1cdd0:	03812a03          	lw	s4,56(sp)
   1cdd4:	03412a83          	lw	s5,52(sp)
   1cdd8:	03012b03          	lw	s6,48(sp)
   1cddc:	02c12b83          	lw	s7,44(sp)
   1cde0:	02812c03          	lw	s8,40(sp)
   1cde4:	02412c83          	lw	s9,36(sp)
   1cde8:	02012d03          	lw	s10,32(sp)
   1cdec:	01c12d83          	lw	s11,28(sp)
   1cdf0:	05010113          	addi	sp,sp,80
   1cdf4:	00008067          	ret
   1cdf8:	010007b7          	lui	a5,0x1000
   1cdfc:	01000a13          	li	s4,16
   1ce00:	ecf66ee3          	bltu	a2,a5,1ccdc <__umoddi3+0x74>
   1ce04:	01800a13          	li	s4,24
   1ce08:	ed5ff06f          	j	1ccdc <__umoddi3+0x74>
   1ce0c:	00061a63          	bnez	a2,1ce20 <__umoddi3+0x1b8>
   1ce10:	00000593          	li	a1,0
   1ce14:	00100513          	li	a0,1
   1ce18:	7c0040ef          	jal	ra,215d8 <__udivsi3>
   1ce1c:	00050913          	mv	s2,a0
   1ce20:	000107b7          	lui	a5,0x10
   1ce24:	0ef97a63          	bleu	a5,s2,1cf18 <__umoddi3+0x2b0>
   1ce28:	0ff00793          	li	a5,255
   1ce2c:	0127f463          	bleu	s2,a5,1ce34 <__umoddi3+0x1cc>
   1ce30:	00800a13          	li	s4,8
   1ce34:	014957b3          	srl	a5,s2,s4
   1ce38:	00fa8ab3          	add	s5,s5,a5
   1ce3c:	000ac703          	lbu	a4,0(s5)
   1ce40:	02000513          	li	a0,32
   1ce44:	412984b3          	sub	s1,s3,s2
   1ce48:	01470733          	add	a4,a4,s4
   1ce4c:	40e50a33          	sub	s4,a0,a4
   1ce50:	ea0a0ee3          	beqz	s4,1cd0c <__umoddi3+0xa4>
   1ce54:	01491933          	sll	s2,s2,s4
   1ce58:	00e9dab3          	srl	s5,s3,a4
   1ce5c:	014995b3          	sll	a1,s3,s4
   1ce60:	00ecd733          	srl	a4,s9,a4
   1ce64:	01095493          	srli	s1,s2,0x10
   1ce68:	00b76b33          	or	s6,a4,a1
   1ce6c:	000a8513          	mv	a0,s5
   1ce70:	00048593          	mv	a1,s1
   1ce74:	7ac040ef          	jal	ra,21620 <__umodsi3>
   1ce78:	00050993          	mv	s3,a0
   1ce7c:	00048593          	mv	a1,s1
   1ce80:	01091b93          	slli	s7,s2,0x10
   1ce84:	000a8513          	mv	a0,s5
   1ce88:	750040ef          	jal	ra,215d8 <__udivsi3>
   1ce8c:	010bdb93          	srli	s7,s7,0x10
   1ce90:	00050593          	mv	a1,a0
   1ce94:	000b8513          	mv	a0,s7
   1ce98:	714040ef          	jal	ra,215ac <__mulsi3>
   1ce9c:	01099993          	slli	s3,s3,0x10
   1cea0:	010b5793          	srli	a5,s6,0x10
   1cea4:	00f9e7b3          	or	a5,s3,a5
   1cea8:	014c9433          	sll	s0,s9,s4
   1ceac:	00a7fa63          	bleu	a0,a5,1cec0 <__umoddi3+0x258>
   1ceb0:	012787b3          	add	a5,a5,s2
   1ceb4:	0127e663          	bltu	a5,s2,1cec0 <__umoddi3+0x258>
   1ceb8:	00a7f463          	bleu	a0,a5,1cec0 <__umoddi3+0x258>
   1cebc:	012787b3          	add	a5,a5,s2
   1cec0:	40a78ab3          	sub	s5,a5,a0
   1cec4:	00048593          	mv	a1,s1
   1cec8:	000a8513          	mv	a0,s5
   1cecc:	754040ef          	jal	ra,21620 <__umodsi3>
   1ced0:	00050993          	mv	s3,a0
   1ced4:	00048593          	mv	a1,s1
   1ced8:	000a8513          	mv	a0,s5
   1cedc:	6fc040ef          	jal	ra,215d8 <__udivsi3>
   1cee0:	00050593          	mv	a1,a0
   1cee4:	000b8513          	mv	a0,s7
   1cee8:	6c4040ef          	jal	ra,215ac <__mulsi3>
   1ceec:	010b1593          	slli	a1,s6,0x10
   1cef0:	01099993          	slli	s3,s3,0x10
   1cef4:	0105d593          	srli	a1,a1,0x10
   1cef8:	00b9e5b3          	or	a1,s3,a1
   1cefc:	00a5fa63          	bleu	a0,a1,1cf10 <__umoddi3+0x2a8>
   1cf00:	012585b3          	add	a1,a1,s2
   1cf04:	0125e663          	bltu	a1,s2,1cf10 <__umoddi3+0x2a8>
   1cf08:	00a5f463          	bleu	a0,a1,1cf10 <__umoddi3+0x2a8>
   1cf0c:	012585b3          	add	a1,a1,s2
   1cf10:	40a584b3          	sub	s1,a1,a0
   1cf14:	df9ff06f          	j	1cd0c <__umoddi3+0xa4>
   1cf18:	010007b7          	lui	a5,0x1000
   1cf1c:	01000a13          	li	s4,16
   1cf20:	f0f96ae3          	bltu	s2,a5,1ce34 <__umoddi3+0x1cc>
   1cf24:	01800a13          	li	s4,24
   1cf28:	f0dff06f          	j	1ce34 <__umoddi3+0x1cc>
   1cf2c:	e8d5e8e3          	bltu	a1,a3,1cdbc <__umoddi3+0x154>
   1cf30:	000107b7          	lui	a5,0x10
   1cf34:	04f6fc63          	bleu	a5,a3,1cf8c <__umoddi3+0x324>
   1cf38:	0ff00b93          	li	s7,255
   1cf3c:	00dbb533          	sltu	a0,s7,a3
   1cf40:	00351513          	slli	a0,a0,0x3
   1cf44:	00022737          	lui	a4,0x22
   1cf48:	00a6d7b3          	srl	a5,a3,a0
   1cf4c:	34c70713          	addi	a4,a4,844 # 2234c <__clz_tab>
   1cf50:	00e787b3          	add	a5,a5,a4
   1cf54:	0007cb83          	lbu	s7,0(a5) # 10000 <main-0x74>
   1cf58:	02000593          	li	a1,32
   1cf5c:	00ab8bb3          	add	s7,s7,a0
   1cf60:	41758b33          	sub	s6,a1,s7
   1cf64:	020b1e63          	bnez	s6,1cfa0 <__umoddi3+0x338>
   1cf68:	0136e463          	bltu	a3,s3,1cf70 <__umoddi3+0x308>
   1cf6c:	00ccea63          	bltu	s9,a2,1cf80 <__umoddi3+0x318>
   1cf70:	40cc8433          	sub	s0,s9,a2
   1cf74:	40d986b3          	sub	a3,s3,a3
   1cf78:	008cb533          	sltu	a0,s9,s0
   1cf7c:	40a684b3          	sub	s1,a3,a0
   1cf80:	00040513          	mv	a0,s0
   1cf84:	00048593          	mv	a1,s1
   1cf88:	e35ff06f          	j	1cdbc <__umoddi3+0x154>
   1cf8c:	010007b7          	lui	a5,0x1000
   1cf90:	01000513          	li	a0,16
   1cf94:	faf6e8e3          	bltu	a3,a5,1cf44 <__umoddi3+0x2dc>
   1cf98:	01800513          	li	a0,24
   1cf9c:	fa9ff06f          	j	1cf44 <__umoddi3+0x2dc>
   1cfa0:	016696b3          	sll	a3,a3,s6
   1cfa4:	01765d33          	srl	s10,a2,s7
   1cfa8:	00dd6d33          	or	s10,s10,a3
   1cfac:	0179d433          	srl	s0,s3,s7
   1cfb0:	016995b3          	sll	a1,s3,s6
   1cfb4:	017cdc33          	srl	s8,s9,s7
   1cfb8:	010d5493          	srli	s1,s10,0x10
   1cfbc:	00bc6c33          	or	s8,s8,a1
   1cfc0:	00040513          	mv	a0,s0
   1cfc4:	00048593          	mv	a1,s1
   1cfc8:	01661ab3          	sll	s5,a2,s6
   1cfcc:	654040ef          	jal	ra,21620 <__umodsi3>
   1cfd0:	00050a13          	mv	s4,a0
   1cfd4:	00048593          	mv	a1,s1
   1cfd8:	00040513          	mv	a0,s0
   1cfdc:	016c9933          	sll	s2,s9,s6
   1cfe0:	010d1c93          	slli	s9,s10,0x10
   1cfe4:	5f4040ef          	jal	ra,215d8 <__udivsi3>
   1cfe8:	010cdc93          	srli	s9,s9,0x10
   1cfec:	00050413          	mv	s0,a0
   1cff0:	00050593          	mv	a1,a0
   1cff4:	000c8513          	mv	a0,s9
   1cff8:	5b4040ef          	jal	ra,215ac <__mulsi3>
   1cffc:	010a1a13          	slli	s4,s4,0x10
   1d000:	010c5713          	srli	a4,s8,0x10
   1d004:	00ea6733          	or	a4,s4,a4
   1d008:	00040a13          	mv	s4,s0
   1d00c:	00a77e63          	bleu	a0,a4,1d028 <__umoddi3+0x3c0>
   1d010:	01a70733          	add	a4,a4,s10
   1d014:	fff40a13          	addi	s4,s0,-1
   1d018:	01a76863          	bltu	a4,s10,1d028 <__umoddi3+0x3c0>
   1d01c:	00a77663          	bleu	a0,a4,1d028 <__umoddi3+0x3c0>
   1d020:	ffe40a13          	addi	s4,s0,-2
   1d024:	01a70733          	add	a4,a4,s10
   1d028:	40a709b3          	sub	s3,a4,a0
   1d02c:	00048593          	mv	a1,s1
   1d030:	00098513          	mv	a0,s3
   1d034:	5ec040ef          	jal	ra,21620 <__umodsi3>
   1d038:	00048593          	mv	a1,s1
   1d03c:	00050413          	mv	s0,a0
   1d040:	00098513          	mv	a0,s3
   1d044:	594040ef          	jal	ra,215d8 <__udivsi3>
   1d048:	00050593          	mv	a1,a0
   1d04c:	00050493          	mv	s1,a0
   1d050:	000c8513          	mv	a0,s9
   1d054:	558040ef          	jal	ra,215ac <__mulsi3>
   1d058:	010c1593          	slli	a1,s8,0x10
   1d05c:	01041413          	slli	s0,s0,0x10
   1d060:	0105d593          	srli	a1,a1,0x10
   1d064:	00b465b3          	or	a1,s0,a1
   1d068:	00048713          	mv	a4,s1
   1d06c:	00a5fe63          	bleu	a0,a1,1d088 <__umoddi3+0x420>
   1d070:	01a585b3          	add	a1,a1,s10
   1d074:	fff48713          	addi	a4,s1,-1
   1d078:	01a5e863          	bltu	a1,s10,1d088 <__umoddi3+0x420>
   1d07c:	00a5f663          	bleu	a0,a1,1d088 <__umoddi3+0x420>
   1d080:	ffe48713          	addi	a4,s1,-2
   1d084:	01a585b3          	add	a1,a1,s10
   1d088:	010a1a13          	slli	s4,s4,0x10
   1d08c:	00010cb7          	lui	s9,0x10
   1d090:	00ea6a33          	or	s4,s4,a4
   1d094:	fffc8413          	addi	s0,s9,-1 # ffff <main-0x75>
   1d098:	008a77b3          	and	a5,s4,s0
   1d09c:	008af433          	and	s0,s5,s0
   1d0a0:	40a584b3          	sub	s1,a1,a0
   1d0a4:	00078513          	mv	a0,a5
   1d0a8:	00040593          	mv	a1,s0
   1d0ac:	00f12623          	sw	a5,12(sp)
   1d0b0:	010a5a13          	srli	s4,s4,0x10
   1d0b4:	4f8040ef          	jal	ra,215ac <__mulsi3>
   1d0b8:	00050993          	mv	s3,a0
   1d0bc:	00040593          	mv	a1,s0
   1d0c0:	000a0513          	mv	a0,s4
   1d0c4:	4e8040ef          	jal	ra,215ac <__mulsi3>
   1d0c8:	010adc13          	srli	s8,s5,0x10
   1d0cc:	00050d93          	mv	s11,a0
   1d0d0:	000c0593          	mv	a1,s8
   1d0d4:	000a0513          	mv	a0,s4
   1d0d8:	4d4040ef          	jal	ra,215ac <__mulsi3>
   1d0dc:	00c12783          	lw	a5,12(sp)
   1d0e0:	00050a13          	mv	s4,a0
   1d0e4:	000c0593          	mv	a1,s8
   1d0e8:	00078513          	mv	a0,a5
   1d0ec:	4c0040ef          	jal	ra,215ac <__mulsi3>
   1d0f0:	01b50533          	add	a0,a0,s11
   1d0f4:	0109d713          	srli	a4,s3,0x10
   1d0f8:	00a70733          	add	a4,a4,a0
   1d0fc:	01b77463          	bleu	s11,a4,1d104 <__umoddi3+0x49c>
   1d100:	019a0a33          	add	s4,s4,s9
   1d104:	000107b7          	lui	a5,0x10
   1d108:	fff78793          	addi	a5,a5,-1 # ffff <main-0x75>
   1d10c:	01075593          	srli	a1,a4,0x10
   1d110:	00f77733          	and	a4,a4,a5
   1d114:	01071713          	slli	a4,a4,0x10
   1d118:	00f9f7b3          	and	a5,s3,a5
   1d11c:	014585b3          	add	a1,a1,s4
   1d120:	00f707b3          	add	a5,a4,a5
   1d124:	00b4e663          	bltu	s1,a1,1d130 <__umoddi3+0x4c8>
   1d128:	00b49e63          	bne	s1,a1,1d144 <__umoddi3+0x4dc>
   1d12c:	00f97c63          	bleu	a5,s2,1d144 <__umoddi3+0x4dc>
   1d130:	41578633          	sub	a2,a5,s5
   1d134:	00c7b7b3          	sltu	a5,a5,a2
   1d138:	41a585b3          	sub	a1,a1,s10
   1d13c:	40f585b3          	sub	a1,a1,a5
   1d140:	00060793          	mv	a5,a2
   1d144:	40f907b3          	sub	a5,s2,a5
   1d148:	00f93933          	sltu	s2,s2,a5
   1d14c:	40b485b3          	sub	a1,s1,a1
   1d150:	412585b3          	sub	a1,a1,s2
   1d154:	01759433          	sll	s0,a1,s7
   1d158:	0167d7b3          	srl	a5,a5,s6
   1d15c:	00f46533          	or	a0,s0,a5
   1d160:	0165d5b3          	srl	a1,a1,s6
   1d164:	c59ff06f          	j	1cdbc <__umoddi3+0x154>

0001d168 <__divdf3>:
   1d168:	fb010113          	addi	sp,sp,-80
   1d16c:	04812423          	sw	s0,72(sp)
   1d170:	03412c23          	sw	s4,56(sp)
   1d174:	00100437          	lui	s0,0x100
   1d178:	0145da13          	srli	s4,a1,0x14
   1d17c:	05212023          	sw	s2,64(sp)
   1d180:	03312e23          	sw	s3,60(sp)
   1d184:	03512a23          	sw	s5,52(sp)
   1d188:	03812423          	sw	s8,40(sp)
   1d18c:	fff40413          	addi	s0,s0,-1 # fffff <__global_pointer$+0xdb89f>
   1d190:	04112623          	sw	ra,76(sp)
   1d194:	04912223          	sw	s1,68(sp)
   1d198:	03612823          	sw	s6,48(sp)
   1d19c:	03712623          	sw	s7,44(sp)
   1d1a0:	03912223          	sw	s9,36(sp)
   1d1a4:	03a12023          	sw	s10,32(sp)
   1d1a8:	01b12e23          	sw	s11,28(sp)
   1d1ac:	7ffa7a13          	andi	s4,s4,2047
   1d1b0:	00050913          	mv	s2,a0
   1d1b4:	00060c13          	mv	s8,a2
   1d1b8:	00068a93          	mv	s5,a3
   1d1bc:	00b47433          	and	s0,s0,a1
   1d1c0:	01f5d993          	srli	s3,a1,0x1f
   1d1c4:	0a0a0463          	beqz	s4,1d26c <__divdf3+0x104>
   1d1c8:	7ff00793          	li	a5,2047
   1d1cc:	10fa0263          	beq	s4,a5,1d2d0 <__divdf3+0x168>
   1d1d0:	00341413          	slli	s0,s0,0x3
   1d1d4:	008007b7          	lui	a5,0x800
   1d1d8:	00f46433          	or	s0,s0,a5
   1d1dc:	01d55b13          	srli	s6,a0,0x1d
   1d1e0:	008b6b33          	or	s6,s6,s0
   1d1e4:	00351493          	slli	s1,a0,0x3
   1d1e8:	c01a0a13          	addi	s4,s4,-1023
   1d1ec:	00000b93          	li	s7,0
   1d1f0:	014ad513          	srli	a0,s5,0x14
   1d1f4:	00100937          	lui	s2,0x100
   1d1f8:	fff90913          	addi	s2,s2,-1 # fffff <__global_pointer$+0xdb89f>
   1d1fc:	7ff57513          	andi	a0,a0,2047
   1d200:	01597933          	and	s2,s2,s5
   1d204:	000c0593          	mv	a1,s8
   1d208:	01fada93          	srli	s5,s5,0x1f
   1d20c:	10050063          	beqz	a0,1d30c <__divdf3+0x1a4>
   1d210:	7ff00793          	li	a5,2047
   1d214:	16f50063          	beq	a0,a5,1d374 <__divdf3+0x20c>
   1d218:	00800437          	lui	s0,0x800
   1d21c:	00391913          	slli	s2,s2,0x3
   1d220:	00896933          	or	s2,s2,s0
   1d224:	01dc5413          	srli	s0,s8,0x1d
   1d228:	01246433          	or	s0,s0,s2
   1d22c:	003c1593          	slli	a1,s8,0x3
   1d230:	c0150513          	addi	a0,a0,-1023
   1d234:	00000793          	li	a5,0
   1d238:	002b9713          	slli	a4,s7,0x2
   1d23c:	00f76733          	or	a4,a4,a5
   1d240:	fff70713          	addi	a4,a4,-1
   1d244:	00e00693          	li	a3,14
   1d248:	0159c933          	xor	s2,s3,s5
   1d24c:	40aa0a33          	sub	s4,s4,a0
   1d250:	14e6ee63          	bltu	a3,a4,1d3ac <__divdf3+0x244>
   1d254:	000226b7          	lui	a3,0x22
   1d258:	00271713          	slli	a4,a4,0x2
   1d25c:	29868693          	addi	a3,a3,664 # 22298 <zeroes.4339+0x10>
   1d260:	00d70733          	add	a4,a4,a3
   1d264:	00072703          	lw	a4,0(a4)
   1d268:	00070067          	jr	a4
   1d26c:	00a46b33          	or	s6,s0,a0
   1d270:	060b0e63          	beqz	s6,1d2ec <__divdf3+0x184>
   1d274:	04040063          	beqz	s0,1d2b4 <__divdf3+0x14c>
   1d278:	00040513          	mv	a0,s0
   1d27c:	408040ef          	jal	ra,21684 <__clzsi2>
   1d280:	ff550793          	addi	a5,a0,-11
   1d284:	01c00713          	li	a4,28
   1d288:	02f74c63          	blt	a4,a5,1d2c0 <__divdf3+0x158>
   1d28c:	01d00b13          	li	s6,29
   1d290:	ff850493          	addi	s1,a0,-8
   1d294:	40fb0b33          	sub	s6,s6,a5
   1d298:	00941433          	sll	s0,s0,s1
   1d29c:	01695b33          	srl	s6,s2,s6
   1d2a0:	008b6b33          	or	s6,s6,s0
   1d2a4:	009914b3          	sll	s1,s2,s1
   1d2a8:	c0d00a13          	li	s4,-1011
   1d2ac:	40aa0a33          	sub	s4,s4,a0
   1d2b0:	f3dff06f          	j	1d1ec <__divdf3+0x84>
   1d2b4:	3d0040ef          	jal	ra,21684 <__clzsi2>
   1d2b8:	02050513          	addi	a0,a0,32
   1d2bc:	fc5ff06f          	j	1d280 <__divdf3+0x118>
   1d2c0:	fd850413          	addi	s0,a0,-40
   1d2c4:	00891b33          	sll	s6,s2,s0
   1d2c8:	00000493          	li	s1,0
   1d2cc:	fddff06f          	j	1d2a8 <__divdf3+0x140>
   1d2d0:	00a46b33          	or	s6,s0,a0
   1d2d4:	020b0463          	beqz	s6,1d2fc <__divdf3+0x194>
   1d2d8:	00050493          	mv	s1,a0
   1d2dc:	00040b13          	mv	s6,s0
   1d2e0:	7ff00a13          	li	s4,2047
   1d2e4:	00300b93          	li	s7,3
   1d2e8:	f09ff06f          	j	1d1f0 <__divdf3+0x88>
   1d2ec:	00000493          	li	s1,0
   1d2f0:	00000a13          	li	s4,0
   1d2f4:	00100b93          	li	s7,1
   1d2f8:	ef9ff06f          	j	1d1f0 <__divdf3+0x88>
   1d2fc:	00000493          	li	s1,0
   1d300:	7ff00a13          	li	s4,2047
   1d304:	00200b93          	li	s7,2
   1d308:	ee9ff06f          	j	1d1f0 <__divdf3+0x88>
   1d30c:	01896433          	or	s0,s2,s8
   1d310:	06040e63          	beqz	s0,1d38c <__divdf3+0x224>
   1d314:	04090063          	beqz	s2,1d354 <__divdf3+0x1ec>
   1d318:	00090513          	mv	a0,s2
   1d31c:	368040ef          	jal	ra,21684 <__clzsi2>
   1d320:	ff550793          	addi	a5,a0,-11
   1d324:	01c00713          	li	a4,28
   1d328:	02f74e63          	blt	a4,a5,1d364 <__divdf3+0x1fc>
   1d32c:	01d00413          	li	s0,29
   1d330:	ff850593          	addi	a1,a0,-8
   1d334:	40f40433          	sub	s0,s0,a5
   1d338:	00b91933          	sll	s2,s2,a1
   1d33c:	008c5433          	srl	s0,s8,s0
   1d340:	01246433          	or	s0,s0,s2
   1d344:	00bc15b3          	sll	a1,s8,a1
   1d348:	c0d00713          	li	a4,-1011
   1d34c:	40a70533          	sub	a0,a4,a0
   1d350:	ee5ff06f          	j	1d234 <__divdf3+0xcc>
   1d354:	000c0513          	mv	a0,s8
   1d358:	32c040ef          	jal	ra,21684 <__clzsi2>
   1d35c:	02050513          	addi	a0,a0,32
   1d360:	fc1ff06f          	j	1d320 <__divdf3+0x1b8>
   1d364:	fd850413          	addi	s0,a0,-40
   1d368:	008c1433          	sll	s0,s8,s0
   1d36c:	00000593          	li	a1,0
   1d370:	fd9ff06f          	j	1d348 <__divdf3+0x1e0>
   1d374:	01896433          	or	s0,s2,s8
   1d378:	02040263          	beqz	s0,1d39c <__divdf3+0x234>
   1d37c:	00090413          	mv	s0,s2
   1d380:	7ff00513          	li	a0,2047
   1d384:	00300793          	li	a5,3
   1d388:	eb1ff06f          	j	1d238 <__divdf3+0xd0>
   1d38c:	00000593          	li	a1,0
   1d390:	00000513          	li	a0,0
   1d394:	00100793          	li	a5,1
   1d398:	ea1ff06f          	j	1d238 <__divdf3+0xd0>
   1d39c:	00000593          	li	a1,0
   1d3a0:	7ff00513          	li	a0,2047
   1d3a4:	00200793          	li	a5,2
   1d3a8:	e91ff06f          	j	1d238 <__divdf3+0xd0>
   1d3ac:	01646663          	bltu	s0,s6,1d3b8 <__divdf3+0x250>
   1d3b0:	488b1263          	bne	s6,s0,1d834 <__divdf3+0x6cc>
   1d3b4:	48b4e063          	bltu	s1,a1,1d834 <__divdf3+0x6cc>
   1d3b8:	01fb1693          	slli	a3,s6,0x1f
   1d3bc:	0014d713          	srli	a4,s1,0x1
   1d3c0:	01f49c13          	slli	s8,s1,0x1f
   1d3c4:	001b5b13          	srli	s6,s6,0x1
   1d3c8:	00e6e4b3          	or	s1,a3,a4
   1d3cc:	00841413          	slli	s0,s0,0x8
   1d3d0:	0185dc93          	srli	s9,a1,0x18
   1d3d4:	008cecb3          	or	s9,s9,s0
   1d3d8:	010cda93          	srli	s5,s9,0x10
   1d3dc:	010c9793          	slli	a5,s9,0x10
   1d3e0:	0107d793          	srli	a5,a5,0x10
   1d3e4:	00859d13          	slli	s10,a1,0x8
   1d3e8:	000b0513          	mv	a0,s6
   1d3ec:	000a8593          	mv	a1,s5
   1d3f0:	00f12223          	sw	a5,4(sp)
   1d3f4:	1e4040ef          	jal	ra,215d8 <__udivsi3>
   1d3f8:	00050593          	mv	a1,a0
   1d3fc:	00050b93          	mv	s7,a0
   1d400:	010c9513          	slli	a0,s9,0x10
   1d404:	01055513          	srli	a0,a0,0x10
   1d408:	1a4040ef          	jal	ra,215ac <__mulsi3>
   1d40c:	00050413          	mv	s0,a0
   1d410:	000a8593          	mv	a1,s5
   1d414:	000b0513          	mv	a0,s6
   1d418:	208040ef          	jal	ra,21620 <__umodsi3>
   1d41c:	01051513          	slli	a0,a0,0x10
   1d420:	0104d713          	srli	a4,s1,0x10
   1d424:	00a76533          	or	a0,a4,a0
   1d428:	000b8993          	mv	s3,s7
   1d42c:	00857e63          	bleu	s0,a0,1d448 <__divdf3+0x2e0>
   1d430:	01950533          	add	a0,a0,s9
   1d434:	fffb8993          	addi	s3,s7,-1
   1d438:	01956863          	bltu	a0,s9,1d448 <__divdf3+0x2e0>
   1d43c:	00857663          	bleu	s0,a0,1d448 <__divdf3+0x2e0>
   1d440:	ffeb8993          	addi	s3,s7,-2
   1d444:	01950533          	add	a0,a0,s9
   1d448:	40850433          	sub	s0,a0,s0
   1d44c:	000a8593          	mv	a1,s5
   1d450:	00040513          	mv	a0,s0
   1d454:	184040ef          	jal	ra,215d8 <__udivsi3>
   1d458:	00050593          	mv	a1,a0
   1d45c:	00050b93          	mv	s7,a0
   1d460:	010c9513          	slli	a0,s9,0x10
   1d464:	01055513          	srli	a0,a0,0x10
   1d468:	144040ef          	jal	ra,215ac <__mulsi3>
   1d46c:	00050b13          	mv	s6,a0
   1d470:	000a8593          	mv	a1,s5
   1d474:	00040513          	mv	a0,s0
   1d478:	1a8040ef          	jal	ra,21620 <__umodsi3>
   1d47c:	01049d93          	slli	s11,s1,0x10
   1d480:	01051513          	slli	a0,a0,0x10
   1d484:	010ddd93          	srli	s11,s11,0x10
   1d488:	00adedb3          	or	s11,s11,a0
   1d48c:	000b8713          	mv	a4,s7
   1d490:	016dfe63          	bleu	s6,s11,1d4ac <__divdf3+0x344>
   1d494:	019d8db3          	add	s11,s11,s9
   1d498:	fffb8713          	addi	a4,s7,-1
   1d49c:	019de863          	bltu	s11,s9,1d4ac <__divdf3+0x344>
   1d4a0:	016df663          	bleu	s6,s11,1d4ac <__divdf3+0x344>
   1d4a4:	ffeb8713          	addi	a4,s7,-2
   1d4a8:	019d8db3          	add	s11,s11,s9
   1d4ac:	01099693          	slli	a3,s3,0x10
   1d4b0:	000104b7          	lui	s1,0x10
   1d4b4:	00e6e6b3          	or	a3,a3,a4
   1d4b8:	416d8db3          	sub	s11,s11,s6
   1d4bc:	fff48b13          	addi	s6,s1,-1 # ffff <main-0x75>
   1d4c0:	0166f733          	and	a4,a3,s6
   1d4c4:	016d7b33          	and	s6,s10,s6
   1d4c8:	00070513          	mv	a0,a4
   1d4cc:	000b0593          	mv	a1,s6
   1d4d0:	0106d413          	srli	s0,a3,0x10
   1d4d4:	00d12623          	sw	a3,12(sp)
   1d4d8:	00e12423          	sw	a4,8(sp)
   1d4dc:	0d0040ef          	jal	ra,215ac <__mulsi3>
   1d4e0:	00a12223          	sw	a0,4(sp)
   1d4e4:	000b0593          	mv	a1,s6
   1d4e8:	00040513          	mv	a0,s0
   1d4ec:	0c0040ef          	jal	ra,215ac <__mulsi3>
   1d4f0:	010d5b93          	srli	s7,s10,0x10
   1d4f4:	00050993          	mv	s3,a0
   1d4f8:	000b8593          	mv	a1,s7
   1d4fc:	00040513          	mv	a0,s0
   1d500:	0ac040ef          	jal	ra,215ac <__mulsi3>
   1d504:	00812703          	lw	a4,8(sp)
   1d508:	00050413          	mv	s0,a0
   1d50c:	000b8513          	mv	a0,s7
   1d510:	00070593          	mv	a1,a4
   1d514:	098040ef          	jal	ra,215ac <__mulsi3>
   1d518:	00412603          	lw	a2,4(sp)
   1d51c:	01350533          	add	a0,a0,s3
   1d520:	00c12683          	lw	a3,12(sp)
   1d524:	01065713          	srli	a4,a2,0x10
   1d528:	00a70733          	add	a4,a4,a0
   1d52c:	01377463          	bleu	s3,a4,1d534 <__divdf3+0x3cc>
   1d530:	00940433          	add	s0,s0,s1
   1d534:	00010537          	lui	a0,0x10
   1d538:	fff50513          	addi	a0,a0,-1 # ffff <main-0x75>
   1d53c:	01075493          	srli	s1,a4,0x10
   1d540:	00a779b3          	and	s3,a4,a0
   1d544:	01099993          	slli	s3,s3,0x10
   1d548:	00a67633          	and	a2,a2,a0
   1d54c:	008484b3          	add	s1,s1,s0
   1d550:	00c989b3          	add	s3,s3,a2
   1d554:	009de863          	bltu	s11,s1,1d564 <__divdf3+0x3fc>
   1d558:	00068413          	mv	s0,a3
   1d55c:	049d9463          	bne	s11,s1,1d5a4 <__divdf3+0x43c>
   1d560:	053c7263          	bleu	s3,s8,1d5a4 <__divdf3+0x43c>
   1d564:	01ac0c33          	add	s8,s8,s10
   1d568:	01ac3733          	sltu	a4,s8,s10
   1d56c:	01970733          	add	a4,a4,s9
   1d570:	00ed8db3          	add	s11,s11,a4
   1d574:	fff68413          	addi	s0,a3,-1
   1d578:	01bce663          	bltu	s9,s11,1d584 <__divdf3+0x41c>
   1d57c:	03bc9463          	bne	s9,s11,1d5a4 <__divdf3+0x43c>
   1d580:	03ac6263          	bltu	s8,s10,1d5a4 <__divdf3+0x43c>
   1d584:	009de663          	bltu	s11,s1,1d590 <__divdf3+0x428>
   1d588:	01b49e63          	bne	s1,s11,1d5a4 <__divdf3+0x43c>
   1d58c:	013c7c63          	bleu	s3,s8,1d5a4 <__divdf3+0x43c>
   1d590:	01ac0c33          	add	s8,s8,s10
   1d594:	01ac3733          	sltu	a4,s8,s10
   1d598:	01970733          	add	a4,a4,s9
   1d59c:	ffe68413          	addi	s0,a3,-2
   1d5a0:	00ed8db3          	add	s11,s11,a4
   1d5a4:	413c09b3          	sub	s3,s8,s3
   1d5a8:	409d84b3          	sub	s1,s11,s1
   1d5ac:	013c37b3          	sltu	a5,s8,s3
   1d5b0:	40f484b3          	sub	s1,s1,a5
   1d5b4:	fff00593          	li	a1,-1
   1d5b8:	1a9c8863          	beq	s9,s1,1d768 <__divdf3+0x600>
   1d5bc:	000a8593          	mv	a1,s5
   1d5c0:	00048513          	mv	a0,s1
   1d5c4:	014040ef          	jal	ra,215d8 <__udivsi3>
   1d5c8:	00050593          	mv	a1,a0
   1d5cc:	00a12423          	sw	a0,8(sp)
   1d5d0:	010c9513          	slli	a0,s9,0x10
   1d5d4:	01055513          	srli	a0,a0,0x10
   1d5d8:	7d5030ef          	jal	ra,215ac <__mulsi3>
   1d5dc:	00a12223          	sw	a0,4(sp)
   1d5e0:	000a8593          	mv	a1,s5
   1d5e4:	00048513          	mv	a0,s1
   1d5e8:	038040ef          	jal	ra,21620 <__umodsi3>
   1d5ec:	00812683          	lw	a3,8(sp)
   1d5f0:	00412703          	lw	a4,4(sp)
   1d5f4:	01051513          	slli	a0,a0,0x10
   1d5f8:	0109d793          	srli	a5,s3,0x10
   1d5fc:	00a7e533          	or	a0,a5,a0
   1d600:	00068d93          	mv	s11,a3
   1d604:	00e57e63          	bleu	a4,a0,1d620 <__divdf3+0x4b8>
   1d608:	01950533          	add	a0,a0,s9
   1d60c:	fff68d93          	addi	s11,a3,-1
   1d610:	01956863          	bltu	a0,s9,1d620 <__divdf3+0x4b8>
   1d614:	00e57663          	bleu	a4,a0,1d620 <__divdf3+0x4b8>
   1d618:	ffe68d93          	addi	s11,a3,-2
   1d61c:	01950533          	add	a0,a0,s9
   1d620:	40e504b3          	sub	s1,a0,a4
   1d624:	000a8593          	mv	a1,s5
   1d628:	00048513          	mv	a0,s1
   1d62c:	7ad030ef          	jal	ra,215d8 <__udivsi3>
   1d630:	00050593          	mv	a1,a0
   1d634:	00a12223          	sw	a0,4(sp)
   1d638:	010c9513          	slli	a0,s9,0x10
   1d63c:	01055513          	srli	a0,a0,0x10
   1d640:	76d030ef          	jal	ra,215ac <__mulsi3>
   1d644:	00050c13          	mv	s8,a0
   1d648:	000a8593          	mv	a1,s5
   1d64c:	00048513          	mv	a0,s1
   1d650:	7d1030ef          	jal	ra,21620 <__umodsi3>
   1d654:	01099993          	slli	s3,s3,0x10
   1d658:	00412703          	lw	a4,4(sp)
   1d65c:	01051513          	slli	a0,a0,0x10
   1d660:	0109d993          	srli	s3,s3,0x10
   1d664:	00a9e533          	or	a0,s3,a0
   1d668:	00070793          	mv	a5,a4
   1d66c:	01857e63          	bleu	s8,a0,1d688 <__divdf3+0x520>
   1d670:	01950533          	add	a0,a0,s9
   1d674:	fff70793          	addi	a5,a4,-1
   1d678:	01956863          	bltu	a0,s9,1d688 <__divdf3+0x520>
   1d67c:	01857663          	bleu	s8,a0,1d688 <__divdf3+0x520>
   1d680:	ffe70793          	addi	a5,a4,-2
   1d684:	01950533          	add	a0,a0,s9
   1d688:	010d9493          	slli	s1,s11,0x10
   1d68c:	00f4e4b3          	or	s1,s1,a5
   1d690:	01049793          	slli	a5,s1,0x10
   1d694:	0107d793          	srli	a5,a5,0x10
   1d698:	000b0593          	mv	a1,s6
   1d69c:	418509b3          	sub	s3,a0,s8
   1d6a0:	00078513          	mv	a0,a5
   1d6a4:	00f12223          	sw	a5,4(sp)
   1d6a8:	0104dd93          	srli	s11,s1,0x10
   1d6ac:	701030ef          	jal	ra,215ac <__mulsi3>
   1d6b0:	000b0593          	mv	a1,s6
   1d6b4:	00050a93          	mv	s5,a0
   1d6b8:	000d8513          	mv	a0,s11
   1d6bc:	6f1030ef          	jal	ra,215ac <__mulsi3>
   1d6c0:	00050c13          	mv	s8,a0
   1d6c4:	000d8593          	mv	a1,s11
   1d6c8:	000b8513          	mv	a0,s7
   1d6cc:	6e1030ef          	jal	ra,215ac <__mulsi3>
   1d6d0:	00412783          	lw	a5,4(sp)
   1d6d4:	00050b13          	mv	s6,a0
   1d6d8:	000b8513          	mv	a0,s7
   1d6dc:	00078593          	mv	a1,a5
   1d6e0:	6cd030ef          	jal	ra,215ac <__mulsi3>
   1d6e4:	01850533          	add	a0,a0,s8
   1d6e8:	010ad793          	srli	a5,s5,0x10
   1d6ec:	00a78533          	add	a0,a5,a0
   1d6f0:	01857663          	bleu	s8,a0,1d6fc <__divdf3+0x594>
   1d6f4:	000107b7          	lui	a5,0x10
   1d6f8:	00fb0b33          	add	s6,s6,a5
   1d6fc:	000106b7          	lui	a3,0x10
   1d700:	fff68693          	addi	a3,a3,-1 # ffff <main-0x75>
   1d704:	01055793          	srli	a5,a0,0x10
   1d708:	00d57733          	and	a4,a0,a3
   1d70c:	01071713          	slli	a4,a4,0x10
   1d710:	00dafab3          	and	s5,s5,a3
   1d714:	016787b3          	add	a5,a5,s6
   1d718:	01570733          	add	a4,a4,s5
   1d71c:	00f9e863          	bltu	s3,a5,1d72c <__divdf3+0x5c4>
   1d720:	00048593          	mv	a1,s1
   1d724:	04f99063          	bne	s3,a5,1d764 <__divdf3+0x5fc>
   1d728:	04070063          	beqz	a4,1d768 <__divdf3+0x600>
   1d72c:	013c8533          	add	a0,s9,s3
   1d730:	fff48593          	addi	a1,s1,-1
   1d734:	03956463          	bltu	a0,s9,1d75c <__divdf3+0x5f4>
   1d738:	00f56663          	bltu	a0,a5,1d744 <__divdf3+0x5dc>
   1d73c:	02f51463          	bne	a0,a5,1d764 <__divdf3+0x5fc>
   1d740:	02ed7063          	bleu	a4,s10,1d760 <__divdf3+0x5f8>
   1d744:	001d1693          	slli	a3,s10,0x1
   1d748:	01a6bd33          	sltu	s10,a3,s10
   1d74c:	019d0cb3          	add	s9,s10,s9
   1d750:	ffe48593          	addi	a1,s1,-2
   1d754:	01950533          	add	a0,a0,s9
   1d758:	00068d13          	mv	s10,a3
   1d75c:	00f51463          	bne	a0,a5,1d764 <__divdf3+0x5fc>
   1d760:	01a70463          	beq	a4,s10,1d768 <__divdf3+0x600>
   1d764:	0015e593          	ori	a1,a1,1
   1d768:	3ffa0713          	addi	a4,s4,1023
   1d76c:	12e05263          	blez	a4,1d890 <__divdf3+0x728>
   1d770:	0075f793          	andi	a5,a1,7
   1d774:	02078063          	beqz	a5,1d794 <__divdf3+0x62c>
   1d778:	00f5f793          	andi	a5,a1,15
   1d77c:	00400693          	li	a3,4
   1d780:	00d78a63          	beq	a5,a3,1d794 <__divdf3+0x62c>
   1d784:	00458693          	addi	a3,a1,4
   1d788:	00b6b5b3          	sltu	a1,a3,a1
   1d78c:	00b40433          	add	s0,s0,a1
   1d790:	00068593          	mv	a1,a3
   1d794:	00741793          	slli	a5,s0,0x7
   1d798:	0007da63          	bgez	a5,1d7ac <__divdf3+0x644>
   1d79c:	ff0007b7          	lui	a5,0xff000
   1d7a0:	fff78793          	addi	a5,a5,-1 # feffffff <__global_pointer$+0xfefdb89f>
   1d7a4:	00f47433          	and	s0,s0,a5
   1d7a8:	400a0713          	addi	a4,s4,1024
   1d7ac:	7fe00793          	li	a5,2046
   1d7b0:	1ae7c263          	blt	a5,a4,1d954 <__divdf3+0x7ec>
   1d7b4:	01d41793          	slli	a5,s0,0x1d
   1d7b8:	0035d593          	srli	a1,a1,0x3
   1d7bc:	00b7e7b3          	or	a5,a5,a1
   1d7c0:	00345413          	srli	s0,s0,0x3
   1d7c4:	001006b7          	lui	a3,0x100
   1d7c8:	fff68693          	addi	a3,a3,-1 # fffff <__global_pointer$+0xdb89f>
   1d7cc:	00d47433          	and	s0,s0,a3
   1d7d0:	801006b7          	lui	a3,0x80100
   1d7d4:	7ff77713          	andi	a4,a4,2047
   1d7d8:	fff68693          	addi	a3,a3,-1 # 800fffff <__global_pointer$+0x800db89f>
   1d7dc:	01471713          	slli	a4,a4,0x14
   1d7e0:	00d47433          	and	s0,s0,a3
   1d7e4:	01f91913          	slli	s2,s2,0x1f
   1d7e8:	00e46433          	or	s0,s0,a4
   1d7ec:	01246733          	or	a4,s0,s2
   1d7f0:	04c12083          	lw	ra,76(sp)
   1d7f4:	04812403          	lw	s0,72(sp)
   1d7f8:	04412483          	lw	s1,68(sp)
   1d7fc:	04012903          	lw	s2,64(sp)
   1d800:	03c12983          	lw	s3,60(sp)
   1d804:	03812a03          	lw	s4,56(sp)
   1d808:	03412a83          	lw	s5,52(sp)
   1d80c:	03012b03          	lw	s6,48(sp)
   1d810:	02c12b83          	lw	s7,44(sp)
   1d814:	02812c03          	lw	s8,40(sp)
   1d818:	02412c83          	lw	s9,36(sp)
   1d81c:	02012d03          	lw	s10,32(sp)
   1d820:	01c12d83          	lw	s11,28(sp)
   1d824:	00078513          	mv	a0,a5
   1d828:	00070593          	mv	a1,a4
   1d82c:	05010113          	addi	sp,sp,80
   1d830:	00008067          	ret
   1d834:	fffa0a13          	addi	s4,s4,-1
   1d838:	00000c13          	li	s8,0
   1d83c:	b91ff06f          	j	1d3cc <__divdf3+0x264>
   1d840:	00098913          	mv	s2,s3
   1d844:	000b0413          	mv	s0,s6
   1d848:	00048593          	mv	a1,s1
   1d84c:	000b8793          	mv	a5,s7
   1d850:	00200713          	li	a4,2
   1d854:	10e78063          	beq	a5,a4,1d954 <__divdf3+0x7ec>
   1d858:	00300713          	li	a4,3
   1d85c:	0ee78263          	beq	a5,a4,1d940 <__divdf3+0x7d8>
   1d860:	00100713          	li	a4,1
   1d864:	f0e792e3          	bne	a5,a4,1d768 <__divdf3+0x600>
   1d868:	00000413          	li	s0,0
   1d86c:	00000793          	li	a5,0
   1d870:	0940006f          	j	1d904 <__divdf3+0x79c>
   1d874:	000a8913          	mv	s2,s5
   1d878:	fd9ff06f          	j	1d850 <__divdf3+0x6e8>
   1d87c:	00080437          	lui	s0,0x80
   1d880:	00000593          	li	a1,0
   1d884:	00000913          	li	s2,0
   1d888:	00300793          	li	a5,3
   1d88c:	fc5ff06f          	j	1d850 <__divdf3+0x6e8>
   1d890:	00100693          	li	a3,1
   1d894:	40e686b3          	sub	a3,a3,a4
   1d898:	03800793          	li	a5,56
   1d89c:	fcd7c6e3          	blt	a5,a3,1d868 <__divdf3+0x700>
   1d8a0:	01f00793          	li	a5,31
   1d8a4:	06d7c463          	blt	a5,a3,1d90c <__divdf3+0x7a4>
   1d8a8:	41ea0a13          	addi	s4,s4,1054
   1d8ac:	014417b3          	sll	a5,s0,s4
   1d8b0:	00d5d733          	srl	a4,a1,a3
   1d8b4:	01459a33          	sll	s4,a1,s4
   1d8b8:	00e7e7b3          	or	a5,a5,a4
   1d8bc:	01403a33          	snez	s4,s4
   1d8c0:	0147e7b3          	or	a5,a5,s4
   1d8c4:	00d45433          	srl	s0,s0,a3
   1d8c8:	0077f713          	andi	a4,a5,7
   1d8cc:	02070063          	beqz	a4,1d8ec <__divdf3+0x784>
   1d8d0:	00f7f713          	andi	a4,a5,15
   1d8d4:	00400693          	li	a3,4
   1d8d8:	00d70a63          	beq	a4,a3,1d8ec <__divdf3+0x784>
   1d8dc:	00478713          	addi	a4,a5,4
   1d8e0:	00f737b3          	sltu	a5,a4,a5
   1d8e4:	00f40433          	add	s0,s0,a5
   1d8e8:	00070793          	mv	a5,a4
   1d8ec:	00841713          	slli	a4,s0,0x8
   1d8f0:	06074a63          	bltz	a4,1d964 <__divdf3+0x7fc>
   1d8f4:	01d41713          	slli	a4,s0,0x1d
   1d8f8:	0037d793          	srli	a5,a5,0x3
   1d8fc:	00f767b3          	or	a5,a4,a5
   1d900:	00345413          	srli	s0,s0,0x3
   1d904:	00000713          	li	a4,0
   1d908:	ebdff06f          	j	1d7c4 <__divdf3+0x65c>
   1d90c:	fe100793          	li	a5,-31
   1d910:	40e787b3          	sub	a5,a5,a4
   1d914:	02000713          	li	a4,32
   1d918:	00f457b3          	srl	a5,s0,a5
   1d91c:	00000513          	li	a0,0
   1d920:	00e68663          	beq	a3,a4,1d92c <__divdf3+0x7c4>
   1d924:	43ea0a13          	addi	s4,s4,1086
   1d928:	01441533          	sll	a0,s0,s4
   1d92c:	00b56a33          	or	s4,a0,a1
   1d930:	01403a33          	snez	s4,s4
   1d934:	0147e7b3          	or	a5,a5,s4
   1d938:	00000413          	li	s0,0
   1d93c:	f8dff06f          	j	1d8c8 <__divdf3+0x760>
   1d940:	00080437          	lui	s0,0x80
   1d944:	00000793          	li	a5,0
   1d948:	7ff00713          	li	a4,2047
   1d94c:	00000913          	li	s2,0
   1d950:	e75ff06f          	j	1d7c4 <__divdf3+0x65c>
   1d954:	00000413          	li	s0,0
   1d958:	00000793          	li	a5,0
   1d95c:	7ff00713          	li	a4,2047
   1d960:	e65ff06f          	j	1d7c4 <__divdf3+0x65c>
   1d964:	00000413          	li	s0,0
   1d968:	00000793          	li	a5,0
   1d96c:	00100713          	li	a4,1
   1d970:	e55ff06f          	j	1d7c4 <__divdf3+0x65c>

0001d974 <__muldf3>:
   1d974:	fa010113          	addi	sp,sp,-96
   1d978:	04812c23          	sw	s0,88(sp)
   1d97c:	05312623          	sw	s3,76(sp)
   1d980:	00100437          	lui	s0,0x100
   1d984:	0145d993          	srli	s3,a1,0x14
   1d988:	04912a23          	sw	s1,84(sp)
   1d98c:	05612023          	sw	s6,64(sp)
   1d990:	03712e23          	sw	s7,60(sp)
   1d994:	03812c23          	sw	s8,56(sp)
   1d998:	fff40413          	addi	s0,s0,-1 # fffff <__global_pointer$+0xdb89f>
   1d99c:	04112e23          	sw	ra,92(sp)
   1d9a0:	05212823          	sw	s2,80(sp)
   1d9a4:	05412423          	sw	s4,72(sp)
   1d9a8:	05512223          	sw	s5,68(sp)
   1d9ac:	03912a23          	sw	s9,52(sp)
   1d9b0:	03a12823          	sw	s10,48(sp)
   1d9b4:	03b12623          	sw	s11,44(sp)
   1d9b8:	7ff9f993          	andi	s3,s3,2047
   1d9bc:	00050493          	mv	s1,a0
   1d9c0:	00060b93          	mv	s7,a2
   1d9c4:	00068c13          	mv	s8,a3
   1d9c8:	00b47433          	and	s0,s0,a1
   1d9cc:	01f5db13          	srli	s6,a1,0x1f
   1d9d0:	0a098663          	beqz	s3,1da7c <__muldf3+0x108>
   1d9d4:	7ff00793          	li	a5,2047
   1d9d8:	10f98463          	beq	s3,a5,1dae0 <__muldf3+0x16c>
   1d9dc:	00800937          	lui	s2,0x800
   1d9e0:	00341413          	slli	s0,s0,0x3
   1d9e4:	01246433          	or	s0,s0,s2
   1d9e8:	01d55913          	srli	s2,a0,0x1d
   1d9ec:	00896933          	or	s2,s2,s0
   1d9f0:	00351d13          	slli	s10,a0,0x3
   1d9f4:	c0198993          	addi	s3,s3,-1023
   1d9f8:	00000c93          	li	s9,0
   1d9fc:	014c5513          	srli	a0,s8,0x14
   1da00:	00100a37          	lui	s4,0x100
   1da04:	fffa0a13          	addi	s4,s4,-1 # fffff <__global_pointer$+0xdb89f>
   1da08:	7ff57513          	andi	a0,a0,2047
   1da0c:	018a7a33          	and	s4,s4,s8
   1da10:	000b8493          	mv	s1,s7
   1da14:	01fc5c13          	srli	s8,s8,0x1f
   1da18:	10050263          	beqz	a0,1db1c <__muldf3+0x1a8>
   1da1c:	7ff00793          	li	a5,2047
   1da20:	16f50263          	beq	a0,a5,1db84 <__muldf3+0x210>
   1da24:	00800437          	lui	s0,0x800
   1da28:	003a1a13          	slli	s4,s4,0x3
   1da2c:	008a6a33          	or	s4,s4,s0
   1da30:	01dbd413          	srli	s0,s7,0x1d
   1da34:	01446433          	or	s0,s0,s4
   1da38:	003b9493          	slli	s1,s7,0x3
   1da3c:	c0150513          	addi	a0,a0,-1023
   1da40:	00000793          	li	a5,0
   1da44:	002c9713          	slli	a4,s9,0x2
   1da48:	00f76733          	or	a4,a4,a5
   1da4c:	00a989b3          	add	s3,s3,a0
   1da50:	fff70713          	addi	a4,a4,-1
   1da54:	00e00693          	li	a3,14
   1da58:	018b4bb3          	xor	s7,s6,s8
   1da5c:	00198a93          	addi	s5,s3,1
   1da60:	14e6ee63          	bltu	a3,a4,1dbbc <__muldf3+0x248>
   1da64:	000226b7          	lui	a3,0x22
   1da68:	00271713          	slli	a4,a4,0x2
   1da6c:	2d468693          	addi	a3,a3,724 # 222d4 <zeroes.4339+0x4c>
   1da70:	00d70733          	add	a4,a4,a3
   1da74:	00072703          	lw	a4,0(a4)
   1da78:	00070067          	jr	a4
   1da7c:	00a46933          	or	s2,s0,a0
   1da80:	06090e63          	beqz	s2,1dafc <__muldf3+0x188>
   1da84:	04040063          	beqz	s0,1dac4 <__muldf3+0x150>
   1da88:	00040513          	mv	a0,s0
   1da8c:	3f9030ef          	jal	ra,21684 <__clzsi2>
   1da90:	ff550793          	addi	a5,a0,-11
   1da94:	01c00713          	li	a4,28
   1da98:	02f74c63          	blt	a4,a5,1dad0 <__muldf3+0x15c>
   1da9c:	01d00913          	li	s2,29
   1daa0:	ff850d13          	addi	s10,a0,-8
   1daa4:	40f90933          	sub	s2,s2,a5
   1daa8:	01a41433          	sll	s0,s0,s10
   1daac:	0124d933          	srl	s2,s1,s2
   1dab0:	00896933          	or	s2,s2,s0
   1dab4:	01a49d33          	sll	s10,s1,s10
   1dab8:	c0d00993          	li	s3,-1011
   1dabc:	40a989b3          	sub	s3,s3,a0
   1dac0:	f39ff06f          	j	1d9f8 <__muldf3+0x84>
   1dac4:	3c1030ef          	jal	ra,21684 <__clzsi2>
   1dac8:	02050513          	addi	a0,a0,32
   1dacc:	fc5ff06f          	j	1da90 <__muldf3+0x11c>
   1dad0:	fd850913          	addi	s2,a0,-40
   1dad4:	01249933          	sll	s2,s1,s2
   1dad8:	00000d13          	li	s10,0
   1dadc:	fddff06f          	j	1dab8 <__muldf3+0x144>
   1dae0:	00a46933          	or	s2,s0,a0
   1dae4:	02090463          	beqz	s2,1db0c <__muldf3+0x198>
   1dae8:	00050d13          	mv	s10,a0
   1daec:	00040913          	mv	s2,s0
   1daf0:	7ff00993          	li	s3,2047
   1daf4:	00300c93          	li	s9,3
   1daf8:	f05ff06f          	j	1d9fc <__muldf3+0x88>
   1dafc:	00000d13          	li	s10,0
   1db00:	00000993          	li	s3,0
   1db04:	00100c93          	li	s9,1
   1db08:	ef5ff06f          	j	1d9fc <__muldf3+0x88>
   1db0c:	00000d13          	li	s10,0
   1db10:	7ff00993          	li	s3,2047
   1db14:	00200c93          	li	s9,2
   1db18:	ee5ff06f          	j	1d9fc <__muldf3+0x88>
   1db1c:	017a6433          	or	s0,s4,s7
   1db20:	06040e63          	beqz	s0,1db9c <__muldf3+0x228>
   1db24:	040a0063          	beqz	s4,1db64 <__muldf3+0x1f0>
   1db28:	000a0513          	mv	a0,s4
   1db2c:	359030ef          	jal	ra,21684 <__clzsi2>
   1db30:	ff550793          	addi	a5,a0,-11
   1db34:	01c00713          	li	a4,28
   1db38:	02f74e63          	blt	a4,a5,1db74 <__muldf3+0x200>
   1db3c:	01d00413          	li	s0,29
   1db40:	ff850493          	addi	s1,a0,-8
   1db44:	40f40433          	sub	s0,s0,a5
   1db48:	009a1a33          	sll	s4,s4,s1
   1db4c:	008bd433          	srl	s0,s7,s0
   1db50:	01446433          	or	s0,s0,s4
   1db54:	009b94b3          	sll	s1,s7,s1
   1db58:	c0d00793          	li	a5,-1011
   1db5c:	40a78533          	sub	a0,a5,a0
   1db60:	ee1ff06f          	j	1da40 <__muldf3+0xcc>
   1db64:	000b8513          	mv	a0,s7
   1db68:	31d030ef          	jal	ra,21684 <__clzsi2>
   1db6c:	02050513          	addi	a0,a0,32
   1db70:	fc1ff06f          	j	1db30 <__muldf3+0x1bc>
   1db74:	fd850413          	addi	s0,a0,-40
   1db78:	008b9433          	sll	s0,s7,s0
   1db7c:	00000493          	li	s1,0
   1db80:	fd9ff06f          	j	1db58 <__muldf3+0x1e4>
   1db84:	017a6433          	or	s0,s4,s7
   1db88:	02040263          	beqz	s0,1dbac <__muldf3+0x238>
   1db8c:	000a0413          	mv	s0,s4
   1db90:	7ff00513          	li	a0,2047
   1db94:	00300793          	li	a5,3
   1db98:	eadff06f          	j	1da44 <__muldf3+0xd0>
   1db9c:	00000493          	li	s1,0
   1dba0:	00000513          	li	a0,0
   1dba4:	00100793          	li	a5,1
   1dba8:	e9dff06f          	j	1da44 <__muldf3+0xd0>
   1dbac:	00000493          	li	s1,0
   1dbb0:	7ff00513          	li	a0,2047
   1dbb4:	00200793          	li	a5,2
   1dbb8:	e8dff06f          	j	1da44 <__muldf3+0xd0>
   1dbbc:	00010737          	lui	a4,0x10
   1dbc0:	fff70a13          	addi	s4,a4,-1 # ffff <main-0x75>
   1dbc4:	010d5c13          	srli	s8,s10,0x10
   1dbc8:	0104dd93          	srli	s11,s1,0x10
   1dbcc:	014d7d33          	and	s10,s10,s4
   1dbd0:	0144f4b3          	and	s1,s1,s4
   1dbd4:	00048593          	mv	a1,s1
   1dbd8:	000d0513          	mv	a0,s10
   1dbdc:	00e12823          	sw	a4,16(sp)
   1dbe0:	1cd030ef          	jal	ra,215ac <__mulsi3>
   1dbe4:	00050c93          	mv	s9,a0
   1dbe8:	00048593          	mv	a1,s1
   1dbec:	000c0513          	mv	a0,s8
   1dbf0:	1bd030ef          	jal	ra,215ac <__mulsi3>
   1dbf4:	00a12623          	sw	a0,12(sp)
   1dbf8:	000d8593          	mv	a1,s11
   1dbfc:	000c0513          	mv	a0,s8
   1dc00:	1ad030ef          	jal	ra,215ac <__mulsi3>
   1dc04:	00050b13          	mv	s6,a0
   1dc08:	000d0593          	mv	a1,s10
   1dc0c:	000d8513          	mv	a0,s11
   1dc10:	19d030ef          	jal	ra,215ac <__mulsi3>
   1dc14:	00c12683          	lw	a3,12(sp)
   1dc18:	010cd793          	srli	a5,s9,0x10
   1dc1c:	00d50533          	add	a0,a0,a3
   1dc20:	00a78533          	add	a0,a5,a0
   1dc24:	00d57663          	bleu	a3,a0,1dc30 <__muldf3+0x2bc>
   1dc28:	01012703          	lw	a4,16(sp)
   1dc2c:	00eb0b33          	add	s6,s6,a4
   1dc30:	01055693          	srli	a3,a0,0x10
   1dc34:	01457533          	and	a0,a0,s4
   1dc38:	014cfcb3          	and	s9,s9,s4
   1dc3c:	01051513          	slli	a0,a0,0x10
   1dc40:	019507b3          	add	a5,a0,s9
   1dc44:	01045c93          	srli	s9,s0,0x10
   1dc48:	01447433          	and	s0,s0,s4
   1dc4c:	000d0593          	mv	a1,s10
   1dc50:	00040513          	mv	a0,s0
   1dc54:	00d12a23          	sw	a3,20(sp)
   1dc58:	00f12623          	sw	a5,12(sp)
   1dc5c:	151030ef          	jal	ra,215ac <__mulsi3>
   1dc60:	00a12823          	sw	a0,16(sp)
   1dc64:	00040593          	mv	a1,s0
   1dc68:	000c0513          	mv	a0,s8
   1dc6c:	141030ef          	jal	ra,215ac <__mulsi3>
   1dc70:	00050a13          	mv	s4,a0
   1dc74:	000c8593          	mv	a1,s9
   1dc78:	000c0513          	mv	a0,s8
   1dc7c:	131030ef          	jal	ra,215ac <__mulsi3>
   1dc80:	00050c13          	mv	s8,a0
   1dc84:	000d0593          	mv	a1,s10
   1dc88:	000c8513          	mv	a0,s9
   1dc8c:	121030ef          	jal	ra,215ac <__mulsi3>
   1dc90:	01012703          	lw	a4,16(sp)
   1dc94:	01450533          	add	a0,a0,s4
   1dc98:	01412683          	lw	a3,20(sp)
   1dc9c:	01075793          	srli	a5,a4,0x10
   1dca0:	00a78533          	add	a0,a5,a0
   1dca4:	01457663          	bleu	s4,a0,1dcb0 <__muldf3+0x33c>
   1dca8:	000107b7          	lui	a5,0x10
   1dcac:	00fc0c33          	add	s8,s8,a5
   1dcb0:	00010637          	lui	a2,0x10
   1dcb4:	01055793          	srli	a5,a0,0x10
   1dcb8:	01878c33          	add	s8,a5,s8
   1dcbc:	fff60793          	addi	a5,a2,-1 # ffff <main-0x75>
   1dcc0:	00f57a33          	and	s4,a0,a5
   1dcc4:	00f77733          	and	a4,a4,a5
   1dcc8:	010a1a13          	slli	s4,s4,0x10
   1dccc:	01095d13          	srli	s10,s2,0x10
   1dcd0:	00ea0a33          	add	s4,s4,a4
   1dcd4:	00f97933          	and	s2,s2,a5
   1dcd8:	01468733          	add	a4,a3,s4
   1dcdc:	00048593          	mv	a1,s1
   1dce0:	00090513          	mv	a0,s2
   1dce4:	00e12823          	sw	a4,16(sp)
   1dce8:	00c12e23          	sw	a2,28(sp)
   1dcec:	0c1030ef          	jal	ra,215ac <__mulsi3>
   1dcf0:	00048593          	mv	a1,s1
   1dcf4:	00a12c23          	sw	a0,24(sp)
   1dcf8:	000d0513          	mv	a0,s10
   1dcfc:	0b1030ef          	jal	ra,215ac <__mulsi3>
   1dd00:	00a12a23          	sw	a0,20(sp)
   1dd04:	000d0593          	mv	a1,s10
   1dd08:	000d8513          	mv	a0,s11
   1dd0c:	0a1030ef          	jal	ra,215ac <__mulsi3>
   1dd10:	00050493          	mv	s1,a0
   1dd14:	00090593          	mv	a1,s2
   1dd18:	000d8513          	mv	a0,s11
   1dd1c:	091030ef          	jal	ra,215ac <__mulsi3>
   1dd20:	01412683          	lw	a3,20(sp)
   1dd24:	01812703          	lw	a4,24(sp)
   1dd28:	00d50533          	add	a0,a0,a3
   1dd2c:	01075793          	srli	a5,a4,0x10
   1dd30:	00a78533          	add	a0,a5,a0
   1dd34:	00d57663          	bleu	a3,a0,1dd40 <__muldf3+0x3cc>
   1dd38:	01c12603          	lw	a2,28(sp)
   1dd3c:	00c484b3          	add	s1,s1,a2
   1dd40:	000106b7          	lui	a3,0x10
   1dd44:	fff68793          	addi	a5,a3,-1 # ffff <main-0x75>
   1dd48:	01055d93          	srli	s11,a0,0x10
   1dd4c:	009d84b3          	add	s1,s11,s1
   1dd50:	00f57db3          	and	s11,a0,a5
   1dd54:	00f77733          	and	a4,a4,a5
   1dd58:	00040593          	mv	a1,s0
   1dd5c:	010d9d93          	slli	s11,s11,0x10
   1dd60:	00090513          	mv	a0,s2
   1dd64:	00ed8db3          	add	s11,s11,a4
   1dd68:	00d12c23          	sw	a3,24(sp)
   1dd6c:	041030ef          	jal	ra,215ac <__mulsi3>
   1dd70:	00040593          	mv	a1,s0
   1dd74:	00a12a23          	sw	a0,20(sp)
   1dd78:	000d0513          	mv	a0,s10
   1dd7c:	031030ef          	jal	ra,215ac <__mulsi3>
   1dd80:	000d0593          	mv	a1,s10
   1dd84:	00050413          	mv	s0,a0
   1dd88:	000c8513          	mv	a0,s9
   1dd8c:	021030ef          	jal	ra,215ac <__mulsi3>
   1dd90:	00050d13          	mv	s10,a0
   1dd94:	00090593          	mv	a1,s2
   1dd98:	000c8513          	mv	a0,s9
   1dd9c:	011030ef          	jal	ra,215ac <__mulsi3>
   1dda0:	01412703          	lw	a4,20(sp)
   1dda4:	00850533          	add	a0,a0,s0
   1dda8:	01075793          	srli	a5,a4,0x10
   1ddac:	00a78533          	add	a0,a5,a0
   1ddb0:	00857663          	bleu	s0,a0,1ddbc <__muldf3+0x448>
   1ddb4:	01812683          	lw	a3,24(sp)
   1ddb8:	00dd0d33          	add	s10,s10,a3
   1ddbc:	01012783          	lw	a5,16(sp)
   1ddc0:	000106b7          	lui	a3,0x10
   1ddc4:	fff68693          	addi	a3,a3,-1 # ffff <main-0x75>
   1ddc8:	00fb0b33          	add	s6,s6,a5
   1ddcc:	00d577b3          	and	a5,a0,a3
   1ddd0:	00d77733          	and	a4,a4,a3
   1ddd4:	01079793          	slli	a5,a5,0x10
   1ddd8:	00e787b3          	add	a5,a5,a4
   1dddc:	014b3a33          	sltu	s4,s6,s4
   1dde0:	018787b3          	add	a5,a5,s8
   1dde4:	01478433          	add	s0,a5,s4
   1dde8:	01bb0b33          	add	s6,s6,s11
   1ddec:	00940733          	add	a4,s0,s1
   1ddf0:	01bb3db3          	sltu	s11,s6,s11
   1ddf4:	01b706b3          	add	a3,a4,s11
   1ddf8:	0187bc33          	sltu	s8,a5,s8
   1ddfc:	01443433          	sltu	s0,s0,s4
   1de00:	01055793          	srli	a5,a0,0x10
   1de04:	00973733          	sltu	a4,a4,s1
   1de08:	008c6433          	or	s0,s8,s0
   1de0c:	01b6bdb3          	sltu	s11,a3,s11
   1de10:	00f40433          	add	s0,s0,a5
   1de14:	01b76db3          	or	s11,a4,s11
   1de18:	01b40433          	add	s0,s0,s11
   1de1c:	01a40433          	add	s0,s0,s10
   1de20:	0176d793          	srli	a5,a3,0x17
   1de24:	00941413          	slli	s0,s0,0x9
   1de28:	00f46433          	or	s0,s0,a5
   1de2c:	00c12783          	lw	a5,12(sp)
   1de30:	009b1493          	slli	s1,s6,0x9
   1de34:	017b5b13          	srli	s6,s6,0x17
   1de38:	00f4e4b3          	or	s1,s1,a5
   1de3c:	009034b3          	snez	s1,s1
   1de40:	00969793          	slli	a5,a3,0x9
   1de44:	0164e4b3          	or	s1,s1,s6
   1de48:	00f4e4b3          	or	s1,s1,a5
   1de4c:	00741793          	slli	a5,s0,0x7
   1de50:	1207d263          	bgez	a5,1df74 <__muldf3+0x600>
   1de54:	0014d793          	srli	a5,s1,0x1
   1de58:	0014f493          	andi	s1,s1,1
   1de5c:	0097e4b3          	or	s1,a5,s1
   1de60:	01f41793          	slli	a5,s0,0x1f
   1de64:	00f4e4b3          	or	s1,s1,a5
   1de68:	00145413          	srli	s0,s0,0x1
   1de6c:	3ffa8713          	addi	a4,s5,1023
   1de70:	10e05663          	blez	a4,1df7c <__muldf3+0x608>
   1de74:	0074f793          	andi	a5,s1,7
   1de78:	02078063          	beqz	a5,1de98 <__muldf3+0x524>
   1de7c:	00f4f793          	andi	a5,s1,15
   1de80:	00400693          	li	a3,4
   1de84:	00d78a63          	beq	a5,a3,1de98 <__muldf3+0x524>
   1de88:	00448793          	addi	a5,s1,4
   1de8c:	0097b4b3          	sltu	s1,a5,s1
   1de90:	00940433          	add	s0,s0,s1
   1de94:	00078493          	mv	s1,a5
   1de98:	00741793          	slli	a5,s0,0x7
   1de9c:	0007da63          	bgez	a5,1deb0 <__muldf3+0x53c>
   1dea0:	ff0007b7          	lui	a5,0xff000
   1dea4:	fff78793          	addi	a5,a5,-1 # feffffff <__global_pointer$+0xfefdb89f>
   1dea8:	00f47433          	and	s0,s0,a5
   1deac:	400a8713          	addi	a4,s5,1024
   1deb0:	7fe00793          	li	a5,2046
   1deb4:	18e7c663          	blt	a5,a4,1e040 <__muldf3+0x6cc>
   1deb8:	0034da93          	srli	s5,s1,0x3
   1debc:	01d41493          	slli	s1,s0,0x1d
   1dec0:	0154e4b3          	or	s1,s1,s5
   1dec4:	00345413          	srli	s0,s0,0x3
   1dec8:	001007b7          	lui	a5,0x100
   1decc:	fff78793          	addi	a5,a5,-1 # fffff <__global_pointer$+0xdb89f>
   1ded0:	00f47433          	and	s0,s0,a5
   1ded4:	7ff77793          	andi	a5,a4,2047
   1ded8:	80100737          	lui	a4,0x80100
   1dedc:	fff70713          	addi	a4,a4,-1 # 800fffff <__global_pointer$+0x800db89f>
   1dee0:	01479793          	slli	a5,a5,0x14
   1dee4:	00e47433          	and	s0,s0,a4
   1dee8:	01fb9b93          	slli	s7,s7,0x1f
   1deec:	00f46433          	or	s0,s0,a5
   1def0:	017467b3          	or	a5,s0,s7
   1def4:	05c12083          	lw	ra,92(sp)
   1def8:	05812403          	lw	s0,88(sp)
   1defc:	00048513          	mv	a0,s1
   1df00:	05012903          	lw	s2,80(sp)
   1df04:	05412483          	lw	s1,84(sp)
   1df08:	04c12983          	lw	s3,76(sp)
   1df0c:	04812a03          	lw	s4,72(sp)
   1df10:	04412a83          	lw	s5,68(sp)
   1df14:	04012b03          	lw	s6,64(sp)
   1df18:	03c12b83          	lw	s7,60(sp)
   1df1c:	03812c03          	lw	s8,56(sp)
   1df20:	03412c83          	lw	s9,52(sp)
   1df24:	03012d03          	lw	s10,48(sp)
   1df28:	02c12d83          	lw	s11,44(sp)
   1df2c:	00078593          	mv	a1,a5
   1df30:	06010113          	addi	sp,sp,96
   1df34:	00008067          	ret
   1df38:	000b0b93          	mv	s7,s6
   1df3c:	00090413          	mv	s0,s2
   1df40:	000d0493          	mv	s1,s10
   1df44:	000c8793          	mv	a5,s9
   1df48:	00200713          	li	a4,2
   1df4c:	0ee78a63          	beq	a5,a4,1e040 <__muldf3+0x6cc>
   1df50:	00300713          	li	a4,3
   1df54:	0ce78c63          	beq	a5,a4,1e02c <__muldf3+0x6b8>
   1df58:	00100713          	li	a4,1
   1df5c:	f0e798e3          	bne	a5,a4,1de6c <__muldf3+0x4f8>
   1df60:	00000413          	li	s0,0
   1df64:	00000493          	li	s1,0
   1df68:	0880006f          	j	1dff0 <__muldf3+0x67c>
   1df6c:	000c0b93          	mv	s7,s8
   1df70:	fd9ff06f          	j	1df48 <__muldf3+0x5d4>
   1df74:	00098a93          	mv	s5,s3
   1df78:	ef5ff06f          	j	1de6c <__muldf3+0x4f8>
   1df7c:	00100693          	li	a3,1
   1df80:	40e686b3          	sub	a3,a3,a4
   1df84:	03800793          	li	a5,56
   1df88:	fcd7cce3          	blt	a5,a3,1df60 <__muldf3+0x5ec>
   1df8c:	01f00793          	li	a5,31
   1df90:	06d7c463          	blt	a5,a3,1dff8 <__muldf3+0x684>
   1df94:	41ea8a93          	addi	s5,s5,1054
   1df98:	015417b3          	sll	a5,s0,s5
   1df9c:	00d4d733          	srl	a4,s1,a3
   1dfa0:	015494b3          	sll	s1,s1,s5
   1dfa4:	00e7e7b3          	or	a5,a5,a4
   1dfa8:	009034b3          	snez	s1,s1
   1dfac:	0097e4b3          	or	s1,a5,s1
   1dfb0:	00d45433          	srl	s0,s0,a3
   1dfb4:	0074f793          	andi	a5,s1,7
   1dfb8:	02078063          	beqz	a5,1dfd8 <__muldf3+0x664>
   1dfbc:	00f4f793          	andi	a5,s1,15
   1dfc0:	00400713          	li	a4,4
   1dfc4:	00e78a63          	beq	a5,a4,1dfd8 <__muldf3+0x664>
   1dfc8:	00448793          	addi	a5,s1,4
   1dfcc:	0097b4b3          	sltu	s1,a5,s1
   1dfd0:	00940433          	add	s0,s0,s1
   1dfd4:	00078493          	mv	s1,a5
   1dfd8:	00841793          	slli	a5,s0,0x8
   1dfdc:	0607ca63          	bltz	a5,1e050 <__muldf3+0x6dc>
   1dfe0:	01d41793          	slli	a5,s0,0x1d
   1dfe4:	0034d493          	srli	s1,s1,0x3
   1dfe8:	0097e4b3          	or	s1,a5,s1
   1dfec:	00345413          	srli	s0,s0,0x3
   1dff0:	00000713          	li	a4,0
   1dff4:	ed5ff06f          	j	1dec8 <__muldf3+0x554>
   1dff8:	fe100793          	li	a5,-31
   1dffc:	40e787b3          	sub	a5,a5,a4
   1e000:	02000613          	li	a2,32
   1e004:	00f457b3          	srl	a5,s0,a5
   1e008:	00000713          	li	a4,0
   1e00c:	00c68663          	beq	a3,a2,1e018 <__muldf3+0x6a4>
   1e010:	43ea8a93          	addi	s5,s5,1086
   1e014:	01541733          	sll	a4,s0,s5
   1e018:	009764b3          	or	s1,a4,s1
   1e01c:	009034b3          	snez	s1,s1
   1e020:	0097e4b3          	or	s1,a5,s1
   1e024:	00000413          	li	s0,0
   1e028:	f8dff06f          	j	1dfb4 <__muldf3+0x640>
   1e02c:	00080437          	lui	s0,0x80
   1e030:	00000493          	li	s1,0
   1e034:	7ff00713          	li	a4,2047
   1e038:	00000b93          	li	s7,0
   1e03c:	e8dff06f          	j	1dec8 <__muldf3+0x554>
   1e040:	00000413          	li	s0,0
   1e044:	00000493          	li	s1,0
   1e048:	7ff00713          	li	a4,2047
   1e04c:	e7dff06f          	j	1dec8 <__muldf3+0x554>
   1e050:	00000413          	li	s0,0
   1e054:	00000493          	li	s1,0
   1e058:	00100713          	li	a4,1
   1e05c:	e6dff06f          	j	1dec8 <__muldf3+0x554>

0001e060 <__eqtf2>:
   1e060:	00c52783          	lw	a5,12(a0)
   1e064:	0005af03          	lw	t5,0(a1)
   1e068:	0045af83          	lw	t6,4(a1)
   1e06c:	0085a283          	lw	t0,8(a1)
   1e070:	00c5a583          	lw	a1,12(a1)
   1e074:	00008737          	lui	a4,0x8
   1e078:	0107d693          	srli	a3,a5,0x10
   1e07c:	fff70713          	addi	a4,a4,-1 # 7fff <main-0x8075>
   1e080:	01079813          	slli	a6,a5,0x10
   1e084:	01059e93          	slli	t4,a1,0x10
   1e088:	01f7d613          	srli	a2,a5,0x1f
   1e08c:	00d776b3          	and	a3,a4,a3
   1e090:	0105d793          	srli	a5,a1,0x10
   1e094:	ff010113          	addi	sp,sp,-16
   1e098:	00052883          	lw	a7,0(a0)
   1e09c:	00452303          	lw	t1,4(a0)
   1e0a0:	00852e03          	lw	t3,8(a0)
   1e0a4:	01085813          	srli	a6,a6,0x10
   1e0a8:	010ede93          	srli	t4,t4,0x10
   1e0ac:	00f777b3          	and	a5,a4,a5
   1e0b0:	01f5d593          	srli	a1,a1,0x1f
   1e0b4:	02e69063          	bne	a3,a4,1e0d4 <__eqtf2+0x74>
   1e0b8:	0068e733          	or	a4,a7,t1
   1e0bc:	01c76733          	or	a4,a4,t3
   1e0c0:	01076733          	or	a4,a4,a6
   1e0c4:	00100513          	li	a0,1
   1e0c8:	04071a63          	bnez	a4,1e11c <__eqtf2+0xbc>
   1e0cc:	04d79863          	bne	a5,a3,1e11c <__eqtf2+0xbc>
   1e0d0:	0080006f          	j	1e0d8 <__eqtf2+0x78>
   1e0d4:	00e79c63          	bne	a5,a4,1e0ec <__eqtf2+0x8c>
   1e0d8:	01ff6733          	or	a4,t5,t6
   1e0dc:	00576733          	or	a4,a4,t0
   1e0e0:	01d76733          	or	a4,a4,t4
   1e0e4:	00100513          	li	a0,1
   1e0e8:	02071a63          	bnez	a4,1e11c <__eqtf2+0xbc>
   1e0ec:	00100513          	li	a0,1
   1e0f0:	02d79663          	bne	a5,a3,1e11c <__eqtf2+0xbc>
   1e0f4:	03e89463          	bne	a7,t5,1e11c <__eqtf2+0xbc>
   1e0f8:	03f31263          	bne	t1,t6,1e11c <__eqtf2+0xbc>
   1e0fc:	025e1063          	bne	t3,t0,1e11c <__eqtf2+0xbc>
   1e100:	01d81e63          	bne	a6,t4,1e11c <__eqtf2+0xbc>
   1e104:	02b60063          	beq	a2,a1,1e124 <__eqtf2+0xc4>
   1e108:	00079a63          	bnez	a5,1e11c <__eqtf2+0xbc>
   1e10c:	0068e533          	or	a0,a7,t1
   1e110:	01c56533          	or	a0,a0,t3
   1e114:	01056533          	or	a0,a0,a6
   1e118:	00a03533          	snez	a0,a0
   1e11c:	01010113          	addi	sp,sp,16
   1e120:	00008067          	ret
   1e124:	00000513          	li	a0,0
   1e128:	ff5ff06f          	j	1e11c <__eqtf2+0xbc>

0001e12c <__getf2>:
   1e12c:	00c52783          	lw	a5,12(a0)
   1e130:	00c5a883          	lw	a7,12(a1)
   1e134:	00052f03          	lw	t5,0(a0)
   1e138:	00452603          	lw	a2,4(a0)
   1e13c:	00852803          	lw	a6,8(a0)
   1e140:	00008537          	lui	a0,0x8
   1e144:	0107d713          	srli	a4,a5,0x10
   1e148:	fff50513          	addi	a0,a0,-1 # 7fff <main-0x8075>
   1e14c:	01089e93          	slli	t4,a7,0x10
   1e150:	0108d693          	srli	a3,a7,0x10
   1e154:	0005a283          	lw	t0,0(a1)
   1e158:	0045a303          	lw	t1,4(a1)
   1e15c:	0085ae03          	lw	t3,8(a1)
   1e160:	00e57733          	and	a4,a0,a4
   1e164:	01079593          	slli	a1,a5,0x10
   1e168:	ff010113          	addi	sp,sp,-16
   1e16c:	0105d593          	srli	a1,a1,0x10
   1e170:	01f7d793          	srli	a5,a5,0x1f
   1e174:	010ede93          	srli	t4,t4,0x10
   1e178:	00d576b3          	and	a3,a0,a3
   1e17c:	01f8d893          	srli	a7,a7,0x1f
   1e180:	02a71063          	bne	a4,a0,1e1a0 <__getf2+0x74>
   1e184:	00cf6fb3          	or	t6,t5,a2
   1e188:	010fefb3          	or	t6,t6,a6
   1e18c:	00bfefb3          	or	t6,t6,a1
   1e190:	ffe00513          	li	a0,-2
   1e194:	0e0f8063          	beqz	t6,1e274 <__getf2+0x148>
   1e198:	01010113          	addi	sp,sp,16
   1e19c:	00008067          	ret
   1e1a0:	02a69863          	bne	a3,a0,1e1d0 <__getf2+0xa4>
   1e1a4:	0062efb3          	or	t6,t0,t1
   1e1a8:	01cfefb3          	or	t6,t6,t3
   1e1ac:	01dfefb3          	or	t6,t6,t4
   1e1b0:	ffe00513          	li	a0,-2
   1e1b4:	fe0f92e3          	bnez	t6,1e198 <__getf2+0x6c>
   1e1b8:	04071263          	bnez	a4,1e1fc <__getf2+0xd0>
   1e1bc:	00cf6533          	or	a0,t5,a2
   1e1c0:	01056533          	or	a0,a0,a6
   1e1c4:	00b56533          	or	a0,a0,a1
   1e1c8:	00153513          	seqz	a0,a0
   1e1cc:	02c0006f          	j	1e1f8 <__getf2+0xcc>
   1e1d0:	0a071463          	bnez	a4,1e278 <__getf2+0x14c>
   1e1d4:	00cf6533          	or	a0,t5,a2
   1e1d8:	01056533          	or	a0,a0,a6
   1e1dc:	00b56533          	or	a0,a0,a1
   1e1e0:	00153513          	seqz	a0,a0
   1e1e4:	00069a63          	bnez	a3,1e1f8 <__getf2+0xcc>
   1e1e8:	0062efb3          	or	t6,t0,t1
   1e1ec:	01cfefb3          	or	t6,t6,t3
   1e1f0:	01dfefb3          	or	t6,t6,t4
   1e1f4:	060f8c63          	beqz	t6,1e26c <__getf2+0x140>
   1e1f8:	00051a63          	bnez	a0,1e20c <__getf2+0xe0>
   1e1fc:	01178e63          	beq	a5,a7,1e218 <__getf2+0xec>
   1e200:	00100513          	li	a0,1
   1e204:	f8078ae3          	beqz	a5,1e198 <__getf2+0x6c>
   1e208:	0080006f          	j	1e210 <__getf2+0xe4>
   1e20c:	f80896e3          	bnez	a7,1e198 <__getf2+0x6c>
   1e210:	fff00513          	li	a0,-1
   1e214:	f85ff06f          	j	1e198 <__getf2+0x6c>
   1e218:	fee6c4e3          	blt	a3,a4,1e200 <__getf2+0xd4>
   1e21c:	00d75a63          	ble	a3,a4,1e230 <__getf2+0x104>
   1e220:	fff00513          	li	a0,-1
   1e224:	f6078ae3          	beqz	a5,1e198 <__getf2+0x6c>
   1e228:	00100513          	li	a0,1
   1e22c:	f6dff06f          	j	1e198 <__getf2+0x6c>
   1e230:	fcbee8e3          	bltu	t4,a1,1e200 <__getf2+0xd4>
   1e234:	03d59663          	bne	a1,t4,1e260 <__getf2+0x134>
   1e238:	fd0e64e3          	bltu	t3,a6,1e200 <__getf2+0xd4>
   1e23c:	05c81463          	bne	a6,t3,1e284 <__getf2+0x158>
   1e240:	fcc360e3          	bltu	t1,a2,1e200 <__getf2+0xd4>
   1e244:	00661463          	bne	a2,t1,1e24c <__getf2+0x120>
   1e248:	fbe2ece3          	bltu	t0,t5,1e200 <__getf2+0xd4>
   1e24c:	fc666ae3          	bltu	a2,t1,1e220 <__getf2+0xf4>
   1e250:	00000513          	li	a0,0
   1e254:	f46612e3          	bne	a2,t1,1e198 <__getf2+0x6c>
   1e258:	fc5f64e3          	bltu	t5,t0,1e220 <__getf2+0xf4>
   1e25c:	f3dff06f          	j	1e198 <__getf2+0x6c>
   1e260:	fdd5e0e3          	bltu	a1,t4,1e220 <__getf2+0xf4>
   1e264:	00000513          	li	a0,0
   1e268:	f31ff06f          	j	1e198 <__getf2+0x6c>
   1e26c:	fe051ce3          	bnez	a0,1e264 <__getf2+0x138>
   1e270:	f91ff06f          	j	1e200 <__getf2+0xd4>
   1e274:	f2e688e3          	beq	a3,a4,1e1a4 <__getf2+0x78>
   1e278:	00000513          	li	a0,0
   1e27c:	f60686e3          	beqz	a3,1e1e8 <__getf2+0xbc>
   1e280:	f7dff06f          	j	1e1fc <__getf2+0xd0>
   1e284:	f9c86ee3          	bltu	a6,t3,1e220 <__getf2+0xf4>
   1e288:	fddff06f          	j	1e264 <__getf2+0x138>

0001e28c <__letf2>:
   1e28c:	00c52783          	lw	a5,12(a0)
   1e290:	00c5a883          	lw	a7,12(a1)
   1e294:	00052f03          	lw	t5,0(a0)
   1e298:	00452603          	lw	a2,4(a0)
   1e29c:	00852803          	lw	a6,8(a0)
   1e2a0:	00008537          	lui	a0,0x8
   1e2a4:	0107d713          	srli	a4,a5,0x10
   1e2a8:	fff50513          	addi	a0,a0,-1 # 7fff <main-0x8075>
   1e2ac:	01089e93          	slli	t4,a7,0x10
   1e2b0:	0108d693          	srli	a3,a7,0x10
   1e2b4:	0005a283          	lw	t0,0(a1)
   1e2b8:	0045a303          	lw	t1,4(a1)
   1e2bc:	0085ae03          	lw	t3,8(a1)
   1e2c0:	00e57733          	and	a4,a0,a4
   1e2c4:	01079593          	slli	a1,a5,0x10
   1e2c8:	ff010113          	addi	sp,sp,-16
   1e2cc:	0105d593          	srli	a1,a1,0x10
   1e2d0:	01f7d793          	srli	a5,a5,0x1f
   1e2d4:	010ede93          	srli	t4,t4,0x10
   1e2d8:	00d576b3          	and	a3,a0,a3
   1e2dc:	01f8d893          	srli	a7,a7,0x1f
   1e2e0:	02a71063          	bne	a4,a0,1e300 <__letf2+0x74>
   1e2e4:	00cf6fb3          	or	t6,t5,a2
   1e2e8:	010fefb3          	or	t6,t6,a6
   1e2ec:	00bfefb3          	or	t6,t6,a1
   1e2f0:	00200513          	li	a0,2
   1e2f4:	0e0f8063          	beqz	t6,1e3d4 <__letf2+0x148>
   1e2f8:	01010113          	addi	sp,sp,16
   1e2fc:	00008067          	ret
   1e300:	02a69863          	bne	a3,a0,1e330 <__letf2+0xa4>
   1e304:	0062efb3          	or	t6,t0,t1
   1e308:	01cfefb3          	or	t6,t6,t3
   1e30c:	01dfefb3          	or	t6,t6,t4
   1e310:	00200513          	li	a0,2
   1e314:	fe0f92e3          	bnez	t6,1e2f8 <__letf2+0x6c>
   1e318:	04071263          	bnez	a4,1e35c <__letf2+0xd0>
   1e31c:	00cf6533          	or	a0,t5,a2
   1e320:	01056533          	or	a0,a0,a6
   1e324:	00b56533          	or	a0,a0,a1
   1e328:	00153513          	seqz	a0,a0
   1e32c:	02c0006f          	j	1e358 <__letf2+0xcc>
   1e330:	0a071463          	bnez	a4,1e3d8 <__letf2+0x14c>
   1e334:	00cf6533          	or	a0,t5,a2
   1e338:	01056533          	or	a0,a0,a6
   1e33c:	00b56533          	or	a0,a0,a1
   1e340:	00153513          	seqz	a0,a0
   1e344:	00069a63          	bnez	a3,1e358 <__letf2+0xcc>
   1e348:	0062efb3          	or	t6,t0,t1
   1e34c:	01cfefb3          	or	t6,t6,t3
   1e350:	01dfefb3          	or	t6,t6,t4
   1e354:	060f8c63          	beqz	t6,1e3cc <__letf2+0x140>
   1e358:	00051a63          	bnez	a0,1e36c <__letf2+0xe0>
   1e35c:	01178e63          	beq	a5,a7,1e378 <__letf2+0xec>
   1e360:	00100513          	li	a0,1
   1e364:	f8078ae3          	beqz	a5,1e2f8 <__letf2+0x6c>
   1e368:	0080006f          	j	1e370 <__letf2+0xe4>
   1e36c:	f80896e3          	bnez	a7,1e2f8 <__letf2+0x6c>
   1e370:	fff00513          	li	a0,-1
   1e374:	f85ff06f          	j	1e2f8 <__letf2+0x6c>
   1e378:	fee6c4e3          	blt	a3,a4,1e360 <__letf2+0xd4>
   1e37c:	00d75a63          	ble	a3,a4,1e390 <__letf2+0x104>
   1e380:	fff00513          	li	a0,-1
   1e384:	f6078ae3          	beqz	a5,1e2f8 <__letf2+0x6c>
   1e388:	00100513          	li	a0,1
   1e38c:	f6dff06f          	j	1e2f8 <__letf2+0x6c>
   1e390:	fcbee8e3          	bltu	t4,a1,1e360 <__letf2+0xd4>
   1e394:	03d59663          	bne	a1,t4,1e3c0 <__letf2+0x134>
   1e398:	fd0e64e3          	bltu	t3,a6,1e360 <__letf2+0xd4>
   1e39c:	05c81463          	bne	a6,t3,1e3e4 <__letf2+0x158>
   1e3a0:	fcc360e3          	bltu	t1,a2,1e360 <__letf2+0xd4>
   1e3a4:	00661463          	bne	a2,t1,1e3ac <__letf2+0x120>
   1e3a8:	fbe2ece3          	bltu	t0,t5,1e360 <__letf2+0xd4>
   1e3ac:	fc666ae3          	bltu	a2,t1,1e380 <__letf2+0xf4>
   1e3b0:	00000513          	li	a0,0
   1e3b4:	f46612e3          	bne	a2,t1,1e2f8 <__letf2+0x6c>
   1e3b8:	fc5f64e3          	bltu	t5,t0,1e380 <__letf2+0xf4>
   1e3bc:	f3dff06f          	j	1e2f8 <__letf2+0x6c>
   1e3c0:	fdd5e0e3          	bltu	a1,t4,1e380 <__letf2+0xf4>
   1e3c4:	00000513          	li	a0,0
   1e3c8:	f31ff06f          	j	1e2f8 <__letf2+0x6c>
   1e3cc:	fe051ce3          	bnez	a0,1e3c4 <__letf2+0x138>
   1e3d0:	f91ff06f          	j	1e360 <__letf2+0xd4>
   1e3d4:	f2e688e3          	beq	a3,a4,1e304 <__letf2+0x78>
   1e3d8:	00000513          	li	a0,0
   1e3dc:	f60686e3          	beqz	a3,1e348 <__letf2+0xbc>
   1e3e0:	f7dff06f          	j	1e35c <__letf2+0xd0>
   1e3e4:	f9c86ee3          	bltu	a6,t3,1e380 <__letf2+0xf4>
   1e3e8:	fddff06f          	j	1e3c4 <__letf2+0x138>

0001e3ec <__multf3>:
   1e3ec:	f2010113          	addi	sp,sp,-224
   1e3f0:	0d312623          	sw	s3,204(sp)
   1e3f4:	00c5a983          	lw	s3,12(a1)
   1e3f8:	0005a683          	lw	a3,0(a1)
   1e3fc:	0045a783          	lw	a5,4(a1)
   1e400:	00a12a23          	sw	a0,20(sp)
   1e404:	0085a503          	lw	a0,8(a1)
   1e408:	01099713          	slli	a4,s3,0x10
   1e40c:	0d212823          	sw	s2,208(sp)
   1e410:	0d412423          	sw	s4,200(sp)
   1e414:	0d512223          	sw	s5,196(sp)
   1e418:	0d612023          	sw	s6,192(sp)
   1e41c:	00062a03          	lw	s4,0(a2)
   1e420:	00462b03          	lw	s6,4(a2)
   1e424:	00862a83          	lw	s5,8(a2)
   1e428:	00c62903          	lw	s2,12(a2)
   1e42c:	00008637          	lui	a2,0x8
   1e430:	0c812c23          	sw	s0,216(sp)
   1e434:	01075713          	srli	a4,a4,0x10
   1e438:	0109d413          	srli	s0,s3,0x10
   1e43c:	fff60613          	addi	a2,a2,-1 # 7fff <main-0x8075>
   1e440:	09312623          	sw	s3,140(sp)
   1e444:	0c112e23          	sw	ra,220(sp)
   1e448:	0c912a23          	sw	s1,212(sp)
   1e44c:	0b712e23          	sw	s7,188(sp)
   1e450:	0b812c23          	sw	s8,184(sp)
   1e454:	0b912a23          	sw	s9,180(sp)
   1e458:	0ba12823          	sw	s10,176(sp)
   1e45c:	0bb12623          	sw	s11,172(sp)
   1e460:	08d12023          	sw	a3,128(sp)
   1e464:	08f12223          	sw	a5,132(sp)
   1e468:	08a12423          	sw	a0,136(sp)
   1e46c:	04d12823          	sw	a3,80(sp)
   1e470:	04f12a23          	sw	a5,84(sp)
   1e474:	04a12c23          	sw	a0,88(sp)
   1e478:	04e12e23          	sw	a4,92(sp)
   1e47c:	00867433          	and	s0,a2,s0
   1e480:	01f9d993          	srli	s3,s3,0x1f
   1e484:	12040863          	beqz	s0,1e5b4 <__multf3+0x1c8>
   1e488:	24c40e63          	beq	s0,a2,1e6e4 <__multf3+0x2f8>
   1e48c:	00010537          	lui	a0,0x10
   1e490:	00a76533          	or	a0,a4,a0
   1e494:	04a12e23          	sw	a0,92(sp)
   1e498:	05010613          	addi	a2,sp,80
   1e49c:	05c10793          	addi	a5,sp,92
   1e4a0:	0007a703          	lw	a4,0(a5)
   1e4a4:	ffc7a683          	lw	a3,-4(a5)
   1e4a8:	ffc78793          	addi	a5,a5,-4
   1e4ac:	00371713          	slli	a4,a4,0x3
   1e4b0:	01d6d693          	srli	a3,a3,0x1d
   1e4b4:	00d76733          	or	a4,a4,a3
   1e4b8:	00e7a223          	sw	a4,4(a5)
   1e4bc:	fef612e3          	bne	a2,a5,1e4a0 <__multf3+0xb4>
   1e4c0:	05012783          	lw	a5,80(sp)
   1e4c4:	00379793          	slli	a5,a5,0x3
   1e4c8:	04f12823          	sw	a5,80(sp)
   1e4cc:	ffffc7b7          	lui	a5,0xffffc
   1e4d0:	00178793          	addi	a5,a5,1 # ffffc001 <__global_pointer$+0xfffd78a1>
   1e4d4:	00f40433          	add	s0,s0,a5
   1e4d8:	00000493          	li	s1,0
   1e4dc:	01091513          	slli	a0,s2,0x10
   1e4e0:	00008737          	lui	a4,0x8
   1e4e4:	01095793          	srli	a5,s2,0x10
   1e4e8:	01055513          	srli	a0,a0,0x10
   1e4ec:	fff70713          	addi	a4,a4,-1 # 7fff <main-0x8075>
   1e4f0:	09212623          	sw	s2,140(sp)
   1e4f4:	09412023          	sw	s4,128(sp)
   1e4f8:	09612223          	sw	s6,132(sp)
   1e4fc:	09512423          	sw	s5,136(sp)
   1e500:	07412023          	sw	s4,96(sp)
   1e504:	07612223          	sw	s6,100(sp)
   1e508:	07512423          	sw	s5,104(sp)
   1e50c:	06a12623          	sw	a0,108(sp)
   1e510:	00f777b3          	and	a5,a4,a5
   1e514:	01f95913          	srli	s2,s2,0x1f
   1e518:	1e078a63          	beqz	a5,1e70c <__multf3+0x320>
   1e51c:	32e78063          	beq	a5,a4,1e83c <__multf3+0x450>
   1e520:	00010ab7          	lui	s5,0x10
   1e524:	01556533          	or	a0,a0,s5
   1e528:	06a12623          	sw	a0,108(sp)
   1e52c:	06010593          	addi	a1,sp,96
   1e530:	06c10713          	addi	a4,sp,108
   1e534:	00072683          	lw	a3,0(a4)
   1e538:	ffc72603          	lw	a2,-4(a4)
   1e53c:	ffc70713          	addi	a4,a4,-4
   1e540:	00369693          	slli	a3,a3,0x3
   1e544:	01d65613          	srli	a2,a2,0x1d
   1e548:	00c6e6b3          	or	a3,a3,a2
   1e54c:	00d72223          	sw	a3,4(a4)
   1e550:	fee592e3          	bne	a1,a4,1e534 <__multf3+0x148>
   1e554:	06012703          	lw	a4,96(sp)
   1e558:	00371713          	slli	a4,a4,0x3
   1e55c:	06e12023          	sw	a4,96(sp)
   1e560:	ffffc737          	lui	a4,0xffffc
   1e564:	00170713          	addi	a4,a4,1 # ffffc001 <__global_pointer$+0xfffd78a1>
   1e568:	00e787b3          	add	a5,a5,a4
   1e56c:	00000713          	li	a4,0
   1e570:	008787b3          	add	a5,a5,s0
   1e574:	02f12623          	sw	a5,44(sp)
   1e578:	00178793          	addi	a5,a5,1
   1e57c:	02f12423          	sw	a5,40(sp)
   1e580:	00249793          	slli	a5,s1,0x2
   1e584:	0129c6b3          	xor	a3,s3,s2
   1e588:	00e7e7b3          	or	a5,a5,a4
   1e58c:	00d12c23          	sw	a3,24(sp)
   1e590:	fff78793          	addi	a5,a5,-1
   1e594:	00e00693          	li	a3,14
   1e598:	2cf6e663          	bltu	a3,a5,1e864 <__multf3+0x478>
   1e59c:	000226b7          	lui	a3,0x22
   1e5a0:	00279793          	slli	a5,a5,0x2
   1e5a4:	31068693          	addi	a3,a3,784 # 22310 <zeroes.4339+0x88>
   1e5a8:	00d787b3          	add	a5,a5,a3
   1e5ac:	0007a783          	lw	a5,0(a5)
   1e5b0:	00078067          	jr	a5
   1e5b4:	00d7e633          	or	a2,a5,a3
   1e5b8:	00a66633          	or	a2,a2,a0
   1e5bc:	00e66633          	or	a2,a2,a4
   1e5c0:	14060063          	beqz	a2,1e700 <__multf3+0x314>
   1e5c4:	06070063          	beqz	a4,1e624 <__multf3+0x238>
   1e5c8:	00070513          	mv	a0,a4
   1e5cc:	0b8030ef          	jal	ra,21684 <__clzsi2>
   1e5d0:	00050c13          	mv	s8,a0
   1e5d4:	ff4c0b93          	addi	s7,s8,-12
   1e5d8:	405bd493          	srai	s1,s7,0x5
   1e5dc:	01fbfb93          	andi	s7,s7,31
   1e5e0:	060b8c63          	beqz	s7,1e658 <__multf3+0x26c>
   1e5e4:	ffc00593          	li	a1,-4
   1e5e8:	00048513          	mv	a0,s1
   1e5ec:	7c1020ef          	jal	ra,215ac <__mulsi3>
   1e5f0:	02000693          	li	a3,32
   1e5f4:	00249713          	slli	a4,s1,0x2
   1e5f8:	ff000813          	li	a6,-16
   1e5fc:	417686b3          	sub	a3,a3,s7
   1e600:	ffc50513          	addi	a0,a0,-4 # fffc <main-0x78>
   1e604:	09051e63          	bne	a0,a6,1e6a0 <__multf3+0x2b4>
   1e608:	0a010793          	addi	a5,sp,160
   1e60c:	00e78733          	add	a4,a5,a4
   1e610:	05012783          	lw	a5,80(sp)
   1e614:	fff48493          	addi	s1,s1,-1
   1e618:	01779bb3          	sll	s7,a5,s7
   1e61c:	fb772823          	sw	s7,-80(a4)
   1e620:	0680006f          	j	1e688 <__multf3+0x29c>
   1e624:	00050863          	beqz	a0,1e634 <__multf3+0x248>
   1e628:	05c030ef          	jal	ra,21684 <__clzsi2>
   1e62c:	02050c13          	addi	s8,a0,32
   1e630:	fa5ff06f          	j	1e5d4 <__multf3+0x1e8>
   1e634:	00078a63          	beqz	a5,1e648 <__multf3+0x25c>
   1e638:	00078513          	mv	a0,a5
   1e63c:	048030ef          	jal	ra,21684 <__clzsi2>
   1e640:	04050c13          	addi	s8,a0,64
   1e644:	f91ff06f          	j	1e5d4 <__multf3+0x1e8>
   1e648:	00068513          	mv	a0,a3
   1e64c:	038030ef          	jal	ra,21684 <__clzsi2>
   1e650:	06050c13          	addi	s8,a0,96
   1e654:	f81ff06f          	j	1e5d4 <__multf3+0x1e8>
   1e658:	ffc00593          	li	a1,-4
   1e65c:	00048513          	mv	a0,s1
   1e660:	74d020ef          	jal	ra,215ac <__mulsi3>
   1e664:	05010413          	addi	s0,sp,80
   1e668:	00300793          	li	a5,3
   1e66c:	00a40733          	add	a4,s0,a0
   1e670:	00c72703          	lw	a4,12(a4)
   1e674:	fff78793          	addi	a5,a5,-1
   1e678:	ffc40413          	addi	s0,s0,-4 # 7fffc <__global_pointer$+0x5b89c>
   1e67c:	00e42823          	sw	a4,16(s0)
   1e680:	fe97d6e3          	ble	s1,a5,1e66c <__multf3+0x280>
   1e684:	fff48493          	addi	s1,s1,-1
   1e688:	fff00713          	li	a4,-1
   1e68c:	04e49063          	bne	s1,a4,1e6cc <__multf3+0x2e0>
   1e690:	ffffc437          	lui	s0,0xffffc
   1e694:	01140413          	addi	s0,s0,17 # ffffc011 <__global_pointer$+0xfffd78b1>
   1e698:	41840433          	sub	s0,s0,s8
   1e69c:	e3dff06f          	j	1e4d8 <__multf3+0xec>
   1e6a0:	05010793          	addi	a5,sp,80
   1e6a4:	00a785b3          	add	a1,a5,a0
   1e6a8:	00a70633          	add	a2,a4,a0
   1e6ac:	00c78633          	add	a2,a5,a2
   1e6b0:	00c5a783          	lw	a5,12(a1)
   1e6b4:	0105a583          	lw	a1,16(a1)
   1e6b8:	00d7d7b3          	srl	a5,a5,a3
   1e6bc:	017595b3          	sll	a1,a1,s7
   1e6c0:	00b7e7b3          	or	a5,a5,a1
   1e6c4:	00f62823          	sw	a5,16(a2)
   1e6c8:	f39ff06f          	j	1e600 <__multf3+0x214>
   1e6cc:	00249793          	slli	a5,s1,0x2
   1e6d0:	05010693          	addi	a3,sp,80
   1e6d4:	00f687b3          	add	a5,a3,a5
   1e6d8:	0007a023          	sw	zero,0(a5)
   1e6dc:	fff48493          	addi	s1,s1,-1
   1e6e0:	fadff06f          	j	1e68c <__multf3+0x2a0>
   1e6e4:	00d7e7b3          	or	a5,a5,a3
   1e6e8:	00a7e7b3          	or	a5,a5,a0
   1e6ec:	00e7e533          	or	a0,a5,a4
   1e6f0:	00200493          	li	s1,2
   1e6f4:	de0504e3          	beqz	a0,1e4dc <__multf3+0xf0>
   1e6f8:	00300493          	li	s1,3
   1e6fc:	de1ff06f          	j	1e4dc <__multf3+0xf0>
   1e700:	00000413          	li	s0,0
   1e704:	00100493          	li	s1,1
   1e708:	dd5ff06f          	j	1e4dc <__multf3+0xf0>
   1e70c:	016a67b3          	or	a5,s4,s6
   1e710:	0157e7b3          	or	a5,a5,s5
   1e714:	00a7e7b3          	or	a5,a5,a0
   1e718:	14078063          	beqz	a5,1e858 <__multf3+0x46c>
   1e71c:	04050e63          	beqz	a0,1e778 <__multf3+0x38c>
   1e720:	765020ef          	jal	ra,21684 <__clzsi2>
   1e724:	00050b13          	mv	s6,a0
   1e728:	ff4b0a93          	addi	s5,s6,-12
   1e72c:	405ada13          	srai	s4,s5,0x5
   1e730:	01fafa93          	andi	s5,s5,31
   1e734:	060a8e63          	beqz	s5,1e7b0 <__multf3+0x3c4>
   1e738:	ffc00593          	li	a1,-4
   1e73c:	000a0513          	mv	a0,s4
   1e740:	66d020ef          	jal	ra,215ac <__mulsi3>
   1e744:	02000693          	li	a3,32
   1e748:	002a1713          	slli	a4,s4,0x2
   1e74c:	ff000813          	li	a6,-16
   1e750:	415686b3          	sub	a3,a3,s5
   1e754:	ffc50513          	addi	a0,a0,-4
   1e758:	0b051063          	bne	a0,a6,1e7f8 <__multf3+0x40c>
   1e75c:	0a010793          	addi	a5,sp,160
   1e760:	00e78733          	add	a4,a5,a4
   1e764:	06012783          	lw	a5,96(sp)
   1e768:	fffa0a13          	addi	s4,s4,-1
   1e76c:	01579ab3          	sll	s5,a5,s5
   1e770:	fd572023          	sw	s5,-64(a4)
   1e774:	06c0006f          	j	1e7e0 <__multf3+0x3f4>
   1e778:	000a8a63          	beqz	s5,1e78c <__multf3+0x3a0>
   1e77c:	000a8513          	mv	a0,s5
   1e780:	705020ef          	jal	ra,21684 <__clzsi2>
   1e784:	02050b13          	addi	s6,a0,32
   1e788:	fa1ff06f          	j	1e728 <__multf3+0x33c>
   1e78c:	000b0a63          	beqz	s6,1e7a0 <__multf3+0x3b4>
   1e790:	000b0513          	mv	a0,s6
   1e794:	6f1020ef          	jal	ra,21684 <__clzsi2>
   1e798:	04050b13          	addi	s6,a0,64
   1e79c:	f8dff06f          	j	1e728 <__multf3+0x33c>
   1e7a0:	000a0513          	mv	a0,s4
   1e7a4:	6e1020ef          	jal	ra,21684 <__clzsi2>
   1e7a8:	06050b13          	addi	s6,a0,96
   1e7ac:	f7dff06f          	j	1e728 <__multf3+0x33c>
   1e7b0:	ffc00593          	li	a1,-4
   1e7b4:	000a0513          	mv	a0,s4
   1e7b8:	5f5020ef          	jal	ra,215ac <__mulsi3>
   1e7bc:	06010a93          	addi	s5,sp,96
   1e7c0:	00300793          	li	a5,3
   1e7c4:	00aa8733          	add	a4,s5,a0
   1e7c8:	00c72703          	lw	a4,12(a4)
   1e7cc:	fff78793          	addi	a5,a5,-1
   1e7d0:	ffca8a93          	addi	s5,s5,-4 # fffc <main-0x78>
   1e7d4:	00eaa823          	sw	a4,16(s5)
   1e7d8:	ff47d6e3          	ble	s4,a5,1e7c4 <__multf3+0x3d8>
   1e7dc:	fffa0a13          	addi	s4,s4,-1
   1e7e0:	fff00713          	li	a4,-1
   1e7e4:	04ea1063          	bne	s4,a4,1e824 <__multf3+0x438>
   1e7e8:	ffffc7b7          	lui	a5,0xffffc
   1e7ec:	01178793          	addi	a5,a5,17 # ffffc011 <__global_pointer$+0xfffd78b1>
   1e7f0:	416787b3          	sub	a5,a5,s6
   1e7f4:	d79ff06f          	j	1e56c <__multf3+0x180>
   1e7f8:	06010793          	addi	a5,sp,96
   1e7fc:	00a785b3          	add	a1,a5,a0
   1e800:	00a70633          	add	a2,a4,a0
   1e804:	00c78633          	add	a2,a5,a2
   1e808:	00c5a783          	lw	a5,12(a1)
   1e80c:	0105a583          	lw	a1,16(a1)
   1e810:	00d7d7b3          	srl	a5,a5,a3
   1e814:	015595b3          	sll	a1,a1,s5
   1e818:	00b7e7b3          	or	a5,a5,a1
   1e81c:	00f62823          	sw	a5,16(a2)
   1e820:	f35ff06f          	j	1e754 <__multf3+0x368>
   1e824:	002a1793          	slli	a5,s4,0x2
   1e828:	06010693          	addi	a3,sp,96
   1e82c:	00f687b3          	add	a5,a3,a5
   1e830:	0007a023          	sw	zero,0(a5)
   1e834:	fffa0a13          	addi	s4,s4,-1
   1e838:	fadff06f          	j	1e7e4 <__multf3+0x3f8>
   1e83c:	016a6a33          	or	s4,s4,s6
   1e840:	015a6ab3          	or	s5,s4,s5
   1e844:	00aae533          	or	a0,s5,a0
   1e848:	00200713          	li	a4,2
   1e84c:	d20502e3          	beqz	a0,1e570 <__multf3+0x184>
   1e850:	00300713          	li	a4,3
   1e854:	d1dff06f          	j	1e570 <__multf3+0x184>
   1e858:	00000793          	li	a5,0
   1e85c:	00100713          	li	a4,1
   1e860:	d11ff06f          	j	1e570 <__multf3+0x184>
   1e864:	05012983          	lw	s3,80(sp)
   1e868:	06012403          	lw	s0,96(sp)
   1e86c:	00010b37          	lui	s6,0x10
   1e870:	fffb0493          	addi	s1,s6,-1 # ffff <main-0x75>
   1e874:	0109da93          	srli	s5,s3,0x10
   1e878:	01045913          	srli	s2,s0,0x10
   1e87c:	0099f9b3          	and	s3,s3,s1
   1e880:	00947433          	and	s0,s0,s1
   1e884:	00040593          	mv	a1,s0
   1e888:	00098513          	mv	a0,s3
   1e88c:	521020ef          	jal	ra,215ac <__mulsi3>
   1e890:	00050a13          	mv	s4,a0
   1e894:	00040593          	mv	a1,s0
   1e898:	000a8513          	mv	a0,s5
   1e89c:	511020ef          	jal	ra,215ac <__mulsi3>
   1e8a0:	00050c13          	mv	s8,a0
   1e8a4:	00090593          	mv	a1,s2
   1e8a8:	000a8513          	mv	a0,s5
   1e8ac:	501020ef          	jal	ra,215ac <__mulsi3>
   1e8b0:	00050b93          	mv	s7,a0
   1e8b4:	00098593          	mv	a1,s3
   1e8b8:	00090513          	mv	a0,s2
   1e8bc:	4f1020ef          	jal	ra,215ac <__mulsi3>
   1e8c0:	01850533          	add	a0,a0,s8
   1e8c4:	010a5793          	srli	a5,s4,0x10
   1e8c8:	00a78533          	add	a0,a5,a0
   1e8cc:	01857463          	bleu	s8,a0,1e8d4 <__multf3+0x4e8>
   1e8d0:	016b8bb3          	add	s7,s7,s6
   1e8d4:	01055c93          	srli	s9,a0,0x10
   1e8d8:	00957533          	and	a0,a0,s1
   1e8dc:	009a7a33          	and	s4,s4,s1
   1e8e0:	01051513          	slli	a0,a0,0x10
   1e8e4:	014507b3          	add	a5,a0,s4
   1e8e8:	02f12823          	sw	a5,48(sp)
   1e8ec:	08f12023          	sw	a5,128(sp)
   1e8f0:	06412783          	lw	a5,100(sp)
   1e8f4:	00098513          	mv	a0,s3
   1e8f8:	0107da13          	srli	s4,a5,0x10
   1e8fc:	0097f7b3          	and	a5,a5,s1
   1e900:	00078593          	mv	a1,a5
   1e904:	00f12423          	sw	a5,8(sp)
   1e908:	4a5020ef          	jal	ra,215ac <__mulsi3>
   1e90c:	00812583          	lw	a1,8(sp)
   1e910:	00050b13          	mv	s6,a0
   1e914:	000a8513          	mv	a0,s5
   1e918:	495020ef          	jal	ra,215ac <__mulsi3>
   1e91c:	00050493          	mv	s1,a0
   1e920:	000a0593          	mv	a1,s4
   1e924:	000a8513          	mv	a0,s5
   1e928:	485020ef          	jal	ra,215ac <__mulsi3>
   1e92c:	00050c13          	mv	s8,a0
   1e930:	00098593          	mv	a1,s3
   1e934:	000a0513          	mv	a0,s4
   1e938:	475020ef          	jal	ra,215ac <__mulsi3>
   1e93c:	00950533          	add	a0,a0,s1
   1e940:	010b5793          	srli	a5,s6,0x10
   1e944:	00a78533          	add	a0,a5,a0
   1e948:	00957663          	bleu	s1,a0,1e954 <__multf3+0x568>
   1e94c:	000107b7          	lui	a5,0x10
   1e950:	00fc0c33          	add	s8,s8,a5
   1e954:	00010737          	lui	a4,0x10
   1e958:	fff70493          	addi	s1,a4,-1 # ffff <main-0x75>
   1e95c:	00957d33          	and	s10,a0,s1
   1e960:	009b7b33          	and	s6,s6,s1
   1e964:	010d1d13          	slli	s10,s10,0x10
   1e968:	01055793          	srli	a5,a0,0x10
   1e96c:	016d0d33          	add	s10,s10,s6
   1e970:	00f12e23          	sw	a5,28(sp)
   1e974:	01ac87b3          	add	a5,s9,s10
   1e978:	02f12a23          	sw	a5,52(sp)
   1e97c:	05412783          	lw	a5,84(sp)
   1e980:	00040513          	mv	a0,s0
   1e984:	00e12223          	sw	a4,4(sp)
   1e988:	0097f4b3          	and	s1,a5,s1
   1e98c:	00048593          	mv	a1,s1
   1e990:	0107dc93          	srli	s9,a5,0x10
   1e994:	419020ef          	jal	ra,215ac <__mulsi3>
   1e998:	00050b13          	mv	s6,a0
   1e99c:	00040593          	mv	a1,s0
   1e9a0:	000c8513          	mv	a0,s9
   1e9a4:	409020ef          	jal	ra,215ac <__mulsi3>
   1e9a8:	00a12023          	sw	a0,0(sp)
   1e9ac:	000c8593          	mv	a1,s9
   1e9b0:	00090513          	mv	a0,s2
   1e9b4:	3f9020ef          	jal	ra,215ac <__mulsi3>
   1e9b8:	00050d93          	mv	s11,a0
   1e9bc:	00048593          	mv	a1,s1
   1e9c0:	00090513          	mv	a0,s2
   1e9c4:	3e9020ef          	jal	ra,215ac <__mulsi3>
   1e9c8:	00012683          	lw	a3,0(sp)
   1e9cc:	010b5793          	srli	a5,s6,0x10
   1e9d0:	00d50533          	add	a0,a0,a3
   1e9d4:	00a78533          	add	a0,a5,a0
   1e9d8:	00d57663          	bleu	a3,a0,1e9e4 <__multf3+0x5f8>
   1e9dc:	00412703          	lw	a4,4(sp)
   1e9e0:	00ed8db3          	add	s11,s11,a4
   1e9e4:	01055793          	srli	a5,a0,0x10
   1e9e8:	000106b7          	lui	a3,0x10
   1e9ec:	01b787b3          	add	a5,a5,s11
   1e9f0:	02f12023          	sw	a5,32(sp)
   1e9f4:	fff68793          	addi	a5,a3,-1 # ffff <main-0x75>
   1e9f8:	00f57db3          	and	s11,a0,a5
   1e9fc:	00812503          	lw	a0,8(sp)
   1ea00:	00048593          	mv	a1,s1
   1ea04:	00fb7b33          	and	s6,s6,a5
   1ea08:	00d12623          	sw	a3,12(sp)
   1ea0c:	3a1020ef          	jal	ra,215ac <__mulsi3>
   1ea10:	00812583          	lw	a1,8(sp)
   1ea14:	00a12223          	sw	a0,4(sp)
   1ea18:	000c8513          	mv	a0,s9
   1ea1c:	391020ef          	jal	ra,215ac <__mulsi3>
   1ea20:	00a12023          	sw	a0,0(sp)
   1ea24:	000c8593          	mv	a1,s9
   1ea28:	000a0513          	mv	a0,s4
   1ea2c:	381020ef          	jal	ra,215ac <__mulsi3>
   1ea30:	010d9d93          	slli	s11,s11,0x10
   1ea34:	016d8db3          	add	s11,s11,s6
   1ea38:	00048593          	mv	a1,s1
   1ea3c:	00050b13          	mv	s6,a0
   1ea40:	000a0513          	mv	a0,s4
   1ea44:	369020ef          	jal	ra,215ac <__mulsi3>
   1ea48:	00012603          	lw	a2,0(sp)
   1ea4c:	00412703          	lw	a4,4(sp)
   1ea50:	00c50533          	add	a0,a0,a2
   1ea54:	01075793          	srli	a5,a4,0x10
   1ea58:	00a78533          	add	a0,a5,a0
   1ea5c:	00c57663          	bleu	a2,a0,1ea68 <__multf3+0x67c>
   1ea60:	00c12683          	lw	a3,12(sp)
   1ea64:	00db0b33          	add	s6,s6,a3
   1ea68:	01055793          	srli	a5,a0,0x10
   1ea6c:	00010637          	lui	a2,0x10
   1ea70:	016787b3          	add	a5,a5,s6
   1ea74:	02f12223          	sw	a5,36(sp)
   1ea78:	fff60793          	addi	a5,a2,-1 # ffff <main-0x75>
   1ea7c:	00f57b33          	and	s6,a0,a5
   1ea80:	00f77733          	and	a4,a4,a5
   1ea84:	010b1b13          	slli	s6,s6,0x10
   1ea88:	00eb0b33          	add	s6,s6,a4
   1ea8c:	06812703          	lw	a4,104(sp)
   1ea90:	00098513          	mv	a0,s3
   1ea94:	02c12e23          	sw	a2,60(sp)
   1ea98:	00f777b3          	and	a5,a4,a5
   1ea9c:	01075693          	srli	a3,a4,0x10
   1eaa0:	00078593          	mv	a1,a5
   1eaa4:	00d12023          	sw	a3,0(sp)
   1eaa8:	00f12623          	sw	a5,12(sp)
   1eaac:	301020ef          	jal	ra,215ac <__mulsi3>
   1eab0:	00c12583          	lw	a1,12(sp)
   1eab4:	02a12c23          	sw	a0,56(sp)
   1eab8:	000a8513          	mv	a0,s5
   1eabc:	2f1020ef          	jal	ra,215ac <__mulsi3>
   1eac0:	00012583          	lw	a1,0(sp)
   1eac4:	00a12823          	sw	a0,16(sp)
   1eac8:	000a8513          	mv	a0,s5
   1eacc:	2e1020ef          	jal	ra,215ac <__mulsi3>
   1ead0:	00a12223          	sw	a0,4(sp)
   1ead4:	00012503          	lw	a0,0(sp)
   1ead8:	00098593          	mv	a1,s3
   1eadc:	2d1020ef          	jal	ra,215ac <__mulsi3>
   1eae0:	01012803          	lw	a6,16(sp)
   1eae4:	03812703          	lw	a4,56(sp)
   1eae8:	00412683          	lw	a3,4(sp)
   1eaec:	01050533          	add	a0,a0,a6
   1eaf0:	01075793          	srli	a5,a4,0x10
   1eaf4:	00a78533          	add	a0,a5,a0
   1eaf8:	01057663          	bleu	a6,a0,1eb04 <__multf3+0x718>
   1eafc:	03c12603          	lw	a2,60(sp)
   1eb00:	00c686b3          	add	a3,a3,a2
   1eb04:	00010837          	lui	a6,0x10
   1eb08:	01055793          	srli	a5,a0,0x10
   1eb0c:	00d786b3          	add	a3,a5,a3
   1eb10:	fff80793          	addi	a5,a6,-1 # ffff <main-0x75>
   1eb14:	00f57633          	and	a2,a0,a5
   1eb18:	00f77733          	and	a4,a4,a5
   1eb1c:	01061613          	slli	a2,a2,0x10
   1eb20:	00e60633          	add	a2,a2,a4
   1eb24:	05812703          	lw	a4,88(sp)
   1eb28:	04d12623          	sw	a3,76(sp)
   1eb2c:	00040513          	mv	a0,s0
   1eb30:	00f777b3          	and	a5,a4,a5
   1eb34:	01075693          	srli	a3,a4,0x10
   1eb38:	00078593          	mv	a1,a5
   1eb3c:	04c12223          	sw	a2,68(sp)
   1eb40:	00d12223          	sw	a3,4(sp)
   1eb44:	00f12823          	sw	a5,16(sp)
   1eb48:	05012423          	sw	a6,72(sp)
   1eb4c:	261020ef          	jal	ra,215ac <__mulsi3>
   1eb50:	04a12023          	sw	a0,64(sp)
   1eb54:	00412503          	lw	a0,4(sp)
   1eb58:	00040593          	mv	a1,s0
   1eb5c:	251020ef          	jal	ra,215ac <__mulsi3>
   1eb60:	00412583          	lw	a1,4(sp)
   1eb64:	02a12e23          	sw	a0,60(sp)
   1eb68:	00090513          	mv	a0,s2
   1eb6c:	241020ef          	jal	ra,215ac <__mulsi3>
   1eb70:	01012583          	lw	a1,16(sp)
   1eb74:	02a12c23          	sw	a0,56(sp)
   1eb78:	00090513          	mv	a0,s2
   1eb7c:	231020ef          	jal	ra,215ac <__mulsi3>
   1eb80:	03c12883          	lw	a7,60(sp)
   1eb84:	04012303          	lw	t1,64(sp)
   1eb88:	03812703          	lw	a4,56(sp)
   1eb8c:	01150533          	add	a0,a0,a7
   1eb90:	01035793          	srli	a5,t1,0x10
   1eb94:	00a787b3          	add	a5,a5,a0
   1eb98:	04412603          	lw	a2,68(sp)
   1eb9c:	04c12683          	lw	a3,76(sp)
   1eba0:	0117f663          	bleu	a7,a5,1ebac <__multf3+0x7c0>
   1eba4:	04812803          	lw	a6,72(sp)
   1eba8:	01070733          	add	a4,a4,a6
   1ebac:	0107d813          	srli	a6,a5,0x10
   1ebb0:	00e80833          	add	a6,a6,a4
   1ebb4:	00010737          	lui	a4,0x10
   1ebb8:	fff70593          	addi	a1,a4,-1 # ffff <main-0x75>
   1ebbc:	00b7f7b3          	and	a5,a5,a1
   1ebc0:	00b37333          	and	t1,t1,a1
   1ebc4:	01079793          	slli	a5,a5,0x10
   1ebc8:	00678e33          	add	t3,a5,t1
   1ebcc:	03412783          	lw	a5,52(sp)
   1ebd0:	02e12c23          	sw	a4,56(sp)
   1ebd4:	02012703          	lw	a4,32(sp)
   1ebd8:	00fb8bb3          	add	s7,s7,a5
   1ebdc:	01c12783          	lw	a5,28(sp)
   1ebe0:	01abbd33          	sltu	s10,s7,s10
   1ebe4:	01a788b3          	add	a7,a5,s10
   1ebe8:	01bb87b3          	add	a5,s7,s11
   1ebec:	01b7bdb3          	sltu	s11,a5,s11
   1ebf0:	00f12e23          	sw	a5,28(sp)
   1ebf4:	08f12223          	sw	a5,132(sp)
   1ebf8:	02012783          	lw	a5,32(sp)
   1ebfc:	018888b3          	add	a7,a7,s8
   1ec00:	00f887b3          	add	a5,a7,a5
   1ec04:	01b78c33          	add	s8,a5,s11
   1ec08:	016c0333          	add	t1,s8,s6
   1ec0c:	00e7b7b3          	sltu	a5,a5,a4
   1ec10:	01bc3c33          	sltu	s8,s8,s11
   1ec14:	0187ec33          	or	s8,a5,s8
   1ec18:	02412783          	lw	a5,36(sp)
   1ec1c:	01a8b8b3          	sltu	a7,a7,s10
   1ec20:	011c0c33          	add	s8,s8,a7
   1ec24:	02412703          	lw	a4,36(sp)
   1ec28:	01633b33          	sltu	s6,t1,s6
   1ec2c:	00fc0c33          	add	s8,s8,a5
   1ec30:	016c0533          	add	a0,s8,s6
   1ec34:	00c30333          	add	t1,t1,a2
   1ec38:	00d508b3          	add	a7,a0,a3
   1ec3c:	00c33633          	sltu	a2,t1,a2
   1ec40:	01c307b3          	add	a5,t1,t3
   1ec44:	00c88eb3          	add	t4,a7,a2
   1ec48:	00ec3c33          	sltu	s8,s8,a4
   1ec4c:	01653b33          	sltu	s6,a0,s6
   1ec50:	01c7b333          	sltu	t1,a5,t3
   1ec54:	02f12023          	sw	a5,32(sp)
   1ec58:	08f12423          	sw	a5,136(sp)
   1ec5c:	016c6c33          	or	s8,s8,s6
   1ec60:	010e87b3          	add	a5,t4,a6
   1ec64:	06c12b03          	lw	s6,108(sp)
   1ec68:	00d8b6b3          	sltu	a3,a7,a3
   1ec6c:	00ceb633          	sltu	a2,t4,a2
   1ec70:	00678db3          	add	s11,a5,t1
   1ec74:	00c6e6b3          	or	a3,a3,a2
   1ec78:	0107b7b3          	sltu	a5,a5,a6
   1ec7c:	006db333          	sltu	t1,s11,t1
   1ec80:	00dc0c33          	add	s8,s8,a3
   1ec84:	0067e7b3          	or	a5,a5,t1
   1ec88:	010b5b93          	srli	s7,s6,0x10
   1ec8c:	00bb7b33          	and	s6,s6,a1
   1ec90:	00fc07b3          	add	a5,s8,a5
   1ec94:	000b0593          	mv	a1,s6
   1ec98:	00098513          	mv	a0,s3
   1ec9c:	02f12223          	sw	a5,36(sp)
   1eca0:	10d020ef          	jal	ra,215ac <__mulsi3>
   1eca4:	00050c13          	mv	s8,a0
   1eca8:	000b0593          	mv	a1,s6
   1ecac:	000a8513          	mv	a0,s5
   1ecb0:	0fd020ef          	jal	ra,215ac <__mulsi3>
   1ecb4:	00050d13          	mv	s10,a0
   1ecb8:	000b8593          	mv	a1,s7
   1ecbc:	000a8513          	mv	a0,s5
   1ecc0:	0ed020ef          	jal	ra,215ac <__mulsi3>
   1ecc4:	00050a93          	mv	s5,a0
   1ecc8:	00098593          	mv	a1,s3
   1eccc:	000b8513          	mv	a0,s7
   1ecd0:	0dd020ef          	jal	ra,215ac <__mulsi3>
   1ecd4:	01a50533          	add	a0,a0,s10
   1ecd8:	010c5793          	srli	a5,s8,0x10
   1ecdc:	00a78533          	add	a0,a5,a0
   1ece0:	01a57663          	bleu	s10,a0,1ecec <__multf3+0x900>
   1ece4:	03812703          	lw	a4,56(sp)
   1ece8:	00ea8ab3          	add	s5,s5,a4
   1ecec:	01055793          	srli	a5,a0,0x10
   1ecf0:	000106b7          	lui	a3,0x10
   1ecf4:	015787b3          	add	a5,a5,s5
   1ecf8:	02f12a23          	sw	a5,52(sp)
   1ecfc:	05c12a83          	lw	s5,92(sp)
   1ed00:	fff68793          	addi	a5,a3,-1 # ffff <main-0x75>
   1ed04:	00f579b3          	and	s3,a0,a5
   1ed08:	00fc7c33          	and	s8,s8,a5
   1ed0c:	01099993          	slli	s3,s3,0x10
   1ed10:	018989b3          	add	s3,s3,s8
   1ed14:	010adc13          	srli	s8,s5,0x10
   1ed18:	00fafab3          	and	s5,s5,a5
   1ed1c:	000a8593          	mv	a1,s5
   1ed20:	00040513          	mv	a0,s0
   1ed24:	02d12e23          	sw	a3,60(sp)
   1ed28:	085020ef          	jal	ra,215ac <__mulsi3>
   1ed2c:	00040593          	mv	a1,s0
   1ed30:	02a12c23          	sw	a0,56(sp)
   1ed34:	000c0513          	mv	a0,s8
   1ed38:	075020ef          	jal	ra,215ac <__mulsi3>
   1ed3c:	00050413          	mv	s0,a0
   1ed40:	000c0593          	mv	a1,s8
   1ed44:	00090513          	mv	a0,s2
   1ed48:	065020ef          	jal	ra,215ac <__mulsi3>
   1ed4c:	00050d13          	mv	s10,a0
   1ed50:	000a8593          	mv	a1,s5
   1ed54:	00090513          	mv	a0,s2
   1ed58:	055020ef          	jal	ra,215ac <__mulsi3>
   1ed5c:	03812703          	lw	a4,56(sp)
   1ed60:	00850533          	add	a0,a0,s0
   1ed64:	01075793          	srli	a5,a4,0x10
   1ed68:	00a78533          	add	a0,a5,a0
   1ed6c:	00857663          	bleu	s0,a0,1ed78 <__multf3+0x98c>
   1ed70:	03c12683          	lw	a3,60(sp)
   1ed74:	00dd0d33          	add	s10,s10,a3
   1ed78:	000106b7          	lui	a3,0x10
   1ed7c:	01055793          	srli	a5,a0,0x10
   1ed80:	00c12583          	lw	a1,12(sp)
   1ed84:	01a78d33          	add	s10,a5,s10
   1ed88:	fff68793          	addi	a5,a3,-1 # ffff <main-0x75>
   1ed8c:	00f57933          	and	s2,a0,a5
   1ed90:	00f77733          	and	a4,a4,a5
   1ed94:	01091913          	slli	s2,s2,0x10
   1ed98:	00048513          	mv	a0,s1
   1ed9c:	00e90933          	add	s2,s2,a4
   1eda0:	04d12023          	sw	a3,64(sp)
   1eda4:	009020ef          	jal	ra,215ac <__mulsi3>
   1eda8:	00c12583          	lw	a1,12(sp)
   1edac:	02a12e23          	sw	a0,60(sp)
   1edb0:	000c8513          	mv	a0,s9
   1edb4:	7f8020ef          	jal	ra,215ac <__mulsi3>
   1edb8:	00012583          	lw	a1,0(sp)
   1edbc:	02a12c23          	sw	a0,56(sp)
   1edc0:	000c8513          	mv	a0,s9
   1edc4:	7e8020ef          	jal	ra,215ac <__mulsi3>
   1edc8:	00050413          	mv	s0,a0
   1edcc:	00012503          	lw	a0,0(sp)
   1edd0:	00048593          	mv	a1,s1
   1edd4:	7d8020ef          	jal	ra,215ac <__mulsi3>
   1edd8:	03812603          	lw	a2,56(sp)
   1eddc:	03c12703          	lw	a4,60(sp)
   1ede0:	00c50533          	add	a0,a0,a2
   1ede4:	01075793          	srli	a5,a4,0x10
   1ede8:	00a78533          	add	a0,a5,a0
   1edec:	00c57663          	bleu	a2,a0,1edf8 <__multf3+0xa0c>
   1edf0:	04012683          	lw	a3,64(sp)
   1edf4:	00d40433          	add	s0,s0,a3
   1edf8:	00010837          	lui	a6,0x10
   1edfc:	fff80793          	addi	a5,a6,-1 # ffff <main-0x75>
   1ee00:	01055313          	srli	t1,a0,0x10
   1ee04:	00830333          	add	t1,t1,s0
   1ee08:	01012583          	lw	a1,16(sp)
   1ee0c:	00f57433          	and	s0,a0,a5
   1ee10:	00812503          	lw	a0,8(sp)
   1ee14:	00f77733          	and	a4,a4,a5
   1ee18:	01041413          	slli	s0,s0,0x10
   1ee1c:	04612423          	sw	t1,72(sp)
   1ee20:	00e40433          	add	s0,s0,a4
   1ee24:	05012223          	sw	a6,68(sp)
   1ee28:	784020ef          	jal	ra,215ac <__mulsi3>
   1ee2c:	04a12023          	sw	a0,64(sp)
   1ee30:	00812583          	lw	a1,8(sp)
   1ee34:	00412503          	lw	a0,4(sp)
   1ee38:	774020ef          	jal	ra,215ac <__mulsi3>
   1ee3c:	00412583          	lw	a1,4(sp)
   1ee40:	02a12e23          	sw	a0,60(sp)
   1ee44:	000a0513          	mv	a0,s4
   1ee48:	764020ef          	jal	ra,215ac <__mulsi3>
   1ee4c:	01012583          	lw	a1,16(sp)
   1ee50:	02a12c23          	sw	a0,56(sp)
   1ee54:	000a0513          	mv	a0,s4
   1ee58:	754020ef          	jal	ra,215ac <__mulsi3>
   1ee5c:	03c12883          	lw	a7,60(sp)
   1ee60:	04012603          	lw	a2,64(sp)
   1ee64:	03812683          	lw	a3,56(sp)
   1ee68:	01150533          	add	a0,a0,a7
   1ee6c:	01065713          	srli	a4,a2,0x10
   1ee70:	00a70533          	add	a0,a4,a0
   1ee74:	04812303          	lw	t1,72(sp)
   1ee78:	01157663          	bleu	a7,a0,1ee84 <__multf3+0xa98>
   1ee7c:	04412803          	lw	a6,68(sp)
   1ee80:	010686b3          	add	a3,a3,a6
   1ee84:	000108b7          	lui	a7,0x10
   1ee88:	fff88713          	addi	a4,a7,-1 # ffff <main-0x75>
   1ee8c:	01055813          	srli	a6,a0,0x10
   1ee90:	00d80833          	add	a6,a6,a3
   1ee94:	00e577b3          	and	a5,a0,a4
   1ee98:	00e67633          	and	a2,a2,a4
   1ee9c:	03412683          	lw	a3,52(sp)
   1eea0:	02412703          	lw	a4,36(sp)
   1eea4:	013d8db3          	add	s11,s11,s3
   1eea8:	013dbf33          	sltu	t5,s11,s3
   1eeac:	00d70733          	add	a4,a4,a3
   1eeb0:	03112c23          	sw	a7,56(sp)
   1eeb4:	03412883          	lw	a7,52(sp)
   1eeb8:	01e70eb3          	add	t4,a4,t5
   1eebc:	012d8db3          	add	s11,s11,s2
   1eec0:	01ae85b3          	add	a1,t4,s10
   1eec4:	012db933          	sltu	s2,s11,s2
   1eec8:	008d8db3          	add	s11,s11,s0
   1eecc:	008dbfb3          	sltu	t6,s11,s0
   1eed0:	01258e33          	add	t3,a1,s2
   1eed4:	01173733          	sltu	a4,a4,a7
   1eed8:	01eeb433          	sltu	s0,t4,t5
   1eedc:	01079793          	slli	a5,a5,0x10
   1eee0:	012e3933          	sltu	s2,t3,s2
   1eee4:	00c787b3          	add	a5,a5,a2
   1eee8:	00876433          	or	s0,a4,s0
   1eeec:	006e0633          	add	a2,t3,t1
   1eef0:	01a5b733          	sltu	a4,a1,s10
   1eef4:	01f60533          	add	a0,a2,t6
   1eef8:	00fd86b3          	add	a3,s11,a5
   1eefc:	01276733          	or	a4,a4,s2
   1ef00:	00e40733          	add	a4,s0,a4
   1ef04:	00f6b7b3          	sltu	a5,a3,a5
   1ef08:	00663433          	sltu	s0,a2,t1
   1ef0c:	02d12223          	sw	a3,36(sp)
   1ef10:	08d12623          	sw	a3,140(sp)
   1ef14:	010506b3          	add	a3,a0,a6
   1ef18:	01f53533          	sltu	a0,a0,t6
   1ef1c:	00f689b3          	add	s3,a3,a5
   1ef20:	00a46433          	or	s0,s0,a0
   1ef24:	01012583          	lw	a1,16(sp)
   1ef28:	00c12503          	lw	a0,12(sp)
   1ef2c:	0106b6b3          	sltu	a3,a3,a6
   1ef30:	00f9b7b3          	sltu	a5,s3,a5
   1ef34:	00f6e7b3          	or	a5,a3,a5
   1ef38:	00870433          	add	s0,a4,s0
   1ef3c:	00f40433          	add	s0,s0,a5
   1ef40:	66c020ef          	jal	ra,215ac <__mulsi3>
   1ef44:	00050d13          	mv	s10,a0
   1ef48:	00c12583          	lw	a1,12(sp)
   1ef4c:	00412503          	lw	a0,4(sp)
   1ef50:	65c020ef          	jal	ra,215ac <__mulsi3>
   1ef54:	00050913          	mv	s2,a0
   1ef58:	00412583          	lw	a1,4(sp)
   1ef5c:	00012503          	lw	a0,0(sp)
   1ef60:	64c020ef          	jal	ra,215ac <__mulsi3>
   1ef64:	00050d93          	mv	s11,a0
   1ef68:	01012583          	lw	a1,16(sp)
   1ef6c:	00012503          	lw	a0,0(sp)
   1ef70:	63c020ef          	jal	ra,215ac <__mulsi3>
   1ef74:	01250533          	add	a0,a0,s2
   1ef78:	010d5793          	srli	a5,s10,0x10
   1ef7c:	00a78533          	add	a0,a5,a0
   1ef80:	01257663          	bleu	s2,a0,1ef8c <__multf3+0xba0>
   1ef84:	03812883          	lw	a7,56(sp)
   1ef88:	011d8db3          	add	s11,s11,a7
   1ef8c:	000106b7          	lui	a3,0x10
   1ef90:	01055793          	srli	a5,a0,0x10
   1ef94:	01b78db3          	add	s11,a5,s11
   1ef98:	fff68793          	addi	a5,a3,-1 # ffff <main-0x75>
   1ef9c:	00f57933          	and	s2,a0,a5
   1efa0:	000b0593          	mv	a1,s6
   1efa4:	00048513          	mv	a0,s1
   1efa8:	00fd7d33          	and	s10,s10,a5
   1efac:	02d12c23          	sw	a3,56(sp)
   1efb0:	5fc020ef          	jal	ra,215ac <__mulsi3>
   1efb4:	02a12a23          	sw	a0,52(sp)
   1efb8:	000b0593          	mv	a1,s6
   1efbc:	000c8513          	mv	a0,s9
   1efc0:	5ec020ef          	jal	ra,215ac <__mulsi3>
   1efc4:	01091913          	slli	s2,s2,0x10
   1efc8:	000b8593          	mv	a1,s7
   1efcc:	01a90933          	add	s2,s2,s10
   1efd0:	00050d13          	mv	s10,a0
   1efd4:	000c8513          	mv	a0,s9
   1efd8:	5d4020ef          	jal	ra,215ac <__mulsi3>
   1efdc:	00050c93          	mv	s9,a0
   1efe0:	00048593          	mv	a1,s1
   1efe4:	000b8513          	mv	a0,s7
   1efe8:	5c4020ef          	jal	ra,215ac <__mulsi3>
   1efec:	03412703          	lw	a4,52(sp)
   1eff0:	01a50533          	add	a0,a0,s10
   1eff4:	01075793          	srli	a5,a4,0x10
   1eff8:	00a78533          	add	a0,a5,a0
   1effc:	01a57663          	bleu	s10,a0,1f008 <__multf3+0xc1c>
   1f000:	03812683          	lw	a3,56(sp)
   1f004:	00dc8cb3          	add	s9,s9,a3
   1f008:	000106b7          	lui	a3,0x10
   1f00c:	fff68793          	addi	a5,a3,-1 # ffff <main-0x75>
   1f010:	00f574b3          	and	s1,a0,a5
   1f014:	01055d13          	srli	s10,a0,0x10
   1f018:	00812503          	lw	a0,8(sp)
   1f01c:	00f77733          	and	a4,a4,a5
   1f020:	000a8593          	mv	a1,s5
   1f024:	01049493          	slli	s1,s1,0x10
   1f028:	00e484b3          	add	s1,s1,a4
   1f02c:	02d12c23          	sw	a3,56(sp)
   1f030:	57c020ef          	jal	ra,215ac <__mulsi3>
   1f034:	00812583          	lw	a1,8(sp)
   1f038:	02a12a23          	sw	a0,52(sp)
   1f03c:	000c0513          	mv	a0,s8
   1f040:	56c020ef          	jal	ra,215ac <__mulsi3>
   1f044:	00a12423          	sw	a0,8(sp)
   1f048:	000c0593          	mv	a1,s8
   1f04c:	000a0513          	mv	a0,s4
   1f050:	55c020ef          	jal	ra,215ac <__mulsi3>
   1f054:	019d0d33          	add	s10,s10,s9
   1f058:	000a8593          	mv	a1,s5
   1f05c:	00050c93          	mv	s9,a0
   1f060:	000a0513          	mv	a0,s4
   1f064:	548020ef          	jal	ra,215ac <__mulsi3>
   1f068:	00812603          	lw	a2,8(sp)
   1f06c:	03412703          	lw	a4,52(sp)
   1f070:	00c50533          	add	a0,a0,a2
   1f074:	01075793          	srli	a5,a4,0x10
   1f078:	00a78533          	add	a0,a5,a0
   1f07c:	00c57663          	bleu	a2,a0,1f088 <__multf3+0xc9c>
   1f080:	03812683          	lw	a3,56(sp)
   1f084:	00dc8cb3          	add	s9,s9,a3
   1f088:	00010837          	lui	a6,0x10
   1f08c:	01055793          	srli	a5,a0,0x10
   1f090:	01978cb3          	add	s9,a5,s9
   1f094:	fff80793          	addi	a5,a6,-1 # ffff <main-0x75>
   1f098:	00f57a33          	and	s4,a0,a5
   1f09c:	01012503          	lw	a0,16(sp)
   1f0a0:	00f77733          	and	a4,a4,a5
   1f0a4:	000b0593          	mv	a1,s6
   1f0a8:	010a1a13          	slli	s4,s4,0x10
   1f0ac:	00ea0a33          	add	s4,s4,a4
   1f0b0:	03012c23          	sw	a6,56(sp)
   1f0b4:	4f8020ef          	jal	ra,215ac <__mulsi3>
   1f0b8:	02a12a23          	sw	a0,52(sp)
   1f0bc:	00412503          	lw	a0,4(sp)
   1f0c0:	000b0593          	mv	a1,s6
   1f0c4:	4e8020ef          	jal	ra,215ac <__mulsi3>
   1f0c8:	00a12423          	sw	a0,8(sp)
   1f0cc:	00412503          	lw	a0,4(sp)
   1f0d0:	000b8593          	mv	a1,s7
   1f0d4:	4d8020ef          	jal	ra,215ac <__mulsi3>
   1f0d8:	01012583          	lw	a1,16(sp)
   1f0dc:	00a12223          	sw	a0,4(sp)
   1f0e0:	000b8513          	mv	a0,s7
   1f0e4:	4c8020ef          	jal	ra,215ac <__mulsi3>
   1f0e8:	00812883          	lw	a7,8(sp)
   1f0ec:	03412683          	lw	a3,52(sp)
   1f0f0:	00412603          	lw	a2,4(sp)
   1f0f4:	01150533          	add	a0,a0,a7
   1f0f8:	0106d713          	srli	a4,a3,0x10
   1f0fc:	00a70533          	add	a0,a4,a0
   1f100:	01157663          	bleu	a7,a0,1f10c <__multf3+0xd20>
   1f104:	03812803          	lw	a6,56(sp)
   1f108:	01060633          	add	a2,a2,a6
   1f10c:	00010837          	lui	a6,0x10
   1f110:	fff80713          	addi	a4,a6,-1 # ffff <main-0x75>
   1f114:	00e577b3          	and	a5,a0,a4
   1f118:	01055313          	srli	t1,a0,0x10
   1f11c:	00c12503          	lw	a0,12(sp)
   1f120:	00e6f6b3          	and	a3,a3,a4
   1f124:	01079793          	slli	a5,a5,0x10
   1f128:	00c30333          	add	t1,t1,a2
   1f12c:	00d787b3          	add	a5,a5,a3
   1f130:	000a8593          	mv	a1,s5
   1f134:	02612e23          	sw	t1,60(sp)
   1f138:	02f12a23          	sw	a5,52(sp)
   1f13c:	03012c23          	sw	a6,56(sp)
   1f140:	46c020ef          	jal	ra,215ac <__mulsi3>
   1f144:	00c12583          	lw	a1,12(sp)
   1f148:	00a12823          	sw	a0,16(sp)
   1f14c:	000c0513          	mv	a0,s8
   1f150:	45c020ef          	jal	ra,215ac <__mulsi3>
   1f154:	00a12423          	sw	a0,8(sp)
   1f158:	00012503          	lw	a0,0(sp)
   1f15c:	000c0593          	mv	a1,s8
   1f160:	44c020ef          	jal	ra,215ac <__mulsi3>
   1f164:	00a12223          	sw	a0,4(sp)
   1f168:	00012503          	lw	a0,0(sp)
   1f16c:	000a8593          	mv	a1,s5
   1f170:	43c020ef          	jal	ra,215ac <__mulsi3>
   1f174:	00812883          	lw	a7,8(sp)
   1f178:	01012e03          	lw	t3,16(sp)
   1f17c:	00412603          	lw	a2,4(sp)
   1f180:	01150533          	add	a0,a0,a7
   1f184:	010e5693          	srli	a3,t3,0x10
   1f188:	00a68533          	add	a0,a3,a0
   1f18c:	03412783          	lw	a5,52(sp)
   1f190:	03c12303          	lw	t1,60(sp)
   1f194:	01157663          	bleu	a7,a0,1f1a0 <__multf3+0xdb4>
   1f198:	03812803          	lw	a6,56(sp)
   1f19c:	01060633          	add	a2,a2,a6
   1f1a0:	00010837          	lui	a6,0x10
   1f1a4:	01055893          	srli	a7,a0,0x10
   1f1a8:	012989b3          	add	s3,s3,s2
   1f1ac:	00c888b3          	add	a7,a7,a2
   1f1b0:	0129b933          	sltu	s2,s3,s2
   1f1b4:	fff80613          	addi	a2,a6,-1 # ffff <main-0x75>
   1f1b8:	01b40433          	add	s0,s0,s11
   1f1bc:	01240eb3          	add	t4,s0,s2
   1f1c0:	00c57733          	and	a4,a0,a2
   1f1c4:	009989b3          	add	s3,s3,s1
   1f1c8:	00ce7e33          	and	t3,t3,a2
   1f1cc:	01ae85b3          	add	a1,t4,s10
   1f1d0:	0099b4b3          	sltu	s1,s3,s1
   1f1d4:	01071713          	slli	a4,a4,0x10
   1f1d8:	01c70733          	add	a4,a4,t3
   1f1dc:	014989b3          	add	s3,s3,s4
   1f1e0:	00958e33          	add	t3,a1,s1
   1f1e4:	019e0f33          	add	t5,t3,s9
   1f1e8:	0149ba33          	sltu	s4,s3,s4
   1f1ec:	014f0fb3          	add	t6,t5,s4
   1f1f0:	012eb533          	sltu	a0,t4,s2
   1f1f4:	01b43433          	sltu	s0,s0,s11
   1f1f8:	01a5bd33          	sltu	s10,a1,s10
   1f1fc:	009e34b3          	sltu	s1,t3,s1
   1f200:	009d6e33          	or	t3,s10,s1
   1f204:	019f3cb3          	sltu	s9,t5,s9
   1f208:	014fba33          	sltu	s4,t6,s4
   1f20c:	00a46533          	or	a0,s0,a0
   1f210:	01c50533          	add	a0,a0,t3
   1f214:	014cea33          	or	s4,s9,s4
   1f218:	00ff86b3          	add	a3,t6,a5
   1f21c:	01450533          	add	a0,a0,s4
   1f220:	00650533          	add	a0,a0,t1
   1f224:	00f6b7b3          	sltu	a5,a3,a5
   1f228:	00f505b3          	add	a1,a0,a5
   1f22c:	00f5b7b3          	sltu	a5,a1,a5
   1f230:	00653533          	sltu	a0,a0,t1
   1f234:	00e686b3          	add	a3,a3,a4
   1f238:	00f56433          	or	s0,a0,a5
   1f23c:	00e6b733          	sltu	a4,a3,a4
   1f240:	01158533          	add	a0,a1,a7
   1f244:	00e504b3          	add	s1,a0,a4
   1f248:	00e4b733          	sltu	a4,s1,a4
   1f24c:	01153533          	sltu	a0,a0,a7
   1f250:	09312823          	sw	s3,144(sp)
   1f254:	000a8593          	mv	a1,s5
   1f258:	00e569b3          	or	s3,a0,a4
   1f25c:	000b0513          	mv	a0,s6
   1f260:	00c12023          	sw	a2,0(sp)
   1f264:	01012223          	sw	a6,4(sp)
   1f268:	08d12a23          	sw	a3,148(sp)
   1f26c:	340020ef          	jal	ra,215ac <__mulsi3>
   1f270:	000b0593          	mv	a1,s6
   1f274:	00050a13          	mv	s4,a0
   1f278:	000c0513          	mv	a0,s8
   1f27c:	330020ef          	jal	ra,215ac <__mulsi3>
   1f280:	00050b13          	mv	s6,a0
   1f284:	000c0593          	mv	a1,s8
   1f288:	000b8513          	mv	a0,s7
   1f28c:	320020ef          	jal	ra,215ac <__mulsi3>
   1f290:	00050913          	mv	s2,a0
   1f294:	000a8593          	mv	a1,s5
   1f298:	000b8513          	mv	a0,s7
   1f29c:	310020ef          	jal	ra,215ac <__mulsi3>
   1f2a0:	01650533          	add	a0,a0,s6
   1f2a4:	010a5793          	srli	a5,s4,0x10
   1f2a8:	00a78533          	add	a0,a5,a0
   1f2ac:	00012603          	lw	a2,0(sp)
   1f2b0:	01657663          	bleu	s6,a0,1f2bc <__multf3+0xed0>
   1f2b4:	00412803          	lw	a6,4(sp)
   1f2b8:	01090933          	add	s2,s2,a6
   1f2bc:	00c577b3          	and	a5,a0,a2
   1f2c0:	01079793          	slli	a5,a5,0x10
   1f2c4:	00ca7633          	and	a2,s4,a2
   1f2c8:	00c78633          	add	a2,a5,a2
   1f2cc:	01c12703          	lw	a4,28(sp)
   1f2d0:	03012783          	lw	a5,48(sp)
   1f2d4:	01055513          	srli	a0,a0,0x10
   1f2d8:	00c484b3          	add	s1,s1,a2
   1f2dc:	00e7e7b3          	or	a5,a5,a4
   1f2e0:	02012703          	lw	a4,32(sp)
   1f2e4:	00850533          	add	a0,a0,s0
   1f2e8:	00c4b633          	sltu	a2,s1,a2
   1f2ec:	00f76bb3          	or	s7,a4,a5
   1f2f0:	02412783          	lw	a5,36(sp)
   1f2f4:	01350533          	add	a0,a0,s3
   1f2f8:	00c50533          	add	a0,a0,a2
   1f2fc:	01250533          	add	a0,a0,s2
   1f300:	00d79793          	slli	a5,a5,0xd
   1f304:	08a12e23          	sw	a0,156(sp)
   1f308:	08912c23          	sw	s1,152(sp)
   1f30c:	0177e7b3          	or	a5,a5,s7
   1f310:	08010713          	addi	a4,sp,128
   1f314:	00000613          	li	a2,0
   1f318:	00400513          	li	a0,4
   1f31c:	00c72683          	lw	a3,12(a4)
   1f320:	01072583          	lw	a1,16(a4)
   1f324:	00160613          	addi	a2,a2,1
   1f328:	0136d693          	srli	a3,a3,0x13
   1f32c:	00d59593          	slli	a1,a1,0xd
   1f330:	00b6e6b3          	or	a3,a3,a1
   1f334:	00d72023          	sw	a3,0(a4)
   1f338:	00470713          	addi	a4,a4,4
   1f33c:	fea610e3          	bne	a2,a0,1f31c <__multf3+0xf30>
   1f340:	08012703          	lw	a4,128(sp)
   1f344:	08812683          	lw	a3,136(sp)
   1f348:	00f037b3          	snez	a5,a5
   1f34c:	00e7e7b3          	or	a5,a5,a4
   1f350:	06d12c23          	sw	a3,120(sp)
   1f354:	08c12703          	lw	a4,140(sp)
   1f358:	08412683          	lw	a3,132(sp)
   1f35c:	06f12823          	sw	a5,112(sp)
   1f360:	06e12e23          	sw	a4,124(sp)
   1f364:	06d12a23          	sw	a3,116(sp)
   1f368:	00b71693          	slli	a3,a4,0xb
   1f36c:	2406d463          	bgez	a3,1f5b4 <__multf3+0x11c8>
   1f370:	01f79793          	slli	a5,a5,0x1f
   1f374:	07010713          	addi	a4,sp,112
   1f378:	00000613          	li	a2,0
   1f37c:	00300513          	li	a0,3
   1f380:	00072683          	lw	a3,0(a4)
   1f384:	00472583          	lw	a1,4(a4)
   1f388:	00160613          	addi	a2,a2,1
   1f38c:	0016d693          	srli	a3,a3,0x1
   1f390:	01f59593          	slli	a1,a1,0x1f
   1f394:	00b6e6b3          	or	a3,a3,a1
   1f398:	00d72023          	sw	a3,0(a4)
   1f39c:	00470713          	addi	a4,a4,4
   1f3a0:	fea610e3          	bne	a2,a0,1f380 <__multf3+0xf94>
   1f3a4:	07c12703          	lw	a4,124(sp)
   1f3a8:	00f037b3          	snez	a5,a5
   1f3ac:	00175713          	srli	a4,a4,0x1
   1f3b0:	06e12e23          	sw	a4,124(sp)
   1f3b4:	07012703          	lw	a4,112(sp)
   1f3b8:	00f767b3          	or	a5,a4,a5
   1f3bc:	06f12823          	sw	a5,112(sp)
   1f3c0:	02812703          	lw	a4,40(sp)
   1f3c4:	000047b7          	lui	a5,0x4
   1f3c8:	fff78793          	addi	a5,a5,-1 # 3fff <main-0xc075>
   1f3cc:	00f707b3          	add	a5,a4,a5
   1f3d0:	20f05463          	blez	a5,1f5d8 <__multf3+0x11ec>
   1f3d4:	07012703          	lw	a4,112(sp)
   1f3d8:	00777693          	andi	a3,a4,7
   1f3dc:	04068463          	beqz	a3,1f424 <__multf3+0x1038>
   1f3e0:	00f77693          	andi	a3,a4,15
   1f3e4:	00400613          	li	a2,4
   1f3e8:	02c68e63          	beq	a3,a2,1f424 <__multf3+0x1038>
   1f3ec:	07412683          	lw	a3,116(sp)
   1f3f0:	00470713          	addi	a4,a4,4
   1f3f4:	06e12823          	sw	a4,112(sp)
   1f3f8:	00473713          	sltiu	a4,a4,4
   1f3fc:	00d706b3          	add	a3,a4,a3
   1f400:	00e6b733          	sltu	a4,a3,a4
   1f404:	06d12a23          	sw	a3,116(sp)
   1f408:	07812683          	lw	a3,120(sp)
   1f40c:	00d706b3          	add	a3,a4,a3
   1f410:	06d12c23          	sw	a3,120(sp)
   1f414:	00e6b6b3          	sltu	a3,a3,a4
   1f418:	07c12703          	lw	a4,124(sp)
   1f41c:	00e686b3          	add	a3,a3,a4
   1f420:	06d12e23          	sw	a3,124(sp)
   1f424:	07c12703          	lw	a4,124(sp)
   1f428:	00b71693          	slli	a3,a4,0xb
   1f42c:	0206d063          	bgez	a3,1f44c <__multf3+0x1060>
   1f430:	fff007b7          	lui	a5,0xfff00
   1f434:	fff78793          	addi	a5,a5,-1 # ffefffff <__global_pointer$+0xffedb89f>
   1f438:	00f77733          	and	a4,a4,a5
   1f43c:	06e12e23          	sw	a4,124(sp)
   1f440:	02812703          	lw	a4,40(sp)
   1f444:	000047b7          	lui	a5,0x4
   1f448:	00f707b3          	add	a5,a4,a5
   1f44c:	07010713          	addi	a4,sp,112
   1f450:	00000613          	li	a2,0
   1f454:	00300513          	li	a0,3
   1f458:	00072683          	lw	a3,0(a4)
   1f45c:	00472583          	lw	a1,4(a4)
   1f460:	00160613          	addi	a2,a2,1
   1f464:	0036d693          	srli	a3,a3,0x3
   1f468:	01d59593          	slli	a1,a1,0x1d
   1f46c:	00b6e6b3          	or	a3,a3,a1
   1f470:	00d72023          	sw	a3,0(a4)
   1f474:	00470713          	addi	a4,a4,4
   1f478:	fea610e3          	bne	a2,a0,1f458 <__multf3+0x106c>
   1f47c:	00008737          	lui	a4,0x8
   1f480:	ffe70693          	addi	a3,a4,-2 # 7ffe <main-0x8076>
   1f484:	12f6ce63          	blt	a3,a5,1f5c0 <__multf3+0x11d4>
   1f488:	07c12703          	lw	a4,124(sp)
   1f48c:	00375713          	srli	a4,a4,0x3
   1f490:	06e12e23          	sw	a4,124(sp)
   1f494:	07c12703          	lw	a4,124(sp)
   1f498:	ffff86b7          	lui	a3,0xffff8
   1f49c:	0dc12083          	lw	ra,220(sp)
   1f4a0:	08e11623          	sh	a4,140(sp)
   1f4a4:	00008737          	lui	a4,0x8
   1f4a8:	fff70713          	addi	a4,a4,-1 # 7fff <main-0x8075>
   1f4ac:	00e7f7b3          	and	a5,a5,a4
   1f4b0:	08e15703          	lhu	a4,142(sp)
   1f4b4:	0d812403          	lw	s0,216(sp)
   1f4b8:	0d412483          	lw	s1,212(sp)
   1f4bc:	00d77733          	and	a4,a4,a3
   1f4c0:	00f767b3          	or	a5,a4,a5
   1f4c4:	08f11723          	sh	a5,142(sp)
   1f4c8:	0087d713          	srli	a4,a5,0x8
   1f4cc:	01812783          	lw	a5,24(sp)
   1f4d0:	07f77713          	andi	a4,a4,127
   1f4d4:	0d012903          	lw	s2,208(sp)
   1f4d8:	00779793          	slli	a5,a5,0x7
   1f4dc:	00f767b3          	or	a5,a4,a5
   1f4e0:	08f107a3          	sb	a5,143(sp)
   1f4e4:	01412703          	lw	a4,20(sp)
   1f4e8:	07012783          	lw	a5,112(sp)
   1f4ec:	0cc12983          	lw	s3,204(sp)
   1f4f0:	0c812a03          	lw	s4,200(sp)
   1f4f4:	00f72023          	sw	a5,0(a4)
   1f4f8:	07412783          	lw	a5,116(sp)
   1f4fc:	0c412a83          	lw	s5,196(sp)
   1f500:	0c012b03          	lw	s6,192(sp)
   1f504:	00f72223          	sw	a5,4(a4)
   1f508:	07812783          	lw	a5,120(sp)
   1f50c:	0bc12b83          	lw	s7,188(sp)
   1f510:	0b812c03          	lw	s8,184(sp)
   1f514:	00f72423          	sw	a5,8(a4)
   1f518:	08c12783          	lw	a5,140(sp)
   1f51c:	0b412c83          	lw	s9,180(sp)
   1f520:	0b012d03          	lw	s10,176(sp)
   1f524:	00f72623          	sw	a5,12(a4)
   1f528:	0ac12d83          	lw	s11,172(sp)
   1f52c:	00070513          	mv	a0,a4
   1f530:	0e010113          	addi	sp,sp,224
   1f534:	00008067          	ret
   1f538:	01312c23          	sw	s3,24(sp)
   1f53c:	05012783          	lw	a5,80(sp)
   1f540:	06f12823          	sw	a5,112(sp)
   1f544:	05412783          	lw	a5,84(sp)
   1f548:	06f12a23          	sw	a5,116(sp)
   1f54c:	05812783          	lw	a5,88(sp)
   1f550:	06f12c23          	sw	a5,120(sp)
   1f554:	05c12783          	lw	a5,92(sp)
   1f558:	06f12e23          	sw	a5,124(sp)
   1f55c:	00200793          	li	a5,2
   1f560:	28f48063          	beq	s1,a5,1f7e0 <__multf3+0x13f4>
   1f564:	00300793          	li	a5,3
   1f568:	28f48a63          	beq	s1,a5,1f7fc <__multf3+0x1410>
   1f56c:	00100793          	li	a5,1
   1f570:	e4f498e3          	bne	s1,a5,1f3c0 <__multf3+0xfd4>
   1f574:	06012e23          	sw	zero,124(sp)
   1f578:	06012c23          	sw	zero,120(sp)
   1f57c:	06012a23          	sw	zero,116(sp)
   1f580:	06012823          	sw	zero,112(sp)
   1f584:	21c0006f          	j	1f7a0 <__multf3+0x13b4>
   1f588:	01212c23          	sw	s2,24(sp)
   1f58c:	06012783          	lw	a5,96(sp)
   1f590:	00070493          	mv	s1,a4
   1f594:	06f12823          	sw	a5,112(sp)
   1f598:	06412783          	lw	a5,100(sp)
   1f59c:	06f12a23          	sw	a5,116(sp)
   1f5a0:	06812783          	lw	a5,104(sp)
   1f5a4:	06f12c23          	sw	a5,120(sp)
   1f5a8:	06c12783          	lw	a5,108(sp)
   1f5ac:	06f12e23          	sw	a5,124(sp)
   1f5b0:	fadff06f          	j	1f55c <__multf3+0x1170>
   1f5b4:	02c12783          	lw	a5,44(sp)
   1f5b8:	02f12423          	sw	a5,40(sp)
   1f5bc:	e05ff06f          	j	1f3c0 <__multf3+0xfd4>
   1f5c0:	06012e23          	sw	zero,124(sp)
   1f5c4:	06012c23          	sw	zero,120(sp)
   1f5c8:	06012a23          	sw	zero,116(sp)
   1f5cc:	06012823          	sw	zero,112(sp)
   1f5d0:	fff70793          	addi	a5,a4,-1
   1f5d4:	ec1ff06f          	j	1f494 <__multf3+0x10a8>
   1f5d8:	00100693          	li	a3,1
   1f5dc:	40f687b3          	sub	a5,a3,a5
   1f5e0:	07400713          	li	a4,116
   1f5e4:	1cf74263          	blt	a4,a5,1f7a8 <__multf3+0x13bc>
   1f5e8:	4057d613          	srai	a2,a5,0x5
   1f5ec:	01f7f693          	andi	a3,a5,31
   1f5f0:	00000713          	li	a4,0
   1f5f4:	00000793          	li	a5,0
   1f5f8:	00271593          	slli	a1,a4,0x2
   1f5fc:	0ac71263          	bne	a4,a2,1f6a0 <__multf3+0x12b4>
   1f600:	0c069863          	bnez	a3,1f6d0 <__multf3+0x12e4>
   1f604:	00300513          	li	a0,3
   1f608:	07010613          	addi	a2,sp,112
   1f60c:	40e50533          	sub	a0,a0,a4
   1f610:	0ad55463          	ble	a3,a0,1f6b8 <__multf3+0x12cc>
   1f614:	00400693          	li	a3,4
   1f618:	40e68733          	sub	a4,a3,a4
   1f61c:	00400613          	li	a2,4
   1f620:	12c71663          	bne	a4,a2,1f74c <__multf3+0x1360>
   1f624:	07012683          	lw	a3,112(sp)
   1f628:	00f037b3          	snez	a5,a5
   1f62c:	00d7e7b3          	or	a5,a5,a3
   1f630:	06f12823          	sw	a5,112(sp)
   1f634:	0077f693          	andi	a3,a5,7
   1f638:	04068263          	beqz	a3,1f67c <__multf3+0x1290>
   1f63c:	00f7f693          	andi	a3,a5,15
   1f640:	02e68e63          	beq	a3,a4,1f67c <__multf3+0x1290>
   1f644:	07412703          	lw	a4,116(sp)
   1f648:	00478793          	addi	a5,a5,4 # 4004 <main-0xc070>
   1f64c:	06f12823          	sw	a5,112(sp)
   1f650:	0047b793          	sltiu	a5,a5,4
   1f654:	00e78733          	add	a4,a5,a4
   1f658:	00f737b3          	sltu	a5,a4,a5
   1f65c:	06e12a23          	sw	a4,116(sp)
   1f660:	07812703          	lw	a4,120(sp)
   1f664:	00e78733          	add	a4,a5,a4
   1f668:	06e12c23          	sw	a4,120(sp)
   1f66c:	00f73733          	sltu	a4,a4,a5
   1f670:	07c12783          	lw	a5,124(sp)
   1f674:	00f70733          	add	a4,a4,a5
   1f678:	06e12e23          	sw	a4,124(sp)
   1f67c:	07c12783          	lw	a5,124(sp)
   1f680:	00c79713          	slli	a4,a5,0xc
   1f684:	0e075063          	bgez	a4,1f764 <__multf3+0x1378>
   1f688:	06012e23          	sw	zero,124(sp)
   1f68c:	06012c23          	sw	zero,120(sp)
   1f690:	06012a23          	sw	zero,116(sp)
   1f694:	06012823          	sw	zero,112(sp)
   1f698:	00100793          	li	a5,1
   1f69c:	df9ff06f          	j	1f494 <__multf3+0x10a8>
   1f6a0:	07010513          	addi	a0,sp,112
   1f6a4:	00b505b3          	add	a1,a0,a1
   1f6a8:	0005a583          	lw	a1,0(a1)
   1f6ac:	00170713          	addi	a4,a4,1
   1f6b0:	00b7e7b3          	or	a5,a5,a1
   1f6b4:	f45ff06f          	j	1f5f8 <__multf3+0x120c>
   1f6b8:	00b60833          	add	a6,a2,a1
   1f6bc:	00082803          	lw	a6,0(a6)
   1f6c0:	00168693          	addi	a3,a3,1 # ffff8001 <__global_pointer$+0xfffd38a1>
   1f6c4:	00460613          	addi	a2,a2,4
   1f6c8:	ff062e23          	sw	a6,-4(a2)
   1f6cc:	f45ff06f          	j	1f610 <__multf3+0x1224>
   1f6d0:	0a010613          	addi	a2,sp,160
   1f6d4:	00b60633          	add	a2,a2,a1
   1f6d8:	fd062603          	lw	a2,-48(a2)
   1f6dc:	02000813          	li	a6,32
   1f6e0:	40d80833          	sub	a6,a6,a3
   1f6e4:	01061633          	sll	a2,a2,a6
   1f6e8:	00c7e7b3          	or	a5,a5,a2
   1f6ec:	00300613          	li	a2,3
   1f6f0:	07010893          	addi	a7,sp,112
   1f6f4:	00000313          	li	t1,0
   1f6f8:	40e60633          	sub	a2,a2,a4
   1f6fc:	02c34463          	blt	t1,a2,1f724 <__multf3+0x1338>
   1f700:	00400593          	li	a1,4
   1f704:	40e58733          	sub	a4,a1,a4
   1f708:	00261613          	slli	a2,a2,0x2
   1f70c:	0a010593          	addi	a1,sp,160
   1f710:	00c58633          	add	a2,a1,a2
   1f714:	07c12583          	lw	a1,124(sp)
   1f718:	00d5d6b3          	srl	a3,a1,a3
   1f71c:	fcd62823          	sw	a3,-48(a2)
   1f720:	efdff06f          	j	1f61c <__multf3+0x1230>
   1f724:	00b88e33          	add	t3,a7,a1
   1f728:	000e2503          	lw	a0,0(t3)
   1f72c:	004e2e03          	lw	t3,4(t3)
   1f730:	00130313          	addi	t1,t1,1
   1f734:	00d55533          	srl	a0,a0,a3
   1f738:	010e1e33          	sll	t3,t3,a6
   1f73c:	01c56533          	or	a0,a0,t3
   1f740:	00a8a023          	sw	a0,0(a7)
   1f744:	00488893          	addi	a7,a7,4
   1f748:	fb5ff06f          	j	1f6fc <__multf3+0x1310>
   1f74c:	00271693          	slli	a3,a4,0x2
   1f750:	07010593          	addi	a1,sp,112
   1f754:	00d586b3          	add	a3,a1,a3
   1f758:	0006a023          	sw	zero,0(a3)
   1f75c:	00170713          	addi	a4,a4,1
   1f760:	ec1ff06f          	j	1f620 <__multf3+0x1234>
   1f764:	07010793          	addi	a5,sp,112
   1f768:	00000693          	li	a3,0
   1f76c:	00300593          	li	a1,3
   1f770:	0007a703          	lw	a4,0(a5)
   1f774:	0047a603          	lw	a2,4(a5)
   1f778:	00168693          	addi	a3,a3,1
   1f77c:	00375713          	srli	a4,a4,0x3
   1f780:	01d61613          	slli	a2,a2,0x1d
   1f784:	00c76733          	or	a4,a4,a2
   1f788:	00e7a023          	sw	a4,0(a5)
   1f78c:	00478793          	addi	a5,a5,4
   1f790:	feb690e3          	bne	a3,a1,1f770 <__multf3+0x1384>
   1f794:	07c12783          	lw	a5,124(sp)
   1f798:	0037d793          	srli	a5,a5,0x3
   1f79c:	06f12e23          	sw	a5,124(sp)
   1f7a0:	00000793          	li	a5,0
   1f7a4:	cf1ff06f          	j	1f494 <__multf3+0x10a8>
   1f7a8:	07412783          	lw	a5,116(sp)
   1f7ac:	07012703          	lw	a4,112(sp)
   1f7b0:	00f76733          	or	a4,a4,a5
   1f7b4:	07812783          	lw	a5,120(sp)
   1f7b8:	00f76733          	or	a4,a4,a5
   1f7bc:	07c12783          	lw	a5,124(sp)
   1f7c0:	00f76733          	or	a4,a4,a5
   1f7c4:	00000793          	li	a5,0
   1f7c8:	cc0706e3          	beqz	a4,1f494 <__multf3+0x10a8>
   1f7cc:	06012e23          	sw	zero,124(sp)
   1f7d0:	06012c23          	sw	zero,120(sp)
   1f7d4:	06012a23          	sw	zero,116(sp)
   1f7d8:	06012823          	sw	zero,112(sp)
   1f7dc:	cb9ff06f          	j	1f494 <__multf3+0x10a8>
   1f7e0:	000087b7          	lui	a5,0x8
   1f7e4:	06012e23          	sw	zero,124(sp)
   1f7e8:	06012c23          	sw	zero,120(sp)
   1f7ec:	06012a23          	sw	zero,116(sp)
   1f7f0:	06012823          	sw	zero,112(sp)
   1f7f4:	fff78793          	addi	a5,a5,-1 # 7fff <main-0x8075>
   1f7f8:	c9dff06f          	j	1f494 <__multf3+0x10a8>
   1f7fc:	000087b7          	lui	a5,0x8
   1f800:	06f12e23          	sw	a5,124(sp)
   1f804:	06012c23          	sw	zero,120(sp)
   1f808:	06012a23          	sw	zero,116(sp)
   1f80c:	06012823          	sw	zero,112(sp)
   1f810:	fff78793          	addi	a5,a5,-1 # 7fff <main-0x8075>
   1f814:	00012c23          	sw	zero,24(sp)
   1f818:	c7dff06f          	j	1f494 <__multf3+0x10a8>

0001f81c <__subtf3>:
   1f81c:	fa010113          	addi	sp,sp,-96
   1f820:	0085a783          	lw	a5,8(a1)
   1f824:	05412423          	sw	s4,72(sp)
   1f828:	00c5aa03          	lw	s4,12(a1)
   1f82c:	0005a683          	lw	a3,0(a1)
   1f830:	0045a703          	lw	a4,4(a1)
   1f834:	02f12c23          	sw	a5,56(sp)
   1f838:	00f12c23          	sw	a5,24(sp)
   1f83c:	010a1793          	slli	a5,s4,0x10
   1f840:	04812c23          	sw	s0,88(sp)
   1f844:	0107d793          	srli	a5,a5,0x10
   1f848:	001a1413          	slli	s0,s4,0x1
   1f84c:	04912a23          	sw	s1,84(sp)
   1f850:	00062303          	lw	t1,0(a2)
   1f854:	00050493          	mv	s1,a0
   1f858:	00462883          	lw	a7,4(a2)
   1f85c:	00862583          	lw	a1,8(a2)
   1f860:	00c62503          	lw	a0,12(a2)
   1f864:	03412e23          	sw	s4,60(sp)
   1f868:	04112e23          	sw	ra,92(sp)
   1f86c:	05212823          	sw	s2,80(sp)
   1f870:	05312623          	sw	s3,76(sp)
   1f874:	05512223          	sw	s5,68(sp)
   1f878:	02d12823          	sw	a3,48(sp)
   1f87c:	02e12a23          	sw	a4,52(sp)
   1f880:	00d12823          	sw	a3,16(sp)
   1f884:	00e12a23          	sw	a4,20(sp)
   1f888:	00f12e23          	sw	a5,28(sp)
   1f88c:	01145413          	srli	s0,s0,0x11
   1f890:	01fa5a13          	srli	s4,s4,0x1f
   1f894:	01010813          	addi	a6,sp,16
   1f898:	01c10613          	addi	a2,sp,28
   1f89c:	00062783          	lw	a5,0(a2)
   1f8a0:	ffc62703          	lw	a4,-4(a2)
   1f8a4:	ffc60613          	addi	a2,a2,-4
   1f8a8:	00379793          	slli	a5,a5,0x3
   1f8ac:	01d75713          	srli	a4,a4,0x1d
   1f8b0:	00e7e7b3          	or	a5,a5,a4
   1f8b4:	00f62223          	sw	a5,4(a2)
   1f8b8:	fec812e3          	bne	a6,a2,1f89c <__subtf3+0x80>
   1f8bc:	01012683          	lw	a3,16(sp)
   1f8c0:	01051793          	slli	a5,a0,0x10
   1f8c4:	02b12c23          	sw	a1,56(sp)
   1f8c8:	00369693          	slli	a3,a3,0x3
   1f8cc:	02b12423          	sw	a1,40(sp)
   1f8d0:	0107d793          	srli	a5,a5,0x10
   1f8d4:	00151593          	slli	a1,a0,0x1
   1f8d8:	02612823          	sw	t1,48(sp)
   1f8dc:	03112a23          	sw	a7,52(sp)
   1f8e0:	02a12e23          	sw	a0,60(sp)
   1f8e4:	02612023          	sw	t1,32(sp)
   1f8e8:	03112223          	sw	a7,36(sp)
   1f8ec:	00d12823          	sw	a3,16(sp)
   1f8f0:	02f12623          	sw	a5,44(sp)
   1f8f4:	0115d593          	srli	a1,a1,0x11
   1f8f8:	01f55513          	srli	a0,a0,0x1f
   1f8fc:	02010893          	addi	a7,sp,32
   1f900:	02c10313          	addi	t1,sp,44
   1f904:	00032783          	lw	a5,0(t1)
   1f908:	ffc32703          	lw	a4,-4(t1)
   1f90c:	ffc30313          	addi	t1,t1,-4
   1f910:	00379793          	slli	a5,a5,0x3
   1f914:	01d75713          	srli	a4,a4,0x1d
   1f918:	00e7e7b3          	or	a5,a5,a4
   1f91c:	00f32223          	sw	a5,4(t1)
   1f920:	fe6892e3          	bne	a7,t1,1f904 <__subtf3+0xe8>
   1f924:	02012783          	lw	a5,32(sp)
   1f928:	00008737          	lui	a4,0x8
   1f92c:	fff70713          	addi	a4,a4,-1 # 7fff <main-0x8075>
   1f930:	00379793          	slli	a5,a5,0x3
   1f934:	02f12023          	sw	a5,32(sp)
   1f938:	02e59063          	bne	a1,a4,1f958 <__subtf3+0x13c>
   1f93c:	02812e03          	lw	t3,40(sp)
   1f940:	02412703          	lw	a4,36(sp)
   1f944:	01c76733          	or	a4,a4,t3
   1f948:	02c12e03          	lw	t3,44(sp)
   1f94c:	01c76733          	or	a4,a4,t3
   1f950:	00f76733          	or	a4,a4,a5
   1f954:	00071463          	bnez	a4,1f95c <__subtf3+0x140>
   1f958:	00154513          	xori	a0,a0,1
   1f95c:	40b40733          	sub	a4,s0,a1
   1f960:	114516e3          	bne	a0,s4,2026c <__subtf3+0xa50>
   1f964:	30e05263          	blez	a4,1fc68 <__subtf3+0x44c>
   1f968:	14059663          	bnez	a1,1fab4 <__subtf3+0x298>
   1f96c:	02412503          	lw	a0,36(sp)
   1f970:	02812583          	lw	a1,40(sp)
   1f974:	02c12803          	lw	a6,44(sp)
   1f978:	00b56633          	or	a2,a0,a1
   1f97c:	01066633          	or	a2,a2,a6
   1f980:	00f66633          	or	a2,a2,a5
   1f984:	02061463          	bnez	a2,1f9ac <__subtf3+0x190>
   1f988:	01412783          	lw	a5,20(sp)
   1f98c:	02d12823          	sw	a3,48(sp)
   1f990:	00070413          	mv	s0,a4
   1f994:	02f12a23          	sw	a5,52(sp)
   1f998:	01812783          	lw	a5,24(sp)
   1f99c:	02f12c23          	sw	a5,56(sp)
   1f9a0:	01c12783          	lw	a5,28(sp)
   1f9a4:	02f12e23          	sw	a5,60(sp)
   1f9a8:	3040006f          	j	1fcac <__subtf3+0x490>
   1f9ac:	fff70613          	addi	a2,a4,-1
   1f9b0:	0c061e63          	bnez	a2,1fa8c <__subtf3+0x270>
   1f9b4:	01412703          	lw	a4,20(sp)
   1f9b8:	00f687b3          	add	a5,a3,a5
   1f9bc:	00d7b6b3          	sltu	a3,a5,a3
   1f9c0:	00e50633          	add	a2,a0,a4
   1f9c4:	02f12823          	sw	a5,48(sp)
   1f9c8:	00d607b3          	add	a5,a2,a3
   1f9cc:	00d7b6b3          	sltu	a3,a5,a3
   1f9d0:	02f12a23          	sw	a5,52(sp)
   1f9d4:	01812783          	lw	a5,24(sp)
   1f9d8:	00e63733          	sltu	a4,a2,a4
   1f9dc:	00d766b3          	or	a3,a4,a3
   1f9e0:	00f58733          	add	a4,a1,a5
   1f9e4:	00d70633          	add	a2,a4,a3
   1f9e8:	00f737b3          	sltu	a5,a4,a5
   1f9ec:	01c12703          	lw	a4,28(sp)
   1f9f0:	00d636b3          	sltu	a3,a2,a3
   1f9f4:	00d7e7b3          	or	a5,a5,a3
   1f9f8:	00e80833          	add	a6,a6,a4
   1f9fc:	010787b3          	add	a5,a5,a6
   1fa00:	02c12c23          	sw	a2,56(sp)
   1fa04:	02f12e23          	sw	a5,60(sp)
   1fa08:	00100413          	li	s0,1
   1fa0c:	03c12783          	lw	a5,60(sp)
   1fa10:	00c79713          	slli	a4,a5,0xc
   1fa14:	28075c63          	bgez	a4,1fcac <__subtf3+0x490>
   1fa18:	fff80737          	lui	a4,0xfff80
   1fa1c:	fff70713          	addi	a4,a4,-1 # fff7ffff <__global_pointer$+0xfff5b89f>
   1fa20:	00e7f7b3          	and	a5,a5,a4
   1fa24:	02f12e23          	sw	a5,60(sp)
   1fa28:	03012783          	lw	a5,48(sp)
   1fa2c:	00140413          	addi	s0,s0,1
   1fa30:	03010713          	addi	a4,sp,48
   1fa34:	01f79793          	slli	a5,a5,0x1f
   1fa38:	00000613          	li	a2,0
   1fa3c:	00300513          	li	a0,3
   1fa40:	00072683          	lw	a3,0(a4)
   1fa44:	00472583          	lw	a1,4(a4)
   1fa48:	00160613          	addi	a2,a2,1
   1fa4c:	0016d693          	srli	a3,a3,0x1
   1fa50:	01f59593          	slli	a1,a1,0x1f
   1fa54:	00b6e6b3          	or	a3,a3,a1
   1fa58:	00d72023          	sw	a3,0(a4)
   1fa5c:	00470713          	addi	a4,a4,4
   1fa60:	fea610e3          	bne	a2,a0,1fa40 <__subtf3+0x224>
   1fa64:	03c12703          	lw	a4,60(sp)
   1fa68:	00f037b3          	snez	a5,a5
   1fa6c:	00175713          	srli	a4,a4,0x1
   1fa70:	02e12e23          	sw	a4,60(sp)
   1fa74:	03012703          	lw	a4,48(sp)
   1fa78:	00f767b3          	or	a5,a4,a5
   1fa7c:	02f12823          	sw	a5,48(sp)
   1fa80:	000087b7          	lui	a5,0x8
   1fa84:	fff78793          	addi	a5,a5,-1 # 7fff <main-0x8075>
   1fa88:	7cc0006f          	j	20254 <__subtf3+0xa38>
   1fa8c:	000087b7          	lui	a5,0x8
   1fa90:	fff78793          	addi	a5,a5,-1 # 7fff <main-0x8075>
   1fa94:	eef70ae3          	beq	a4,a5,1f988 <__subtf3+0x16c>
   1fa98:	07400793          	li	a5,116
   1fa9c:	06c7d063          	ble	a2,a5,1fafc <__subtf3+0x2e0>
   1faa0:	02012623          	sw	zero,44(sp)
   1faa4:	02012423          	sw	zero,40(sp)
   1faa8:	02012223          	sw	zero,36(sp)
   1faac:	00100793          	li	a5,1
   1fab0:	0900006f          	j	1fb40 <__subtf3+0x324>
   1fab4:	000087b7          	lui	a5,0x8
   1fab8:	fff78793          	addi	a5,a5,-1 # 7fff <main-0x8075>
   1fabc:	02f41263          	bne	s0,a5,1fae0 <__subtf3+0x2c4>
   1fac0:	01412783          	lw	a5,20(sp)
   1fac4:	02d12823          	sw	a3,48(sp)
   1fac8:	02f12a23          	sw	a5,52(sp)
   1facc:	01812783          	lw	a5,24(sp)
   1fad0:	02f12c23          	sw	a5,56(sp)
   1fad4:	01c12783          	lw	a5,28(sp)
   1fad8:	02f12e23          	sw	a5,60(sp)
   1fadc:	1d00006f          	j	1fcac <__subtf3+0x490>
   1fae0:	02c12783          	lw	a5,44(sp)
   1fae4:	000806b7          	lui	a3,0x80
   1fae8:	00d7e7b3          	or	a5,a5,a3
   1faec:	02f12623          	sw	a5,44(sp)
   1faf0:	07400793          	li	a5,116
   1faf4:	fae7c6e3          	blt	a5,a4,1faa0 <__subtf3+0x284>
   1faf8:	00070613          	mv	a2,a4
   1fafc:	40565713          	srai	a4,a2,0x5
   1fb00:	00000593          	li	a1,0
   1fb04:	01f67613          	andi	a2,a2,31
   1fb08:	00000793          	li	a5,0
   1fb0c:	00279693          	slli	a3,a5,0x2
   1fb10:	0ae79063          	bne	a5,a4,1fbb0 <__subtf3+0x394>
   1fb14:	0c061463          	bnez	a2,1fbdc <__subtf3+0x3c0>
   1fb18:	00300713          	li	a4,3
   1fb1c:	40f70733          	sub	a4,a4,a5
   1fb20:	0ac75263          	ble	a2,a4,1fbc4 <__subtf3+0x3a8>
   1fb24:	00400713          	li	a4,4
   1fb28:	40f707b3          	sub	a5,a4,a5
   1fb2c:	00400693          	li	a3,4
   1fb30:	12d79263          	bne	a5,a3,1fc54 <__subtf3+0x438>
   1fb34:	02012703          	lw	a4,32(sp)
   1fb38:	00b037b3          	snez	a5,a1
   1fb3c:	00f767b3          	or	a5,a4,a5
   1fb40:	02f12023          	sw	a5,32(sp)
   1fb44:	01012683          	lw	a3,16(sp)
   1fb48:	02012783          	lw	a5,32(sp)
   1fb4c:	01412703          	lw	a4,20(sp)
   1fb50:	02812583          	lw	a1,40(sp)
   1fb54:	00f687b3          	add	a5,a3,a5
   1fb58:	00d7b6b3          	sltu	a3,a5,a3
   1fb5c:	02f12823          	sw	a5,48(sp)
   1fb60:	02412783          	lw	a5,36(sp)
   1fb64:	02c12503          	lw	a0,44(sp)
   1fb68:	00f707b3          	add	a5,a4,a5
   1fb6c:	00d78633          	add	a2,a5,a3
   1fb70:	00e7b733          	sltu	a4,a5,a4
   1fb74:	00d637b3          	sltu	a5,a2,a3
   1fb78:	00f767b3          	or	a5,a4,a5
   1fb7c:	01812703          	lw	a4,24(sp)
   1fb80:	01c12683          	lw	a3,28(sp)
   1fb84:	02c12a23          	sw	a2,52(sp)
   1fb88:	00b705b3          	add	a1,a4,a1
   1fb8c:	00f58633          	add	a2,a1,a5
   1fb90:	00e5b733          	sltu	a4,a1,a4
   1fb94:	00f637b3          	sltu	a5,a2,a5
   1fb98:	00a686b3          	add	a3,a3,a0
   1fb9c:	00f76733          	or	a4,a4,a5
   1fba0:	00e68733          	add	a4,a3,a4
   1fba4:	02c12c23          	sw	a2,56(sp)
   1fba8:	02e12e23          	sw	a4,60(sp)
   1fbac:	e61ff06f          	j	1fa0c <__subtf3+0x1f0>
   1fbb0:	00d886b3          	add	a3,a7,a3
   1fbb4:	0006a683          	lw	a3,0(a3) # 80000 <__global_pointer$+0x5b8a0>
   1fbb8:	00178793          	addi	a5,a5,1
   1fbbc:	00d5e5b3          	or	a1,a1,a3
   1fbc0:	f4dff06f          	j	1fb0c <__subtf3+0x2f0>
   1fbc4:	00d30533          	add	a0,t1,a3
   1fbc8:	00052503          	lw	a0,0(a0)
   1fbcc:	00160613          	addi	a2,a2,1
   1fbd0:	00430313          	addi	t1,t1,4
   1fbd4:	fea32e23          	sw	a0,-4(t1)
   1fbd8:	f49ff06f          	j	1fb20 <__subtf3+0x304>
   1fbdc:	04010713          	addi	a4,sp,64
   1fbe0:	00d70733          	add	a4,a4,a3
   1fbe4:	fe072703          	lw	a4,-32(a4)
   1fbe8:	02000813          	li	a6,32
   1fbec:	40c80833          	sub	a6,a6,a2
   1fbf0:	01071733          	sll	a4,a4,a6
   1fbf4:	00e5e5b3          	or	a1,a1,a4
   1fbf8:	00300713          	li	a4,3
   1fbfc:	00000e13          	li	t3,0
   1fc00:	40f70733          	sub	a4,a4,a5
   1fc04:	02ee4463          	blt	t3,a4,1fc2c <__subtf3+0x410>
   1fc08:	00400693          	li	a3,4
   1fc0c:	40f687b3          	sub	a5,a3,a5
   1fc10:	00271713          	slli	a4,a4,0x2
   1fc14:	04010693          	addi	a3,sp,64
   1fc18:	00e68733          	add	a4,a3,a4
   1fc1c:	02c12683          	lw	a3,44(sp)
   1fc20:	00c6d633          	srl	a2,a3,a2
   1fc24:	fec72023          	sw	a2,-32(a4)
   1fc28:	f05ff06f          	j	1fb2c <__subtf3+0x310>
   1fc2c:	00d30eb3          	add	t4,t1,a3
   1fc30:	000ea503          	lw	a0,0(t4)
   1fc34:	004eae83          	lw	t4,4(t4)
   1fc38:	001e0e13          	addi	t3,t3,1
   1fc3c:	00c55533          	srl	a0,a0,a2
   1fc40:	010e9eb3          	sll	t4,t4,a6
   1fc44:	01d56533          	or	a0,a0,t4
   1fc48:	00a32023          	sw	a0,0(t1)
   1fc4c:	00430313          	addi	t1,t1,4
   1fc50:	fb5ff06f          	j	1fc04 <__subtf3+0x3e8>
   1fc54:	00279713          	slli	a4,a5,0x2
   1fc58:	00e88733          	add	a4,a7,a4
   1fc5c:	00072023          	sw	zero,0(a4)
   1fc60:	00178793          	addi	a5,a5,1
   1fc64:	ecdff06f          	j	1fb30 <__subtf3+0x314>
   1fc68:	3e070063          	beqz	a4,20048 <__subtf3+0x82c>
   1fc6c:	24041663          	bnez	s0,1feb8 <__subtf3+0x69c>
   1fc70:	01412883          	lw	a7,20(sp)
   1fc74:	01812503          	lw	a0,24(sp)
   1fc78:	01c12e03          	lw	t3,28(sp)
   1fc7c:	00a8e333          	or	t1,a7,a0
   1fc80:	01c36333          	or	t1,t1,t3
   1fc84:	00d36333          	or	t1,t1,a3
   1fc88:	1a031063          	bnez	t1,1fe28 <__subtf3+0x60c>
   1fc8c:	02f12823          	sw	a5,48(sp)
   1fc90:	02412783          	lw	a5,36(sp)
   1fc94:	00058413          	mv	s0,a1
   1fc98:	02f12a23          	sw	a5,52(sp)
   1fc9c:	02812783          	lw	a5,40(sp)
   1fca0:	02f12c23          	sw	a5,56(sp)
   1fca4:	02c12783          	lw	a5,44(sp)
   1fca8:	02f12e23          	sw	a5,60(sp)
   1fcac:	03012783          	lw	a5,48(sp)
   1fcb0:	0077f713          	andi	a4,a5,7
   1fcb4:	04070463          	beqz	a4,1fcfc <__subtf3+0x4e0>
   1fcb8:	00f7f713          	andi	a4,a5,15
   1fcbc:	00400693          	li	a3,4
   1fcc0:	02d70e63          	beq	a4,a3,1fcfc <__subtf3+0x4e0>
   1fcc4:	03412703          	lw	a4,52(sp)
   1fcc8:	00478793          	addi	a5,a5,4
   1fccc:	02f12823          	sw	a5,48(sp)
   1fcd0:	0047b793          	sltiu	a5,a5,4
   1fcd4:	00e78733          	add	a4,a5,a4
   1fcd8:	00f737b3          	sltu	a5,a4,a5
   1fcdc:	02e12a23          	sw	a4,52(sp)
   1fce0:	03812703          	lw	a4,56(sp)
   1fce4:	00e78733          	add	a4,a5,a4
   1fce8:	02e12c23          	sw	a4,56(sp)
   1fcec:	00f73733          	sltu	a4,a4,a5
   1fcf0:	03c12783          	lw	a5,60(sp)
   1fcf4:	00f70733          	add	a4,a4,a5
   1fcf8:	02e12e23          	sw	a4,60(sp)
   1fcfc:	03c12783          	lw	a5,60(sp)
   1fd00:	00c79713          	slli	a4,a5,0xc
   1fd04:	02075463          	bgez	a4,1fd2c <__subtf3+0x510>
   1fd08:	00008737          	lui	a4,0x8
   1fd0c:	00140413          	addi	s0,s0,1
   1fd10:	fff70713          	addi	a4,a4,-1 # 7fff <main-0x8075>
   1fd14:	00e41463          	bne	s0,a4,1fd1c <__subtf3+0x500>
   1fd18:	7f50006f          	j	20d0c <__subtf3+0x14f0>
   1fd1c:	fff80737          	lui	a4,0xfff80
   1fd20:	fff70713          	addi	a4,a4,-1 # fff7ffff <__global_pointer$+0xfff5b89f>
   1fd24:	00e7f7b3          	and	a5,a5,a4
   1fd28:	02f12e23          	sw	a5,60(sp)
   1fd2c:	03010793          	addi	a5,sp,48
   1fd30:	00000693          	li	a3,0
   1fd34:	00300593          	li	a1,3
   1fd38:	0007a703          	lw	a4,0(a5)
   1fd3c:	0047a603          	lw	a2,4(a5)
   1fd40:	00168693          	addi	a3,a3,1
   1fd44:	00375713          	srli	a4,a4,0x3
   1fd48:	01d61613          	slli	a2,a2,0x1d
   1fd4c:	00c76733          	or	a4,a4,a2
   1fd50:	00e7a023          	sw	a4,0(a5)
   1fd54:	00478793          	addi	a5,a5,4
   1fd58:	feb690e3          	bne	a3,a1,1fd38 <__subtf3+0x51c>
   1fd5c:	03c12783          	lw	a5,60(sp)
   1fd60:	000086b7          	lui	a3,0x8
   1fd64:	0037d713          	srli	a4,a5,0x3
   1fd68:	02e12e23          	sw	a4,60(sp)
   1fd6c:	fff68793          	addi	a5,a3,-1 # 7fff <main-0x8075>
   1fd70:	02f41a63          	bne	s0,a5,1fda4 <__subtf3+0x588>
   1fd74:	03412603          	lw	a2,52(sp)
   1fd78:	03012783          	lw	a5,48(sp)
   1fd7c:	00c7e7b3          	or	a5,a5,a2
   1fd80:	03812603          	lw	a2,56(sp)
   1fd84:	00c7e7b3          	or	a5,a5,a2
   1fd88:	00e7e7b3          	or	a5,a5,a4
   1fd8c:	00078c63          	beqz	a5,1fda4 <__subtf3+0x588>
   1fd90:	02d12e23          	sw	a3,60(sp)
   1fd94:	02012c23          	sw	zero,56(sp)
   1fd98:	02012a23          	sw	zero,52(sp)
   1fd9c:	02012823          	sw	zero,48(sp)
   1fda0:	00000a13          	li	s4,0
   1fda4:	00008537          	lui	a0,0x8
   1fda8:	03c12783          	lw	a5,60(sp)
   1fdac:	fff50513          	addi	a0,a0,-1 # 7fff <main-0x8075>
   1fdb0:	00a47533          	and	a0,s0,a0
   1fdb4:	00e15403          	lhu	s0,14(sp)
   1fdb8:	00f11623          	sh	a5,12(sp)
   1fdbc:	ffff87b7          	lui	a5,0xffff8
   1fdc0:	00f47433          	and	s0,s0,a5
   1fdc4:	00a46433          	or	s0,s0,a0
   1fdc8:	00845793          	srli	a5,s0,0x8
   1fdcc:	007a1713          	slli	a4,s4,0x7
   1fdd0:	07f7fa13          	andi	s4,a5,127
   1fdd4:	03012783          	lw	a5,48(sp)
   1fdd8:	00811723          	sh	s0,14(sp)
   1fddc:	00ea6a33          	or	s4,s4,a4
   1fde0:	00f4a023          	sw	a5,0(s1)
   1fde4:	03412783          	lw	a5,52(sp)
   1fde8:	014107a3          	sb	s4,15(sp)
   1fdec:	05c12083          	lw	ra,92(sp)
   1fdf0:	00f4a223          	sw	a5,4(s1)
   1fdf4:	03812783          	lw	a5,56(sp)
   1fdf8:	05812403          	lw	s0,88(sp)
   1fdfc:	00048513          	mv	a0,s1
   1fe00:	00f4a423          	sw	a5,8(s1)
   1fe04:	00c12783          	lw	a5,12(sp)
   1fe08:	05012903          	lw	s2,80(sp)
   1fe0c:	04c12983          	lw	s3,76(sp)
   1fe10:	00f4a623          	sw	a5,12(s1)
   1fe14:	04812a03          	lw	s4,72(sp)
   1fe18:	05412483          	lw	s1,84(sp)
   1fe1c:	04412a83          	lw	s5,68(sp)
   1fe20:	06010113          	addi	sp,sp,96
   1fe24:	00008067          	ret
   1fe28:	fff00313          	li	t1,-1
   1fe2c:	06671063          	bne	a4,t1,1fe8c <__subtf3+0x670>
   1fe30:	02412603          	lw	a2,36(sp)
   1fe34:	00f686b3          	add	a3,a3,a5
   1fe38:	00f6b7b3          	sltu	a5,a3,a5
   1fe3c:	00c88833          	add	a6,a7,a2
   1fe40:	00f80733          	add	a4,a6,a5
   1fe44:	00f737b3          	sltu	a5,a4,a5
   1fe48:	02e12a23          	sw	a4,52(sp)
   1fe4c:	02812703          	lw	a4,40(sp)
   1fe50:	00c83633          	sltu	a2,a6,a2
   1fe54:	00f667b3          	or	a5,a2,a5
   1fe58:	02d12823          	sw	a3,48(sp)
   1fe5c:	00e506b3          	add	a3,a0,a4
   1fe60:	00f68633          	add	a2,a3,a5
   1fe64:	00f637b3          	sltu	a5,a2,a5
   1fe68:	00e6b733          	sltu	a4,a3,a4
   1fe6c:	00f76733          	or	a4,a4,a5
   1fe70:	02c12783          	lw	a5,44(sp)
   1fe74:	02c12c23          	sw	a2,56(sp)
   1fe78:	00fe0e33          	add	t3,t3,a5
   1fe7c:	01c70733          	add	a4,a4,t3
   1fe80:	02e12e23          	sw	a4,60(sp)
   1fe84:	00058413          	mv	s0,a1
   1fe88:	b85ff06f          	j	1fa0c <__subtf3+0x1f0>
   1fe8c:	000086b7          	lui	a3,0x8
   1fe90:	fff68693          	addi	a3,a3,-1 # 7fff <main-0x8075>
   1fe94:	ded58ce3          	beq	a1,a3,1fc8c <__subtf3+0x470>
   1fe98:	fff74713          	not	a4,a4
   1fe9c:	07400793          	li	a5,116
   1fea0:	04e7d063          	ble	a4,a5,1fee0 <__subtf3+0x6c4>
   1fea4:	00012e23          	sw	zero,28(sp)
   1fea8:	00012c23          	sw	zero,24(sp)
   1feac:	00012a23          	sw	zero,20(sp)
   1feb0:	00100793          	li	a5,1
   1feb4:	0700006f          	j	1ff24 <__subtf3+0x708>
   1feb8:	000086b7          	lui	a3,0x8
   1febc:	fff68693          	addi	a3,a3,-1 # 7fff <main-0x8075>
   1fec0:	dcd586e3          	beq	a1,a3,1fc8c <__subtf3+0x470>
   1fec4:	01c12783          	lw	a5,28(sp)
   1fec8:	000806b7          	lui	a3,0x80
   1fecc:	00d7e7b3          	or	a5,a5,a3
   1fed0:	00f12e23          	sw	a5,28(sp)
   1fed4:	f8c00793          	li	a5,-116
   1fed8:	fcf746e3          	blt	a4,a5,1fea4 <__subtf3+0x688>
   1fedc:	40e00733          	neg	a4,a4
   1fee0:	40575693          	srai	a3,a4,0x5
   1fee4:	00000893          	li	a7,0
   1fee8:	01f77713          	andi	a4,a4,31
   1feec:	00000793          	li	a5,0
   1fef0:	00279513          	slli	a0,a5,0x2
   1fef4:	08d79e63          	bne	a5,a3,1ff90 <__subtf3+0x774>
   1fef8:	0c071263          	bnez	a4,1ffbc <__subtf3+0x7a0>
   1fefc:	00300693          	li	a3,3
   1ff00:	40f686b3          	sub	a3,a3,a5
   1ff04:	0ae6d063          	ble	a4,a3,1ffa4 <__subtf3+0x788>
   1ff08:	00400713          	li	a4,4
   1ff0c:	40f707b3          	sub	a5,a4,a5
   1ff10:	00400693          	li	a3,4
   1ff14:	12d79063          	bne	a5,a3,20034 <__subtf3+0x818>
   1ff18:	01012703          	lw	a4,16(sp)
   1ff1c:	011037b3          	snez	a5,a7
   1ff20:	00f767b3          	or	a5,a4,a5
   1ff24:	00f12823          	sw	a5,16(sp)
   1ff28:	02012683          	lw	a3,32(sp)
   1ff2c:	01012783          	lw	a5,16(sp)
   1ff30:	02412703          	lw	a4,36(sp)
   1ff34:	01812503          	lw	a0,24(sp)
   1ff38:	00f687b3          	add	a5,a3,a5
   1ff3c:	00d7b6b3          	sltu	a3,a5,a3
   1ff40:	02f12823          	sw	a5,48(sp)
   1ff44:	01412783          	lw	a5,20(sp)
   1ff48:	01c12803          	lw	a6,28(sp)
   1ff4c:	00f707b3          	add	a5,a4,a5
   1ff50:	00d78633          	add	a2,a5,a3
   1ff54:	00e7b733          	sltu	a4,a5,a4
   1ff58:	00d637b3          	sltu	a5,a2,a3
   1ff5c:	00f767b3          	or	a5,a4,a5
   1ff60:	02812703          	lw	a4,40(sp)
   1ff64:	02c12683          	lw	a3,44(sp)
   1ff68:	02c12a23          	sw	a2,52(sp)
   1ff6c:	00a70533          	add	a0,a4,a0
   1ff70:	00f50633          	add	a2,a0,a5
   1ff74:	00e53733          	sltu	a4,a0,a4
   1ff78:	00f637b3          	sltu	a5,a2,a5
   1ff7c:	010686b3          	add	a3,a3,a6
   1ff80:	00f76733          	or	a4,a4,a5
   1ff84:	02c12c23          	sw	a2,56(sp)
   1ff88:	00e68733          	add	a4,a3,a4
   1ff8c:	ef5ff06f          	j	1fe80 <__subtf3+0x664>
   1ff90:	00a80533          	add	a0,a6,a0
   1ff94:	00052503          	lw	a0,0(a0)
   1ff98:	00178793          	addi	a5,a5,1 # ffff8001 <__global_pointer$+0xfffd38a1>
   1ff9c:	00a8e8b3          	or	a7,a7,a0
   1ffa0:	f51ff06f          	j	1fef0 <__subtf3+0x6d4>
   1ffa4:	00a60333          	add	t1,a2,a0
   1ffa8:	00032303          	lw	t1,0(t1)
   1ffac:	00170713          	addi	a4,a4,1
   1ffb0:	00460613          	addi	a2,a2,4
   1ffb4:	fe662e23          	sw	t1,-4(a2)
   1ffb8:	f4dff06f          	j	1ff04 <__subtf3+0x6e8>
   1ffbc:	04010693          	addi	a3,sp,64
   1ffc0:	00a686b3          	add	a3,a3,a0
   1ffc4:	fd06a683          	lw	a3,-48(a3) # 7ffd0 <__global_pointer$+0x5b870>
   1ffc8:	02000e13          	li	t3,32
   1ffcc:	40ee0e33          	sub	t3,t3,a4
   1ffd0:	01c696b3          	sll	a3,a3,t3
   1ffd4:	00d8e8b3          	or	a7,a7,a3
   1ffd8:	00300693          	li	a3,3
   1ffdc:	00000e93          	li	t4,0
   1ffe0:	40f686b3          	sub	a3,a3,a5
   1ffe4:	02dec463          	blt	t4,a3,2000c <__subtf3+0x7f0>
   1ffe8:	00400613          	li	a2,4
   1ffec:	40f607b3          	sub	a5,a2,a5
   1fff0:	00269693          	slli	a3,a3,0x2
   1fff4:	04010613          	addi	a2,sp,64
   1fff8:	00d606b3          	add	a3,a2,a3
   1fffc:	01c12603          	lw	a2,28(sp)
   20000:	00e65733          	srl	a4,a2,a4
   20004:	fce6a823          	sw	a4,-48(a3)
   20008:	f09ff06f          	j	1ff10 <__subtf3+0x6f4>
   2000c:	00a60f33          	add	t5,a2,a0
   20010:	000f2303          	lw	t1,0(t5)
   20014:	004f2f03          	lw	t5,4(t5)
   20018:	001e8e93          	addi	t4,t4,1
   2001c:	00e35333          	srl	t1,t1,a4
   20020:	01cf1f33          	sll	t5,t5,t3
   20024:	01e36333          	or	t1,t1,t5
   20028:	00662023          	sw	t1,0(a2)
   2002c:	00460613          	addi	a2,a2,4
   20030:	fb5ff06f          	j	1ffe4 <__subtf3+0x7c8>
   20034:	00279713          	slli	a4,a5,0x2
   20038:	00e80733          	add	a4,a6,a4
   2003c:	00072023          	sw	zero,0(a4)
   20040:	00178793          	addi	a5,a5,1
   20044:	ed1ff06f          	j	1ff14 <__subtf3+0x6f8>
   20048:	00008f37          	lui	t5,0x8
   2004c:	00140513          	addi	a0,s0,1
   20050:	ffff0e93          	addi	t4,t5,-1 # 7fff <main-0x8075>
   20054:	01d572b3          	and	t0,a0,t4
   20058:	00100f93          	li	t6,1
   2005c:	02412703          	lw	a4,36(sp)
   20060:	02812603          	lw	a2,40(sp)
   20064:	02c12803          	lw	a6,44(sp)
   20068:	01412583          	lw	a1,20(sp)
   2006c:	01812e03          	lw	t3,24(sp)
   20070:	01c12303          	lw	t1,28(sp)
   20074:	03010893          	addi	a7,sp,48
   20078:	145fc663          	blt	t6,t0,201c4 <__subtf3+0x9a8>
   2007c:	01c5e533          	or	a0,a1,t3
   20080:	00656533          	or	a0,a0,t1
   20084:	00d56533          	or	a0,a0,a3
   20088:	0a041663          	bnez	s0,20134 <__subtf3+0x918>
   2008c:	00051c63          	bnez	a0,200a4 <__subtf3+0x888>
   20090:	02f12823          	sw	a5,48(sp)
   20094:	02e12a23          	sw	a4,52(sp)
   20098:	02c12c23          	sw	a2,56(sp)
   2009c:	03012e23          	sw	a6,60(sp)
   200a0:	c0dff06f          	j	1fcac <__subtf3+0x490>
   200a4:	00c76533          	or	a0,a4,a2
   200a8:	01056533          	or	a0,a0,a6
   200ac:	00f56533          	or	a0,a0,a5
   200b0:	00051c63          	bnez	a0,200c8 <__subtf3+0x8ac>
   200b4:	02d12823          	sw	a3,48(sp)
   200b8:	02b12a23          	sw	a1,52(sp)
   200bc:	03c12c23          	sw	t3,56(sp)
   200c0:	02612e23          	sw	t1,60(sp)
   200c4:	be9ff06f          	j	1fcac <__subtf3+0x490>
   200c8:	00f687b3          	add	a5,a3,a5
   200cc:	00b70733          	add	a4,a4,a1
   200d0:	02f12823          	sw	a5,48(sp)
   200d4:	00d7b7b3          	sltu	a5,a5,a3
   200d8:	00f706b3          	add	a3,a4,a5
   200dc:	02d12a23          	sw	a3,52(sp)
   200e0:	00b73733          	sltu	a4,a4,a1
   200e4:	00f6b6b3          	sltu	a3,a3,a5
   200e8:	00d766b3          	or	a3,a4,a3
   200ec:	01c605b3          	add	a1,a2,t3
   200f0:	00d587b3          	add	a5,a1,a3
   200f4:	01c5b633          	sltu	a2,a1,t3
   200f8:	00d7b6b3          	sltu	a3,a5,a3
   200fc:	00d666b3          	or	a3,a2,a3
   20100:	00680633          	add	a2,a6,t1
   20104:	00c68633          	add	a2,a3,a2
   20108:	02f12c23          	sw	a5,56(sp)
   2010c:	00c61793          	slli	a5,a2,0xc
   20110:	0007c663          	bltz	a5,2011c <__subtf3+0x900>
   20114:	02c12e23          	sw	a2,60(sp)
   20118:	b95ff06f          	j	1fcac <__subtf3+0x490>
   2011c:	fff806b7          	lui	a3,0xfff80
   20120:	fff68693          	addi	a3,a3,-1 # fff7ffff <__global_pointer$+0xfff5b89f>
   20124:	00d67633          	and	a2,a2,a3
   20128:	02c12e23          	sw	a2,60(sp)
   2012c:	00100413          	li	s0,1
   20130:	b7dff06f          	j	1fcac <__subtf3+0x490>
   20134:	00051e63          	bnez	a0,20150 <__subtf3+0x934>
   20138:	02f12823          	sw	a5,48(sp)
   2013c:	02e12a23          	sw	a4,52(sp)
   20140:	02c12c23          	sw	a2,56(sp)
   20144:	03012e23          	sw	a6,60(sp)
   20148:	000e8413          	mv	s0,t4
   2014c:	b61ff06f          	j	1fcac <__subtf3+0x490>
   20150:	00c76633          	or	a2,a4,a2
   20154:	01066633          	or	a2,a2,a6
   20158:	00f667b3          	or	a5,a2,a5
   2015c:	00079c63          	bnez	a5,20174 <__subtf3+0x958>
   20160:	02d12823          	sw	a3,48(sp)
   20164:	02b12a23          	sw	a1,52(sp)
   20168:	03c12c23          	sw	t3,56(sp)
   2016c:	02612e23          	sw	t1,60(sp)
   20170:	fd9ff06f          	j	20148 <__subtf3+0x92c>
   20174:	03e12e23          	sw	t5,60(sp)
   20178:	02012c23          	sw	zero,56(sp)
   2017c:	02012a23          	sw	zero,52(sp)
   20180:	02012823          	sw	zero,48(sp)
   20184:	03c10713          	addi	a4,sp,60
   20188:	00072783          	lw	a5,0(a4)
   2018c:	ffc72683          	lw	a3,-4(a4)
   20190:	ffc70713          	addi	a4,a4,-4
   20194:	00379793          	slli	a5,a5,0x3
   20198:	01d6d693          	srli	a3,a3,0x1d
   2019c:	00d7e7b3          	or	a5,a5,a3
   201a0:	00f72223          	sw	a5,4(a4)
   201a4:	fee892e3          	bne	a7,a4,20188 <__subtf3+0x96c>
   201a8:	03012783          	lw	a5,48(sp)
   201ac:	00008437          	lui	s0,0x8
   201b0:	fff40413          	addi	s0,s0,-1 # 7fff <main-0x8075>
   201b4:	00379793          	slli	a5,a5,0x3
   201b8:	02f12823          	sw	a5,48(sp)
   201bc:	00000a13          	li	s4,0
   201c0:	aedff06f          	j	1fcac <__subtf3+0x490>
   201c4:	00f687b3          	add	a5,a3,a5
   201c8:	00b70733          	add	a4,a4,a1
   201cc:	02f12823          	sw	a5,48(sp)
   201d0:	00d7b7b3          	sltu	a5,a5,a3
   201d4:	00f706b3          	add	a3,a4,a5
   201d8:	02d12a23          	sw	a3,52(sp)
   201dc:	00b73733          	sltu	a4,a4,a1
   201e0:	00f6b6b3          	sltu	a3,a3,a5
   201e4:	00d766b3          	or	a3,a4,a3
   201e8:	01c60633          	add	a2,a2,t3
   201ec:	00d60733          	add	a4,a2,a3
   201f0:	00d736b3          	sltu	a3,a4,a3
   201f4:	01c63633          	sltu	a2,a2,t3
   201f8:	00d66633          	or	a2,a2,a3
   201fc:	006806b3          	add	a3,a6,t1
   20200:	00d60633          	add	a2,a2,a3
   20204:	02e12c23          	sw	a4,56(sp)
   20208:	02c12e23          	sw	a2,60(sp)
   2020c:	00088793          	mv	a5,a7
   20210:	00000693          	li	a3,0
   20214:	00300593          	li	a1,3
   20218:	0007a703          	lw	a4,0(a5)
   2021c:	0047a603          	lw	a2,4(a5)
   20220:	00168693          	addi	a3,a3,1
   20224:	00175713          	srli	a4,a4,0x1
   20228:	01f61613          	slli	a2,a2,0x1f
   2022c:	00c76733          	or	a4,a4,a2
   20230:	00e7a023          	sw	a4,0(a5)
   20234:	00478793          	addi	a5,a5,4
   20238:	feb690e3          	bne	a3,a1,20218 <__subtf3+0x9fc>
   2023c:	03c12783          	lw	a5,60(sp)
   20240:	00050413          	mv	s0,a0
   20244:	0017d793          	srli	a5,a5,0x1
   20248:	02f12e23          	sw	a5,60(sp)
   2024c:	000087b7          	lui	a5,0x8
   20250:	fff78793          	addi	a5,a5,-1 # 7fff <main-0x8075>
   20254:	a4f41ce3          	bne	s0,a5,1fcac <__subtf3+0x490>
   20258:	02012e23          	sw	zero,60(sp)
   2025c:	02012c23          	sw	zero,56(sp)
   20260:	02012a23          	sw	zero,52(sp)
   20264:	02012823          	sw	zero,48(sp)
   20268:	a45ff06f          	j	1fcac <__subtf3+0x490>
   2026c:	28e05263          	blez	a4,204f0 <__subtf3+0xcd4>
   20270:	0c059e63          	bnez	a1,2034c <__subtf3+0xb30>
   20274:	02412503          	lw	a0,36(sp)
   20278:	02812583          	lw	a1,40(sp)
   2027c:	02c12e03          	lw	t3,44(sp)
   20280:	00b56833          	or	a6,a0,a1
   20284:	01c86833          	or	a6,a6,t3
   20288:	00f86833          	or	a6,a6,a5
   2028c:	ee080e63          	beqz	a6,1f988 <__subtf3+0x16c>
   20290:	fff70613          	addi	a2,a4,-1
   20294:	08061863          	bnez	a2,20324 <__subtf3+0xb08>
   20298:	01412883          	lw	a7,20(sp)
   2029c:	40f687b3          	sub	a5,a3,a5
   202a0:	00f6b733          	sltu	a4,a3,a5
   202a4:	40a88833          	sub	a6,a7,a0
   202a8:	0108b333          	sltu	t1,a7,a6
   202ac:	40e80833          	sub	a6,a6,a4
   202b0:	02f12823          	sw	a5,48(sp)
   202b4:	03012a23          	sw	a6,52(sp)
   202b8:	00000713          	li	a4,0
   202bc:	00f6f663          	bleu	a5,a3,202c8 <__subtf3+0xaac>
   202c0:	41150733          	sub	a4,a0,a7
   202c4:	00173713          	seqz	a4,a4
   202c8:	01812803          	lw	a6,24(sp)
   202cc:	00676733          	or	a4,a4,t1
   202d0:	40b806b3          	sub	a3,a6,a1
   202d4:	00d83533          	sltu	a0,a6,a3
   202d8:	40e686b3          	sub	a3,a3,a4
   202dc:	02d12c23          	sw	a3,56(sp)
   202e0:	00070663          	beqz	a4,202ec <__subtf3+0xad0>
   202e4:	410585b3          	sub	a1,a1,a6
   202e8:	0015b613          	seqz	a2,a1
   202ec:	01c12783          	lw	a5,28(sp)
   202f0:	00a66633          	or	a2,a2,a0
   202f4:	00100413          	li	s0,1
   202f8:	41c787b3          	sub	a5,a5,t3
   202fc:	40c78633          	sub	a2,a5,a2
   20300:	02c12e23          	sw	a2,60(sp)
   20304:	03c12783          	lw	a5,60(sp)
   20308:	00c79713          	slli	a4,a5,0xc
   2030c:	9a0750e3          	bgez	a4,1fcac <__subtf3+0x490>
   20310:	00080737          	lui	a4,0x80
   20314:	fff70713          	addi	a4,a4,-1 # 7ffff <__global_pointer$+0x5b89f>
   20318:	00e7f7b3          	and	a5,a5,a4
   2031c:	02f12e23          	sw	a5,60(sp)
   20320:	72c0006f          	j	20a4c <__subtf3+0x1230>
   20324:	000087b7          	lui	a5,0x8
   20328:	fff78793          	addi	a5,a5,-1 # 7fff <main-0x8075>
   2032c:	e4f70e63          	beq	a4,a5,1f988 <__subtf3+0x16c>
   20330:	07400793          	li	a5,116
   20334:	04c7d063          	ble	a2,a5,20374 <__subtf3+0xb58>
   20338:	02012623          	sw	zero,44(sp)
   2033c:	02012423          	sw	zero,40(sp)
   20340:	02012223          	sw	zero,36(sp)
   20344:	00100793          	li	a5,1
   20348:	0700006f          	j	203b8 <__subtf3+0xb9c>
   2034c:	000087b7          	lui	a5,0x8
   20350:	fff78793          	addi	a5,a5,-1 # 7fff <main-0x8075>
   20354:	f6f40663          	beq	s0,a5,1fac0 <__subtf3+0x2a4>
   20358:	02c12783          	lw	a5,44(sp)
   2035c:	000806b7          	lui	a3,0x80
   20360:	00d7e7b3          	or	a5,a5,a3
   20364:	02f12623          	sw	a5,44(sp)
   20368:	07400793          	li	a5,116
   2036c:	fce7c6e3          	blt	a5,a4,20338 <__subtf3+0xb1c>
   20370:	00070613          	mv	a2,a4
   20374:	40565713          	srai	a4,a2,0x5
   20378:	00000593          	li	a1,0
   2037c:	01f67613          	andi	a2,a2,31
   20380:	00000793          	li	a5,0
   20384:	00279693          	slli	a3,a5,0x2
   20388:	0ae79863          	bne	a5,a4,20438 <__subtf3+0xc1c>
   2038c:	0c061c63          	bnez	a2,20464 <__subtf3+0xc48>
   20390:	00300713          	li	a4,3
   20394:	40f70733          	sub	a4,a4,a5
   20398:	0ac75a63          	ble	a2,a4,2044c <__subtf3+0xc30>
   2039c:	00400713          	li	a4,4
   203a0:	40f707b3          	sub	a5,a4,a5
   203a4:	00400693          	li	a3,4
   203a8:	12d79a63          	bne	a5,a3,204dc <__subtf3+0xcc0>
   203ac:	02012703          	lw	a4,32(sp)
   203b0:	00b037b3          	snez	a5,a1
   203b4:	00f767b3          	or	a5,a4,a5
   203b8:	02f12023          	sw	a5,32(sp)
   203bc:	01412683          	lw	a3,20(sp)
   203c0:	01012583          	lw	a1,16(sp)
   203c4:	02012703          	lw	a4,32(sp)
   203c8:	02412783          	lw	a5,36(sp)
   203cc:	40e58733          	sub	a4,a1,a4
   203d0:	40f687b3          	sub	a5,a3,a5
   203d4:	00f6b633          	sltu	a2,a3,a5
   203d8:	00e5b6b3          	sltu	a3,a1,a4
   203dc:	40d786b3          	sub	a3,a5,a3
   203e0:	02d12a23          	sw	a3,52(sp)
   203e4:	02e12823          	sw	a4,48(sp)
   203e8:	00000693          	li	a3,0
   203ec:	00e5f463          	bleu	a4,a1,203f4 <__subtf3+0xbd8>
   203f0:	0017b693          	seqz	a3,a5
   203f4:	00c6e6b3          	or	a3,a3,a2
   203f8:	02812703          	lw	a4,40(sp)
   203fc:	01812603          	lw	a2,24(sp)
   20400:	40e60733          	sub	a4,a2,a4
   20404:	40d707b3          	sub	a5,a4,a3
   20408:	02f12c23          	sw	a5,56(sp)
   2040c:	00e635b3          	sltu	a1,a2,a4
   20410:	00000613          	li	a2,0
   20414:	00068463          	beqz	a3,2041c <__subtf3+0xc00>
   20418:	00173613          	seqz	a2,a4
   2041c:	01c12783          	lw	a5,28(sp)
   20420:	02c12703          	lw	a4,44(sp)
   20424:	00b66633          	or	a2,a2,a1
   20428:	40e787b3          	sub	a5,a5,a4
   2042c:	40c787b3          	sub	a5,a5,a2
   20430:	02f12e23          	sw	a5,60(sp)
   20434:	ed1ff06f          	j	20304 <__subtf3+0xae8>
   20438:	00d886b3          	add	a3,a7,a3
   2043c:	0006a683          	lw	a3,0(a3) # 80000 <__global_pointer$+0x5b8a0>
   20440:	00178793          	addi	a5,a5,1
   20444:	00d5e5b3          	or	a1,a1,a3
   20448:	f3dff06f          	j	20384 <__subtf3+0xb68>
   2044c:	00d30533          	add	a0,t1,a3
   20450:	00052503          	lw	a0,0(a0)
   20454:	00160613          	addi	a2,a2,1
   20458:	00430313          	addi	t1,t1,4
   2045c:	fea32e23          	sw	a0,-4(t1)
   20460:	f39ff06f          	j	20398 <__subtf3+0xb7c>
   20464:	04010713          	addi	a4,sp,64
   20468:	00d70733          	add	a4,a4,a3
   2046c:	fe072703          	lw	a4,-32(a4)
   20470:	02000813          	li	a6,32
   20474:	40c80833          	sub	a6,a6,a2
   20478:	01071733          	sll	a4,a4,a6
   2047c:	00e5e5b3          	or	a1,a1,a4
   20480:	00300713          	li	a4,3
   20484:	00000e13          	li	t3,0
   20488:	40f70733          	sub	a4,a4,a5
   2048c:	02ee4463          	blt	t3,a4,204b4 <__subtf3+0xc98>
   20490:	00400693          	li	a3,4
   20494:	40f687b3          	sub	a5,a3,a5
   20498:	00271713          	slli	a4,a4,0x2
   2049c:	04010693          	addi	a3,sp,64
   204a0:	00e68733          	add	a4,a3,a4
   204a4:	02c12683          	lw	a3,44(sp)
   204a8:	00c6d633          	srl	a2,a3,a2
   204ac:	fec72023          	sw	a2,-32(a4)
   204b0:	ef5ff06f          	j	203a4 <__subtf3+0xb88>
   204b4:	00d30eb3          	add	t4,t1,a3
   204b8:	000ea503          	lw	a0,0(t4)
   204bc:	004eae83          	lw	t4,4(t4)
   204c0:	001e0e13          	addi	t3,t3,1
   204c4:	00c55533          	srl	a0,a0,a2
   204c8:	010e9eb3          	sll	t4,t4,a6
   204cc:	01d56533          	or	a0,a0,t4
   204d0:	00a32023          	sw	a0,0(t1)
   204d4:	00430313          	addi	t1,t1,4
   204d8:	fb5ff06f          	j	2048c <__subtf3+0xc70>
   204dc:	00279713          	slli	a4,a5,0x2
   204e0:	00e88733          	add	a4,a7,a4
   204e4:	00072023          	sw	zero,0(a4)
   204e8:	00178793          	addi	a5,a5,1
   204ec:	ebdff06f          	j	203a8 <__subtf3+0xb8c>
   204f0:	28070c63          	beqz	a4,20788 <__subtf3+0xf6c>
   204f4:	0e041a63          	bnez	s0,205e8 <__subtf3+0xdcc>
   204f8:	01412303          	lw	t1,20(sp)
   204fc:	01812883          	lw	a7,24(sp)
   20500:	01c12e83          	lw	t4,28(sp)
   20504:	01136e33          	or	t3,t1,a7
   20508:	01de6e33          	or	t3,t3,t4
   2050c:	00de6e33          	or	t3,t3,a3
   20510:	020e1663          	bnez	t3,2053c <__subtf3+0xd20>
   20514:	02f12823          	sw	a5,48(sp)
   20518:	02412783          	lw	a5,36(sp)
   2051c:	00058413          	mv	s0,a1
   20520:	02f12a23          	sw	a5,52(sp)
   20524:	02812783          	lw	a5,40(sp)
   20528:	02f12c23          	sw	a5,56(sp)
   2052c:	02c12783          	lw	a5,44(sp)
   20530:	02f12e23          	sw	a5,60(sp)
   20534:	00050a13          	mv	s4,a0
   20538:	f74ff06f          	j	1fcac <__subtf3+0x490>
   2053c:	fff00e13          	li	t3,-1
   20540:	07c71e63          	bne	a4,t3,205bc <__subtf3+0xda0>
   20544:	02412803          	lw	a6,36(sp)
   20548:	40d786b3          	sub	a3,a5,a3
   2054c:	00d7b733          	sltu	a4,a5,a3
   20550:	40680633          	sub	a2,a6,t1
   20554:	00c83e33          	sltu	t3,a6,a2
   20558:	40e60633          	sub	a2,a2,a4
   2055c:	02d12823          	sw	a3,48(sp)
   20560:	02c12a23          	sw	a2,52(sp)
   20564:	00000713          	li	a4,0
   20568:	00d7f663          	bleu	a3,a5,20574 <__subtf3+0xd58>
   2056c:	41030733          	sub	a4,t1,a6
   20570:	00173713          	seqz	a4,a4
   20574:	02812803          	lw	a6,40(sp)
   20578:	01c76733          	or	a4,a4,t3
   2057c:	00000693          	li	a3,0
   20580:	41180633          	sub	a2,a6,a7
   20584:	00c83333          	sltu	t1,a6,a2
   20588:	40e60633          	sub	a2,a2,a4
   2058c:	02c12c23          	sw	a2,56(sp)
   20590:	00070663          	beqz	a4,2059c <__subtf3+0xd80>
   20594:	410888b3          	sub	a7,a7,a6
   20598:	0018b693          	seqz	a3,a7
   2059c:	02c12783          	lw	a5,44(sp)
   205a0:	0066e8b3          	or	a7,a3,t1
   205a4:	41d787b3          	sub	a5,a5,t4
   205a8:	411787b3          	sub	a5,a5,a7
   205ac:	02f12e23          	sw	a5,60(sp)
   205b0:	00058413          	mv	s0,a1
   205b4:	00050a13          	mv	s4,a0
   205b8:	d4dff06f          	j	20304 <__subtf3+0xae8>
   205bc:	000086b7          	lui	a3,0x8
   205c0:	fff68693          	addi	a3,a3,-1 # 7fff <main-0x8075>
   205c4:	f4d588e3          	beq	a1,a3,20514 <__subtf3+0xcf8>
   205c8:	fff74713          	not	a4,a4
   205cc:	07400793          	li	a5,116
   205d0:	04e7d063          	ble	a4,a5,20610 <__subtf3+0xdf4>
   205d4:	00012e23          	sw	zero,28(sp)
   205d8:	00012c23          	sw	zero,24(sp)
   205dc:	00012a23          	sw	zero,20(sp)
   205e0:	00100793          	li	a5,1
   205e4:	0700006f          	j	20654 <__subtf3+0xe38>
   205e8:	000086b7          	lui	a3,0x8
   205ec:	fff68693          	addi	a3,a3,-1 # 7fff <main-0x8075>
   205f0:	f2d582e3          	beq	a1,a3,20514 <__subtf3+0xcf8>
   205f4:	01c12783          	lw	a5,28(sp)
   205f8:	000806b7          	lui	a3,0x80
   205fc:	00d7e7b3          	or	a5,a5,a3
   20600:	00f12e23          	sw	a5,28(sp)
   20604:	f8c00793          	li	a5,-116
   20608:	fcf746e3          	blt	a4,a5,205d4 <__subtf3+0xdb8>
   2060c:	40e00733          	neg	a4,a4
   20610:	40575693          	srai	a3,a4,0x5
   20614:	00000313          	li	t1,0
   20618:	01f77713          	andi	a4,a4,31
   2061c:	00000793          	li	a5,0
   20620:	00279893          	slli	a7,a5,0x2
   20624:	0ad79663          	bne	a5,a3,206d0 <__subtf3+0xeb4>
   20628:	0c071a63          	bnez	a4,206fc <__subtf3+0xee0>
   2062c:	00300693          	li	a3,3
   20630:	40f686b3          	sub	a3,a3,a5
   20634:	0ae6d863          	ble	a4,a3,206e4 <__subtf3+0xec8>
   20638:	00400713          	li	a4,4
   2063c:	40f707b3          	sub	a5,a4,a5
   20640:	00400693          	li	a3,4
   20644:	12d79863          	bne	a5,a3,20774 <__subtf3+0xf58>
   20648:	01012703          	lw	a4,16(sp)
   2064c:	006037b3          	snez	a5,t1
   20650:	00f767b3          	or	a5,a4,a5
   20654:	00f12823          	sw	a5,16(sp)
   20658:	02412683          	lw	a3,36(sp)
   2065c:	02012803          	lw	a6,32(sp)
   20660:	01012703          	lw	a4,16(sp)
   20664:	01412783          	lw	a5,20(sp)
   20668:	40e80733          	sub	a4,a6,a4
   2066c:	40f687b3          	sub	a5,a3,a5
   20670:	00f6b633          	sltu	a2,a3,a5
   20674:	00e836b3          	sltu	a3,a6,a4
   20678:	40d786b3          	sub	a3,a5,a3
   2067c:	02d12a23          	sw	a3,52(sp)
   20680:	02e12823          	sw	a4,48(sp)
   20684:	00000693          	li	a3,0
   20688:	00e87463          	bleu	a4,a6,20690 <__subtf3+0xe74>
   2068c:	0017b693          	seqz	a3,a5
   20690:	00c6e6b3          	or	a3,a3,a2
   20694:	01812703          	lw	a4,24(sp)
   20698:	02812603          	lw	a2,40(sp)
   2069c:	40e60733          	sub	a4,a2,a4
   206a0:	40d707b3          	sub	a5,a4,a3
   206a4:	02f12c23          	sw	a5,56(sp)
   206a8:	00e63833          	sltu	a6,a2,a4
   206ac:	00000613          	li	a2,0
   206b0:	00068463          	beqz	a3,206b8 <__subtf3+0xe9c>
   206b4:	00173613          	seqz	a2,a4
   206b8:	02c12783          	lw	a5,44(sp)
   206bc:	01c12703          	lw	a4,28(sp)
   206c0:	01066633          	or	a2,a2,a6
   206c4:	40e787b3          	sub	a5,a5,a4
   206c8:	40c787b3          	sub	a5,a5,a2
   206cc:	ee1ff06f          	j	205ac <__subtf3+0xd90>
   206d0:	011808b3          	add	a7,a6,a7
   206d4:	0008a883          	lw	a7,0(a7)
   206d8:	00178793          	addi	a5,a5,1
   206dc:	01136333          	or	t1,t1,a7
   206e0:	f41ff06f          	j	20620 <__subtf3+0xe04>
   206e4:	01160e33          	add	t3,a2,a7
   206e8:	000e2e03          	lw	t3,0(t3)
   206ec:	00170713          	addi	a4,a4,1
   206f0:	00460613          	addi	a2,a2,4
   206f4:	ffc62e23          	sw	t3,-4(a2)
   206f8:	f3dff06f          	j	20634 <__subtf3+0xe18>
   206fc:	04010693          	addi	a3,sp,64
   20700:	011686b3          	add	a3,a3,a7
   20704:	fd06a683          	lw	a3,-48(a3) # 7ffd0 <__global_pointer$+0x5b870>
   20708:	02000e93          	li	t4,32
   2070c:	40ee8eb3          	sub	t4,t4,a4
   20710:	01d696b3          	sll	a3,a3,t4
   20714:	00d36333          	or	t1,t1,a3
   20718:	00300693          	li	a3,3
   2071c:	00000f13          	li	t5,0
   20720:	40f686b3          	sub	a3,a3,a5
   20724:	02df4463          	blt	t5,a3,2074c <__subtf3+0xf30>
   20728:	00400613          	li	a2,4
   2072c:	40f607b3          	sub	a5,a2,a5
   20730:	00269693          	slli	a3,a3,0x2
   20734:	04010613          	addi	a2,sp,64
   20738:	00d606b3          	add	a3,a2,a3
   2073c:	01c12603          	lw	a2,28(sp)
   20740:	00e65733          	srl	a4,a2,a4
   20744:	fce6a823          	sw	a4,-48(a3)
   20748:	ef9ff06f          	j	20640 <__subtf3+0xe24>
   2074c:	01160fb3          	add	t6,a2,a7
   20750:	000fae03          	lw	t3,0(t6)
   20754:	004faf83          	lw	t6,4(t6)
   20758:	001f0f13          	addi	t5,t5,1
   2075c:	00ee5e33          	srl	t3,t3,a4
   20760:	01df9fb3          	sll	t6,t6,t4
   20764:	01fe6e33          	or	t3,t3,t6
   20768:	01c62023          	sw	t3,0(a2)
   2076c:	00460613          	addi	a2,a2,4
   20770:	fb5ff06f          	j	20724 <__subtf3+0xf08>
   20774:	00279713          	slli	a4,a5,0x2
   20778:	00e80733          	add	a4,a6,a4
   2077c:	00072023          	sw	zero,0(a4)
   20780:	00178793          	addi	a5,a5,1
   20784:	ec1ff06f          	j	20644 <__subtf3+0xe28>
   20788:	00008fb7          	lui	t6,0x8
   2078c:	00140e93          	addi	t4,s0,1
   20790:	ffff8293          	addi	t0,t6,-1 # 7fff <main-0x8075>
   20794:	005efeb3          	and	t4,t4,t0
   20798:	00100f13          	li	t5,1
   2079c:	02412583          	lw	a1,36(sp)
   207a0:	01412603          	lw	a2,20(sp)
   207a4:	01812803          	lw	a6,24(sp)
   207a8:	01c12e03          	lw	t3,28(sp)
   207ac:	02812883          	lw	a7,40(sp)
   207b0:	02c12303          	lw	t1,44(sp)
   207b4:	1ddf4e63          	blt	t5,t4,20990 <__subtf3+0x1174>
   207b8:	0115eeb3          	or	t4,a1,a7
   207bc:	01066f33          	or	t5,a2,a6
   207c0:	006eeeb3          	or	t4,t4,t1
   207c4:	01cf6f33          	or	t5,t5,t3
   207c8:	00feeeb3          	or	t4,t4,a5
   207cc:	00df6f33          	or	t5,t5,a3
   207d0:	10041863          	bnez	s0,208e0 <__subtf3+0x10c4>
   207d4:	020f1263          	bnez	t5,207f8 <__subtf3+0xfdc>
   207d8:	02f12823          	sw	a5,48(sp)
   207dc:	02b12a23          	sw	a1,52(sp)
   207e0:	03112c23          	sw	a7,56(sp)
   207e4:	02612e23          	sw	t1,60(sp)
   207e8:	d40e96e3          	bnez	t4,20534 <__subtf3+0xd18>
   207ec:	00000413          	li	s0,0
   207f0:	00000a13          	li	s4,0
   207f4:	d08ff06f          	j	1fcfc <__subtf3+0x4e0>
   207f8:	000e9c63          	bnez	t4,20810 <__subtf3+0xff4>
   207fc:	02d12823          	sw	a3,48(sp)
   20800:	02c12a23          	sw	a2,52(sp)
   20804:	03012c23          	sw	a6,56(sp)
   20808:	03c12e23          	sw	t3,60(sp)
   2080c:	ca0ff06f          	j	1fcac <__subtf3+0x490>
   20810:	40f68eb3          	sub	t4,a3,a5
   20814:	40b602b3          	sub	t0,a2,a1
   20818:	01d6bfb3          	sltu	t6,a3,t4
   2081c:	00563f33          	sltu	t5,a2,t0
   20820:	41f282b3          	sub	t0,t0,t6
   20824:	03d12823          	sw	t4,48(sp)
   20828:	02512a23          	sw	t0,52(sp)
   2082c:	00000f93          	li	t6,0
   20830:	01d6f663          	bleu	t4,a3,2083c <__subtf3+0x1020>
   20834:	40c58fb3          	sub	t6,a1,a2
   20838:	001fbf93          	seqz	t6,t6
   2083c:	411803b3          	sub	t2,a6,a7
   20840:	01efefb3          	or	t6,t6,t5
   20844:	41f389b3          	sub	s3,t2,t6
   20848:	03312c23          	sw	s3,56(sp)
   2084c:	00783ab3          	sltu	s5,a6,t2
   20850:	00000913          	li	s2,0
   20854:	000f8463          	beqz	t6,2085c <__subtf3+0x1040>
   20858:	0013b913          	seqz	s2,t2
   2085c:	406e0f33          	sub	t5,t3,t1
   20860:	01596933          	or	s2,s2,s5
   20864:	412f0f33          	sub	t5,t5,s2
   20868:	03e12e23          	sw	t5,60(sp)
   2086c:	00cf1f93          	slli	t6,t5,0xc
   20870:	040fde63          	bgez	t6,208cc <__subtf3+0x10b0>
   20874:	40d786b3          	sub	a3,a5,a3
   20878:	40c58633          	sub	a2,a1,a2
   2087c:	00d7beb3          	sltu	t4,a5,a3
   20880:	41d60eb3          	sub	t4,a2,t4
   20884:	03d12a23          	sw	t4,52(sp)
   20888:	02d12823          	sw	a3,48(sp)
   2088c:	00c5b5b3          	sltu	a1,a1,a2
   20890:	00000e93          	li	t4,0
   20894:	00d7f463          	bleu	a3,a5,2089c <__subtf3+0x1080>
   20898:	00163e93          	seqz	t4,a2
   2089c:	410887b3          	sub	a5,a7,a6
   208a0:	00bee5b3          	or	a1,t4,a1
   208a4:	00f8b6b3          	sltu	a3,a7,a5
   208a8:	40b787b3          	sub	a5,a5,a1
   208ac:	02f12c23          	sw	a5,56(sp)
   208b0:	00058463          	beqz	a1,208b8 <__subtf3+0x109c>
   208b4:	0013b713          	seqz	a4,t2
   208b8:	41c30333          	sub	t1,t1,t3
   208bc:	00d76733          	or	a4,a4,a3
   208c0:	40e30333          	sub	t1,t1,a4
   208c4:	02612e23          	sw	t1,60(sp)
   208c8:	c6dff06f          	j	20534 <__subtf3+0xd18>
   208cc:	005eeeb3          	or	t4,t4,t0
   208d0:	013eeeb3          	or	t4,t4,s3
   208d4:	01eeeeb3          	or	t4,t4,t5
   208d8:	f00e8ae3          	beqz	t4,207ec <__subtf3+0xfd0>
   208dc:	bd0ff06f          	j	1fcac <__subtf3+0x490>
   208e0:	03010393          	addi	t2,sp,48
   208e4:	040f1e63          	bnez	t5,20940 <__subtf3+0x1124>
   208e8:	020e9e63          	bnez	t4,20924 <__subtf3+0x1108>
   208ec:	03f12e23          	sw	t6,60(sp)
   208f0:	02012c23          	sw	zero,56(sp)
   208f4:	02012a23          	sw	zero,52(sp)
   208f8:	02012823          	sw	zero,48(sp)
   208fc:	03c10793          	addi	a5,sp,60
   20900:	0007a703          	lw	a4,0(a5)
   20904:	ffc7a683          	lw	a3,-4(a5)
   20908:	ffc78793          	addi	a5,a5,-4
   2090c:	00371713          	slli	a4,a4,0x3
   20910:	01d6d693          	srli	a3,a3,0x1d
   20914:	00d76733          	or	a4,a4,a3
   20918:	00e7a223          	sw	a4,4(a5)
   2091c:	fef392e3          	bne	t2,a5,20900 <__subtf3+0x10e4>
   20920:	889ff06f          	j	201a8 <__subtf3+0x98c>
   20924:	02f12823          	sw	a5,48(sp)
   20928:	02b12a23          	sw	a1,52(sp)
   2092c:	03112c23          	sw	a7,56(sp)
   20930:	02612e23          	sw	t1,60(sp)
   20934:	00050a13          	mv	s4,a0
   20938:	00028413          	mv	s0,t0
   2093c:	b70ff06f          	j	1fcac <__subtf3+0x490>
   20940:	000e9c63          	bnez	t4,20958 <__subtf3+0x113c>
   20944:	02d12823          	sw	a3,48(sp)
   20948:	02c12a23          	sw	a2,52(sp)
   2094c:	03012c23          	sw	a6,56(sp)
   20950:	03c12e23          	sw	t3,60(sp)
   20954:	fe5ff06f          	j	20938 <__subtf3+0x111c>
   20958:	03f12e23          	sw	t6,60(sp)
   2095c:	02012c23          	sw	zero,56(sp)
   20960:	02012a23          	sw	zero,52(sp)
   20964:	02012823          	sw	zero,48(sp)
   20968:	03c10793          	addi	a5,sp,60
   2096c:	0007a703          	lw	a4,0(a5)
   20970:	ffc7a683          	lw	a3,-4(a5)
   20974:	ffc78793          	addi	a5,a5,-4
   20978:	00371713          	slli	a4,a4,0x3
   2097c:	01d6d693          	srli	a3,a3,0x1d
   20980:	00d76733          	or	a4,a4,a3
   20984:	00e7a223          	sw	a4,4(a5)
   20988:	fef392e3          	bne	t2,a5,2096c <__subtf3+0x1150>
   2098c:	81dff06f          	j	201a8 <__subtf3+0x98c>
   20990:	40f68eb3          	sub	t4,a3,a5
   20994:	40b602b3          	sub	t0,a2,a1
   20998:	01d6bfb3          	sltu	t6,a3,t4
   2099c:	00563f33          	sltu	t5,a2,t0
   209a0:	41f282b3          	sub	t0,t0,t6
   209a4:	03d12823          	sw	t4,48(sp)
   209a8:	02512a23          	sw	t0,52(sp)
   209ac:	00000f93          	li	t6,0
   209b0:	01d6f663          	bleu	t4,a3,209bc <__subtf3+0x11a0>
   209b4:	40c58fb3          	sub	t6,a1,a2
   209b8:	001fbf93          	seqz	t6,t6
   209bc:	411803b3          	sub	t2,a6,a7
   209c0:	01efefb3          	or	t6,t6,t5
   209c4:	41f389b3          	sub	s3,t2,t6
   209c8:	03312c23          	sw	s3,56(sp)
   209cc:	00783ab3          	sltu	s5,a6,t2
   209d0:	00000913          	li	s2,0
   209d4:	000f8463          	beqz	t6,209dc <__subtf3+0x11c0>
   209d8:	0013b913          	seqz	s2,t2
   209dc:	406e0f33          	sub	t5,t3,t1
   209e0:	01596933          	or	s2,s2,s5
   209e4:	412f0f33          	sub	t5,t5,s2
   209e8:	03e12e23          	sw	t5,60(sp)
   209ec:	00cf1f93          	slli	t6,t5,0xc
   209f0:	0c0fde63          	bgez	t6,20acc <__subtf3+0x12b0>
   209f4:	40d786b3          	sub	a3,a5,a3
   209f8:	40c58633          	sub	a2,a1,a2
   209fc:	00d7beb3          	sltu	t4,a5,a3
   20a00:	41d60eb3          	sub	t4,a2,t4
   20a04:	03d12a23          	sw	t4,52(sp)
   20a08:	02d12823          	sw	a3,48(sp)
   20a0c:	00c5b5b3          	sltu	a1,a1,a2
   20a10:	00000e93          	li	t4,0
   20a14:	00d7f463          	bleu	a3,a5,20a1c <__subtf3+0x1200>
   20a18:	00163e93          	seqz	t4,a2
   20a1c:	410887b3          	sub	a5,a7,a6
   20a20:	00bee5b3          	or	a1,t4,a1
   20a24:	00f8b6b3          	sltu	a3,a7,a5
   20a28:	40b787b3          	sub	a5,a5,a1
   20a2c:	02f12c23          	sw	a5,56(sp)
   20a30:	00058463          	beqz	a1,20a38 <__subtf3+0x121c>
   20a34:	0013b713          	seqz	a4,t2
   20a38:	41c30333          	sub	t1,t1,t3
   20a3c:	00d76733          	or	a4,a4,a3
   20a40:	40e30733          	sub	a4,t1,a4
   20a44:	02e12e23          	sw	a4,60(sp)
   20a48:	00050a13          	mv	s4,a0
   20a4c:	03c12503          	lw	a0,60(sp)
   20a50:	08050863          	beqz	a0,20ae0 <__subtf3+0x12c4>
   20a54:	431000ef          	jal	ra,21684 <__clzsi2>
   20a58:	ff450a93          	addi	s5,a0,-12
   20a5c:	41fad913          	srai	s2,s5,0x1f
   20a60:	800009b7          	lui	s3,0x80000
   20a64:	01f97913          	andi	s2,s2,31
   20a68:	01f98993          	addi	s3,s3,31 # 8000001f <__global_pointer$+0x7ffdb8bf>
   20a6c:	01590933          	add	s2,s2,s5
   20a70:	013af9b3          	and	s3,s5,s3
   20a74:	40595913          	srai	s2,s2,0x5
   20a78:	0009d863          	bgez	s3,20a88 <__subtf3+0x126c>
   20a7c:	fff98993          	addi	s3,s3,-1
   20a80:	fe09e993          	ori	s3,s3,-32
   20a84:	00198993          	addi	s3,s3,1
   20a88:	08098863          	beqz	s3,20b18 <__subtf3+0x12fc>
   20a8c:	ffc00593          	li	a1,-4
   20a90:	00090513          	mv	a0,s2
   20a94:	319000ef          	jal	ra,215ac <__mulsi3>
   20a98:	02000693          	li	a3,32
   20a9c:	00291713          	slli	a4,s2,0x2
   20aa0:	ff000813          	li	a6,-16
   20aa4:	413686b3          	sub	a3,a3,s3
   20aa8:	ffc50513          	addi	a0,a0,-4
   20aac:	13051c63          	bne	a0,a6,20be4 <__subtf3+0x13c8>
   20ab0:	04010793          	addi	a5,sp,64
   20ab4:	00e78733          	add	a4,a5,a4
   20ab8:	03012783          	lw	a5,48(sp)
   20abc:	fff90913          	addi	s2,s2,-1 # 7fffff <__global_pointer$+0x7db89f>
   20ac0:	013799b3          	sll	s3,a5,s3
   20ac4:	ff372823          	sw	s3,-16(a4)
   20ac8:	0800006f          	j	20b48 <__subtf3+0x132c>
   20acc:	005eeeb3          	or	t4,t4,t0
   20ad0:	013eeeb3          	or	t4,t4,s3
   20ad4:	01eeeeb3          	or	t4,t4,t5
   20ad8:	d00e8ae3          	beqz	t4,207ec <__subtf3+0xfd0>
   20adc:	f71ff06f          	j	20a4c <__subtf3+0x1230>
   20ae0:	03812503          	lw	a0,56(sp)
   20ae4:	00050863          	beqz	a0,20af4 <__subtf3+0x12d8>
   20ae8:	39d000ef          	jal	ra,21684 <__clzsi2>
   20aec:	02050513          	addi	a0,a0,32
   20af0:	f69ff06f          	j	20a58 <__subtf3+0x123c>
   20af4:	03412503          	lw	a0,52(sp)
   20af8:	00050863          	beqz	a0,20b08 <__subtf3+0x12ec>
   20afc:	389000ef          	jal	ra,21684 <__clzsi2>
   20b00:	04050513          	addi	a0,a0,64
   20b04:	f55ff06f          	j	20a58 <__subtf3+0x123c>
   20b08:	03012503          	lw	a0,48(sp)
   20b0c:	379000ef          	jal	ra,21684 <__clzsi2>
   20b10:	06050513          	addi	a0,a0,96
   20b14:	f45ff06f          	j	20a58 <__subtf3+0x123c>
   20b18:	ffc00593          	li	a1,-4
   20b1c:	00090513          	mv	a0,s2
   20b20:	28d000ef          	jal	ra,215ac <__mulsi3>
   20b24:	03010993          	addi	s3,sp,48
   20b28:	00300793          	li	a5,3
   20b2c:	00a98733          	add	a4,s3,a0
   20b30:	00c72703          	lw	a4,12(a4)
   20b34:	fff78793          	addi	a5,a5,-1
   20b38:	ffc98993          	addi	s3,s3,-4
   20b3c:	00e9a823          	sw	a4,16(s3)
   20b40:	ff27d6e3          	ble	s2,a5,20b2c <__subtf3+0x1310>
   20b44:	fff90913          	addi	s2,s2,-1
   20b48:	fff00713          	li	a4,-1
   20b4c:	0ce91263          	bne	s2,a4,20c10 <__subtf3+0x13f4>
   20b50:	1a8ac263          	blt	s5,s0,20cf4 <__subtf3+0x14d8>
   20b54:	408a8433          	sub	s0,s5,s0
   20b58:	00140413          	addi	s0,s0,1
   20b5c:	41f45793          	srai	a5,s0,0x1f
   20b60:	80000737          	lui	a4,0x80000
   20b64:	01f7f793          	andi	a5,a5,31
   20b68:	01f70713          	addi	a4,a4,31 # 8000001f <__global_pointer$+0x7ffdb8bf>
   20b6c:	008787b3          	add	a5,a5,s0
   20b70:	00e47433          	and	s0,s0,a4
   20b74:	4057d793          	srai	a5,a5,0x5
   20b78:	00045863          	bgez	s0,20b88 <__subtf3+0x136c>
   20b7c:	fff40413          	addi	s0,s0,-1
   20b80:	fe046413          	ori	s0,s0,-32
   20b84:	00140413          	addi	s0,s0,1
   20b88:	00040693          	mv	a3,s0
   20b8c:	00000513          	li	a0,0
   20b90:	00000713          	li	a4,0
   20b94:	08f74a63          	blt	a4,a5,20c28 <__subtf3+0x140c>
   20b98:	00078713          	mv	a4,a5
   20b9c:	0007d463          	bgez	a5,20ba4 <__subtf3+0x1388>
   20ba0:	00000713          	li	a4,0
   20ba4:	00279313          	slli	t1,a5,0x2
   20ba8:	0a041a63          	bnez	s0,20c5c <__subtf3+0x1440>
   20bac:	00300613          	li	a2,3
   20bb0:	03010713          	addi	a4,sp,48
   20bb4:	40f60633          	sub	a2,a2,a5
   20bb8:	08d65663          	ble	a3,a2,20c44 <__subtf3+0x1428>
   20bbc:	00400713          	li	a4,4
   20bc0:	40f707b3          	sub	a5,a4,a5
   20bc4:	00300693          	li	a3,3
   20bc8:	10f6da63          	ble	a5,a3,20cdc <__subtf3+0x14c0>
   20bcc:	03012703          	lw	a4,48(sp)
   20bd0:	00a037b3          	snez	a5,a0
   20bd4:	00000413          	li	s0,0
   20bd8:	00f767b3          	or	a5,a4,a5
   20bdc:	02f12823          	sw	a5,48(sp)
   20be0:	8ccff06f          	j	1fcac <__subtf3+0x490>
   20be4:	03010793          	addi	a5,sp,48
   20be8:	00a785b3          	add	a1,a5,a0
   20bec:	00a70633          	add	a2,a4,a0
   20bf0:	00c78633          	add	a2,a5,a2
   20bf4:	00c5a783          	lw	a5,12(a1)
   20bf8:	0105a583          	lw	a1,16(a1)
   20bfc:	00d7d7b3          	srl	a5,a5,a3
   20c00:	013595b3          	sll	a1,a1,s3
   20c04:	00b7e7b3          	or	a5,a5,a1
   20c08:	00f62823          	sw	a5,16(a2)
   20c0c:	e9dff06f          	j	20aa8 <__subtf3+0x128c>
   20c10:	00291793          	slli	a5,s2,0x2
   20c14:	03010693          	addi	a3,sp,48
   20c18:	00f687b3          	add	a5,a3,a5
   20c1c:	0007a023          	sw	zero,0(a5)
   20c20:	fff90913          	addi	s2,s2,-1
   20c24:	f29ff06f          	j	20b4c <__subtf3+0x1330>
   20c28:	00271613          	slli	a2,a4,0x2
   20c2c:	03010593          	addi	a1,sp,48
   20c30:	00c58633          	add	a2,a1,a2
   20c34:	00062603          	lw	a2,0(a2)
   20c38:	00170713          	addi	a4,a4,1
   20c3c:	00c56533          	or	a0,a0,a2
   20c40:	f55ff06f          	j	20b94 <__subtf3+0x1378>
   20c44:	006705b3          	add	a1,a4,t1
   20c48:	0005a583          	lw	a1,0(a1)
   20c4c:	00168693          	addi	a3,a3,1
   20c50:	00470713          	addi	a4,a4,4
   20c54:	feb72e23          	sw	a1,-4(a4)
   20c58:	f61ff06f          	j	20bb8 <__subtf3+0x139c>
   20c5c:	00271713          	slli	a4,a4,0x2
   20c60:	04010693          	addi	a3,sp,64
   20c64:	00e68733          	add	a4,a3,a4
   20c68:	ff072703          	lw	a4,-16(a4)
   20c6c:	02000613          	li	a2,32
   20c70:	40860633          	sub	a2,a2,s0
   20c74:	00c71733          	sll	a4,a4,a2
   20c78:	00e56533          	or	a0,a0,a4
   20c7c:	00300713          	li	a4,3
   20c80:	03010593          	addi	a1,sp,48
   20c84:	00000813          	li	a6,0
   20c88:	40f70733          	sub	a4,a4,a5
   20c8c:	02e84463          	blt	a6,a4,20cb4 <__subtf3+0x1498>
   20c90:	00400693          	li	a3,4
   20c94:	40f687b3          	sub	a5,a3,a5
   20c98:	00271713          	slli	a4,a4,0x2
   20c9c:	04010693          	addi	a3,sp,64
   20ca0:	00e68733          	add	a4,a3,a4
   20ca4:	03c12683          	lw	a3,60(sp)
   20ca8:	0086d433          	srl	s0,a3,s0
   20cac:	fe872823          	sw	s0,-16(a4)
   20cb0:	f15ff06f          	j	20bc4 <__subtf3+0x13a8>
   20cb4:	006588b3          	add	a7,a1,t1
   20cb8:	0008a683          	lw	a3,0(a7)
   20cbc:	0048a883          	lw	a7,4(a7)
   20cc0:	00180813          	addi	a6,a6,1
   20cc4:	0086d6b3          	srl	a3,a3,s0
   20cc8:	00c898b3          	sll	a7,a7,a2
   20ccc:	0116e6b3          	or	a3,a3,a7
   20cd0:	00d5a023          	sw	a3,0(a1)
   20cd4:	00458593          	addi	a1,a1,4
   20cd8:	fb5ff06f          	j	20c8c <__subtf3+0x1470>
   20cdc:	00279713          	slli	a4,a5,0x2
   20ce0:	03010613          	addi	a2,sp,48
   20ce4:	00e60733          	add	a4,a2,a4
   20ce8:	00072023          	sw	zero,0(a4)
   20cec:	00178793          	addi	a5,a5,1
   20cf0:	ed9ff06f          	j	20bc8 <__subtf3+0x13ac>
   20cf4:	03c12783          	lw	a5,60(sp)
   20cf8:	fff80737          	lui	a4,0xfff80
   20cfc:	fff70713          	addi	a4,a4,-1 # fff7ffff <__global_pointer$+0xfff5b89f>
   20d00:	41540433          	sub	s0,s0,s5
   20d04:	00e7f7b3          	and	a5,a5,a4
   20d08:	dd1fe06f          	j	1fad8 <__subtf3+0x2bc>
   20d0c:	02012e23          	sw	zero,60(sp)
   20d10:	02012c23          	sw	zero,56(sp)
   20d14:	02012a23          	sw	zero,52(sp)
   20d18:	02012823          	sw	zero,48(sp)
   20d1c:	810ff06f          	j	1fd2c <__subtf3+0x510>

00020d20 <__fixtfsi>:
   20d20:	00452703          	lw	a4,4(a0)
   20d24:	00852783          	lw	a5,8(a0)
   20d28:	00c52603          	lw	a2,12(a0)
   20d2c:	00052683          	lw	a3,0(a0)
   20d30:	fe010113          	addi	sp,sp,-32
   20d34:	00e12223          	sw	a4,4(sp)
   20d38:	00f12423          	sw	a5,8(sp)
   20d3c:	00e12a23          	sw	a4,20(sp)
   20d40:	00f12c23          	sw	a5,24(sp)
   20d44:	00004737          	lui	a4,0x4
   20d48:	00161793          	slli	a5,a2,0x1
   20d4c:	00d12023          	sw	a3,0(sp)
   20d50:	00d12823          	sw	a3,16(sp)
   20d54:	00c12623          	sw	a2,12(sp)
   20d58:	0117d693          	srli	a3,a5,0x11
   20d5c:	ffe70793          	addi	a5,a4,-2 # 3ffe <main-0xc076>
   20d60:	00000513          	li	a0,0
   20d64:	02d7d063          	ble	a3,a5,20d84 <__fixtfsi+0x64>
   20d68:	01d70793          	addi	a5,a4,29
   20d6c:	01061593          	slli	a1,a2,0x10
   20d70:	01f65613          	srli	a2,a2,0x1f
   20d74:	00d7dc63          	ble	a3,a5,20d8c <__fixtfsi+0x6c>
   20d78:	80000537          	lui	a0,0x80000
   20d7c:	fff54513          	not	a0,a0
   20d80:	00a60533          	add	a0,a2,a0
   20d84:	02010113          	addi	sp,sp,32
   20d88:	00008067          	ret
   20d8c:	000107b7          	lui	a5,0x10
   20d90:	0105d593          	srli	a1,a1,0x10
   20d94:	00f5e5b3          	or	a1,a1,a5
   20d98:	06f70793          	addi	a5,a4,111
   20d9c:	40d787b3          	sub	a5,a5,a3
   20da0:	4057d713          	srai	a4,a5,0x5
   20da4:	00b12e23          	sw	a1,28(sp)
   20da8:	01f7f793          	andi	a5,a5,31
   20dac:	0a079263          	bnez	a5,20e50 <__fixtfsi+0x130>
   20db0:	00300593          	li	a1,3
   20db4:	01010693          	addi	a3,sp,16
   20db8:	00271513          	slli	a0,a4,0x2
   20dbc:	40e585b3          	sub	a1,a1,a4
   20dc0:	02f5de63          	ble	a5,a1,20dfc <__fixtfsi+0xdc>
   20dc4:	00400793          	li	a5,4
   20dc8:	40e78733          	sub	a4,a5,a4
   20dcc:	01010693          	addi	a3,sp,16
   20dd0:	00271793          	slli	a5,a4,0x2
   20dd4:	00f687b3          	add	a5,a3,a5
   20dd8:	00400693          	li	a3,4
   20ddc:	0007a023          	sw	zero,0(a5) # 10000 <main-0x74>
   20de0:	00170713          	addi	a4,a4,1
   20de4:	00478793          	addi	a5,a5,4
   20de8:	fed71ae3          	bne	a4,a3,20ddc <__fixtfsi+0xbc>
   20dec:	01012503          	lw	a0,16(sp)
   20df0:	f8060ae3          	beqz	a2,20d84 <__fixtfsi+0x64>
   20df4:	40a00533          	neg	a0,a0
   20df8:	f8dff06f          	j	20d84 <__fixtfsi+0x64>
   20dfc:	00a68833          	add	a6,a3,a0
   20e00:	00082803          	lw	a6,0(a6)
   20e04:	00178793          	addi	a5,a5,1
   20e08:	00468693          	addi	a3,a3,4
   20e0c:	ff06ae23          	sw	a6,-4(a3)
   20e10:	fb1ff06f          	j	20dc0 <__fixtfsi+0xa0>
   20e14:	ff052683          	lw	a3,-16(a0) # 7ffffff0 <__global_pointer$+0x7ffdb890>
   20e18:	ff072303          	lw	t1,-16(a4)
   20e1c:	011696b3          	sll	a3,a3,a7
   20e20:	00f35333          	srl	t1,t1,a5
   20e24:	0066e6b3          	or	a3,a3,t1
   20e28:	00d12823          	sw	a3,16(sp)
   20e2c:	00100693          	li	a3,1
   20e30:	ff06c2e3          	blt	a3,a6,20e14 <__fixtfsi+0xf4>
   20e34:	00168713          	addi	a4,a3,1
   20e38:	02010513          	addi	a0,sp,32
   20e3c:	00269693          	slli	a3,a3,0x2
   20e40:	00d506b3          	add	a3,a0,a3
   20e44:	00f5d7b3          	srl	a5,a1,a5
   20e48:	fef6a823          	sw	a5,-16(a3)
   20e4c:	f81ff06f          	j	20dcc <__fixtfsi+0xac>
   20e50:	00170513          	addi	a0,a4,1
   20e54:	02010893          	addi	a7,sp,32
   20e58:	00300813          	li	a6,3
   20e5c:	00251513          	slli	a0,a0,0x2
   20e60:	40e80833          	sub	a6,a6,a4
   20e64:	00a88533          	add	a0,a7,a0
   20e68:	00271713          	slli	a4,a4,0x2
   20e6c:	02000893          	li	a7,32
   20e70:	02010313          	addi	t1,sp,32
   20e74:	00000693          	li	a3,0
   20e78:	40f888b3          	sub	a7,a7,a5
   20e7c:	00e30733          	add	a4,t1,a4
   20e80:	fb1ff06f          	j	20e30 <__fixtfsi+0x110>

00020e84 <__floatsitf>:
   20e84:	fd010113          	addi	sp,sp,-48
   20e88:	02912223          	sw	s1,36(sp)
   20e8c:	02112623          	sw	ra,44(sp)
   20e90:	02812423          	sw	s0,40(sp)
   20e94:	03212023          	sw	s2,32(sp)
   20e98:	00050493          	mv	s1,a0
   20e9c:	14058663          	beqz	a1,20fe8 <__floatsitf+0x164>
   20ea0:	00058413          	mv	s0,a1
   20ea4:	01f5d913          	srli	s2,a1,0x1f
   20ea8:	0005d463          	bgez	a1,20eb0 <__floatsitf+0x2c>
   20eac:	40b00433          	neg	s0,a1
   20eb0:	00040513          	mv	a0,s0
   20eb4:	7d0000ef          	jal	ra,21684 <__clzsi2>
   20eb8:	05150593          	addi	a1,a0,81
   20ebc:	00004737          	lui	a4,0x4
   20ec0:	01e70713          	addi	a4,a4,30 # 401e <main-0xc056>
   20ec4:	4055d793          	srai	a5,a1,0x5
   20ec8:	00812823          	sw	s0,16(sp)
   20ecc:	00012a23          	sw	zero,20(sp)
   20ed0:	00012c23          	sw	zero,24(sp)
   20ed4:	00012e23          	sw	zero,28(sp)
   20ed8:	01f5f593          	andi	a1,a1,31
   20edc:	40a70733          	sub	a4,a4,a0
   20ee0:	02058c63          	beqz	a1,20f18 <__floatsitf+0x94>
   20ee4:	00200693          	li	a3,2
   20ee8:	0ed79c63          	bne	a5,a3,20fe0 <__floatsitf+0x15c>
   20eec:	02000693          	li	a3,32
   20ef0:	40b686b3          	sub	a3,a3,a1
   20ef4:	00d456b3          	srl	a3,s0,a3
   20ef8:	00d12e23          	sw	a3,28(sp)
   20efc:	fff78693          	addi	a3,a5,-1
   20f00:	02010613          	addi	a2,sp,32
   20f04:	00279793          	slli	a5,a5,0x2
   20f08:	00f607b3          	add	a5,a2,a5
   20f0c:	00b41433          	sll	s0,s0,a1
   20f10:	fe87a823          	sw	s0,-16(a5)
   20f14:	0340006f          	j	20f48 <__floatsitf+0xc4>
   20f18:	00300693          	li	a3,3
   20f1c:	40f686b3          	sub	a3,a3,a5
   20f20:	02010613          	addi	a2,sp,32
   20f24:	00269693          	slli	a3,a3,0x2
   20f28:	00d606b3          	add	a3,a2,a3
   20f2c:	ff06a683          	lw	a3,-16(a3)
   20f30:	00200613          	li	a2,2
   20f34:	00d12e23          	sw	a3,28(sp)
   20f38:	00200693          	li	a3,2
   20f3c:	00c79663          	bne	a5,a2,20f48 <__floatsitf+0xc4>
   20f40:	00812c23          	sw	s0,24(sp)
   20f44:	00100693          	li	a3,1
   20f48:	01010793          	addi	a5,sp,16
   20f4c:	00269613          	slli	a2,a3,0x2
   20f50:	00c78633          	add	a2,a5,a2
   20f54:	fff00793          	li	a5,-1
   20f58:	00062023          	sw	zero,0(a2)
   20f5c:	fff68693          	addi	a3,a3,-1
   20f60:	ffc60613          	addi	a2,a2,-4
   20f64:	fef69ae3          	bne	a3,a5,20f58 <__floatsitf+0xd4>
   20f68:	000086b7          	lui	a3,0x8
   20f6c:	01c12783          	lw	a5,28(sp)
   20f70:	fff68693          	addi	a3,a3,-1 # 7fff <main-0x8075>
   20f74:	00d776b3          	and	a3,a4,a3
   20f78:	00e15703          	lhu	a4,14(sp)
   20f7c:	00f11623          	sh	a5,12(sp)
   20f80:	ffff87b7          	lui	a5,0xffff8
   20f84:	00f77733          	and	a4,a4,a5
   20f88:	00d76733          	or	a4,a4,a3
   20f8c:	00875793          	srli	a5,a4,0x8
   20f90:	00e11723          	sh	a4,14(sp)
   20f94:	07f7f793          	andi	a5,a5,127
   20f98:	00791713          	slli	a4,s2,0x7
   20f9c:	00e7e7b3          	or	a5,a5,a4
   20fa0:	00f107a3          	sb	a5,15(sp)
   20fa4:	01012783          	lw	a5,16(sp)
   20fa8:	02c12083          	lw	ra,44(sp)
   20fac:	02812403          	lw	s0,40(sp)
   20fb0:	00f4a023          	sw	a5,0(s1)
   20fb4:	01412783          	lw	a5,20(sp)
   20fb8:	00048513          	mv	a0,s1
   20fbc:	02012903          	lw	s2,32(sp)
   20fc0:	00f4a223          	sw	a5,4(s1)
   20fc4:	01812783          	lw	a5,24(sp)
   20fc8:	00f4a423          	sw	a5,8(s1)
   20fcc:	00c12783          	lw	a5,12(sp)
   20fd0:	00f4a623          	sw	a5,12(s1)
   20fd4:	02412483          	lw	s1,36(sp)
   20fd8:	03010113          	addi	sp,sp,48
   20fdc:	00008067          	ret
   20fe0:	00300793          	li	a5,3
   20fe4:	f19ff06f          	j	20efc <__floatsitf+0x78>
   20fe8:	00012e23          	sw	zero,28(sp)
   20fec:	00012c23          	sw	zero,24(sp)
   20ff0:	00012a23          	sw	zero,20(sp)
   20ff4:	00012823          	sw	zero,16(sp)
   20ff8:	00000713          	li	a4,0
   20ffc:	00000913          	li	s2,0
   21000:	f69ff06f          	j	20f68 <__floatsitf+0xe4>

00021004 <__extenddftf2>:
   21004:	01465793          	srli	a5,a2,0x14
   21008:	00100737          	lui	a4,0x100
   2100c:	fff70713          	addi	a4,a4,-1 # fffff <__global_pointer$+0xdb89f>
   21010:	7ff7f793          	andi	a5,a5,2047
   21014:	fc010113          	addi	sp,sp,-64
   21018:	00c77733          	and	a4,a4,a2
   2101c:	00178693          	addi	a3,a5,1 # ffff8001 <__global_pointer$+0xfffd38a1>
   21020:	02812c23          	sw	s0,56(sp)
   21024:	02912a23          	sw	s1,52(sp)
   21028:	02112e23          	sw	ra,60(sp)
   2102c:	01f65493          	srli	s1,a2,0x1f
   21030:	03212823          	sw	s2,48(sp)
   21034:	03312623          	sw	s3,44(sp)
   21038:	03412423          	sw	s4,40(sp)
   2103c:	03512223          	sw	s5,36(sp)
   21040:	00b12823          	sw	a1,16(sp)
   21044:	00e12a23          	sw	a4,20(sp)
   21048:	00012e23          	sw	zero,28(sp)
   2104c:	00012c23          	sw	zero,24(sp)
   21050:	7ff6f693          	andi	a3,a3,2047
   21054:	00100613          	li	a2,1
   21058:	00050413          	mv	s0,a0
   2105c:	0ad65c63          	ble	a3,a2,21114 <__extenddftf2+0x110>
   21060:	000046b7          	lui	a3,0x4
   21064:	c0068693          	addi	a3,a3,-1024 # 3c00 <main-0xc474>
   21068:	0045d513          	srli	a0,a1,0x4
   2106c:	00d787b3          	add	a5,a5,a3
   21070:	00475693          	srli	a3,a4,0x4
   21074:	01c71713          	slli	a4,a4,0x1c
   21078:	00a76733          	or	a4,a4,a0
   2107c:	01c59593          	slli	a1,a1,0x1c
   21080:	00d12e23          	sw	a3,28(sp)
   21084:	00e12c23          	sw	a4,24(sp)
   21088:	00b12a23          	sw	a1,20(sp)
   2108c:	00012823          	sw	zero,16(sp)
   21090:	01c12703          	lw	a4,28(sp)
   21094:	ffff86b7          	lui	a3,0xffff8
   21098:	00749613          	slli	a2,s1,0x7
   2109c:	00e11623          	sh	a4,12(sp)
   210a0:	00008737          	lui	a4,0x8
   210a4:	fff70713          	addi	a4,a4,-1 # 7fff <main-0x8075>
   210a8:	00e7f7b3          	and	a5,a5,a4
   210ac:	00e15703          	lhu	a4,14(sp)
   210b0:	00040513          	mv	a0,s0
   210b4:	03c12083          	lw	ra,60(sp)
   210b8:	00d77733          	and	a4,a4,a3
   210bc:	00f767b3          	or	a5,a4,a5
   210c0:	0087d713          	srli	a4,a5,0x8
   210c4:	00f11723          	sh	a5,14(sp)
   210c8:	07f77493          	andi	s1,a4,127
   210cc:	01012783          	lw	a5,16(sp)
   210d0:	00c4e4b3          	or	s1,s1,a2
   210d4:	009107a3          	sb	s1,15(sp)
   210d8:	00f42023          	sw	a5,0(s0)
   210dc:	01412783          	lw	a5,20(sp)
   210e0:	03412483          	lw	s1,52(sp)
   210e4:	03012903          	lw	s2,48(sp)
   210e8:	00f42223          	sw	a5,4(s0)
   210ec:	01812783          	lw	a5,24(sp)
   210f0:	02c12983          	lw	s3,44(sp)
   210f4:	02812a03          	lw	s4,40(sp)
   210f8:	00f42423          	sw	a5,8(s0)
   210fc:	00c12783          	lw	a5,12(sp)
   21100:	02412a83          	lw	s5,36(sp)
   21104:	00f42623          	sw	a5,12(s0)
   21108:	03812403          	lw	s0,56(sp)
   2110c:	04010113          	addi	sp,sp,64
   21110:	00008067          	ret
   21114:	00b76533          	or	a0,a4,a1
   21118:	10079063          	bnez	a5,21218 <__extenddftf2+0x214>
   2111c:	f6050ae3          	beqz	a0,21090 <__extenddftf2+0x8c>
   21120:	06070463          	beqz	a4,21188 <__extenddftf2+0x184>
   21124:	00070513          	mv	a0,a4
   21128:	55c000ef          	jal	ra,21684 <__clzsi2>
   2112c:	00050a13          	mv	s4,a0
   21130:	031a0993          	addi	s3,s4,49
   21134:	4059d913          	srai	s2,s3,0x5
   21138:	01f9f993          	andi	s3,s3,31
   2113c:	04098c63          	beqz	s3,21194 <__extenddftf2+0x190>
   21140:	ffc00593          	li	a1,-4
   21144:	00090513          	mv	a0,s2
   21148:	464000ef          	jal	ra,215ac <__mulsi3>
   2114c:	02000793          	li	a5,32
   21150:	01010a93          	addi	s5,sp,16
   21154:	ff000613          	li	a2,-16
   21158:	413787b3          	sub	a5,a5,s3
   2115c:	ffc50513          	addi	a0,a0,-4
   21160:	ffca8a93          	addi	s5,s5,-4
   21164:	08c51863          	bne	a0,a2,211f4 <__extenddftf2+0x1f0>
   21168:	02010793          	addi	a5,sp,32
   2116c:	fff90693          	addi	a3,s2,-1
   21170:	00291913          	slli	s2,s2,0x2
   21174:	01278933          	add	s2,a5,s2
   21178:	01012783          	lw	a5,16(sp)
   2117c:	013799b3          	sll	s3,a5,s3
   21180:	ff392823          	sw	s3,-16(s2)
   21184:	0400006f          	j	211c4 <__extenddftf2+0x1c0>
   21188:	4fc000ef          	jal	ra,21684 <__clzsi2>
   2118c:	02050a13          	addi	s4,a0,32
   21190:	fa1ff06f          	j	21130 <__extenddftf2+0x12c>
   21194:	ffc00593          	li	a1,-4
   21198:	00090513          	mv	a0,s2
   2119c:	410000ef          	jal	ra,215ac <__mulsi3>
   211a0:	01010993          	addi	s3,sp,16
   211a4:	00300793          	li	a5,3
   211a8:	00a98733          	add	a4,s3,a0
   211ac:	00c72703          	lw	a4,12(a4)
   211b0:	fff78793          	addi	a5,a5,-1
   211b4:	ffc98993          	addi	s3,s3,-4
   211b8:	00e9a823          	sw	a4,16(s3)
   211bc:	ff27d6e3          	ble	s2,a5,211a8 <__extenddftf2+0x1a4>
   211c0:	fff90693          	addi	a3,s2,-1
   211c4:	01010793          	addi	a5,sp,16
   211c8:	00269713          	slli	a4,a3,0x2
   211cc:	00e78733          	add	a4,a5,a4
   211d0:	fff00793          	li	a5,-1
   211d4:	00072023          	sw	zero,0(a4)
   211d8:	fff68693          	addi	a3,a3,-1 # ffff7fff <__global_pointer$+0xfffd389f>
   211dc:	ffc70713          	addi	a4,a4,-4
   211e0:	fef69ae3          	bne	a3,a5,211d4 <__extenddftf2+0x1d0>
   211e4:	000047b7          	lui	a5,0x4
   211e8:	c0c78793          	addi	a5,a5,-1012 # 3c0c <main-0xc468>
   211ec:	414787b3          	sub	a5,a5,s4
   211f0:	ea1ff06f          	j	21090 <__extenddftf2+0x8c>
   211f4:	01010713          	addi	a4,sp,16
   211f8:	00a706b3          	add	a3,a4,a0
   211fc:	00c6a703          	lw	a4,12(a3)
   21200:	0106a683          	lw	a3,16(a3)
   21204:	00f75733          	srl	a4,a4,a5
   21208:	013696b3          	sll	a3,a3,s3
   2120c:	00d76733          	or	a4,a4,a3
   21210:	00eaa823          	sw	a4,16(s5)
   21214:	f49ff06f          	j	2115c <__extenddftf2+0x158>
   21218:	000087b7          	lui	a5,0x8
   2121c:	02050863          	beqz	a0,2124c <__extenddftf2+0x248>
   21220:	01c71793          	slli	a5,a4,0x1c
   21224:	0045d693          	srli	a3,a1,0x4
   21228:	00d7e7b3          	or	a5,a5,a3
   2122c:	00f12c23          	sw	a5,24(sp)
   21230:	00475713          	srli	a4,a4,0x4
   21234:	000087b7          	lui	a5,0x8
   21238:	01c59593          	slli	a1,a1,0x1c
   2123c:	00f76733          	or	a4,a4,a5
   21240:	00b12a23          	sw	a1,20(sp)
   21244:	00012823          	sw	zero,16(sp)
   21248:	00e12e23          	sw	a4,28(sp)
   2124c:	fff78793          	addi	a5,a5,-1 # 7fff <main-0x8075>
   21250:	e41ff06f          	j	21090 <__extenddftf2+0x8c>

00021254 <__trunctfdf2>:
   21254:	00c52583          	lw	a1,12(a0)
   21258:	00852783          	lw	a5,8(a0)
   2125c:	00452703          	lw	a4,4(a0)
   21260:	fe010113          	addi	sp,sp,-32
   21264:	00052683          	lw	a3,0(a0)
   21268:	00f12423          	sw	a5,8(sp)
   2126c:	00f12c23          	sw	a5,24(sp)
   21270:	01059793          	slli	a5,a1,0x10
   21274:	00e12223          	sw	a4,4(sp)
   21278:	00e12a23          	sw	a4,20(sp)
   2127c:	0107d793          	srli	a5,a5,0x10
   21280:	00159713          	slli	a4,a1,0x1
   21284:	00b12623          	sw	a1,12(sp)
   21288:	00d12023          	sw	a3,0(sp)
   2128c:	00d12823          	sw	a3,16(sp)
   21290:	00f12e23          	sw	a5,28(sp)
   21294:	01175713          	srli	a4,a4,0x11
   21298:	01f5d593          	srli	a1,a1,0x1f
   2129c:	01010313          	addi	t1,sp,16
   212a0:	01c10613          	addi	a2,sp,28
   212a4:	00062783          	lw	a5,0(a2)
   212a8:	ffc62683          	lw	a3,-4(a2)
   212ac:	ffc60613          	addi	a2,a2,-4
   212b0:	00379793          	slli	a5,a5,0x3
   212b4:	01d6d693          	srli	a3,a3,0x1d
   212b8:	00d7e7b3          	or	a5,a5,a3
   212bc:	00f62223          	sw	a5,4(a2)
   212c0:	fec312e3          	bne	t1,a2,212a4 <__trunctfdf2+0x50>
   212c4:	01012683          	lw	a3,16(sp)
   212c8:	00170793          	addi	a5,a4,1
   212cc:	00369513          	slli	a0,a3,0x3
   212d0:	000086b7          	lui	a3,0x8
   212d4:	fff68693          	addi	a3,a3,-1 # 7fff <main-0x8075>
   212d8:	00d7f7b3          	and	a5,a5,a3
   212dc:	00a12823          	sw	a0,16(sp)
   212e0:	00100693          	li	a3,1
   212e4:	1af6dc63          	ble	a5,a3,2149c <__trunctfdf2+0x248>
   212e8:	ffffc7b7          	lui	a5,0xffffc
   212ec:	40078793          	addi	a5,a5,1024 # ffffc400 <__global_pointer$+0xfffd7ca0>
   212f0:	00f70733          	add	a4,a4,a5
   212f4:	7fe00793          	li	a5,2046
   212f8:	1ee7ce63          	blt	a5,a4,214f4 <__trunctfdf2+0x2a0>
   212fc:	06e05863          	blez	a4,2136c <__trunctfdf2+0x118>
   21300:	01812783          	lw	a5,24(sp)
   21304:	01c12603          	lw	a2,28(sp)
   21308:	01412803          	lw	a6,20(sp)
   2130c:	01c7d693          	srli	a3,a5,0x1c
   21310:	00461613          	slli	a2,a2,0x4
   21314:	00d66633          	or	a2,a2,a3
   21318:	00481693          	slli	a3,a6,0x4
   2131c:	00a6e6b3          	or	a3,a3,a0
   21320:	00479793          	slli	a5,a5,0x4
   21324:	01c85813          	srli	a6,a6,0x1c
   21328:	00d036b3          	snez	a3,a3
   2132c:	0107e7b3          	or	a5,a5,a6
   21330:	00f6e6b3          	or	a3,a3,a5
   21334:	00c12a23          	sw	a2,20(sp)
   21338:	00d12823          	sw	a3,16(sp)
   2133c:	01012683          	lw	a3,16(sp)
   21340:	01412783          	lw	a5,20(sp)
   21344:	0076f613          	andi	a2,a3,7
   21348:	1a060c63          	beqz	a2,21500 <__trunctfdf2+0x2ac>
   2134c:	00f6f613          	andi	a2,a3,15
   21350:	00400513          	li	a0,4
   21354:	1aa60663          	beq	a2,a0,21500 <__trunctfdf2+0x2ac>
   21358:	00468613          	addi	a2,a3,4
   2135c:	00d636b3          	sltu	a3,a2,a3
   21360:	00d787b3          	add	a5,a5,a3
   21364:	00060693          	mv	a3,a2
   21368:	1980006f          	j	21500 <__trunctfdf2+0x2ac>
   2136c:	fcc00793          	li	a5,-52
   21370:	00f75a63          	ble	a5,a4,21384 <__trunctfdf2+0x130>
   21374:	00012a23          	sw	zero,20(sp)
   21378:	00d12823          	sw	a3,16(sp)
   2137c:	00000713          	li	a4,0
   21380:	fbdff06f          	j	2133c <__trunctfdf2+0xe8>
   21384:	01c12783          	lw	a5,28(sp)
   21388:	000806b7          	lui	a3,0x80
   2138c:	00000893          	li	a7,0
   21390:	00d7e7b3          	or	a5,a5,a3
   21394:	00f12e23          	sw	a5,28(sp)
   21398:	03d00793          	li	a5,61
   2139c:	40e78733          	sub	a4,a5,a4
   213a0:	40575513          	srai	a0,a4,0x5
   213a4:	00030793          	mv	a5,t1
   213a8:	01f77713          	andi	a4,a4,31
   213ac:	00000693          	li	a3,0
   213b0:	0007a803          	lw	a6,0(a5)
   213b4:	00168693          	addi	a3,a3,1 # 80001 <__global_pointer$+0x5b8a1>
   213b8:	00478793          	addi	a5,a5,4
   213bc:	0108e8b3          	or	a7,a7,a6
   213c0:	fed518e3          	bne	a0,a3,213b0 <__trunctfdf2+0x15c>
   213c4:	00269e93          	slli	t4,a3,0x2
   213c8:	04071e63          	bnez	a4,21424 <__trunctfdf2+0x1d0>
   213cc:	00300793          	li	a5,3
   213d0:	40d787b3          	sub	a5,a5,a3
   213d4:	02e7dc63          	ble	a4,a5,2140c <__trunctfdf2+0x1b8>
   213d8:	00400793          	li	a5,4
   213dc:	40d786b3          	sub	a3,a5,a3
   213e0:	00400713          	li	a4,4
   213e4:	00269793          	slli	a5,a3,0x2
   213e8:	00f307b3          	add	a5,t1,a5
   213ec:	0007a023          	sw	zero,0(a5)
   213f0:	00168693          	addi	a3,a3,1
   213f4:	fee698e3          	bne	a3,a4,213e4 <__trunctfdf2+0x190>
   213f8:	01012703          	lw	a4,16(sp)
   213fc:	011037b3          	snez	a5,a7
   21400:	00f767b3          	or	a5,a4,a5
   21404:	00f12823          	sw	a5,16(sp)
   21408:	f75ff06f          	j	2137c <__trunctfdf2+0x128>
   2140c:	01d60533          	add	a0,a2,t4
   21410:	00052503          	lw	a0,0(a0)
   21414:	00170713          	addi	a4,a4,1
   21418:	00460613          	addi	a2,a2,4
   2141c:	fea62e23          	sw	a0,-4(a2)
   21420:	fb5ff06f          	j	213d4 <__trunctfdf2+0x180>
   21424:	02010793          	addi	a5,sp,32
   21428:	01d787b3          	add	a5,a5,t4
   2142c:	ff07a783          	lw	a5,-16(a5)
   21430:	02000813          	li	a6,32
   21434:	40e80833          	sub	a6,a6,a4
   21438:	010797b3          	sll	a5,a5,a6
   2143c:	00f8e8b3          	or	a7,a7,a5
   21440:	00300793          	li	a5,3
   21444:	00000e13          	li	t3,0
   21448:	40d787b3          	sub	a5,a5,a3
   2144c:	02fe4463          	blt	t3,a5,21474 <__trunctfdf2+0x220>
   21450:	00400613          	li	a2,4
   21454:	40d606b3          	sub	a3,a2,a3
   21458:	00279793          	slli	a5,a5,0x2
   2145c:	02010613          	addi	a2,sp,32
   21460:	00f607b3          	add	a5,a2,a5
   21464:	01c12603          	lw	a2,28(sp)
   21468:	00e65733          	srl	a4,a2,a4
   2146c:	fee7a823          	sw	a4,-16(a5)
   21470:	f71ff06f          	j	213e0 <__trunctfdf2+0x18c>
   21474:	01d60f33          	add	t5,a2,t4
   21478:	000f2503          	lw	a0,0(t5)
   2147c:	004f2f03          	lw	t5,4(t5)
   21480:	001e0e13          	addi	t3,t3,1
   21484:	00e55533          	srl	a0,a0,a4
   21488:	010f1f33          	sll	t5,t5,a6
   2148c:	01e56533          	or	a0,a0,t5
   21490:	00a62023          	sw	a0,0(a2)
   21494:	00460613          	addi	a2,a2,4
   21498:	fb5ff06f          	j	2144c <__trunctfdf2+0x1f8>
   2149c:	01412603          	lw	a2,20(sp)
   214a0:	01812783          	lw	a5,24(sp)
   214a4:	01c12803          	lw	a6,28(sp)
   214a8:	00f666b3          	or	a3,a2,a5
   214ac:	0106e6b3          	or	a3,a3,a6
   214b0:	00a6e6b3          	or	a3,a3,a0
   214b4:	00071863          	bnez	a4,214c4 <__trunctfdf2+0x270>
   214b8:	00d036b3          	snez	a3,a3
   214bc:	00000793          	li	a5,0
   214c0:	e85ff06f          	j	21344 <__trunctfdf2+0xf0>
   214c4:	0c068a63          	beqz	a3,21598 <__trunctfdf2+0x344>
   214c8:	01c65693          	srli	a3,a2,0x1c
   214cc:	00481813          	slli	a6,a6,0x4
   214d0:	00479613          	slli	a2,a5,0x4
   214d4:	01c7d793          	srli	a5,a5,0x1c
   214d8:	00400737          	lui	a4,0x400
   214dc:	00c6e6b3          	or	a3,a3,a2
   214e0:	0107e7b3          	or	a5,a5,a6
   214e4:	00e7e7b3          	or	a5,a5,a4
   214e8:	ff86f693          	andi	a3,a3,-8
   214ec:	7ff00713          	li	a4,2047
   214f0:	e55ff06f          	j	21344 <__trunctfdf2+0xf0>
   214f4:	00000793          	li	a5,0
   214f8:	00000693          	li	a3,0
   214fc:	7ff00713          	li	a4,2047
   21500:	00879613          	slli	a2,a5,0x8
   21504:	00065e63          	bgez	a2,21520 <__trunctfdf2+0x2cc>
   21508:	00170713          	addi	a4,a4,1 # 400001 <__global_pointer$+0x3db8a1>
   2150c:	7ff00613          	li	a2,2047
   21510:	08c70863          	beq	a4,a2,215a0 <__trunctfdf2+0x34c>
   21514:	ff800637          	lui	a2,0xff800
   21518:	fff60613          	addi	a2,a2,-1 # ff7fffff <__global_pointer$+0xff7db89f>
   2151c:	00c7f7b3          	and	a5,a5,a2
   21520:	01d79613          	slli	a2,a5,0x1d
   21524:	0036d693          	srli	a3,a3,0x3
   21528:	00d666b3          	or	a3,a2,a3
   2152c:	7ff00613          	li	a2,2047
   21530:	0037d793          	srli	a5,a5,0x3
   21534:	00c71e63          	bne	a4,a2,21550 <__trunctfdf2+0x2fc>
   21538:	00f6e6b3          	or	a3,a3,a5
   2153c:	00000793          	li	a5,0
   21540:	00068863          	beqz	a3,21550 <__trunctfdf2+0x2fc>
   21544:	000807b7          	lui	a5,0x80
   21548:	00000693          	li	a3,0
   2154c:	00000593          	li	a1,0
   21550:	00100637          	lui	a2,0x100
   21554:	fff60613          	addi	a2,a2,-1 # fffff <__global_pointer$+0xdb89f>
   21558:	00c7f7b3          	and	a5,a5,a2
   2155c:	80100637          	lui	a2,0x80100
   21560:	7ff77713          	andi	a4,a4,2047
   21564:	fff60613          	addi	a2,a2,-1 # 800fffff <__global_pointer$+0x800db89f>
   21568:	01471713          	slli	a4,a4,0x14
   2156c:	00c7f7b3          	and	a5,a5,a2
   21570:	00e7e7b3          	or	a5,a5,a4
   21574:	80000737          	lui	a4,0x80000
   21578:	fff74713          	not	a4,a4
   2157c:	01f59593          	slli	a1,a1,0x1f
   21580:	00e7f7b3          	and	a5,a5,a4
   21584:	00b7e733          	or	a4,a5,a1
   21588:	00068513          	mv	a0,a3
   2158c:	00070593          	mv	a1,a4
   21590:	02010113          	addi	sp,sp,32
   21594:	00008067          	ret
   21598:	00000793          	li	a5,0
   2159c:	f61ff06f          	j	214fc <__trunctfdf2+0x2a8>
   215a0:	00000793          	li	a5,0
   215a4:	00000693          	li	a3,0
   215a8:	f79ff06f          	j	21520 <__trunctfdf2+0x2cc>

000215ac <__mulsi3>:
   215ac:	00050613          	mv	a2,a0
   215b0:	00000513          	li	a0,0
   215b4:	0015f693          	andi	a3,a1,1
   215b8:	00068463          	beqz	a3,215c0 <__mulsi3+0x14>
   215bc:	00c50533          	add	a0,a0,a2
   215c0:	0015d593          	srli	a1,a1,0x1
   215c4:	00161613          	slli	a2,a2,0x1
   215c8:	fe0596e3          	bnez	a1,215b4 <__mulsi3+0x8>
   215cc:	00008067          	ret

000215d0 <__divsi3>:
   215d0:	06054063          	bltz	a0,21630 <__umodsi3+0x10>
   215d4:	0605c663          	bltz	a1,21640 <__umodsi3+0x20>

000215d8 <__udivsi3>:
   215d8:	00058613          	mv	a2,a1
   215dc:	00050593          	mv	a1,a0
   215e0:	fff00513          	li	a0,-1
   215e4:	02060c63          	beqz	a2,2161c <__udivsi3+0x44>
   215e8:	00100693          	li	a3,1
   215ec:	00b67a63          	bleu	a1,a2,21600 <__udivsi3+0x28>
   215f0:	00c05863          	blez	a2,21600 <__udivsi3+0x28>
   215f4:	00161613          	slli	a2,a2,0x1
   215f8:	00169693          	slli	a3,a3,0x1
   215fc:	feb66ae3          	bltu	a2,a1,215f0 <__udivsi3+0x18>
   21600:	00000513          	li	a0,0
   21604:	00c5e663          	bltu	a1,a2,21610 <__udivsi3+0x38>
   21608:	40c585b3          	sub	a1,a1,a2
   2160c:	00d56533          	or	a0,a0,a3
   21610:	0016d693          	srli	a3,a3,0x1
   21614:	00165613          	srli	a2,a2,0x1
   21618:	fe0696e3          	bnez	a3,21604 <__udivsi3+0x2c>
   2161c:	00008067          	ret

00021620 <__umodsi3>:
   21620:	00008293          	mv	t0,ra
   21624:	fb5ff0ef          	jal	ra,215d8 <__udivsi3>
   21628:	00058513          	mv	a0,a1
   2162c:	00028067          	jr	t0
   21630:	40a00533          	neg	a0,a0
   21634:	0005d863          	bgez	a1,21644 <__umodsi3+0x24>
   21638:	40b005b3          	neg	a1,a1
   2163c:	f9dff06f          	j	215d8 <__udivsi3>
   21640:	40b005b3          	neg	a1,a1
   21644:	00008293          	mv	t0,ra
   21648:	f91ff0ef          	jal	ra,215d8 <__udivsi3>
   2164c:	40a00533          	neg	a0,a0
   21650:	00028067          	jr	t0

00021654 <__modsi3>:
   21654:	00008293          	mv	t0,ra
   21658:	0005ca63          	bltz	a1,2166c <__modsi3+0x18>
   2165c:	00054c63          	bltz	a0,21674 <__modsi3+0x20>
   21660:	f79ff0ef          	jal	ra,215d8 <__udivsi3>
   21664:	00058513          	mv	a0,a1
   21668:	00028067          	jr	t0
   2166c:	40b005b3          	neg	a1,a1
   21670:	fe0558e3          	bgez	a0,21660 <__modsi3+0xc>
   21674:	40a00533          	neg	a0,a0
   21678:	f61ff0ef          	jal	ra,215d8 <__udivsi3>
   2167c:	40b00533          	neg	a0,a1
   21680:	00028067          	jr	t0

00021684 <__clzsi2>:
   21684:	000107b7          	lui	a5,0x10
   21688:	02f57a63          	bleu	a5,a0,216bc <__clzsi2+0x38>
   2168c:	0ff00793          	li	a5,255
   21690:	00a7b7b3          	sltu	a5,a5,a0
   21694:	00379793          	slli	a5,a5,0x3
   21698:	02000713          	li	a4,32
   2169c:	40f70733          	sub	a4,a4,a5
   216a0:	00f557b3          	srl	a5,a0,a5
   216a4:	00022537          	lui	a0,0x22
   216a8:	34c50513          	addi	a0,a0,844 # 2234c <__clz_tab>
   216ac:	00a787b3          	add	a5,a5,a0
   216b0:	0007c503          	lbu	a0,0(a5) # 10000 <main-0x74>
   216b4:	40a70533          	sub	a0,a4,a0
   216b8:	00008067          	ret
   216bc:	01000737          	lui	a4,0x1000
   216c0:	01000793          	li	a5,16
   216c4:	fce56ae3          	bltu	a0,a4,21698 <__clzsi2+0x14>
   216c8:	01800793          	li	a5,24
   216cc:	fcdff06f          	j	21698 <__clzsi2+0x14>
