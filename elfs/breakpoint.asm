
breakpoint:     file format elf32-littleriscv


Disassembly of section .text:

00010074 <main>:
   10074:	00013537          	lui	a0,0x13
   10078:	ff010113          	addi	sp,sp,-16
   1007c:	0ac50513          	addi	a0,a0,172 # 130ac <__modsi3+0x30>
   10080:	00112623          	sw	ra,12(sp)
   10084:	46c000ef          	jal	ra,104f0 <puts>
   10088:	00013537          	lui	a0,0x13
   1008c:	0bc50513          	addi	a0,a0,188 # 130bc <__modsi3+0x40>
   10090:	460000ef          	jal	ra,104f0 <puts>
   10094:	00100073          	ebreak
   10098:	00013537          	lui	a0,0x13
   1009c:	10450513          	addi	a0,a0,260 # 13104 <__modsi3+0x88>
   100a0:	450000ef          	jal	ra,104f0 <puts>
   100a4:	00c12083          	lw	ra,12(sp)
   100a8:	00000513          	li	a0,0
   100ac:	01010113          	addi	sp,sp,16
   100b0:	00008067          	ret

000100b4 <_start>:
   100b4:	00005197          	auipc	gp,0x5
   100b8:	0e418193          	addi	gp,gp,228 # 15198 <__global_pointer$>
   100bc:	00005517          	auipc	a0,0x5
   100c0:	8f050513          	addi	a0,a0,-1808 # 149ac <_edata>
   100c4:	00005617          	auipc	a2,0x5
   100c8:	94860613          	addi	a2,a2,-1720 # 14a0c <_end>
   100cc:	40a60633          	sub	a2,a2,a0
   100d0:	00000593          	li	a1,0
   100d4:	278000ef          	jal	ra,1034c <memset>
   100d8:	00000517          	auipc	a0,0x0
   100dc:	16450513          	addi	a0,a0,356 # 1023c <__libc_fini_array>
   100e0:	114000ef          	jal	ra,101f4 <atexit>
   100e4:	1c8000ef          	jal	ra,102ac <__libc_init_array>
   100e8:	00012503          	lw	a0,0(sp)
   100ec:	00410593          	addi	a1,sp,4
   100f0:	00000613          	li	a2,0
   100f4:	f81ff0ef          	jal	ra,10074 <main>
   100f8:	1100006f          	j	10208 <exit>

000100fc <_fini>:
   100fc:	00008067          	ret

00010100 <deregister_tm_clones>:
   10100:	00015537          	lui	a0,0x15
   10104:	000157b7          	lui	a5,0x15
   10108:	99850713          	addi	a4,a0,-1640 # 14998 <__TMC_END__>
   1010c:	99878793          	addi	a5,a5,-1640 # 14998 <__TMC_END__>
   10110:	00e78c63          	beq	a5,a4,10128 <deregister_tm_clones+0x28>
   10114:	00000337          	lui	t1,0x0
   10118:	00030313          	mv	t1,t1
   1011c:	00030663          	beqz	t1,10128 <deregister_tm_clones+0x28>
   10120:	99850513          	addi	a0,a0,-1640
   10124:	00030067          	jr	t1
   10128:	00008067          	ret

0001012c <register_tm_clones>:
   1012c:	000157b7          	lui	a5,0x15
   10130:	00015537          	lui	a0,0x15
   10134:	99878593          	addi	a1,a5,-1640 # 14998 <__TMC_END__>
   10138:	99850793          	addi	a5,a0,-1640 # 14998 <__TMC_END__>
   1013c:	40f585b3          	sub	a1,a1,a5
   10140:	4025d593          	srai	a1,a1,0x2
   10144:	01f5d793          	srli	a5,a1,0x1f
   10148:	00b785b3          	add	a1,a5,a1
   1014c:	4015d593          	srai	a1,a1,0x1
   10150:	00058c63          	beqz	a1,10168 <register_tm_clones+0x3c>
   10154:	00000337          	lui	t1,0x0
   10158:	00030313          	mv	t1,t1
   1015c:	00030663          	beqz	t1,10168 <register_tm_clones+0x3c>
   10160:	99850513          	addi	a0,a0,-1640
   10164:	00030067          	jr	t1
   10168:	00008067          	ret

0001016c <__do_global_dtors_aux>:
   1016c:	82c1c703          	lbu	a4,-2004(gp) # 149c4 <completed.5148>
   10170:	04071663          	bnez	a4,101bc <__do_global_dtors_aux+0x50>
   10174:	ff010113          	addi	sp,sp,-16
   10178:	00812423          	sw	s0,8(sp)
   1017c:	00112623          	sw	ra,12(sp)
   10180:	00078413          	mv	s0,a5
   10184:	f7dff0ef          	jal	ra,10100 <deregister_tm_clones>
   10188:	000007b7          	lui	a5,0x0
   1018c:	00078793          	mv	a5,a5
   10190:	00078a63          	beqz	a5,101a4 <__do_global_dtors_aux+0x38>
   10194:	00013537          	lui	a0,0x13
   10198:	11850513          	addi	a0,a0,280 # 13118 <__EH_FRAME_BEGIN__>
   1019c:	ffff0097          	auipc	ra,0xffff0
   101a0:	e64080e7          	jalr	-412(ra) # 0 <main-0x10074>
   101a4:	00100793          	li	a5,1
   101a8:	82f18623          	sb	a5,-2004(gp) # 149c4 <completed.5148>
   101ac:	00c12083          	lw	ra,12(sp)
   101b0:	00812403          	lw	s0,8(sp)
   101b4:	01010113          	addi	sp,sp,16
   101b8:	00008067          	ret
   101bc:	00008067          	ret

000101c0 <frame_dummy>:
   101c0:	000007b7          	lui	a5,0x0
   101c4:	00078793          	mv	a5,a5
   101c8:	02078463          	beqz	a5,101f0 <frame_dummy+0x30>
   101cc:	00013537          	lui	a0,0x13
   101d0:	ff010113          	addi	sp,sp,-16
   101d4:	83018593          	addi	a1,gp,-2000 # 149c8 <object.5153>
   101d8:	11850513          	addi	a0,a0,280 # 13118 <__EH_FRAME_BEGIN__>
   101dc:	00112623          	sw	ra,12(sp)
   101e0:	ffff0097          	auipc	ra,0xffff0
   101e4:	e20080e7          	jalr	-480(ra) # 0 <main-0x10074>
   101e8:	00c12083          	lw	ra,12(sp)
   101ec:	01010113          	addi	sp,sp,16
   101f0:	f3dff06f          	j	1012c <register_tm_clones>

000101f4 <atexit>:
   101f4:	00050593          	mv	a1,a0
   101f8:	00000693          	li	a3,0
   101fc:	00000613          	li	a2,0
   10200:	00000513          	li	a0,0
   10204:	3140006f          	j	10518 <__register_exitproc>

00010208 <exit>:
   10208:	ff010113          	addi	sp,sp,-16
   1020c:	00000593          	li	a1,0
   10210:	00812423          	sw	s0,8(sp)
   10214:	00112623          	sw	ra,12(sp)
   10218:	00050413          	mv	s0,a0
   1021c:	37c000ef          	jal	ra,10598 <__call_exitprocs>
   10220:	000157b7          	lui	a5,0x15
   10224:	99c7a503          	lw	a0,-1636(a5) # 1499c <_global_impure_ptr>
   10228:	03c52783          	lw	a5,60(a0)
   1022c:	00078463          	beqz	a5,10234 <exit+0x2c>
   10230:	000780e7          	jalr	a5
   10234:	00040513          	mv	a0,s0
   10238:	571020ef          	jal	ra,12fa8 <_exit>

0001023c <__libc_fini_array>:
   1023c:	ff010113          	addi	sp,sp,-16
   10240:	000147b7          	lui	a5,0x14
   10244:	00014737          	lui	a4,0x14
   10248:	00812423          	sw	s0,8(sp)
   1024c:	16070713          	addi	a4,a4,352 # 14160 <__init_array_end>
   10250:	16478413          	addi	s0,a5,356 # 14164 <__fini_array_end>
   10254:	40e40433          	sub	s0,s0,a4
   10258:	00912223          	sw	s1,4(sp)
   1025c:	01212023          	sw	s2,0(sp)
   10260:	00112623          	sw	ra,12(sp)
   10264:	40245413          	srai	s0,s0,0x2
   10268:	00000493          	li	s1,0
   1026c:	16478913          	addi	s2,a5,356
   10270:	00941e63          	bne	s0,s1,1028c <__libc_fini_array+0x50>
   10274:	00812403          	lw	s0,8(sp)
   10278:	00c12083          	lw	ra,12(sp)
   1027c:	00412483          	lw	s1,4(sp)
   10280:	00012903          	lw	s2,0(sp)
   10284:	01010113          	addi	sp,sp,16
   10288:	e75ff06f          	j	100fc <_fini>
   1028c:	ffc00593          	li	a1,-4
   10290:	00048513          	mv	a0,s1
   10294:	541020ef          	jal	ra,12fd4 <__mulsi3>
   10298:	00a90533          	add	a0,s2,a0
   1029c:	ffc52783          	lw	a5,-4(a0)
   102a0:	00148493          	addi	s1,s1,1
   102a4:	000780e7          	jalr	a5
   102a8:	fc9ff06f          	j	10270 <__libc_fini_array+0x34>

000102ac <__libc_init_array>:
   102ac:	ff010113          	addi	sp,sp,-16
   102b0:	00812423          	sw	s0,8(sp)
   102b4:	00912223          	sw	s1,4(sp)
   102b8:	00014437          	lui	s0,0x14
   102bc:	000144b7          	lui	s1,0x14
   102c0:	15c48793          	addi	a5,s1,348 # 1415c <__frame_dummy_init_array_entry>
   102c4:	15c40413          	addi	s0,s0,348 # 1415c <__frame_dummy_init_array_entry>
   102c8:	40f40433          	sub	s0,s0,a5
   102cc:	01212023          	sw	s2,0(sp)
   102d0:	00112623          	sw	ra,12(sp)
   102d4:	40245413          	srai	s0,s0,0x2
   102d8:	15c48493          	addi	s1,s1,348
   102dc:	00000913          	li	s2,0
   102e0:	04891263          	bne	s2,s0,10324 <__libc_init_array+0x78>
   102e4:	000144b7          	lui	s1,0x14
   102e8:	e15ff0ef          	jal	ra,100fc <_fini>
   102ec:	00014437          	lui	s0,0x14
   102f0:	15c48793          	addi	a5,s1,348 # 1415c <__frame_dummy_init_array_entry>
   102f4:	16040413          	addi	s0,s0,352 # 14160 <__init_array_end>
   102f8:	40f40433          	sub	s0,s0,a5
   102fc:	40245413          	srai	s0,s0,0x2
   10300:	15c48493          	addi	s1,s1,348
   10304:	00000913          	li	s2,0
   10308:	02891863          	bne	s2,s0,10338 <__libc_init_array+0x8c>
   1030c:	00c12083          	lw	ra,12(sp)
   10310:	00812403          	lw	s0,8(sp)
   10314:	00412483          	lw	s1,4(sp)
   10318:	00012903          	lw	s2,0(sp)
   1031c:	01010113          	addi	sp,sp,16
   10320:	00008067          	ret
   10324:	0004a783          	lw	a5,0(s1)
   10328:	00190913          	addi	s2,s2,1
   1032c:	00448493          	addi	s1,s1,4
   10330:	000780e7          	jalr	a5
   10334:	fadff06f          	j	102e0 <__libc_init_array+0x34>
   10338:	0004a783          	lw	a5,0(s1)
   1033c:	00190913          	addi	s2,s2,1
   10340:	00448493          	addi	s1,s1,4
   10344:	000780e7          	jalr	a5
   10348:	fc1ff06f          	j	10308 <__libc_init_array+0x5c>

0001034c <memset>:
   1034c:	00f00813          	li	a6,15
   10350:	00050713          	mv	a4,a0
   10354:	02c87e63          	bleu	a2,a6,10390 <memset+0x44>
   10358:	00f77793          	andi	a5,a4,15
   1035c:	0a079063          	bnez	a5,103fc <memset+0xb0>
   10360:	08059263          	bnez	a1,103e4 <memset+0x98>
   10364:	ff067693          	andi	a3,a2,-16
   10368:	00f67613          	andi	a2,a2,15
   1036c:	00e686b3          	add	a3,a3,a4
   10370:	00b72023          	sw	a1,0(a4)
   10374:	00b72223          	sw	a1,4(a4)
   10378:	00b72423          	sw	a1,8(a4)
   1037c:	00b72623          	sw	a1,12(a4)
   10380:	01070713          	addi	a4,a4,16
   10384:	fed766e3          	bltu	a4,a3,10370 <memset+0x24>
   10388:	00061463          	bnez	a2,10390 <memset+0x44>
   1038c:	00008067          	ret
   10390:	40c806b3          	sub	a3,a6,a2
   10394:	00269693          	slli	a3,a3,0x2
   10398:	00000297          	auipc	t0,0x0
   1039c:	005686b3          	add	a3,a3,t0
   103a0:	00c68067          	jr	12(a3)
   103a4:	00b70723          	sb	a1,14(a4)
   103a8:	00b706a3          	sb	a1,13(a4)
   103ac:	00b70623          	sb	a1,12(a4)
   103b0:	00b705a3          	sb	a1,11(a4)
   103b4:	00b70523          	sb	a1,10(a4)
   103b8:	00b704a3          	sb	a1,9(a4)
   103bc:	00b70423          	sb	a1,8(a4)
   103c0:	00b703a3          	sb	a1,7(a4)
   103c4:	00b70323          	sb	a1,6(a4)
   103c8:	00b702a3          	sb	a1,5(a4)
   103cc:	00b70223          	sb	a1,4(a4)
   103d0:	00b701a3          	sb	a1,3(a4)
   103d4:	00b70123          	sb	a1,2(a4)
   103d8:	00b700a3          	sb	a1,1(a4)
   103dc:	00b70023          	sb	a1,0(a4)
   103e0:	00008067          	ret
   103e4:	0ff5f593          	andi	a1,a1,255
   103e8:	00859693          	slli	a3,a1,0x8
   103ec:	00d5e5b3          	or	a1,a1,a3
   103f0:	01059693          	slli	a3,a1,0x10
   103f4:	00d5e5b3          	or	a1,a1,a3
   103f8:	f6dff06f          	j	10364 <memset+0x18>
   103fc:	00279693          	slli	a3,a5,0x2
   10400:	00000297          	auipc	t0,0x0
   10404:	005686b3          	add	a3,a3,t0
   10408:	00008293          	mv	t0,ra
   1040c:	fa0680e7          	jalr	-96(a3)
   10410:	00028093          	mv	ra,t0
   10414:	ff078793          	addi	a5,a5,-16
   10418:	40f70733          	sub	a4,a4,a5
   1041c:	00f60633          	add	a2,a2,a5
   10420:	f6c878e3          	bleu	a2,a6,10390 <memset+0x44>
   10424:	f3dff06f          	j	10360 <memset+0x14>

00010428 <_puts_r>:
   10428:	fc010113          	addi	sp,sp,-64
   1042c:	02812c23          	sw	s0,56(sp)
   10430:	00050413          	mv	s0,a0
   10434:	00058513          	mv	a0,a1
   10438:	00b12623          	sw	a1,12(sp)
   1043c:	02112e23          	sw	ra,60(sp)
   10440:	0bc000ef          	jal	ra,104fc <strlen>
   10444:	000137b7          	lui	a5,0x13
   10448:	11478793          	addi	a5,a5,276 # 13114 <__modsi3+0x98>
   1044c:	02f12423          	sw	a5,40(sp)
   10450:	00100793          	li	a5,1
   10454:	02f12623          	sw	a5,44(sp)
   10458:	02010793          	addi	a5,sp,32
   1045c:	00c12583          	lw	a1,12(sp)
   10460:	00f12a23          	sw	a5,20(sp)
   10464:	00200793          	li	a5,2
   10468:	00f12c23          	sw	a5,24(sp)
   1046c:	03842783          	lw	a5,56(s0)
   10470:	02a12223          	sw	a0,36(sp)
   10474:	00150513          	addi	a0,a0,1
   10478:	02b12023          	sw	a1,32(sp)
   1047c:	00a12e23          	sw	a0,28(sp)
   10480:	00842583          	lw	a1,8(s0)
   10484:	00079a63          	bnez	a5,10498 <_puts_r+0x70>
   10488:	00040513          	mv	a0,s0
   1048c:	00b12623          	sw	a1,12(sp)
   10490:	340000ef          	jal	ra,107d0 <__sinit>
   10494:	00c12583          	lw	a1,12(sp)
   10498:	00c59783          	lh	a5,12(a1)
   1049c:	01279713          	slli	a4,a5,0x12
   104a0:	02074263          	bltz	a4,104c4 <_puts_r+0x9c>
   104a4:	000026b7          	lui	a3,0x2
   104a8:	0645a703          	lw	a4,100(a1)
   104ac:	00d7e7b3          	or	a5,a5,a3
   104b0:	00f59623          	sh	a5,12(a1)
   104b4:	ffffe7b7          	lui	a5,0xffffe
   104b8:	fff78793          	addi	a5,a5,-1 # ffffdfff <__global_pointer$+0xfffe8e67>
   104bc:	00f777b3          	and	a5,a4,a5
   104c0:	06f5a223          	sw	a5,100(a1)
   104c4:	01410613          	addi	a2,sp,20
   104c8:	00040513          	mv	a0,s0
   104cc:	4a4000ef          	jal	ra,10970 <__sfvwrite_r>
   104d0:	fff00793          	li	a5,-1
   104d4:	00051463          	bnez	a0,104dc <_puts_r+0xb4>
   104d8:	00a00793          	li	a5,10
   104dc:	03c12083          	lw	ra,60(sp)
   104e0:	03812403          	lw	s0,56(sp)
   104e4:	00078513          	mv	a0,a5
   104e8:	04010113          	addi	sp,sp,64
   104ec:	00008067          	ret

000104f0 <puts>:
   104f0:	00050593          	mv	a1,a0
   104f4:	8081a503          	lw	a0,-2040(gp) # 149a0 <_impure_ptr>
   104f8:	f31ff06f          	j	10428 <_puts_r>

000104fc <strlen>:
   104fc:	00050793          	mv	a5,a0
   10500:	00178793          	addi	a5,a5,1
   10504:	fff7c703          	lbu	a4,-1(a5)
   10508:	fe071ce3          	bnez	a4,10500 <strlen+0x4>
   1050c:	40a78533          	sub	a0,a5,a0
   10510:	fff50513          	addi	a0,a0,-1
   10514:	00008067          	ret

00010518 <__register_exitproc>:
   10518:	000157b7          	lui	a5,0x15
   1051c:	99c7a703          	lw	a4,-1636(a5) # 1499c <_global_impure_ptr>
   10520:	00050313          	mv	t1,a0
   10524:	14872783          	lw	a5,328(a4)
   10528:	00079663          	bnez	a5,10534 <__register_exitproc+0x1c>
   1052c:	14c70793          	addi	a5,a4,332
   10530:	14f72423          	sw	a5,328(a4)
   10534:	0047a703          	lw	a4,4(a5)
   10538:	01f00813          	li	a6,31
   1053c:	fff00513          	li	a0,-1
   10540:	04e84a63          	blt	a6,a4,10594 <__register_exitproc+0x7c>
   10544:	00271893          	slli	a7,a4,0x2
   10548:	02030c63          	beqz	t1,10580 <__register_exitproc+0x68>
   1054c:	01178533          	add	a0,a5,a7
   10550:	08c52423          	sw	a2,136(a0)
   10554:	1887a803          	lw	a6,392(a5)
   10558:	00100613          	li	a2,1
   1055c:	00e61633          	sll	a2,a2,a4
   10560:	00c86833          	or	a6,a6,a2
   10564:	1907a423          	sw	a6,392(a5)
   10568:	10d52423          	sw	a3,264(a0)
   1056c:	00200693          	li	a3,2
   10570:	00d31863          	bne	t1,a3,10580 <__register_exitproc+0x68>
   10574:	18c7a683          	lw	a3,396(a5)
   10578:	00c6e633          	or	a2,a3,a2
   1057c:	18c7a623          	sw	a2,396(a5)
   10580:	00170713          	addi	a4,a4,1
   10584:	00e7a223          	sw	a4,4(a5)
   10588:	011787b3          	add	a5,a5,a7
   1058c:	00b7a423          	sw	a1,8(a5)
   10590:	00000513          	li	a0,0
   10594:	00008067          	ret

00010598 <__call_exitprocs>:
   10598:	fd010113          	addi	sp,sp,-48
   1059c:	000157b7          	lui	a5,0x15
   105a0:	01312e23          	sw	s3,28(sp)
   105a4:	99c7a983          	lw	s3,-1636(a5) # 1499c <_global_impure_ptr>
   105a8:	01412c23          	sw	s4,24(sp)
   105ac:	01512a23          	sw	s5,20(sp)
   105b0:	01612823          	sw	s6,16(sp)
   105b4:	02112623          	sw	ra,44(sp)
   105b8:	02812423          	sw	s0,40(sp)
   105bc:	02912223          	sw	s1,36(sp)
   105c0:	03212023          	sw	s2,32(sp)
   105c4:	01712623          	sw	s7,12(sp)
   105c8:	00050a93          	mv	s5,a0
   105cc:	00058a13          	mv	s4,a1
   105d0:	00100b13          	li	s6,1
   105d4:	1489a483          	lw	s1,328(s3)
   105d8:	00048c63          	beqz	s1,105f0 <__call_exitprocs+0x58>
   105dc:	0044a403          	lw	s0,4(s1)
   105e0:	fff40913          	addi	s2,s0,-1
   105e4:	00241413          	slli	s0,s0,0x2
   105e8:	00848433          	add	s0,s1,s0
   105ec:	02095863          	bgez	s2,1061c <__call_exitprocs+0x84>
   105f0:	02c12083          	lw	ra,44(sp)
   105f4:	02812403          	lw	s0,40(sp)
   105f8:	02412483          	lw	s1,36(sp)
   105fc:	02012903          	lw	s2,32(sp)
   10600:	01c12983          	lw	s3,28(sp)
   10604:	01812a03          	lw	s4,24(sp)
   10608:	01412a83          	lw	s5,20(sp)
   1060c:	01012b03          	lw	s6,16(sp)
   10610:	00c12b83          	lw	s7,12(sp)
   10614:	03010113          	addi	sp,sp,48
   10618:	00008067          	ret
   1061c:	000a0c63          	beqz	s4,10634 <__call_exitprocs+0x9c>
   10620:	10442783          	lw	a5,260(s0)
   10624:	01478863          	beq	a5,s4,10634 <__call_exitprocs+0x9c>
   10628:	fff90913          	addi	s2,s2,-1
   1062c:	ffc40413          	addi	s0,s0,-4
   10630:	fbdff06f          	j	105ec <__call_exitprocs+0x54>
   10634:	0044a703          	lw	a4,4(s1)
   10638:	00442783          	lw	a5,4(s0)
   1063c:	fff70713          	addi	a4,a4,-1
   10640:	03271c63          	bne	a4,s2,10678 <__call_exitprocs+0xe0>
   10644:	0124a223          	sw	s2,4(s1)
   10648:	fe0780e3          	beqz	a5,10628 <__call_exitprocs+0x90>
   1064c:	1884a683          	lw	a3,392(s1)
   10650:	012b1733          	sll	a4,s6,s2
   10654:	0044ab83          	lw	s7,4(s1)
   10658:	00d776b3          	and	a3,a4,a3
   1065c:	02069263          	bnez	a3,10680 <__call_exitprocs+0xe8>
   10660:	000780e7          	jalr	a5
   10664:	0044a703          	lw	a4,4(s1)
   10668:	1489a783          	lw	a5,328(s3)
   1066c:	f77714e3          	bne	a4,s7,105d4 <__call_exitprocs+0x3c>
   10670:	faf48ce3          	beq	s1,a5,10628 <__call_exitprocs+0x90>
   10674:	f61ff06f          	j	105d4 <__call_exitprocs+0x3c>
   10678:	00042223          	sw	zero,4(s0)
   1067c:	fcdff06f          	j	10648 <__call_exitprocs+0xb0>
   10680:	18c4a683          	lw	a3,396(s1)
   10684:	08442583          	lw	a1,132(s0)
   10688:	00d77733          	and	a4,a4,a3
   1068c:	00071863          	bnez	a4,1069c <__call_exitprocs+0x104>
   10690:	000a8513          	mv	a0,s5
   10694:	000780e7          	jalr	a5
   10698:	fcdff06f          	j	10664 <__call_exitprocs+0xcc>
   1069c:	00058513          	mv	a0,a1
   106a0:	000780e7          	jalr	a5
   106a4:	fc1ff06f          	j	10664 <__call_exitprocs+0xcc>

000106a8 <__fp_lock>:
   106a8:	00000513          	li	a0,0
   106ac:	00008067          	ret

000106b0 <_cleanup_r>:
   106b0:	000125b7          	lui	a1,0x12
   106b4:	f7c58593          	addi	a1,a1,-132 # 11f7c <_fclose_r>
   106b8:	7bc0006f          	j	10e74 <_fwalk_reent>

000106bc <std.isra.0>:
   106bc:	ff010113          	addi	sp,sp,-16
   106c0:	00812423          	sw	s0,8(sp)
   106c4:	00112623          	sw	ra,12(sp)
   106c8:	00050413          	mv	s0,a0
   106cc:	00b51623          	sh	a1,12(a0)
   106d0:	00c51723          	sh	a2,14(a0)
   106d4:	00052023          	sw	zero,0(a0)
   106d8:	00052223          	sw	zero,4(a0)
   106dc:	00052423          	sw	zero,8(a0)
   106e0:	06052223          	sw	zero,100(a0)
   106e4:	00052823          	sw	zero,16(a0)
   106e8:	00052a23          	sw	zero,20(a0)
   106ec:	00052c23          	sw	zero,24(a0)
   106f0:	00800613          	li	a2,8
   106f4:	00000593          	li	a1,0
   106f8:	05c50513          	addi	a0,a0,92
   106fc:	c51ff0ef          	jal	ra,1034c <memset>
   10700:	000127b7          	lui	a5,0x12
   10704:	c7478793          	addi	a5,a5,-908 # 11c74 <__sread>
   10708:	02f42023          	sw	a5,32(s0)
   1070c:	000127b7          	lui	a5,0x12
   10710:	ccc78793          	addi	a5,a5,-820 # 11ccc <__swrite>
   10714:	02f42223          	sw	a5,36(s0)
   10718:	000127b7          	lui	a5,0x12
   1071c:	d5078793          	addi	a5,a5,-688 # 11d50 <__sseek>
   10720:	02f42423          	sw	a5,40(s0)
   10724:	000127b7          	lui	a5,0x12
   10728:	da878793          	addi	a5,a5,-600 # 11da8 <__sclose>
   1072c:	00842e23          	sw	s0,28(s0)
   10730:	02f42623          	sw	a5,44(s0)
   10734:	00c12083          	lw	ra,12(sp)
   10738:	00812403          	lw	s0,8(sp)
   1073c:	01010113          	addi	sp,sp,16
   10740:	00008067          	ret

00010744 <__fp_unlock>:
   10744:	00000513          	li	a0,0
   10748:	00008067          	ret

0001074c <__sfmoreglue>:
   1074c:	ff010113          	addi	sp,sp,-16
   10750:	01212023          	sw	s2,0(sp)
   10754:	00058913          	mv	s2,a1
   10758:	00812423          	sw	s0,8(sp)
   1075c:	06800593          	li	a1,104
   10760:	00050413          	mv	s0,a0
   10764:	fff90513          	addi	a0,s2,-1
   10768:	00112623          	sw	ra,12(sp)
   1076c:	00912223          	sw	s1,4(sp)
   10770:	065020ef          	jal	ra,12fd4 <__mulsi3>
   10774:	07450593          	addi	a1,a0,116
   10778:	00050493          	mv	s1,a0
   1077c:	00040513          	mv	a0,s0
   10780:	7a8000ef          	jal	ra,10f28 <_malloc_r>
   10784:	00050413          	mv	s0,a0
   10788:	02050063          	beqz	a0,107a8 <__sfmoreglue+0x5c>
   1078c:	00052023          	sw	zero,0(a0)
   10790:	01252223          	sw	s2,4(a0)
   10794:	00c50513          	addi	a0,a0,12
   10798:	00a42423          	sw	a0,8(s0)
   1079c:	06848613          	addi	a2,s1,104
   107a0:	00000593          	li	a1,0
   107a4:	ba9ff0ef          	jal	ra,1034c <memset>
   107a8:	00040513          	mv	a0,s0
   107ac:	00c12083          	lw	ra,12(sp)
   107b0:	00812403          	lw	s0,8(sp)
   107b4:	00412483          	lw	s1,4(sp)
   107b8:	00012903          	lw	s2,0(sp)
   107bc:	01010113          	addi	sp,sp,16
   107c0:	00008067          	ret

000107c4 <_cleanup>:
   107c4:	000157b7          	lui	a5,0x15
   107c8:	99c7a503          	lw	a0,-1636(a5) # 1499c <_global_impure_ptr>
   107cc:	ee5ff06f          	j	106b0 <_cleanup_r>

000107d0 <__sinit>:
   107d0:	03852783          	lw	a5,56(a0)
   107d4:	06079e63          	bnez	a5,10850 <__sinit+0x80>
   107d8:	ff010113          	addi	sp,sp,-16
   107dc:	000107b7          	lui	a5,0x10
   107e0:	00112623          	sw	ra,12(sp)
   107e4:	00812423          	sw	s0,8(sp)
   107e8:	6b078793          	addi	a5,a5,1712 # 106b0 <_cleanup_r>
   107ec:	02f52e23          	sw	a5,60(a0)
   107f0:	00300793          	li	a5,3
   107f4:	2ef52223          	sw	a5,740(a0)
   107f8:	2ec50793          	addi	a5,a0,748
   107fc:	00050413          	mv	s0,a0
   10800:	2ef52423          	sw	a5,744(a0)
   10804:	2e052023          	sw	zero,736(a0)
   10808:	00452503          	lw	a0,4(a0)
   1080c:	00000613          	li	a2,0
   10810:	00400593          	li	a1,4
   10814:	ea9ff0ef          	jal	ra,106bc <std.isra.0>
   10818:	00842503          	lw	a0,8(s0)
   1081c:	00100613          	li	a2,1
   10820:	00900593          	li	a1,9
   10824:	e99ff0ef          	jal	ra,106bc <std.isra.0>
   10828:	00c42503          	lw	a0,12(s0)
   1082c:	00200613          	li	a2,2
   10830:	01200593          	li	a1,18
   10834:	e89ff0ef          	jal	ra,106bc <std.isra.0>
   10838:	00100793          	li	a5,1
   1083c:	02f42c23          	sw	a5,56(s0)
   10840:	00c12083          	lw	ra,12(sp)
   10844:	00812403          	lw	s0,8(sp)
   10848:	01010113          	addi	sp,sp,16
   1084c:	00008067          	ret
   10850:	00008067          	ret

00010854 <__sfp>:
   10854:	ff010113          	addi	sp,sp,-16
   10858:	000157b7          	lui	a5,0x15
   1085c:	00912223          	sw	s1,4(sp)
   10860:	99c7a483          	lw	s1,-1636(a5) # 1499c <_global_impure_ptr>
   10864:	01212023          	sw	s2,0(sp)
   10868:	00112623          	sw	ra,12(sp)
   1086c:	0384a783          	lw	a5,56(s1)
   10870:	00812423          	sw	s0,8(sp)
   10874:	00050913          	mv	s2,a0
   10878:	00079663          	bnez	a5,10884 <__sfp+0x30>
   1087c:	00048513          	mv	a0,s1
   10880:	f51ff0ef          	jal	ra,107d0 <__sinit>
   10884:	2e048493          	addi	s1,s1,736
   10888:	0084a403          	lw	s0,8(s1)
   1088c:	0044a783          	lw	a5,4(s1)
   10890:	fff78793          	addi	a5,a5,-1
   10894:	0007da63          	bgez	a5,108a8 <__sfp+0x54>
   10898:	0004a783          	lw	a5,0(s1)
   1089c:	00078e63          	beqz	a5,108b8 <__sfp+0x64>
   108a0:	0004a483          	lw	s1,0(s1)
   108a4:	fe5ff06f          	j	10888 <__sfp+0x34>
   108a8:	00c41703          	lh	a4,12(s0)
   108ac:	04070463          	beqz	a4,108f4 <__sfp+0xa0>
   108b0:	06840413          	addi	s0,s0,104
   108b4:	fddff06f          	j	10890 <__sfp+0x3c>
   108b8:	00400593          	li	a1,4
   108bc:	00090513          	mv	a0,s2
   108c0:	e8dff0ef          	jal	ra,1074c <__sfmoreglue>
   108c4:	00a4a023          	sw	a0,0(s1)
   108c8:	fc051ce3          	bnez	a0,108a0 <__sfp+0x4c>
   108cc:	00c00793          	li	a5,12
   108d0:	00f92023          	sw	a5,0(s2)
   108d4:	00000413          	li	s0,0
   108d8:	00040513          	mv	a0,s0
   108dc:	00c12083          	lw	ra,12(sp)
   108e0:	00812403          	lw	s0,8(sp)
   108e4:	00412483          	lw	s1,4(sp)
   108e8:	00012903          	lw	s2,0(sp)
   108ec:	01010113          	addi	sp,sp,16
   108f0:	00008067          	ret
   108f4:	ffff07b7          	lui	a5,0xffff0
   108f8:	00178793          	addi	a5,a5,1 # ffff0001 <__global_pointer$+0xfffdae69>
   108fc:	06042223          	sw	zero,100(s0)
   10900:	00042023          	sw	zero,0(s0)
   10904:	00042223          	sw	zero,4(s0)
   10908:	00042423          	sw	zero,8(s0)
   1090c:	00f42623          	sw	a5,12(s0)
   10910:	00042823          	sw	zero,16(s0)
   10914:	00042a23          	sw	zero,20(s0)
   10918:	00042c23          	sw	zero,24(s0)
   1091c:	00800613          	li	a2,8
   10920:	00000593          	li	a1,0
   10924:	05c40513          	addi	a0,s0,92
   10928:	a25ff0ef          	jal	ra,1034c <memset>
   1092c:	02042823          	sw	zero,48(s0)
   10930:	02042a23          	sw	zero,52(s0)
   10934:	04042223          	sw	zero,68(s0)
   10938:	04042423          	sw	zero,72(s0)
   1093c:	f9dff06f          	j	108d8 <__sfp+0x84>

00010940 <__sfp_lock_acquire>:
   10940:	00008067          	ret

00010944 <__sfp_lock_release>:
   10944:	00008067          	ret

00010948 <__sinit_lock_acquire>:
   10948:	00008067          	ret

0001094c <__sinit_lock_release>:
   1094c:	00008067          	ret

00010950 <__fp_lock_all>:
   10950:	8081a503          	lw	a0,-2040(gp) # 149a0 <_impure_ptr>
   10954:	000105b7          	lui	a1,0x10
   10958:	6a858593          	addi	a1,a1,1704 # 106a8 <__fp_lock>
   1095c:	4780006f          	j	10dd4 <_fwalk>

00010960 <__fp_unlock_all>:
   10960:	8081a503          	lw	a0,-2040(gp) # 149a0 <_impure_ptr>
   10964:	000105b7          	lui	a1,0x10
   10968:	74458593          	addi	a1,a1,1860 # 10744 <__fp_unlock>
   1096c:	4680006f          	j	10dd4 <_fwalk>

00010970 <__sfvwrite_r>:
   10970:	00862783          	lw	a5,8(a2)
   10974:	00079863          	bnez	a5,10984 <__sfvwrite_r+0x14>
   10978:	00000793          	li	a5,0
   1097c:	00078513          	mv	a0,a5
   10980:	00008067          	ret
   10984:	00c5d783          	lhu	a5,12(a1)
   10988:	fc010113          	addi	sp,sp,-64
   1098c:	02812c23          	sw	s0,56(sp)
   10990:	03212823          	sw	s2,48(sp)
   10994:	03612023          	sw	s6,32(sp)
   10998:	02112e23          	sw	ra,60(sp)
   1099c:	02912a23          	sw	s1,52(sp)
   109a0:	03312623          	sw	s3,44(sp)
   109a4:	03412423          	sw	s4,40(sp)
   109a8:	03512223          	sw	s5,36(sp)
   109ac:	01712e23          	sw	s7,28(sp)
   109b0:	01812c23          	sw	s8,24(sp)
   109b4:	01912a23          	sw	s9,20(sp)
   109b8:	01a12823          	sw	s10,16(sp)
   109bc:	01b12623          	sw	s11,12(sp)
   109c0:	0087f793          	andi	a5,a5,8
   109c4:	00060b13          	mv	s6,a2
   109c8:	00058413          	mv	s0,a1
   109cc:	00050913          	mv	s2,a0
   109d0:	0e078263          	beqz	a5,10ab4 <__sfvwrite_r+0x144>
   109d4:	0105a783          	lw	a5,16(a1)
   109d8:	0c078e63          	beqz	a5,10ab4 <__sfvwrite_r+0x144>
   109dc:	00c45783          	lhu	a5,12(s0)
   109e0:	000b2a03          	lw	s4,0(s6)
   109e4:	0027f713          	andi	a4,a5,2
   109e8:	16071a63          	bnez	a4,10b5c <__sfvwrite_r+0x1ec>
   109ec:	0017f793          	andi	a5,a5,1
   109f0:	00000b93          	li	s7,0
   109f4:	20078a63          	beqz	a5,10c08 <__sfvwrite_r+0x298>
   109f8:	00000513          	li	a0,0
   109fc:	00000a93          	li	s5,0
   10a00:	00000993          	li	s3,0
   10a04:	36098663          	beqz	s3,10d70 <__sfvwrite_r+0x400>
   10a08:	02051263          	bnez	a0,10a2c <__sfvwrite_r+0xbc>
   10a0c:	00098613          	mv	a2,s3
   10a10:	00a00593          	li	a1,10
   10a14:	000a8513          	mv	a0,s5
   10a18:	355000ef          	jal	ra,1156c <memchr>
   10a1c:	00198b93          	addi	s7,s3,1
   10a20:	00050663          	beqz	a0,10a2c <__sfvwrite_r+0xbc>
   10a24:	00150513          	addi	a0,a0,1
   10a28:	41550bb3          	sub	s7,a0,s5
   10a2c:	000b8c13          	mv	s8,s7
   10a30:	0179f463          	bleu	s7,s3,10a38 <__sfvwrite_r+0xc8>
   10a34:	00098c13          	mv	s8,s3
   10a38:	00042503          	lw	a0,0(s0)
   10a3c:	01042783          	lw	a5,16(s0)
   10a40:	01442683          	lw	a3,20(s0)
   10a44:	34a7f063          	bleu	a0,a5,10d84 <__sfvwrite_r+0x414>
   10a48:	00842483          	lw	s1,8(s0)
   10a4c:	009684b3          	add	s1,a3,s1
   10a50:	3384da63          	ble	s8,s1,10d84 <__sfvwrite_r+0x414>
   10a54:	000a8593          	mv	a1,s5
   10a58:	00048613          	mv	a2,s1
   10a5c:	41d000ef          	jal	ra,11678 <memmove>
   10a60:	00042783          	lw	a5,0(s0)
   10a64:	00040593          	mv	a1,s0
   10a68:	00090513          	mv	a0,s2
   10a6c:	009787b3          	add	a5,a5,s1
   10a70:	00f42023          	sw	a5,0(s0)
   10a74:	7f8010ef          	jal	ra,1226c <_fflush_r>
   10a78:	16051e63          	bnez	a0,10bf4 <__sfvwrite_r+0x284>
   10a7c:	409b8bb3          	sub	s7,s7,s1
   10a80:	00100513          	li	a0,1
   10a84:	000b9a63          	bnez	s7,10a98 <__sfvwrite_r+0x128>
   10a88:	00040593          	mv	a1,s0
   10a8c:	00090513          	mv	a0,s2
   10a90:	7dc010ef          	jal	ra,1226c <_fflush_r>
   10a94:	16051063          	bnez	a0,10bf4 <__sfvwrite_r+0x284>
   10a98:	008b2783          	lw	a5,8(s6)
   10a9c:	009a8ab3          	add	s5,s5,s1
   10aa0:	409989b3          	sub	s3,s3,s1
   10aa4:	409784b3          	sub	s1,a5,s1
   10aa8:	009b2423          	sw	s1,8(s6)
   10aac:	f4049ce3          	bnez	s1,10a04 <__sfvwrite_r+0x94>
   10ab0:	0680006f          	j	10b18 <__sfvwrite_r+0x1a8>
   10ab4:	00040593          	mv	a1,s0
   10ab8:	00090513          	mv	a0,s2
   10abc:	344010ef          	jal	ra,11e00 <__swsetup_r>
   10ac0:	fff00793          	li	a5,-1
   10ac4:	f0050ce3          	beqz	a0,109dc <__sfvwrite_r+0x6c>
   10ac8:	0540006f          	j	10b1c <__sfvwrite_r+0x1ac>
   10acc:	000a2983          	lw	s3,0(s4)
   10ad0:	004a2483          	lw	s1,4(s4)
   10ad4:	008a0a13          	addi	s4,s4,8
   10ad8:	fe048ae3          	beqz	s1,10acc <__sfvwrite_r+0x15c>
   10adc:	00048693          	mv	a3,s1
   10ae0:	009af463          	bleu	s1,s5,10ae8 <__sfvwrite_r+0x178>
   10ae4:	000a8693          	mv	a3,s5
   10ae8:	02442783          	lw	a5,36(s0)
   10aec:	01c42583          	lw	a1,28(s0)
   10af0:	00098613          	mv	a2,s3
   10af4:	00090513          	mv	a0,s2
   10af8:	000780e7          	jalr	a5
   10afc:	0ea05c63          	blez	a0,10bf4 <__sfvwrite_r+0x284>
   10b00:	008b2783          	lw	a5,8(s6)
   10b04:	00a989b3          	add	s3,s3,a0
   10b08:	40a484b3          	sub	s1,s1,a0
   10b0c:	40a78533          	sub	a0,a5,a0
   10b10:	00ab2423          	sw	a0,8(s6)
   10b14:	fc0512e3          	bnez	a0,10ad8 <__sfvwrite_r+0x168>
   10b18:	00000793          	li	a5,0
   10b1c:	03c12083          	lw	ra,60(sp)
   10b20:	03812403          	lw	s0,56(sp)
   10b24:	03412483          	lw	s1,52(sp)
   10b28:	03012903          	lw	s2,48(sp)
   10b2c:	02c12983          	lw	s3,44(sp)
   10b30:	02812a03          	lw	s4,40(sp)
   10b34:	02412a83          	lw	s5,36(sp)
   10b38:	02012b03          	lw	s6,32(sp)
   10b3c:	01c12b83          	lw	s7,28(sp)
   10b40:	01812c03          	lw	s8,24(sp)
   10b44:	01412c83          	lw	s9,20(sp)
   10b48:	01012d03          	lw	s10,16(sp)
   10b4c:	00c12d83          	lw	s11,12(sp)
   10b50:	00078513          	mv	a0,a5
   10b54:	04010113          	addi	sp,sp,64
   10b58:	00008067          	ret
   10b5c:	80000ab7          	lui	s5,0x80000
   10b60:	00000993          	li	s3,0
   10b64:	00000493          	li	s1,0
   10b68:	c00aca93          	xori	s5,s5,-1024
   10b6c:	f6dff06f          	j	10ad8 <__sfvwrite_r+0x168>
   10b70:	000a2b83          	lw	s7,0(s4)
   10b74:	004a2483          	lw	s1,4(s4)
   10b78:	008a0a13          	addi	s4,s4,8
   10b7c:	fe048ae3          	beqz	s1,10b70 <__sfvwrite_r+0x200>
   10b80:	00c45983          	lhu	s3,12(s0)
   10b84:	00842d83          	lw	s11,8(s0)
   10b88:	00042503          	lw	a0,0(s0)
   10b8c:	2009f793          	andi	a5,s3,512
   10b90:	14078463          	beqz	a5,10cd8 <__sfvwrite_r+0x368>
   10b94:	0db4e063          	bltu	s1,s11,10c54 <__sfvwrite_r+0x2e4>
   10b98:	4809f793          	andi	a5,s3,1152
   10b9c:	0a078c63          	beqz	a5,10c54 <__sfvwrite_r+0x2e4>
   10ba0:	01042d83          	lw	s11,16(s0)
   10ba4:	00300593          	li	a1,3
   10ba8:	41b50d33          	sub	s10,a0,s11
   10bac:	01442503          	lw	a0,20(s0)
   10bb0:	424020ef          	jal	ra,12fd4 <__mulsi3>
   10bb4:	01f55a93          	srli	s5,a0,0x1f
   10bb8:	00aa8ab3          	add	s5,s5,a0
   10bbc:	001d0793          	addi	a5,s10,1
   10bc0:	401ada93          	srai	s5,s5,0x1
   10bc4:	009787b3          	add	a5,a5,s1
   10bc8:	00faf463          	bleu	a5,s5,10bd0 <__sfvwrite_r+0x260>
   10bcc:	00078a93          	mv	s5,a5
   10bd0:	4009f993          	andi	s3,s3,1024
   10bd4:	0c098863          	beqz	s3,10ca4 <__sfvwrite_r+0x334>
   10bd8:	000a8593          	mv	a1,s5
   10bdc:	00090513          	mv	a0,s2
   10be0:	348000ef          	jal	ra,10f28 <_malloc_r>
   10be4:	00050993          	mv	s3,a0
   10be8:	02051a63          	bnez	a0,10c1c <__sfvwrite_r+0x2ac>
   10bec:	00c00793          	li	a5,12
   10bf0:	00f92023          	sw	a5,0(s2)
   10bf4:	00c45783          	lhu	a5,12(s0)
   10bf8:	0407e793          	ori	a5,a5,64
   10bfc:	00f41623          	sh	a5,12(s0)
   10c00:	fff00793          	li	a5,-1
   10c04:	f19ff06f          	j	10b1c <__sfvwrite_r+0x1ac>
   10c08:	80000c37          	lui	s8,0x80000
   10c0c:	ffec4c93          	xori	s9,s8,-2
   10c10:	00000493          	li	s1,0
   10c14:	fffc4c13          	not	s8,s8
   10c18:	f65ff06f          	j	10b7c <__sfvwrite_r+0x20c>
   10c1c:	01042583          	lw	a1,16(s0)
   10c20:	000d0613          	mv	a2,s10
   10c24:	16d000ef          	jal	ra,11590 <memcpy>
   10c28:	00c45783          	lhu	a5,12(s0)
   10c2c:	b7f7f793          	andi	a5,a5,-1153
   10c30:	0807e793          	ori	a5,a5,128
   10c34:	00f41623          	sh	a5,12(s0)
   10c38:	01342823          	sw	s3,16(s0)
   10c3c:	01542a23          	sw	s5,20(s0)
   10c40:	01a989b3          	add	s3,s3,s10
   10c44:	41aa8ab3          	sub	s5,s5,s10
   10c48:	01342023          	sw	s3,0(s0)
   10c4c:	00048d93          	mv	s11,s1
   10c50:	01542423          	sw	s5,8(s0)
   10c54:	00048993          	mv	s3,s1
   10c58:	01b4f463          	bleu	s11,s1,10c60 <__sfvwrite_r+0x2f0>
   10c5c:	00048d93          	mv	s11,s1
   10c60:	00042503          	lw	a0,0(s0)
   10c64:	000d8613          	mv	a2,s11
   10c68:	000b8593          	mv	a1,s7
   10c6c:	20d000ef          	jal	ra,11678 <memmove>
   10c70:	00842783          	lw	a5,8(s0)
   10c74:	41b787b3          	sub	a5,a5,s11
   10c78:	00f42423          	sw	a5,8(s0)
   10c7c:	00042783          	lw	a5,0(s0)
   10c80:	01b78db3          	add	s11,a5,s11
   10c84:	01b42023          	sw	s11,0(s0)
   10c88:	008b2783          	lw	a5,8(s6)
   10c8c:	013b8bb3          	add	s7,s7,s3
   10c90:	413484b3          	sub	s1,s1,s3
   10c94:	413789b3          	sub	s3,a5,s3
   10c98:	013b2423          	sw	s3,8(s6)
   10c9c:	ee0990e3          	bnez	s3,10b7c <__sfvwrite_r+0x20c>
   10ca0:	e79ff06f          	j	10b18 <__sfvwrite_r+0x1a8>
   10ca4:	000a8613          	mv	a2,s5
   10ca8:	000d8593          	mv	a1,s11
   10cac:	00090513          	mv	a0,s2
   10cb0:	225000ef          	jal	ra,116d4 <_realloc_r>
   10cb4:	00050993          	mv	s3,a0
   10cb8:	f80510e3          	bnez	a0,10c38 <__sfvwrite_r+0x2c8>
   10cbc:	01042583          	lw	a1,16(s0)
   10cc0:	00090513          	mv	a0,s2
   10cc4:	734010ef          	jal	ra,123f8 <_free_r>
   10cc8:	00c45783          	lhu	a5,12(s0)
   10ccc:	f7f7f793          	andi	a5,a5,-129
   10cd0:	00f41623          	sh	a5,12(s0)
   10cd4:	f19ff06f          	j	10bec <__sfvwrite_r+0x27c>
   10cd8:	01042783          	lw	a5,16(s0)
   10cdc:	00a7e663          	bltu	a5,a0,10ce8 <__sfvwrite_r+0x378>
   10ce0:	01442983          	lw	s3,20(s0)
   10ce4:	0534f663          	bleu	s3,s1,10d30 <__sfvwrite_r+0x3c0>
   10ce8:	000d8993          	mv	s3,s11
   10cec:	01b4f463          	bleu	s11,s1,10cf4 <__sfvwrite_r+0x384>
   10cf0:	00048993          	mv	s3,s1
   10cf4:	00098613          	mv	a2,s3
   10cf8:	000b8593          	mv	a1,s7
   10cfc:	17d000ef          	jal	ra,11678 <memmove>
   10d00:	00842783          	lw	a5,8(s0)
   10d04:	00042703          	lw	a4,0(s0)
   10d08:	413787b3          	sub	a5,a5,s3
   10d0c:	01370733          	add	a4,a4,s3
   10d10:	00f42423          	sw	a5,8(s0)
   10d14:	00e42023          	sw	a4,0(s0)
   10d18:	f60798e3          	bnez	a5,10c88 <__sfvwrite_r+0x318>
   10d1c:	00040593          	mv	a1,s0
   10d20:	00090513          	mv	a0,s2
   10d24:	548010ef          	jal	ra,1226c <_fflush_r>
   10d28:	f60500e3          	beqz	a0,10c88 <__sfvwrite_r+0x318>
   10d2c:	ec9ff06f          	j	10bf4 <__sfvwrite_r+0x284>
   10d30:	000c0513          	mv	a0,s8
   10d34:	009ce463          	bltu	s9,s1,10d3c <__sfvwrite_r+0x3cc>
   10d38:	00048513          	mv	a0,s1
   10d3c:	00098593          	mv	a1,s3
   10d40:	2b8020ef          	jal	ra,12ff8 <__divsi3>
   10d44:	00098593          	mv	a1,s3
   10d48:	28c020ef          	jal	ra,12fd4 <__mulsi3>
   10d4c:	02442783          	lw	a5,36(s0)
   10d50:	01c42583          	lw	a1,28(s0)
   10d54:	00050693          	mv	a3,a0
   10d58:	000b8613          	mv	a2,s7
   10d5c:	00090513          	mv	a0,s2
   10d60:	000780e7          	jalr	a5
   10d64:	00050993          	mv	s3,a0
   10d68:	f2a040e3          	bgtz	a0,10c88 <__sfvwrite_r+0x318>
   10d6c:	e89ff06f          	j	10bf4 <__sfvwrite_r+0x284>
   10d70:	000a2a83          	lw	s5,0(s4)
   10d74:	004a2983          	lw	s3,4(s4)
   10d78:	00000513          	li	a0,0
   10d7c:	008a0a13          	addi	s4,s4,8
   10d80:	c85ff06f          	j	10a04 <__sfvwrite_r+0x94>
   10d84:	02dc4263          	blt	s8,a3,10da8 <__sfvwrite_r+0x438>
   10d88:	02442783          	lw	a5,36(s0)
   10d8c:	01c42583          	lw	a1,28(s0)
   10d90:	000a8613          	mv	a2,s5
   10d94:	00090513          	mv	a0,s2
   10d98:	000780e7          	jalr	a5
   10d9c:	00050493          	mv	s1,a0
   10da0:	cca04ee3          	bgtz	a0,10a7c <__sfvwrite_r+0x10c>
   10da4:	e51ff06f          	j	10bf4 <__sfvwrite_r+0x284>
   10da8:	000c0613          	mv	a2,s8
   10dac:	000a8593          	mv	a1,s5
   10db0:	0c9000ef          	jal	ra,11678 <memmove>
   10db4:	00842783          	lw	a5,8(s0)
   10db8:	000c0493          	mv	s1,s8
   10dbc:	418787b3          	sub	a5,a5,s8
   10dc0:	00f42423          	sw	a5,8(s0)
   10dc4:	00042783          	lw	a5,0(s0)
   10dc8:	018787b3          	add	a5,a5,s8
   10dcc:	00f42023          	sw	a5,0(s0)
   10dd0:	cadff06f          	j	10a7c <__sfvwrite_r+0x10c>

00010dd4 <_fwalk>:
   10dd4:	fd010113          	addi	sp,sp,-48
   10dd8:	02812423          	sw	s0,40(sp)
   10ddc:	03212023          	sw	s2,32(sp)
   10de0:	01412c23          	sw	s4,24(sp)
   10de4:	01512a23          	sw	s5,20(sp)
   10de8:	02112623          	sw	ra,44(sp)
   10dec:	02912223          	sw	s1,36(sp)
   10df0:	01312e23          	sw	s3,28(sp)
   10df4:	2e050413          	addi	s0,a0,736
   10df8:	00000913          	li	s2,0
   10dfc:	00100a13          	li	s4,1
   10e00:	fff00a93          	li	s5,-1
   10e04:	02041663          	bnez	s0,10e30 <_fwalk+0x5c>
   10e08:	02c12083          	lw	ra,44(sp)
   10e0c:	02812403          	lw	s0,40(sp)
   10e10:	00090513          	mv	a0,s2
   10e14:	02412483          	lw	s1,36(sp)
   10e18:	02012903          	lw	s2,32(sp)
   10e1c:	01c12983          	lw	s3,28(sp)
   10e20:	01812a03          	lw	s4,24(sp)
   10e24:	01412a83          	lw	s5,20(sp)
   10e28:	03010113          	addi	sp,sp,48
   10e2c:	00008067          	ret
   10e30:	00842483          	lw	s1,8(s0)
   10e34:	00442983          	lw	s3,4(s0)
   10e38:	fff98993          	addi	s3,s3,-1
   10e3c:	0009d663          	bgez	s3,10e48 <_fwalk+0x74>
   10e40:	00042403          	lw	s0,0(s0)
   10e44:	fc1ff06f          	j	10e04 <_fwalk+0x30>
   10e48:	00c4d783          	lhu	a5,12(s1)
   10e4c:	02fa7063          	bleu	a5,s4,10e6c <_fwalk+0x98>
   10e50:	00e49783          	lh	a5,14(s1)
   10e54:	01578c63          	beq	a5,s5,10e6c <_fwalk+0x98>
   10e58:	00048513          	mv	a0,s1
   10e5c:	00b12623          	sw	a1,12(sp)
   10e60:	000580e7          	jalr	a1
   10e64:	00c12583          	lw	a1,12(sp)
   10e68:	00a96933          	or	s2,s2,a0
   10e6c:	06848493          	addi	s1,s1,104
   10e70:	fc9ff06f          	j	10e38 <_fwalk+0x64>

00010e74 <_fwalk_reent>:
   10e74:	fd010113          	addi	sp,sp,-48
   10e78:	02812423          	sw	s0,40(sp)
   10e7c:	03212023          	sw	s2,32(sp)
   10e80:	01412c23          	sw	s4,24(sp)
   10e84:	01512a23          	sw	s5,20(sp)
   10e88:	01612823          	sw	s6,16(sp)
   10e8c:	01712623          	sw	s7,12(sp)
   10e90:	02112623          	sw	ra,44(sp)
   10e94:	02912223          	sw	s1,36(sp)
   10e98:	01312e23          	sw	s3,28(sp)
   10e9c:	00050a13          	mv	s4,a0
   10ea0:	00058a93          	mv	s5,a1
   10ea4:	2e050413          	addi	s0,a0,736
   10ea8:	00000913          	li	s2,0
   10eac:	00100b13          	li	s6,1
   10eb0:	fff00b93          	li	s7,-1
   10eb4:	02041a63          	bnez	s0,10ee8 <_fwalk_reent+0x74>
   10eb8:	02c12083          	lw	ra,44(sp)
   10ebc:	02812403          	lw	s0,40(sp)
   10ec0:	00090513          	mv	a0,s2
   10ec4:	02412483          	lw	s1,36(sp)
   10ec8:	02012903          	lw	s2,32(sp)
   10ecc:	01c12983          	lw	s3,28(sp)
   10ed0:	01812a03          	lw	s4,24(sp)
   10ed4:	01412a83          	lw	s5,20(sp)
   10ed8:	01012b03          	lw	s6,16(sp)
   10edc:	00c12b83          	lw	s7,12(sp)
   10ee0:	03010113          	addi	sp,sp,48
   10ee4:	00008067          	ret
   10ee8:	00842483          	lw	s1,8(s0)
   10eec:	00442983          	lw	s3,4(s0)
   10ef0:	fff98993          	addi	s3,s3,-1
   10ef4:	0009d663          	bgez	s3,10f00 <_fwalk_reent+0x8c>
   10ef8:	00042403          	lw	s0,0(s0)
   10efc:	fb9ff06f          	j	10eb4 <_fwalk_reent+0x40>
   10f00:	00c4d783          	lhu	a5,12(s1)
   10f04:	00fb7e63          	bleu	a5,s6,10f20 <_fwalk_reent+0xac>
   10f08:	00e49783          	lh	a5,14(s1)
   10f0c:	01778a63          	beq	a5,s7,10f20 <_fwalk_reent+0xac>
   10f10:	00048593          	mv	a1,s1
   10f14:	000a0513          	mv	a0,s4
   10f18:	000a80e7          	jalr	s5
   10f1c:	00a96933          	or	s2,s2,a0
   10f20:	06848493          	addi	s1,s1,104
   10f24:	fcdff06f          	j	10ef0 <_fwalk_reent+0x7c>

00010f28 <_malloc_r>:
   10f28:	fd010113          	addi	sp,sp,-48
   10f2c:	02112623          	sw	ra,44(sp)
   10f30:	02812423          	sw	s0,40(sp)
   10f34:	02912223          	sw	s1,36(sp)
   10f38:	03212023          	sw	s2,32(sp)
   10f3c:	01312e23          	sw	s3,28(sp)
   10f40:	01412c23          	sw	s4,24(sp)
   10f44:	01512a23          	sw	s5,20(sp)
   10f48:	01612823          	sw	s6,16(sp)
   10f4c:	01712623          	sw	s7,12(sp)
   10f50:	01812423          	sw	s8,8(sp)
   10f54:	00b58793          	addi	a5,a1,11
   10f58:	01600713          	li	a4,22
   10f5c:	04f77463          	bleu	a5,a4,10fa4 <_malloc_r+0x7c>
   10f60:	ff87f493          	andi	s1,a5,-8
   10f64:	0404d263          	bgez	s1,10fa8 <_malloc_r+0x80>
   10f68:	00c00793          	li	a5,12
   10f6c:	00f52023          	sw	a5,0(a0)
   10f70:	00000513          	li	a0,0
   10f74:	02c12083          	lw	ra,44(sp)
   10f78:	02812403          	lw	s0,40(sp)
   10f7c:	02412483          	lw	s1,36(sp)
   10f80:	02012903          	lw	s2,32(sp)
   10f84:	01c12983          	lw	s3,28(sp)
   10f88:	01812a03          	lw	s4,24(sp)
   10f8c:	01412a83          	lw	s5,20(sp)
   10f90:	01012b03          	lw	s6,16(sp)
   10f94:	00c12b83          	lw	s7,12(sp)
   10f98:	00812c03          	lw	s8,8(sp)
   10f9c:	03010113          	addi	sp,sp,48
   10fa0:	00008067          	ret
   10fa4:	01000493          	li	s1,16
   10fa8:	fcb4e0e3          	bltu	s1,a1,10f68 <_malloc_r+0x40>
   10fac:	00050993          	mv	s3,a0
   10fb0:	71c000ef          	jal	ra,116cc <__malloc_lock>
   10fb4:	00014937          	lui	s2,0x14
   10fb8:	1f700793          	li	a5,503
   10fbc:	59090913          	addi	s2,s2,1424 # 14590 <__malloc_av_>
   10fc0:	0497ea63          	bltu	a5,s1,11014 <_malloc_r+0xec>
   10fc4:	00848713          	addi	a4,s1,8
   10fc8:	00e90733          	add	a4,s2,a4
   10fcc:	00472403          	lw	s0,4(a4)
   10fd0:	ff870693          	addi	a3,a4,-8
   10fd4:	0034d793          	srli	a5,s1,0x3
   10fd8:	00d41863          	bne	s0,a3,10fe8 <_malloc_r+0xc0>
   10fdc:	00c72403          	lw	s0,12(a4)
   10fe0:	00278793          	addi	a5,a5,2
   10fe4:	08870063          	beq	a4,s0,11064 <_malloc_r+0x13c>
   10fe8:	00442783          	lw	a5,4(s0)
   10fec:	00c42703          	lw	a4,12(s0)
   10ff0:	00842683          	lw	a3,8(s0)
   10ff4:	ffc7f793          	andi	a5,a5,-4
   10ff8:	00f407b3          	add	a5,s0,a5
   10ffc:	00e6a623          	sw	a4,12(a3) # 200c <main-0xe068>
   11000:	00d72423          	sw	a3,8(a4)
   11004:	0047a703          	lw	a4,4(a5)
   11008:	00176713          	ori	a4,a4,1
   1100c:	00e7a223          	sw	a4,4(a5)
   11010:	0a80006f          	j	110b8 <_malloc_r+0x190>
   11014:	0094d713          	srli	a4,s1,0x9
   11018:	03f00793          	li	a5,63
   1101c:	00070a63          	beqz	a4,11030 <_malloc_r+0x108>
   11020:	00400793          	li	a5,4
   11024:	0ae7e263          	bltu	a5,a4,110c8 <_malloc_r+0x1a0>
   11028:	0064d793          	srli	a5,s1,0x6
   1102c:	03878793          	addi	a5,a5,56
   11030:	00178713          	addi	a4,a5,1
   11034:	00371713          	slli	a4,a4,0x3
   11038:	00e90733          	add	a4,s2,a4
   1103c:	00472403          	lw	s0,4(a4)
   11040:	ff870593          	addi	a1,a4,-8
   11044:	00f00513          	li	a0,15
   11048:	00b40c63          	beq	s0,a1,11060 <_malloc_r+0x138>
   1104c:	00442703          	lw	a4,4(s0)
   11050:	ffc77713          	andi	a4,a4,-4
   11054:	40970633          	sub	a2,a4,s1
   11058:	0cc55063          	ble	a2,a0,11118 <_malloc_r+0x1f0>
   1105c:	fff78793          	addi	a5,a5,-1
   11060:	00178793          	addi	a5,a5,1
   11064:	01092403          	lw	s0,16(s2)
   11068:	000145b7          	lui	a1,0x14
   1106c:	00890693          	addi	a3,s2,8
   11070:	59858593          	addi	a1,a1,1432 # 14598 <__malloc_av_+0x8>
   11074:	12d40863          	beq	s0,a3,111a4 <_malloc_r+0x27c>
   11078:	00442703          	lw	a4,4(s0)
   1107c:	00f00613          	li	a2,15
   11080:	ffc77713          	andi	a4,a4,-4
   11084:	40970533          	sub	a0,a4,s1
   11088:	0aa65a63          	ble	a0,a2,1113c <_malloc_r+0x214>
   1108c:	0014e793          	ori	a5,s1,1
   11090:	00f42223          	sw	a5,4(s0)
   11094:	00940633          	add	a2,s0,s1
   11098:	00c92a23          	sw	a2,20(s2)
   1109c:	00c92823          	sw	a2,16(s2)
   110a0:	00156793          	ori	a5,a0,1
   110a4:	00d62623          	sw	a3,12(a2)
   110a8:	00d62423          	sw	a3,8(a2)
   110ac:	00f62223          	sw	a5,4(a2)
   110b0:	00e40733          	add	a4,s0,a4
   110b4:	00a72023          	sw	a0,0(a4)
   110b8:	00098513          	mv	a0,s3
   110bc:	614000ef          	jal	ra,116d0 <__malloc_unlock>
   110c0:	00840513          	addi	a0,s0,8
   110c4:	eb1ff06f          	j	10f74 <_malloc_r+0x4c>
   110c8:	01400793          	li	a5,20
   110cc:	00e7e663          	bltu	a5,a4,110d8 <_malloc_r+0x1b0>
   110d0:	05b70793          	addi	a5,a4,91
   110d4:	f5dff06f          	j	11030 <_malloc_r+0x108>
   110d8:	05400793          	li	a5,84
   110dc:	00e7e863          	bltu	a5,a4,110ec <_malloc_r+0x1c4>
   110e0:	00c4d793          	srli	a5,s1,0xc
   110e4:	06e78793          	addi	a5,a5,110
   110e8:	f49ff06f          	j	11030 <_malloc_r+0x108>
   110ec:	15400793          	li	a5,340
   110f0:	00e7e863          	bltu	a5,a4,11100 <_malloc_r+0x1d8>
   110f4:	00f4d793          	srli	a5,s1,0xf
   110f8:	07778793          	addi	a5,a5,119
   110fc:	f35ff06f          	j	11030 <_malloc_r+0x108>
   11100:	55400693          	li	a3,1364
   11104:	07e00793          	li	a5,126
   11108:	f2e6e4e3          	bltu	a3,a4,11030 <_malloc_r+0x108>
   1110c:	0124d793          	srli	a5,s1,0x12
   11110:	07c78793          	addi	a5,a5,124
   11114:	f1dff06f          	j	11030 <_malloc_r+0x108>
   11118:	00c42683          	lw	a3,12(s0)
   1111c:	00064c63          	bltz	a2,11134 <_malloc_r+0x20c>
   11120:	00842783          	lw	a5,8(s0)
   11124:	00d7a623          	sw	a3,12(a5)
   11128:	00f6a423          	sw	a5,8(a3)
   1112c:	00e407b3          	add	a5,s0,a4
   11130:	ed5ff06f          	j	11004 <_malloc_r+0xdc>
   11134:	00068413          	mv	s0,a3
   11138:	f11ff06f          	j	11048 <_malloc_r+0x120>
   1113c:	00d92a23          	sw	a3,20(s2)
   11140:	00d92823          	sw	a3,16(s2)
   11144:	00054c63          	bltz	a0,1115c <_malloc_r+0x234>
   11148:	00e40733          	add	a4,s0,a4
   1114c:	00472783          	lw	a5,4(a4)
   11150:	0017e793          	ori	a5,a5,1
   11154:	00f72223          	sw	a5,4(a4)
   11158:	f61ff06f          	j	110b8 <_malloc_r+0x190>
   1115c:	1ff00693          	li	a3,511
   11160:	00492803          	lw	a6,4(s2)
   11164:	16e6e663          	bltu	a3,a4,112d0 <_malloc_r+0x3a8>
   11168:	00375713          	srli	a4,a4,0x3
   1116c:	40275613          	srai	a2,a4,0x2
   11170:	00100693          	li	a3,1
   11174:	00170713          	addi	a4,a4,1
   11178:	00c696b3          	sll	a3,a3,a2
   1117c:	00371713          	slli	a4,a4,0x3
   11180:	00e90733          	add	a4,s2,a4
   11184:	0106e6b3          	or	a3,a3,a6
   11188:	00d92223          	sw	a3,4(s2)
   1118c:	00072683          	lw	a3,0(a4)
   11190:	ff870613          	addi	a2,a4,-8
   11194:	00c42623          	sw	a2,12(s0)
   11198:	00d42423          	sw	a3,8(s0)
   1119c:	00872023          	sw	s0,0(a4)
   111a0:	0086a623          	sw	s0,12(a3)
   111a4:	4027d713          	srai	a4,a5,0x2
   111a8:	00100313          	li	t1,1
   111ac:	00e31333          	sll	t1,t1,a4
   111b0:	00492703          	lw	a4,4(s2)
   111b4:	06676a63          	bltu	a4,t1,11228 <_malloc_r+0x300>
   111b8:	006776b3          	and	a3,a4,t1
   111bc:	00069c63          	bnez	a3,111d4 <_malloc_r+0x2ac>
   111c0:	ffc7f793          	andi	a5,a5,-4
   111c4:	00131313          	slli	t1,t1,0x1
   111c8:	006776b3          	and	a3,a4,t1
   111cc:	00478793          	addi	a5,a5,4
   111d0:	fe068ae3          	beqz	a3,111c4 <_malloc_r+0x29c>
   111d4:	00f00e13          	li	t3,15
   111d8:	00379693          	slli	a3,a5,0x3
   111dc:	00d906b3          	add	a3,s2,a3
   111e0:	00068813          	mv	a6,a3
   111e4:	00078513          	mv	a0,a5
   111e8:	00c82403          	lw	s0,12(a6)
   111ec:	1b041263          	bne	s0,a6,11390 <_malloc_r+0x468>
   111f0:	00150513          	addi	a0,a0,1
   111f4:	00357713          	andi	a4,a0,3
   111f8:	00880813          	addi	a6,a6,8
   111fc:	fe0716e3          	bnez	a4,111e8 <_malloc_r+0x2c0>
   11200:	0037f713          	andi	a4,a5,3
   11204:	20071463          	bnez	a4,1140c <_malloc_r+0x4e4>
   11208:	00492703          	lw	a4,4(s2)
   1120c:	fff34793          	not	a5,t1
   11210:	00f777b3          	and	a5,a4,a5
   11214:	00f92223          	sw	a5,4(s2)
   11218:	00492703          	lw	a4,4(s2)
   1121c:	00131313          	slli	t1,t1,0x1
   11220:	00676463          	bltu	a4,t1,11228 <_malloc_r+0x300>
   11224:	20031863          	bnez	t1,11434 <_malloc_r+0x50c>
   11228:	00892b83          	lw	s7,8(s2)
   1122c:	004ba403          	lw	s0,4(s7)
   11230:	ffc47a93          	andi	s5,s0,-4
   11234:	009ae863          	bltu	s5,s1,11244 <_malloc_r+0x31c>
   11238:	409a8733          	sub	a4,s5,s1
   1123c:	00f00793          	li	a5,15
   11240:	30e7ca63          	blt	a5,a4,11554 <_malloc_r+0x62c>
   11244:	81c1a403          	lw	s0,-2020(gp) # 149b4 <__malloc_top_pad>
   11248:	80c1a703          	lw	a4,-2036(gp) # 149a4 <__malloc_sbrk_base>
   1124c:	fff00793          	li	a5,-1
   11250:	00848433          	add	s0,s1,s0
   11254:	1ef71463          	bne	a4,a5,1143c <_malloc_r+0x514>
   11258:	01040413          	addi	s0,s0,16
   1125c:	00040593          	mv	a1,s0
   11260:	00098513          	mv	a0,s3
   11264:	1c9000ef          	jal	ra,11c2c <_sbrk_r>
   11268:	fff00793          	li	a5,-1
   1126c:	00050b13          	mv	s6,a0
   11270:	26f50863          	beq	a0,a5,114e0 <_malloc_r+0x5b8>
   11274:	015b87b3          	add	a5,s7,s5
   11278:	00f57463          	bleu	a5,a0,11280 <_malloc_r+0x358>
   1127c:	272b9263          	bne	s7,s2,114e0 <_malloc_r+0x5b8>
   11280:	84818693          	addi	a3,gp,-1976 # 149e0 <__malloc_current_mallinfo>
   11284:	0006a703          	lw	a4,0(a3)
   11288:	84818c13          	addi	s8,gp,-1976 # 149e0 <__malloc_current_mallinfo>
   1128c:	00e40733          	add	a4,s0,a4
   11290:	00e6a023          	sw	a4,0(a3)
   11294:	1d679063          	bne	a5,s6,11454 <_malloc_r+0x52c>
   11298:	01479693          	slli	a3,a5,0x14
   1129c:	1a069c63          	bnez	a3,11454 <_malloc_r+0x52c>
   112a0:	00892783          	lw	a5,8(s2)
   112a4:	008a8433          	add	s0,s5,s0
   112a8:	00146413          	ori	s0,s0,1
   112ac:	0087a223          	sw	s0,4(a5)
   112b0:	000c2783          	lw	a5,0(s8) # 80000000 <__global_pointer$+0x7ffeae68>
   112b4:	8181a683          	lw	a3,-2024(gp) # 149b0 <__malloc_max_sbrked_mem>
   112b8:	00f6f463          	bleu	a5,a3,112c0 <_malloc_r+0x398>
   112bc:	80f1ac23          	sw	a5,-2024(gp) # 149b0 <__malloc_max_sbrked_mem>
   112c0:	8141a683          	lw	a3,-2028(gp) # 149ac <_edata>
   112c4:	20f6fe63          	bleu	a5,a3,114e0 <_malloc_r+0x5b8>
   112c8:	80f1aa23          	sw	a5,-2028(gp) # 149ac <_edata>
   112cc:	2140006f          	j	114e0 <_malloc_r+0x5b8>
   112d0:	00975613          	srli	a2,a4,0x9
   112d4:	00400693          	li	a3,4
   112d8:	04c6e663          	bltu	a3,a2,11324 <_malloc_r+0x3fc>
   112dc:	00675693          	srli	a3,a4,0x6
   112e0:	03868693          	addi	a3,a3,56
   112e4:	00168613          	addi	a2,a3,1
   112e8:	00361613          	slli	a2,a2,0x3
   112ec:	00c90633          	add	a2,s2,a2
   112f0:	ff860513          	addi	a0,a2,-8
   112f4:	00062603          	lw	a2,0(a2)
   112f8:	08c51263          	bne	a0,a2,1137c <_malloc_r+0x454>
   112fc:	4026d693          	srai	a3,a3,0x2
   11300:	00100713          	li	a4,1
   11304:	00d716b3          	sll	a3,a4,a3
   11308:	0106e6b3          	or	a3,a3,a6
   1130c:	00d92223          	sw	a3,4(s2)
   11310:	00a42623          	sw	a0,12(s0)
   11314:	00c42423          	sw	a2,8(s0)
   11318:	00852423          	sw	s0,8(a0)
   1131c:	00862623          	sw	s0,12(a2)
   11320:	e85ff06f          	j	111a4 <_malloc_r+0x27c>
   11324:	01400693          	li	a3,20
   11328:	00c6e663          	bltu	a3,a2,11334 <_malloc_r+0x40c>
   1132c:	05b60693          	addi	a3,a2,91
   11330:	fb5ff06f          	j	112e4 <_malloc_r+0x3bc>
   11334:	05400693          	li	a3,84
   11338:	00c6e863          	bltu	a3,a2,11348 <_malloc_r+0x420>
   1133c:	00c75693          	srli	a3,a4,0xc
   11340:	06e68693          	addi	a3,a3,110
   11344:	fa1ff06f          	j	112e4 <_malloc_r+0x3bc>
   11348:	15400693          	li	a3,340
   1134c:	00c6e863          	bltu	a3,a2,1135c <_malloc_r+0x434>
   11350:	00f75693          	srli	a3,a4,0xf
   11354:	07768693          	addi	a3,a3,119
   11358:	f8dff06f          	j	112e4 <_malloc_r+0x3bc>
   1135c:	55400513          	li	a0,1364
   11360:	07e00693          	li	a3,126
   11364:	f8c560e3          	bltu	a0,a2,112e4 <_malloc_r+0x3bc>
   11368:	01275693          	srli	a3,a4,0x12
   1136c:	07c68693          	addi	a3,a3,124
   11370:	f75ff06f          	j	112e4 <_malloc_r+0x3bc>
   11374:	00862603          	lw	a2,8(a2)
   11378:	00c50863          	beq	a0,a2,11388 <_malloc_r+0x460>
   1137c:	00462683          	lw	a3,4(a2)
   11380:	ffc6f693          	andi	a3,a3,-4
   11384:	fed768e3          	bltu	a4,a3,11374 <_malloc_r+0x44c>
   11388:	00c62503          	lw	a0,12(a2)
   1138c:	f85ff06f          	j	11310 <_malloc_r+0x3e8>
   11390:	00442703          	lw	a4,4(s0)
   11394:	00c42603          	lw	a2,12(s0)
   11398:	ffc77713          	andi	a4,a4,-4
   1139c:	409708b3          	sub	a7,a4,s1
   113a0:	051e5063          	ble	a7,t3,113e0 <_malloc_r+0x4b8>
   113a4:	0014e793          	ori	a5,s1,1
   113a8:	00f42223          	sw	a5,4(s0)
   113ac:	00842783          	lw	a5,8(s0)
   113b0:	009406b3          	add	a3,s0,s1
   113b4:	00e40733          	add	a4,s0,a4
   113b8:	00c7a623          	sw	a2,12(a5)
   113bc:	00f62423          	sw	a5,8(a2)
   113c0:	00d92a23          	sw	a3,20(s2)
   113c4:	00d92823          	sw	a3,16(s2)
   113c8:	0018e793          	ori	a5,a7,1
   113cc:	00b6a623          	sw	a1,12(a3)
   113d0:	00b6a423          	sw	a1,8(a3)
   113d4:	00f6a223          	sw	a5,4(a3)
   113d8:	01172023          	sw	a7,0(a4)
   113dc:	cddff06f          	j	110b8 <_malloc_r+0x190>
   113e0:	0208c263          	bltz	a7,11404 <_malloc_r+0x4dc>
   113e4:	00e40733          	add	a4,s0,a4
   113e8:	00472783          	lw	a5,4(a4)
   113ec:	0017e793          	ori	a5,a5,1
   113f0:	00f72223          	sw	a5,4(a4)
   113f4:	00842783          	lw	a5,8(s0)
   113f8:	00c7a623          	sw	a2,12(a5)
   113fc:	00f62423          	sw	a5,8(a2)
   11400:	cb9ff06f          	j	110b8 <_malloc_r+0x190>
   11404:	00060413          	mv	s0,a2
   11408:	de5ff06f          	j	111ec <_malloc_r+0x2c4>
   1140c:	ff868713          	addi	a4,a3,-8
   11410:	0006a683          	lw	a3,0(a3)
   11414:	fff78793          	addi	a5,a5,-1
   11418:	dee684e3          	beq	a3,a4,11200 <_malloc_r+0x2d8>
   1141c:	dfdff06f          	j	11218 <_malloc_r+0x2f0>
   11420:	00478793          	addi	a5,a5,4
   11424:	00131313          	slli	t1,t1,0x1
   11428:	006776b3          	and	a3,a4,t1
   1142c:	fe068ae3          	beqz	a3,11420 <_malloc_r+0x4f8>
   11430:	da9ff06f          	j	111d8 <_malloc_r+0x2b0>
   11434:	00050793          	mv	a5,a0
   11438:	ff1ff06f          	j	11428 <_malloc_r+0x500>
   1143c:	000017b7          	lui	a5,0x1
   11440:	00f78793          	addi	a5,a5,15 # 100f <main-0xf065>
   11444:	00f40433          	add	s0,s0,a5
   11448:	fffff7b7          	lui	a5,0xfffff
   1144c:	00f47433          	and	s0,s0,a5
   11450:	e0dff06f          	j	1125c <_malloc_r+0x334>
   11454:	80c1a603          	lw	a2,-2036(gp) # 149a4 <__malloc_sbrk_base>
   11458:	fff00693          	li	a3,-1
   1145c:	0ad61663          	bne	a2,a3,11508 <_malloc_r+0x5e0>
   11460:	8161a623          	sw	s6,-2036(gp) # 149a4 <__malloc_sbrk_base>
   11464:	007b7593          	andi	a1,s6,7
   11468:	00058863          	beqz	a1,11478 <_malloc_r+0x550>
   1146c:	00800793          	li	a5,8
   11470:	40b785b3          	sub	a1,a5,a1
   11474:	00bb0b33          	add	s6,s6,a1
   11478:	000017b7          	lui	a5,0x1
   1147c:	00f585b3          	add	a1,a1,a5
   11480:	008b0433          	add	s0,s6,s0
   11484:	fff78793          	addi	a5,a5,-1 # fff <main-0xf075>
   11488:	00f47433          	and	s0,s0,a5
   1148c:	40858a33          	sub	s4,a1,s0
   11490:	000a0593          	mv	a1,s4
   11494:	00098513          	mv	a0,s3
   11498:	794000ef          	jal	ra,11c2c <_sbrk_r>
   1149c:	fff00793          	li	a5,-1
   114a0:	00f51663          	bne	a0,a5,114ac <_malloc_r+0x584>
   114a4:	000b0513          	mv	a0,s6
   114a8:	00000a13          	li	s4,0
   114ac:	000c2783          	lw	a5,0(s8)
   114b0:	41650533          	sub	a0,a0,s6
   114b4:	01692423          	sw	s6,8(s2)
   114b8:	014787b3          	add	a5,a5,s4
   114bc:	01450a33          	add	s4,a0,s4
   114c0:	001a6a13          	ori	s4,s4,1
   114c4:	00fc2023          	sw	a5,0(s8)
   114c8:	014b2223          	sw	s4,4(s6)
   114cc:	df2b82e3          	beq	s7,s2,112b0 <_malloc_r+0x388>
   114d0:	00f00713          	li	a4,15
   114d4:	05576263          	bltu	a4,s5,11518 <_malloc_r+0x5f0>
   114d8:	00100793          	li	a5,1
   114dc:	00fb2223          	sw	a5,4(s6)
   114e0:	00892783          	lw	a5,8(s2)
   114e4:	0047a783          	lw	a5,4(a5)
   114e8:	ffc7f793          	andi	a5,a5,-4
   114ec:	40978733          	sub	a4,a5,s1
   114f0:	0097e663          	bltu	a5,s1,114fc <_malloc_r+0x5d4>
   114f4:	00f00793          	li	a5,15
   114f8:	04e7ce63          	blt	a5,a4,11554 <_malloc_r+0x62c>
   114fc:	00098513          	mv	a0,s3
   11500:	1d0000ef          	jal	ra,116d0 <__malloc_unlock>
   11504:	a6dff06f          	j	10f70 <_malloc_r+0x48>
   11508:	40fb07b3          	sub	a5,s6,a5
   1150c:	00e787b3          	add	a5,a5,a4
   11510:	00fc2023          	sw	a5,0(s8)
   11514:	f51ff06f          	j	11464 <_malloc_r+0x53c>
   11518:	004ba783          	lw	a5,4(s7)
   1151c:	ff4a8413          	addi	s0,s5,-12 # 7ffffff4 <__global_pointer$+0x7ffeae5c>
   11520:	ff847413          	andi	s0,s0,-8
   11524:	0017f793          	andi	a5,a5,1
   11528:	0087e7b3          	or	a5,a5,s0
   1152c:	00fba223          	sw	a5,4(s7)
   11530:	00500693          	li	a3,5
   11534:	008b87b3          	add	a5,s7,s0
   11538:	00d7a223          	sw	a3,4(a5)
   1153c:	00d7a423          	sw	a3,8(a5)
   11540:	d68778e3          	bleu	s0,a4,112b0 <_malloc_r+0x388>
   11544:	008b8593          	addi	a1,s7,8
   11548:	00098513          	mv	a0,s3
   1154c:	6ad000ef          	jal	ra,123f8 <_free_r>
   11550:	d61ff06f          	j	112b0 <_malloc_r+0x388>
   11554:	00892403          	lw	s0,8(s2)
   11558:	0014e793          	ori	a5,s1,1
   1155c:	00f42223          	sw	a5,4(s0)
   11560:	009407b3          	add	a5,s0,s1
   11564:	00f92423          	sw	a5,8(s2)
   11568:	aa1ff06f          	j	11008 <_malloc_r+0xe0>

0001156c <memchr>:
   1156c:	0ff5f593          	andi	a1,a1,255
   11570:	00c50633          	add	a2,a0,a2
   11574:	00c51663          	bne	a0,a2,11580 <memchr+0x14>
   11578:	00000513          	li	a0,0
   1157c:	00008067          	ret
   11580:	00054783          	lbu	a5,0(a0)
   11584:	feb78ce3          	beq	a5,a1,1157c <memchr+0x10>
   11588:	00150513          	addi	a0,a0,1
   1158c:	fe9ff06f          	j	11574 <memchr+0x8>

00011590 <memcpy>:
   11590:	00a5c7b3          	xor	a5,a1,a0
   11594:	0037f793          	andi	a5,a5,3
   11598:	00c50733          	add	a4,a0,a2
   1159c:	00079663          	bnez	a5,115a8 <memcpy+0x18>
   115a0:	00300793          	li	a5,3
   115a4:	02c7e463          	bltu	a5,a2,115cc <memcpy+0x3c>
   115a8:	00050793          	mv	a5,a0
   115ac:	00e56c63          	bltu	a0,a4,115c4 <memcpy+0x34>
   115b0:	00008067          	ret
   115b4:	0005c683          	lbu	a3,0(a1)
   115b8:	00178793          	addi	a5,a5,1
   115bc:	00158593          	addi	a1,a1,1
   115c0:	fed78fa3          	sb	a3,-1(a5)
   115c4:	fee7e8e3          	bltu	a5,a4,115b4 <memcpy+0x24>
   115c8:	00008067          	ret
   115cc:	00357793          	andi	a5,a0,3
   115d0:	08079263          	bnez	a5,11654 <memcpy+0xc4>
   115d4:	00050793          	mv	a5,a0
   115d8:	ffc77693          	andi	a3,a4,-4
   115dc:	fe068613          	addi	a2,a3,-32
   115e0:	08c7f663          	bleu	a2,a5,1166c <memcpy+0xdc>
   115e4:	0005a383          	lw	t2,0(a1)
   115e8:	0045a283          	lw	t0,4(a1)
   115ec:	0085af83          	lw	t6,8(a1)
   115f0:	00c5af03          	lw	t5,12(a1)
   115f4:	0105ae83          	lw	t4,16(a1)
   115f8:	0145ae03          	lw	t3,20(a1)
   115fc:	0185a303          	lw	t1,24(a1)
   11600:	01c5a883          	lw	a7,28(a1)
   11604:	02458593          	addi	a1,a1,36
   11608:	02478793          	addi	a5,a5,36
   1160c:	ffc5a803          	lw	a6,-4(a1)
   11610:	fc77ae23          	sw	t2,-36(a5)
   11614:	fe57a023          	sw	t0,-32(a5)
   11618:	fff7a223          	sw	t6,-28(a5)
   1161c:	ffe7a423          	sw	t5,-24(a5)
   11620:	ffd7a623          	sw	t4,-20(a5)
   11624:	ffc7a823          	sw	t3,-16(a5)
   11628:	fe67aa23          	sw	t1,-12(a5)
   1162c:	ff17ac23          	sw	a7,-8(a5)
   11630:	ff07ae23          	sw	a6,-4(a5)
   11634:	fadff06f          	j	115e0 <memcpy+0x50>
   11638:	0005c683          	lbu	a3,0(a1)
   1163c:	00178793          	addi	a5,a5,1
   11640:	00158593          	addi	a1,a1,1
   11644:	fed78fa3          	sb	a3,-1(a5)
   11648:	0037f693          	andi	a3,a5,3
   1164c:	fe0696e3          	bnez	a3,11638 <memcpy+0xa8>
   11650:	f89ff06f          	j	115d8 <memcpy+0x48>
   11654:	00050793          	mv	a5,a0
   11658:	ff1ff06f          	j	11648 <memcpy+0xb8>
   1165c:	0005a603          	lw	a2,0(a1)
   11660:	00478793          	addi	a5,a5,4
   11664:	00458593          	addi	a1,a1,4
   11668:	fec7ae23          	sw	a2,-4(a5)
   1166c:	fed7e8e3          	bltu	a5,a3,1165c <memcpy+0xcc>
   11670:	f4e7eae3          	bltu	a5,a4,115c4 <memcpy+0x34>
   11674:	00008067          	ret

00011678 <memmove>:
   11678:	00c50733          	add	a4,a0,a2
   1167c:	00a5e863          	bltu	a1,a0,1168c <memmove+0x14>
   11680:	00050793          	mv	a5,a0
   11684:	02f71a63          	bne	a4,a5,116b8 <memmove+0x40>
   11688:	00008067          	ret
   1168c:	00c587b3          	add	a5,a1,a2
   11690:	40f60633          	sub	a2,a2,a5
   11694:	fef576e3          	bleu	a5,a0,11680 <memmove+0x8>
   11698:	00c786b3          	add	a3,a5,a2
   1169c:	00069463          	bnez	a3,116a4 <memmove+0x2c>
   116a0:	00008067          	ret
   116a4:	fff78793          	addi	a5,a5,-1
   116a8:	0007c683          	lbu	a3,0(a5)
   116ac:	fff70713          	addi	a4,a4,-1
   116b0:	00d70023          	sb	a3,0(a4)
   116b4:	fe5ff06f          	j	11698 <memmove+0x20>
   116b8:	00158593          	addi	a1,a1,1
   116bc:	fff5c683          	lbu	a3,-1(a1)
   116c0:	00178793          	addi	a5,a5,1
   116c4:	fed78fa3          	sb	a3,-1(a5)
   116c8:	fbdff06f          	j	11684 <memmove+0xc>

000116cc <__malloc_lock>:
   116cc:	00008067          	ret

000116d0 <__malloc_unlock>:
   116d0:	00008067          	ret

000116d4 <_realloc_r>:
   116d4:	fc010113          	addi	sp,sp,-64
   116d8:	02812c23          	sw	s0,56(sp)
   116dc:	02112e23          	sw	ra,60(sp)
   116e0:	00058413          	mv	s0,a1
   116e4:	02912a23          	sw	s1,52(sp)
   116e8:	03212823          	sw	s2,48(sp)
   116ec:	03312623          	sw	s3,44(sp)
   116f0:	03412423          	sw	s4,40(sp)
   116f4:	03512223          	sw	s5,36(sp)
   116f8:	03612023          	sw	s6,32(sp)
   116fc:	01712e23          	sw	s7,28(sp)
   11700:	01812c23          	sw	s8,24(sp)
   11704:	00060593          	mv	a1,a2
   11708:	02041a63          	bnez	s0,1173c <_realloc_r+0x68>
   1170c:	03812403          	lw	s0,56(sp)
   11710:	03c12083          	lw	ra,60(sp)
   11714:	03412483          	lw	s1,52(sp)
   11718:	03012903          	lw	s2,48(sp)
   1171c:	02c12983          	lw	s3,44(sp)
   11720:	02812a03          	lw	s4,40(sp)
   11724:	02412a83          	lw	s5,36(sp)
   11728:	02012b03          	lw	s6,32(sp)
   1172c:	01c12b83          	lw	s7,28(sp)
   11730:	01812c03          	lw	s8,24(sp)
   11734:	04010113          	addi	sp,sp,64
   11738:	ff0ff06f          	j	10f28 <_malloc_r>
   1173c:	00050a93          	mv	s5,a0
   11740:	00c12623          	sw	a2,12(sp)
   11744:	f89ff0ef          	jal	ra,116cc <__malloc_lock>
   11748:	00c12583          	lw	a1,12(sp)
   1174c:	ffc42683          	lw	a3,-4(s0)
   11750:	01600793          	li	a5,22
   11754:	00b58993          	addi	s3,a1,11
   11758:	ff840b93          	addi	s7,s0,-8
   1175c:	ffc6f913          	andi	s2,a3,-4
   11760:	0537f663          	bleu	s3,a5,117ac <_realloc_r+0xd8>
   11764:	ff89fb13          	andi	s6,s3,-8
   11768:	040b5463          	bgez	s6,117b0 <_realloc_r+0xdc>
   1176c:	00c00793          	li	a5,12
   11770:	00faa023          	sw	a5,0(s5)
   11774:	00000a13          	li	s4,0
   11778:	03c12083          	lw	ra,60(sp)
   1177c:	03812403          	lw	s0,56(sp)
   11780:	000a0513          	mv	a0,s4
   11784:	03412483          	lw	s1,52(sp)
   11788:	03012903          	lw	s2,48(sp)
   1178c:	02c12983          	lw	s3,44(sp)
   11790:	02812a03          	lw	s4,40(sp)
   11794:	02412a83          	lw	s5,36(sp)
   11798:	02012b03          	lw	s6,32(sp)
   1179c:	01c12b83          	lw	s7,28(sp)
   117a0:	01812c03          	lw	s8,24(sp)
   117a4:	04010113          	addi	sp,sp,64
   117a8:	00008067          	ret
   117ac:	01000b13          	li	s6,16
   117b0:	fabb6ee3          	bltu	s6,a1,1176c <_realloc_r+0x98>
   117b4:	45695c63          	ble	s6,s2,11c0c <_realloc_r+0x538>
   117b8:	00014c37          	lui	s8,0x14
   117bc:	590c0713          	addi	a4,s8,1424 # 14590 <__malloc_av_>
   117c0:	00872603          	lw	a2,8(a4)
   117c4:	012b87b3          	add	a5,s7,s2
   117c8:	0047a703          	lw	a4,4(a5)
   117cc:	590c0c13          	addi	s8,s8,1424
   117d0:	00f60c63          	beq	a2,a5,117e8 <_realloc_r+0x114>
   117d4:	ffe77513          	andi	a0,a4,-2
   117d8:	00a78533          	add	a0,a5,a0
   117dc:	00452503          	lw	a0,4(a0)
   117e0:	00157513          	andi	a0,a0,1
   117e4:	0a051a63          	bnez	a0,11898 <_realloc_r+0x1c4>
   117e8:	ffc77713          	andi	a4,a4,-4
   117ec:	00e909b3          	add	s3,s2,a4
   117f0:	04f61063          	bne	a2,a5,11830 <_realloc_r+0x15c>
   117f4:	010b0513          	addi	a0,s6,16
   117f8:	0aa9c463          	blt	s3,a0,118a0 <_realloc_r+0x1cc>
   117fc:	016b8bb3          	add	s7,s7,s6
   11800:	416989b3          	sub	s3,s3,s6
   11804:	017c2423          	sw	s7,8(s8)
   11808:	0019e993          	ori	s3,s3,1
   1180c:	013ba223          	sw	s3,4(s7)
   11810:	ffc42983          	lw	s3,-4(s0)
   11814:	000a8513          	mv	a0,s5
   11818:	00040a13          	mv	s4,s0
   1181c:	0019f993          	andi	s3,s3,1
   11820:	0169e9b3          	or	s3,s3,s6
   11824:	ff342e23          	sw	s3,-4(s0)
   11828:	ea9ff0ef          	jal	ra,116d0 <__malloc_unlock>
   1182c:	f4dff06f          	j	11778 <_realloc_r+0xa4>
   11830:	0769c863          	blt	s3,s6,118a0 <_realloc_r+0x1cc>
   11834:	00c7a703          	lw	a4,12(a5)
   11838:	0087a783          	lw	a5,8(a5)
   1183c:	00e7a623          	sw	a4,12(a5)
   11840:	00f72423          	sw	a5,8(a4)
   11844:	004ba703          	lw	a4,4(s7)
   11848:	416986b3          	sub	a3,s3,s6
   1184c:	00f00613          	li	a2,15
   11850:	00177713          	andi	a4,a4,1
   11854:	013b87b3          	add	a5,s7,s3
   11858:	3ad67e63          	bleu	a3,a2,11c14 <_realloc_r+0x540>
   1185c:	00eb69b3          	or	s3,s6,a4
   11860:	013ba223          	sw	s3,4(s7)
   11864:	016b85b3          	add	a1,s7,s6
   11868:	0016e693          	ori	a3,a3,1
   1186c:	00d5a223          	sw	a3,4(a1)
   11870:	0047a703          	lw	a4,4(a5)
   11874:	00858593          	addi	a1,a1,8
   11878:	000a8513          	mv	a0,s5
   1187c:	00176713          	ori	a4,a4,1
   11880:	00e7a223          	sw	a4,4(a5)
   11884:	375000ef          	jal	ra,123f8 <_free_r>
   11888:	000a8513          	mv	a0,s5
   1188c:	e45ff0ef          	jal	ra,116d0 <__malloc_unlock>
   11890:	008b8a13          	addi	s4,s7,8
   11894:	ee5ff06f          	j	11778 <_realloc_r+0xa4>
   11898:	00000713          	li	a4,0
   1189c:	00000793          	li	a5,0
   118a0:	0016f693          	andi	a3,a3,1
   118a4:	28069263          	bnez	a3,11b28 <_realloc_r+0x454>
   118a8:	ff842483          	lw	s1,-8(s0)
   118ac:	409b84b3          	sub	s1,s7,s1
   118b0:	0044aa03          	lw	s4,4(s1)
   118b4:	ffca7a13          	andi	s4,s4,-4
   118b8:	012a0a33          	add	s4,s4,s2
   118bc:	1a078c63          	beqz	a5,11a74 <_realloc_r+0x3a0>
   118c0:	014709b3          	add	s3,a4,s4
   118c4:	0ef61663          	bne	a2,a5,119b0 <_realloc_r+0x2dc>
   118c8:	010b0793          	addi	a5,s6,16
   118cc:	1af9c463          	blt	s3,a5,11a74 <_realloc_r+0x3a0>
   118d0:	0084a703          	lw	a4,8(s1)
   118d4:	00c4a783          	lw	a5,12(s1)
   118d8:	ffc90613          	addi	a2,s2,-4
   118dc:	00848a13          	addi	s4,s1,8
   118e0:	00f72623          	sw	a5,12(a4)
   118e4:	00e7a423          	sw	a4,8(a5)
   118e8:	02400713          	li	a4,36
   118ec:	0ac76a63          	bltu	a4,a2,119a0 <_realloc_r+0x2cc>
   118f0:	01300693          	li	a3,19
   118f4:	000a0793          	mv	a5,s4
   118f8:	02c6f263          	bleu	a2,a3,1191c <_realloc_r+0x248>
   118fc:	00042783          	lw	a5,0(s0)
   11900:	00f4a423          	sw	a5,8(s1)
   11904:	00442783          	lw	a5,4(s0)
   11908:	00f4a623          	sw	a5,12(s1)
   1190c:	01b00793          	li	a5,27
   11910:	04c7ea63          	bltu	a5,a2,11964 <_realloc_r+0x290>
   11914:	00840413          	addi	s0,s0,8
   11918:	01048793          	addi	a5,s1,16
   1191c:	00042703          	lw	a4,0(s0)
   11920:	00e7a023          	sw	a4,0(a5)
   11924:	00442703          	lw	a4,4(s0)
   11928:	00e7a223          	sw	a4,4(a5)
   1192c:	00842703          	lw	a4,8(s0)
   11930:	00e7a423          	sw	a4,8(a5)
   11934:	016487b3          	add	a5,s1,s6
   11938:	416989b3          	sub	s3,s3,s6
   1193c:	00fc2423          	sw	a5,8(s8)
   11940:	0019e993          	ori	s3,s3,1
   11944:	0137a223          	sw	s3,4(a5)
   11948:	0044a783          	lw	a5,4(s1)
   1194c:	0017f793          	andi	a5,a5,1
   11950:	0167e9b3          	or	s3,a5,s6
   11954:	0134a223          	sw	s3,4(s1)
   11958:	000a8513          	mv	a0,s5
   1195c:	d75ff0ef          	jal	ra,116d0 <__malloc_unlock>
   11960:	e19ff06f          	j	11778 <_realloc_r+0xa4>
   11964:	00842783          	lw	a5,8(s0)
   11968:	00f4a823          	sw	a5,16(s1)
   1196c:	00c42783          	lw	a5,12(s0)
   11970:	00f4aa23          	sw	a5,20(s1)
   11974:	00e60863          	beq	a2,a4,11984 <_realloc_r+0x2b0>
   11978:	01040413          	addi	s0,s0,16
   1197c:	01848793          	addi	a5,s1,24
   11980:	f9dff06f          	j	1191c <_realloc_r+0x248>
   11984:	01042783          	lw	a5,16(s0)
   11988:	01840413          	addi	s0,s0,24
   1198c:	00f4ac23          	sw	a5,24(s1)
   11990:	ffc42703          	lw	a4,-4(s0)
   11994:	02048793          	addi	a5,s1,32
   11998:	00e4ae23          	sw	a4,28(s1)
   1199c:	f81ff06f          	j	1191c <_realloc_r+0x248>
   119a0:	00040593          	mv	a1,s0
   119a4:	000a0513          	mv	a0,s4
   119a8:	cd1ff0ef          	jal	ra,11678 <memmove>
   119ac:	f89ff06f          	j	11934 <_realloc_r+0x260>
   119b0:	0d69c263          	blt	s3,s6,11a74 <_realloc_r+0x3a0>
   119b4:	00c7a703          	lw	a4,12(a5)
   119b8:	0087a783          	lw	a5,8(a5)
   119bc:	ffc90613          	addi	a2,s2,-4
   119c0:	00848513          	addi	a0,s1,8
   119c4:	00e7a623          	sw	a4,12(a5)
   119c8:	00f72423          	sw	a5,8(a4)
   119cc:	0084a703          	lw	a4,8(s1)
   119d0:	00c4a783          	lw	a5,12(s1)
   119d4:	00f72623          	sw	a5,12(a4)
   119d8:	00e7a423          	sw	a4,8(a5)
   119dc:	02400793          	li	a5,36
   119e0:	08c7e463          	bltu	a5,a2,11a68 <_realloc_r+0x394>
   119e4:	01300713          	li	a4,19
   119e8:	02c77263          	bleu	a2,a4,11a0c <_realloc_r+0x338>
   119ec:	00042703          	lw	a4,0(s0)
   119f0:	00e4a423          	sw	a4,8(s1)
   119f4:	00442703          	lw	a4,4(s0)
   119f8:	00e4a623          	sw	a4,12(s1)
   119fc:	01b00713          	li	a4,27
   11a00:	02c76663          	bltu	a4,a2,11a2c <_realloc_r+0x358>
   11a04:	00840413          	addi	s0,s0,8
   11a08:	01048513          	addi	a0,s1,16
   11a0c:	00042783          	lw	a5,0(s0)
   11a10:	00f52023          	sw	a5,0(a0)
   11a14:	00442783          	lw	a5,4(s0)
   11a18:	00f52223          	sw	a5,4(a0)
   11a1c:	00842783          	lw	a5,8(s0)
   11a20:	00f52423          	sw	a5,8(a0)
   11a24:	00048b93          	mv	s7,s1
   11a28:	e1dff06f          	j	11844 <_realloc_r+0x170>
   11a2c:	00842703          	lw	a4,8(s0)
   11a30:	00e4a823          	sw	a4,16(s1)
   11a34:	00c42703          	lw	a4,12(s0)
   11a38:	00e4aa23          	sw	a4,20(s1)
   11a3c:	00f60863          	beq	a2,a5,11a4c <_realloc_r+0x378>
   11a40:	01040413          	addi	s0,s0,16
   11a44:	01848513          	addi	a0,s1,24
   11a48:	fc5ff06f          	j	11a0c <_realloc_r+0x338>
   11a4c:	01042783          	lw	a5,16(s0)
   11a50:	02048513          	addi	a0,s1,32
   11a54:	01840413          	addi	s0,s0,24
   11a58:	00f4ac23          	sw	a5,24(s1)
   11a5c:	ffc42783          	lw	a5,-4(s0)
   11a60:	00f4ae23          	sw	a5,28(s1)
   11a64:	fa9ff06f          	j	11a0c <_realloc_r+0x338>
   11a68:	00040593          	mv	a1,s0
   11a6c:	c0dff0ef          	jal	ra,11678 <memmove>
   11a70:	fb5ff06f          	j	11a24 <_realloc_r+0x350>
   11a74:	0b6a4a63          	blt	s4,s6,11b28 <_realloc_r+0x454>
   11a78:	00c4a783          	lw	a5,12(s1)
   11a7c:	0084a703          	lw	a4,8(s1)
   11a80:	ffc90613          	addi	a2,s2,-4
   11a84:	00848513          	addi	a0,s1,8
   11a88:	00f72623          	sw	a5,12(a4)
   11a8c:	00e7a423          	sw	a4,8(a5)
   11a90:	02400793          	li	a5,36
   11a94:	08c7e463          	bltu	a5,a2,11b1c <_realloc_r+0x448>
   11a98:	01300713          	li	a4,19
   11a9c:	02c77263          	bleu	a2,a4,11ac0 <_realloc_r+0x3ec>
   11aa0:	00042703          	lw	a4,0(s0)
   11aa4:	00e4a423          	sw	a4,8(s1)
   11aa8:	00442703          	lw	a4,4(s0)
   11aac:	00e4a623          	sw	a4,12(s1)
   11ab0:	01b00713          	li	a4,27
   11ab4:	02c76663          	bltu	a4,a2,11ae0 <_realloc_r+0x40c>
   11ab8:	00840413          	addi	s0,s0,8
   11abc:	01048513          	addi	a0,s1,16
   11ac0:	00042783          	lw	a5,0(s0)
   11ac4:	00f52023          	sw	a5,0(a0)
   11ac8:	00442783          	lw	a5,4(s0)
   11acc:	00f52223          	sw	a5,4(a0)
   11ad0:	00842783          	lw	a5,8(s0)
   11ad4:	00f52423          	sw	a5,8(a0)
   11ad8:	000a0993          	mv	s3,s4
   11adc:	f49ff06f          	j	11a24 <_realloc_r+0x350>
   11ae0:	00842703          	lw	a4,8(s0)
   11ae4:	00e4a823          	sw	a4,16(s1)
   11ae8:	00c42703          	lw	a4,12(s0)
   11aec:	00e4aa23          	sw	a4,20(s1)
   11af0:	00f60863          	beq	a2,a5,11b00 <_realloc_r+0x42c>
   11af4:	01040413          	addi	s0,s0,16
   11af8:	01848513          	addi	a0,s1,24
   11afc:	fc5ff06f          	j	11ac0 <_realloc_r+0x3ec>
   11b00:	01042783          	lw	a5,16(s0)
   11b04:	02048513          	addi	a0,s1,32
   11b08:	01840413          	addi	s0,s0,24
   11b0c:	00f4ac23          	sw	a5,24(s1)
   11b10:	ffc42783          	lw	a5,-4(s0)
   11b14:	00f4ae23          	sw	a5,28(s1)
   11b18:	fa9ff06f          	j	11ac0 <_realloc_r+0x3ec>
   11b1c:	00040593          	mv	a1,s0
   11b20:	b59ff0ef          	jal	ra,11678 <memmove>
   11b24:	fb5ff06f          	j	11ad8 <_realloc_r+0x404>
   11b28:	000a8513          	mv	a0,s5
   11b2c:	bfcff0ef          	jal	ra,10f28 <_malloc_r>
   11b30:	00050a13          	mv	s4,a0
   11b34:	e20502e3          	beqz	a0,11958 <_realloc_r+0x284>
   11b38:	ffc42783          	lw	a5,-4(s0)
   11b3c:	ff850713          	addi	a4,a0,-8
   11b40:	ffe7f793          	andi	a5,a5,-2
   11b44:	00fb87b3          	add	a5,s7,a5
   11b48:	00e79a63          	bne	a5,a4,11b5c <_realloc_r+0x488>
   11b4c:	ffc52983          	lw	s3,-4(a0)
   11b50:	ffc9f993          	andi	s3,s3,-4
   11b54:	012989b3          	add	s3,s3,s2
   11b58:	cedff06f          	j	11844 <_realloc_r+0x170>
   11b5c:	ffc90613          	addi	a2,s2,-4
   11b60:	02400793          	li	a5,36
   11b64:	08c7ee63          	bltu	a5,a2,11c00 <_realloc_r+0x52c>
   11b68:	01300713          	li	a4,19
   11b6c:	08c77463          	bleu	a2,a4,11bf4 <_realloc_r+0x520>
   11b70:	00042703          	lw	a4,0(s0)
   11b74:	00e52023          	sw	a4,0(a0)
   11b78:	00442703          	lw	a4,4(s0)
   11b7c:	00e52223          	sw	a4,4(a0)
   11b80:	01b00713          	li	a4,27
   11b84:	02c76a63          	bltu	a4,a2,11bb8 <_realloc_r+0x4e4>
   11b88:	00840713          	addi	a4,s0,8
   11b8c:	00850793          	addi	a5,a0,8
   11b90:	00072683          	lw	a3,0(a4)
   11b94:	00d7a023          	sw	a3,0(a5)
   11b98:	00472683          	lw	a3,4(a4)
   11b9c:	00d7a223          	sw	a3,4(a5)
   11ba0:	00872703          	lw	a4,8(a4)
   11ba4:	00e7a423          	sw	a4,8(a5)
   11ba8:	00040593          	mv	a1,s0
   11bac:	000a8513          	mv	a0,s5
   11bb0:	049000ef          	jal	ra,123f8 <_free_r>
   11bb4:	da5ff06f          	j	11958 <_realloc_r+0x284>
   11bb8:	00842703          	lw	a4,8(s0)
   11bbc:	00e52423          	sw	a4,8(a0)
   11bc0:	00c42703          	lw	a4,12(s0)
   11bc4:	00e52623          	sw	a4,12(a0)
   11bc8:	00f60863          	beq	a2,a5,11bd8 <_realloc_r+0x504>
   11bcc:	01040713          	addi	a4,s0,16
   11bd0:	01050793          	addi	a5,a0,16
   11bd4:	fbdff06f          	j	11b90 <_realloc_r+0x4bc>
   11bd8:	01042783          	lw	a5,16(s0)
   11bdc:	01840713          	addi	a4,s0,24
   11be0:	00f52823          	sw	a5,16(a0)
   11be4:	01442683          	lw	a3,20(s0)
   11be8:	01850793          	addi	a5,a0,24
   11bec:	00d52a23          	sw	a3,20(a0)
   11bf0:	fa1ff06f          	j	11b90 <_realloc_r+0x4bc>
   11bf4:	00050793          	mv	a5,a0
   11bf8:	00040713          	mv	a4,s0
   11bfc:	f95ff06f          	j	11b90 <_realloc_r+0x4bc>
   11c00:	00040593          	mv	a1,s0
   11c04:	a75ff0ef          	jal	ra,11678 <memmove>
   11c08:	fa1ff06f          	j	11ba8 <_realloc_r+0x4d4>
   11c0c:	00090993          	mv	s3,s2
   11c10:	c35ff06f          	j	11844 <_realloc_r+0x170>
   11c14:	00e9e9b3          	or	s3,s3,a4
   11c18:	013ba223          	sw	s3,4(s7)
   11c1c:	0047a703          	lw	a4,4(a5)
   11c20:	00176713          	ori	a4,a4,1
   11c24:	00e7a223          	sw	a4,4(a5)
   11c28:	c61ff06f          	j	11888 <_realloc_r+0x1b4>

00011c2c <_sbrk_r>:
   11c2c:	ff010113          	addi	sp,sp,-16
   11c30:	00812423          	sw	s0,8(sp)
   11c34:	00912223          	sw	s1,4(sp)
   11c38:	00050493          	mv	s1,a0
   11c3c:	00058513          	mv	a0,a1
   11c40:	00112623          	sw	ra,12(sp)
   11c44:	8601a823          	sw	zero,-1936(gp) # 14a08 <errno>
   11c48:	2d4010ef          	jal	ra,12f1c <sbrk>
   11c4c:	fff00793          	li	a5,-1
   11c50:	00f51863          	bne	a0,a5,11c60 <_sbrk_r+0x34>
   11c54:	8701a783          	lw	a5,-1936(gp) # 14a08 <errno>
   11c58:	00078463          	beqz	a5,11c60 <_sbrk_r+0x34>
   11c5c:	00f4a023          	sw	a5,0(s1)
   11c60:	00c12083          	lw	ra,12(sp)
   11c64:	00812403          	lw	s0,8(sp)
   11c68:	00412483          	lw	s1,4(sp)
   11c6c:	01010113          	addi	sp,sp,16
   11c70:	00008067          	ret

00011c74 <__sread>:
   11c74:	ff010113          	addi	sp,sp,-16
   11c78:	00812423          	sw	s0,8(sp)
   11c7c:	00058413          	mv	s0,a1
   11c80:	00e59583          	lh	a1,14(a1)
   11c84:	00112623          	sw	ra,12(sp)
   11c88:	3a9000ef          	jal	ra,12830 <_read_r>
   11c8c:	02054063          	bltz	a0,11cac <__sread+0x38>
   11c90:	05042783          	lw	a5,80(s0)
   11c94:	00a787b3          	add	a5,a5,a0
   11c98:	04f42823          	sw	a5,80(s0)
   11c9c:	00c12083          	lw	ra,12(sp)
   11ca0:	00812403          	lw	s0,8(sp)
   11ca4:	01010113          	addi	sp,sp,16
   11ca8:	00008067          	ret
   11cac:	00c45783          	lhu	a5,12(s0)
   11cb0:	fffff737          	lui	a4,0xfffff
   11cb4:	fff70713          	addi	a4,a4,-1 # ffffefff <__global_pointer$+0xfffe9e67>
   11cb8:	00e7f7b3          	and	a5,a5,a4
   11cbc:	00f41623          	sh	a5,12(s0)
   11cc0:	fddff06f          	j	11c9c <__sread+0x28>

00011cc4 <__seofread>:
   11cc4:	00000513          	li	a0,0
   11cc8:	00008067          	ret

00011ccc <__swrite>:
   11ccc:	00c5d783          	lhu	a5,12(a1)
   11cd0:	fe010113          	addi	sp,sp,-32
   11cd4:	00812c23          	sw	s0,24(sp)
   11cd8:	00912a23          	sw	s1,20(sp)
   11cdc:	01212823          	sw	s2,16(sp)
   11ce0:	01312623          	sw	s3,12(sp)
   11ce4:	00112e23          	sw	ra,28(sp)
   11ce8:	1007f793          	andi	a5,a5,256
   11cec:	00050493          	mv	s1,a0
   11cf0:	00058413          	mv	s0,a1
   11cf4:	00060913          	mv	s2,a2
   11cf8:	00068993          	mv	s3,a3
   11cfc:	00078a63          	beqz	a5,11d10 <__swrite+0x44>
   11d00:	00e59583          	lh	a1,14(a1)
   11d04:	00200693          	li	a3,2
   11d08:	00000613          	li	a2,0
   11d0c:	149000ef          	jal	ra,12654 <_lseek_r>
   11d10:	00c45783          	lhu	a5,12(s0)
   11d14:	fffff737          	lui	a4,0xfffff
   11d18:	fff70713          	addi	a4,a4,-1 # ffffefff <__global_pointer$+0xfffe9e67>
   11d1c:	00e7f7b3          	and	a5,a5,a4
   11d20:	00f41623          	sh	a5,12(s0)
   11d24:	00e41583          	lh	a1,14(s0)
   11d28:	01812403          	lw	s0,24(sp)
   11d2c:	01c12083          	lw	ra,28(sp)
   11d30:	00098693          	mv	a3,s3
   11d34:	00090613          	mv	a2,s2
   11d38:	00c12983          	lw	s3,12(sp)
   11d3c:	01012903          	lw	s2,16(sp)
   11d40:	00048513          	mv	a0,s1
   11d44:	01412483          	lw	s1,20(sp)
   11d48:	02010113          	addi	sp,sp,32
   11d4c:	0640006f          	j	11db0 <_write_r>

00011d50 <__sseek>:
   11d50:	ff010113          	addi	sp,sp,-16
   11d54:	00812423          	sw	s0,8(sp)
   11d58:	00058413          	mv	s0,a1
   11d5c:	00e59583          	lh	a1,14(a1)
   11d60:	00112623          	sw	ra,12(sp)
   11d64:	0f1000ef          	jal	ra,12654 <_lseek_r>
   11d68:	fff00793          	li	a5,-1
   11d6c:	00c45703          	lhu	a4,12(s0)
   11d70:	02f51263          	bne	a0,a5,11d94 <__sseek+0x44>
   11d74:	fffff7b7          	lui	a5,0xfffff
   11d78:	fff78793          	addi	a5,a5,-1 # ffffefff <__global_pointer$+0xfffe9e67>
   11d7c:	00e7f7b3          	and	a5,a5,a4
   11d80:	00f41623          	sh	a5,12(s0)
   11d84:	00c12083          	lw	ra,12(sp)
   11d88:	00812403          	lw	s0,8(sp)
   11d8c:	01010113          	addi	sp,sp,16
   11d90:	00008067          	ret
   11d94:	000017b7          	lui	a5,0x1
   11d98:	00f767b3          	or	a5,a4,a5
   11d9c:	00f41623          	sh	a5,12(s0)
   11da0:	04a42823          	sw	a0,80(s0)
   11da4:	fe1ff06f          	j	11d84 <__sseek+0x34>

00011da8 <__sclose>:
   11da8:	00e59583          	lh	a1,14(a1)
   11dac:	1880006f          	j	11f34 <_close_r>

00011db0 <_write_r>:
   11db0:	ff010113          	addi	sp,sp,-16
   11db4:	00812423          	sw	s0,8(sp)
   11db8:	00912223          	sw	s1,4(sp)
   11dbc:	00050493          	mv	s1,a0
   11dc0:	00058513          	mv	a0,a1
   11dc4:	00060593          	mv	a1,a2
   11dc8:	00068613          	mv	a2,a3
   11dcc:	00112623          	sw	ra,12(sp)
   11dd0:	8601a823          	sw	zero,-1936(gp) # 14a08 <errno>
   11dd4:	5ad000ef          	jal	ra,12b80 <write>
   11dd8:	fff00793          	li	a5,-1
   11ddc:	00f51863          	bne	a0,a5,11dec <_write_r+0x3c>
   11de0:	8701a783          	lw	a5,-1936(gp) # 14a08 <errno>
   11de4:	00078463          	beqz	a5,11dec <_write_r+0x3c>
   11de8:	00f4a023          	sw	a5,0(s1)
   11dec:	00c12083          	lw	ra,12(sp)
   11df0:	00812403          	lw	s0,8(sp)
   11df4:	00412483          	lw	s1,4(sp)
   11df8:	01010113          	addi	sp,sp,16
   11dfc:	00008067          	ret

00011e00 <__swsetup_r>:
   11e00:	ff010113          	addi	sp,sp,-16
   11e04:	00912223          	sw	s1,4(sp)
   11e08:	00050493          	mv	s1,a0
   11e0c:	8081a503          	lw	a0,-2040(gp) # 149a0 <_impure_ptr>
   11e10:	00812423          	sw	s0,8(sp)
   11e14:	00112623          	sw	ra,12(sp)
   11e18:	00058413          	mv	s0,a1
   11e1c:	00050863          	beqz	a0,11e2c <__swsetup_r+0x2c>
   11e20:	03852783          	lw	a5,56(a0)
   11e24:	00079463          	bnez	a5,11e2c <__swsetup_r+0x2c>
   11e28:	9a9fe0ef          	jal	ra,107d0 <__sinit>
   11e2c:	00c41703          	lh	a4,12(s0)
   11e30:	01071793          	slli	a5,a4,0x10
   11e34:	0107d793          	srli	a5,a5,0x10
   11e38:	0087f693          	andi	a3,a5,8
   11e3c:	06069e63          	bnez	a3,11eb8 <__swsetup_r+0xb8>
   11e40:	0107f693          	andi	a3,a5,16
   11e44:	02069663          	bnez	a3,11e70 <__swsetup_r+0x70>
   11e48:	00900793          	li	a5,9
   11e4c:	00f4a023          	sw	a5,0(s1)
   11e50:	04076713          	ori	a4,a4,64
   11e54:	00e41623          	sh	a4,12(s0)
   11e58:	fff00513          	li	a0,-1
   11e5c:	00c12083          	lw	ra,12(sp)
   11e60:	00812403          	lw	s0,8(sp)
   11e64:	00412483          	lw	s1,4(sp)
   11e68:	01010113          	addi	sp,sp,16
   11e6c:	00008067          	ret
   11e70:	0047f793          	andi	a5,a5,4
   11e74:	02078c63          	beqz	a5,11eac <__swsetup_r+0xac>
   11e78:	03042583          	lw	a1,48(s0)
   11e7c:	00058c63          	beqz	a1,11e94 <__swsetup_r+0x94>
   11e80:	04040793          	addi	a5,s0,64
   11e84:	00f58663          	beq	a1,a5,11e90 <__swsetup_r+0x90>
   11e88:	00048513          	mv	a0,s1
   11e8c:	56c000ef          	jal	ra,123f8 <_free_r>
   11e90:	02042823          	sw	zero,48(s0)
   11e94:	00c45783          	lhu	a5,12(s0)
   11e98:	00042223          	sw	zero,4(s0)
   11e9c:	fdb7f793          	andi	a5,a5,-37
   11ea0:	00f41623          	sh	a5,12(s0)
   11ea4:	01042783          	lw	a5,16(s0)
   11ea8:	00f42023          	sw	a5,0(s0)
   11eac:	00c45783          	lhu	a5,12(s0)
   11eb0:	0087e793          	ori	a5,a5,8
   11eb4:	00f41623          	sh	a5,12(s0)
   11eb8:	01042783          	lw	a5,16(s0)
   11ebc:	02079063          	bnez	a5,11edc <__swsetup_r+0xdc>
   11ec0:	00c45783          	lhu	a5,12(s0)
   11ec4:	20000713          	li	a4,512
   11ec8:	2807f793          	andi	a5,a5,640
   11ecc:	00e78863          	beq	a5,a4,11edc <__swsetup_r+0xdc>
   11ed0:	00040593          	mv	a1,s0
   11ed4:	00048513          	mv	a0,s1
   11ed8:	069000ef          	jal	ra,12740 <__smakebuf_r>
   11edc:	00c45783          	lhu	a5,12(s0)
   11ee0:	0017f713          	andi	a4,a5,1
   11ee4:	02070c63          	beqz	a4,11f1c <__swsetup_r+0x11c>
   11ee8:	01442783          	lw	a5,20(s0)
   11eec:	00042423          	sw	zero,8(s0)
   11ef0:	40f007b3          	neg	a5,a5
   11ef4:	00f42c23          	sw	a5,24(s0)
   11ef8:	01042783          	lw	a5,16(s0)
   11efc:	00000513          	li	a0,0
   11f00:	f4079ee3          	bnez	a5,11e5c <__swsetup_r+0x5c>
   11f04:	00c41783          	lh	a5,12(s0)
   11f08:	0807f713          	andi	a4,a5,128
   11f0c:	f40708e3          	beqz	a4,11e5c <__swsetup_r+0x5c>
   11f10:	0407e793          	ori	a5,a5,64
   11f14:	00f41623          	sh	a5,12(s0)
   11f18:	f41ff06f          	j	11e58 <__swsetup_r+0x58>
   11f1c:	0027f793          	andi	a5,a5,2
   11f20:	00000713          	li	a4,0
   11f24:	00079463          	bnez	a5,11f2c <__swsetup_r+0x12c>
   11f28:	01442703          	lw	a4,20(s0)
   11f2c:	00e42423          	sw	a4,8(s0)
   11f30:	fc9ff06f          	j	11ef8 <__swsetup_r+0xf8>

00011f34 <_close_r>:
   11f34:	ff010113          	addi	sp,sp,-16
   11f38:	00812423          	sw	s0,8(sp)
   11f3c:	00912223          	sw	s1,4(sp)
   11f40:	00050493          	mv	s1,a0
   11f44:	00058513          	mv	a0,a1
   11f48:	00112623          	sw	ra,12(sp)
   11f4c:	8601a823          	sw	zero,-1936(gp) # 14a08 <errno>
   11f50:	5c9000ef          	jal	ra,12d18 <close>
   11f54:	fff00793          	li	a5,-1
   11f58:	00f51863          	bne	a0,a5,11f68 <_close_r+0x34>
   11f5c:	8701a783          	lw	a5,-1936(gp) # 14a08 <errno>
   11f60:	00078463          	beqz	a5,11f68 <_close_r+0x34>
   11f64:	00f4a023          	sw	a5,0(s1)
   11f68:	00c12083          	lw	ra,12(sp)
   11f6c:	00812403          	lw	s0,8(sp)
   11f70:	00412483          	lw	s1,4(sp)
   11f74:	01010113          	addi	sp,sp,16
   11f78:	00008067          	ret

00011f7c <_fclose_r>:
   11f7c:	ff010113          	addi	sp,sp,-16
   11f80:	00112623          	sw	ra,12(sp)
   11f84:	00812423          	sw	s0,8(sp)
   11f88:	00912223          	sw	s1,4(sp)
   11f8c:	01212023          	sw	s2,0(sp)
   11f90:	02059263          	bnez	a1,11fb4 <_fclose_r+0x38>
   11f94:	00000913          	li	s2,0
   11f98:	00c12083          	lw	ra,12(sp)
   11f9c:	00812403          	lw	s0,8(sp)
   11fa0:	00090513          	mv	a0,s2
   11fa4:	00412483          	lw	s1,4(sp)
   11fa8:	00012903          	lw	s2,0(sp)
   11fac:	01010113          	addi	sp,sp,16
   11fb0:	00008067          	ret
   11fb4:	00050493          	mv	s1,a0
   11fb8:	00058413          	mv	s0,a1
   11fbc:	00050863          	beqz	a0,11fcc <_fclose_r+0x50>
   11fc0:	03852783          	lw	a5,56(a0)
   11fc4:	00079463          	bnez	a5,11fcc <_fclose_r+0x50>
   11fc8:	809fe0ef          	jal	ra,107d0 <__sinit>
   11fcc:	00c41783          	lh	a5,12(s0)
   11fd0:	fc0782e3          	beqz	a5,11f94 <_fclose_r+0x18>
   11fd4:	00040593          	mv	a1,s0
   11fd8:	00048513          	mv	a0,s1
   11fdc:	088000ef          	jal	ra,12064 <__sflush_r>
   11fe0:	02c42783          	lw	a5,44(s0)
   11fe4:	00050913          	mv	s2,a0
   11fe8:	00078c63          	beqz	a5,12000 <_fclose_r+0x84>
   11fec:	01c42583          	lw	a1,28(s0)
   11ff0:	00048513          	mv	a0,s1
   11ff4:	000780e7          	jalr	a5
   11ff8:	00055463          	bgez	a0,12000 <_fclose_r+0x84>
   11ffc:	fff00913          	li	s2,-1
   12000:	00c45783          	lhu	a5,12(s0)
   12004:	0807f793          	andi	a5,a5,128
   12008:	00078863          	beqz	a5,12018 <_fclose_r+0x9c>
   1200c:	01042583          	lw	a1,16(s0)
   12010:	00048513          	mv	a0,s1
   12014:	3e4000ef          	jal	ra,123f8 <_free_r>
   12018:	03042583          	lw	a1,48(s0)
   1201c:	00058c63          	beqz	a1,12034 <_fclose_r+0xb8>
   12020:	04040793          	addi	a5,s0,64
   12024:	00f58663          	beq	a1,a5,12030 <_fclose_r+0xb4>
   12028:	00048513          	mv	a0,s1
   1202c:	3cc000ef          	jal	ra,123f8 <_free_r>
   12030:	02042823          	sw	zero,48(s0)
   12034:	04442583          	lw	a1,68(s0)
   12038:	00058863          	beqz	a1,12048 <_fclose_r+0xcc>
   1203c:	00048513          	mv	a0,s1
   12040:	3b8000ef          	jal	ra,123f8 <_free_r>
   12044:	04042223          	sw	zero,68(s0)
   12048:	8f9fe0ef          	jal	ra,10940 <__sfp_lock_acquire>
   1204c:	00041623          	sh	zero,12(s0)
   12050:	8f5fe0ef          	jal	ra,10944 <__sfp_lock_release>
   12054:	f45ff06f          	j	11f98 <_fclose_r+0x1c>

00012058 <fclose>:
   12058:	00050593          	mv	a1,a0
   1205c:	8081a503          	lw	a0,-2040(gp) # 149a0 <_impure_ptr>
   12060:	f1dff06f          	j	11f7c <_fclose_r>

00012064 <__sflush_r>:
   12064:	00c59783          	lh	a5,12(a1)
   12068:	fe010113          	addi	sp,sp,-32
   1206c:	00812c23          	sw	s0,24(sp)
   12070:	01079713          	slli	a4,a5,0x10
   12074:	01075713          	srli	a4,a4,0x10
   12078:	00912a23          	sw	s1,20(sp)
   1207c:	00112e23          	sw	ra,28(sp)
   12080:	01212823          	sw	s2,16(sp)
   12084:	01312623          	sw	s3,12(sp)
   12088:	00877693          	andi	a3,a4,8
   1208c:	00050493          	mv	s1,a0
   12090:	00058413          	mv	s0,a1
   12094:	16069c63          	bnez	a3,1220c <__sflush_r+0x1a8>
   12098:	00001737          	lui	a4,0x1
   1209c:	80070713          	addi	a4,a4,-2048 # 800 <main-0xf874>
   120a0:	00e7e7b3          	or	a5,a5,a4
   120a4:	0045a703          	lw	a4,4(a1)
   120a8:	00f59623          	sh	a5,12(a1)
   120ac:	02e04663          	bgtz	a4,120d8 <__sflush_r+0x74>
   120b0:	03c5a703          	lw	a4,60(a1)
   120b4:	02e04263          	bgtz	a4,120d8 <__sflush_r+0x74>
   120b8:	00000513          	li	a0,0
   120bc:	01c12083          	lw	ra,28(sp)
   120c0:	01812403          	lw	s0,24(sp)
   120c4:	01412483          	lw	s1,20(sp)
   120c8:	01012903          	lw	s2,16(sp)
   120cc:	00c12983          	lw	s3,12(sp)
   120d0:	02010113          	addi	sp,sp,32
   120d4:	00008067          	ret
   120d8:	02842703          	lw	a4,40(s0)
   120dc:	fc070ee3          	beqz	a4,120b8 <__sflush_r+0x54>
   120e0:	0004a903          	lw	s2,0(s1)
   120e4:	01379693          	slli	a3,a5,0x13
   120e8:	0004a023          	sw	zero,0(s1)
   120ec:	01c42583          	lw	a1,28(s0)
   120f0:	0c06d863          	bgez	a3,121c0 <__sflush_r+0x15c>
   120f4:	05042603          	lw	a2,80(s0)
   120f8:	00c45783          	lhu	a5,12(s0)
   120fc:	0047f793          	andi	a5,a5,4
   12100:	00078e63          	beqz	a5,1211c <__sflush_r+0xb8>
   12104:	00442783          	lw	a5,4(s0)
   12108:	40f60633          	sub	a2,a2,a5
   1210c:	03042783          	lw	a5,48(s0)
   12110:	00078663          	beqz	a5,1211c <__sflush_r+0xb8>
   12114:	03c42783          	lw	a5,60(s0)
   12118:	40f60633          	sub	a2,a2,a5
   1211c:	02842783          	lw	a5,40(s0)
   12120:	01c42583          	lw	a1,28(s0)
   12124:	00000693          	li	a3,0
   12128:	00048513          	mv	a0,s1
   1212c:	000780e7          	jalr	a5
   12130:	fff00793          	li	a5,-1
   12134:	00c45683          	lhu	a3,12(s0)
   12138:	02f51263          	bne	a0,a5,1215c <__sflush_r+0xf8>
   1213c:	0004a783          	lw	a5,0(s1)
   12140:	01d00713          	li	a4,29
   12144:	0af76c63          	bltu	a4,a5,121fc <__sflush_r+0x198>
   12148:	20400737          	lui	a4,0x20400
   1214c:	00170713          	addi	a4,a4,1 # 20400001 <__global_pointer$+0x203eae69>
   12150:	00f75733          	srl	a4,a4,a5
   12154:	00177713          	andi	a4,a4,1
   12158:	0a070263          	beqz	a4,121fc <__sflush_r+0x198>
   1215c:	fffff7b7          	lui	a5,0xfffff
   12160:	7ff78793          	addi	a5,a5,2047 # fffff7ff <__global_pointer$+0xfffea667>
   12164:	01042703          	lw	a4,16(s0)
   12168:	00d7f7b3          	and	a5,a5,a3
   1216c:	01079793          	slli	a5,a5,0x10
   12170:	4107d793          	srai	a5,a5,0x10
   12174:	00e42023          	sw	a4,0(s0)
   12178:	00f41623          	sh	a5,12(s0)
   1217c:	00042223          	sw	zero,4(s0)
   12180:	01379713          	slli	a4,a5,0x13
   12184:	00075c63          	bgez	a4,1219c <__sflush_r+0x138>
   12188:	fff00793          	li	a5,-1
   1218c:	00f51663          	bne	a0,a5,12198 <__sflush_r+0x134>
   12190:	0004a783          	lw	a5,0(s1)
   12194:	00079463          	bnez	a5,1219c <__sflush_r+0x138>
   12198:	04a42823          	sw	a0,80(s0)
   1219c:	03042583          	lw	a1,48(s0)
   121a0:	0124a023          	sw	s2,0(s1)
   121a4:	f0058ae3          	beqz	a1,120b8 <__sflush_r+0x54>
   121a8:	04040793          	addi	a5,s0,64
   121ac:	00f58663          	beq	a1,a5,121b8 <__sflush_r+0x154>
   121b0:	00048513          	mv	a0,s1
   121b4:	244000ef          	jal	ra,123f8 <_free_r>
   121b8:	02042823          	sw	zero,48(s0)
   121bc:	efdff06f          	j	120b8 <__sflush_r+0x54>
   121c0:	00000613          	li	a2,0
   121c4:	00100693          	li	a3,1
   121c8:	00048513          	mv	a0,s1
   121cc:	000700e7          	jalr	a4
   121d0:	fff00793          	li	a5,-1
   121d4:	00050613          	mv	a2,a0
   121d8:	f2f510e3          	bne	a0,a5,120f8 <__sflush_r+0x94>
   121dc:	0004a783          	lw	a5,0(s1)
   121e0:	f0078ce3          	beqz	a5,120f8 <__sflush_r+0x94>
   121e4:	01d00713          	li	a4,29
   121e8:	00e78663          	beq	a5,a4,121f4 <__sflush_r+0x190>
   121ec:	01600713          	li	a4,22
   121f0:	06e79263          	bne	a5,a4,12254 <__sflush_r+0x1f0>
   121f4:	0124a023          	sw	s2,0(s1)
   121f8:	ec1ff06f          	j	120b8 <__sflush_r+0x54>
   121fc:	0406e793          	ori	a5,a3,64
   12200:	00f41623          	sh	a5,12(s0)
   12204:	fff00513          	li	a0,-1
   12208:	eb5ff06f          	j	120bc <__sflush_r+0x58>
   1220c:	0105a983          	lw	s3,16(a1)
   12210:	ea0984e3          	beqz	s3,120b8 <__sflush_r+0x54>
   12214:	0005a903          	lw	s2,0(a1)
   12218:	00377713          	andi	a4,a4,3
   1221c:	0135a023          	sw	s3,0(a1)
   12220:	41390933          	sub	s2,s2,s3
   12224:	00000793          	li	a5,0
   12228:	00071463          	bnez	a4,12230 <__sflush_r+0x1cc>
   1222c:	0145a783          	lw	a5,20(a1)
   12230:	00f42423          	sw	a5,8(s0)
   12234:	e92052e3          	blez	s2,120b8 <__sflush_r+0x54>
   12238:	02442783          	lw	a5,36(s0)
   1223c:	01c42583          	lw	a1,28(s0)
   12240:	00090693          	mv	a3,s2
   12244:	00098613          	mv	a2,s3
   12248:	00048513          	mv	a0,s1
   1224c:	000780e7          	jalr	a5
   12250:	00a04863          	bgtz	a0,12260 <__sflush_r+0x1fc>
   12254:	00c45783          	lhu	a5,12(s0)
   12258:	0407e793          	ori	a5,a5,64
   1225c:	fa5ff06f          	j	12200 <__sflush_r+0x19c>
   12260:	00a989b3          	add	s3,s3,a0
   12264:	40a90933          	sub	s2,s2,a0
   12268:	fcdff06f          	j	12234 <__sflush_r+0x1d0>

0001226c <_fflush_r>:
   1226c:	fe010113          	addi	sp,sp,-32
   12270:	00812c23          	sw	s0,24(sp)
   12274:	00112e23          	sw	ra,28(sp)
   12278:	00050413          	mv	s0,a0
   1227c:	00050c63          	beqz	a0,12294 <_fflush_r+0x28>
   12280:	03852783          	lw	a5,56(a0)
   12284:	00079863          	bnez	a5,12294 <_fflush_r+0x28>
   12288:	00b12623          	sw	a1,12(sp)
   1228c:	d44fe0ef          	jal	ra,107d0 <__sinit>
   12290:	00c12583          	lw	a1,12(sp)
   12294:	00c59783          	lh	a5,12(a1)
   12298:	00078c63          	beqz	a5,122b0 <_fflush_r+0x44>
   1229c:	00040513          	mv	a0,s0
   122a0:	01812403          	lw	s0,24(sp)
   122a4:	01c12083          	lw	ra,28(sp)
   122a8:	02010113          	addi	sp,sp,32
   122ac:	db9ff06f          	j	12064 <__sflush_r>
   122b0:	01c12083          	lw	ra,28(sp)
   122b4:	01812403          	lw	s0,24(sp)
   122b8:	00000513          	li	a0,0
   122bc:	02010113          	addi	sp,sp,32
   122c0:	00008067          	ret

000122c4 <fflush>:
   122c4:	00050593          	mv	a1,a0
   122c8:	00051c63          	bnez	a0,122e0 <fflush+0x1c>
   122cc:	000157b7          	lui	a5,0x15
   122d0:	99c7a503          	lw	a0,-1636(a5) # 1499c <_global_impure_ptr>
   122d4:	000125b7          	lui	a1,0x12
   122d8:	26c58593          	addi	a1,a1,620 # 1226c <_fflush_r>
   122dc:	b99fe06f          	j	10e74 <_fwalk_reent>
   122e0:	8081a503          	lw	a0,-2040(gp) # 149a0 <_impure_ptr>
   122e4:	f89ff06f          	j	1226c <_fflush_r>

000122e8 <_malloc_trim_r>:
   122e8:	fd010113          	addi	sp,sp,-48
   122ec:	03212023          	sw	s2,32(sp)
   122f0:	00014937          	lui	s2,0x14
   122f4:	02812423          	sw	s0,40(sp)
   122f8:	02912223          	sw	s1,36(sp)
   122fc:	01312e23          	sw	s3,28(sp)
   12300:	00b12623          	sw	a1,12(sp)
   12304:	02112623          	sw	ra,44(sp)
   12308:	00050993          	mv	s3,a0
   1230c:	59090913          	addi	s2,s2,1424 # 14590 <__malloc_av_>
   12310:	bbcff0ef          	jal	ra,116cc <__malloc_lock>
   12314:	00892783          	lw	a5,8(s2)
   12318:	00c12583          	lw	a1,12(sp)
   1231c:	0047a483          	lw	s1,4(a5)
   12320:	000017b7          	lui	a5,0x1
   12324:	fef78413          	addi	s0,a5,-17 # fef <main-0xf085>
   12328:	ffc4f493          	andi	s1,s1,-4
   1232c:	40b40433          	sub	s0,s0,a1
   12330:	00940433          	add	s0,s0,s1
   12334:	00c45413          	srli	s0,s0,0xc
   12338:	fff40413          	addi	s0,s0,-1
   1233c:	00c41413          	slli	s0,s0,0xc
   12340:	02f45663          	ble	a5,s0,1236c <_malloc_trim_r+0x84>
   12344:	00098513          	mv	a0,s3
   12348:	b88ff0ef          	jal	ra,116d0 <__malloc_unlock>
   1234c:	00000513          	li	a0,0
   12350:	02c12083          	lw	ra,44(sp)
   12354:	02812403          	lw	s0,40(sp)
   12358:	02412483          	lw	s1,36(sp)
   1235c:	02012903          	lw	s2,32(sp)
   12360:	01c12983          	lw	s3,28(sp)
   12364:	03010113          	addi	sp,sp,48
   12368:	00008067          	ret
   1236c:	00000593          	li	a1,0
   12370:	00098513          	mv	a0,s3
   12374:	8b9ff0ef          	jal	ra,11c2c <_sbrk_r>
   12378:	00892783          	lw	a5,8(s2)
   1237c:	009787b3          	add	a5,a5,s1
   12380:	fcf512e3          	bne	a0,a5,12344 <_malloc_trim_r+0x5c>
   12384:	408005b3          	neg	a1,s0
   12388:	00098513          	mv	a0,s3
   1238c:	8a1ff0ef          	jal	ra,11c2c <_sbrk_r>
   12390:	fff00793          	li	a5,-1
   12394:	02f51c63          	bne	a0,a5,123cc <_malloc_trim_r+0xe4>
   12398:	00000593          	li	a1,0
   1239c:	00098513          	mv	a0,s3
   123a0:	88dff0ef          	jal	ra,11c2c <_sbrk_r>
   123a4:	00892703          	lw	a4,8(s2)
   123a8:	00f00693          	li	a3,15
   123ac:	40e507b3          	sub	a5,a0,a4
   123b0:	f8f6dae3          	ble	a5,a3,12344 <_malloc_trim_r+0x5c>
   123b4:	80c1a683          	lw	a3,-2036(gp) # 149a4 <__malloc_sbrk_base>
   123b8:	0017e793          	ori	a5,a5,1
   123bc:	00f72223          	sw	a5,4(a4)
   123c0:	40d50533          	sub	a0,a0,a3
   123c4:	84a1a423          	sw	a0,-1976(gp) # 149e0 <__malloc_current_mallinfo>
   123c8:	f7dff06f          	j	12344 <_malloc_trim_r+0x5c>
   123cc:	00892783          	lw	a5,8(s2)
   123d0:	408484b3          	sub	s1,s1,s0
   123d4:	0014e493          	ori	s1,s1,1
   123d8:	0097a223          	sw	s1,4(a5)
   123dc:	8481a783          	lw	a5,-1976(gp) # 149e0 <__malloc_current_mallinfo>
   123e0:	00098513          	mv	a0,s3
   123e4:	40878433          	sub	s0,a5,s0
   123e8:	8481a423          	sw	s0,-1976(gp) # 149e0 <__malloc_current_mallinfo>
   123ec:	ae4ff0ef          	jal	ra,116d0 <__malloc_unlock>
   123f0:	00100513          	li	a0,1
   123f4:	f5dff06f          	j	12350 <_malloc_trim_r+0x68>

000123f8 <_free_r>:
   123f8:	24058c63          	beqz	a1,12650 <_free_r+0x258>
   123fc:	ff010113          	addi	sp,sp,-16
   12400:	00812423          	sw	s0,8(sp)
   12404:	00912223          	sw	s1,4(sp)
   12408:	00050413          	mv	s0,a0
   1240c:	00058493          	mv	s1,a1
   12410:	00112623          	sw	ra,12(sp)
   12414:	ab8ff0ef          	jal	ra,116cc <__malloc_lock>
   12418:	ffc4a503          	lw	a0,-4(s1)
   1241c:	00014637          	lui	a2,0x14
   12420:	ff848693          	addi	a3,s1,-8
   12424:	ffe57793          	andi	a5,a0,-2
   12428:	59060813          	addi	a6,a2,1424 # 14590 <__malloc_av_>
   1242c:	00f685b3          	add	a1,a3,a5
   12430:	0045a703          	lw	a4,4(a1)
   12434:	00882803          	lw	a6,8(a6)
   12438:	59060613          	addi	a2,a2,1424
   1243c:	ffc77713          	andi	a4,a4,-4
   12440:	00157513          	andi	a0,a0,1
   12444:	06b81063          	bne	a6,a1,124a4 <_free_r+0xac>
   12448:	00e787b3          	add	a5,a5,a4
   1244c:	02051063          	bnez	a0,1246c <_free_r+0x74>
   12450:	ff84a703          	lw	a4,-8(s1)
   12454:	40e686b3          	sub	a3,a3,a4
   12458:	0086a583          	lw	a1,8(a3)
   1245c:	00e787b3          	add	a5,a5,a4
   12460:	00c6a703          	lw	a4,12(a3)
   12464:	00e5a623          	sw	a4,12(a1)
   12468:	00b72423          	sw	a1,8(a4)
   1246c:	0017e713          	ori	a4,a5,1
   12470:	00e6a223          	sw	a4,4(a3)
   12474:	8101a703          	lw	a4,-2032(gp) # 149a8 <__malloc_trim_threshold>
   12478:	00d62423          	sw	a3,8(a2)
   1247c:	00e7e863          	bltu	a5,a4,1248c <_free_r+0x94>
   12480:	81c1a583          	lw	a1,-2020(gp) # 149b4 <__malloc_top_pad>
   12484:	00040513          	mv	a0,s0
   12488:	e61ff0ef          	jal	ra,122e8 <_malloc_trim_r>
   1248c:	00040513          	mv	a0,s0
   12490:	00812403          	lw	s0,8(sp)
   12494:	00c12083          	lw	ra,12(sp)
   12498:	00412483          	lw	s1,4(sp)
   1249c:	01010113          	addi	sp,sp,16
   124a0:	a30ff06f          	j	116d0 <__malloc_unlock>
   124a4:	00e5a223          	sw	a4,4(a1)
   124a8:	00000813          	li	a6,0
   124ac:	02051663          	bnez	a0,124d8 <_free_r+0xe0>
   124b0:	ff84a503          	lw	a0,-8(s1)
   124b4:	000148b7          	lui	a7,0x14
   124b8:	59888893          	addi	a7,a7,1432 # 14598 <__malloc_av_+0x8>
   124bc:	40a686b3          	sub	a3,a3,a0
   124c0:	00a787b3          	add	a5,a5,a0
   124c4:	0086a503          	lw	a0,8(a3)
   124c8:	0b150663          	beq	a0,a7,12574 <_free_r+0x17c>
   124cc:	00c6a883          	lw	a7,12(a3)
   124d0:	01152623          	sw	a7,12(a0)
   124d4:	00a8a423          	sw	a0,8(a7)
   124d8:	00e58533          	add	a0,a1,a4
   124dc:	00452503          	lw	a0,4(a0)
   124e0:	00157513          	andi	a0,a0,1
   124e4:	02051863          	bnez	a0,12514 <_free_r+0x11c>
   124e8:	00e787b3          	add	a5,a5,a4
   124ec:	0085a703          	lw	a4,8(a1)
   124f0:	08081663          	bnez	a6,1257c <_free_r+0x184>
   124f4:	00014537          	lui	a0,0x14
   124f8:	59850513          	addi	a0,a0,1432 # 14598 <__malloc_av_+0x8>
   124fc:	08a71063          	bne	a4,a0,1257c <_free_r+0x184>
   12500:	00d62a23          	sw	a3,20(a2)
   12504:	00d62823          	sw	a3,16(a2)
   12508:	00e6a623          	sw	a4,12(a3)
   1250c:	00e6a423          	sw	a4,8(a3)
   12510:	00100813          	li	a6,1
   12514:	0017e713          	ori	a4,a5,1
   12518:	00e6a223          	sw	a4,4(a3)
   1251c:	00f68733          	add	a4,a3,a5
   12520:	00f72023          	sw	a5,0(a4)
   12524:	f60814e3          	bnez	a6,1248c <_free_r+0x94>
   12528:	1ff00713          	li	a4,511
   1252c:	06f76063          	bltu	a4,a5,1258c <_free_r+0x194>
   12530:	0037d793          	srli	a5,a5,0x3
   12534:	4027d593          	srai	a1,a5,0x2
   12538:	00100713          	li	a4,1
   1253c:	00b71733          	sll	a4,a4,a1
   12540:	00462583          	lw	a1,4(a2)
   12544:	00178793          	addi	a5,a5,1
   12548:	00379793          	slli	a5,a5,0x3
   1254c:	00f607b3          	add	a5,a2,a5
   12550:	00b76733          	or	a4,a4,a1
   12554:	00e62223          	sw	a4,4(a2)
   12558:	0007a703          	lw	a4,0(a5)
   1255c:	ff878613          	addi	a2,a5,-8
   12560:	00c6a623          	sw	a2,12(a3)
   12564:	00e6a423          	sw	a4,8(a3)
   12568:	00d7a023          	sw	a3,0(a5)
   1256c:	00d72623          	sw	a3,12(a4)
   12570:	f1dff06f          	j	1248c <_free_r+0x94>
   12574:	00100813          	li	a6,1
   12578:	f61ff06f          	j	124d8 <_free_r+0xe0>
   1257c:	00c5a583          	lw	a1,12(a1)
   12580:	00b72623          	sw	a1,12(a4)
   12584:	00e5a423          	sw	a4,8(a1)
   12588:	f8dff06f          	j	12514 <_free_r+0x11c>
   1258c:	0097d593          	srli	a1,a5,0x9
   12590:	00400713          	li	a4,4
   12594:	04b76863          	bltu	a4,a1,125e4 <_free_r+0x1ec>
   12598:	0067d713          	srli	a4,a5,0x6
   1259c:	03870713          	addi	a4,a4,56
   125a0:	00170593          	addi	a1,a4,1
   125a4:	00359593          	slli	a1,a1,0x3
   125a8:	00b605b3          	add	a1,a2,a1
   125ac:	ff858513          	addi	a0,a1,-8
   125b0:	0005a583          	lw	a1,0(a1)
   125b4:	08b51463          	bne	a0,a1,1263c <_free_r+0x244>
   125b8:	00100793          	li	a5,1
   125bc:	40275713          	srai	a4,a4,0x2
   125c0:	00e79733          	sll	a4,a5,a4
   125c4:	00462783          	lw	a5,4(a2)
   125c8:	00f76733          	or	a4,a4,a5
   125cc:	00e62223          	sw	a4,4(a2)
   125d0:	00a6a623          	sw	a0,12(a3)
   125d4:	00b6a423          	sw	a1,8(a3)
   125d8:	00d52423          	sw	a3,8(a0)
   125dc:	00d5a623          	sw	a3,12(a1)
   125e0:	eadff06f          	j	1248c <_free_r+0x94>
   125e4:	01400713          	li	a4,20
   125e8:	00b76663          	bltu	a4,a1,125f4 <_free_r+0x1fc>
   125ec:	05b58713          	addi	a4,a1,91
   125f0:	fb1ff06f          	j	125a0 <_free_r+0x1a8>
   125f4:	05400713          	li	a4,84
   125f8:	00b76863          	bltu	a4,a1,12608 <_free_r+0x210>
   125fc:	00c7d713          	srli	a4,a5,0xc
   12600:	06e70713          	addi	a4,a4,110
   12604:	f9dff06f          	j	125a0 <_free_r+0x1a8>
   12608:	15400713          	li	a4,340
   1260c:	00b76863          	bltu	a4,a1,1261c <_free_r+0x224>
   12610:	00f7d713          	srli	a4,a5,0xf
   12614:	07770713          	addi	a4,a4,119
   12618:	f89ff06f          	j	125a0 <_free_r+0x1a8>
   1261c:	55400513          	li	a0,1364
   12620:	07e00713          	li	a4,126
   12624:	f6b56ee3          	bltu	a0,a1,125a0 <_free_r+0x1a8>
   12628:	0127d713          	srli	a4,a5,0x12
   1262c:	07c70713          	addi	a4,a4,124
   12630:	f71ff06f          	j	125a0 <_free_r+0x1a8>
   12634:	0085a583          	lw	a1,8(a1)
   12638:	00b50863          	beq	a0,a1,12648 <_free_r+0x250>
   1263c:	0045a703          	lw	a4,4(a1)
   12640:	ffc77713          	andi	a4,a4,-4
   12644:	fee7e8e3          	bltu	a5,a4,12634 <_free_r+0x23c>
   12648:	00c5a503          	lw	a0,12(a1)
   1264c:	f85ff06f          	j	125d0 <_free_r+0x1d8>
   12650:	00008067          	ret

00012654 <_lseek_r>:
   12654:	ff010113          	addi	sp,sp,-16
   12658:	00812423          	sw	s0,8(sp)
   1265c:	00912223          	sw	s1,4(sp)
   12660:	00050493          	mv	s1,a0
   12664:	00058513          	mv	a0,a1
   12668:	00060593          	mv	a1,a2
   1266c:	00068613          	mv	a2,a3
   12670:	00112623          	sw	ra,12(sp)
   12674:	8601a823          	sw	zero,-1936(gp) # 14a08 <errno>
   12678:	4d8000ef          	jal	ra,12b50 <lseek>
   1267c:	fff00793          	li	a5,-1
   12680:	00f51863          	bne	a0,a5,12690 <_lseek_r+0x3c>
   12684:	8701a783          	lw	a5,-1936(gp) # 14a08 <errno>
   12688:	00078463          	beqz	a5,12690 <_lseek_r+0x3c>
   1268c:	00f4a023          	sw	a5,0(s1)
   12690:	00c12083          	lw	ra,12(sp)
   12694:	00812403          	lw	s0,8(sp)
   12698:	00412483          	lw	s1,4(sp)
   1269c:	01010113          	addi	sp,sp,16
   126a0:	00008067          	ret

000126a4 <__swhatbuf_r>:
   126a4:	fa010113          	addi	sp,sp,-96
   126a8:	04912a23          	sw	s1,84(sp)
   126ac:	00058493          	mv	s1,a1
   126b0:	00e59583          	lh	a1,14(a1)
   126b4:	04812c23          	sw	s0,88(sp)
   126b8:	04112e23          	sw	ra,92(sp)
   126bc:	00060413          	mv	s0,a2
   126c0:	0005de63          	bgez	a1,126dc <__swhatbuf_r+0x38>
   126c4:	00c4d783          	lhu	a5,12(s1)
   126c8:	0006a023          	sw	zero,0(a3)
   126cc:	0807f793          	andi	a5,a5,128
   126d0:	04079863          	bnez	a5,12720 <__swhatbuf_r+0x7c>
   126d4:	40000793          	li	a5,1024
   126d8:	04c0006f          	j	12724 <__swhatbuf_r+0x80>
   126dc:	01410613          	addi	a2,sp,20
   126e0:	00d12623          	sw	a3,12(sp)
   126e4:	2e8000ef          	jal	ra,129cc <_fstat_r>
   126e8:	00c12683          	lw	a3,12(sp)
   126ec:	fc054ce3          	bltz	a0,126c4 <__swhatbuf_r+0x20>
   126f0:	01812703          	lw	a4,24(sp)
   126f4:	0000f7b7          	lui	a5,0xf
   126f8:	00001537          	lui	a0,0x1
   126fc:	00e7f7b3          	and	a5,a5,a4
   12700:	ffffe737          	lui	a4,0xffffe
   12704:	00e787b3          	add	a5,a5,a4
   12708:	0017b793          	seqz	a5,a5
   1270c:	00f6a023          	sw	a5,0(a3)
   12710:	40000793          	li	a5,1024
   12714:	00f42023          	sw	a5,0(s0)
   12718:	80050513          	addi	a0,a0,-2048 # 800 <main-0xf874>
   1271c:	0100006f          	j	1272c <__swhatbuf_r+0x88>
   12720:	04000793          	li	a5,64
   12724:	00f42023          	sw	a5,0(s0)
   12728:	00000513          	li	a0,0
   1272c:	05c12083          	lw	ra,92(sp)
   12730:	05812403          	lw	s0,88(sp)
   12734:	05412483          	lw	s1,84(sp)
   12738:	06010113          	addi	sp,sp,96
   1273c:	00008067          	ret

00012740 <__smakebuf_r>:
   12740:	00c5d783          	lhu	a5,12(a1)
   12744:	fe010113          	addi	sp,sp,-32
   12748:	00812c23          	sw	s0,24(sp)
   1274c:	00112e23          	sw	ra,28(sp)
   12750:	00912a23          	sw	s1,20(sp)
   12754:	01212823          	sw	s2,16(sp)
   12758:	0027f793          	andi	a5,a5,2
   1275c:	00058413          	mv	s0,a1
   12760:	02078863          	beqz	a5,12790 <__smakebuf_r+0x50>
   12764:	04340793          	addi	a5,s0,67
   12768:	00f42023          	sw	a5,0(s0)
   1276c:	00f42823          	sw	a5,16(s0)
   12770:	00100793          	li	a5,1
   12774:	00f42a23          	sw	a5,20(s0)
   12778:	01c12083          	lw	ra,28(sp)
   1277c:	01812403          	lw	s0,24(sp)
   12780:	01412483          	lw	s1,20(sp)
   12784:	01012903          	lw	s2,16(sp)
   12788:	02010113          	addi	sp,sp,32
   1278c:	00008067          	ret
   12790:	00c10693          	addi	a3,sp,12
   12794:	00810613          	addi	a2,sp,8
   12798:	00050493          	mv	s1,a0
   1279c:	f09ff0ef          	jal	ra,126a4 <__swhatbuf_r>
   127a0:	00812583          	lw	a1,8(sp)
   127a4:	00050913          	mv	s2,a0
   127a8:	00048513          	mv	a0,s1
   127ac:	f7cfe0ef          	jal	ra,10f28 <_malloc_r>
   127b0:	02051063          	bnez	a0,127d0 <__smakebuf_r+0x90>
   127b4:	00c41783          	lh	a5,12(s0)
   127b8:	2007f713          	andi	a4,a5,512
   127bc:	fa071ee3          	bnez	a4,12778 <__smakebuf_r+0x38>
   127c0:	ffc7f793          	andi	a5,a5,-4
   127c4:	0027e793          	ori	a5,a5,2
   127c8:	00f41623          	sh	a5,12(s0)
   127cc:	f99ff06f          	j	12764 <__smakebuf_r+0x24>
   127d0:	000107b7          	lui	a5,0x10
   127d4:	6b078793          	addi	a5,a5,1712 # 106b0 <_cleanup_r>
   127d8:	02f4ae23          	sw	a5,60(s1)
   127dc:	00c45783          	lhu	a5,12(s0)
   127e0:	00a42023          	sw	a0,0(s0)
   127e4:	00a42823          	sw	a0,16(s0)
   127e8:	0807e793          	ori	a5,a5,128
   127ec:	00f41623          	sh	a5,12(s0)
   127f0:	00812783          	lw	a5,8(sp)
   127f4:	00f42a23          	sw	a5,20(s0)
   127f8:	00c12783          	lw	a5,12(sp)
   127fc:	02078263          	beqz	a5,12820 <__smakebuf_r+0xe0>
   12800:	00e41583          	lh	a1,14(s0)
   12804:	00048513          	mv	a0,s1
   12808:	210000ef          	jal	ra,12a18 <_isatty_r>
   1280c:	00050a63          	beqz	a0,12820 <__smakebuf_r+0xe0>
   12810:	00c45783          	lhu	a5,12(s0)
   12814:	ffc7f793          	andi	a5,a5,-4
   12818:	0017e793          	ori	a5,a5,1
   1281c:	00f41623          	sh	a5,12(s0)
   12820:	00c45783          	lhu	a5,12(s0)
   12824:	00f96933          	or	s2,s2,a5
   12828:	01241623          	sh	s2,12(s0)
   1282c:	f4dff06f          	j	12778 <__smakebuf_r+0x38>

00012830 <_read_r>:
   12830:	ff010113          	addi	sp,sp,-16
   12834:	00812423          	sw	s0,8(sp)
   12838:	00912223          	sw	s1,4(sp)
   1283c:	00050493          	mv	s1,a0
   12840:	00058513          	mv	a0,a1
   12844:	00060593          	mv	a1,a2
   12848:	00068613          	mv	a2,a3
   1284c:	00112623          	sw	ra,12(sp)
   12850:	8601a823          	sw	zero,-1936(gp) # 14a08 <errno>
   12854:	314000ef          	jal	ra,12b68 <read>
   12858:	fff00793          	li	a5,-1
   1285c:	00f51863          	bne	a0,a5,1286c <_read_r+0x3c>
   12860:	8701a783          	lw	a5,-1936(gp) # 14a08 <errno>
   12864:	00078463          	beqz	a5,1286c <_read_r+0x3c>
   12868:	00f4a023          	sw	a5,0(s1)
   1286c:	00c12083          	lw	ra,12(sp)
   12870:	00812403          	lw	s0,8(sp)
   12874:	00412483          	lw	s1,4(sp)
   12878:	01010113          	addi	sp,sp,16
   1287c:	00008067          	ret

00012880 <cleanup_glue>:
   12880:	ff010113          	addi	sp,sp,-16
   12884:	00812423          	sw	s0,8(sp)
   12888:	00058413          	mv	s0,a1
   1288c:	0005a583          	lw	a1,0(a1)
   12890:	00912223          	sw	s1,4(sp)
   12894:	00112623          	sw	ra,12(sp)
   12898:	00050493          	mv	s1,a0
   1289c:	00058463          	beqz	a1,128a4 <cleanup_glue+0x24>
   128a0:	fe1ff0ef          	jal	ra,12880 <cleanup_glue>
   128a4:	00040593          	mv	a1,s0
   128a8:	00812403          	lw	s0,8(sp)
   128ac:	00c12083          	lw	ra,12(sp)
   128b0:	00048513          	mv	a0,s1
   128b4:	00412483          	lw	s1,4(sp)
   128b8:	01010113          	addi	sp,sp,16
   128bc:	b3dff06f          	j	123f8 <_free_r>

000128c0 <_reclaim_reent>:
   128c0:	8081a783          	lw	a5,-2040(gp) # 149a0 <_impure_ptr>
   128c4:	10a78263          	beq	a5,a0,129c8 <_reclaim_reent+0x108>
   128c8:	04c52783          	lw	a5,76(a0)
   128cc:	fe010113          	addi	sp,sp,-32
   128d0:	00812c23          	sw	s0,24(sp)
   128d4:	00912a23          	sw	s1,20(sp)
   128d8:	01212823          	sw	s2,16(sp)
   128dc:	00112e23          	sw	ra,28(sp)
   128e0:	01312623          	sw	s3,12(sp)
   128e4:	00050413          	mv	s0,a0
   128e8:	00000493          	li	s1,0
   128ec:	08000913          	li	s2,128
   128f0:	04079463          	bnez	a5,12938 <_reclaim_reent+0x78>
   128f4:	04042583          	lw	a1,64(s0)
   128f8:	00058663          	beqz	a1,12904 <_reclaim_reent+0x44>
   128fc:	00040513          	mv	a0,s0
   12900:	af9ff0ef          	jal	ra,123f8 <_free_r>
   12904:	14842583          	lw	a1,328(s0)
   12908:	04058c63          	beqz	a1,12960 <_reclaim_reent+0xa0>
   1290c:	14c40493          	addi	s1,s0,332
   12910:	04958863          	beq	a1,s1,12960 <_reclaim_reent+0xa0>
   12914:	0005a903          	lw	s2,0(a1)
   12918:	00040513          	mv	a0,s0
   1291c:	addff0ef          	jal	ra,123f8 <_free_r>
   12920:	00090593          	mv	a1,s2
   12924:	fedff06f          	j	12910 <_reclaim_reent+0x50>
   12928:	009585b3          	add	a1,a1,s1
   1292c:	0005a583          	lw	a1,0(a1)
   12930:	00059e63          	bnez	a1,1294c <_reclaim_reent+0x8c>
   12934:	00448493          	addi	s1,s1,4
   12938:	04c42583          	lw	a1,76(s0)
   1293c:	ff2496e3          	bne	s1,s2,12928 <_reclaim_reent+0x68>
   12940:	00040513          	mv	a0,s0
   12944:	ab5ff0ef          	jal	ra,123f8 <_free_r>
   12948:	fadff06f          	j	128f4 <_reclaim_reent+0x34>
   1294c:	0005a983          	lw	s3,0(a1)
   12950:	00040513          	mv	a0,s0
   12954:	aa5ff0ef          	jal	ra,123f8 <_free_r>
   12958:	00098593          	mv	a1,s3
   1295c:	fd5ff06f          	j	12930 <_reclaim_reent+0x70>
   12960:	05442583          	lw	a1,84(s0)
   12964:	00058663          	beqz	a1,12970 <_reclaim_reent+0xb0>
   12968:	00040513          	mv	a0,s0
   1296c:	a8dff0ef          	jal	ra,123f8 <_free_r>
   12970:	03842783          	lw	a5,56(s0)
   12974:	02078c63          	beqz	a5,129ac <_reclaim_reent+0xec>
   12978:	03c42783          	lw	a5,60(s0)
   1297c:	00040513          	mv	a0,s0
   12980:	000780e7          	jalr	a5
   12984:	2e042583          	lw	a1,736(s0)
   12988:	02058263          	beqz	a1,129ac <_reclaim_reent+0xec>
   1298c:	00040513          	mv	a0,s0
   12990:	01812403          	lw	s0,24(sp)
   12994:	01c12083          	lw	ra,28(sp)
   12998:	01412483          	lw	s1,20(sp)
   1299c:	01012903          	lw	s2,16(sp)
   129a0:	00c12983          	lw	s3,12(sp)
   129a4:	02010113          	addi	sp,sp,32
   129a8:	ed9ff06f          	j	12880 <cleanup_glue>
   129ac:	01c12083          	lw	ra,28(sp)
   129b0:	01812403          	lw	s0,24(sp)
   129b4:	01412483          	lw	s1,20(sp)
   129b8:	01012903          	lw	s2,16(sp)
   129bc:	00c12983          	lw	s3,12(sp)
   129c0:	02010113          	addi	sp,sp,32
   129c4:	00008067          	ret
   129c8:	00008067          	ret

000129cc <_fstat_r>:
   129cc:	ff010113          	addi	sp,sp,-16
   129d0:	00812423          	sw	s0,8(sp)
   129d4:	00912223          	sw	s1,4(sp)
   129d8:	00050493          	mv	s1,a0
   129dc:	00058513          	mv	a0,a1
   129e0:	00060593          	mv	a1,a2
   129e4:	00112623          	sw	ra,12(sp)
   129e8:	8601a823          	sw	zero,-1936(gp) # 14a08 <errno>
   129ec:	1ac000ef          	jal	ra,12b98 <fstat>
   129f0:	fff00793          	li	a5,-1
   129f4:	00f51863          	bne	a0,a5,12a04 <_fstat_r+0x38>
   129f8:	8701a783          	lw	a5,-1936(gp) # 14a08 <errno>
   129fc:	00078463          	beqz	a5,12a04 <_fstat_r+0x38>
   12a00:	00f4a023          	sw	a5,0(s1)
   12a04:	00c12083          	lw	ra,12(sp)
   12a08:	00812403          	lw	s0,8(sp)
   12a0c:	00412483          	lw	s1,4(sp)
   12a10:	01010113          	addi	sp,sp,16
   12a14:	00008067          	ret

00012a18 <_isatty_r>:
   12a18:	ff010113          	addi	sp,sp,-16
   12a1c:	00812423          	sw	s0,8(sp)
   12a20:	00912223          	sw	s1,4(sp)
   12a24:	00050493          	mv	s1,a0
   12a28:	00058513          	mv	a0,a1
   12a2c:	00112623          	sw	ra,12(sp)
   12a30:	8601a823          	sw	zero,-1936(gp) # 14a08 <errno>
   12a34:	3c4000ef          	jal	ra,12df8 <isatty>
   12a38:	fff00793          	li	a5,-1
   12a3c:	00f51863          	bne	a0,a5,12a4c <_isatty_r+0x34>
   12a40:	8701a783          	lw	a5,-1936(gp) # 14a08 <errno>
   12a44:	00078463          	beqz	a5,12a4c <_isatty_r+0x34>
   12a48:	00f4a023          	sw	a5,0(s1)
   12a4c:	00c12083          	lw	ra,12(sp)
   12a50:	00812403          	lw	s0,8(sp)
   12a54:	00412483          	lw	s1,4(sp)
   12a58:	01010113          	addi	sp,sp,16
   12a5c:	00008067          	ret

00012a60 <conv_stat>:
   12a60:	0005a783          	lw	a5,0(a1)
   12a64:	00f51023          	sh	a5,0(a0)
   12a68:	0085a783          	lw	a5,8(a1)
   12a6c:	00f51123          	sh	a5,2(a0)
   12a70:	0105a783          	lw	a5,16(a1)
   12a74:	00f52223          	sw	a5,4(a0)
   12a78:	0145a783          	lw	a5,20(a1)
   12a7c:	00f51423          	sh	a5,8(a0)
   12a80:	0185a783          	lw	a5,24(a1)
   12a84:	00f51523          	sh	a5,10(a0)
   12a88:	01c5a783          	lw	a5,28(a1)
   12a8c:	00f51623          	sh	a5,12(a0)
   12a90:	0205a783          	lw	a5,32(a1)
   12a94:	00f51723          	sh	a5,14(a0)
   12a98:	0305a783          	lw	a5,48(a1)
   12a9c:	00f52823          	sw	a5,16(a0)
   12aa0:	0405a783          	lw	a5,64(a1)
   12aa4:	02f52823          	sw	a5,48(a0)
   12aa8:	0385a783          	lw	a5,56(a1)
   12aac:	02f52623          	sw	a5,44(a0)
   12ab0:	0485a783          	lw	a5,72(a1)
   12ab4:	00f52a23          	sw	a5,20(a0)
   12ab8:	0505a783          	lw	a5,80(a1)
   12abc:	00f52e23          	sw	a5,28(a0)
   12ac0:	0585a783          	lw	a5,88(a1)
   12ac4:	02f52223          	sw	a5,36(a0)
   12ac8:	00008067          	ret

00012acc <__syscall_error>:
   12acc:	ff010113          	addi	sp,sp,-16
   12ad0:	00812423          	sw	s0,8(sp)
   12ad4:	00112623          	sw	ra,12(sp)
   12ad8:	00050413          	mv	s0,a0
   12adc:	4f0000ef          	jal	ra,12fcc <__errno>
   12ae0:	408007b3          	neg	a5,s0
   12ae4:	00c12083          	lw	ra,12(sp)
   12ae8:	00812403          	lw	s0,8(sp)
   12aec:	00f52023          	sw	a5,0(a0)
   12af0:	fff00513          	li	a0,-1
   12af4:	01010113          	addi	sp,sp,16
   12af8:	00008067          	ret

00012afc <__internal_syscall>:
   12afc:	00050893          	mv	a7,a0
   12b00:	00058513          	mv	a0,a1
   12b04:	00060593          	mv	a1,a2
   12b08:	00068613          	mv	a2,a3
   12b0c:	00070693          	mv	a3,a4
   12b10:	00000073          	ecall
   12b14:	00055463          	bgez	a0,12b1c <__internal_syscall+0x20>
   12b18:	fb5ff06f          	j	12acc <__syscall_error>
   12b1c:	00008067          	ret

00012b20 <open>:
   12b20:	00060693          	mv	a3,a2
   12b24:	00000713          	li	a4,0
   12b28:	00058613          	mv	a2,a1
   12b2c:	00050593          	mv	a1,a0
   12b30:	40000513          	li	a0,1024
   12b34:	fc9ff06f          	j	12afc <__internal_syscall>

00012b38 <openat>:
   12b38:	00068713          	mv	a4,a3
   12b3c:	00060693          	mv	a3,a2
   12b40:	00058613          	mv	a2,a1
   12b44:	00050593          	mv	a1,a0
   12b48:	03800513          	li	a0,56
   12b4c:	fb1ff06f          	j	12afc <__internal_syscall>

00012b50 <lseek>:
   12b50:	00060693          	mv	a3,a2
   12b54:	00000713          	li	a4,0
   12b58:	00058613          	mv	a2,a1
   12b5c:	00050593          	mv	a1,a0
   12b60:	03e00513          	li	a0,62
   12b64:	f99ff06f          	j	12afc <__internal_syscall>

00012b68 <read>:
   12b68:	00060693          	mv	a3,a2
   12b6c:	00000713          	li	a4,0
   12b70:	00058613          	mv	a2,a1
   12b74:	00050593          	mv	a1,a0
   12b78:	03f00513          	li	a0,63
   12b7c:	f81ff06f          	j	12afc <__internal_syscall>

00012b80 <write>:
   12b80:	00060693          	mv	a3,a2
   12b84:	00000713          	li	a4,0
   12b88:	00058613          	mv	a2,a1
   12b8c:	00050593          	mv	a1,a0
   12b90:	04000513          	li	a0,64
   12b94:	f69ff06f          	j	12afc <__internal_syscall>

00012b98 <fstat>:
   12b98:	f8010113          	addi	sp,sp,-128
   12b9c:	06912a23          	sw	s1,116(sp)
   12ba0:	00810613          	addi	a2,sp,8
   12ba4:	00058493          	mv	s1,a1
   12ba8:	00000713          	li	a4,0
   12bac:	00050593          	mv	a1,a0
   12bb0:	00000693          	li	a3,0
   12bb4:	05000513          	li	a0,80
   12bb8:	06112e23          	sw	ra,124(sp)
   12bbc:	06812c23          	sw	s0,120(sp)
   12bc0:	f3dff0ef          	jal	ra,12afc <__internal_syscall>
   12bc4:	00050413          	mv	s0,a0
   12bc8:	00810593          	addi	a1,sp,8
   12bcc:	00048513          	mv	a0,s1
   12bd0:	e91ff0ef          	jal	ra,12a60 <conv_stat>
   12bd4:	00040513          	mv	a0,s0
   12bd8:	07c12083          	lw	ra,124(sp)
   12bdc:	07812403          	lw	s0,120(sp)
   12be0:	07412483          	lw	s1,116(sp)
   12be4:	08010113          	addi	sp,sp,128
   12be8:	00008067          	ret

00012bec <stat>:
   12bec:	f8010113          	addi	sp,sp,-128
   12bf0:	06912a23          	sw	s1,116(sp)
   12bf4:	00810613          	addi	a2,sp,8
   12bf8:	00058493          	mv	s1,a1
   12bfc:	00000713          	li	a4,0
   12c00:	00050593          	mv	a1,a0
   12c04:	00000693          	li	a3,0
   12c08:	40e00513          	li	a0,1038
   12c0c:	06112e23          	sw	ra,124(sp)
   12c10:	06812c23          	sw	s0,120(sp)
   12c14:	ee9ff0ef          	jal	ra,12afc <__internal_syscall>
   12c18:	00050413          	mv	s0,a0
   12c1c:	00810593          	addi	a1,sp,8
   12c20:	00048513          	mv	a0,s1
   12c24:	e3dff0ef          	jal	ra,12a60 <conv_stat>
   12c28:	00040513          	mv	a0,s0
   12c2c:	07c12083          	lw	ra,124(sp)
   12c30:	07812403          	lw	s0,120(sp)
   12c34:	07412483          	lw	s1,116(sp)
   12c38:	08010113          	addi	sp,sp,128
   12c3c:	00008067          	ret

00012c40 <lstat>:
   12c40:	f8010113          	addi	sp,sp,-128
   12c44:	06912a23          	sw	s1,116(sp)
   12c48:	00810613          	addi	a2,sp,8
   12c4c:	00058493          	mv	s1,a1
   12c50:	00000713          	li	a4,0
   12c54:	00050593          	mv	a1,a0
   12c58:	00000693          	li	a3,0
   12c5c:	40f00513          	li	a0,1039
   12c60:	06112e23          	sw	ra,124(sp)
   12c64:	06812c23          	sw	s0,120(sp)
   12c68:	e95ff0ef          	jal	ra,12afc <__internal_syscall>
   12c6c:	00050413          	mv	s0,a0
   12c70:	00810593          	addi	a1,sp,8
   12c74:	00048513          	mv	a0,s1
   12c78:	de9ff0ef          	jal	ra,12a60 <conv_stat>
   12c7c:	00040513          	mv	a0,s0
   12c80:	07c12083          	lw	ra,124(sp)
   12c84:	07812403          	lw	s0,120(sp)
   12c88:	07412483          	lw	s1,116(sp)
   12c8c:	08010113          	addi	sp,sp,128
   12c90:	00008067          	ret

00012c94 <fstatat>:
   12c94:	f8010113          	addi	sp,sp,-128
   12c98:	06912a23          	sw	s1,116(sp)
   12c9c:	00068713          	mv	a4,a3
   12ca0:	00060493          	mv	s1,a2
   12ca4:	00810693          	addi	a3,sp,8
   12ca8:	00058613          	mv	a2,a1
   12cac:	00050593          	mv	a1,a0
   12cb0:	04f00513          	li	a0,79
   12cb4:	06112e23          	sw	ra,124(sp)
   12cb8:	06812c23          	sw	s0,120(sp)
   12cbc:	e41ff0ef          	jal	ra,12afc <__internal_syscall>
   12cc0:	00050413          	mv	s0,a0
   12cc4:	00810593          	addi	a1,sp,8
   12cc8:	00048513          	mv	a0,s1
   12ccc:	d95ff0ef          	jal	ra,12a60 <conv_stat>
   12cd0:	00040513          	mv	a0,s0
   12cd4:	07c12083          	lw	ra,124(sp)
   12cd8:	07812403          	lw	s0,120(sp)
   12cdc:	07412483          	lw	s1,116(sp)
   12ce0:	08010113          	addi	sp,sp,128
   12ce4:	00008067          	ret

00012ce8 <access>:
   12ce8:	00058613          	mv	a2,a1
   12cec:	00000713          	li	a4,0
   12cf0:	00050593          	mv	a1,a0
   12cf4:	00000693          	li	a3,0
   12cf8:	40900513          	li	a0,1033
   12cfc:	e01ff06f          	j	12afc <__internal_syscall>

00012d00 <faccessat>:
   12d00:	00068713          	mv	a4,a3
   12d04:	00060693          	mv	a3,a2
   12d08:	00058613          	mv	a2,a1
   12d0c:	00050593          	mv	a1,a0
   12d10:	03000513          	li	a0,48
   12d14:	de9ff06f          	j	12afc <__internal_syscall>

00012d18 <close>:
   12d18:	00050593          	mv	a1,a0
   12d1c:	00000713          	li	a4,0
   12d20:	00000693          	li	a3,0
   12d24:	00000613          	li	a2,0
   12d28:	03900513          	li	a0,57
   12d2c:	dd1ff06f          	j	12afc <__internal_syscall>

00012d30 <link>:
   12d30:	00058613          	mv	a2,a1
   12d34:	00000713          	li	a4,0
   12d38:	00050593          	mv	a1,a0
   12d3c:	00000693          	li	a3,0
   12d40:	40100513          	li	a0,1025
   12d44:	db9ff06f          	j	12afc <__internal_syscall>

00012d48 <unlink>:
   12d48:	00050593          	mv	a1,a0
   12d4c:	00000713          	li	a4,0
   12d50:	00000693          	li	a3,0
   12d54:	00000613          	li	a2,0
   12d58:	40200513          	li	a0,1026
   12d5c:	da1ff06f          	j	12afc <__internal_syscall>

00012d60 <execve>:
   12d60:	ff010113          	addi	sp,sp,-16
   12d64:	00112623          	sw	ra,12(sp)
   12d68:	264000ef          	jal	ra,12fcc <__errno>
   12d6c:	00c12083          	lw	ra,12(sp)
   12d70:	00c00793          	li	a5,12
   12d74:	00f52023          	sw	a5,0(a0)
   12d78:	fff00513          	li	a0,-1
   12d7c:	01010113          	addi	sp,sp,16
   12d80:	00008067          	ret

00012d84 <fork>:
   12d84:	ff010113          	addi	sp,sp,-16
   12d88:	00112623          	sw	ra,12(sp)
   12d8c:	240000ef          	jal	ra,12fcc <__errno>
   12d90:	00c12083          	lw	ra,12(sp)
   12d94:	00b00793          	li	a5,11
   12d98:	00f52023          	sw	a5,0(a0)
   12d9c:	fff00513          	li	a0,-1
   12da0:	01010113          	addi	sp,sp,16
   12da4:	00008067          	ret

00012da8 <getpid>:
   12da8:	00100513          	li	a0,1
   12dac:	00008067          	ret

00012db0 <kill>:
   12db0:	ff010113          	addi	sp,sp,-16
   12db4:	00112623          	sw	ra,12(sp)
   12db8:	214000ef          	jal	ra,12fcc <__errno>
   12dbc:	00c12083          	lw	ra,12(sp)
   12dc0:	01600793          	li	a5,22
   12dc4:	00f52023          	sw	a5,0(a0)
   12dc8:	fff00513          	li	a0,-1
   12dcc:	01010113          	addi	sp,sp,16
   12dd0:	00008067          	ret

00012dd4 <wait>:
   12dd4:	ff010113          	addi	sp,sp,-16
   12dd8:	00112623          	sw	ra,12(sp)
   12ddc:	1f0000ef          	jal	ra,12fcc <__errno>
   12de0:	00c12083          	lw	ra,12(sp)
   12de4:	00a00793          	li	a5,10
   12de8:	00f52023          	sw	a5,0(a0)
   12dec:	fff00513          	li	a0,-1
   12df0:	01010113          	addi	sp,sp,16
   12df4:	00008067          	ret

00012df8 <isatty>:
   12df8:	fb010113          	addi	sp,sp,-80
   12dfc:	00410593          	addi	a1,sp,4
   12e00:	04112623          	sw	ra,76(sp)
   12e04:	d95ff0ef          	jal	ra,12b98 <fstat>
   12e08:	fff00793          	li	a5,-1
   12e0c:	00f50863          	beq	a0,a5,12e1c <isatty+0x24>
   12e10:	00812503          	lw	a0,8(sp)
   12e14:	00d55513          	srli	a0,a0,0xd
   12e18:	00157513          	andi	a0,a0,1
   12e1c:	04c12083          	lw	ra,76(sp)
   12e20:	05010113          	addi	sp,sp,80
   12e24:	00008067          	ret

00012e28 <gettimeofday>:
   12e28:	00050593          	mv	a1,a0
   12e2c:	00000713          	li	a4,0
   12e30:	00000693          	li	a3,0
   12e34:	00000613          	li	a2,0
   12e38:	0a900513          	li	a0,169
   12e3c:	cc1ff06f          	j	12afc <__internal_syscall>

00012e40 <times>:
   12e40:	fe010113          	addi	sp,sp,-32
   12e44:	00812c23          	sw	s0,24(sp)
   12e48:	00050413          	mv	s0,a0
   12e4c:	8241a783          	lw	a5,-2012(gp) # 149bc <t0.2536>
   12e50:	00912a23          	sw	s1,20(sp)
   12e54:	00112e23          	sw	ra,28(sp)
   12e58:	82418493          	addi	s1,gp,-2012 # 149bc <t0.2536>
   12e5c:	00079863          	bnez	a5,12e6c <times+0x2c>
   12e60:	00000593          	li	a1,0
   12e64:	82418513          	addi	a0,gp,-2012 # 149bc <t0.2536>
   12e68:	fc1ff0ef          	jal	ra,12e28 <gettimeofday>
   12e6c:	00000593          	li	a1,0
   12e70:	00810513          	addi	a0,sp,8
   12e74:	fb5ff0ef          	jal	ra,12e28 <gettimeofday>
   12e78:	0004a783          	lw	a5,0(s1)
   12e7c:	00812503          	lw	a0,8(sp)
   12e80:	000f45b7          	lui	a1,0xf4
   12e84:	24058593          	addi	a1,a1,576 # f4240 <__global_pointer$+0xdf0a8>
   12e88:	40f50533          	sub	a0,a0,a5
   12e8c:	148000ef          	jal	ra,12fd4 <__mulsi3>
   12e90:	0044a703          	lw	a4,4(s1)
   12e94:	00c12783          	lw	a5,12(sp)
   12e98:	00042423          	sw	zero,8(s0)
   12e9c:	00042623          	sw	zero,12(s0)
   12ea0:	40e787b3          	sub	a5,a5,a4
   12ea4:	00f50533          	add	a0,a0,a5
   12ea8:	00a42023          	sw	a0,0(s0)
   12eac:	00042223          	sw	zero,4(s0)
   12eb0:	01c12083          	lw	ra,28(sp)
   12eb4:	01812403          	lw	s0,24(sp)
   12eb8:	01412483          	lw	s1,20(sp)
   12ebc:	fff00513          	li	a0,-1
   12ec0:	02010113          	addi	sp,sp,32
   12ec4:	00008067          	ret

00012ec8 <ftime>:
   12ec8:	00051223          	sh	zero,4(a0)
   12ecc:	00052023          	sw	zero,0(a0)
   12ed0:	00000513          	li	a0,0
   12ed4:	00008067          	ret

00012ed8 <utime>:
   12ed8:	fff00513          	li	a0,-1
   12edc:	00008067          	ret

00012ee0 <chown>:
   12ee0:	fff00513          	li	a0,-1
   12ee4:	00008067          	ret

00012ee8 <chmod>:
   12ee8:	fff00513          	li	a0,-1
   12eec:	00008067          	ret

00012ef0 <chdir>:
   12ef0:	fff00513          	li	a0,-1
   12ef4:	00008067          	ret

00012ef8 <getcwd>:
   12ef8:	00000513          	li	a0,0
   12efc:	00008067          	ret

00012f00 <sysconf>:
   12f00:	00200793          	li	a5,2
   12f04:	00f50663          	beq	a0,a5,12f10 <sysconf+0x10>
   12f08:	fff00513          	li	a0,-1
   12f0c:	00008067          	ret
   12f10:	000f4537          	lui	a0,0xf4
   12f14:	24050513          	addi	a0,a0,576 # f4240 <__global_pointer$+0xdf0a8>
   12f18:	00008067          	ret

00012f1c <sbrk>:
   12f1c:	ff010113          	addi	sp,sp,-16
   12f20:	00812423          	sw	s0,8(sp)
   12f24:	8201a783          	lw	a5,-2016(gp) # 149b8 <heap_end.2573>
   12f28:	00912223          	sw	s1,4(sp)
   12f2c:	00112623          	sw	ra,12(sp)
   12f30:	00050493          	mv	s1,a0
   12f34:	04079063          	bnez	a5,12f74 <sbrk+0x58>
   12f38:	00000713          	li	a4,0
   12f3c:	00000693          	li	a3,0
   12f40:	00000613          	li	a2,0
   12f44:	00000593          	li	a1,0
   12f48:	0d600513          	li	a0,214
   12f4c:	bb1ff0ef          	jal	ra,12afc <__internal_syscall>
   12f50:	fff00793          	li	a5,-1
   12f54:	00f51e63          	bne	a0,a5,12f70 <sbrk+0x54>
   12f58:	fff00513          	li	a0,-1
   12f5c:	00c12083          	lw	ra,12(sp)
   12f60:	00812403          	lw	s0,8(sp)
   12f64:	00412483          	lw	s1,4(sp)
   12f68:	01010113          	addi	sp,sp,16
   12f6c:	00008067          	ret
   12f70:	82a1a023          	sw	a0,-2016(gp) # 149b8 <heap_end.2573>
   12f74:	8201a583          	lw	a1,-2016(gp) # 149b8 <heap_end.2573>
   12f78:	00000713          	li	a4,0
   12f7c:	00000693          	li	a3,0
   12f80:	00b485b3          	add	a1,s1,a1
   12f84:	00000613          	li	a2,0
   12f88:	0d600513          	li	a0,214
   12f8c:	b71ff0ef          	jal	ra,12afc <__internal_syscall>
   12f90:	8201a783          	lw	a5,-2016(gp) # 149b8 <heap_end.2573>
   12f94:	00f484b3          	add	s1,s1,a5
   12f98:	fc9510e3          	bne	a0,s1,12f58 <sbrk+0x3c>
   12f9c:	82a1a023          	sw	a0,-2016(gp) # 149b8 <heap_end.2573>
   12fa0:	00078513          	mv	a0,a5
   12fa4:	fb9ff06f          	j	12f5c <sbrk+0x40>

00012fa8 <_exit>:
   12fa8:	ff010113          	addi	sp,sp,-16
   12fac:	00050593          	mv	a1,a0
   12fb0:	00000713          	li	a4,0
   12fb4:	00000693          	li	a3,0
   12fb8:	00000613          	li	a2,0
   12fbc:	05d00513          	li	a0,93
   12fc0:	00112623          	sw	ra,12(sp)
   12fc4:	b39ff0ef          	jal	ra,12afc <__internal_syscall>
   12fc8:	0000006f          	j	12fc8 <_exit+0x20>

00012fcc <__errno>:
   12fcc:	8081a503          	lw	a0,-2040(gp) # 149a0 <_impure_ptr>
   12fd0:	00008067          	ret

00012fd4 <__mulsi3>:
   12fd4:	00050613          	mv	a2,a0
   12fd8:	00000513          	li	a0,0
   12fdc:	0015f693          	andi	a3,a1,1
   12fe0:	00068463          	beqz	a3,12fe8 <__mulsi3+0x14>
   12fe4:	00c50533          	add	a0,a0,a2
   12fe8:	0015d593          	srli	a1,a1,0x1
   12fec:	00161613          	slli	a2,a2,0x1
   12ff0:	fe0596e3          	bnez	a1,12fdc <__mulsi3+0x8>
   12ff4:	00008067          	ret

00012ff8 <__divsi3>:
   12ff8:	06054063          	bltz	a0,13058 <__umodsi3+0x10>
   12ffc:	0605c663          	bltz	a1,13068 <__umodsi3+0x20>

00013000 <__udivsi3>:
   13000:	00058613          	mv	a2,a1
   13004:	00050593          	mv	a1,a0
   13008:	fff00513          	li	a0,-1
   1300c:	02060c63          	beqz	a2,13044 <__udivsi3+0x44>
   13010:	00100693          	li	a3,1
   13014:	00b67a63          	bleu	a1,a2,13028 <__udivsi3+0x28>
   13018:	00c05863          	blez	a2,13028 <__udivsi3+0x28>
   1301c:	00161613          	slli	a2,a2,0x1
   13020:	00169693          	slli	a3,a3,0x1
   13024:	feb66ae3          	bltu	a2,a1,13018 <__udivsi3+0x18>
   13028:	00000513          	li	a0,0
   1302c:	00c5e663          	bltu	a1,a2,13038 <__udivsi3+0x38>
   13030:	40c585b3          	sub	a1,a1,a2
   13034:	00d56533          	or	a0,a0,a3
   13038:	0016d693          	srli	a3,a3,0x1
   1303c:	00165613          	srli	a2,a2,0x1
   13040:	fe0696e3          	bnez	a3,1302c <__udivsi3+0x2c>
   13044:	00008067          	ret

00013048 <__umodsi3>:
   13048:	00008293          	mv	t0,ra
   1304c:	fb5ff0ef          	jal	ra,13000 <__udivsi3>
   13050:	00058513          	mv	a0,a1
   13054:	00028067          	jr	t0
   13058:	40a00533          	neg	a0,a0
   1305c:	0005d863          	bgez	a1,1306c <__umodsi3+0x24>
   13060:	40b005b3          	neg	a1,a1
   13064:	f9dff06f          	j	13000 <__udivsi3>
   13068:	40b005b3          	neg	a1,a1
   1306c:	00008293          	mv	t0,ra
   13070:	f91ff0ef          	jal	ra,13000 <__udivsi3>
   13074:	40a00533          	neg	a0,a0
   13078:	00028067          	jr	t0

0001307c <__modsi3>:
   1307c:	00008293          	mv	t0,ra
   13080:	0005ca63          	bltz	a1,13094 <__modsi3+0x18>
   13084:	00054c63          	bltz	a0,1309c <__modsi3+0x20>
   13088:	f79ff0ef          	jal	ra,13000 <__udivsi3>
   1308c:	00058513          	mv	a0,a1
   13090:	00028067          	jr	t0
   13094:	40b005b3          	neg	a1,a1
   13098:	fe0558e3          	bgez	a0,13088 <__modsi3+0xc>
   1309c:	40a00533          	neg	a0,a0
   130a0:	f61ff0ef          	jal	ra,13000 <__udivsi3>
   130a4:	40b00533          	neg	a0,a1
   130a8:	00028067          	jr	t0

Disassembly of section .rodata:

000130ac <.rodata>:
   130ac:	7242                	flw	ft4,48(sp)
   130ae:	6165                	addi	sp,sp,112
   130b0:	696f706b          	0x696f706b
   130b4:	746e                	flw	fs0,248(sp)
   130b6:	7420                	flw	fs0,104(s0)
   130b8:	7365                	lui	t1,0xffff9
   130ba:	0074                	addi	a3,sp,12
   130bc:	6649                	lui	a2,0x12
   130be:	7920                	flw	fs0,112(a0)
   130c0:	6820756f          	jal	a0,1a742 <__global_pointer$+0x55aa>
   130c4:	7661                	lui	a2,0xffff8
   130c6:	2065                	jal	1316e <__FRAME_END__+0x16>
   130c8:	2061                	jal	13150 <__EH_FRAME_BEGIN__+0x38>
   130ca:	6564                	flw	fs1,76(a0)
   130cc:	7562                	flw	fa0,56(sp)
   130ce:	72656767          	0x72656767
   130d2:	6120                	flw	fs0,64(a0)
   130d4:	7474                	flw	fa3,108(s0)
   130d6:	6361                	lui	t1,0x18
   130d8:	6568                	flw	fa0,76(a0)
   130da:	2c64                	fld	fs1,216(s0)
   130dc:	6920                	flw	fs0,80(a0)
   130de:	2074                	fld	fa3,192(s0)
   130e0:	756f6873          	csrrsi	a6,0x756,30
   130e4:	646c                	flw	fa1,76(s0)
   130e6:	7320                	flw	fs0,96(a4)
   130e8:	6f74                	flw	fa3,92(a4)
   130ea:	2070                	fld	fa2,192(s0)
   130ec:	7461                	lui	s0,0xffff8
   130ee:	7420                	flw	fs0,104(s0)
   130f0:	6568                	flw	fa0,76(a0)
   130f2:	6620                	flw	fs0,72(a2)
   130f4:	6f6c6c6f          	jal	s8,d97ea <__global_pointer$+0xc4652>
   130f8:	676e6977          	0x676e6977
   130fc:	6c20                	flw	fs0,88(s0)
   130fe:	6e69                	lui	t3,0x1a
   13100:	2e65                	jal	134b8 <__FRAME_END__+0x360>
   13102:	0000                	unimp
   13104:	6554                	flw	fa3,12(a0)
   13106:	63207473          	csrrci	s0,0x632,0
   1310a:	6c706d6f          	jal	s10,19fd0 <__global_pointer$+0x4e38>
   1310e:	7465                	lui	s0,0xffff9
   13110:	6465                	lui	s0,0x19
   13112:	002e                	0x2e
   13114:	000a                	0xa
	...

Disassembly of section .eh_frame:

00013118 <__EH_FRAME_BEGIN__>:
   13118:	0010                	addi	a2,sp,0
   1311a:	0000                	unimp
   1311c:	0000                	unimp
   1311e:	0000                	unimp
   13120:	00527a03          	0x527a03
   13124:	7c01                	lui	s8,0xfffe0
   13126:	0101                	addi	sp,sp,0
   13128:	00020c1b          	0x20c1b
   1312c:	0028                	addi	a0,sp,8
   1312e:	0000                	unimp
   13130:	0018                	addi	a4,sp,0
   13132:	0000                	unimp
   13134:	cf40                	sw	s0,28(a4)
   13136:	ffff                	0xffff
   13138:	0040                	addi	s0,sp,4
   1313a:	0000                	unimp
   1313c:	0400                	addi	s0,sp,512
   1313e:	0008                	addi	a0,sp,0
   13140:	0000                	unimp
   13142:	100e                	0x100e
   13144:	0804                	addi	s1,sp,16
   13146:	0000                	unimp
   13148:	8100                	0x8100
   1314a:	0401                	addi	s0,s0,0
   1314c:	0024                	addi	s1,sp,8
   1314e:	0000                	unimp
   13150:	04c1                	addi	s1,s1,16
   13152:	0008                	addi	a0,sp,0
   13154:	0000                	unimp
   13156:	000e                	0xe

00013158 <__FRAME_END__>:
   13158:	0000                	unimp
	...

Disassembly of section .init_array:

0001415c <__frame_dummy_init_array_entry>:
   1415c:	01c0                	addi	s0,sp,196
   1415e:	0001                	nop

Disassembly of section .fini_array:

00014160 <__do_global_dtors_aux_fini_array_entry>:
   14160:	016c                	addi	a1,sp,140
   14162:	0001                	nop

Disassembly of section .data:

00014168 <impure_data>:
   14168:	0000                	unimp
   1416a:	0000                	unimp
   1416c:	4454                	lw	a3,12(s0)
   1416e:	0001                	nop
   14170:	44bc                	lw	a5,72(s1)
   14172:	0001                	nop
   14174:	4524                	lw	s1,72(a0)
   14176:	0001                	nop
	...
   14210:	0001                	nop
   14212:	0000                	unimp
   14214:	0000                	unimp
   14216:	0000                	unimp
   14218:	330e                	fld	ft6,224(sp)
   1421a:	abcd                	j	1480c <__malloc_av_+0x27c>
   1421c:	1234                	addi	a3,sp,296
   1421e:	e66d                	bnez	a2,14308 <impure_data+0x1a0>
   14220:	deec                	sw	a1,124(a3)
   14222:	0005                	c.addi	zero,1
   14224:	0000000b          	0xb
	...

00014590 <__malloc_av_>:
	...
   14598:	4590                	lw	a2,8(a1)
   1459a:	0001                	nop
   1459c:	4590                	lw	a2,8(a1)
   1459e:	0001                	nop
   145a0:	4598                	lw	a4,8(a1)
   145a2:	0001                	nop
   145a4:	4598                	lw	a4,8(a1)
   145a6:	0001                	nop
   145a8:	45a0                	lw	s0,72(a1)
   145aa:	0001                	nop
   145ac:	45a0                	lw	s0,72(a1)
   145ae:	0001                	nop
   145b0:	45a8                	lw	a0,72(a1)
   145b2:	0001                	nop
   145b4:	45a8                	lw	a0,72(a1)
   145b6:	0001                	nop
   145b8:	45b0                	lw	a2,72(a1)
   145ba:	0001                	nop
   145bc:	45b0                	lw	a2,72(a1)
   145be:	0001                	nop
   145c0:	45b8                	lw	a4,72(a1)
   145c2:	0001                	nop
   145c4:	45b8                	lw	a4,72(a1)
   145c6:	0001                	nop
   145c8:	45c0                	lw	s0,12(a1)
   145ca:	0001                	nop
   145cc:	45c0                	lw	s0,12(a1)
   145ce:	0001                	nop
   145d0:	45c8                	lw	a0,12(a1)
   145d2:	0001                	nop
   145d4:	45c8                	lw	a0,12(a1)
   145d6:	0001                	nop
   145d8:	45d0                	lw	a2,12(a1)
   145da:	0001                	nop
   145dc:	45d0                	lw	a2,12(a1)
   145de:	0001                	nop
   145e0:	45d8                	lw	a4,12(a1)
   145e2:	0001                	nop
   145e4:	45d8                	lw	a4,12(a1)
   145e6:	0001                	nop
   145e8:	45e0                	lw	s0,76(a1)
   145ea:	0001                	nop
   145ec:	45e0                	lw	s0,76(a1)
   145ee:	0001                	nop
   145f0:	45e8                	lw	a0,76(a1)
   145f2:	0001                	nop
   145f4:	45e8                	lw	a0,76(a1)
   145f6:	0001                	nop
   145f8:	45f0                	lw	a2,76(a1)
   145fa:	0001                	nop
   145fc:	45f0                	lw	a2,76(a1)
   145fe:	0001                	nop
   14600:	45f8                	lw	a4,76(a1)
   14602:	0001                	nop
   14604:	45f8                	lw	a4,76(a1)
   14606:	0001                	nop
   14608:	4600                	lw	s0,8(a2)
   1460a:	0001                	nop
   1460c:	4600                	lw	s0,8(a2)
   1460e:	0001                	nop
   14610:	4608                	lw	a0,8(a2)
   14612:	0001                	nop
   14614:	4608                	lw	a0,8(a2)
   14616:	0001                	nop
   14618:	4610                	lw	a2,8(a2)
   1461a:	0001                	nop
   1461c:	4610                	lw	a2,8(a2)
   1461e:	0001                	nop
   14620:	4618                	lw	a4,8(a2)
   14622:	0001                	nop
   14624:	4618                	lw	a4,8(a2)
   14626:	0001                	nop
   14628:	4620                	lw	s0,72(a2)
   1462a:	0001                	nop
   1462c:	4620                	lw	s0,72(a2)
   1462e:	0001                	nop
   14630:	4628                	lw	a0,72(a2)
   14632:	0001                	nop
   14634:	4628                	lw	a0,72(a2)
   14636:	0001                	nop
   14638:	4630                	lw	a2,72(a2)
   1463a:	0001                	nop
   1463c:	4630                	lw	a2,72(a2)
   1463e:	0001                	nop
   14640:	4638                	lw	a4,72(a2)
   14642:	0001                	nop
   14644:	4638                	lw	a4,72(a2)
   14646:	0001                	nop
   14648:	4640                	lw	s0,12(a2)
   1464a:	0001                	nop
   1464c:	4640                	lw	s0,12(a2)
   1464e:	0001                	nop
   14650:	4648                	lw	a0,12(a2)
   14652:	0001                	nop
   14654:	4648                	lw	a0,12(a2)
   14656:	0001                	nop
   14658:	4650                	lw	a2,12(a2)
   1465a:	0001                	nop
   1465c:	4650                	lw	a2,12(a2)
   1465e:	0001                	nop
   14660:	4658                	lw	a4,12(a2)
   14662:	0001                	nop
   14664:	4658                	lw	a4,12(a2)
   14666:	0001                	nop
   14668:	4660                	lw	s0,76(a2)
   1466a:	0001                	nop
   1466c:	4660                	lw	s0,76(a2)
   1466e:	0001                	nop
   14670:	4668                	lw	a0,76(a2)
   14672:	0001                	nop
   14674:	4668                	lw	a0,76(a2)
   14676:	0001                	nop
   14678:	4670                	lw	a2,76(a2)
   1467a:	0001                	nop
   1467c:	4670                	lw	a2,76(a2)
   1467e:	0001                	nop
   14680:	4678                	lw	a4,76(a2)
   14682:	0001                	nop
   14684:	4678                	lw	a4,76(a2)
   14686:	0001                	nop
   14688:	4680                	lw	s0,8(a3)
   1468a:	0001                	nop
   1468c:	4680                	lw	s0,8(a3)
   1468e:	0001                	nop
   14690:	4688                	lw	a0,8(a3)
   14692:	0001                	nop
   14694:	4688                	lw	a0,8(a3)
   14696:	0001                	nop
   14698:	4690                	lw	a2,8(a3)
   1469a:	0001                	nop
   1469c:	4690                	lw	a2,8(a3)
   1469e:	0001                	nop
   146a0:	4698                	lw	a4,8(a3)
   146a2:	0001                	nop
   146a4:	4698                	lw	a4,8(a3)
   146a6:	0001                	nop
   146a8:	46a0                	lw	s0,72(a3)
   146aa:	0001                	nop
   146ac:	46a0                	lw	s0,72(a3)
   146ae:	0001                	nop
   146b0:	46a8                	lw	a0,72(a3)
   146b2:	0001                	nop
   146b4:	46a8                	lw	a0,72(a3)
   146b6:	0001                	nop
   146b8:	46b0                	lw	a2,72(a3)
   146ba:	0001                	nop
   146bc:	46b0                	lw	a2,72(a3)
   146be:	0001                	nop
   146c0:	46b8                	lw	a4,72(a3)
   146c2:	0001                	nop
   146c4:	46b8                	lw	a4,72(a3)
   146c6:	0001                	nop
   146c8:	46c0                	lw	s0,12(a3)
   146ca:	0001                	nop
   146cc:	46c0                	lw	s0,12(a3)
   146ce:	0001                	nop
   146d0:	46c8                	lw	a0,12(a3)
   146d2:	0001                	nop
   146d4:	46c8                	lw	a0,12(a3)
   146d6:	0001                	nop
   146d8:	46d0                	lw	a2,12(a3)
   146da:	0001                	nop
   146dc:	46d0                	lw	a2,12(a3)
   146de:	0001                	nop
   146e0:	46d8                	lw	a4,12(a3)
   146e2:	0001                	nop
   146e4:	46d8                	lw	a4,12(a3)
   146e6:	0001                	nop
   146e8:	46e0                	lw	s0,76(a3)
   146ea:	0001                	nop
   146ec:	46e0                	lw	s0,76(a3)
   146ee:	0001                	nop
   146f0:	46e8                	lw	a0,76(a3)
   146f2:	0001                	nop
   146f4:	46e8                	lw	a0,76(a3)
   146f6:	0001                	nop
   146f8:	46f0                	lw	a2,76(a3)
   146fa:	0001                	nop
   146fc:	46f0                	lw	a2,76(a3)
   146fe:	0001                	nop
   14700:	46f8                	lw	a4,76(a3)
   14702:	0001                	nop
   14704:	46f8                	lw	a4,76(a3)
   14706:	0001                	nop
   14708:	4700                	lw	s0,8(a4)
   1470a:	0001                	nop
   1470c:	4700                	lw	s0,8(a4)
   1470e:	0001                	nop
   14710:	4708                	lw	a0,8(a4)
   14712:	0001                	nop
   14714:	4708                	lw	a0,8(a4)
   14716:	0001                	nop
   14718:	4710                	lw	a2,8(a4)
   1471a:	0001                	nop
   1471c:	4710                	lw	a2,8(a4)
   1471e:	0001                	nop
   14720:	4718                	lw	a4,8(a4)
   14722:	0001                	nop
   14724:	4718                	lw	a4,8(a4)
   14726:	0001                	nop
   14728:	4720                	lw	s0,72(a4)
   1472a:	0001                	nop
   1472c:	4720                	lw	s0,72(a4)
   1472e:	0001                	nop
   14730:	4728                	lw	a0,72(a4)
   14732:	0001                	nop
   14734:	4728                	lw	a0,72(a4)
   14736:	0001                	nop
   14738:	4730                	lw	a2,72(a4)
   1473a:	0001                	nop
   1473c:	4730                	lw	a2,72(a4)
   1473e:	0001                	nop
   14740:	4738                	lw	a4,72(a4)
   14742:	0001                	nop
   14744:	4738                	lw	a4,72(a4)
   14746:	0001                	nop
   14748:	4740                	lw	s0,12(a4)
   1474a:	0001                	nop
   1474c:	4740                	lw	s0,12(a4)
   1474e:	0001                	nop
   14750:	4748                	lw	a0,12(a4)
   14752:	0001                	nop
   14754:	4748                	lw	a0,12(a4)
   14756:	0001                	nop
   14758:	4750                	lw	a2,12(a4)
   1475a:	0001                	nop
   1475c:	4750                	lw	a2,12(a4)
   1475e:	0001                	nop
   14760:	4758                	lw	a4,12(a4)
   14762:	0001                	nop
   14764:	4758                	lw	a4,12(a4)
   14766:	0001                	nop
   14768:	4760                	lw	s0,76(a4)
   1476a:	0001                	nop
   1476c:	4760                	lw	s0,76(a4)
   1476e:	0001                	nop
   14770:	4768                	lw	a0,76(a4)
   14772:	0001                	nop
   14774:	4768                	lw	a0,76(a4)
   14776:	0001                	nop
   14778:	4770                	lw	a2,76(a4)
   1477a:	0001                	nop
   1477c:	4770                	lw	a2,76(a4)
   1477e:	0001                	nop
   14780:	4778                	lw	a4,76(a4)
   14782:	0001                	nop
   14784:	4778                	lw	a4,76(a4)
   14786:	0001                	nop
   14788:	4780                	lw	s0,8(a5)
   1478a:	0001                	nop
   1478c:	4780                	lw	s0,8(a5)
   1478e:	0001                	nop
   14790:	4788                	lw	a0,8(a5)
   14792:	0001                	nop
   14794:	4788                	lw	a0,8(a5)
   14796:	0001                	nop
   14798:	4790                	lw	a2,8(a5)
   1479a:	0001                	nop
   1479c:	4790                	lw	a2,8(a5)
   1479e:	0001                	nop
   147a0:	4798                	lw	a4,8(a5)
   147a2:	0001                	nop
   147a4:	4798                	lw	a4,8(a5)
   147a6:	0001                	nop
   147a8:	47a0                	lw	s0,72(a5)
   147aa:	0001                	nop
   147ac:	47a0                	lw	s0,72(a5)
   147ae:	0001                	nop
   147b0:	47a8                	lw	a0,72(a5)
   147b2:	0001                	nop
   147b4:	47a8                	lw	a0,72(a5)
   147b6:	0001                	nop
   147b8:	47b0                	lw	a2,72(a5)
   147ba:	0001                	nop
   147bc:	47b0                	lw	a2,72(a5)
   147be:	0001                	nop
   147c0:	47b8                	lw	a4,72(a5)
   147c2:	0001                	nop
   147c4:	47b8                	lw	a4,72(a5)
   147c6:	0001                	nop
   147c8:	47c0                	lw	s0,12(a5)
   147ca:	0001                	nop
   147cc:	47c0                	lw	s0,12(a5)
   147ce:	0001                	nop
   147d0:	47c8                	lw	a0,12(a5)
   147d2:	0001                	nop
   147d4:	47c8                	lw	a0,12(a5)
   147d6:	0001                	nop
   147d8:	47d0                	lw	a2,12(a5)
   147da:	0001                	nop
   147dc:	47d0                	lw	a2,12(a5)
   147de:	0001                	nop
   147e0:	47d8                	lw	a4,12(a5)
   147e2:	0001                	nop
   147e4:	47d8                	lw	a4,12(a5)
   147e6:	0001                	nop
   147e8:	47e0                	lw	s0,76(a5)
   147ea:	0001                	nop
   147ec:	47e0                	lw	s0,76(a5)
   147ee:	0001                	nop
   147f0:	47e8                	lw	a0,76(a5)
   147f2:	0001                	nop
   147f4:	47e8                	lw	a0,76(a5)
   147f6:	0001                	nop
   147f8:	47f0                	lw	a2,76(a5)
   147fa:	0001                	nop
   147fc:	47f0                	lw	a2,76(a5)
   147fe:	0001                	nop
   14800:	47f8                	lw	a4,76(a5)
   14802:	0001                	nop
   14804:	47f8                	lw	a4,76(a5)
   14806:	0001                	nop
   14808:	4800                	lw	s0,16(s0)
   1480a:	0001                	nop
   1480c:	4800                	lw	s0,16(s0)
   1480e:	0001                	nop
   14810:	4808                	lw	a0,16(s0)
   14812:	0001                	nop
   14814:	4808                	lw	a0,16(s0)
   14816:	0001                	nop
   14818:	4810                	lw	a2,16(s0)
   1481a:	0001                	nop
   1481c:	4810                	lw	a2,16(s0)
   1481e:	0001                	nop
   14820:	4818                	lw	a4,16(s0)
   14822:	0001                	nop
   14824:	4818                	lw	a4,16(s0)
   14826:	0001                	nop
   14828:	4820                	lw	s0,80(s0)
   1482a:	0001                	nop
   1482c:	4820                	lw	s0,80(s0)
   1482e:	0001                	nop
   14830:	4828                	lw	a0,80(s0)
   14832:	0001                	nop
   14834:	4828                	lw	a0,80(s0)
   14836:	0001                	nop
   14838:	4830                	lw	a2,80(s0)
   1483a:	0001                	nop
   1483c:	4830                	lw	a2,80(s0)
   1483e:	0001                	nop
   14840:	4838                	lw	a4,80(s0)
   14842:	0001                	nop
   14844:	4838                	lw	a4,80(s0)
   14846:	0001                	nop
   14848:	4840                	lw	s0,20(s0)
   1484a:	0001                	nop
   1484c:	4840                	lw	s0,20(s0)
   1484e:	0001                	nop
   14850:	4848                	lw	a0,20(s0)
   14852:	0001                	nop
   14854:	4848                	lw	a0,20(s0)
   14856:	0001                	nop
   14858:	4850                	lw	a2,20(s0)
   1485a:	0001                	nop
   1485c:	4850                	lw	a2,20(s0)
   1485e:	0001                	nop
   14860:	4858                	lw	a4,20(s0)
   14862:	0001                	nop
   14864:	4858                	lw	a4,20(s0)
   14866:	0001                	nop
   14868:	4860                	lw	s0,84(s0)
   1486a:	0001                	nop
   1486c:	4860                	lw	s0,84(s0)
   1486e:	0001                	nop
   14870:	4868                	lw	a0,84(s0)
   14872:	0001                	nop
   14874:	4868                	lw	a0,84(s0)
   14876:	0001                	nop
   14878:	4870                	lw	a2,84(s0)
   1487a:	0001                	nop
   1487c:	4870                	lw	a2,84(s0)
   1487e:	0001                	nop
   14880:	4878                	lw	a4,84(s0)
   14882:	0001                	nop
   14884:	4878                	lw	a4,84(s0)
   14886:	0001                	nop
   14888:	4880                	lw	s0,16(s1)
   1488a:	0001                	nop
   1488c:	4880                	lw	s0,16(s1)
   1488e:	0001                	nop
   14890:	4888                	lw	a0,16(s1)
   14892:	0001                	nop
   14894:	4888                	lw	a0,16(s1)
   14896:	0001                	nop
   14898:	4890                	lw	a2,16(s1)
   1489a:	0001                	nop
   1489c:	4890                	lw	a2,16(s1)
   1489e:	0001                	nop
   148a0:	4898                	lw	a4,16(s1)
   148a2:	0001                	nop
   148a4:	4898                	lw	a4,16(s1)
   148a6:	0001                	nop
   148a8:	48a0                	lw	s0,80(s1)
   148aa:	0001                	nop
   148ac:	48a0                	lw	s0,80(s1)
   148ae:	0001                	nop
   148b0:	48a8                	lw	a0,80(s1)
   148b2:	0001                	nop
   148b4:	48a8                	lw	a0,80(s1)
   148b6:	0001                	nop
   148b8:	48b0                	lw	a2,80(s1)
   148ba:	0001                	nop
   148bc:	48b0                	lw	a2,80(s1)
   148be:	0001                	nop
   148c0:	48b8                	lw	a4,80(s1)
   148c2:	0001                	nop
   148c4:	48b8                	lw	a4,80(s1)
   148c6:	0001                	nop
   148c8:	48c0                	lw	s0,20(s1)
   148ca:	0001                	nop
   148cc:	48c0                	lw	s0,20(s1)
   148ce:	0001                	nop
   148d0:	48c8                	lw	a0,20(s1)
   148d2:	0001                	nop
   148d4:	48c8                	lw	a0,20(s1)
   148d6:	0001                	nop
   148d8:	48d0                	lw	a2,20(s1)
   148da:	0001                	nop
   148dc:	48d0                	lw	a2,20(s1)
   148de:	0001                	nop
   148e0:	48d8                	lw	a4,20(s1)
   148e2:	0001                	nop
   148e4:	48d8                	lw	a4,20(s1)
   148e6:	0001                	nop
   148e8:	48e0                	lw	s0,84(s1)
   148ea:	0001                	nop
   148ec:	48e0                	lw	s0,84(s1)
   148ee:	0001                	nop
   148f0:	48e8                	lw	a0,84(s1)
   148f2:	0001                	nop
   148f4:	48e8                	lw	a0,84(s1)
   148f6:	0001                	nop
   148f8:	48f0                	lw	a2,84(s1)
   148fa:	0001                	nop
   148fc:	48f0                	lw	a2,84(s1)
   148fe:	0001                	nop
   14900:	48f8                	lw	a4,84(s1)
   14902:	0001                	nop
   14904:	48f8                	lw	a4,84(s1)
   14906:	0001                	nop
   14908:	4900                	lw	s0,16(a0)
   1490a:	0001                	nop
   1490c:	4900                	lw	s0,16(a0)
   1490e:	0001                	nop
   14910:	4908                	lw	a0,16(a0)
   14912:	0001                	nop
   14914:	4908                	lw	a0,16(a0)
   14916:	0001                	nop
   14918:	4910                	lw	a2,16(a0)
   1491a:	0001                	nop
   1491c:	4910                	lw	a2,16(a0)
   1491e:	0001                	nop
   14920:	4918                	lw	a4,16(a0)
   14922:	0001                	nop
   14924:	4918                	lw	a4,16(a0)
   14926:	0001                	nop
   14928:	4920                	lw	s0,80(a0)
   1492a:	0001                	nop
   1492c:	4920                	lw	s0,80(a0)
   1492e:	0001                	nop
   14930:	4928                	lw	a0,80(a0)
   14932:	0001                	nop
   14934:	4928                	lw	a0,80(a0)
   14936:	0001                	nop
   14938:	4930                	lw	a2,80(a0)
   1493a:	0001                	nop
   1493c:	4930                	lw	a2,80(a0)
   1493e:	0001                	nop
   14940:	4938                	lw	a4,80(a0)
   14942:	0001                	nop
   14944:	4938                	lw	a4,80(a0)
   14946:	0001                	nop
   14948:	4940                	lw	s0,20(a0)
   1494a:	0001                	nop
   1494c:	4940                	lw	s0,20(a0)
   1494e:	0001                	nop
   14950:	4948                	lw	a0,20(a0)
   14952:	0001                	nop
   14954:	4948                	lw	a0,20(a0)
   14956:	0001                	nop
   14958:	4950                	lw	a2,20(a0)
   1495a:	0001                	nop
   1495c:	4950                	lw	a2,20(a0)
   1495e:	0001                	nop
   14960:	4958                	lw	a4,20(a0)
   14962:	0001                	nop
   14964:	4958                	lw	a4,20(a0)
   14966:	0001                	nop
   14968:	4960                	lw	s0,84(a0)
   1496a:	0001                	nop
   1496c:	4960                	lw	s0,84(a0)
   1496e:	0001                	nop
   14970:	4968                	lw	a0,84(a0)
   14972:	0001                	nop
   14974:	4968                	lw	a0,84(a0)
   14976:	0001                	nop
   14978:	4970                	lw	a2,84(a0)
   1497a:	0001                	nop
   1497c:	4970                	lw	a2,84(a0)
   1497e:	0001                	nop
   14980:	4978                	lw	a4,84(a0)
   14982:	0001                	nop
   14984:	4978                	lw	a4,84(a0)
   14986:	0001                	nop
   14988:	4980                	lw	s0,16(a1)
   1498a:	0001                	nop
   1498c:	4980                	lw	s0,16(a1)
   1498e:	0001                	nop
   14990:	4988                	lw	a0,16(a1)
   14992:	0001                	nop
   14994:	4988                	lw	a0,16(a1)
   14996:	0001                	nop

Disassembly of section .sdata:

00014998 <__TMC_END__>:
   14998:	0000                	unimp
	...

0001499c <_global_impure_ptr>:
   1499c:	4168                	lw	a0,68(a0)
   1499e:	0001                	nop

000149a0 <_impure_ptr>:
   149a0:	4168                	lw	a0,68(a0)
   149a2:	0001                	nop

000149a4 <__malloc_sbrk_base>:
   149a4:	ffff                	0xffff
   149a6:	ffff                	0xffff

000149a8 <__malloc_trim_threshold>:
   149a8:	0000                	unimp
   149aa:	0002                	0x2

Disassembly of section .sbss:

000149ac <__malloc_max_total_mem>:
   149ac:	0000                	unimp
	...

000149b0 <__malloc_max_sbrked_mem>:
   149b0:	0000                	unimp
	...

000149b4 <__malloc_top_pad>:
   149b4:	0000                	unimp
	...

000149b8 <heap_end.2573>:
   149b8:	0000                	unimp
	...

000149bc <t0.2536>:
	...

Disassembly of section .bss:

000149c4 <completed.5148>:
   149c4:	0000                	unimp
	...

000149c8 <object.5153>:
	...

000149e0 <__malloc_current_mallinfo>:
	...

00014a08 <errno>:
   14a08:	0000                	unimp
	...

Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347          	fmsub.d	ft6,ft6,ft4,ft7,rmm
   4:	2820                	fld	fs0,80(s0)
   6:	29554e47          	fmsub.s	ft8,fa0,fs5,ft5,rmm
   a:	3720                	fld	fs0,104(a4)
   c:	312e                	fld	ft2,232(sp)
   e:	312e                	fld	ft2,232(sp)
  10:	3220                	fld	fs0,96(a2)
  12:	3130                	fld	fa2,96(a0)
  14:	30353037          	lui	zero,0x30353
  18:	0039                	c.addi	zero,14

Disassembly of section .debug_aranges:

00000000 <.debug_aranges>:
   0:	001c                	addi	a5,sp,0
   2:	0000                	unimp
   4:	0002                	0x2
   6:	0000                	unimp
   8:	0000                	unimp
   a:	0004                	addi	s1,sp,0
   c:	0000                	unimp
   e:	0000                	unimp
  10:	2fd4                	fld	fa3,152(a5)
  12:	0001                	nop
  14:	0024                	addi	s1,sp,8
	...
  1e:	0000                	unimp
  20:	001c                	addi	a5,sp,0
  22:	0000                	unimp
  24:	0002                	0x2
  26:	00e6                	slli	ra,ra,0x19
  28:	0000                	unimp
  2a:	0004                	addi	s1,sp,0
  2c:	0000                	unimp
  2e:	0000                	unimp
  30:	2ff8                	fld	fa4,216(a5)
  32:	0001                	nop
  34:	00b4                	addi	a3,sp,72
	...

Disassembly of section .debug_info:

00000000 <.debug_info>:
   0:	00e2                	slli	ra,ra,0x18
   2:	0000                	unimp
   4:	0002                	0x2
   6:	0000                	unimp
   8:	0000                	unimp
   a:	0104                	addi	s1,sp,128
   c:	0000                	unimp
   e:	0000                	unimp
  10:	2fd4                	fld	fa3,152(a5)
  12:	0001                	nop
  14:	2ff8                	fld	fa4,216(a5)
  16:	0001                	nop
  18:	6d6f682f          	0x6d6f682f
  1c:	2f65                	jal	7d4 <main-0xf8a0>
  1e:	646a                	flw	fs0,152(sp)
  20:	6f72502f          	0x6f72502f
  24:	656a                	flw	fa0,152(sp)
  26:	2f737463          	bleu	s7,t1,30e <main-0xfd66>
  2a:	6972                	flw	fs2,28(sp)
  2c:	2d766373          	csrrsi	t1,0x2d7,12
  30:	6f74                	flw	fa3,92(a4)
  32:	2f736c6f          	jal	s8,36b28 <__global_pointer$+0x21990>
  36:	6972                	flw	fs2,28(sp)
  38:	2d766373          	csrrsi	t1,0x2d7,12
  3c:	2d756e67          	0x2d756e67
  40:	6f74                	flw	fa3,92(a4)
  42:	68636c6f          	jal	s8,366c8 <__global_pointer$+0x21530>
  46:	6961                	lui	s2,0x18
  48:	2f6e                	fld	ft10,216(sp)
  4a:	6972                	flw	fs2,28(sp)
  4c:	2d766373          	csrrsi	t1,0x2d7,12
  50:	2f636367          	0x2f636367
  54:	696c                	flw	fa1,84(a0)
  56:	6762                	flw	fa4,24(sp)
  58:	632f6363          	bltu	t5,s2,67e <main-0xf9f6>
  5c:	69666e6f          	jal	t3,666f2 <__global_pointer$+0x5155a>
  60:	69722f67          	0x69722f67
  64:	2f766373          	csrrsi	t1,0x2f7,12
  68:	756d                	lui	a0,0xffffb
  6a:	646c                	flw	fa1,76(s0)
  6c:	3369                	jal	fffffdf6 <__global_pointer$+0xfffeac5e>
  6e:	532e                	lw	t1,232(sp)
  70:	2f00                	fld	fs0,24(a4)
  72:	6f68                	flw	fa0,92(a4)
  74:	656d                	lui	a0,0x1b
  76:	2f646a2f          	0x2f646a2f
  7a:	7250                	flw	fa2,36(a2)
  7c:	63656a6f          	jal	s4,566b2 <__global_pointer$+0x4151a>
  80:	7374                	flw	fa3,100(a4)
  82:	7369722f          	0x7369722f
  86:	742d7663          	bleu	sp,s10,7d2 <main-0xf8a2>
  8a:	736c6f6f          	jal	t5,c67c0 <__global_pointer$+0xb1628>
  8e:	7369722f          	0x7369722f
  92:	672d7663          	bleu	s2,s10,6fe <main-0xf976>
  96:	756e                	flw	fa0,248(sp)
  98:	742d                	lui	s0,0xfffeb
  9a:	636c6f6f          	jal	t5,c66d0 <__global_pointer$+0xb1538>
  9e:	6168                	flw	fa0,68(a0)
  a0:	6e69                	lui	t3,0x1a
  a2:	6975622f          	0x6975622f
  a6:	646c                	flw	fa1,76(s0)
  a8:	672d                	lui	a4,0xb
  aa:	6e2d6363          	bltu	s10,sp,790 <main-0xf8e4>
  ae:	7765                	lui	a4,0xffff9
  b0:	696c                	flw	fa1,84(a0)
  b2:	2d62                	fld	fs10,24(sp)
  b4:	67617473          	csrrci	s0,0x676,2
  b8:	3265                	jal	fffffa60 <__global_pointer$+0xfffea8c8>
  ba:	7369722f          	0x7369722f
  be:	32337663          	bleu	gp,t1,3ea <main-0xfc8a>
  c2:	752d                	lui	a0,0xfffeb
  c4:	6b6e                	flw	fs6,216(sp)
  c6:	6f6e                	flw	ft10,216(sp)
  c8:	652d6e77          	0x652d6e77
  cc:	666c                	flw	fa1,76(a2)
  ce:	62696c2f          	0x62696c2f
  d2:	00636367          	0x636367
  d6:	20554e47          	fmsub.s	ft8,fa0,ft5,ft4,rmm
  da:	5341                	li	t1,-16
  dc:	3220                	fld	fs0,96(a2)
  de:	322e                	fld	ft4,232(sp)
  e0:	2e38                	fld	fa4,88(a2)
  e2:	0030                	addi	a2,sp,8
  e4:	8001                	srli	s0,s0,0x0
  e6:	00df 0000 0002      	0x2000000df
  ec:	0014                	addi	a3,sp,0
  ee:	0000                	unimp
  f0:	0104                	addi	s1,sp,128
  f2:	00b9                	addi	ra,ra,14
  f4:	0000                	unimp
  f6:	2ff8                	fld	fa4,216(a5)
  f8:	0001                	nop
  fa:	30ac                	fld	fa1,96(s1)
  fc:	0001                	nop
  fe:	6d6f682f          	0x6d6f682f
 102:	2f65                	jal	8ba <main-0xf7ba>
 104:	646a                	flw	fs0,152(sp)
 106:	6f72502f          	0x6f72502f
 10a:	656a                	flw	fa0,152(sp)
 10c:	2f737463          	bleu	s7,t1,3f4 <main-0xfc80>
 110:	6972                	flw	fs2,28(sp)
 112:	2d766373          	csrrsi	t1,0x2d7,12
 116:	6f74                	flw	fa3,92(a4)
 118:	2f736c6f          	jal	s8,36c0e <__global_pointer$+0x21a76>
 11c:	6972                	flw	fs2,28(sp)
 11e:	2d766373          	csrrsi	t1,0x2d7,12
 122:	2d756e67          	0x2d756e67
 126:	6f74                	flw	fa3,92(a4)
 128:	68636c6f          	jal	s8,367ae <__global_pointer$+0x21616>
 12c:	6961                	lui	s2,0x18
 12e:	2f6e                	fld	ft10,216(sp)
 130:	6972                	flw	fs2,28(sp)
 132:	2d766373          	csrrsi	t1,0x2d7,12
 136:	2f636367          	0x2f636367
 13a:	696c                	flw	fa1,84(a0)
 13c:	6762                	flw	fa4,24(sp)
 13e:	632f6363          	bltu	t5,s2,764 <main-0xf910>
 142:	69666e6f          	jal	t3,667d8 <__global_pointer$+0x51640>
 146:	69722f67          	0x69722f67
 14a:	2f766373          	csrrsi	t1,0x2f7,12
 14e:	6964                	flw	fs1,84(a0)
 150:	2e76                	fld	ft8,344(sp)
 152:	682f0053          	0x682f0053
 156:	2f656d6f          	jal	s10,5644c <__global_pointer$+0x412b4>
 15a:	646a                	flw	fs0,152(sp)
 15c:	6f72502f          	0x6f72502f
 160:	656a                	flw	fa0,152(sp)
 162:	2f737463          	bleu	s7,t1,44a <main-0xfc2a>
 166:	6972                	flw	fs2,28(sp)
 168:	2d766373          	csrrsi	t1,0x2d7,12
 16c:	6f74                	flw	fa3,92(a4)
 16e:	2f736c6f          	jal	s8,36c64 <__global_pointer$+0x21acc>
 172:	6972                	flw	fs2,28(sp)
 174:	2d766373          	csrrsi	t1,0x2d7,12
 178:	2d756e67          	0x2d756e67
 17c:	6f74                	flw	fa3,92(a4)
 17e:	68636c6f          	jal	s8,36804 <__global_pointer$+0x2166c>
 182:	6961                	lui	s2,0x18
 184:	2f6e                	fld	ft10,216(sp)
 186:	7562                	flw	fa0,56(sp)
 188:	6c69                	lui	s8,0x1a
 18a:	2d64                	fld	fs1,216(a0)
 18c:	2d636367          	0x2d636367
 190:	656e                	flw	fa0,216(sp)
 192:	62696c77          	0x62696c77
 196:	732d                	lui	t1,0xfffeb
 198:	6174                	flw	fa3,68(a0)
 19a:	2f326567          	0x2f326567
 19e:	6972                	flw	fs2,28(sp)
 1a0:	33766373          	csrrsi	t1,mhpmevent23,12
 1a4:	2d32                	fld	fs10,264(sp)
 1a6:	6e75                	lui	t3,0x1d
 1a8:	776f6e6b          	0x776f6e6b
 1ac:	2d6e                	fld	fs10,216(sp)
 1ae:	6c65                	lui	s8,0x19
 1b0:	2f66                	fld	ft10,88(sp)
 1b2:	696c                	flw	fa1,84(a0)
 1b4:	6762                	flw	fa4,24(sp)
 1b6:	47006363          	bltu	zero,a6,61c <main-0xfa58>
 1ba:	554e                	lw	a0,240(sp)
 1bc:	4120                	lw	s0,64(a0)
 1be:	2e322053          	0x2e322053
 1c2:	3832                	fld	fa6,296(sp)
 1c4:	302e                	fld	ft0,232(sp)
 1c6:	0100                	addi	s0,sp,128
 1c8:	80 00 00 00 00          	Address 0x00000000000001c8 is out of bounds.


Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	1101                	addi	sp,sp,-32
   2:	1000                	addi	s0,sp,32
   4:	1106                	slli	sp,sp,0x21
   6:	1201                	addi	tp,tp,-32
   8:	0301                	addi	t1,t1,0
   a:	1b08                	addi	a0,sp,432
   c:	2508                	fld	fa0,8(a0)
   e:	1308                	addi	a0,sp,416
  10:	0005                	c.addi	zero,1
  12:	0000                	unimp
  14:	1101                	addi	sp,sp,-32
  16:	1000                	addi	s0,sp,32
  18:	1106                	slli	sp,sp,0x21
  1a:	1201                	addi	tp,tp,-32
  1c:	0301                	addi	t1,t1,0
  1e:	1b08                	addi	a0,sp,432
  20:	2508                	fld	fa0,8(a0)
  22:	1308                	addi	a0,sp,416
  24:	0005                	c.addi	zero,1
	...

Disassembly of section .debug_line:

00000000 <.debug_line>:
   0:	00b5                	addi	ra,ra,13
   2:	0000                	unimp
   4:	0002                	0x2
   6:	0000006f          	j	6 <main-0x1006e>
   a:	0101                	addi	sp,sp,0
   c:	000d0efb          	0xd0efb
  10:	0101                	addi	sp,sp,0
  12:	0101                	addi	sp,sp,0
  14:	0000                	unimp
  16:	0100                	addi	s0,sp,128
  18:	0000                	unimp
  1a:	2f01                	jal	72a <main-0xf94a>
  1c:	6f68                	flw	fa0,92(a4)
  1e:	656d                	lui	a0,0x1b
  20:	2f646a2f          	0x2f646a2f
  24:	7250                	flw	fa2,36(a2)
  26:	63656a6f          	jal	s4,5665c <__global_pointer$+0x414c4>
  2a:	7374                	flw	fa3,100(a4)
  2c:	7369722f          	0x7369722f
  30:	742d7663          	bleu	sp,s10,77c <main-0xf8f8>
  34:	736c6f6f          	jal	t5,c676a <__global_pointer$+0xb15d2>
  38:	7369722f          	0x7369722f
  3c:	672d7663          	bleu	s2,s10,6a8 <main-0xf9cc>
  40:	756e                	flw	fa0,248(sp)
  42:	742d                	lui	s0,0xfffeb
  44:	636c6f6f          	jal	t5,c667a <__global_pointer$+0xb14e2>
  48:	6168                	flw	fa0,68(a0)
  4a:	6e69                	lui	t3,0x1a
  4c:	7369722f          	0x7369722f
  50:	672d7663          	bleu	s2,s10,6bc <main-0xf9b8>
  54:	6c2f6363          	bltu	t5,sp,71a <main-0xf95a>
  58:	6269                	lui	tp,0x1a
  5a:	2f636367          	0x2f636367
  5e:	666e6f63          	bltu	t3,t1,6dc <main-0xf998>
  62:	6769                	lui	a4,0x1a
  64:	7369722f          	0x7369722f
  68:	00007663          	bleu	zero,zero,74 <main-0x10000>
  6c:	756d                	lui	a0,0xffffb
  6e:	646c                	flw	fa1,76(s0)
  70:	3369                	jal	fffffdfa <__global_pointer$+0xfffeac62>
  72:	532e                	lw	t1,232(sp)
  74:	0100                	addi	s0,sp,128
  76:	0000                	unimp
  78:	0000                	unimp
  7a:	0205                	addi	tp,tp,1
  7c:	2fd4                	fld	fa3,152(a5)
  7e:	0001                	nop
  80:	03012303          	lw	t1,48(sp)
  84:	0901                	addi	s2,s2,0
  86:	0004                	addi	s1,sp,0
  88:	0301                	addi	t1,t1,0
  8a:	0902                	slli	s2,s2,0x0
  8c:	0004                	addi	s1,sp,0
  8e:	0301                	addi	t1,t1,0
  90:	0901                	addi	s2,s2,0
  92:	0004                	addi	s1,sp,0
  94:	0301                	addi	t1,t1,0
  96:	0901                	addi	s2,s2,0
  98:	0004                	addi	s1,sp,0
  9a:	0301                	addi	t1,t1,0
  9c:	0902                	slli	s2,s2,0x0
  9e:	0004                	addi	s1,sp,0
  a0:	0301                	addi	t1,t1,0
  a2:	0901                	addi	s2,s2,0
  a4:	0004                	addi	s1,sp,0
  a6:	0301                	addi	t1,t1,0
  a8:	0901                	addi	s2,s2,0
  aa:	0004                	addi	s1,sp,0
  ac:	0301                	addi	t1,t1,0
  ae:	0901                	addi	s2,s2,0
  b0:	0004                	addi	s1,sp,0
  b2:	0901                	addi	s2,s2,0
  b4:	0004                	addi	s1,sp,0
  b6:	0100                	addi	s0,sp,128
  b8:	8b01                	andi	a4,a4,0
  ba:	0001                	nop
  bc:	0200                	addi	s0,sp,256
  be:	6c00                	flw	fs0,24(s0)
  c0:	0000                	unimp
  c2:	0100                	addi	s0,sp,128
  c4:	fb01                	bnez	a4,ffffffd4 <__global_pointer$+0xfffeae3c>
  c6:	0d0e                	slli	s10,s10,0x3
  c8:	0100                	addi	s0,sp,128
  ca:	0101                	addi	sp,sp,0
  cc:	0001                	nop
  ce:	0000                	unimp
  d0:	0001                	nop
  d2:	0100                	addi	s0,sp,128
  d4:	6d6f682f          	0x6d6f682f
  d8:	2f65                	jal	890 <main-0xf7e4>
  da:	646a                	flw	fs0,152(sp)
  dc:	6f72502f          	0x6f72502f
  e0:	656a                	flw	fa0,152(sp)
  e2:	2f737463          	bleu	s7,t1,3ca <main-0xfcaa>
  e6:	6972                	flw	fs2,28(sp)
  e8:	2d766373          	csrrsi	t1,0x2d7,12
  ec:	6f74                	flw	fa3,92(a4)
  ee:	2f736c6f          	jal	s8,36be4 <__global_pointer$+0x21a4c>
  f2:	6972                	flw	fs2,28(sp)
  f4:	2d766373          	csrrsi	t1,0x2d7,12
  f8:	2d756e67          	0x2d756e67
  fc:	6f74                	flw	fa3,92(a4)
  fe:	68636c6f          	jal	s8,36784 <__global_pointer$+0x215ec>
 102:	6961                	lui	s2,0x18
 104:	2f6e                	fld	ft10,216(sp)
 106:	6972                	flw	fs2,28(sp)
 108:	2d766373          	csrrsi	t1,0x2d7,12
 10c:	2f636367          	0x2f636367
 110:	696c                	flw	fa1,84(a0)
 112:	6762                	flw	fa4,24(sp)
 114:	632f6363          	bltu	t5,s2,73a <main-0xf93a>
 118:	69666e6f          	jal	t3,667ae <__global_pointer$+0x51616>
 11c:	69722f67          	0x69722f67
 120:	00766373          	csrrsi	t1,0x7,12
 124:	6400                	flw	fs0,8(s0)
 126:	7669                	lui	a2,0xffffa
 128:	532e                	lw	t1,232(sp)
 12a:	0100                	addi	s0,sp,128
 12c:	0000                	unimp
 12e:	0000                	unimp
 130:	0205                	addi	tp,tp,1
 132:	2ff8                	fld	fa4,216(a5)
 134:	0001                	nop
 136:	0100c503          	lbu	a0,16(ra)
 13a:	04090103          	lb	sp,64(s2) # 18040 <__global_pointer$+0x2ea8>
 13e:	0100                	addi	s0,sp,128
 140:	04090503          	lb	a0,64(s2)
 144:	0100                	addi	s0,sp,128
 146:	04090103          	lb	sp,64(s2)
 14a:	0100                	addi	s0,sp,128
 14c:	04090103          	lb	sp,64(s2)
 150:	0100                	addi	s0,sp,128
 152:	04090103          	lb	sp,64(s2)
 156:	0100                	addi	s0,sp,128
 158:	04090103          	lb	sp,64(s2)
 15c:	0100                	addi	s0,sp,128
 15e:	04090103          	lb	sp,64(s2)
 162:	0100                	addi	s0,sp,128
 164:	04090203          	lb	tp,64(s2)
 168:	0100                	addi	s0,sp,128
 16a:	04090103          	lb	sp,64(s2)
 16e:	0100                	addi	s0,sp,128
 170:	04090103          	lb	sp,64(s2)
 174:	0100                	addi	s0,sp,128
 176:	04090103          	lb	sp,64(s2)
 17a:	0100                	addi	s0,sp,128
 17c:	04090203          	lb	tp,64(s2)
 180:	0100                	addi	s0,sp,128
 182:	04090203          	lb	tp,64(s2)
 186:	0100                	addi	s0,sp,128
 188:	04090103          	lb	sp,64(s2)
 18c:	0100                	addi	s0,sp,128
 18e:	04090103          	lb	sp,64(s2)
 192:	0100                	addi	s0,sp,128
 194:	04090203          	lb	tp,64(s2)
 198:	0100                	addi	s0,sp,128
 19a:	04090103          	lb	sp,64(s2)
 19e:	0100                	addi	s0,sp,128
 1a0:	04090103          	lb	sp,64(s2)
 1a4:	0100                	addi	s0,sp,128
 1a6:	04090203          	lb	tp,64(s2)
 1aa:	0100                	addi	s0,sp,128
 1ac:	04090503          	lb	a0,64(s2)
 1b0:	0100                	addi	s0,sp,128
 1b2:	04090103          	lb	sp,64(s2)
 1b6:	0100                	addi	s0,sp,128
 1b8:	04090103          	lb	sp,64(s2)
 1bc:	0100                	addi	s0,sp,128
 1be:	04090103          	lb	sp,64(s2)
 1c2:	0100                	addi	s0,sp,128
 1c4:	04090403          	lb	s0,64(s2)
 1c8:	0100                	addi	s0,sp,128
 1ca:	04090103          	lb	sp,64(s2)
 1ce:	0100                	addi	s0,sp,128
 1d0:	04090103          	lb	sp,64(s2)
 1d4:	0100                	addi	s0,sp,128
 1d6:	04090103          	lb	sp,64(s2)
 1da:	0100                	addi	s0,sp,128
 1dc:	04090203          	lb	tp,64(s2)
 1e0:	0100                	addi	s0,sp,128
 1e2:	04090203          	lb	tp,64(s2)
 1e6:	0100                	addi	s0,sp,128
 1e8:	04090103          	lb	sp,64(s2)
 1ec:	0100                	addi	s0,sp,128
 1ee:	04090103          	lb	sp,64(s2)
 1f2:	0100                	addi	s0,sp,128
 1f4:	04090103          	lb	sp,64(s2)
 1f8:	0100                	addi	s0,sp,128
 1fa:	04090403          	lb	s0,64(s2)
 1fe:	0100                	addi	s0,sp,128
 200:	04090103          	lb	sp,64(s2)
 204:	0100                	addi	s0,sp,128
 206:	04090103          	lb	sp,64(s2)
 20a:	0100                	addi	s0,sp,128
 20c:	04090203          	lb	tp,64(s2)
 210:	0100                	addi	s0,sp,128
 212:	04090103          	lb	sp,64(s2)
 216:	0100                	addi	s0,sp,128
 218:	04090103          	lb	sp,64(s2)
 21c:	0100                	addi	s0,sp,128
 21e:	04090203          	lb	tp,64(s2)
 222:	0100                	addi	s0,sp,128
 224:	04090103          	lb	sp,64(s2)
 228:	0100                	addi	s0,sp,128
 22a:	04090203          	lb	tp,64(s2)
 22e:	0100                	addi	s0,sp,128
 230:	04090103          	lb	sp,64(s2)
 234:	0100                	addi	s0,sp,128
 236:	04090103          	lb	sp,64(s2)
 23a:	0100                	addi	s0,sp,128
 23c:	04090103          	lb	sp,64(s2)
 240:	0100                	addi	s0,sp,128
 242:	0409                	addi	s0,s0,2
 244:	0000                	unimp
 246:	0101                	addi	sp,sp,0
