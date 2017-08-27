
hello:     file format elf32-littleriscv


Disassembly of section .text:

00010074 <main>:
   10074:	00013537          	lui	a0,0x13
   10078:	ff010113          	addi	sp,sp,-16
   1007c:	09050513          	addi	a0,a0,144 # 13090 <__modsi3+0x30>
   10080:	00112623          	sw	ra,12(sp)
   10084:	450000ef          	jal	ra,104d4 <puts>
   10088:	00c12083          	lw	ra,12(sp)
   1008c:	00000513          	li	a0,0
   10090:	01010113          	addi	sp,sp,16
   10094:	00008067          	ret

00010098 <_start>:
   10098:	00005197          	auipc	gp,0x5
   1009c:	08818193          	addi	gp,gp,136 # 15120 <__global_pointer$>
   100a0:	00005517          	auipc	a0,0x5
   100a4:	89450513          	addi	a0,a0,-1900 # 14934 <_edata>
   100a8:	00005617          	auipc	a2,0x5
   100ac:	8ec60613          	addi	a2,a2,-1812 # 14994 <_end>
   100b0:	40a60633          	sub	a2,a2,a0
   100b4:	00000593          	li	a1,0
   100b8:	278000ef          	jal	ra,10330 <memset>
   100bc:	00000517          	auipc	a0,0x0
   100c0:	16450513          	addi	a0,a0,356 # 10220 <__libc_fini_array>
   100c4:	114000ef          	jal	ra,101d8 <atexit>
   100c8:	1c8000ef          	jal	ra,10290 <__libc_init_array>
   100cc:	00012503          	lw	a0,0(sp)
   100d0:	00410593          	addi	a1,sp,4
   100d4:	00000613          	li	a2,0
   100d8:	f9dff0ef          	jal	ra,10074 <main>
   100dc:	1100006f          	j	101ec <exit>

000100e0 <_fini>:
   100e0:	00008067          	ret

000100e4 <deregister_tm_clones>:
   100e4:	00015537          	lui	a0,0x15
   100e8:	000157b7          	lui	a5,0x15
   100ec:	92050713          	addi	a4,a0,-1760 # 14920 <__TMC_END__>
   100f0:	92078793          	addi	a5,a5,-1760 # 14920 <__TMC_END__>
   100f4:	00e78c63          	beq	a5,a4,1010c <deregister_tm_clones+0x28>
   100f8:	00000337          	lui	t1,0x0
   100fc:	00030313          	mv	t1,t1
   10100:	00030663          	beqz	t1,1010c <deregister_tm_clones+0x28>
   10104:	92050513          	addi	a0,a0,-1760
   10108:	00030067          	jr	t1
   1010c:	00008067          	ret

00010110 <register_tm_clones>:
   10110:	000157b7          	lui	a5,0x15
   10114:	00015537          	lui	a0,0x15
   10118:	92078593          	addi	a1,a5,-1760 # 14920 <__TMC_END__>
   1011c:	92050793          	addi	a5,a0,-1760 # 14920 <__TMC_END__>
   10120:	40f585b3          	sub	a1,a1,a5
   10124:	4025d593          	srai	a1,a1,0x2
   10128:	01f5d793          	srli	a5,a1,0x1f
   1012c:	00b785b3          	add	a1,a5,a1
   10130:	4015d593          	srai	a1,a1,0x1
   10134:	00058c63          	beqz	a1,1014c <register_tm_clones+0x3c>
   10138:	00000337          	lui	t1,0x0
   1013c:	00030313          	mv	t1,t1
   10140:	00030663          	beqz	t1,1014c <register_tm_clones+0x3c>
   10144:	92050513          	addi	a0,a0,-1760
   10148:	00030067          	jr	t1
   1014c:	00008067          	ret

00010150 <__do_global_dtors_aux>:
   10150:	82c1c703          	lbu	a4,-2004(gp) # 1494c <completed.5148>
   10154:	04071663          	bnez	a4,101a0 <__do_global_dtors_aux+0x50>
   10158:	ff010113          	addi	sp,sp,-16
   1015c:	00812423          	sw	s0,8(sp)
   10160:	00112623          	sw	ra,12(sp)
   10164:	00078413          	mv	s0,a5
   10168:	f7dff0ef          	jal	ra,100e4 <deregister_tm_clones>
   1016c:	000007b7          	lui	a5,0x0
   10170:	00078793          	mv	a5,a5
   10174:	00078a63          	beqz	a5,10188 <__do_global_dtors_aux+0x38>
   10178:	00013537          	lui	a0,0x13
   1017c:	0a450513          	addi	a0,a0,164 # 130a4 <__EH_FRAME_BEGIN__>
   10180:	ffff0097          	auipc	ra,0xffff0
   10184:	e80080e7          	jalr	-384(ra) # 0 <main-0x10074>
   10188:	00100793          	li	a5,1
   1018c:	82f18623          	sb	a5,-2004(gp) # 1494c <completed.5148>
   10190:	00c12083          	lw	ra,12(sp)
   10194:	00812403          	lw	s0,8(sp)
   10198:	01010113          	addi	sp,sp,16
   1019c:	00008067          	ret
   101a0:	00008067          	ret

000101a4 <frame_dummy>:
   101a4:	000007b7          	lui	a5,0x0
   101a8:	00078793          	mv	a5,a5
   101ac:	02078463          	beqz	a5,101d4 <frame_dummy+0x30>
   101b0:	00013537          	lui	a0,0x13
   101b4:	ff010113          	addi	sp,sp,-16
   101b8:	83018593          	addi	a1,gp,-2000 # 14950 <object.5153>
   101bc:	0a450513          	addi	a0,a0,164 # 130a4 <__EH_FRAME_BEGIN__>
   101c0:	00112623          	sw	ra,12(sp)
   101c4:	ffff0097          	auipc	ra,0xffff0
   101c8:	e3c080e7          	jalr	-452(ra) # 0 <main-0x10074>
   101cc:	00c12083          	lw	ra,12(sp)
   101d0:	01010113          	addi	sp,sp,16
   101d4:	f3dff06f          	j	10110 <register_tm_clones>

000101d8 <atexit>:
   101d8:	00050593          	mv	a1,a0
   101dc:	00000693          	li	a3,0
   101e0:	00000613          	li	a2,0
   101e4:	00000513          	li	a0,0
   101e8:	3140006f          	j	104fc <__register_exitproc>

000101ec <exit>:
   101ec:	ff010113          	addi	sp,sp,-16
   101f0:	00000593          	li	a1,0
   101f4:	00812423          	sw	s0,8(sp)
   101f8:	00112623          	sw	ra,12(sp)
   101fc:	00050413          	mv	s0,a0
   10200:	37c000ef          	jal	ra,1057c <__call_exitprocs>
   10204:	000157b7          	lui	a5,0x15
   10208:	9247a503          	lw	a0,-1756(a5) # 14924 <_global_impure_ptr>
   1020c:	03c52783          	lw	a5,60(a0)
   10210:	00078463          	beqz	a5,10218 <exit+0x2c>
   10214:	000780e7          	jalr	a5
   10218:	00040513          	mv	a0,s0
   1021c:	571020ef          	jal	ra,12f8c <_exit>

00010220 <__libc_fini_array>:
   10220:	ff010113          	addi	sp,sp,-16
   10224:	000147b7          	lui	a5,0x14
   10228:	00014737          	lui	a4,0x14
   1022c:	00812423          	sw	s0,8(sp)
   10230:	0ec70713          	addi	a4,a4,236 # 140ec <__init_array_end>
   10234:	0f078413          	addi	s0,a5,240 # 140f0 <__fini_array_end>
   10238:	40e40433          	sub	s0,s0,a4
   1023c:	00912223          	sw	s1,4(sp)
   10240:	01212023          	sw	s2,0(sp)
   10244:	00112623          	sw	ra,12(sp)
   10248:	40245413          	srai	s0,s0,0x2
   1024c:	00000493          	li	s1,0
   10250:	0f078913          	addi	s2,a5,240
   10254:	00941e63          	bne	s0,s1,10270 <__libc_fini_array+0x50>
   10258:	00812403          	lw	s0,8(sp)
   1025c:	00c12083          	lw	ra,12(sp)
   10260:	00412483          	lw	s1,4(sp)
   10264:	00012903          	lw	s2,0(sp)
   10268:	01010113          	addi	sp,sp,16
   1026c:	e75ff06f          	j	100e0 <_fini>
   10270:	ffc00593          	li	a1,-4
   10274:	00048513          	mv	a0,s1
   10278:	541020ef          	jal	ra,12fb8 <__mulsi3>
   1027c:	00a90533          	add	a0,s2,a0
   10280:	ffc52783          	lw	a5,-4(a0)
   10284:	00148493          	addi	s1,s1,1
   10288:	000780e7          	jalr	a5
   1028c:	fc9ff06f          	j	10254 <__libc_fini_array+0x34>

00010290 <__libc_init_array>:
   10290:	ff010113          	addi	sp,sp,-16
   10294:	00812423          	sw	s0,8(sp)
   10298:	00912223          	sw	s1,4(sp)
   1029c:	00014437          	lui	s0,0x14
   102a0:	000144b7          	lui	s1,0x14
   102a4:	0e848793          	addi	a5,s1,232 # 140e8 <__frame_dummy_init_array_entry>
   102a8:	0e840413          	addi	s0,s0,232 # 140e8 <__frame_dummy_init_array_entry>
   102ac:	40f40433          	sub	s0,s0,a5
   102b0:	01212023          	sw	s2,0(sp)
   102b4:	00112623          	sw	ra,12(sp)
   102b8:	40245413          	srai	s0,s0,0x2
   102bc:	0e848493          	addi	s1,s1,232
   102c0:	00000913          	li	s2,0
   102c4:	04891263          	bne	s2,s0,10308 <__libc_init_array+0x78>
   102c8:	000144b7          	lui	s1,0x14
   102cc:	e15ff0ef          	jal	ra,100e0 <_fini>
   102d0:	00014437          	lui	s0,0x14
   102d4:	0e848793          	addi	a5,s1,232 # 140e8 <__frame_dummy_init_array_entry>
   102d8:	0ec40413          	addi	s0,s0,236 # 140ec <__init_array_end>
   102dc:	40f40433          	sub	s0,s0,a5
   102e0:	40245413          	srai	s0,s0,0x2
   102e4:	0e848493          	addi	s1,s1,232
   102e8:	00000913          	li	s2,0
   102ec:	02891863          	bne	s2,s0,1031c <__libc_init_array+0x8c>
   102f0:	00c12083          	lw	ra,12(sp)
   102f4:	00812403          	lw	s0,8(sp)
   102f8:	00412483          	lw	s1,4(sp)
   102fc:	00012903          	lw	s2,0(sp)
   10300:	01010113          	addi	sp,sp,16
   10304:	00008067          	ret
   10308:	0004a783          	lw	a5,0(s1)
   1030c:	00190913          	addi	s2,s2,1
   10310:	00448493          	addi	s1,s1,4
   10314:	000780e7          	jalr	a5
   10318:	fadff06f          	j	102c4 <__libc_init_array+0x34>
   1031c:	0004a783          	lw	a5,0(s1)
   10320:	00190913          	addi	s2,s2,1
   10324:	00448493          	addi	s1,s1,4
   10328:	000780e7          	jalr	a5
   1032c:	fc1ff06f          	j	102ec <__libc_init_array+0x5c>

00010330 <memset>:
   10330:	00f00813          	li	a6,15
   10334:	00050713          	mv	a4,a0
   10338:	02c87e63          	bleu	a2,a6,10374 <memset+0x44>
   1033c:	00f77793          	andi	a5,a4,15
   10340:	0a079063          	bnez	a5,103e0 <memset+0xb0>
   10344:	08059263          	bnez	a1,103c8 <memset+0x98>
   10348:	ff067693          	andi	a3,a2,-16
   1034c:	00f67613          	andi	a2,a2,15
   10350:	00e686b3          	add	a3,a3,a4
   10354:	00b72023          	sw	a1,0(a4)
   10358:	00b72223          	sw	a1,4(a4)
   1035c:	00b72423          	sw	a1,8(a4)
   10360:	00b72623          	sw	a1,12(a4)
   10364:	01070713          	addi	a4,a4,16
   10368:	fed766e3          	bltu	a4,a3,10354 <memset+0x24>
   1036c:	00061463          	bnez	a2,10374 <memset+0x44>
   10370:	00008067          	ret
   10374:	40c806b3          	sub	a3,a6,a2
   10378:	00269693          	slli	a3,a3,0x2
   1037c:	00000297          	auipc	t0,0x0
   10380:	005686b3          	add	a3,a3,t0
   10384:	00c68067          	jr	12(a3)
   10388:	00b70723          	sb	a1,14(a4)
   1038c:	00b706a3          	sb	a1,13(a4)
   10390:	00b70623          	sb	a1,12(a4)
   10394:	00b705a3          	sb	a1,11(a4)
   10398:	00b70523          	sb	a1,10(a4)
   1039c:	00b704a3          	sb	a1,9(a4)
   103a0:	00b70423          	sb	a1,8(a4)
   103a4:	00b703a3          	sb	a1,7(a4)
   103a8:	00b70323          	sb	a1,6(a4)
   103ac:	00b702a3          	sb	a1,5(a4)
   103b0:	00b70223          	sb	a1,4(a4)
   103b4:	00b701a3          	sb	a1,3(a4)
   103b8:	00b70123          	sb	a1,2(a4)
   103bc:	00b700a3          	sb	a1,1(a4)
   103c0:	00b70023          	sb	a1,0(a4)
   103c4:	00008067          	ret
   103c8:	0ff5f593          	andi	a1,a1,255
   103cc:	00859693          	slli	a3,a1,0x8
   103d0:	00d5e5b3          	or	a1,a1,a3
   103d4:	01059693          	slli	a3,a1,0x10
   103d8:	00d5e5b3          	or	a1,a1,a3
   103dc:	f6dff06f          	j	10348 <memset+0x18>
   103e0:	00279693          	slli	a3,a5,0x2
   103e4:	00000297          	auipc	t0,0x0
   103e8:	005686b3          	add	a3,a3,t0
   103ec:	00008293          	mv	t0,ra
   103f0:	fa0680e7          	jalr	-96(a3)
   103f4:	00028093          	mv	ra,t0
   103f8:	ff078793          	addi	a5,a5,-16
   103fc:	40f70733          	sub	a4,a4,a5
   10400:	00f60633          	add	a2,a2,a5
   10404:	f6c878e3          	bleu	a2,a6,10374 <memset+0x44>
   10408:	f3dff06f          	j	10344 <memset+0x14>

0001040c <_puts_r>:
   1040c:	fc010113          	addi	sp,sp,-64
   10410:	02812c23          	sw	s0,56(sp)
   10414:	00050413          	mv	s0,a0
   10418:	00058513          	mv	a0,a1
   1041c:	00b12623          	sw	a1,12(sp)
   10420:	02112e23          	sw	ra,60(sp)
   10424:	0bc000ef          	jal	ra,104e0 <strlen>
   10428:	000137b7          	lui	a5,0x13
   1042c:	0a078793          	addi	a5,a5,160 # 130a0 <__modsi3+0x40>
   10430:	02f12423          	sw	a5,40(sp)
   10434:	00100793          	li	a5,1
   10438:	02f12623          	sw	a5,44(sp)
   1043c:	02010793          	addi	a5,sp,32
   10440:	00c12583          	lw	a1,12(sp)
   10444:	00f12a23          	sw	a5,20(sp)
   10448:	00200793          	li	a5,2
   1044c:	00f12c23          	sw	a5,24(sp)
   10450:	03842783          	lw	a5,56(s0)
   10454:	02a12223          	sw	a0,36(sp)
   10458:	00150513          	addi	a0,a0,1
   1045c:	02b12023          	sw	a1,32(sp)
   10460:	00a12e23          	sw	a0,28(sp)
   10464:	00842583          	lw	a1,8(s0)
   10468:	00079a63          	bnez	a5,1047c <_puts_r+0x70>
   1046c:	00040513          	mv	a0,s0
   10470:	00b12623          	sw	a1,12(sp)
   10474:	340000ef          	jal	ra,107b4 <__sinit>
   10478:	00c12583          	lw	a1,12(sp)
   1047c:	00c59783          	lh	a5,12(a1)
   10480:	01279713          	slli	a4,a5,0x12
   10484:	02074263          	bltz	a4,104a8 <_puts_r+0x9c>
   10488:	000026b7          	lui	a3,0x2
   1048c:	0645a703          	lw	a4,100(a1)
   10490:	00d7e7b3          	or	a5,a5,a3
   10494:	00f59623          	sh	a5,12(a1)
   10498:	ffffe7b7          	lui	a5,0xffffe
   1049c:	fff78793          	addi	a5,a5,-1 # ffffdfff <__global_pointer$+0xfffe8edf>
   104a0:	00f777b3          	and	a5,a4,a5
   104a4:	06f5a223          	sw	a5,100(a1)
   104a8:	01410613          	addi	a2,sp,20
   104ac:	00040513          	mv	a0,s0
   104b0:	4a4000ef          	jal	ra,10954 <__sfvwrite_r>
   104b4:	fff00793          	li	a5,-1
   104b8:	00051463          	bnez	a0,104c0 <_puts_r+0xb4>
   104bc:	00a00793          	li	a5,10
   104c0:	03c12083          	lw	ra,60(sp)
   104c4:	03812403          	lw	s0,56(sp)
   104c8:	00078513          	mv	a0,a5
   104cc:	04010113          	addi	sp,sp,64
   104d0:	00008067          	ret

000104d4 <puts>:
   104d4:	00050593          	mv	a1,a0
   104d8:	8081a503          	lw	a0,-2040(gp) # 14928 <_impure_ptr>
   104dc:	f31ff06f          	j	1040c <_puts_r>

000104e0 <strlen>:
   104e0:	00050793          	mv	a5,a0
   104e4:	00178793          	addi	a5,a5,1
   104e8:	fff7c703          	lbu	a4,-1(a5)
   104ec:	fe071ce3          	bnez	a4,104e4 <strlen+0x4>
   104f0:	40a78533          	sub	a0,a5,a0
   104f4:	fff50513          	addi	a0,a0,-1
   104f8:	00008067          	ret

000104fc <__register_exitproc>:
   104fc:	000157b7          	lui	a5,0x15
   10500:	9247a703          	lw	a4,-1756(a5) # 14924 <_global_impure_ptr>
   10504:	00050313          	mv	t1,a0
   10508:	14872783          	lw	a5,328(a4)
   1050c:	00079663          	bnez	a5,10518 <__register_exitproc+0x1c>
   10510:	14c70793          	addi	a5,a4,332
   10514:	14f72423          	sw	a5,328(a4)
   10518:	0047a703          	lw	a4,4(a5)
   1051c:	01f00813          	li	a6,31
   10520:	fff00513          	li	a0,-1
   10524:	04e84a63          	blt	a6,a4,10578 <__register_exitproc+0x7c>
   10528:	00271893          	slli	a7,a4,0x2
   1052c:	02030c63          	beqz	t1,10564 <__register_exitproc+0x68>
   10530:	01178533          	add	a0,a5,a7
   10534:	08c52423          	sw	a2,136(a0)
   10538:	1887a803          	lw	a6,392(a5)
   1053c:	00100613          	li	a2,1
   10540:	00e61633          	sll	a2,a2,a4
   10544:	00c86833          	or	a6,a6,a2
   10548:	1907a423          	sw	a6,392(a5)
   1054c:	10d52423          	sw	a3,264(a0)
   10550:	00200693          	li	a3,2
   10554:	00d31863          	bne	t1,a3,10564 <__register_exitproc+0x68>
   10558:	18c7a683          	lw	a3,396(a5)
   1055c:	00c6e633          	or	a2,a3,a2
   10560:	18c7a623          	sw	a2,396(a5)
   10564:	00170713          	addi	a4,a4,1
   10568:	00e7a223          	sw	a4,4(a5)
   1056c:	011787b3          	add	a5,a5,a7
   10570:	00b7a423          	sw	a1,8(a5)
   10574:	00000513          	li	a0,0
   10578:	00008067          	ret

0001057c <__call_exitprocs>:
   1057c:	fd010113          	addi	sp,sp,-48
   10580:	000157b7          	lui	a5,0x15
   10584:	01312e23          	sw	s3,28(sp)
   10588:	9247a983          	lw	s3,-1756(a5) # 14924 <_global_impure_ptr>
   1058c:	01412c23          	sw	s4,24(sp)
   10590:	01512a23          	sw	s5,20(sp)
   10594:	01612823          	sw	s6,16(sp)
   10598:	02112623          	sw	ra,44(sp)
   1059c:	02812423          	sw	s0,40(sp)
   105a0:	02912223          	sw	s1,36(sp)
   105a4:	03212023          	sw	s2,32(sp)
   105a8:	01712623          	sw	s7,12(sp)
   105ac:	00050a93          	mv	s5,a0
   105b0:	00058a13          	mv	s4,a1
   105b4:	00100b13          	li	s6,1
   105b8:	1489a483          	lw	s1,328(s3)
   105bc:	00048c63          	beqz	s1,105d4 <__call_exitprocs+0x58>
   105c0:	0044a403          	lw	s0,4(s1)
   105c4:	fff40913          	addi	s2,s0,-1
   105c8:	00241413          	slli	s0,s0,0x2
   105cc:	00848433          	add	s0,s1,s0
   105d0:	02095863          	bgez	s2,10600 <__call_exitprocs+0x84>
   105d4:	02c12083          	lw	ra,44(sp)
   105d8:	02812403          	lw	s0,40(sp)
   105dc:	02412483          	lw	s1,36(sp)
   105e0:	02012903          	lw	s2,32(sp)
   105e4:	01c12983          	lw	s3,28(sp)
   105e8:	01812a03          	lw	s4,24(sp)
   105ec:	01412a83          	lw	s5,20(sp)
   105f0:	01012b03          	lw	s6,16(sp)
   105f4:	00c12b83          	lw	s7,12(sp)
   105f8:	03010113          	addi	sp,sp,48
   105fc:	00008067          	ret
   10600:	000a0c63          	beqz	s4,10618 <__call_exitprocs+0x9c>
   10604:	10442783          	lw	a5,260(s0)
   10608:	01478863          	beq	a5,s4,10618 <__call_exitprocs+0x9c>
   1060c:	fff90913          	addi	s2,s2,-1
   10610:	ffc40413          	addi	s0,s0,-4
   10614:	fbdff06f          	j	105d0 <__call_exitprocs+0x54>
   10618:	0044a703          	lw	a4,4(s1)
   1061c:	00442783          	lw	a5,4(s0)
   10620:	fff70713          	addi	a4,a4,-1
   10624:	03271c63          	bne	a4,s2,1065c <__call_exitprocs+0xe0>
   10628:	0124a223          	sw	s2,4(s1)
   1062c:	fe0780e3          	beqz	a5,1060c <__call_exitprocs+0x90>
   10630:	1884a683          	lw	a3,392(s1)
   10634:	012b1733          	sll	a4,s6,s2
   10638:	0044ab83          	lw	s7,4(s1)
   1063c:	00d776b3          	and	a3,a4,a3
   10640:	02069263          	bnez	a3,10664 <__call_exitprocs+0xe8>
   10644:	000780e7          	jalr	a5
   10648:	0044a703          	lw	a4,4(s1)
   1064c:	1489a783          	lw	a5,328(s3)
   10650:	f77714e3          	bne	a4,s7,105b8 <__call_exitprocs+0x3c>
   10654:	faf48ce3          	beq	s1,a5,1060c <__call_exitprocs+0x90>
   10658:	f61ff06f          	j	105b8 <__call_exitprocs+0x3c>
   1065c:	00042223          	sw	zero,4(s0)
   10660:	fcdff06f          	j	1062c <__call_exitprocs+0xb0>
   10664:	18c4a683          	lw	a3,396(s1)
   10668:	08442583          	lw	a1,132(s0)
   1066c:	00d77733          	and	a4,a4,a3
   10670:	00071863          	bnez	a4,10680 <__call_exitprocs+0x104>
   10674:	000a8513          	mv	a0,s5
   10678:	000780e7          	jalr	a5
   1067c:	fcdff06f          	j	10648 <__call_exitprocs+0xcc>
   10680:	00058513          	mv	a0,a1
   10684:	000780e7          	jalr	a5
   10688:	fc1ff06f          	j	10648 <__call_exitprocs+0xcc>

0001068c <__fp_lock>:
   1068c:	00000513          	li	a0,0
   10690:	00008067          	ret

00010694 <_cleanup_r>:
   10694:	000125b7          	lui	a1,0x12
   10698:	f6058593          	addi	a1,a1,-160 # 11f60 <_fclose_r>
   1069c:	7bc0006f          	j	10e58 <_fwalk_reent>

000106a0 <std.isra.0>:
   106a0:	ff010113          	addi	sp,sp,-16
   106a4:	00812423          	sw	s0,8(sp)
   106a8:	00112623          	sw	ra,12(sp)
   106ac:	00050413          	mv	s0,a0
   106b0:	00b51623          	sh	a1,12(a0)
   106b4:	00c51723          	sh	a2,14(a0)
   106b8:	00052023          	sw	zero,0(a0)
   106bc:	00052223          	sw	zero,4(a0)
   106c0:	00052423          	sw	zero,8(a0)
   106c4:	06052223          	sw	zero,100(a0)
   106c8:	00052823          	sw	zero,16(a0)
   106cc:	00052a23          	sw	zero,20(a0)
   106d0:	00052c23          	sw	zero,24(a0)
   106d4:	00800613          	li	a2,8
   106d8:	00000593          	li	a1,0
   106dc:	05c50513          	addi	a0,a0,92
   106e0:	c51ff0ef          	jal	ra,10330 <memset>
   106e4:	000127b7          	lui	a5,0x12
   106e8:	c5878793          	addi	a5,a5,-936 # 11c58 <__sread>
   106ec:	02f42023          	sw	a5,32(s0)
   106f0:	000127b7          	lui	a5,0x12
   106f4:	cb078793          	addi	a5,a5,-848 # 11cb0 <__swrite>
   106f8:	02f42223          	sw	a5,36(s0)
   106fc:	000127b7          	lui	a5,0x12
   10700:	d3478793          	addi	a5,a5,-716 # 11d34 <__sseek>
   10704:	02f42423          	sw	a5,40(s0)
   10708:	000127b7          	lui	a5,0x12
   1070c:	d8c78793          	addi	a5,a5,-628 # 11d8c <__sclose>
   10710:	00842e23          	sw	s0,28(s0)
   10714:	02f42623          	sw	a5,44(s0)
   10718:	00c12083          	lw	ra,12(sp)
   1071c:	00812403          	lw	s0,8(sp)
   10720:	01010113          	addi	sp,sp,16
   10724:	00008067          	ret

00010728 <__fp_unlock>:
   10728:	00000513          	li	a0,0
   1072c:	00008067          	ret

00010730 <__sfmoreglue>:
   10730:	ff010113          	addi	sp,sp,-16
   10734:	01212023          	sw	s2,0(sp)
   10738:	00058913          	mv	s2,a1
   1073c:	00812423          	sw	s0,8(sp)
   10740:	06800593          	li	a1,104
   10744:	00050413          	mv	s0,a0
   10748:	fff90513          	addi	a0,s2,-1
   1074c:	00112623          	sw	ra,12(sp)
   10750:	00912223          	sw	s1,4(sp)
   10754:	065020ef          	jal	ra,12fb8 <__mulsi3>
   10758:	07450593          	addi	a1,a0,116
   1075c:	00050493          	mv	s1,a0
   10760:	00040513          	mv	a0,s0
   10764:	7a8000ef          	jal	ra,10f0c <_malloc_r>
   10768:	00050413          	mv	s0,a0
   1076c:	02050063          	beqz	a0,1078c <__sfmoreglue+0x5c>
   10770:	00052023          	sw	zero,0(a0)
   10774:	01252223          	sw	s2,4(a0)
   10778:	00c50513          	addi	a0,a0,12
   1077c:	00a42423          	sw	a0,8(s0)
   10780:	06848613          	addi	a2,s1,104
   10784:	00000593          	li	a1,0
   10788:	ba9ff0ef          	jal	ra,10330 <memset>
   1078c:	00040513          	mv	a0,s0
   10790:	00c12083          	lw	ra,12(sp)
   10794:	00812403          	lw	s0,8(sp)
   10798:	00412483          	lw	s1,4(sp)
   1079c:	00012903          	lw	s2,0(sp)
   107a0:	01010113          	addi	sp,sp,16
   107a4:	00008067          	ret

000107a8 <_cleanup>:
   107a8:	000157b7          	lui	a5,0x15
   107ac:	9247a503          	lw	a0,-1756(a5) # 14924 <_global_impure_ptr>
   107b0:	ee5ff06f          	j	10694 <_cleanup_r>

000107b4 <__sinit>:
   107b4:	03852783          	lw	a5,56(a0)
   107b8:	06079e63          	bnez	a5,10834 <__sinit+0x80>
   107bc:	ff010113          	addi	sp,sp,-16
   107c0:	000107b7          	lui	a5,0x10
   107c4:	00112623          	sw	ra,12(sp)
   107c8:	00812423          	sw	s0,8(sp)
   107cc:	69478793          	addi	a5,a5,1684 # 10694 <_cleanup_r>
   107d0:	02f52e23          	sw	a5,60(a0)
   107d4:	00300793          	li	a5,3
   107d8:	2ef52223          	sw	a5,740(a0)
   107dc:	2ec50793          	addi	a5,a0,748
   107e0:	00050413          	mv	s0,a0
   107e4:	2ef52423          	sw	a5,744(a0)
   107e8:	2e052023          	sw	zero,736(a0)
   107ec:	00452503          	lw	a0,4(a0)
   107f0:	00000613          	li	a2,0
   107f4:	00400593          	li	a1,4
   107f8:	ea9ff0ef          	jal	ra,106a0 <std.isra.0>
   107fc:	00842503          	lw	a0,8(s0)
   10800:	00100613          	li	a2,1
   10804:	00900593          	li	a1,9
   10808:	e99ff0ef          	jal	ra,106a0 <std.isra.0>
   1080c:	00c42503          	lw	a0,12(s0)
   10810:	00200613          	li	a2,2
   10814:	01200593          	li	a1,18
   10818:	e89ff0ef          	jal	ra,106a0 <std.isra.0>
   1081c:	00100793          	li	a5,1
   10820:	02f42c23          	sw	a5,56(s0)
   10824:	00c12083          	lw	ra,12(sp)
   10828:	00812403          	lw	s0,8(sp)
   1082c:	01010113          	addi	sp,sp,16
   10830:	00008067          	ret
   10834:	00008067          	ret

00010838 <__sfp>:
   10838:	ff010113          	addi	sp,sp,-16
   1083c:	000157b7          	lui	a5,0x15
   10840:	00912223          	sw	s1,4(sp)
   10844:	9247a483          	lw	s1,-1756(a5) # 14924 <_global_impure_ptr>
   10848:	01212023          	sw	s2,0(sp)
   1084c:	00112623          	sw	ra,12(sp)
   10850:	0384a783          	lw	a5,56(s1)
   10854:	00812423          	sw	s0,8(sp)
   10858:	00050913          	mv	s2,a0
   1085c:	00079663          	bnez	a5,10868 <__sfp+0x30>
   10860:	00048513          	mv	a0,s1
   10864:	f51ff0ef          	jal	ra,107b4 <__sinit>
   10868:	2e048493          	addi	s1,s1,736
   1086c:	0084a403          	lw	s0,8(s1)
   10870:	0044a783          	lw	a5,4(s1)
   10874:	fff78793          	addi	a5,a5,-1
   10878:	0007da63          	bgez	a5,1088c <__sfp+0x54>
   1087c:	0004a783          	lw	a5,0(s1)
   10880:	00078e63          	beqz	a5,1089c <__sfp+0x64>
   10884:	0004a483          	lw	s1,0(s1)
   10888:	fe5ff06f          	j	1086c <__sfp+0x34>
   1088c:	00c41703          	lh	a4,12(s0)
   10890:	04070463          	beqz	a4,108d8 <__sfp+0xa0>
   10894:	06840413          	addi	s0,s0,104
   10898:	fddff06f          	j	10874 <__sfp+0x3c>
   1089c:	00400593          	li	a1,4
   108a0:	00090513          	mv	a0,s2
   108a4:	e8dff0ef          	jal	ra,10730 <__sfmoreglue>
   108a8:	00a4a023          	sw	a0,0(s1)
   108ac:	fc051ce3          	bnez	a0,10884 <__sfp+0x4c>
   108b0:	00c00793          	li	a5,12
   108b4:	00f92023          	sw	a5,0(s2)
   108b8:	00000413          	li	s0,0
   108bc:	00040513          	mv	a0,s0
   108c0:	00c12083          	lw	ra,12(sp)
   108c4:	00812403          	lw	s0,8(sp)
   108c8:	00412483          	lw	s1,4(sp)
   108cc:	00012903          	lw	s2,0(sp)
   108d0:	01010113          	addi	sp,sp,16
   108d4:	00008067          	ret
   108d8:	ffff07b7          	lui	a5,0xffff0
   108dc:	00178793          	addi	a5,a5,1 # ffff0001 <__global_pointer$+0xfffdaee1>
   108e0:	06042223          	sw	zero,100(s0)
   108e4:	00042023          	sw	zero,0(s0)
   108e8:	00042223          	sw	zero,4(s0)
   108ec:	00042423          	sw	zero,8(s0)
   108f0:	00f42623          	sw	a5,12(s0)
   108f4:	00042823          	sw	zero,16(s0)
   108f8:	00042a23          	sw	zero,20(s0)
   108fc:	00042c23          	sw	zero,24(s0)
   10900:	00800613          	li	a2,8
   10904:	00000593          	li	a1,0
   10908:	05c40513          	addi	a0,s0,92
   1090c:	a25ff0ef          	jal	ra,10330 <memset>
   10910:	02042823          	sw	zero,48(s0)
   10914:	02042a23          	sw	zero,52(s0)
   10918:	04042223          	sw	zero,68(s0)
   1091c:	04042423          	sw	zero,72(s0)
   10920:	f9dff06f          	j	108bc <__sfp+0x84>

00010924 <__sfp_lock_acquire>:
   10924:	00008067          	ret

00010928 <__sfp_lock_release>:
   10928:	00008067          	ret

0001092c <__sinit_lock_acquire>:
   1092c:	00008067          	ret

00010930 <__sinit_lock_release>:
   10930:	00008067          	ret

00010934 <__fp_lock_all>:
   10934:	8081a503          	lw	a0,-2040(gp) # 14928 <_impure_ptr>
   10938:	000105b7          	lui	a1,0x10
   1093c:	68c58593          	addi	a1,a1,1676 # 1068c <__fp_lock>
   10940:	4780006f          	j	10db8 <_fwalk>

00010944 <__fp_unlock_all>:
   10944:	8081a503          	lw	a0,-2040(gp) # 14928 <_impure_ptr>
   10948:	000105b7          	lui	a1,0x10
   1094c:	72858593          	addi	a1,a1,1832 # 10728 <__fp_unlock>
   10950:	4680006f          	j	10db8 <_fwalk>

00010954 <__sfvwrite_r>:
   10954:	00862783          	lw	a5,8(a2)
   10958:	00079863          	bnez	a5,10968 <__sfvwrite_r+0x14>
   1095c:	00000793          	li	a5,0
   10960:	00078513          	mv	a0,a5
   10964:	00008067          	ret
   10968:	00c5d783          	lhu	a5,12(a1)
   1096c:	fc010113          	addi	sp,sp,-64
   10970:	02812c23          	sw	s0,56(sp)
   10974:	03212823          	sw	s2,48(sp)
   10978:	03612023          	sw	s6,32(sp)
   1097c:	02112e23          	sw	ra,60(sp)
   10980:	02912a23          	sw	s1,52(sp)
   10984:	03312623          	sw	s3,44(sp)
   10988:	03412423          	sw	s4,40(sp)
   1098c:	03512223          	sw	s5,36(sp)
   10990:	01712e23          	sw	s7,28(sp)
   10994:	01812c23          	sw	s8,24(sp)
   10998:	01912a23          	sw	s9,20(sp)
   1099c:	01a12823          	sw	s10,16(sp)
   109a0:	01b12623          	sw	s11,12(sp)
   109a4:	0087f793          	andi	a5,a5,8
   109a8:	00060b13          	mv	s6,a2
   109ac:	00058413          	mv	s0,a1
   109b0:	00050913          	mv	s2,a0
   109b4:	0e078263          	beqz	a5,10a98 <__sfvwrite_r+0x144>
   109b8:	0105a783          	lw	a5,16(a1)
   109bc:	0c078e63          	beqz	a5,10a98 <__sfvwrite_r+0x144>
   109c0:	00c45783          	lhu	a5,12(s0)
   109c4:	000b2a03          	lw	s4,0(s6)
   109c8:	0027f713          	andi	a4,a5,2
   109cc:	16071a63          	bnez	a4,10b40 <__sfvwrite_r+0x1ec>
   109d0:	0017f793          	andi	a5,a5,1
   109d4:	00000b93          	li	s7,0
   109d8:	20078a63          	beqz	a5,10bec <__sfvwrite_r+0x298>
   109dc:	00000513          	li	a0,0
   109e0:	00000a93          	li	s5,0
   109e4:	00000993          	li	s3,0
   109e8:	36098663          	beqz	s3,10d54 <__sfvwrite_r+0x400>
   109ec:	02051263          	bnez	a0,10a10 <__sfvwrite_r+0xbc>
   109f0:	00098613          	mv	a2,s3
   109f4:	00a00593          	li	a1,10
   109f8:	000a8513          	mv	a0,s5
   109fc:	355000ef          	jal	ra,11550 <memchr>
   10a00:	00198b93          	addi	s7,s3,1
   10a04:	00050663          	beqz	a0,10a10 <__sfvwrite_r+0xbc>
   10a08:	00150513          	addi	a0,a0,1
   10a0c:	41550bb3          	sub	s7,a0,s5
   10a10:	000b8c13          	mv	s8,s7
   10a14:	0179f463          	bleu	s7,s3,10a1c <__sfvwrite_r+0xc8>
   10a18:	00098c13          	mv	s8,s3
   10a1c:	00042503          	lw	a0,0(s0)
   10a20:	01042783          	lw	a5,16(s0)
   10a24:	01442683          	lw	a3,20(s0)
   10a28:	34a7f063          	bleu	a0,a5,10d68 <__sfvwrite_r+0x414>
   10a2c:	00842483          	lw	s1,8(s0)
   10a30:	009684b3          	add	s1,a3,s1
   10a34:	3384da63          	ble	s8,s1,10d68 <__sfvwrite_r+0x414>
   10a38:	000a8593          	mv	a1,s5
   10a3c:	00048613          	mv	a2,s1
   10a40:	41d000ef          	jal	ra,1165c <memmove>
   10a44:	00042783          	lw	a5,0(s0)
   10a48:	00040593          	mv	a1,s0
   10a4c:	00090513          	mv	a0,s2
   10a50:	009787b3          	add	a5,a5,s1
   10a54:	00f42023          	sw	a5,0(s0)
   10a58:	7f8010ef          	jal	ra,12250 <_fflush_r>
   10a5c:	16051e63          	bnez	a0,10bd8 <__sfvwrite_r+0x284>
   10a60:	409b8bb3          	sub	s7,s7,s1
   10a64:	00100513          	li	a0,1
   10a68:	000b9a63          	bnez	s7,10a7c <__sfvwrite_r+0x128>
   10a6c:	00040593          	mv	a1,s0
   10a70:	00090513          	mv	a0,s2
   10a74:	7dc010ef          	jal	ra,12250 <_fflush_r>
   10a78:	16051063          	bnez	a0,10bd8 <__sfvwrite_r+0x284>
   10a7c:	008b2783          	lw	a5,8(s6)
   10a80:	009a8ab3          	add	s5,s5,s1
   10a84:	409989b3          	sub	s3,s3,s1
   10a88:	409784b3          	sub	s1,a5,s1
   10a8c:	009b2423          	sw	s1,8(s6)
   10a90:	f4049ce3          	bnez	s1,109e8 <__sfvwrite_r+0x94>
   10a94:	0680006f          	j	10afc <__sfvwrite_r+0x1a8>
   10a98:	00040593          	mv	a1,s0
   10a9c:	00090513          	mv	a0,s2
   10aa0:	344010ef          	jal	ra,11de4 <__swsetup_r>
   10aa4:	fff00793          	li	a5,-1
   10aa8:	f0050ce3          	beqz	a0,109c0 <__sfvwrite_r+0x6c>
   10aac:	0540006f          	j	10b00 <__sfvwrite_r+0x1ac>
   10ab0:	000a2983          	lw	s3,0(s4)
   10ab4:	004a2483          	lw	s1,4(s4)
   10ab8:	008a0a13          	addi	s4,s4,8
   10abc:	fe048ae3          	beqz	s1,10ab0 <__sfvwrite_r+0x15c>
   10ac0:	00048693          	mv	a3,s1
   10ac4:	009af463          	bleu	s1,s5,10acc <__sfvwrite_r+0x178>
   10ac8:	000a8693          	mv	a3,s5
   10acc:	02442783          	lw	a5,36(s0)
   10ad0:	01c42583          	lw	a1,28(s0)
   10ad4:	00098613          	mv	a2,s3
   10ad8:	00090513          	mv	a0,s2
   10adc:	000780e7          	jalr	a5
   10ae0:	0ea05c63          	blez	a0,10bd8 <__sfvwrite_r+0x284>
   10ae4:	008b2783          	lw	a5,8(s6)
   10ae8:	00a989b3          	add	s3,s3,a0
   10aec:	40a484b3          	sub	s1,s1,a0
   10af0:	40a78533          	sub	a0,a5,a0
   10af4:	00ab2423          	sw	a0,8(s6)
   10af8:	fc0512e3          	bnez	a0,10abc <__sfvwrite_r+0x168>
   10afc:	00000793          	li	a5,0
   10b00:	03c12083          	lw	ra,60(sp)
   10b04:	03812403          	lw	s0,56(sp)
   10b08:	03412483          	lw	s1,52(sp)
   10b0c:	03012903          	lw	s2,48(sp)
   10b10:	02c12983          	lw	s3,44(sp)
   10b14:	02812a03          	lw	s4,40(sp)
   10b18:	02412a83          	lw	s5,36(sp)
   10b1c:	02012b03          	lw	s6,32(sp)
   10b20:	01c12b83          	lw	s7,28(sp)
   10b24:	01812c03          	lw	s8,24(sp)
   10b28:	01412c83          	lw	s9,20(sp)
   10b2c:	01012d03          	lw	s10,16(sp)
   10b30:	00c12d83          	lw	s11,12(sp)
   10b34:	00078513          	mv	a0,a5
   10b38:	04010113          	addi	sp,sp,64
   10b3c:	00008067          	ret
   10b40:	80000ab7          	lui	s5,0x80000
   10b44:	00000993          	li	s3,0
   10b48:	00000493          	li	s1,0
   10b4c:	c00aca93          	xori	s5,s5,-1024
   10b50:	f6dff06f          	j	10abc <__sfvwrite_r+0x168>
   10b54:	000a2b83          	lw	s7,0(s4)
   10b58:	004a2483          	lw	s1,4(s4)
   10b5c:	008a0a13          	addi	s4,s4,8
   10b60:	fe048ae3          	beqz	s1,10b54 <__sfvwrite_r+0x200>
   10b64:	00c45983          	lhu	s3,12(s0)
   10b68:	00842d83          	lw	s11,8(s0)
   10b6c:	00042503          	lw	a0,0(s0)
   10b70:	2009f793          	andi	a5,s3,512
   10b74:	14078463          	beqz	a5,10cbc <__sfvwrite_r+0x368>
   10b78:	0db4e063          	bltu	s1,s11,10c38 <__sfvwrite_r+0x2e4>
   10b7c:	4809f793          	andi	a5,s3,1152
   10b80:	0a078c63          	beqz	a5,10c38 <__sfvwrite_r+0x2e4>
   10b84:	01042d83          	lw	s11,16(s0)
   10b88:	00300593          	li	a1,3
   10b8c:	41b50d33          	sub	s10,a0,s11
   10b90:	01442503          	lw	a0,20(s0)
   10b94:	424020ef          	jal	ra,12fb8 <__mulsi3>
   10b98:	01f55a93          	srli	s5,a0,0x1f
   10b9c:	00aa8ab3          	add	s5,s5,a0
   10ba0:	001d0793          	addi	a5,s10,1
   10ba4:	401ada93          	srai	s5,s5,0x1
   10ba8:	009787b3          	add	a5,a5,s1
   10bac:	00faf463          	bleu	a5,s5,10bb4 <__sfvwrite_r+0x260>
   10bb0:	00078a93          	mv	s5,a5
   10bb4:	4009f993          	andi	s3,s3,1024
   10bb8:	0c098863          	beqz	s3,10c88 <__sfvwrite_r+0x334>
   10bbc:	000a8593          	mv	a1,s5
   10bc0:	00090513          	mv	a0,s2
   10bc4:	348000ef          	jal	ra,10f0c <_malloc_r>
   10bc8:	00050993          	mv	s3,a0
   10bcc:	02051a63          	bnez	a0,10c00 <__sfvwrite_r+0x2ac>
   10bd0:	00c00793          	li	a5,12
   10bd4:	00f92023          	sw	a5,0(s2)
   10bd8:	00c45783          	lhu	a5,12(s0)
   10bdc:	0407e793          	ori	a5,a5,64
   10be0:	00f41623          	sh	a5,12(s0)
   10be4:	fff00793          	li	a5,-1
   10be8:	f19ff06f          	j	10b00 <__sfvwrite_r+0x1ac>
   10bec:	80000c37          	lui	s8,0x80000
   10bf0:	ffec4c93          	xori	s9,s8,-2
   10bf4:	00000493          	li	s1,0
   10bf8:	fffc4c13          	not	s8,s8
   10bfc:	f65ff06f          	j	10b60 <__sfvwrite_r+0x20c>
   10c00:	01042583          	lw	a1,16(s0)
   10c04:	000d0613          	mv	a2,s10
   10c08:	16d000ef          	jal	ra,11574 <memcpy>
   10c0c:	00c45783          	lhu	a5,12(s0)
   10c10:	b7f7f793          	andi	a5,a5,-1153
   10c14:	0807e793          	ori	a5,a5,128
   10c18:	00f41623          	sh	a5,12(s0)
   10c1c:	01342823          	sw	s3,16(s0)
   10c20:	01542a23          	sw	s5,20(s0)
   10c24:	01a989b3          	add	s3,s3,s10
   10c28:	41aa8ab3          	sub	s5,s5,s10
   10c2c:	01342023          	sw	s3,0(s0)
   10c30:	00048d93          	mv	s11,s1
   10c34:	01542423          	sw	s5,8(s0)
   10c38:	00048993          	mv	s3,s1
   10c3c:	01b4f463          	bleu	s11,s1,10c44 <__sfvwrite_r+0x2f0>
   10c40:	00048d93          	mv	s11,s1
   10c44:	00042503          	lw	a0,0(s0)
   10c48:	000d8613          	mv	a2,s11
   10c4c:	000b8593          	mv	a1,s7
   10c50:	20d000ef          	jal	ra,1165c <memmove>
   10c54:	00842783          	lw	a5,8(s0)
   10c58:	41b787b3          	sub	a5,a5,s11
   10c5c:	00f42423          	sw	a5,8(s0)
   10c60:	00042783          	lw	a5,0(s0)
   10c64:	01b78db3          	add	s11,a5,s11
   10c68:	01b42023          	sw	s11,0(s0)
   10c6c:	008b2783          	lw	a5,8(s6)
   10c70:	013b8bb3          	add	s7,s7,s3
   10c74:	413484b3          	sub	s1,s1,s3
   10c78:	413789b3          	sub	s3,a5,s3
   10c7c:	013b2423          	sw	s3,8(s6)
   10c80:	ee0990e3          	bnez	s3,10b60 <__sfvwrite_r+0x20c>
   10c84:	e79ff06f          	j	10afc <__sfvwrite_r+0x1a8>
   10c88:	000a8613          	mv	a2,s5
   10c8c:	000d8593          	mv	a1,s11
   10c90:	00090513          	mv	a0,s2
   10c94:	225000ef          	jal	ra,116b8 <_realloc_r>
   10c98:	00050993          	mv	s3,a0
   10c9c:	f80510e3          	bnez	a0,10c1c <__sfvwrite_r+0x2c8>
   10ca0:	01042583          	lw	a1,16(s0)
   10ca4:	00090513          	mv	a0,s2
   10ca8:	734010ef          	jal	ra,123dc <_free_r>
   10cac:	00c45783          	lhu	a5,12(s0)
   10cb0:	f7f7f793          	andi	a5,a5,-129
   10cb4:	00f41623          	sh	a5,12(s0)
   10cb8:	f19ff06f          	j	10bd0 <__sfvwrite_r+0x27c>
   10cbc:	01042783          	lw	a5,16(s0)
   10cc0:	00a7e663          	bltu	a5,a0,10ccc <__sfvwrite_r+0x378>
   10cc4:	01442983          	lw	s3,20(s0)
   10cc8:	0534f663          	bleu	s3,s1,10d14 <__sfvwrite_r+0x3c0>
   10ccc:	000d8993          	mv	s3,s11
   10cd0:	01b4f463          	bleu	s11,s1,10cd8 <__sfvwrite_r+0x384>
   10cd4:	00048993          	mv	s3,s1
   10cd8:	00098613          	mv	a2,s3
   10cdc:	000b8593          	mv	a1,s7
   10ce0:	17d000ef          	jal	ra,1165c <memmove>
   10ce4:	00842783          	lw	a5,8(s0)
   10ce8:	00042703          	lw	a4,0(s0)
   10cec:	413787b3          	sub	a5,a5,s3
   10cf0:	01370733          	add	a4,a4,s3
   10cf4:	00f42423          	sw	a5,8(s0)
   10cf8:	00e42023          	sw	a4,0(s0)
   10cfc:	f60798e3          	bnez	a5,10c6c <__sfvwrite_r+0x318>
   10d00:	00040593          	mv	a1,s0
   10d04:	00090513          	mv	a0,s2
   10d08:	548010ef          	jal	ra,12250 <_fflush_r>
   10d0c:	f60500e3          	beqz	a0,10c6c <__sfvwrite_r+0x318>
   10d10:	ec9ff06f          	j	10bd8 <__sfvwrite_r+0x284>
   10d14:	000c0513          	mv	a0,s8
   10d18:	009ce463          	bltu	s9,s1,10d20 <__sfvwrite_r+0x3cc>
   10d1c:	00048513          	mv	a0,s1
   10d20:	00098593          	mv	a1,s3
   10d24:	2b8020ef          	jal	ra,12fdc <__divsi3>
   10d28:	00098593          	mv	a1,s3
   10d2c:	28c020ef          	jal	ra,12fb8 <__mulsi3>
   10d30:	02442783          	lw	a5,36(s0)
   10d34:	01c42583          	lw	a1,28(s0)
   10d38:	00050693          	mv	a3,a0
   10d3c:	000b8613          	mv	a2,s7
   10d40:	00090513          	mv	a0,s2
   10d44:	000780e7          	jalr	a5
   10d48:	00050993          	mv	s3,a0
   10d4c:	f2a040e3          	bgtz	a0,10c6c <__sfvwrite_r+0x318>
   10d50:	e89ff06f          	j	10bd8 <__sfvwrite_r+0x284>
   10d54:	000a2a83          	lw	s5,0(s4)
   10d58:	004a2983          	lw	s3,4(s4)
   10d5c:	00000513          	li	a0,0
   10d60:	008a0a13          	addi	s4,s4,8
   10d64:	c85ff06f          	j	109e8 <__sfvwrite_r+0x94>
   10d68:	02dc4263          	blt	s8,a3,10d8c <__sfvwrite_r+0x438>
   10d6c:	02442783          	lw	a5,36(s0)
   10d70:	01c42583          	lw	a1,28(s0)
   10d74:	000a8613          	mv	a2,s5
   10d78:	00090513          	mv	a0,s2
   10d7c:	000780e7          	jalr	a5
   10d80:	00050493          	mv	s1,a0
   10d84:	cca04ee3          	bgtz	a0,10a60 <__sfvwrite_r+0x10c>
   10d88:	e51ff06f          	j	10bd8 <__sfvwrite_r+0x284>
   10d8c:	000c0613          	mv	a2,s8
   10d90:	000a8593          	mv	a1,s5
   10d94:	0c9000ef          	jal	ra,1165c <memmove>
   10d98:	00842783          	lw	a5,8(s0)
   10d9c:	000c0493          	mv	s1,s8
   10da0:	418787b3          	sub	a5,a5,s8
   10da4:	00f42423          	sw	a5,8(s0)
   10da8:	00042783          	lw	a5,0(s0)
   10dac:	018787b3          	add	a5,a5,s8
   10db0:	00f42023          	sw	a5,0(s0)
   10db4:	cadff06f          	j	10a60 <__sfvwrite_r+0x10c>

00010db8 <_fwalk>:
   10db8:	fd010113          	addi	sp,sp,-48
   10dbc:	02812423          	sw	s0,40(sp)
   10dc0:	03212023          	sw	s2,32(sp)
   10dc4:	01412c23          	sw	s4,24(sp)
   10dc8:	01512a23          	sw	s5,20(sp)
   10dcc:	02112623          	sw	ra,44(sp)
   10dd0:	02912223          	sw	s1,36(sp)
   10dd4:	01312e23          	sw	s3,28(sp)
   10dd8:	2e050413          	addi	s0,a0,736
   10ddc:	00000913          	li	s2,0
   10de0:	00100a13          	li	s4,1
   10de4:	fff00a93          	li	s5,-1
   10de8:	02041663          	bnez	s0,10e14 <_fwalk+0x5c>
   10dec:	02c12083          	lw	ra,44(sp)
   10df0:	02812403          	lw	s0,40(sp)
   10df4:	00090513          	mv	a0,s2
   10df8:	02412483          	lw	s1,36(sp)
   10dfc:	02012903          	lw	s2,32(sp)
   10e00:	01c12983          	lw	s3,28(sp)
   10e04:	01812a03          	lw	s4,24(sp)
   10e08:	01412a83          	lw	s5,20(sp)
   10e0c:	03010113          	addi	sp,sp,48
   10e10:	00008067          	ret
   10e14:	00842483          	lw	s1,8(s0)
   10e18:	00442983          	lw	s3,4(s0)
   10e1c:	fff98993          	addi	s3,s3,-1
   10e20:	0009d663          	bgez	s3,10e2c <_fwalk+0x74>
   10e24:	00042403          	lw	s0,0(s0)
   10e28:	fc1ff06f          	j	10de8 <_fwalk+0x30>
   10e2c:	00c4d783          	lhu	a5,12(s1)
   10e30:	02fa7063          	bleu	a5,s4,10e50 <_fwalk+0x98>
   10e34:	00e49783          	lh	a5,14(s1)
   10e38:	01578c63          	beq	a5,s5,10e50 <_fwalk+0x98>
   10e3c:	00048513          	mv	a0,s1
   10e40:	00b12623          	sw	a1,12(sp)
   10e44:	000580e7          	jalr	a1
   10e48:	00c12583          	lw	a1,12(sp)
   10e4c:	00a96933          	or	s2,s2,a0
   10e50:	06848493          	addi	s1,s1,104
   10e54:	fc9ff06f          	j	10e1c <_fwalk+0x64>

00010e58 <_fwalk_reent>:
   10e58:	fd010113          	addi	sp,sp,-48
   10e5c:	02812423          	sw	s0,40(sp)
   10e60:	03212023          	sw	s2,32(sp)
   10e64:	01412c23          	sw	s4,24(sp)
   10e68:	01512a23          	sw	s5,20(sp)
   10e6c:	01612823          	sw	s6,16(sp)
   10e70:	01712623          	sw	s7,12(sp)
   10e74:	02112623          	sw	ra,44(sp)
   10e78:	02912223          	sw	s1,36(sp)
   10e7c:	01312e23          	sw	s3,28(sp)
   10e80:	00050a13          	mv	s4,a0
   10e84:	00058a93          	mv	s5,a1
   10e88:	2e050413          	addi	s0,a0,736
   10e8c:	00000913          	li	s2,0
   10e90:	00100b13          	li	s6,1
   10e94:	fff00b93          	li	s7,-1
   10e98:	02041a63          	bnez	s0,10ecc <_fwalk_reent+0x74>
   10e9c:	02c12083          	lw	ra,44(sp)
   10ea0:	02812403          	lw	s0,40(sp)
   10ea4:	00090513          	mv	a0,s2
   10ea8:	02412483          	lw	s1,36(sp)
   10eac:	02012903          	lw	s2,32(sp)
   10eb0:	01c12983          	lw	s3,28(sp)
   10eb4:	01812a03          	lw	s4,24(sp)
   10eb8:	01412a83          	lw	s5,20(sp)
   10ebc:	01012b03          	lw	s6,16(sp)
   10ec0:	00c12b83          	lw	s7,12(sp)
   10ec4:	03010113          	addi	sp,sp,48
   10ec8:	00008067          	ret
   10ecc:	00842483          	lw	s1,8(s0)
   10ed0:	00442983          	lw	s3,4(s0)
   10ed4:	fff98993          	addi	s3,s3,-1
   10ed8:	0009d663          	bgez	s3,10ee4 <_fwalk_reent+0x8c>
   10edc:	00042403          	lw	s0,0(s0)
   10ee0:	fb9ff06f          	j	10e98 <_fwalk_reent+0x40>
   10ee4:	00c4d783          	lhu	a5,12(s1)
   10ee8:	00fb7e63          	bleu	a5,s6,10f04 <_fwalk_reent+0xac>
   10eec:	00e49783          	lh	a5,14(s1)
   10ef0:	01778a63          	beq	a5,s7,10f04 <_fwalk_reent+0xac>
   10ef4:	00048593          	mv	a1,s1
   10ef8:	000a0513          	mv	a0,s4
   10efc:	000a80e7          	jalr	s5
   10f00:	00a96933          	or	s2,s2,a0
   10f04:	06848493          	addi	s1,s1,104
   10f08:	fcdff06f          	j	10ed4 <_fwalk_reent+0x7c>

00010f0c <_malloc_r>:
   10f0c:	fd010113          	addi	sp,sp,-48
   10f10:	02112623          	sw	ra,44(sp)
   10f14:	02812423          	sw	s0,40(sp)
   10f18:	02912223          	sw	s1,36(sp)
   10f1c:	03212023          	sw	s2,32(sp)
   10f20:	01312e23          	sw	s3,28(sp)
   10f24:	01412c23          	sw	s4,24(sp)
   10f28:	01512a23          	sw	s5,20(sp)
   10f2c:	01612823          	sw	s6,16(sp)
   10f30:	01712623          	sw	s7,12(sp)
   10f34:	01812423          	sw	s8,8(sp)
   10f38:	00b58793          	addi	a5,a1,11
   10f3c:	01600713          	li	a4,22
   10f40:	04f77463          	bleu	a5,a4,10f88 <_malloc_r+0x7c>
   10f44:	ff87f493          	andi	s1,a5,-8
   10f48:	0404d263          	bgez	s1,10f8c <_malloc_r+0x80>
   10f4c:	00c00793          	li	a5,12
   10f50:	00f52023          	sw	a5,0(a0)
   10f54:	00000513          	li	a0,0
   10f58:	02c12083          	lw	ra,44(sp)
   10f5c:	02812403          	lw	s0,40(sp)
   10f60:	02412483          	lw	s1,36(sp)
   10f64:	02012903          	lw	s2,32(sp)
   10f68:	01c12983          	lw	s3,28(sp)
   10f6c:	01812a03          	lw	s4,24(sp)
   10f70:	01412a83          	lw	s5,20(sp)
   10f74:	01012b03          	lw	s6,16(sp)
   10f78:	00c12b83          	lw	s7,12(sp)
   10f7c:	00812c03          	lw	s8,8(sp)
   10f80:	03010113          	addi	sp,sp,48
   10f84:	00008067          	ret
   10f88:	01000493          	li	s1,16
   10f8c:	fcb4e0e3          	bltu	s1,a1,10f4c <_malloc_r+0x40>
   10f90:	00050993          	mv	s3,a0
   10f94:	71c000ef          	jal	ra,116b0 <__malloc_lock>
   10f98:	00014937          	lui	s2,0x14
   10f9c:	1f700793          	li	a5,503
   10fa0:	51890913          	addi	s2,s2,1304 # 14518 <__malloc_av_>
   10fa4:	0497ea63          	bltu	a5,s1,10ff8 <_malloc_r+0xec>
   10fa8:	00848713          	addi	a4,s1,8
   10fac:	00e90733          	add	a4,s2,a4
   10fb0:	00472403          	lw	s0,4(a4)
   10fb4:	ff870693          	addi	a3,a4,-8
   10fb8:	0034d793          	srli	a5,s1,0x3
   10fbc:	00d41863          	bne	s0,a3,10fcc <_malloc_r+0xc0>
   10fc0:	00c72403          	lw	s0,12(a4)
   10fc4:	00278793          	addi	a5,a5,2
   10fc8:	08870063          	beq	a4,s0,11048 <_malloc_r+0x13c>
   10fcc:	00442783          	lw	a5,4(s0)
   10fd0:	00c42703          	lw	a4,12(s0)
   10fd4:	00842683          	lw	a3,8(s0)
   10fd8:	ffc7f793          	andi	a5,a5,-4
   10fdc:	00f407b3          	add	a5,s0,a5
   10fe0:	00e6a623          	sw	a4,12(a3) # 200c <main-0xe068>
   10fe4:	00d72423          	sw	a3,8(a4)
   10fe8:	0047a703          	lw	a4,4(a5)
   10fec:	00176713          	ori	a4,a4,1
   10ff0:	00e7a223          	sw	a4,4(a5)
   10ff4:	0a80006f          	j	1109c <_malloc_r+0x190>
   10ff8:	0094d713          	srli	a4,s1,0x9
   10ffc:	03f00793          	li	a5,63
   11000:	00070a63          	beqz	a4,11014 <_malloc_r+0x108>
   11004:	00400793          	li	a5,4
   11008:	0ae7e263          	bltu	a5,a4,110ac <_malloc_r+0x1a0>
   1100c:	0064d793          	srli	a5,s1,0x6
   11010:	03878793          	addi	a5,a5,56
   11014:	00178713          	addi	a4,a5,1
   11018:	00371713          	slli	a4,a4,0x3
   1101c:	00e90733          	add	a4,s2,a4
   11020:	00472403          	lw	s0,4(a4)
   11024:	ff870593          	addi	a1,a4,-8
   11028:	00f00513          	li	a0,15
   1102c:	00b40c63          	beq	s0,a1,11044 <_malloc_r+0x138>
   11030:	00442703          	lw	a4,4(s0)
   11034:	ffc77713          	andi	a4,a4,-4
   11038:	40970633          	sub	a2,a4,s1
   1103c:	0cc55063          	ble	a2,a0,110fc <_malloc_r+0x1f0>
   11040:	fff78793          	addi	a5,a5,-1
   11044:	00178793          	addi	a5,a5,1
   11048:	01092403          	lw	s0,16(s2)
   1104c:	000145b7          	lui	a1,0x14
   11050:	00890693          	addi	a3,s2,8
   11054:	52058593          	addi	a1,a1,1312 # 14520 <__malloc_av_+0x8>
   11058:	12d40863          	beq	s0,a3,11188 <_malloc_r+0x27c>
   1105c:	00442703          	lw	a4,4(s0)
   11060:	00f00613          	li	a2,15
   11064:	ffc77713          	andi	a4,a4,-4
   11068:	40970533          	sub	a0,a4,s1
   1106c:	0aa65a63          	ble	a0,a2,11120 <_malloc_r+0x214>
   11070:	0014e793          	ori	a5,s1,1
   11074:	00f42223          	sw	a5,4(s0)
   11078:	00940633          	add	a2,s0,s1
   1107c:	00c92a23          	sw	a2,20(s2)
   11080:	00c92823          	sw	a2,16(s2)
   11084:	00156793          	ori	a5,a0,1
   11088:	00d62623          	sw	a3,12(a2)
   1108c:	00d62423          	sw	a3,8(a2)
   11090:	00f62223          	sw	a5,4(a2)
   11094:	00e40733          	add	a4,s0,a4
   11098:	00a72023          	sw	a0,0(a4)
   1109c:	00098513          	mv	a0,s3
   110a0:	614000ef          	jal	ra,116b4 <__malloc_unlock>
   110a4:	00840513          	addi	a0,s0,8
   110a8:	eb1ff06f          	j	10f58 <_malloc_r+0x4c>
   110ac:	01400793          	li	a5,20
   110b0:	00e7e663          	bltu	a5,a4,110bc <_malloc_r+0x1b0>
   110b4:	05b70793          	addi	a5,a4,91
   110b8:	f5dff06f          	j	11014 <_malloc_r+0x108>
   110bc:	05400793          	li	a5,84
   110c0:	00e7e863          	bltu	a5,a4,110d0 <_malloc_r+0x1c4>
   110c4:	00c4d793          	srli	a5,s1,0xc
   110c8:	06e78793          	addi	a5,a5,110
   110cc:	f49ff06f          	j	11014 <_malloc_r+0x108>
   110d0:	15400793          	li	a5,340
   110d4:	00e7e863          	bltu	a5,a4,110e4 <_malloc_r+0x1d8>
   110d8:	00f4d793          	srli	a5,s1,0xf
   110dc:	07778793          	addi	a5,a5,119
   110e0:	f35ff06f          	j	11014 <_malloc_r+0x108>
   110e4:	55400693          	li	a3,1364
   110e8:	07e00793          	li	a5,126
   110ec:	f2e6e4e3          	bltu	a3,a4,11014 <_malloc_r+0x108>
   110f0:	0124d793          	srli	a5,s1,0x12
   110f4:	07c78793          	addi	a5,a5,124
   110f8:	f1dff06f          	j	11014 <_malloc_r+0x108>
   110fc:	00c42683          	lw	a3,12(s0)
   11100:	00064c63          	bltz	a2,11118 <_malloc_r+0x20c>
   11104:	00842783          	lw	a5,8(s0)
   11108:	00d7a623          	sw	a3,12(a5)
   1110c:	00f6a423          	sw	a5,8(a3)
   11110:	00e407b3          	add	a5,s0,a4
   11114:	ed5ff06f          	j	10fe8 <_malloc_r+0xdc>
   11118:	00068413          	mv	s0,a3
   1111c:	f11ff06f          	j	1102c <_malloc_r+0x120>
   11120:	00d92a23          	sw	a3,20(s2)
   11124:	00d92823          	sw	a3,16(s2)
   11128:	00054c63          	bltz	a0,11140 <_malloc_r+0x234>
   1112c:	00e40733          	add	a4,s0,a4
   11130:	00472783          	lw	a5,4(a4)
   11134:	0017e793          	ori	a5,a5,1
   11138:	00f72223          	sw	a5,4(a4)
   1113c:	f61ff06f          	j	1109c <_malloc_r+0x190>
   11140:	1ff00693          	li	a3,511
   11144:	00492803          	lw	a6,4(s2)
   11148:	16e6e663          	bltu	a3,a4,112b4 <_malloc_r+0x3a8>
   1114c:	00375713          	srli	a4,a4,0x3
   11150:	40275613          	srai	a2,a4,0x2
   11154:	00100693          	li	a3,1
   11158:	00170713          	addi	a4,a4,1
   1115c:	00c696b3          	sll	a3,a3,a2
   11160:	00371713          	slli	a4,a4,0x3
   11164:	00e90733          	add	a4,s2,a4
   11168:	0106e6b3          	or	a3,a3,a6
   1116c:	00d92223          	sw	a3,4(s2)
   11170:	00072683          	lw	a3,0(a4)
   11174:	ff870613          	addi	a2,a4,-8
   11178:	00c42623          	sw	a2,12(s0)
   1117c:	00d42423          	sw	a3,8(s0)
   11180:	00872023          	sw	s0,0(a4)
   11184:	0086a623          	sw	s0,12(a3)
   11188:	4027d713          	srai	a4,a5,0x2
   1118c:	00100313          	li	t1,1
   11190:	00e31333          	sll	t1,t1,a4
   11194:	00492703          	lw	a4,4(s2)
   11198:	06676a63          	bltu	a4,t1,1120c <_malloc_r+0x300>
   1119c:	006776b3          	and	a3,a4,t1
   111a0:	00069c63          	bnez	a3,111b8 <_malloc_r+0x2ac>
   111a4:	ffc7f793          	andi	a5,a5,-4
   111a8:	00131313          	slli	t1,t1,0x1
   111ac:	006776b3          	and	a3,a4,t1
   111b0:	00478793          	addi	a5,a5,4
   111b4:	fe068ae3          	beqz	a3,111a8 <_malloc_r+0x29c>
   111b8:	00f00e13          	li	t3,15
   111bc:	00379693          	slli	a3,a5,0x3
   111c0:	00d906b3          	add	a3,s2,a3
   111c4:	00068813          	mv	a6,a3
   111c8:	00078513          	mv	a0,a5
   111cc:	00c82403          	lw	s0,12(a6)
   111d0:	1b041263          	bne	s0,a6,11374 <_malloc_r+0x468>
   111d4:	00150513          	addi	a0,a0,1
   111d8:	00357713          	andi	a4,a0,3
   111dc:	00880813          	addi	a6,a6,8
   111e0:	fe0716e3          	bnez	a4,111cc <_malloc_r+0x2c0>
   111e4:	0037f713          	andi	a4,a5,3
   111e8:	20071463          	bnez	a4,113f0 <_malloc_r+0x4e4>
   111ec:	00492703          	lw	a4,4(s2)
   111f0:	fff34793          	not	a5,t1
   111f4:	00f777b3          	and	a5,a4,a5
   111f8:	00f92223          	sw	a5,4(s2)
   111fc:	00492703          	lw	a4,4(s2)
   11200:	00131313          	slli	t1,t1,0x1
   11204:	00676463          	bltu	a4,t1,1120c <_malloc_r+0x300>
   11208:	20031863          	bnez	t1,11418 <_malloc_r+0x50c>
   1120c:	00892b83          	lw	s7,8(s2)
   11210:	004ba403          	lw	s0,4(s7)
   11214:	ffc47a93          	andi	s5,s0,-4
   11218:	009ae863          	bltu	s5,s1,11228 <_malloc_r+0x31c>
   1121c:	409a8733          	sub	a4,s5,s1
   11220:	00f00793          	li	a5,15
   11224:	30e7ca63          	blt	a5,a4,11538 <_malloc_r+0x62c>
   11228:	81c1a403          	lw	s0,-2020(gp) # 1493c <__malloc_top_pad>
   1122c:	80c1a703          	lw	a4,-2036(gp) # 1492c <__malloc_sbrk_base>
   11230:	fff00793          	li	a5,-1
   11234:	00848433          	add	s0,s1,s0
   11238:	1ef71463          	bne	a4,a5,11420 <_malloc_r+0x514>
   1123c:	01040413          	addi	s0,s0,16
   11240:	00040593          	mv	a1,s0
   11244:	00098513          	mv	a0,s3
   11248:	1c9000ef          	jal	ra,11c10 <_sbrk_r>
   1124c:	fff00793          	li	a5,-1
   11250:	00050b13          	mv	s6,a0
   11254:	26f50863          	beq	a0,a5,114c4 <_malloc_r+0x5b8>
   11258:	015b87b3          	add	a5,s7,s5
   1125c:	00f57463          	bleu	a5,a0,11264 <_malloc_r+0x358>
   11260:	272b9263          	bne	s7,s2,114c4 <_malloc_r+0x5b8>
   11264:	84818693          	addi	a3,gp,-1976 # 14968 <__malloc_current_mallinfo>
   11268:	0006a703          	lw	a4,0(a3)
   1126c:	84818c13          	addi	s8,gp,-1976 # 14968 <__malloc_current_mallinfo>
   11270:	00e40733          	add	a4,s0,a4
   11274:	00e6a023          	sw	a4,0(a3)
   11278:	1d679063          	bne	a5,s6,11438 <_malloc_r+0x52c>
   1127c:	01479693          	slli	a3,a5,0x14
   11280:	1a069c63          	bnez	a3,11438 <_malloc_r+0x52c>
   11284:	00892783          	lw	a5,8(s2)
   11288:	008a8433          	add	s0,s5,s0
   1128c:	00146413          	ori	s0,s0,1
   11290:	0087a223          	sw	s0,4(a5)
   11294:	000c2783          	lw	a5,0(s8) # 80000000 <__global_pointer$+0x7ffeaee0>
   11298:	8181a683          	lw	a3,-2024(gp) # 14938 <__malloc_max_sbrked_mem>
   1129c:	00f6f463          	bleu	a5,a3,112a4 <_malloc_r+0x398>
   112a0:	80f1ac23          	sw	a5,-2024(gp) # 14938 <__malloc_max_sbrked_mem>
   112a4:	8141a683          	lw	a3,-2028(gp) # 14934 <_edata>
   112a8:	20f6fe63          	bleu	a5,a3,114c4 <_malloc_r+0x5b8>
   112ac:	80f1aa23          	sw	a5,-2028(gp) # 14934 <_edata>
   112b0:	2140006f          	j	114c4 <_malloc_r+0x5b8>
   112b4:	00975613          	srli	a2,a4,0x9
   112b8:	00400693          	li	a3,4
   112bc:	04c6e663          	bltu	a3,a2,11308 <_malloc_r+0x3fc>
   112c0:	00675693          	srli	a3,a4,0x6
   112c4:	03868693          	addi	a3,a3,56
   112c8:	00168613          	addi	a2,a3,1
   112cc:	00361613          	slli	a2,a2,0x3
   112d0:	00c90633          	add	a2,s2,a2
   112d4:	ff860513          	addi	a0,a2,-8
   112d8:	00062603          	lw	a2,0(a2)
   112dc:	08c51263          	bne	a0,a2,11360 <_malloc_r+0x454>
   112e0:	4026d693          	srai	a3,a3,0x2
   112e4:	00100713          	li	a4,1
   112e8:	00d716b3          	sll	a3,a4,a3
   112ec:	0106e6b3          	or	a3,a3,a6
   112f0:	00d92223          	sw	a3,4(s2)
   112f4:	00a42623          	sw	a0,12(s0)
   112f8:	00c42423          	sw	a2,8(s0)
   112fc:	00852423          	sw	s0,8(a0)
   11300:	00862623          	sw	s0,12(a2)
   11304:	e85ff06f          	j	11188 <_malloc_r+0x27c>
   11308:	01400693          	li	a3,20
   1130c:	00c6e663          	bltu	a3,a2,11318 <_malloc_r+0x40c>
   11310:	05b60693          	addi	a3,a2,91
   11314:	fb5ff06f          	j	112c8 <_malloc_r+0x3bc>
   11318:	05400693          	li	a3,84
   1131c:	00c6e863          	bltu	a3,a2,1132c <_malloc_r+0x420>
   11320:	00c75693          	srli	a3,a4,0xc
   11324:	06e68693          	addi	a3,a3,110
   11328:	fa1ff06f          	j	112c8 <_malloc_r+0x3bc>
   1132c:	15400693          	li	a3,340
   11330:	00c6e863          	bltu	a3,a2,11340 <_malloc_r+0x434>
   11334:	00f75693          	srli	a3,a4,0xf
   11338:	07768693          	addi	a3,a3,119
   1133c:	f8dff06f          	j	112c8 <_malloc_r+0x3bc>
   11340:	55400513          	li	a0,1364
   11344:	07e00693          	li	a3,126
   11348:	f8c560e3          	bltu	a0,a2,112c8 <_malloc_r+0x3bc>
   1134c:	01275693          	srli	a3,a4,0x12
   11350:	07c68693          	addi	a3,a3,124
   11354:	f75ff06f          	j	112c8 <_malloc_r+0x3bc>
   11358:	00862603          	lw	a2,8(a2)
   1135c:	00c50863          	beq	a0,a2,1136c <_malloc_r+0x460>
   11360:	00462683          	lw	a3,4(a2)
   11364:	ffc6f693          	andi	a3,a3,-4
   11368:	fed768e3          	bltu	a4,a3,11358 <_malloc_r+0x44c>
   1136c:	00c62503          	lw	a0,12(a2)
   11370:	f85ff06f          	j	112f4 <_malloc_r+0x3e8>
   11374:	00442703          	lw	a4,4(s0)
   11378:	00c42603          	lw	a2,12(s0)
   1137c:	ffc77713          	andi	a4,a4,-4
   11380:	409708b3          	sub	a7,a4,s1
   11384:	051e5063          	ble	a7,t3,113c4 <_malloc_r+0x4b8>
   11388:	0014e793          	ori	a5,s1,1
   1138c:	00f42223          	sw	a5,4(s0)
   11390:	00842783          	lw	a5,8(s0)
   11394:	009406b3          	add	a3,s0,s1
   11398:	00e40733          	add	a4,s0,a4
   1139c:	00c7a623          	sw	a2,12(a5)
   113a0:	00f62423          	sw	a5,8(a2)
   113a4:	00d92a23          	sw	a3,20(s2)
   113a8:	00d92823          	sw	a3,16(s2)
   113ac:	0018e793          	ori	a5,a7,1
   113b0:	00b6a623          	sw	a1,12(a3)
   113b4:	00b6a423          	sw	a1,8(a3)
   113b8:	00f6a223          	sw	a5,4(a3)
   113bc:	01172023          	sw	a7,0(a4)
   113c0:	cddff06f          	j	1109c <_malloc_r+0x190>
   113c4:	0208c263          	bltz	a7,113e8 <_malloc_r+0x4dc>
   113c8:	00e40733          	add	a4,s0,a4
   113cc:	00472783          	lw	a5,4(a4)
   113d0:	0017e793          	ori	a5,a5,1
   113d4:	00f72223          	sw	a5,4(a4)
   113d8:	00842783          	lw	a5,8(s0)
   113dc:	00c7a623          	sw	a2,12(a5)
   113e0:	00f62423          	sw	a5,8(a2)
   113e4:	cb9ff06f          	j	1109c <_malloc_r+0x190>
   113e8:	00060413          	mv	s0,a2
   113ec:	de5ff06f          	j	111d0 <_malloc_r+0x2c4>
   113f0:	ff868713          	addi	a4,a3,-8
   113f4:	0006a683          	lw	a3,0(a3)
   113f8:	fff78793          	addi	a5,a5,-1
   113fc:	dee684e3          	beq	a3,a4,111e4 <_malloc_r+0x2d8>
   11400:	dfdff06f          	j	111fc <_malloc_r+0x2f0>
   11404:	00478793          	addi	a5,a5,4
   11408:	00131313          	slli	t1,t1,0x1
   1140c:	006776b3          	and	a3,a4,t1
   11410:	fe068ae3          	beqz	a3,11404 <_malloc_r+0x4f8>
   11414:	da9ff06f          	j	111bc <_malloc_r+0x2b0>
   11418:	00050793          	mv	a5,a0
   1141c:	ff1ff06f          	j	1140c <_malloc_r+0x500>
   11420:	000017b7          	lui	a5,0x1
   11424:	00f78793          	addi	a5,a5,15 # 100f <main-0xf065>
   11428:	00f40433          	add	s0,s0,a5
   1142c:	fffff7b7          	lui	a5,0xfffff
   11430:	00f47433          	and	s0,s0,a5
   11434:	e0dff06f          	j	11240 <_malloc_r+0x334>
   11438:	80c1a603          	lw	a2,-2036(gp) # 1492c <__malloc_sbrk_base>
   1143c:	fff00693          	li	a3,-1
   11440:	0ad61663          	bne	a2,a3,114ec <_malloc_r+0x5e0>
   11444:	8161a623          	sw	s6,-2036(gp) # 1492c <__malloc_sbrk_base>
   11448:	007b7593          	andi	a1,s6,7
   1144c:	00058863          	beqz	a1,1145c <_malloc_r+0x550>
   11450:	00800793          	li	a5,8
   11454:	40b785b3          	sub	a1,a5,a1
   11458:	00bb0b33          	add	s6,s6,a1
   1145c:	000017b7          	lui	a5,0x1
   11460:	00f585b3          	add	a1,a1,a5
   11464:	008b0433          	add	s0,s6,s0
   11468:	fff78793          	addi	a5,a5,-1 # fff <main-0xf075>
   1146c:	00f47433          	and	s0,s0,a5
   11470:	40858a33          	sub	s4,a1,s0
   11474:	000a0593          	mv	a1,s4
   11478:	00098513          	mv	a0,s3
   1147c:	794000ef          	jal	ra,11c10 <_sbrk_r>
   11480:	fff00793          	li	a5,-1
   11484:	00f51663          	bne	a0,a5,11490 <_malloc_r+0x584>
   11488:	000b0513          	mv	a0,s6
   1148c:	00000a13          	li	s4,0
   11490:	000c2783          	lw	a5,0(s8)
   11494:	41650533          	sub	a0,a0,s6
   11498:	01692423          	sw	s6,8(s2)
   1149c:	014787b3          	add	a5,a5,s4
   114a0:	01450a33          	add	s4,a0,s4
   114a4:	001a6a13          	ori	s4,s4,1
   114a8:	00fc2023          	sw	a5,0(s8)
   114ac:	014b2223          	sw	s4,4(s6)
   114b0:	df2b82e3          	beq	s7,s2,11294 <_malloc_r+0x388>
   114b4:	00f00713          	li	a4,15
   114b8:	05576263          	bltu	a4,s5,114fc <_malloc_r+0x5f0>
   114bc:	00100793          	li	a5,1
   114c0:	00fb2223          	sw	a5,4(s6)
   114c4:	00892783          	lw	a5,8(s2)
   114c8:	0047a783          	lw	a5,4(a5)
   114cc:	ffc7f793          	andi	a5,a5,-4
   114d0:	40978733          	sub	a4,a5,s1
   114d4:	0097e663          	bltu	a5,s1,114e0 <_malloc_r+0x5d4>
   114d8:	00f00793          	li	a5,15
   114dc:	04e7ce63          	blt	a5,a4,11538 <_malloc_r+0x62c>
   114e0:	00098513          	mv	a0,s3
   114e4:	1d0000ef          	jal	ra,116b4 <__malloc_unlock>
   114e8:	a6dff06f          	j	10f54 <_malloc_r+0x48>
   114ec:	40fb07b3          	sub	a5,s6,a5
   114f0:	00e787b3          	add	a5,a5,a4
   114f4:	00fc2023          	sw	a5,0(s8)
   114f8:	f51ff06f          	j	11448 <_malloc_r+0x53c>
   114fc:	004ba783          	lw	a5,4(s7)
   11500:	ff4a8413          	addi	s0,s5,-12 # 7ffffff4 <__global_pointer$+0x7ffeaed4>
   11504:	ff847413          	andi	s0,s0,-8
   11508:	0017f793          	andi	a5,a5,1
   1150c:	0087e7b3          	or	a5,a5,s0
   11510:	00fba223          	sw	a5,4(s7)
   11514:	00500693          	li	a3,5
   11518:	008b87b3          	add	a5,s7,s0
   1151c:	00d7a223          	sw	a3,4(a5)
   11520:	00d7a423          	sw	a3,8(a5)
   11524:	d68778e3          	bleu	s0,a4,11294 <_malloc_r+0x388>
   11528:	008b8593          	addi	a1,s7,8
   1152c:	00098513          	mv	a0,s3
   11530:	6ad000ef          	jal	ra,123dc <_free_r>
   11534:	d61ff06f          	j	11294 <_malloc_r+0x388>
   11538:	00892403          	lw	s0,8(s2)
   1153c:	0014e793          	ori	a5,s1,1
   11540:	00f42223          	sw	a5,4(s0)
   11544:	009407b3          	add	a5,s0,s1
   11548:	00f92423          	sw	a5,8(s2)
   1154c:	aa1ff06f          	j	10fec <_malloc_r+0xe0>

00011550 <memchr>:
   11550:	0ff5f593          	andi	a1,a1,255
   11554:	00c50633          	add	a2,a0,a2
   11558:	00c51663          	bne	a0,a2,11564 <memchr+0x14>
   1155c:	00000513          	li	a0,0
   11560:	00008067          	ret
   11564:	00054783          	lbu	a5,0(a0)
   11568:	feb78ce3          	beq	a5,a1,11560 <memchr+0x10>
   1156c:	00150513          	addi	a0,a0,1
   11570:	fe9ff06f          	j	11558 <memchr+0x8>

00011574 <memcpy>:
   11574:	00a5c7b3          	xor	a5,a1,a0
   11578:	0037f793          	andi	a5,a5,3
   1157c:	00c50733          	add	a4,a0,a2
   11580:	00079663          	bnez	a5,1158c <memcpy+0x18>
   11584:	00300793          	li	a5,3
   11588:	02c7e463          	bltu	a5,a2,115b0 <memcpy+0x3c>
   1158c:	00050793          	mv	a5,a0
   11590:	00e56c63          	bltu	a0,a4,115a8 <memcpy+0x34>
   11594:	00008067          	ret
   11598:	0005c683          	lbu	a3,0(a1)
   1159c:	00178793          	addi	a5,a5,1
   115a0:	00158593          	addi	a1,a1,1
   115a4:	fed78fa3          	sb	a3,-1(a5)
   115a8:	fee7e8e3          	bltu	a5,a4,11598 <memcpy+0x24>
   115ac:	00008067          	ret
   115b0:	00357793          	andi	a5,a0,3
   115b4:	08079263          	bnez	a5,11638 <memcpy+0xc4>
   115b8:	00050793          	mv	a5,a0
   115bc:	ffc77693          	andi	a3,a4,-4
   115c0:	fe068613          	addi	a2,a3,-32
   115c4:	08c7f663          	bleu	a2,a5,11650 <memcpy+0xdc>
   115c8:	0005a383          	lw	t2,0(a1)
   115cc:	0045a283          	lw	t0,4(a1)
   115d0:	0085af83          	lw	t6,8(a1)
   115d4:	00c5af03          	lw	t5,12(a1)
   115d8:	0105ae83          	lw	t4,16(a1)
   115dc:	0145ae03          	lw	t3,20(a1)
   115e0:	0185a303          	lw	t1,24(a1)
   115e4:	01c5a883          	lw	a7,28(a1)
   115e8:	02458593          	addi	a1,a1,36
   115ec:	02478793          	addi	a5,a5,36
   115f0:	ffc5a803          	lw	a6,-4(a1)
   115f4:	fc77ae23          	sw	t2,-36(a5)
   115f8:	fe57a023          	sw	t0,-32(a5)
   115fc:	fff7a223          	sw	t6,-28(a5)
   11600:	ffe7a423          	sw	t5,-24(a5)
   11604:	ffd7a623          	sw	t4,-20(a5)
   11608:	ffc7a823          	sw	t3,-16(a5)
   1160c:	fe67aa23          	sw	t1,-12(a5)
   11610:	ff17ac23          	sw	a7,-8(a5)
   11614:	ff07ae23          	sw	a6,-4(a5)
   11618:	fadff06f          	j	115c4 <memcpy+0x50>
   1161c:	0005c683          	lbu	a3,0(a1)
   11620:	00178793          	addi	a5,a5,1
   11624:	00158593          	addi	a1,a1,1
   11628:	fed78fa3          	sb	a3,-1(a5)
   1162c:	0037f693          	andi	a3,a5,3
   11630:	fe0696e3          	bnez	a3,1161c <memcpy+0xa8>
   11634:	f89ff06f          	j	115bc <memcpy+0x48>
   11638:	00050793          	mv	a5,a0
   1163c:	ff1ff06f          	j	1162c <memcpy+0xb8>
   11640:	0005a603          	lw	a2,0(a1)
   11644:	00478793          	addi	a5,a5,4
   11648:	00458593          	addi	a1,a1,4
   1164c:	fec7ae23          	sw	a2,-4(a5)
   11650:	fed7e8e3          	bltu	a5,a3,11640 <memcpy+0xcc>
   11654:	f4e7eae3          	bltu	a5,a4,115a8 <memcpy+0x34>
   11658:	00008067          	ret

0001165c <memmove>:
   1165c:	00c50733          	add	a4,a0,a2
   11660:	00a5e863          	bltu	a1,a0,11670 <memmove+0x14>
   11664:	00050793          	mv	a5,a0
   11668:	02f71a63          	bne	a4,a5,1169c <memmove+0x40>
   1166c:	00008067          	ret
   11670:	00c587b3          	add	a5,a1,a2
   11674:	40f60633          	sub	a2,a2,a5
   11678:	fef576e3          	bleu	a5,a0,11664 <memmove+0x8>
   1167c:	00c786b3          	add	a3,a5,a2
   11680:	00069463          	bnez	a3,11688 <memmove+0x2c>
   11684:	00008067          	ret
   11688:	fff78793          	addi	a5,a5,-1
   1168c:	0007c683          	lbu	a3,0(a5)
   11690:	fff70713          	addi	a4,a4,-1
   11694:	00d70023          	sb	a3,0(a4)
   11698:	fe5ff06f          	j	1167c <memmove+0x20>
   1169c:	00158593          	addi	a1,a1,1
   116a0:	fff5c683          	lbu	a3,-1(a1)
   116a4:	00178793          	addi	a5,a5,1
   116a8:	fed78fa3          	sb	a3,-1(a5)
   116ac:	fbdff06f          	j	11668 <memmove+0xc>

000116b0 <__malloc_lock>:
   116b0:	00008067          	ret

000116b4 <__malloc_unlock>:
   116b4:	00008067          	ret

000116b8 <_realloc_r>:
   116b8:	fc010113          	addi	sp,sp,-64
   116bc:	02812c23          	sw	s0,56(sp)
   116c0:	02112e23          	sw	ra,60(sp)
   116c4:	00058413          	mv	s0,a1
   116c8:	02912a23          	sw	s1,52(sp)
   116cc:	03212823          	sw	s2,48(sp)
   116d0:	03312623          	sw	s3,44(sp)
   116d4:	03412423          	sw	s4,40(sp)
   116d8:	03512223          	sw	s5,36(sp)
   116dc:	03612023          	sw	s6,32(sp)
   116e0:	01712e23          	sw	s7,28(sp)
   116e4:	01812c23          	sw	s8,24(sp)
   116e8:	00060593          	mv	a1,a2
   116ec:	02041a63          	bnez	s0,11720 <_realloc_r+0x68>
   116f0:	03812403          	lw	s0,56(sp)
   116f4:	03c12083          	lw	ra,60(sp)
   116f8:	03412483          	lw	s1,52(sp)
   116fc:	03012903          	lw	s2,48(sp)
   11700:	02c12983          	lw	s3,44(sp)
   11704:	02812a03          	lw	s4,40(sp)
   11708:	02412a83          	lw	s5,36(sp)
   1170c:	02012b03          	lw	s6,32(sp)
   11710:	01c12b83          	lw	s7,28(sp)
   11714:	01812c03          	lw	s8,24(sp)
   11718:	04010113          	addi	sp,sp,64
   1171c:	ff0ff06f          	j	10f0c <_malloc_r>
   11720:	00050a93          	mv	s5,a0
   11724:	00c12623          	sw	a2,12(sp)
   11728:	f89ff0ef          	jal	ra,116b0 <__malloc_lock>
   1172c:	00c12583          	lw	a1,12(sp)
   11730:	ffc42683          	lw	a3,-4(s0)
   11734:	01600793          	li	a5,22
   11738:	00b58993          	addi	s3,a1,11
   1173c:	ff840b93          	addi	s7,s0,-8
   11740:	ffc6f913          	andi	s2,a3,-4
   11744:	0537f663          	bleu	s3,a5,11790 <_realloc_r+0xd8>
   11748:	ff89fb13          	andi	s6,s3,-8
   1174c:	040b5463          	bgez	s6,11794 <_realloc_r+0xdc>
   11750:	00c00793          	li	a5,12
   11754:	00faa023          	sw	a5,0(s5)
   11758:	00000a13          	li	s4,0
   1175c:	03c12083          	lw	ra,60(sp)
   11760:	03812403          	lw	s0,56(sp)
   11764:	000a0513          	mv	a0,s4
   11768:	03412483          	lw	s1,52(sp)
   1176c:	03012903          	lw	s2,48(sp)
   11770:	02c12983          	lw	s3,44(sp)
   11774:	02812a03          	lw	s4,40(sp)
   11778:	02412a83          	lw	s5,36(sp)
   1177c:	02012b03          	lw	s6,32(sp)
   11780:	01c12b83          	lw	s7,28(sp)
   11784:	01812c03          	lw	s8,24(sp)
   11788:	04010113          	addi	sp,sp,64
   1178c:	00008067          	ret
   11790:	01000b13          	li	s6,16
   11794:	fabb6ee3          	bltu	s6,a1,11750 <_realloc_r+0x98>
   11798:	45695c63          	ble	s6,s2,11bf0 <_realloc_r+0x538>
   1179c:	00014c37          	lui	s8,0x14
   117a0:	518c0713          	addi	a4,s8,1304 # 14518 <__malloc_av_>
   117a4:	00872603          	lw	a2,8(a4)
   117a8:	012b87b3          	add	a5,s7,s2
   117ac:	0047a703          	lw	a4,4(a5)
   117b0:	518c0c13          	addi	s8,s8,1304
   117b4:	00f60c63          	beq	a2,a5,117cc <_realloc_r+0x114>
   117b8:	ffe77513          	andi	a0,a4,-2
   117bc:	00a78533          	add	a0,a5,a0
   117c0:	00452503          	lw	a0,4(a0)
   117c4:	00157513          	andi	a0,a0,1
   117c8:	0a051a63          	bnez	a0,1187c <_realloc_r+0x1c4>
   117cc:	ffc77713          	andi	a4,a4,-4
   117d0:	00e909b3          	add	s3,s2,a4
   117d4:	04f61063          	bne	a2,a5,11814 <_realloc_r+0x15c>
   117d8:	010b0513          	addi	a0,s6,16
   117dc:	0aa9c463          	blt	s3,a0,11884 <_realloc_r+0x1cc>
   117e0:	016b8bb3          	add	s7,s7,s6
   117e4:	416989b3          	sub	s3,s3,s6
   117e8:	017c2423          	sw	s7,8(s8)
   117ec:	0019e993          	ori	s3,s3,1
   117f0:	013ba223          	sw	s3,4(s7)
   117f4:	ffc42983          	lw	s3,-4(s0)
   117f8:	000a8513          	mv	a0,s5
   117fc:	00040a13          	mv	s4,s0
   11800:	0019f993          	andi	s3,s3,1
   11804:	0169e9b3          	or	s3,s3,s6
   11808:	ff342e23          	sw	s3,-4(s0)
   1180c:	ea9ff0ef          	jal	ra,116b4 <__malloc_unlock>
   11810:	f4dff06f          	j	1175c <_realloc_r+0xa4>
   11814:	0769c863          	blt	s3,s6,11884 <_realloc_r+0x1cc>
   11818:	00c7a703          	lw	a4,12(a5)
   1181c:	0087a783          	lw	a5,8(a5)
   11820:	00e7a623          	sw	a4,12(a5)
   11824:	00f72423          	sw	a5,8(a4)
   11828:	004ba703          	lw	a4,4(s7)
   1182c:	416986b3          	sub	a3,s3,s6
   11830:	00f00613          	li	a2,15
   11834:	00177713          	andi	a4,a4,1
   11838:	013b87b3          	add	a5,s7,s3
   1183c:	3ad67e63          	bleu	a3,a2,11bf8 <_realloc_r+0x540>
   11840:	00eb69b3          	or	s3,s6,a4
   11844:	013ba223          	sw	s3,4(s7)
   11848:	016b85b3          	add	a1,s7,s6
   1184c:	0016e693          	ori	a3,a3,1
   11850:	00d5a223          	sw	a3,4(a1)
   11854:	0047a703          	lw	a4,4(a5)
   11858:	00858593          	addi	a1,a1,8
   1185c:	000a8513          	mv	a0,s5
   11860:	00176713          	ori	a4,a4,1
   11864:	00e7a223          	sw	a4,4(a5)
   11868:	375000ef          	jal	ra,123dc <_free_r>
   1186c:	000a8513          	mv	a0,s5
   11870:	e45ff0ef          	jal	ra,116b4 <__malloc_unlock>
   11874:	008b8a13          	addi	s4,s7,8
   11878:	ee5ff06f          	j	1175c <_realloc_r+0xa4>
   1187c:	00000713          	li	a4,0
   11880:	00000793          	li	a5,0
   11884:	0016f693          	andi	a3,a3,1
   11888:	28069263          	bnez	a3,11b0c <_realloc_r+0x454>
   1188c:	ff842483          	lw	s1,-8(s0)
   11890:	409b84b3          	sub	s1,s7,s1
   11894:	0044aa03          	lw	s4,4(s1)
   11898:	ffca7a13          	andi	s4,s4,-4
   1189c:	012a0a33          	add	s4,s4,s2
   118a0:	1a078c63          	beqz	a5,11a58 <_realloc_r+0x3a0>
   118a4:	014709b3          	add	s3,a4,s4
   118a8:	0ef61663          	bne	a2,a5,11994 <_realloc_r+0x2dc>
   118ac:	010b0793          	addi	a5,s6,16
   118b0:	1af9c463          	blt	s3,a5,11a58 <_realloc_r+0x3a0>
   118b4:	0084a703          	lw	a4,8(s1)
   118b8:	00c4a783          	lw	a5,12(s1)
   118bc:	ffc90613          	addi	a2,s2,-4
   118c0:	00848a13          	addi	s4,s1,8
   118c4:	00f72623          	sw	a5,12(a4)
   118c8:	00e7a423          	sw	a4,8(a5)
   118cc:	02400713          	li	a4,36
   118d0:	0ac76a63          	bltu	a4,a2,11984 <_realloc_r+0x2cc>
   118d4:	01300693          	li	a3,19
   118d8:	000a0793          	mv	a5,s4
   118dc:	02c6f263          	bleu	a2,a3,11900 <_realloc_r+0x248>
   118e0:	00042783          	lw	a5,0(s0)
   118e4:	00f4a423          	sw	a5,8(s1)
   118e8:	00442783          	lw	a5,4(s0)
   118ec:	00f4a623          	sw	a5,12(s1)
   118f0:	01b00793          	li	a5,27
   118f4:	04c7ea63          	bltu	a5,a2,11948 <_realloc_r+0x290>
   118f8:	00840413          	addi	s0,s0,8
   118fc:	01048793          	addi	a5,s1,16
   11900:	00042703          	lw	a4,0(s0)
   11904:	00e7a023          	sw	a4,0(a5)
   11908:	00442703          	lw	a4,4(s0)
   1190c:	00e7a223          	sw	a4,4(a5)
   11910:	00842703          	lw	a4,8(s0)
   11914:	00e7a423          	sw	a4,8(a5)
   11918:	016487b3          	add	a5,s1,s6
   1191c:	416989b3          	sub	s3,s3,s6
   11920:	00fc2423          	sw	a5,8(s8)
   11924:	0019e993          	ori	s3,s3,1
   11928:	0137a223          	sw	s3,4(a5)
   1192c:	0044a783          	lw	a5,4(s1)
   11930:	0017f793          	andi	a5,a5,1
   11934:	0167e9b3          	or	s3,a5,s6
   11938:	0134a223          	sw	s3,4(s1)
   1193c:	000a8513          	mv	a0,s5
   11940:	d75ff0ef          	jal	ra,116b4 <__malloc_unlock>
   11944:	e19ff06f          	j	1175c <_realloc_r+0xa4>
   11948:	00842783          	lw	a5,8(s0)
   1194c:	00f4a823          	sw	a5,16(s1)
   11950:	00c42783          	lw	a5,12(s0)
   11954:	00f4aa23          	sw	a5,20(s1)
   11958:	00e60863          	beq	a2,a4,11968 <_realloc_r+0x2b0>
   1195c:	01040413          	addi	s0,s0,16
   11960:	01848793          	addi	a5,s1,24
   11964:	f9dff06f          	j	11900 <_realloc_r+0x248>
   11968:	01042783          	lw	a5,16(s0)
   1196c:	01840413          	addi	s0,s0,24
   11970:	00f4ac23          	sw	a5,24(s1)
   11974:	ffc42703          	lw	a4,-4(s0)
   11978:	02048793          	addi	a5,s1,32
   1197c:	00e4ae23          	sw	a4,28(s1)
   11980:	f81ff06f          	j	11900 <_realloc_r+0x248>
   11984:	00040593          	mv	a1,s0
   11988:	000a0513          	mv	a0,s4
   1198c:	cd1ff0ef          	jal	ra,1165c <memmove>
   11990:	f89ff06f          	j	11918 <_realloc_r+0x260>
   11994:	0d69c263          	blt	s3,s6,11a58 <_realloc_r+0x3a0>
   11998:	00c7a703          	lw	a4,12(a5)
   1199c:	0087a783          	lw	a5,8(a5)
   119a0:	ffc90613          	addi	a2,s2,-4
   119a4:	00848513          	addi	a0,s1,8
   119a8:	00e7a623          	sw	a4,12(a5)
   119ac:	00f72423          	sw	a5,8(a4)
   119b0:	0084a703          	lw	a4,8(s1)
   119b4:	00c4a783          	lw	a5,12(s1)
   119b8:	00f72623          	sw	a5,12(a4)
   119bc:	00e7a423          	sw	a4,8(a5)
   119c0:	02400793          	li	a5,36
   119c4:	08c7e463          	bltu	a5,a2,11a4c <_realloc_r+0x394>
   119c8:	01300713          	li	a4,19
   119cc:	02c77263          	bleu	a2,a4,119f0 <_realloc_r+0x338>
   119d0:	00042703          	lw	a4,0(s0)
   119d4:	00e4a423          	sw	a4,8(s1)
   119d8:	00442703          	lw	a4,4(s0)
   119dc:	00e4a623          	sw	a4,12(s1)
   119e0:	01b00713          	li	a4,27
   119e4:	02c76663          	bltu	a4,a2,11a10 <_realloc_r+0x358>
   119e8:	00840413          	addi	s0,s0,8
   119ec:	01048513          	addi	a0,s1,16
   119f0:	00042783          	lw	a5,0(s0)
   119f4:	00f52023          	sw	a5,0(a0)
   119f8:	00442783          	lw	a5,4(s0)
   119fc:	00f52223          	sw	a5,4(a0)
   11a00:	00842783          	lw	a5,8(s0)
   11a04:	00f52423          	sw	a5,8(a0)
   11a08:	00048b93          	mv	s7,s1
   11a0c:	e1dff06f          	j	11828 <_realloc_r+0x170>
   11a10:	00842703          	lw	a4,8(s0)
   11a14:	00e4a823          	sw	a4,16(s1)
   11a18:	00c42703          	lw	a4,12(s0)
   11a1c:	00e4aa23          	sw	a4,20(s1)
   11a20:	00f60863          	beq	a2,a5,11a30 <_realloc_r+0x378>
   11a24:	01040413          	addi	s0,s0,16
   11a28:	01848513          	addi	a0,s1,24
   11a2c:	fc5ff06f          	j	119f0 <_realloc_r+0x338>
   11a30:	01042783          	lw	a5,16(s0)
   11a34:	02048513          	addi	a0,s1,32
   11a38:	01840413          	addi	s0,s0,24
   11a3c:	00f4ac23          	sw	a5,24(s1)
   11a40:	ffc42783          	lw	a5,-4(s0)
   11a44:	00f4ae23          	sw	a5,28(s1)
   11a48:	fa9ff06f          	j	119f0 <_realloc_r+0x338>
   11a4c:	00040593          	mv	a1,s0
   11a50:	c0dff0ef          	jal	ra,1165c <memmove>
   11a54:	fb5ff06f          	j	11a08 <_realloc_r+0x350>
   11a58:	0b6a4a63          	blt	s4,s6,11b0c <_realloc_r+0x454>
   11a5c:	00c4a783          	lw	a5,12(s1)
   11a60:	0084a703          	lw	a4,8(s1)
   11a64:	ffc90613          	addi	a2,s2,-4
   11a68:	00848513          	addi	a0,s1,8
   11a6c:	00f72623          	sw	a5,12(a4)
   11a70:	00e7a423          	sw	a4,8(a5)
   11a74:	02400793          	li	a5,36
   11a78:	08c7e463          	bltu	a5,a2,11b00 <_realloc_r+0x448>
   11a7c:	01300713          	li	a4,19
   11a80:	02c77263          	bleu	a2,a4,11aa4 <_realloc_r+0x3ec>
   11a84:	00042703          	lw	a4,0(s0)
   11a88:	00e4a423          	sw	a4,8(s1)
   11a8c:	00442703          	lw	a4,4(s0)
   11a90:	00e4a623          	sw	a4,12(s1)
   11a94:	01b00713          	li	a4,27
   11a98:	02c76663          	bltu	a4,a2,11ac4 <_realloc_r+0x40c>
   11a9c:	00840413          	addi	s0,s0,8
   11aa0:	01048513          	addi	a0,s1,16
   11aa4:	00042783          	lw	a5,0(s0)
   11aa8:	00f52023          	sw	a5,0(a0)
   11aac:	00442783          	lw	a5,4(s0)
   11ab0:	00f52223          	sw	a5,4(a0)
   11ab4:	00842783          	lw	a5,8(s0)
   11ab8:	00f52423          	sw	a5,8(a0)
   11abc:	000a0993          	mv	s3,s4
   11ac0:	f49ff06f          	j	11a08 <_realloc_r+0x350>
   11ac4:	00842703          	lw	a4,8(s0)
   11ac8:	00e4a823          	sw	a4,16(s1)
   11acc:	00c42703          	lw	a4,12(s0)
   11ad0:	00e4aa23          	sw	a4,20(s1)
   11ad4:	00f60863          	beq	a2,a5,11ae4 <_realloc_r+0x42c>
   11ad8:	01040413          	addi	s0,s0,16
   11adc:	01848513          	addi	a0,s1,24
   11ae0:	fc5ff06f          	j	11aa4 <_realloc_r+0x3ec>
   11ae4:	01042783          	lw	a5,16(s0)
   11ae8:	02048513          	addi	a0,s1,32
   11aec:	01840413          	addi	s0,s0,24
   11af0:	00f4ac23          	sw	a5,24(s1)
   11af4:	ffc42783          	lw	a5,-4(s0)
   11af8:	00f4ae23          	sw	a5,28(s1)
   11afc:	fa9ff06f          	j	11aa4 <_realloc_r+0x3ec>
   11b00:	00040593          	mv	a1,s0
   11b04:	b59ff0ef          	jal	ra,1165c <memmove>
   11b08:	fb5ff06f          	j	11abc <_realloc_r+0x404>
   11b0c:	000a8513          	mv	a0,s5
   11b10:	bfcff0ef          	jal	ra,10f0c <_malloc_r>
   11b14:	00050a13          	mv	s4,a0
   11b18:	e20502e3          	beqz	a0,1193c <_realloc_r+0x284>
   11b1c:	ffc42783          	lw	a5,-4(s0)
   11b20:	ff850713          	addi	a4,a0,-8
   11b24:	ffe7f793          	andi	a5,a5,-2
   11b28:	00fb87b3          	add	a5,s7,a5
   11b2c:	00e79a63          	bne	a5,a4,11b40 <_realloc_r+0x488>
   11b30:	ffc52983          	lw	s3,-4(a0)
   11b34:	ffc9f993          	andi	s3,s3,-4
   11b38:	012989b3          	add	s3,s3,s2
   11b3c:	cedff06f          	j	11828 <_realloc_r+0x170>
   11b40:	ffc90613          	addi	a2,s2,-4
   11b44:	02400793          	li	a5,36
   11b48:	08c7ee63          	bltu	a5,a2,11be4 <_realloc_r+0x52c>
   11b4c:	01300713          	li	a4,19
   11b50:	08c77463          	bleu	a2,a4,11bd8 <_realloc_r+0x520>
   11b54:	00042703          	lw	a4,0(s0)
   11b58:	00e52023          	sw	a4,0(a0)
   11b5c:	00442703          	lw	a4,4(s0)
   11b60:	00e52223          	sw	a4,4(a0)
   11b64:	01b00713          	li	a4,27
   11b68:	02c76a63          	bltu	a4,a2,11b9c <_realloc_r+0x4e4>
   11b6c:	00840713          	addi	a4,s0,8
   11b70:	00850793          	addi	a5,a0,8
   11b74:	00072683          	lw	a3,0(a4)
   11b78:	00d7a023          	sw	a3,0(a5)
   11b7c:	00472683          	lw	a3,4(a4)
   11b80:	00d7a223          	sw	a3,4(a5)
   11b84:	00872703          	lw	a4,8(a4)
   11b88:	00e7a423          	sw	a4,8(a5)
   11b8c:	00040593          	mv	a1,s0
   11b90:	000a8513          	mv	a0,s5
   11b94:	049000ef          	jal	ra,123dc <_free_r>
   11b98:	da5ff06f          	j	1193c <_realloc_r+0x284>
   11b9c:	00842703          	lw	a4,8(s0)
   11ba0:	00e52423          	sw	a4,8(a0)
   11ba4:	00c42703          	lw	a4,12(s0)
   11ba8:	00e52623          	sw	a4,12(a0)
   11bac:	00f60863          	beq	a2,a5,11bbc <_realloc_r+0x504>
   11bb0:	01040713          	addi	a4,s0,16
   11bb4:	01050793          	addi	a5,a0,16
   11bb8:	fbdff06f          	j	11b74 <_realloc_r+0x4bc>
   11bbc:	01042783          	lw	a5,16(s0)
   11bc0:	01840713          	addi	a4,s0,24
   11bc4:	00f52823          	sw	a5,16(a0)
   11bc8:	01442683          	lw	a3,20(s0)
   11bcc:	01850793          	addi	a5,a0,24
   11bd0:	00d52a23          	sw	a3,20(a0)
   11bd4:	fa1ff06f          	j	11b74 <_realloc_r+0x4bc>
   11bd8:	00050793          	mv	a5,a0
   11bdc:	00040713          	mv	a4,s0
   11be0:	f95ff06f          	j	11b74 <_realloc_r+0x4bc>
   11be4:	00040593          	mv	a1,s0
   11be8:	a75ff0ef          	jal	ra,1165c <memmove>
   11bec:	fa1ff06f          	j	11b8c <_realloc_r+0x4d4>
   11bf0:	00090993          	mv	s3,s2
   11bf4:	c35ff06f          	j	11828 <_realloc_r+0x170>
   11bf8:	00e9e9b3          	or	s3,s3,a4
   11bfc:	013ba223          	sw	s3,4(s7)
   11c00:	0047a703          	lw	a4,4(a5)
   11c04:	00176713          	ori	a4,a4,1
   11c08:	00e7a223          	sw	a4,4(a5)
   11c0c:	c61ff06f          	j	1186c <_realloc_r+0x1b4>

00011c10 <_sbrk_r>:
   11c10:	ff010113          	addi	sp,sp,-16
   11c14:	00812423          	sw	s0,8(sp)
   11c18:	00912223          	sw	s1,4(sp)
   11c1c:	00050493          	mv	s1,a0
   11c20:	00058513          	mv	a0,a1
   11c24:	00112623          	sw	ra,12(sp)
   11c28:	8601a823          	sw	zero,-1936(gp) # 14990 <errno>
   11c2c:	2d4010ef          	jal	ra,12f00 <sbrk>
   11c30:	fff00793          	li	a5,-1
   11c34:	00f51863          	bne	a0,a5,11c44 <_sbrk_r+0x34>
   11c38:	8701a783          	lw	a5,-1936(gp) # 14990 <errno>
   11c3c:	00078463          	beqz	a5,11c44 <_sbrk_r+0x34>
   11c40:	00f4a023          	sw	a5,0(s1)
   11c44:	00c12083          	lw	ra,12(sp)
   11c48:	00812403          	lw	s0,8(sp)
   11c4c:	00412483          	lw	s1,4(sp)
   11c50:	01010113          	addi	sp,sp,16
   11c54:	00008067          	ret

00011c58 <__sread>:
   11c58:	ff010113          	addi	sp,sp,-16
   11c5c:	00812423          	sw	s0,8(sp)
   11c60:	00058413          	mv	s0,a1
   11c64:	00e59583          	lh	a1,14(a1)
   11c68:	00112623          	sw	ra,12(sp)
   11c6c:	3a9000ef          	jal	ra,12814 <_read_r>
   11c70:	02054063          	bltz	a0,11c90 <__sread+0x38>
   11c74:	05042783          	lw	a5,80(s0)
   11c78:	00a787b3          	add	a5,a5,a0
   11c7c:	04f42823          	sw	a5,80(s0)
   11c80:	00c12083          	lw	ra,12(sp)
   11c84:	00812403          	lw	s0,8(sp)
   11c88:	01010113          	addi	sp,sp,16
   11c8c:	00008067          	ret
   11c90:	00c45783          	lhu	a5,12(s0)
   11c94:	fffff737          	lui	a4,0xfffff
   11c98:	fff70713          	addi	a4,a4,-1 # ffffefff <__global_pointer$+0xfffe9edf>
   11c9c:	00e7f7b3          	and	a5,a5,a4
   11ca0:	00f41623          	sh	a5,12(s0)
   11ca4:	fddff06f          	j	11c80 <__sread+0x28>

00011ca8 <__seofread>:
   11ca8:	00000513          	li	a0,0
   11cac:	00008067          	ret

00011cb0 <__swrite>:
   11cb0:	00c5d783          	lhu	a5,12(a1)
   11cb4:	fe010113          	addi	sp,sp,-32
   11cb8:	00812c23          	sw	s0,24(sp)
   11cbc:	00912a23          	sw	s1,20(sp)
   11cc0:	01212823          	sw	s2,16(sp)
   11cc4:	01312623          	sw	s3,12(sp)
   11cc8:	00112e23          	sw	ra,28(sp)
   11ccc:	1007f793          	andi	a5,a5,256
   11cd0:	00050493          	mv	s1,a0
   11cd4:	00058413          	mv	s0,a1
   11cd8:	00060913          	mv	s2,a2
   11cdc:	00068993          	mv	s3,a3
   11ce0:	00078a63          	beqz	a5,11cf4 <__swrite+0x44>
   11ce4:	00e59583          	lh	a1,14(a1)
   11ce8:	00200693          	li	a3,2
   11cec:	00000613          	li	a2,0
   11cf0:	149000ef          	jal	ra,12638 <_lseek_r>
   11cf4:	00c45783          	lhu	a5,12(s0)
   11cf8:	fffff737          	lui	a4,0xfffff
   11cfc:	fff70713          	addi	a4,a4,-1 # ffffefff <__global_pointer$+0xfffe9edf>
   11d00:	00e7f7b3          	and	a5,a5,a4
   11d04:	00f41623          	sh	a5,12(s0)
   11d08:	00e41583          	lh	a1,14(s0)
   11d0c:	01812403          	lw	s0,24(sp)
   11d10:	01c12083          	lw	ra,28(sp)
   11d14:	00098693          	mv	a3,s3
   11d18:	00090613          	mv	a2,s2
   11d1c:	00c12983          	lw	s3,12(sp)
   11d20:	01012903          	lw	s2,16(sp)
   11d24:	00048513          	mv	a0,s1
   11d28:	01412483          	lw	s1,20(sp)
   11d2c:	02010113          	addi	sp,sp,32
   11d30:	0640006f          	j	11d94 <_write_r>

00011d34 <__sseek>:
   11d34:	ff010113          	addi	sp,sp,-16
   11d38:	00812423          	sw	s0,8(sp)
   11d3c:	00058413          	mv	s0,a1
   11d40:	00e59583          	lh	a1,14(a1)
   11d44:	00112623          	sw	ra,12(sp)
   11d48:	0f1000ef          	jal	ra,12638 <_lseek_r>
   11d4c:	fff00793          	li	a5,-1
   11d50:	00c45703          	lhu	a4,12(s0)
   11d54:	02f51263          	bne	a0,a5,11d78 <__sseek+0x44>
   11d58:	fffff7b7          	lui	a5,0xfffff
   11d5c:	fff78793          	addi	a5,a5,-1 # ffffefff <__global_pointer$+0xfffe9edf>
   11d60:	00e7f7b3          	and	a5,a5,a4
   11d64:	00f41623          	sh	a5,12(s0)
   11d68:	00c12083          	lw	ra,12(sp)
   11d6c:	00812403          	lw	s0,8(sp)
   11d70:	01010113          	addi	sp,sp,16
   11d74:	00008067          	ret
   11d78:	000017b7          	lui	a5,0x1
   11d7c:	00f767b3          	or	a5,a4,a5
   11d80:	00f41623          	sh	a5,12(s0)
   11d84:	04a42823          	sw	a0,80(s0)
   11d88:	fe1ff06f          	j	11d68 <__sseek+0x34>

00011d8c <__sclose>:
   11d8c:	00e59583          	lh	a1,14(a1)
   11d90:	1880006f          	j	11f18 <_close_r>

00011d94 <_write_r>:
   11d94:	ff010113          	addi	sp,sp,-16
   11d98:	00812423          	sw	s0,8(sp)
   11d9c:	00912223          	sw	s1,4(sp)
   11da0:	00050493          	mv	s1,a0
   11da4:	00058513          	mv	a0,a1
   11da8:	00060593          	mv	a1,a2
   11dac:	00068613          	mv	a2,a3
   11db0:	00112623          	sw	ra,12(sp)
   11db4:	8601a823          	sw	zero,-1936(gp) # 14990 <errno>
   11db8:	5ad000ef          	jal	ra,12b64 <write>
   11dbc:	fff00793          	li	a5,-1
   11dc0:	00f51863          	bne	a0,a5,11dd0 <_write_r+0x3c>
   11dc4:	8701a783          	lw	a5,-1936(gp) # 14990 <errno>
   11dc8:	00078463          	beqz	a5,11dd0 <_write_r+0x3c>
   11dcc:	00f4a023          	sw	a5,0(s1)
   11dd0:	00c12083          	lw	ra,12(sp)
   11dd4:	00812403          	lw	s0,8(sp)
   11dd8:	00412483          	lw	s1,4(sp)
   11ddc:	01010113          	addi	sp,sp,16
   11de0:	00008067          	ret

00011de4 <__swsetup_r>:
   11de4:	ff010113          	addi	sp,sp,-16
   11de8:	00912223          	sw	s1,4(sp)
   11dec:	00050493          	mv	s1,a0
   11df0:	8081a503          	lw	a0,-2040(gp) # 14928 <_impure_ptr>
   11df4:	00812423          	sw	s0,8(sp)
   11df8:	00112623          	sw	ra,12(sp)
   11dfc:	00058413          	mv	s0,a1
   11e00:	00050863          	beqz	a0,11e10 <__swsetup_r+0x2c>
   11e04:	03852783          	lw	a5,56(a0)
   11e08:	00079463          	bnez	a5,11e10 <__swsetup_r+0x2c>
   11e0c:	9a9fe0ef          	jal	ra,107b4 <__sinit>
   11e10:	00c41703          	lh	a4,12(s0)
   11e14:	01071793          	slli	a5,a4,0x10
   11e18:	0107d793          	srli	a5,a5,0x10
   11e1c:	0087f693          	andi	a3,a5,8
   11e20:	06069e63          	bnez	a3,11e9c <__swsetup_r+0xb8>
   11e24:	0107f693          	andi	a3,a5,16
   11e28:	02069663          	bnez	a3,11e54 <__swsetup_r+0x70>
   11e2c:	00900793          	li	a5,9
   11e30:	00f4a023          	sw	a5,0(s1)
   11e34:	04076713          	ori	a4,a4,64
   11e38:	00e41623          	sh	a4,12(s0)
   11e3c:	fff00513          	li	a0,-1
   11e40:	00c12083          	lw	ra,12(sp)
   11e44:	00812403          	lw	s0,8(sp)
   11e48:	00412483          	lw	s1,4(sp)
   11e4c:	01010113          	addi	sp,sp,16
   11e50:	00008067          	ret
   11e54:	0047f793          	andi	a5,a5,4
   11e58:	02078c63          	beqz	a5,11e90 <__swsetup_r+0xac>
   11e5c:	03042583          	lw	a1,48(s0)
   11e60:	00058c63          	beqz	a1,11e78 <__swsetup_r+0x94>
   11e64:	04040793          	addi	a5,s0,64
   11e68:	00f58663          	beq	a1,a5,11e74 <__swsetup_r+0x90>
   11e6c:	00048513          	mv	a0,s1
   11e70:	56c000ef          	jal	ra,123dc <_free_r>
   11e74:	02042823          	sw	zero,48(s0)
   11e78:	00c45783          	lhu	a5,12(s0)
   11e7c:	00042223          	sw	zero,4(s0)
   11e80:	fdb7f793          	andi	a5,a5,-37
   11e84:	00f41623          	sh	a5,12(s0)
   11e88:	01042783          	lw	a5,16(s0)
   11e8c:	00f42023          	sw	a5,0(s0)
   11e90:	00c45783          	lhu	a5,12(s0)
   11e94:	0087e793          	ori	a5,a5,8
   11e98:	00f41623          	sh	a5,12(s0)
   11e9c:	01042783          	lw	a5,16(s0)
   11ea0:	02079063          	bnez	a5,11ec0 <__swsetup_r+0xdc>
   11ea4:	00c45783          	lhu	a5,12(s0)
   11ea8:	20000713          	li	a4,512
   11eac:	2807f793          	andi	a5,a5,640
   11eb0:	00e78863          	beq	a5,a4,11ec0 <__swsetup_r+0xdc>
   11eb4:	00040593          	mv	a1,s0
   11eb8:	00048513          	mv	a0,s1
   11ebc:	069000ef          	jal	ra,12724 <__smakebuf_r>
   11ec0:	00c45783          	lhu	a5,12(s0)
   11ec4:	0017f713          	andi	a4,a5,1
   11ec8:	02070c63          	beqz	a4,11f00 <__swsetup_r+0x11c>
   11ecc:	01442783          	lw	a5,20(s0)
   11ed0:	00042423          	sw	zero,8(s0)
   11ed4:	40f007b3          	neg	a5,a5
   11ed8:	00f42c23          	sw	a5,24(s0)
   11edc:	01042783          	lw	a5,16(s0)
   11ee0:	00000513          	li	a0,0
   11ee4:	f4079ee3          	bnez	a5,11e40 <__swsetup_r+0x5c>
   11ee8:	00c41783          	lh	a5,12(s0)
   11eec:	0807f713          	andi	a4,a5,128
   11ef0:	f40708e3          	beqz	a4,11e40 <__swsetup_r+0x5c>
   11ef4:	0407e793          	ori	a5,a5,64
   11ef8:	00f41623          	sh	a5,12(s0)
   11efc:	f41ff06f          	j	11e3c <__swsetup_r+0x58>
   11f00:	0027f793          	andi	a5,a5,2
   11f04:	00000713          	li	a4,0
   11f08:	00079463          	bnez	a5,11f10 <__swsetup_r+0x12c>
   11f0c:	01442703          	lw	a4,20(s0)
   11f10:	00e42423          	sw	a4,8(s0)
   11f14:	fc9ff06f          	j	11edc <__swsetup_r+0xf8>

00011f18 <_close_r>:
   11f18:	ff010113          	addi	sp,sp,-16
   11f1c:	00812423          	sw	s0,8(sp)
   11f20:	00912223          	sw	s1,4(sp)
   11f24:	00050493          	mv	s1,a0
   11f28:	00058513          	mv	a0,a1
   11f2c:	00112623          	sw	ra,12(sp)
   11f30:	8601a823          	sw	zero,-1936(gp) # 14990 <errno>
   11f34:	5c9000ef          	jal	ra,12cfc <close>
   11f38:	fff00793          	li	a5,-1
   11f3c:	00f51863          	bne	a0,a5,11f4c <_close_r+0x34>
   11f40:	8701a783          	lw	a5,-1936(gp) # 14990 <errno>
   11f44:	00078463          	beqz	a5,11f4c <_close_r+0x34>
   11f48:	00f4a023          	sw	a5,0(s1)
   11f4c:	00c12083          	lw	ra,12(sp)
   11f50:	00812403          	lw	s0,8(sp)
   11f54:	00412483          	lw	s1,4(sp)
   11f58:	01010113          	addi	sp,sp,16
   11f5c:	00008067          	ret

00011f60 <_fclose_r>:
   11f60:	ff010113          	addi	sp,sp,-16
   11f64:	00112623          	sw	ra,12(sp)
   11f68:	00812423          	sw	s0,8(sp)
   11f6c:	00912223          	sw	s1,4(sp)
   11f70:	01212023          	sw	s2,0(sp)
   11f74:	02059263          	bnez	a1,11f98 <_fclose_r+0x38>
   11f78:	00000913          	li	s2,0
   11f7c:	00c12083          	lw	ra,12(sp)
   11f80:	00812403          	lw	s0,8(sp)
   11f84:	00090513          	mv	a0,s2
   11f88:	00412483          	lw	s1,4(sp)
   11f8c:	00012903          	lw	s2,0(sp)
   11f90:	01010113          	addi	sp,sp,16
   11f94:	00008067          	ret
   11f98:	00050493          	mv	s1,a0
   11f9c:	00058413          	mv	s0,a1
   11fa0:	00050863          	beqz	a0,11fb0 <_fclose_r+0x50>
   11fa4:	03852783          	lw	a5,56(a0)
   11fa8:	00079463          	bnez	a5,11fb0 <_fclose_r+0x50>
   11fac:	809fe0ef          	jal	ra,107b4 <__sinit>
   11fb0:	00c41783          	lh	a5,12(s0)
   11fb4:	fc0782e3          	beqz	a5,11f78 <_fclose_r+0x18>
   11fb8:	00040593          	mv	a1,s0
   11fbc:	00048513          	mv	a0,s1
   11fc0:	088000ef          	jal	ra,12048 <__sflush_r>
   11fc4:	02c42783          	lw	a5,44(s0)
   11fc8:	00050913          	mv	s2,a0
   11fcc:	00078c63          	beqz	a5,11fe4 <_fclose_r+0x84>
   11fd0:	01c42583          	lw	a1,28(s0)
   11fd4:	00048513          	mv	a0,s1
   11fd8:	000780e7          	jalr	a5
   11fdc:	00055463          	bgez	a0,11fe4 <_fclose_r+0x84>
   11fe0:	fff00913          	li	s2,-1
   11fe4:	00c45783          	lhu	a5,12(s0)
   11fe8:	0807f793          	andi	a5,a5,128
   11fec:	00078863          	beqz	a5,11ffc <_fclose_r+0x9c>
   11ff0:	01042583          	lw	a1,16(s0)
   11ff4:	00048513          	mv	a0,s1
   11ff8:	3e4000ef          	jal	ra,123dc <_free_r>
   11ffc:	03042583          	lw	a1,48(s0)
   12000:	00058c63          	beqz	a1,12018 <_fclose_r+0xb8>
   12004:	04040793          	addi	a5,s0,64
   12008:	00f58663          	beq	a1,a5,12014 <_fclose_r+0xb4>
   1200c:	00048513          	mv	a0,s1
   12010:	3cc000ef          	jal	ra,123dc <_free_r>
   12014:	02042823          	sw	zero,48(s0)
   12018:	04442583          	lw	a1,68(s0)
   1201c:	00058863          	beqz	a1,1202c <_fclose_r+0xcc>
   12020:	00048513          	mv	a0,s1
   12024:	3b8000ef          	jal	ra,123dc <_free_r>
   12028:	04042223          	sw	zero,68(s0)
   1202c:	8f9fe0ef          	jal	ra,10924 <__sfp_lock_acquire>
   12030:	00041623          	sh	zero,12(s0)
   12034:	8f5fe0ef          	jal	ra,10928 <__sfp_lock_release>
   12038:	f45ff06f          	j	11f7c <_fclose_r+0x1c>

0001203c <fclose>:
   1203c:	00050593          	mv	a1,a0
   12040:	8081a503          	lw	a0,-2040(gp) # 14928 <_impure_ptr>
   12044:	f1dff06f          	j	11f60 <_fclose_r>

00012048 <__sflush_r>:
   12048:	00c59783          	lh	a5,12(a1)
   1204c:	fe010113          	addi	sp,sp,-32
   12050:	00812c23          	sw	s0,24(sp)
   12054:	01079713          	slli	a4,a5,0x10
   12058:	01075713          	srli	a4,a4,0x10
   1205c:	00912a23          	sw	s1,20(sp)
   12060:	00112e23          	sw	ra,28(sp)
   12064:	01212823          	sw	s2,16(sp)
   12068:	01312623          	sw	s3,12(sp)
   1206c:	00877693          	andi	a3,a4,8
   12070:	00050493          	mv	s1,a0
   12074:	00058413          	mv	s0,a1
   12078:	16069c63          	bnez	a3,121f0 <__sflush_r+0x1a8>
   1207c:	00001737          	lui	a4,0x1
   12080:	80070713          	addi	a4,a4,-2048 # 800 <main-0xf874>
   12084:	00e7e7b3          	or	a5,a5,a4
   12088:	0045a703          	lw	a4,4(a1)
   1208c:	00f59623          	sh	a5,12(a1)
   12090:	02e04663          	bgtz	a4,120bc <__sflush_r+0x74>
   12094:	03c5a703          	lw	a4,60(a1)
   12098:	02e04263          	bgtz	a4,120bc <__sflush_r+0x74>
   1209c:	00000513          	li	a0,0
   120a0:	01c12083          	lw	ra,28(sp)
   120a4:	01812403          	lw	s0,24(sp)
   120a8:	01412483          	lw	s1,20(sp)
   120ac:	01012903          	lw	s2,16(sp)
   120b0:	00c12983          	lw	s3,12(sp)
   120b4:	02010113          	addi	sp,sp,32
   120b8:	00008067          	ret
   120bc:	02842703          	lw	a4,40(s0)
   120c0:	fc070ee3          	beqz	a4,1209c <__sflush_r+0x54>
   120c4:	0004a903          	lw	s2,0(s1)
   120c8:	01379693          	slli	a3,a5,0x13
   120cc:	0004a023          	sw	zero,0(s1)
   120d0:	01c42583          	lw	a1,28(s0)
   120d4:	0c06d863          	bgez	a3,121a4 <__sflush_r+0x15c>
   120d8:	05042603          	lw	a2,80(s0)
   120dc:	00c45783          	lhu	a5,12(s0)
   120e0:	0047f793          	andi	a5,a5,4
   120e4:	00078e63          	beqz	a5,12100 <__sflush_r+0xb8>
   120e8:	00442783          	lw	a5,4(s0)
   120ec:	40f60633          	sub	a2,a2,a5
   120f0:	03042783          	lw	a5,48(s0)
   120f4:	00078663          	beqz	a5,12100 <__sflush_r+0xb8>
   120f8:	03c42783          	lw	a5,60(s0)
   120fc:	40f60633          	sub	a2,a2,a5
   12100:	02842783          	lw	a5,40(s0)
   12104:	01c42583          	lw	a1,28(s0)
   12108:	00000693          	li	a3,0
   1210c:	00048513          	mv	a0,s1
   12110:	000780e7          	jalr	a5
   12114:	fff00793          	li	a5,-1
   12118:	00c45683          	lhu	a3,12(s0)
   1211c:	02f51263          	bne	a0,a5,12140 <__sflush_r+0xf8>
   12120:	0004a783          	lw	a5,0(s1)
   12124:	01d00713          	li	a4,29
   12128:	0af76c63          	bltu	a4,a5,121e0 <__sflush_r+0x198>
   1212c:	20400737          	lui	a4,0x20400
   12130:	00170713          	addi	a4,a4,1 # 20400001 <__global_pointer$+0x203eaee1>
   12134:	00f75733          	srl	a4,a4,a5
   12138:	00177713          	andi	a4,a4,1
   1213c:	0a070263          	beqz	a4,121e0 <__sflush_r+0x198>
   12140:	fffff7b7          	lui	a5,0xfffff
   12144:	7ff78793          	addi	a5,a5,2047 # fffff7ff <__global_pointer$+0xfffea6df>
   12148:	01042703          	lw	a4,16(s0)
   1214c:	00d7f7b3          	and	a5,a5,a3
   12150:	01079793          	slli	a5,a5,0x10
   12154:	4107d793          	srai	a5,a5,0x10
   12158:	00e42023          	sw	a4,0(s0)
   1215c:	00f41623          	sh	a5,12(s0)
   12160:	00042223          	sw	zero,4(s0)
   12164:	01379713          	slli	a4,a5,0x13
   12168:	00075c63          	bgez	a4,12180 <__sflush_r+0x138>
   1216c:	fff00793          	li	a5,-1
   12170:	00f51663          	bne	a0,a5,1217c <__sflush_r+0x134>
   12174:	0004a783          	lw	a5,0(s1)
   12178:	00079463          	bnez	a5,12180 <__sflush_r+0x138>
   1217c:	04a42823          	sw	a0,80(s0)
   12180:	03042583          	lw	a1,48(s0)
   12184:	0124a023          	sw	s2,0(s1)
   12188:	f0058ae3          	beqz	a1,1209c <__sflush_r+0x54>
   1218c:	04040793          	addi	a5,s0,64
   12190:	00f58663          	beq	a1,a5,1219c <__sflush_r+0x154>
   12194:	00048513          	mv	a0,s1
   12198:	244000ef          	jal	ra,123dc <_free_r>
   1219c:	02042823          	sw	zero,48(s0)
   121a0:	efdff06f          	j	1209c <__sflush_r+0x54>
   121a4:	00000613          	li	a2,0
   121a8:	00100693          	li	a3,1
   121ac:	00048513          	mv	a0,s1
   121b0:	000700e7          	jalr	a4
   121b4:	fff00793          	li	a5,-1
   121b8:	00050613          	mv	a2,a0
   121bc:	f2f510e3          	bne	a0,a5,120dc <__sflush_r+0x94>
   121c0:	0004a783          	lw	a5,0(s1)
   121c4:	f0078ce3          	beqz	a5,120dc <__sflush_r+0x94>
   121c8:	01d00713          	li	a4,29
   121cc:	00e78663          	beq	a5,a4,121d8 <__sflush_r+0x190>
   121d0:	01600713          	li	a4,22
   121d4:	06e79263          	bne	a5,a4,12238 <__sflush_r+0x1f0>
   121d8:	0124a023          	sw	s2,0(s1)
   121dc:	ec1ff06f          	j	1209c <__sflush_r+0x54>
   121e0:	0406e793          	ori	a5,a3,64
   121e4:	00f41623          	sh	a5,12(s0)
   121e8:	fff00513          	li	a0,-1
   121ec:	eb5ff06f          	j	120a0 <__sflush_r+0x58>
   121f0:	0105a983          	lw	s3,16(a1)
   121f4:	ea0984e3          	beqz	s3,1209c <__sflush_r+0x54>
   121f8:	0005a903          	lw	s2,0(a1)
   121fc:	00377713          	andi	a4,a4,3
   12200:	0135a023          	sw	s3,0(a1)
   12204:	41390933          	sub	s2,s2,s3
   12208:	00000793          	li	a5,0
   1220c:	00071463          	bnez	a4,12214 <__sflush_r+0x1cc>
   12210:	0145a783          	lw	a5,20(a1)
   12214:	00f42423          	sw	a5,8(s0)
   12218:	e92052e3          	blez	s2,1209c <__sflush_r+0x54>
   1221c:	02442783          	lw	a5,36(s0)
   12220:	01c42583          	lw	a1,28(s0)
   12224:	00090693          	mv	a3,s2
   12228:	00098613          	mv	a2,s3
   1222c:	00048513          	mv	a0,s1
   12230:	000780e7          	jalr	a5
   12234:	00a04863          	bgtz	a0,12244 <__sflush_r+0x1fc>
   12238:	00c45783          	lhu	a5,12(s0)
   1223c:	0407e793          	ori	a5,a5,64
   12240:	fa5ff06f          	j	121e4 <__sflush_r+0x19c>
   12244:	00a989b3          	add	s3,s3,a0
   12248:	40a90933          	sub	s2,s2,a0
   1224c:	fcdff06f          	j	12218 <__sflush_r+0x1d0>

00012250 <_fflush_r>:
   12250:	fe010113          	addi	sp,sp,-32
   12254:	00812c23          	sw	s0,24(sp)
   12258:	00112e23          	sw	ra,28(sp)
   1225c:	00050413          	mv	s0,a0
   12260:	00050c63          	beqz	a0,12278 <_fflush_r+0x28>
   12264:	03852783          	lw	a5,56(a0)
   12268:	00079863          	bnez	a5,12278 <_fflush_r+0x28>
   1226c:	00b12623          	sw	a1,12(sp)
   12270:	d44fe0ef          	jal	ra,107b4 <__sinit>
   12274:	00c12583          	lw	a1,12(sp)
   12278:	00c59783          	lh	a5,12(a1)
   1227c:	00078c63          	beqz	a5,12294 <_fflush_r+0x44>
   12280:	00040513          	mv	a0,s0
   12284:	01812403          	lw	s0,24(sp)
   12288:	01c12083          	lw	ra,28(sp)
   1228c:	02010113          	addi	sp,sp,32
   12290:	db9ff06f          	j	12048 <__sflush_r>
   12294:	01c12083          	lw	ra,28(sp)
   12298:	01812403          	lw	s0,24(sp)
   1229c:	00000513          	li	a0,0
   122a0:	02010113          	addi	sp,sp,32
   122a4:	00008067          	ret

000122a8 <fflush>:
   122a8:	00050593          	mv	a1,a0
   122ac:	00051c63          	bnez	a0,122c4 <fflush+0x1c>
   122b0:	000157b7          	lui	a5,0x15
   122b4:	9247a503          	lw	a0,-1756(a5) # 14924 <_global_impure_ptr>
   122b8:	000125b7          	lui	a1,0x12
   122bc:	25058593          	addi	a1,a1,592 # 12250 <_fflush_r>
   122c0:	b99fe06f          	j	10e58 <_fwalk_reent>
   122c4:	8081a503          	lw	a0,-2040(gp) # 14928 <_impure_ptr>
   122c8:	f89ff06f          	j	12250 <_fflush_r>

000122cc <_malloc_trim_r>:
   122cc:	fd010113          	addi	sp,sp,-48
   122d0:	03212023          	sw	s2,32(sp)
   122d4:	00014937          	lui	s2,0x14
   122d8:	02812423          	sw	s0,40(sp)
   122dc:	02912223          	sw	s1,36(sp)
   122e0:	01312e23          	sw	s3,28(sp)
   122e4:	00b12623          	sw	a1,12(sp)
   122e8:	02112623          	sw	ra,44(sp)
   122ec:	00050993          	mv	s3,a0
   122f0:	51890913          	addi	s2,s2,1304 # 14518 <__malloc_av_>
   122f4:	bbcff0ef          	jal	ra,116b0 <__malloc_lock>
   122f8:	00892783          	lw	a5,8(s2)
   122fc:	00c12583          	lw	a1,12(sp)
   12300:	0047a483          	lw	s1,4(a5)
   12304:	000017b7          	lui	a5,0x1
   12308:	fef78413          	addi	s0,a5,-17 # fef <main-0xf085>
   1230c:	ffc4f493          	andi	s1,s1,-4
   12310:	40b40433          	sub	s0,s0,a1
   12314:	00940433          	add	s0,s0,s1
   12318:	00c45413          	srli	s0,s0,0xc
   1231c:	fff40413          	addi	s0,s0,-1
   12320:	00c41413          	slli	s0,s0,0xc
   12324:	02f45663          	ble	a5,s0,12350 <_malloc_trim_r+0x84>
   12328:	00098513          	mv	a0,s3
   1232c:	b88ff0ef          	jal	ra,116b4 <__malloc_unlock>
   12330:	00000513          	li	a0,0
   12334:	02c12083          	lw	ra,44(sp)
   12338:	02812403          	lw	s0,40(sp)
   1233c:	02412483          	lw	s1,36(sp)
   12340:	02012903          	lw	s2,32(sp)
   12344:	01c12983          	lw	s3,28(sp)
   12348:	03010113          	addi	sp,sp,48
   1234c:	00008067          	ret
   12350:	00000593          	li	a1,0
   12354:	00098513          	mv	a0,s3
   12358:	8b9ff0ef          	jal	ra,11c10 <_sbrk_r>
   1235c:	00892783          	lw	a5,8(s2)
   12360:	009787b3          	add	a5,a5,s1
   12364:	fcf512e3          	bne	a0,a5,12328 <_malloc_trim_r+0x5c>
   12368:	408005b3          	neg	a1,s0
   1236c:	00098513          	mv	a0,s3
   12370:	8a1ff0ef          	jal	ra,11c10 <_sbrk_r>
   12374:	fff00793          	li	a5,-1
   12378:	02f51c63          	bne	a0,a5,123b0 <_malloc_trim_r+0xe4>
   1237c:	00000593          	li	a1,0
   12380:	00098513          	mv	a0,s3
   12384:	88dff0ef          	jal	ra,11c10 <_sbrk_r>
   12388:	00892703          	lw	a4,8(s2)
   1238c:	00f00693          	li	a3,15
   12390:	40e507b3          	sub	a5,a0,a4
   12394:	f8f6dae3          	ble	a5,a3,12328 <_malloc_trim_r+0x5c>
   12398:	80c1a683          	lw	a3,-2036(gp) # 1492c <__malloc_sbrk_base>
   1239c:	0017e793          	ori	a5,a5,1
   123a0:	00f72223          	sw	a5,4(a4)
   123a4:	40d50533          	sub	a0,a0,a3
   123a8:	84a1a423          	sw	a0,-1976(gp) # 14968 <__malloc_current_mallinfo>
   123ac:	f7dff06f          	j	12328 <_malloc_trim_r+0x5c>
   123b0:	00892783          	lw	a5,8(s2)
   123b4:	408484b3          	sub	s1,s1,s0
   123b8:	0014e493          	ori	s1,s1,1
   123bc:	0097a223          	sw	s1,4(a5)
   123c0:	8481a783          	lw	a5,-1976(gp) # 14968 <__malloc_current_mallinfo>
   123c4:	00098513          	mv	a0,s3
   123c8:	40878433          	sub	s0,a5,s0
   123cc:	8481a423          	sw	s0,-1976(gp) # 14968 <__malloc_current_mallinfo>
   123d0:	ae4ff0ef          	jal	ra,116b4 <__malloc_unlock>
   123d4:	00100513          	li	a0,1
   123d8:	f5dff06f          	j	12334 <_malloc_trim_r+0x68>

000123dc <_free_r>:
   123dc:	24058c63          	beqz	a1,12634 <_free_r+0x258>
   123e0:	ff010113          	addi	sp,sp,-16
   123e4:	00812423          	sw	s0,8(sp)
   123e8:	00912223          	sw	s1,4(sp)
   123ec:	00050413          	mv	s0,a0
   123f0:	00058493          	mv	s1,a1
   123f4:	00112623          	sw	ra,12(sp)
   123f8:	ab8ff0ef          	jal	ra,116b0 <__malloc_lock>
   123fc:	ffc4a503          	lw	a0,-4(s1)
   12400:	00014637          	lui	a2,0x14
   12404:	ff848693          	addi	a3,s1,-8
   12408:	ffe57793          	andi	a5,a0,-2
   1240c:	51860813          	addi	a6,a2,1304 # 14518 <__malloc_av_>
   12410:	00f685b3          	add	a1,a3,a5
   12414:	0045a703          	lw	a4,4(a1)
   12418:	00882803          	lw	a6,8(a6)
   1241c:	51860613          	addi	a2,a2,1304
   12420:	ffc77713          	andi	a4,a4,-4
   12424:	00157513          	andi	a0,a0,1
   12428:	06b81063          	bne	a6,a1,12488 <_free_r+0xac>
   1242c:	00e787b3          	add	a5,a5,a4
   12430:	02051063          	bnez	a0,12450 <_free_r+0x74>
   12434:	ff84a703          	lw	a4,-8(s1)
   12438:	40e686b3          	sub	a3,a3,a4
   1243c:	0086a583          	lw	a1,8(a3)
   12440:	00e787b3          	add	a5,a5,a4
   12444:	00c6a703          	lw	a4,12(a3)
   12448:	00e5a623          	sw	a4,12(a1)
   1244c:	00b72423          	sw	a1,8(a4)
   12450:	0017e713          	ori	a4,a5,1
   12454:	00e6a223          	sw	a4,4(a3)
   12458:	8101a703          	lw	a4,-2032(gp) # 14930 <__malloc_trim_threshold>
   1245c:	00d62423          	sw	a3,8(a2)
   12460:	00e7e863          	bltu	a5,a4,12470 <_free_r+0x94>
   12464:	81c1a583          	lw	a1,-2020(gp) # 1493c <__malloc_top_pad>
   12468:	00040513          	mv	a0,s0
   1246c:	e61ff0ef          	jal	ra,122cc <_malloc_trim_r>
   12470:	00040513          	mv	a0,s0
   12474:	00812403          	lw	s0,8(sp)
   12478:	00c12083          	lw	ra,12(sp)
   1247c:	00412483          	lw	s1,4(sp)
   12480:	01010113          	addi	sp,sp,16
   12484:	a30ff06f          	j	116b4 <__malloc_unlock>
   12488:	00e5a223          	sw	a4,4(a1)
   1248c:	00000813          	li	a6,0
   12490:	02051663          	bnez	a0,124bc <_free_r+0xe0>
   12494:	ff84a503          	lw	a0,-8(s1)
   12498:	000148b7          	lui	a7,0x14
   1249c:	52088893          	addi	a7,a7,1312 # 14520 <__malloc_av_+0x8>
   124a0:	40a686b3          	sub	a3,a3,a0
   124a4:	00a787b3          	add	a5,a5,a0
   124a8:	0086a503          	lw	a0,8(a3)
   124ac:	0b150663          	beq	a0,a7,12558 <_free_r+0x17c>
   124b0:	00c6a883          	lw	a7,12(a3)
   124b4:	01152623          	sw	a7,12(a0)
   124b8:	00a8a423          	sw	a0,8(a7)
   124bc:	00e58533          	add	a0,a1,a4
   124c0:	00452503          	lw	a0,4(a0)
   124c4:	00157513          	andi	a0,a0,1
   124c8:	02051863          	bnez	a0,124f8 <_free_r+0x11c>
   124cc:	00e787b3          	add	a5,a5,a4
   124d0:	0085a703          	lw	a4,8(a1)
   124d4:	08081663          	bnez	a6,12560 <_free_r+0x184>
   124d8:	00014537          	lui	a0,0x14
   124dc:	52050513          	addi	a0,a0,1312 # 14520 <__malloc_av_+0x8>
   124e0:	08a71063          	bne	a4,a0,12560 <_free_r+0x184>
   124e4:	00d62a23          	sw	a3,20(a2)
   124e8:	00d62823          	sw	a3,16(a2)
   124ec:	00e6a623          	sw	a4,12(a3)
   124f0:	00e6a423          	sw	a4,8(a3)
   124f4:	00100813          	li	a6,1
   124f8:	0017e713          	ori	a4,a5,1
   124fc:	00e6a223          	sw	a4,4(a3)
   12500:	00f68733          	add	a4,a3,a5
   12504:	00f72023          	sw	a5,0(a4)
   12508:	f60814e3          	bnez	a6,12470 <_free_r+0x94>
   1250c:	1ff00713          	li	a4,511
   12510:	06f76063          	bltu	a4,a5,12570 <_free_r+0x194>
   12514:	0037d793          	srli	a5,a5,0x3
   12518:	4027d593          	srai	a1,a5,0x2
   1251c:	00100713          	li	a4,1
   12520:	00b71733          	sll	a4,a4,a1
   12524:	00462583          	lw	a1,4(a2)
   12528:	00178793          	addi	a5,a5,1
   1252c:	00379793          	slli	a5,a5,0x3
   12530:	00f607b3          	add	a5,a2,a5
   12534:	00b76733          	or	a4,a4,a1
   12538:	00e62223          	sw	a4,4(a2)
   1253c:	0007a703          	lw	a4,0(a5)
   12540:	ff878613          	addi	a2,a5,-8
   12544:	00c6a623          	sw	a2,12(a3)
   12548:	00e6a423          	sw	a4,8(a3)
   1254c:	00d7a023          	sw	a3,0(a5)
   12550:	00d72623          	sw	a3,12(a4)
   12554:	f1dff06f          	j	12470 <_free_r+0x94>
   12558:	00100813          	li	a6,1
   1255c:	f61ff06f          	j	124bc <_free_r+0xe0>
   12560:	00c5a583          	lw	a1,12(a1)
   12564:	00b72623          	sw	a1,12(a4)
   12568:	00e5a423          	sw	a4,8(a1)
   1256c:	f8dff06f          	j	124f8 <_free_r+0x11c>
   12570:	0097d593          	srli	a1,a5,0x9
   12574:	00400713          	li	a4,4
   12578:	04b76863          	bltu	a4,a1,125c8 <_free_r+0x1ec>
   1257c:	0067d713          	srli	a4,a5,0x6
   12580:	03870713          	addi	a4,a4,56
   12584:	00170593          	addi	a1,a4,1
   12588:	00359593          	slli	a1,a1,0x3
   1258c:	00b605b3          	add	a1,a2,a1
   12590:	ff858513          	addi	a0,a1,-8
   12594:	0005a583          	lw	a1,0(a1)
   12598:	08b51463          	bne	a0,a1,12620 <_free_r+0x244>
   1259c:	00100793          	li	a5,1
   125a0:	40275713          	srai	a4,a4,0x2
   125a4:	00e79733          	sll	a4,a5,a4
   125a8:	00462783          	lw	a5,4(a2)
   125ac:	00f76733          	or	a4,a4,a5
   125b0:	00e62223          	sw	a4,4(a2)
   125b4:	00a6a623          	sw	a0,12(a3)
   125b8:	00b6a423          	sw	a1,8(a3)
   125bc:	00d52423          	sw	a3,8(a0)
   125c0:	00d5a623          	sw	a3,12(a1)
   125c4:	eadff06f          	j	12470 <_free_r+0x94>
   125c8:	01400713          	li	a4,20
   125cc:	00b76663          	bltu	a4,a1,125d8 <_free_r+0x1fc>
   125d0:	05b58713          	addi	a4,a1,91
   125d4:	fb1ff06f          	j	12584 <_free_r+0x1a8>
   125d8:	05400713          	li	a4,84
   125dc:	00b76863          	bltu	a4,a1,125ec <_free_r+0x210>
   125e0:	00c7d713          	srli	a4,a5,0xc
   125e4:	06e70713          	addi	a4,a4,110
   125e8:	f9dff06f          	j	12584 <_free_r+0x1a8>
   125ec:	15400713          	li	a4,340
   125f0:	00b76863          	bltu	a4,a1,12600 <_free_r+0x224>
   125f4:	00f7d713          	srli	a4,a5,0xf
   125f8:	07770713          	addi	a4,a4,119
   125fc:	f89ff06f          	j	12584 <_free_r+0x1a8>
   12600:	55400513          	li	a0,1364
   12604:	07e00713          	li	a4,126
   12608:	f6b56ee3          	bltu	a0,a1,12584 <_free_r+0x1a8>
   1260c:	0127d713          	srli	a4,a5,0x12
   12610:	07c70713          	addi	a4,a4,124
   12614:	f71ff06f          	j	12584 <_free_r+0x1a8>
   12618:	0085a583          	lw	a1,8(a1)
   1261c:	00b50863          	beq	a0,a1,1262c <_free_r+0x250>
   12620:	0045a703          	lw	a4,4(a1)
   12624:	ffc77713          	andi	a4,a4,-4
   12628:	fee7e8e3          	bltu	a5,a4,12618 <_free_r+0x23c>
   1262c:	00c5a503          	lw	a0,12(a1)
   12630:	f85ff06f          	j	125b4 <_free_r+0x1d8>
   12634:	00008067          	ret

00012638 <_lseek_r>:
   12638:	ff010113          	addi	sp,sp,-16
   1263c:	00812423          	sw	s0,8(sp)
   12640:	00912223          	sw	s1,4(sp)
   12644:	00050493          	mv	s1,a0
   12648:	00058513          	mv	a0,a1
   1264c:	00060593          	mv	a1,a2
   12650:	00068613          	mv	a2,a3
   12654:	00112623          	sw	ra,12(sp)
   12658:	8601a823          	sw	zero,-1936(gp) # 14990 <errno>
   1265c:	4d8000ef          	jal	ra,12b34 <lseek>
   12660:	fff00793          	li	a5,-1
   12664:	00f51863          	bne	a0,a5,12674 <_lseek_r+0x3c>
   12668:	8701a783          	lw	a5,-1936(gp) # 14990 <errno>
   1266c:	00078463          	beqz	a5,12674 <_lseek_r+0x3c>
   12670:	00f4a023          	sw	a5,0(s1)
   12674:	00c12083          	lw	ra,12(sp)
   12678:	00812403          	lw	s0,8(sp)
   1267c:	00412483          	lw	s1,4(sp)
   12680:	01010113          	addi	sp,sp,16
   12684:	00008067          	ret

00012688 <__swhatbuf_r>:
   12688:	fa010113          	addi	sp,sp,-96
   1268c:	04912a23          	sw	s1,84(sp)
   12690:	00058493          	mv	s1,a1
   12694:	00e59583          	lh	a1,14(a1)
   12698:	04812c23          	sw	s0,88(sp)
   1269c:	04112e23          	sw	ra,92(sp)
   126a0:	00060413          	mv	s0,a2
   126a4:	0005de63          	bgez	a1,126c0 <__swhatbuf_r+0x38>
   126a8:	00c4d783          	lhu	a5,12(s1)
   126ac:	0006a023          	sw	zero,0(a3)
   126b0:	0807f793          	andi	a5,a5,128
   126b4:	04079863          	bnez	a5,12704 <__swhatbuf_r+0x7c>
   126b8:	40000793          	li	a5,1024
   126bc:	04c0006f          	j	12708 <__swhatbuf_r+0x80>
   126c0:	01410613          	addi	a2,sp,20
   126c4:	00d12623          	sw	a3,12(sp)
   126c8:	2e8000ef          	jal	ra,129b0 <_fstat_r>
   126cc:	00c12683          	lw	a3,12(sp)
   126d0:	fc054ce3          	bltz	a0,126a8 <__swhatbuf_r+0x20>
   126d4:	01812703          	lw	a4,24(sp)
   126d8:	0000f7b7          	lui	a5,0xf
   126dc:	00001537          	lui	a0,0x1
   126e0:	00e7f7b3          	and	a5,a5,a4
   126e4:	ffffe737          	lui	a4,0xffffe
   126e8:	00e787b3          	add	a5,a5,a4
   126ec:	0017b793          	seqz	a5,a5
   126f0:	00f6a023          	sw	a5,0(a3)
   126f4:	40000793          	li	a5,1024
   126f8:	00f42023          	sw	a5,0(s0)
   126fc:	80050513          	addi	a0,a0,-2048 # 800 <main-0xf874>
   12700:	0100006f          	j	12710 <__swhatbuf_r+0x88>
   12704:	04000793          	li	a5,64
   12708:	00f42023          	sw	a5,0(s0)
   1270c:	00000513          	li	a0,0
   12710:	05c12083          	lw	ra,92(sp)
   12714:	05812403          	lw	s0,88(sp)
   12718:	05412483          	lw	s1,84(sp)
   1271c:	06010113          	addi	sp,sp,96
   12720:	00008067          	ret

00012724 <__smakebuf_r>:
   12724:	00c5d783          	lhu	a5,12(a1)
   12728:	fe010113          	addi	sp,sp,-32
   1272c:	00812c23          	sw	s0,24(sp)
   12730:	00112e23          	sw	ra,28(sp)
   12734:	00912a23          	sw	s1,20(sp)
   12738:	01212823          	sw	s2,16(sp)
   1273c:	0027f793          	andi	a5,a5,2
   12740:	00058413          	mv	s0,a1
   12744:	02078863          	beqz	a5,12774 <__smakebuf_r+0x50>
   12748:	04340793          	addi	a5,s0,67
   1274c:	00f42023          	sw	a5,0(s0)
   12750:	00f42823          	sw	a5,16(s0)
   12754:	00100793          	li	a5,1
   12758:	00f42a23          	sw	a5,20(s0)
   1275c:	01c12083          	lw	ra,28(sp)
   12760:	01812403          	lw	s0,24(sp)
   12764:	01412483          	lw	s1,20(sp)
   12768:	01012903          	lw	s2,16(sp)
   1276c:	02010113          	addi	sp,sp,32
   12770:	00008067          	ret
   12774:	00c10693          	addi	a3,sp,12
   12778:	00810613          	addi	a2,sp,8
   1277c:	00050493          	mv	s1,a0
   12780:	f09ff0ef          	jal	ra,12688 <__swhatbuf_r>
   12784:	00812583          	lw	a1,8(sp)
   12788:	00050913          	mv	s2,a0
   1278c:	00048513          	mv	a0,s1
   12790:	f7cfe0ef          	jal	ra,10f0c <_malloc_r>
   12794:	02051063          	bnez	a0,127b4 <__smakebuf_r+0x90>
   12798:	00c41783          	lh	a5,12(s0)
   1279c:	2007f713          	andi	a4,a5,512
   127a0:	fa071ee3          	bnez	a4,1275c <__smakebuf_r+0x38>
   127a4:	ffc7f793          	andi	a5,a5,-4
   127a8:	0027e793          	ori	a5,a5,2
   127ac:	00f41623          	sh	a5,12(s0)
   127b0:	f99ff06f          	j	12748 <__smakebuf_r+0x24>
   127b4:	000107b7          	lui	a5,0x10
   127b8:	69478793          	addi	a5,a5,1684 # 10694 <_cleanup_r>
   127bc:	02f4ae23          	sw	a5,60(s1)
   127c0:	00c45783          	lhu	a5,12(s0)
   127c4:	00a42023          	sw	a0,0(s0)
   127c8:	00a42823          	sw	a0,16(s0)
   127cc:	0807e793          	ori	a5,a5,128
   127d0:	00f41623          	sh	a5,12(s0)
   127d4:	00812783          	lw	a5,8(sp)
   127d8:	00f42a23          	sw	a5,20(s0)
   127dc:	00c12783          	lw	a5,12(sp)
   127e0:	02078263          	beqz	a5,12804 <__smakebuf_r+0xe0>
   127e4:	00e41583          	lh	a1,14(s0)
   127e8:	00048513          	mv	a0,s1
   127ec:	210000ef          	jal	ra,129fc <_isatty_r>
   127f0:	00050a63          	beqz	a0,12804 <__smakebuf_r+0xe0>
   127f4:	00c45783          	lhu	a5,12(s0)
   127f8:	ffc7f793          	andi	a5,a5,-4
   127fc:	0017e793          	ori	a5,a5,1
   12800:	00f41623          	sh	a5,12(s0)
   12804:	00c45783          	lhu	a5,12(s0)
   12808:	00f96933          	or	s2,s2,a5
   1280c:	01241623          	sh	s2,12(s0)
   12810:	f4dff06f          	j	1275c <__smakebuf_r+0x38>

00012814 <_read_r>:
   12814:	ff010113          	addi	sp,sp,-16
   12818:	00812423          	sw	s0,8(sp)
   1281c:	00912223          	sw	s1,4(sp)
   12820:	00050493          	mv	s1,a0
   12824:	00058513          	mv	a0,a1
   12828:	00060593          	mv	a1,a2
   1282c:	00068613          	mv	a2,a3
   12830:	00112623          	sw	ra,12(sp)
   12834:	8601a823          	sw	zero,-1936(gp) # 14990 <errno>
   12838:	314000ef          	jal	ra,12b4c <read>
   1283c:	fff00793          	li	a5,-1
   12840:	00f51863          	bne	a0,a5,12850 <_read_r+0x3c>
   12844:	8701a783          	lw	a5,-1936(gp) # 14990 <errno>
   12848:	00078463          	beqz	a5,12850 <_read_r+0x3c>
   1284c:	00f4a023          	sw	a5,0(s1)
   12850:	00c12083          	lw	ra,12(sp)
   12854:	00812403          	lw	s0,8(sp)
   12858:	00412483          	lw	s1,4(sp)
   1285c:	01010113          	addi	sp,sp,16
   12860:	00008067          	ret

00012864 <cleanup_glue>:
   12864:	ff010113          	addi	sp,sp,-16
   12868:	00812423          	sw	s0,8(sp)
   1286c:	00058413          	mv	s0,a1
   12870:	0005a583          	lw	a1,0(a1)
   12874:	00912223          	sw	s1,4(sp)
   12878:	00112623          	sw	ra,12(sp)
   1287c:	00050493          	mv	s1,a0
   12880:	00058463          	beqz	a1,12888 <cleanup_glue+0x24>
   12884:	fe1ff0ef          	jal	ra,12864 <cleanup_glue>
   12888:	00040593          	mv	a1,s0
   1288c:	00812403          	lw	s0,8(sp)
   12890:	00c12083          	lw	ra,12(sp)
   12894:	00048513          	mv	a0,s1
   12898:	00412483          	lw	s1,4(sp)
   1289c:	01010113          	addi	sp,sp,16
   128a0:	b3dff06f          	j	123dc <_free_r>

000128a4 <_reclaim_reent>:
   128a4:	8081a783          	lw	a5,-2040(gp) # 14928 <_impure_ptr>
   128a8:	10a78263          	beq	a5,a0,129ac <_reclaim_reent+0x108>
   128ac:	04c52783          	lw	a5,76(a0)
   128b0:	fe010113          	addi	sp,sp,-32
   128b4:	00812c23          	sw	s0,24(sp)
   128b8:	00912a23          	sw	s1,20(sp)
   128bc:	01212823          	sw	s2,16(sp)
   128c0:	00112e23          	sw	ra,28(sp)
   128c4:	01312623          	sw	s3,12(sp)
   128c8:	00050413          	mv	s0,a0
   128cc:	00000493          	li	s1,0
   128d0:	08000913          	li	s2,128
   128d4:	04079463          	bnez	a5,1291c <_reclaim_reent+0x78>
   128d8:	04042583          	lw	a1,64(s0)
   128dc:	00058663          	beqz	a1,128e8 <_reclaim_reent+0x44>
   128e0:	00040513          	mv	a0,s0
   128e4:	af9ff0ef          	jal	ra,123dc <_free_r>
   128e8:	14842583          	lw	a1,328(s0)
   128ec:	04058c63          	beqz	a1,12944 <_reclaim_reent+0xa0>
   128f0:	14c40493          	addi	s1,s0,332
   128f4:	04958863          	beq	a1,s1,12944 <_reclaim_reent+0xa0>
   128f8:	0005a903          	lw	s2,0(a1)
   128fc:	00040513          	mv	a0,s0
   12900:	addff0ef          	jal	ra,123dc <_free_r>
   12904:	00090593          	mv	a1,s2
   12908:	fedff06f          	j	128f4 <_reclaim_reent+0x50>
   1290c:	009585b3          	add	a1,a1,s1
   12910:	0005a583          	lw	a1,0(a1)
   12914:	00059e63          	bnez	a1,12930 <_reclaim_reent+0x8c>
   12918:	00448493          	addi	s1,s1,4
   1291c:	04c42583          	lw	a1,76(s0)
   12920:	ff2496e3          	bne	s1,s2,1290c <_reclaim_reent+0x68>
   12924:	00040513          	mv	a0,s0
   12928:	ab5ff0ef          	jal	ra,123dc <_free_r>
   1292c:	fadff06f          	j	128d8 <_reclaim_reent+0x34>
   12930:	0005a983          	lw	s3,0(a1)
   12934:	00040513          	mv	a0,s0
   12938:	aa5ff0ef          	jal	ra,123dc <_free_r>
   1293c:	00098593          	mv	a1,s3
   12940:	fd5ff06f          	j	12914 <_reclaim_reent+0x70>
   12944:	05442583          	lw	a1,84(s0)
   12948:	00058663          	beqz	a1,12954 <_reclaim_reent+0xb0>
   1294c:	00040513          	mv	a0,s0
   12950:	a8dff0ef          	jal	ra,123dc <_free_r>
   12954:	03842783          	lw	a5,56(s0)
   12958:	02078c63          	beqz	a5,12990 <_reclaim_reent+0xec>
   1295c:	03c42783          	lw	a5,60(s0)
   12960:	00040513          	mv	a0,s0
   12964:	000780e7          	jalr	a5
   12968:	2e042583          	lw	a1,736(s0)
   1296c:	02058263          	beqz	a1,12990 <_reclaim_reent+0xec>
   12970:	00040513          	mv	a0,s0
   12974:	01812403          	lw	s0,24(sp)
   12978:	01c12083          	lw	ra,28(sp)
   1297c:	01412483          	lw	s1,20(sp)
   12980:	01012903          	lw	s2,16(sp)
   12984:	00c12983          	lw	s3,12(sp)
   12988:	02010113          	addi	sp,sp,32
   1298c:	ed9ff06f          	j	12864 <cleanup_glue>
   12990:	01c12083          	lw	ra,28(sp)
   12994:	01812403          	lw	s0,24(sp)
   12998:	01412483          	lw	s1,20(sp)
   1299c:	01012903          	lw	s2,16(sp)
   129a0:	00c12983          	lw	s3,12(sp)
   129a4:	02010113          	addi	sp,sp,32
   129a8:	00008067          	ret
   129ac:	00008067          	ret

000129b0 <_fstat_r>:
   129b0:	ff010113          	addi	sp,sp,-16
   129b4:	00812423          	sw	s0,8(sp)
   129b8:	00912223          	sw	s1,4(sp)
   129bc:	00050493          	mv	s1,a0
   129c0:	00058513          	mv	a0,a1
   129c4:	00060593          	mv	a1,a2
   129c8:	00112623          	sw	ra,12(sp)
   129cc:	8601a823          	sw	zero,-1936(gp) # 14990 <errno>
   129d0:	1ac000ef          	jal	ra,12b7c <fstat>
   129d4:	fff00793          	li	a5,-1
   129d8:	00f51863          	bne	a0,a5,129e8 <_fstat_r+0x38>
   129dc:	8701a783          	lw	a5,-1936(gp) # 14990 <errno>
   129e0:	00078463          	beqz	a5,129e8 <_fstat_r+0x38>
   129e4:	00f4a023          	sw	a5,0(s1)
   129e8:	00c12083          	lw	ra,12(sp)
   129ec:	00812403          	lw	s0,8(sp)
   129f0:	00412483          	lw	s1,4(sp)
   129f4:	01010113          	addi	sp,sp,16
   129f8:	00008067          	ret

000129fc <_isatty_r>:
   129fc:	ff010113          	addi	sp,sp,-16
   12a00:	00812423          	sw	s0,8(sp)
   12a04:	00912223          	sw	s1,4(sp)
   12a08:	00050493          	mv	s1,a0
   12a0c:	00058513          	mv	a0,a1
   12a10:	00112623          	sw	ra,12(sp)
   12a14:	8601a823          	sw	zero,-1936(gp) # 14990 <errno>
   12a18:	3c4000ef          	jal	ra,12ddc <isatty>
   12a1c:	fff00793          	li	a5,-1
   12a20:	00f51863          	bne	a0,a5,12a30 <_isatty_r+0x34>
   12a24:	8701a783          	lw	a5,-1936(gp) # 14990 <errno>
   12a28:	00078463          	beqz	a5,12a30 <_isatty_r+0x34>
   12a2c:	00f4a023          	sw	a5,0(s1)
   12a30:	00c12083          	lw	ra,12(sp)
   12a34:	00812403          	lw	s0,8(sp)
   12a38:	00412483          	lw	s1,4(sp)
   12a3c:	01010113          	addi	sp,sp,16
   12a40:	00008067          	ret

00012a44 <conv_stat>:
   12a44:	0005a783          	lw	a5,0(a1)
   12a48:	00f51023          	sh	a5,0(a0)
   12a4c:	0085a783          	lw	a5,8(a1)
   12a50:	00f51123          	sh	a5,2(a0)
   12a54:	0105a783          	lw	a5,16(a1)
   12a58:	00f52223          	sw	a5,4(a0)
   12a5c:	0145a783          	lw	a5,20(a1)
   12a60:	00f51423          	sh	a5,8(a0)
   12a64:	0185a783          	lw	a5,24(a1)
   12a68:	00f51523          	sh	a5,10(a0)
   12a6c:	01c5a783          	lw	a5,28(a1)
   12a70:	00f51623          	sh	a5,12(a0)
   12a74:	0205a783          	lw	a5,32(a1)
   12a78:	00f51723          	sh	a5,14(a0)
   12a7c:	0305a783          	lw	a5,48(a1)
   12a80:	00f52823          	sw	a5,16(a0)
   12a84:	0405a783          	lw	a5,64(a1)
   12a88:	02f52823          	sw	a5,48(a0)
   12a8c:	0385a783          	lw	a5,56(a1)
   12a90:	02f52623          	sw	a5,44(a0)
   12a94:	0485a783          	lw	a5,72(a1)
   12a98:	00f52a23          	sw	a5,20(a0)
   12a9c:	0505a783          	lw	a5,80(a1)
   12aa0:	00f52e23          	sw	a5,28(a0)
   12aa4:	0585a783          	lw	a5,88(a1)
   12aa8:	02f52223          	sw	a5,36(a0)
   12aac:	00008067          	ret

00012ab0 <__syscall_error>:
   12ab0:	ff010113          	addi	sp,sp,-16
   12ab4:	00812423          	sw	s0,8(sp)
   12ab8:	00112623          	sw	ra,12(sp)
   12abc:	00050413          	mv	s0,a0
   12ac0:	4f0000ef          	jal	ra,12fb0 <__errno>
   12ac4:	408007b3          	neg	a5,s0
   12ac8:	00c12083          	lw	ra,12(sp)
   12acc:	00812403          	lw	s0,8(sp)
   12ad0:	00f52023          	sw	a5,0(a0)
   12ad4:	fff00513          	li	a0,-1
   12ad8:	01010113          	addi	sp,sp,16
   12adc:	00008067          	ret

00012ae0 <__internal_syscall>:
   12ae0:	00050893          	mv	a7,a0
   12ae4:	00058513          	mv	a0,a1
   12ae8:	00060593          	mv	a1,a2
   12aec:	00068613          	mv	a2,a3
   12af0:	00070693          	mv	a3,a4
   12af4:	00000073          	ecall
   12af8:	00055463          	bgez	a0,12b00 <__internal_syscall+0x20>
   12afc:	fb5ff06f          	j	12ab0 <__syscall_error>
   12b00:	00008067          	ret

00012b04 <open>:
   12b04:	00060693          	mv	a3,a2
   12b08:	00000713          	li	a4,0
   12b0c:	00058613          	mv	a2,a1
   12b10:	00050593          	mv	a1,a0
   12b14:	40000513          	li	a0,1024
   12b18:	fc9ff06f          	j	12ae0 <__internal_syscall>

00012b1c <openat>:
   12b1c:	00068713          	mv	a4,a3
   12b20:	00060693          	mv	a3,a2
   12b24:	00058613          	mv	a2,a1
   12b28:	00050593          	mv	a1,a0
   12b2c:	03800513          	li	a0,56
   12b30:	fb1ff06f          	j	12ae0 <__internal_syscall>

00012b34 <lseek>:
   12b34:	00060693          	mv	a3,a2
   12b38:	00000713          	li	a4,0
   12b3c:	00058613          	mv	a2,a1
   12b40:	00050593          	mv	a1,a0
   12b44:	03e00513          	li	a0,62
   12b48:	f99ff06f          	j	12ae0 <__internal_syscall>

00012b4c <read>:
   12b4c:	00060693          	mv	a3,a2
   12b50:	00000713          	li	a4,0
   12b54:	00058613          	mv	a2,a1
   12b58:	00050593          	mv	a1,a0
   12b5c:	03f00513          	li	a0,63
   12b60:	f81ff06f          	j	12ae0 <__internal_syscall>

00012b64 <write>:
   12b64:	00060693          	mv	a3,a2
   12b68:	00000713          	li	a4,0
   12b6c:	00058613          	mv	a2,a1
   12b70:	00050593          	mv	a1,a0
   12b74:	04000513          	li	a0,64
   12b78:	f69ff06f          	j	12ae0 <__internal_syscall>

00012b7c <fstat>:
   12b7c:	f8010113          	addi	sp,sp,-128
   12b80:	06912a23          	sw	s1,116(sp)
   12b84:	00810613          	addi	a2,sp,8
   12b88:	00058493          	mv	s1,a1
   12b8c:	00000713          	li	a4,0
   12b90:	00050593          	mv	a1,a0
   12b94:	00000693          	li	a3,0
   12b98:	05000513          	li	a0,80
   12b9c:	06112e23          	sw	ra,124(sp)
   12ba0:	06812c23          	sw	s0,120(sp)
   12ba4:	f3dff0ef          	jal	ra,12ae0 <__internal_syscall>
   12ba8:	00050413          	mv	s0,a0
   12bac:	00810593          	addi	a1,sp,8
   12bb0:	00048513          	mv	a0,s1
   12bb4:	e91ff0ef          	jal	ra,12a44 <conv_stat>
   12bb8:	00040513          	mv	a0,s0
   12bbc:	07c12083          	lw	ra,124(sp)
   12bc0:	07812403          	lw	s0,120(sp)
   12bc4:	07412483          	lw	s1,116(sp)
   12bc8:	08010113          	addi	sp,sp,128
   12bcc:	00008067          	ret

00012bd0 <stat>:
   12bd0:	f8010113          	addi	sp,sp,-128
   12bd4:	06912a23          	sw	s1,116(sp)
   12bd8:	00810613          	addi	a2,sp,8
   12bdc:	00058493          	mv	s1,a1
   12be0:	00000713          	li	a4,0
   12be4:	00050593          	mv	a1,a0
   12be8:	00000693          	li	a3,0
   12bec:	40e00513          	li	a0,1038
   12bf0:	06112e23          	sw	ra,124(sp)
   12bf4:	06812c23          	sw	s0,120(sp)
   12bf8:	ee9ff0ef          	jal	ra,12ae0 <__internal_syscall>
   12bfc:	00050413          	mv	s0,a0
   12c00:	00810593          	addi	a1,sp,8
   12c04:	00048513          	mv	a0,s1
   12c08:	e3dff0ef          	jal	ra,12a44 <conv_stat>
   12c0c:	00040513          	mv	a0,s0
   12c10:	07c12083          	lw	ra,124(sp)
   12c14:	07812403          	lw	s0,120(sp)
   12c18:	07412483          	lw	s1,116(sp)
   12c1c:	08010113          	addi	sp,sp,128
   12c20:	00008067          	ret

00012c24 <lstat>:
   12c24:	f8010113          	addi	sp,sp,-128
   12c28:	06912a23          	sw	s1,116(sp)
   12c2c:	00810613          	addi	a2,sp,8
   12c30:	00058493          	mv	s1,a1
   12c34:	00000713          	li	a4,0
   12c38:	00050593          	mv	a1,a0
   12c3c:	00000693          	li	a3,0
   12c40:	40f00513          	li	a0,1039
   12c44:	06112e23          	sw	ra,124(sp)
   12c48:	06812c23          	sw	s0,120(sp)
   12c4c:	e95ff0ef          	jal	ra,12ae0 <__internal_syscall>
   12c50:	00050413          	mv	s0,a0
   12c54:	00810593          	addi	a1,sp,8
   12c58:	00048513          	mv	a0,s1
   12c5c:	de9ff0ef          	jal	ra,12a44 <conv_stat>
   12c60:	00040513          	mv	a0,s0
   12c64:	07c12083          	lw	ra,124(sp)
   12c68:	07812403          	lw	s0,120(sp)
   12c6c:	07412483          	lw	s1,116(sp)
   12c70:	08010113          	addi	sp,sp,128
   12c74:	00008067          	ret

00012c78 <fstatat>:
   12c78:	f8010113          	addi	sp,sp,-128
   12c7c:	06912a23          	sw	s1,116(sp)
   12c80:	00068713          	mv	a4,a3
   12c84:	00060493          	mv	s1,a2
   12c88:	00810693          	addi	a3,sp,8
   12c8c:	00058613          	mv	a2,a1
   12c90:	00050593          	mv	a1,a0
   12c94:	04f00513          	li	a0,79
   12c98:	06112e23          	sw	ra,124(sp)
   12c9c:	06812c23          	sw	s0,120(sp)
   12ca0:	e41ff0ef          	jal	ra,12ae0 <__internal_syscall>
   12ca4:	00050413          	mv	s0,a0
   12ca8:	00810593          	addi	a1,sp,8
   12cac:	00048513          	mv	a0,s1
   12cb0:	d95ff0ef          	jal	ra,12a44 <conv_stat>
   12cb4:	00040513          	mv	a0,s0
   12cb8:	07c12083          	lw	ra,124(sp)
   12cbc:	07812403          	lw	s0,120(sp)
   12cc0:	07412483          	lw	s1,116(sp)
   12cc4:	08010113          	addi	sp,sp,128
   12cc8:	00008067          	ret

00012ccc <access>:
   12ccc:	00058613          	mv	a2,a1
   12cd0:	00000713          	li	a4,0
   12cd4:	00050593          	mv	a1,a0
   12cd8:	00000693          	li	a3,0
   12cdc:	40900513          	li	a0,1033
   12ce0:	e01ff06f          	j	12ae0 <__internal_syscall>

00012ce4 <faccessat>:
   12ce4:	00068713          	mv	a4,a3
   12ce8:	00060693          	mv	a3,a2
   12cec:	00058613          	mv	a2,a1
   12cf0:	00050593          	mv	a1,a0
   12cf4:	03000513          	li	a0,48
   12cf8:	de9ff06f          	j	12ae0 <__internal_syscall>

00012cfc <close>:
   12cfc:	00050593          	mv	a1,a0
   12d00:	00000713          	li	a4,0
   12d04:	00000693          	li	a3,0
   12d08:	00000613          	li	a2,0
   12d0c:	03900513          	li	a0,57
   12d10:	dd1ff06f          	j	12ae0 <__internal_syscall>

00012d14 <link>:
   12d14:	00058613          	mv	a2,a1
   12d18:	00000713          	li	a4,0
   12d1c:	00050593          	mv	a1,a0
   12d20:	00000693          	li	a3,0
   12d24:	40100513          	li	a0,1025
   12d28:	db9ff06f          	j	12ae0 <__internal_syscall>

00012d2c <unlink>:
   12d2c:	00050593          	mv	a1,a0
   12d30:	00000713          	li	a4,0
   12d34:	00000693          	li	a3,0
   12d38:	00000613          	li	a2,0
   12d3c:	40200513          	li	a0,1026
   12d40:	da1ff06f          	j	12ae0 <__internal_syscall>

00012d44 <execve>:
   12d44:	ff010113          	addi	sp,sp,-16
   12d48:	00112623          	sw	ra,12(sp)
   12d4c:	264000ef          	jal	ra,12fb0 <__errno>
   12d50:	00c12083          	lw	ra,12(sp)
   12d54:	00c00793          	li	a5,12
   12d58:	00f52023          	sw	a5,0(a0)
   12d5c:	fff00513          	li	a0,-1
   12d60:	01010113          	addi	sp,sp,16
   12d64:	00008067          	ret

00012d68 <fork>:
   12d68:	ff010113          	addi	sp,sp,-16
   12d6c:	00112623          	sw	ra,12(sp)
   12d70:	240000ef          	jal	ra,12fb0 <__errno>
   12d74:	00c12083          	lw	ra,12(sp)
   12d78:	00b00793          	li	a5,11
   12d7c:	00f52023          	sw	a5,0(a0)
   12d80:	fff00513          	li	a0,-1
   12d84:	01010113          	addi	sp,sp,16
   12d88:	00008067          	ret

00012d8c <getpid>:
   12d8c:	00100513          	li	a0,1
   12d90:	00008067          	ret

00012d94 <kill>:
   12d94:	ff010113          	addi	sp,sp,-16
   12d98:	00112623          	sw	ra,12(sp)
   12d9c:	214000ef          	jal	ra,12fb0 <__errno>
   12da0:	00c12083          	lw	ra,12(sp)
   12da4:	01600793          	li	a5,22
   12da8:	00f52023          	sw	a5,0(a0)
   12dac:	fff00513          	li	a0,-1
   12db0:	01010113          	addi	sp,sp,16
   12db4:	00008067          	ret

00012db8 <wait>:
   12db8:	ff010113          	addi	sp,sp,-16
   12dbc:	00112623          	sw	ra,12(sp)
   12dc0:	1f0000ef          	jal	ra,12fb0 <__errno>
   12dc4:	00c12083          	lw	ra,12(sp)
   12dc8:	00a00793          	li	a5,10
   12dcc:	00f52023          	sw	a5,0(a0)
   12dd0:	fff00513          	li	a0,-1
   12dd4:	01010113          	addi	sp,sp,16
   12dd8:	00008067          	ret

00012ddc <isatty>:
   12ddc:	fb010113          	addi	sp,sp,-80
   12de0:	00410593          	addi	a1,sp,4
   12de4:	04112623          	sw	ra,76(sp)
   12de8:	d95ff0ef          	jal	ra,12b7c <fstat>
   12dec:	fff00793          	li	a5,-1
   12df0:	00f50863          	beq	a0,a5,12e00 <isatty+0x24>
   12df4:	00812503          	lw	a0,8(sp)
   12df8:	00d55513          	srli	a0,a0,0xd
   12dfc:	00157513          	andi	a0,a0,1
   12e00:	04c12083          	lw	ra,76(sp)
   12e04:	05010113          	addi	sp,sp,80
   12e08:	00008067          	ret

00012e0c <gettimeofday>:
   12e0c:	00050593          	mv	a1,a0
   12e10:	00000713          	li	a4,0
   12e14:	00000693          	li	a3,0
   12e18:	00000613          	li	a2,0
   12e1c:	0a900513          	li	a0,169
   12e20:	cc1ff06f          	j	12ae0 <__internal_syscall>

00012e24 <times>:
   12e24:	fe010113          	addi	sp,sp,-32
   12e28:	00812c23          	sw	s0,24(sp)
   12e2c:	00050413          	mv	s0,a0
   12e30:	8241a783          	lw	a5,-2012(gp) # 14944 <t0.2536>
   12e34:	00912a23          	sw	s1,20(sp)
   12e38:	00112e23          	sw	ra,28(sp)
   12e3c:	82418493          	addi	s1,gp,-2012 # 14944 <t0.2536>
   12e40:	00079863          	bnez	a5,12e50 <times+0x2c>
   12e44:	00000593          	li	a1,0
   12e48:	82418513          	addi	a0,gp,-2012 # 14944 <t0.2536>
   12e4c:	fc1ff0ef          	jal	ra,12e0c <gettimeofday>
   12e50:	00000593          	li	a1,0
   12e54:	00810513          	addi	a0,sp,8
   12e58:	fb5ff0ef          	jal	ra,12e0c <gettimeofday>
   12e5c:	0004a783          	lw	a5,0(s1)
   12e60:	00812503          	lw	a0,8(sp)
   12e64:	000f45b7          	lui	a1,0xf4
   12e68:	24058593          	addi	a1,a1,576 # f4240 <__global_pointer$+0xdf120>
   12e6c:	40f50533          	sub	a0,a0,a5
   12e70:	148000ef          	jal	ra,12fb8 <__mulsi3>
   12e74:	0044a703          	lw	a4,4(s1)
   12e78:	00c12783          	lw	a5,12(sp)
   12e7c:	00042423          	sw	zero,8(s0)
   12e80:	00042623          	sw	zero,12(s0)
   12e84:	40e787b3          	sub	a5,a5,a4
   12e88:	00f50533          	add	a0,a0,a5
   12e8c:	00a42023          	sw	a0,0(s0)
   12e90:	00042223          	sw	zero,4(s0)
   12e94:	01c12083          	lw	ra,28(sp)
   12e98:	01812403          	lw	s0,24(sp)
   12e9c:	01412483          	lw	s1,20(sp)
   12ea0:	fff00513          	li	a0,-1
   12ea4:	02010113          	addi	sp,sp,32
   12ea8:	00008067          	ret

00012eac <ftime>:
   12eac:	00051223          	sh	zero,4(a0)
   12eb0:	00052023          	sw	zero,0(a0)
   12eb4:	00000513          	li	a0,0
   12eb8:	00008067          	ret

00012ebc <utime>:
   12ebc:	fff00513          	li	a0,-1
   12ec0:	00008067          	ret

00012ec4 <chown>:
   12ec4:	fff00513          	li	a0,-1
   12ec8:	00008067          	ret

00012ecc <chmod>:
   12ecc:	fff00513          	li	a0,-1
   12ed0:	00008067          	ret

00012ed4 <chdir>:
   12ed4:	fff00513          	li	a0,-1
   12ed8:	00008067          	ret

00012edc <getcwd>:
   12edc:	00000513          	li	a0,0
   12ee0:	00008067          	ret

00012ee4 <sysconf>:
   12ee4:	00200793          	li	a5,2
   12ee8:	00f50663          	beq	a0,a5,12ef4 <sysconf+0x10>
   12eec:	fff00513          	li	a0,-1
   12ef0:	00008067          	ret
   12ef4:	000f4537          	lui	a0,0xf4
   12ef8:	24050513          	addi	a0,a0,576 # f4240 <__global_pointer$+0xdf120>
   12efc:	00008067          	ret

00012f00 <sbrk>:
   12f00:	ff010113          	addi	sp,sp,-16
   12f04:	00812423          	sw	s0,8(sp)
   12f08:	8201a783          	lw	a5,-2016(gp) # 14940 <heap_end.2573>
   12f0c:	00912223          	sw	s1,4(sp)
   12f10:	00112623          	sw	ra,12(sp)
   12f14:	00050493          	mv	s1,a0
   12f18:	04079063          	bnez	a5,12f58 <sbrk+0x58>
   12f1c:	00000713          	li	a4,0
   12f20:	00000693          	li	a3,0
   12f24:	00000613          	li	a2,0
   12f28:	00000593          	li	a1,0
   12f2c:	0d600513          	li	a0,214
   12f30:	bb1ff0ef          	jal	ra,12ae0 <__internal_syscall>
   12f34:	fff00793          	li	a5,-1
   12f38:	00f51e63          	bne	a0,a5,12f54 <sbrk+0x54>
   12f3c:	fff00513          	li	a0,-1
   12f40:	00c12083          	lw	ra,12(sp)
   12f44:	00812403          	lw	s0,8(sp)
   12f48:	00412483          	lw	s1,4(sp)
   12f4c:	01010113          	addi	sp,sp,16
   12f50:	00008067          	ret
   12f54:	82a1a023          	sw	a0,-2016(gp) # 14940 <heap_end.2573>
   12f58:	8201a583          	lw	a1,-2016(gp) # 14940 <heap_end.2573>
   12f5c:	00000713          	li	a4,0
   12f60:	00000693          	li	a3,0
   12f64:	00b485b3          	add	a1,s1,a1
   12f68:	00000613          	li	a2,0
   12f6c:	0d600513          	li	a0,214
   12f70:	b71ff0ef          	jal	ra,12ae0 <__internal_syscall>
   12f74:	8201a783          	lw	a5,-2016(gp) # 14940 <heap_end.2573>
   12f78:	00f484b3          	add	s1,s1,a5
   12f7c:	fc9510e3          	bne	a0,s1,12f3c <sbrk+0x3c>
   12f80:	82a1a023          	sw	a0,-2016(gp) # 14940 <heap_end.2573>
   12f84:	00078513          	mv	a0,a5
   12f88:	fb9ff06f          	j	12f40 <sbrk+0x40>

00012f8c <_exit>:
   12f8c:	ff010113          	addi	sp,sp,-16
   12f90:	00050593          	mv	a1,a0
   12f94:	00000713          	li	a4,0
   12f98:	00000693          	li	a3,0
   12f9c:	00000613          	li	a2,0
   12fa0:	05d00513          	li	a0,93
   12fa4:	00112623          	sw	ra,12(sp)
   12fa8:	b39ff0ef          	jal	ra,12ae0 <__internal_syscall>
   12fac:	0000006f          	j	12fac <_exit+0x20>

00012fb0 <__errno>:
   12fb0:	8081a503          	lw	a0,-2040(gp) # 14928 <_impure_ptr>
   12fb4:	00008067          	ret

00012fb8 <__mulsi3>:
   12fb8:	00050613          	mv	a2,a0
   12fbc:	00000513          	li	a0,0
   12fc0:	0015f693          	andi	a3,a1,1
   12fc4:	00068463          	beqz	a3,12fcc <__mulsi3+0x14>
   12fc8:	00c50533          	add	a0,a0,a2
   12fcc:	0015d593          	srli	a1,a1,0x1
   12fd0:	00161613          	slli	a2,a2,0x1
   12fd4:	fe0596e3          	bnez	a1,12fc0 <__mulsi3+0x8>
   12fd8:	00008067          	ret

00012fdc <__divsi3>:
   12fdc:	06054063          	bltz	a0,1303c <__umodsi3+0x10>
   12fe0:	0605c663          	bltz	a1,1304c <__umodsi3+0x20>

00012fe4 <__udivsi3>:
   12fe4:	00058613          	mv	a2,a1
   12fe8:	00050593          	mv	a1,a0
   12fec:	fff00513          	li	a0,-1
   12ff0:	02060c63          	beqz	a2,13028 <__udivsi3+0x44>
   12ff4:	00100693          	li	a3,1
   12ff8:	00b67a63          	bleu	a1,a2,1300c <__udivsi3+0x28>
   12ffc:	00c05863          	blez	a2,1300c <__udivsi3+0x28>
   13000:	00161613          	slli	a2,a2,0x1
   13004:	00169693          	slli	a3,a3,0x1
   13008:	feb66ae3          	bltu	a2,a1,12ffc <__udivsi3+0x18>
   1300c:	00000513          	li	a0,0
   13010:	00c5e663          	bltu	a1,a2,1301c <__udivsi3+0x38>
   13014:	40c585b3          	sub	a1,a1,a2
   13018:	00d56533          	or	a0,a0,a3
   1301c:	0016d693          	srli	a3,a3,0x1
   13020:	00165613          	srli	a2,a2,0x1
   13024:	fe0696e3          	bnez	a3,13010 <__udivsi3+0x2c>
   13028:	00008067          	ret

0001302c <__umodsi3>:
   1302c:	00008293          	mv	t0,ra
   13030:	fb5ff0ef          	jal	ra,12fe4 <__udivsi3>
   13034:	00058513          	mv	a0,a1
   13038:	00028067          	jr	t0
   1303c:	40a00533          	neg	a0,a0
   13040:	0005d863          	bgez	a1,13050 <__umodsi3+0x24>
   13044:	40b005b3          	neg	a1,a1
   13048:	f9dff06f          	j	12fe4 <__udivsi3>
   1304c:	40b005b3          	neg	a1,a1
   13050:	00008293          	mv	t0,ra
   13054:	f91ff0ef          	jal	ra,12fe4 <__udivsi3>
   13058:	40a00533          	neg	a0,a0
   1305c:	00028067          	jr	t0

00013060 <__modsi3>:
   13060:	00008293          	mv	t0,ra
   13064:	0005ca63          	bltz	a1,13078 <__modsi3+0x18>
   13068:	00054c63          	bltz	a0,13080 <__modsi3+0x20>
   1306c:	f79ff0ef          	jal	ra,12fe4 <__udivsi3>
   13070:	00058513          	mv	a0,a1
   13074:	00028067          	jr	t0
   13078:	40b005b3          	neg	a1,a1
   1307c:	fe0558e3          	bgez	a0,1306c <__modsi3+0xc>
   13080:	40a00533          	neg	a0,a0
   13084:	f61ff0ef          	jal	ra,12fe4 <__udivsi3>
   13088:	40b00533          	neg	a0,a1
   1308c:	00028067          	jr	t0

Disassembly of section .rodata:

00013090 <.rodata>:
   13090:	6548                	flw	fa0,12(a0)
   13092:	6c6c                	flw	fa1,92(s0)
   13094:	6f77206f          	j	85f8a <__global_pointer$+0x70e6a>
   13098:	6c72                	flw	fs8,28(sp)
   1309a:	2164                	fld	fs1,192(a0)
   1309c:	0000                	unimp
   1309e:	0000                	unimp
   130a0:	000a                	0xa
	...

Disassembly of section .eh_frame:

000130a4 <__EH_FRAME_BEGIN__>:
   130a4:	0010                	addi	a2,sp,0
   130a6:	0000                	unimp
   130a8:	0000                	unimp
   130aa:	0000                	unimp
   130ac:	00527a03          	0x527a03
   130b0:	7c01                	lui	s8,0xfffe0
   130b2:	0101                	addi	sp,sp,0
   130b4:	00020c1b          	0x20c1b
   130b8:	0028                	addi	a0,sp,8
   130ba:	0000                	unimp
   130bc:	0018                	addi	a4,sp,0
   130be:	0000                	unimp
   130c0:	cfb4                	sw	a3,88(a5)
   130c2:	ffff                	0xffff
   130c4:	0024                	addi	s1,sp,8
   130c6:	0000                	unimp
   130c8:	0400                	addi	s0,sp,512
   130ca:	0008                	addi	a0,sp,0
   130cc:	0000                	unimp
   130ce:	100e                	0x100e
   130d0:	0804                	addi	s1,sp,16
   130d2:	0000                	unimp
   130d4:	8100                	0x8100
   130d6:	0401                	addi	s0,s0,0
   130d8:	0008                	addi	a0,sp,0
   130da:	0000                	unimp
   130dc:	04c1                	addi	s1,s1,16
   130de:	0008                	addi	a0,sp,0
   130e0:	0000                	unimp
   130e2:	000e                	0xe

000130e4 <__FRAME_END__>:
   130e4:	0000                	unimp
	...

Disassembly of section .init_array:

000140e8 <__frame_dummy_init_array_entry>:
   140e8:	01a4                	addi	s1,sp,200
   140ea:	0001                	nop

Disassembly of section .fini_array:

000140ec <__do_global_dtors_aux_fini_array_entry>:
   140ec:	0150                	addi	a2,sp,132
   140ee:	0001                	nop

Disassembly of section .data:

000140f0 <impure_data>:
   140f0:	0000                	unimp
   140f2:	0000                	unimp
   140f4:	43dc                	lw	a5,4(a5)
   140f6:	0001                	nop
   140f8:	4444                	lw	s1,12(s0)
   140fa:	0001                	nop
   140fc:	44ac                	lw	a1,72(s1)
   140fe:	0001                	nop
	...
   14198:	0001                	nop
   1419a:	0000                	unimp
   1419c:	0000                	unimp
   1419e:	0000                	unimp
   141a0:	330e                	fld	ft6,224(sp)
   141a2:	abcd                	j	14794 <__malloc_av_+0x27c>
   141a4:	1234                	addi	a3,sp,296
   141a6:	e66d                	bnez	a2,14290 <impure_data+0x1a0>
   141a8:	deec                	sw	a1,124(a3)
   141aa:	0005                	c.addi	zero,1
   141ac:	0000000b          	0xb
	...

00014518 <__malloc_av_>:
	...
   14520:	4518                	lw	a4,8(a0)
   14522:	0001                	nop
   14524:	4518                	lw	a4,8(a0)
   14526:	0001                	nop
   14528:	4520                	lw	s0,72(a0)
   1452a:	0001                	nop
   1452c:	4520                	lw	s0,72(a0)
   1452e:	0001                	nop
   14530:	4528                	lw	a0,72(a0)
   14532:	0001                	nop
   14534:	4528                	lw	a0,72(a0)
   14536:	0001                	nop
   14538:	4530                	lw	a2,72(a0)
   1453a:	0001                	nop
   1453c:	4530                	lw	a2,72(a0)
   1453e:	0001                	nop
   14540:	4538                	lw	a4,72(a0)
   14542:	0001                	nop
   14544:	4538                	lw	a4,72(a0)
   14546:	0001                	nop
   14548:	4540                	lw	s0,12(a0)
   1454a:	0001                	nop
   1454c:	4540                	lw	s0,12(a0)
   1454e:	0001                	nop
   14550:	4548                	lw	a0,12(a0)
   14552:	0001                	nop
   14554:	4548                	lw	a0,12(a0)
   14556:	0001                	nop
   14558:	4550                	lw	a2,12(a0)
   1455a:	0001                	nop
   1455c:	4550                	lw	a2,12(a0)
   1455e:	0001                	nop
   14560:	4558                	lw	a4,12(a0)
   14562:	0001                	nop
   14564:	4558                	lw	a4,12(a0)
   14566:	0001                	nop
   14568:	4560                	lw	s0,76(a0)
   1456a:	0001                	nop
   1456c:	4560                	lw	s0,76(a0)
   1456e:	0001                	nop
   14570:	4568                	lw	a0,76(a0)
   14572:	0001                	nop
   14574:	4568                	lw	a0,76(a0)
   14576:	0001                	nop
   14578:	4570                	lw	a2,76(a0)
   1457a:	0001                	nop
   1457c:	4570                	lw	a2,76(a0)
   1457e:	0001                	nop
   14580:	4578                	lw	a4,76(a0)
   14582:	0001                	nop
   14584:	4578                	lw	a4,76(a0)
   14586:	0001                	nop
   14588:	4580                	lw	s0,8(a1)
   1458a:	0001                	nop
   1458c:	4580                	lw	s0,8(a1)
   1458e:	0001                	nop
   14590:	4588                	lw	a0,8(a1)
   14592:	0001                	nop
   14594:	4588                	lw	a0,8(a1)
   14596:	0001                	nop
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

Disassembly of section .sdata:

00014920 <__TMC_END__>:
   14920:	0000                	unimp
	...

00014924 <_global_impure_ptr>:
   14924:	40f0                	lw	a2,68(s1)
   14926:	0001                	nop

00014928 <_impure_ptr>:
   14928:	40f0                	lw	a2,68(s1)
   1492a:	0001                	nop

0001492c <__malloc_sbrk_base>:
   1492c:	ffff                	0xffff
   1492e:	ffff                	0xffff

00014930 <__malloc_trim_threshold>:
   14930:	0000                	unimp
   14932:	0002                	0x2

Disassembly of section .sbss:

00014934 <__malloc_max_total_mem>:
   14934:	0000                	unimp
	...

00014938 <__malloc_max_sbrked_mem>:
   14938:	0000                	unimp
	...

0001493c <__malloc_top_pad>:
   1493c:	0000                	unimp
	...

00014940 <heap_end.2573>:
   14940:	0000                	unimp
	...

00014944 <t0.2536>:
	...

Disassembly of section .bss:

0001494c <completed.5148>:
   1494c:	0000                	unimp
	...

00014950 <object.5153>:
	...

00014968 <__malloc_current_mallinfo>:
	...

00014990 <errno>:
   14990:	0000                	unimp
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
  10:	2fb8                	fld	fa4,88(a5)
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
  30:	2fdc                	fld	fa5,152(a5)
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
  10:	2fb8                	fld	fa4,88(a5)
  12:	0001                	nop
  14:	2fdc                	fld	fa5,152(a5)
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
  32:	2f736c6f          	jal	s8,36b28 <__global_pointer$+0x21a08>
  36:	6972                	flw	fs2,28(sp)
  38:	2d766373          	csrrsi	t1,0x2d7,12
  3c:	2d756e67          	0x2d756e67
  40:	6f74                	flw	fa3,92(a4)
  42:	68636c6f          	jal	s8,366c8 <__global_pointer$+0x215a8>
  46:	6961                	lui	s2,0x18
  48:	2f6e                	fld	ft10,216(sp)
  4a:	6972                	flw	fs2,28(sp)
  4c:	2d766373          	csrrsi	t1,0x2d7,12
  50:	2f636367          	0x2f636367
  54:	696c                	flw	fa1,84(a0)
  56:	6762                	flw	fa4,24(sp)
  58:	632f6363          	bltu	t5,s2,67e <main-0xf9f6>
  5c:	69666e6f          	jal	t3,666f2 <__global_pointer$+0x515d2>
  60:	69722f67          	0x69722f67
  64:	2f766373          	csrrsi	t1,0x2f7,12
  68:	756d                	lui	a0,0xffffb
  6a:	646c                	flw	fa1,76(s0)
  6c:	3369                	jal	fffffdf6 <__global_pointer$+0xfffeacd6>
  6e:	532e                	lw	t1,232(sp)
  70:	2f00                	fld	fs0,24(a4)
  72:	6f68                	flw	fa0,92(a4)
  74:	656d                	lui	a0,0x1b
  76:	2f646a2f          	0x2f646a2f
  7a:	7250                	flw	fa2,36(a2)
  7c:	63656a6f          	jal	s4,566b2 <__global_pointer$+0x41592>
  80:	7374                	flw	fa3,100(a4)
  82:	7369722f          	0x7369722f
  86:	742d7663          	bleu	sp,s10,7d2 <main-0xf8a2>
  8a:	736c6f6f          	jal	t5,c67c0 <__global_pointer$+0xb16a0>
  8e:	7369722f          	0x7369722f
  92:	672d7663          	bleu	s2,s10,6fe <main-0xf976>
  96:	756e                	flw	fa0,248(sp)
  98:	742d                	lui	s0,0xfffeb
  9a:	636c6f6f          	jal	t5,c66d0 <__global_pointer$+0xb15b0>
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
  b8:	3265                	jal	fffffa60 <__global_pointer$+0xfffea940>
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
  f6:	2fdc                	fld	fa5,152(a5)
  f8:	0001                	nop
  fa:	3090                	fld	fa2,32(s1)
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
 118:	2f736c6f          	jal	s8,36c0e <__global_pointer$+0x21aee>
 11c:	6972                	flw	fs2,28(sp)
 11e:	2d766373          	csrrsi	t1,0x2d7,12
 122:	2d756e67          	0x2d756e67
 126:	6f74                	flw	fa3,92(a4)
 128:	68636c6f          	jal	s8,367ae <__global_pointer$+0x2168e>
 12c:	6961                	lui	s2,0x18
 12e:	2f6e                	fld	ft10,216(sp)
 130:	6972                	flw	fs2,28(sp)
 132:	2d766373          	csrrsi	t1,0x2d7,12
 136:	2f636367          	0x2f636367
 13a:	696c                	flw	fa1,84(a0)
 13c:	6762                	flw	fa4,24(sp)
 13e:	632f6363          	bltu	t5,s2,764 <main-0xf910>
 142:	69666e6f          	jal	t3,667d8 <__global_pointer$+0x516b8>
 146:	69722f67          	0x69722f67
 14a:	2f766373          	csrrsi	t1,0x2f7,12
 14e:	6964                	flw	fs1,84(a0)
 150:	2e76                	fld	ft8,344(sp)
 152:	682f0053          	0x682f0053
 156:	2f656d6f          	jal	s10,5644c <__global_pointer$+0x4132c>
 15a:	646a                	flw	fs0,152(sp)
 15c:	6f72502f          	0x6f72502f
 160:	656a                	flw	fa0,152(sp)
 162:	2f737463          	bleu	s7,t1,44a <main-0xfc2a>
 166:	6972                	flw	fs2,28(sp)
 168:	2d766373          	csrrsi	t1,0x2d7,12
 16c:	6f74                	flw	fa3,92(a4)
 16e:	2f736c6f          	jal	s8,36c64 <__global_pointer$+0x21b44>
 172:	6972                	flw	fs2,28(sp)
 174:	2d766373          	csrrsi	t1,0x2d7,12
 178:	2d756e67          	0x2d756e67
 17c:	6f74                	flw	fa3,92(a4)
 17e:	68636c6f          	jal	s8,36804 <__global_pointer$+0x216e4>
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
  26:	63656a6f          	jal	s4,5665c <__global_pointer$+0x4153c>
  2a:	7374                	flw	fa3,100(a4)
  2c:	7369722f          	0x7369722f
  30:	742d7663          	bleu	sp,s10,77c <main-0xf8f8>
  34:	736c6f6f          	jal	t5,c676a <__global_pointer$+0xb164a>
  38:	7369722f          	0x7369722f
  3c:	672d7663          	bleu	s2,s10,6a8 <main-0xf9cc>
  40:	756e                	flw	fa0,248(sp)
  42:	742d                	lui	s0,0xfffeb
  44:	636c6f6f          	jal	t5,c667a <__global_pointer$+0xb155a>
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
  70:	3369                	jal	fffffdfa <__global_pointer$+0xfffeacda>
  72:	532e                	lw	t1,232(sp)
  74:	0100                	addi	s0,sp,128
  76:	0000                	unimp
  78:	0000                	unimp
  7a:	0205                	addi	tp,tp,1
  7c:	2fb8                	fld	fa4,88(a5)
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
  c4:	fb01                	bnez	a4,ffffffd4 <__global_pointer$+0xfffeaeb4>
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
  ee:	2f736c6f          	jal	s8,36be4 <__global_pointer$+0x21ac4>
  f2:	6972                	flw	fs2,28(sp)
  f4:	2d766373          	csrrsi	t1,0x2d7,12
  f8:	2d756e67          	0x2d756e67
  fc:	6f74                	flw	fa3,92(a4)
  fe:	68636c6f          	jal	s8,36784 <__global_pointer$+0x21664>
 102:	6961                	lui	s2,0x18
 104:	2f6e                	fld	ft10,216(sp)
 106:	6972                	flw	fs2,28(sp)
 108:	2d766373          	csrrsi	t1,0x2d7,12
 10c:	2f636367          	0x2f636367
 110:	696c                	flw	fa1,84(a0)
 112:	6762                	flw	fa4,24(sp)
 114:	632f6363          	bltu	t5,s2,73a <main-0xf93a>
 118:	69666e6f          	jal	t3,667ae <__global_pointer$+0x5168e>
 11c:	69722f67          	0x69722f67
 120:	00766373          	csrrsi	t1,0x7,12
 124:	6400                	flw	fs0,8(s0)
 126:	7669                	lui	a2,0xffffa
 128:	532e                	lw	t1,232(sp)
 12a:	0100                	addi	s0,sp,128
 12c:	0000                	unimp
 12e:	0000                	unimp
 130:	0205                	addi	tp,tp,1
 132:	2fdc                	fld	fa5,152(a5)
 134:	0001                	nop
 136:	0100c503          	lbu	a0,16(ra)
 13a:	04090103          	lb	sp,64(s2) # 18040 <__global_pointer$+0x2f20>
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
