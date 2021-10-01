
rtarget:     file format elf64-x86-64


Disassembly of section .text:

0000000000421300 <_start>:
  421300:	31 ed                	xor    %ebp,%ebp
  421302:	49 89 d1             	mov    %rdx,%r9
  421305:	5e                   	pop    %rsi
  421306:	48 89 e2             	mov    %rsp,%rdx
  421309:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  42130d:	50                   	push   %rax
  42130e:	54                   	push   %rsp
  42130f:	49 c7 c0 40 31 42 00 	mov    $0x423140,%r8
  421316:	48 c7 c1 d0 30 42 00 	mov    $0x4230d0,%rcx
  42131d:	48 c7 c7 c0 15 42 00 	mov    $0x4215c0,%rdi
  421324:	e8 a7 f9 fd ff       	callq  400cd0 <__libc_start_main@plt>
  421329:	f4                   	hlt    
  42132a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000421330 <deregister_tm_clones>:
  421330:	b8 b7 54 62 00       	mov    $0x6254b7,%eax
  421335:	55                   	push   %rbp
  421336:	48 2d b0 54 62 00    	sub    $0x6254b0,%rax
  42133c:	48 83 f8 0e          	cmp    $0xe,%rax
  421340:	48 89 e5             	mov    %rsp,%rbp
  421343:	77 02                	ja     421347 <deregister_tm_clones+0x17>
  421345:	5d                   	pop    %rbp
  421346:	c3                   	retq   
  421347:	b8 00 00 00 00       	mov    $0x0,%eax
  42134c:	48 85 c0             	test   %rax,%rax
  42134f:	74 f4                	je     421345 <deregister_tm_clones+0x15>
  421351:	5d                   	pop    %rbp
  421352:	bf b0 54 62 00       	mov    $0x6254b0,%edi
  421357:	ff e0                	jmpq   *%rax
  421359:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000421360 <register_tm_clones>:
  421360:	b8 b0 54 62 00       	mov    $0x6254b0,%eax
  421365:	55                   	push   %rbp
  421366:	48 2d b0 54 62 00    	sub    $0x6254b0,%rax
  42136c:	48 c1 f8 03          	sar    $0x3,%rax
  421370:	48 89 e5             	mov    %rsp,%rbp
  421373:	48 89 c2             	mov    %rax,%rdx
  421376:	48 c1 ea 3f          	shr    $0x3f,%rdx
  42137a:	48 01 d0             	add    %rdx,%rax
  42137d:	48 d1 f8             	sar    %rax
  421380:	75 02                	jne    421384 <register_tm_clones+0x24>
  421382:	5d                   	pop    %rbp
  421383:	c3                   	retq   
  421384:	ba 00 00 00 00       	mov    $0x0,%edx
  421389:	48 85 d2             	test   %rdx,%rdx
  42138c:	74 f4                	je     421382 <register_tm_clones+0x22>
  42138e:	5d                   	pop    %rbp
  42138f:	48 89 c6             	mov    %rax,%rsi
  421392:	bf b0 54 62 00       	mov    $0x6254b0,%edi
  421397:	ff e2                	jmpq   *%rdx
  421399:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000004213a0 <__do_global_dtors_aux>:
  4213a0:	80 3d 31 41 20 00 00 	cmpb   $0x0,0x204131(%rip)        # 6254d8 <completed.6355>
  4213a7:	75 11                	jne    4213ba <__do_global_dtors_aux+0x1a>
  4213a9:	55                   	push   %rbp
  4213aa:	48 89 e5             	mov    %rsp,%rbp
  4213ad:	e8 7e ff ff ff       	callq  421330 <deregister_tm_clones>
  4213b2:	5d                   	pop    %rbp
  4213b3:	c6 05 1e 41 20 00 01 	movb   $0x1,0x20411e(%rip)        # 6254d8 <completed.6355>
  4213ba:	f3 c3                	repz retq 
  4213bc:	0f 1f 40 00          	nopl   0x0(%rax)

00000000004213c0 <frame_dummy>:
  4213c0:	48 83 3d 58 3a 20 00 	cmpq   $0x0,0x203a58(%rip)        # 624e20 <__JCR_END__>
  4213c7:	00 
  4213c8:	74 1e                	je     4213e8 <frame_dummy+0x28>
  4213ca:	b8 00 00 00 00       	mov    $0x0,%eax
  4213cf:	48 85 c0             	test   %rax,%rax
  4213d2:	74 14                	je     4213e8 <frame_dummy+0x28>
  4213d4:	55                   	push   %rbp
  4213d5:	bf 20 4e 62 00       	mov    $0x624e20,%edi
  4213da:	48 89 e5             	mov    %rsp,%rbp
  4213dd:	ff d0                	callq  *%rax
  4213df:	5d                   	pop    %rbp
  4213e0:	e9 7b ff ff ff       	jmpq   421360 <register_tm_clones>
  4213e5:	0f 1f 00             	nopl   (%rax)
  4213e8:	e9 73 ff ff ff       	jmpq   421360 <register_tm_clones>
  4213ed:	0f 1f 00             	nopl   (%rax)

00000000004213f0 <usage>:
  4213f0:	48 83 ec 08          	sub    $0x8,%rsp
  4213f4:	48 89 fe             	mov    %rdi,%rsi
  4213f7:	83 3d 0a 41 20 00 00 	cmpl   $0x0,0x20410a(%rip)        # 625508 <is_checker>
  4213fe:	74 39                	je     421439 <usage+0x49>
  421400:	bf 60 31 42 00       	mov    $0x423160,%edi
  421405:	b8 00 00 00 00       	mov    $0x0,%eax
  42140a:	e8 71 f8 fd ff       	callq  400c80 <printf@plt>
  42140f:	bf 98 31 42 00       	mov    $0x423198,%edi
  421414:	e8 37 f8 fd ff       	callq  400c50 <puts@plt>
  421419:	bf 10 33 42 00       	mov    $0x423310,%edi
  42141e:	e8 2d f8 fd ff       	callq  400c50 <puts@plt>
  421423:	bf c0 31 42 00       	mov    $0x4231c0,%edi
  421428:	e8 23 f8 fd ff       	callq  400c50 <puts@plt>
  42142d:	bf 2a 33 42 00       	mov    $0x42332a,%edi
  421432:	e8 19 f8 fd ff       	callq  400c50 <puts@plt>
  421437:	eb 2d                	jmp    421466 <usage+0x76>
  421439:	bf 46 33 42 00       	mov    $0x423346,%edi
  42143e:	b8 00 00 00 00       	mov    $0x0,%eax
  421443:	e8 38 f8 fd ff       	callq  400c80 <printf@plt>
  421448:	bf e8 31 42 00       	mov    $0x4231e8,%edi
  42144d:	e8 fe f7 fd ff       	callq  400c50 <puts@plt>
  421452:	bf 10 32 42 00       	mov    $0x423210,%edi
  421457:	e8 f4 f7 fd ff       	callq  400c50 <puts@plt>
  42145c:	bf 64 33 42 00       	mov    $0x423364,%edi
  421461:	e8 ea f7 fd ff       	callq  400c50 <puts@plt>
  421466:	bf 00 00 00 00       	mov    $0x0,%edi
  42146b:	e8 80 f9 fd ff       	callq  400df0 <exit@plt>

0000000000421470 <initialize_target>:
  421470:	55                   	push   %rbp
  421471:	53                   	push   %rbx
  421472:	48 81 ec 08 21 00 00 	sub    $0x2108,%rsp
  421479:	89 f5                	mov    %esi,%ebp
  42147b:	89 3d 77 40 20 00    	mov    %edi,0x204077(%rip)        # 6254f8 <check_level>
  421481:	8b 3d e1 3c 20 00    	mov    0x203ce1(%rip),%edi        # 625168 <target_id>
  421487:	e8 20 1c 00 00       	callq  4230ac <gencookie>
  42148c:	89 05 72 40 20 00    	mov    %eax,0x204072(%rip)        # 625504 <cookie>
  421492:	89 c7                	mov    %eax,%edi
  421494:	e8 13 1c 00 00       	callq  4230ac <gencookie>
  421499:	89 05 61 40 20 00    	mov    %eax,0x204061(%rip)        # 625500 <authkey>
  42149f:	8b 05 c3 3c 20 00    	mov    0x203cc3(%rip),%eax        # 625168 <target_id>
  4214a5:	8d 78 01             	lea    0x1(%rax),%edi
  4214a8:	e8 73 f7 fd ff       	callq  400c20 <srandom@plt>
  4214ad:	e8 9e f8 fd ff       	callq  400d50 <random@plt>
  4214b2:	89 c7                	mov    %eax,%edi
  4214b4:	e8 ca 02 00 00       	callq  421783 <scramble>
  4214b9:	89 c3                	mov    %eax,%ebx
  4214bb:	bf 00 00 00 00       	mov    $0x0,%edi
  4214c0:	e8 7b f8 fd ff       	callq  400d40 <time@plt>
  4214c5:	89 c7                	mov    %eax,%edi
  4214c7:	e8 54 f7 fd ff       	callq  400c20 <srandom@plt>
  4214cc:	85 ed                	test   %ebp,%ebp
  4214ce:	74 07                	je     4214d7 <initialize_target+0x67>
  4214d0:	e8 7b f8 fd ff       	callq  400d50 <random@plt>
  4214d5:	eb 05                	jmp    4214dc <initialize_target+0x6c>
  4214d7:	b8 00 00 00 00       	mov    $0x0,%eax
  4214dc:	01 c3                	add    %eax,%ebx
  4214de:	0f b7 db             	movzwl %bx,%ebx
  4214e1:	8d 04 dd 00 01 00 00 	lea    0x100(,%rbx,8),%eax
  4214e8:	89 c0                	mov    %eax,%eax
  4214ea:	48 89 05 af 3f 20 00 	mov    %rax,0x203faf(%rip)        # 6254a0 <buf_offset>
  4214f1:	c6 05 30 4c 20 00 72 	movb   $0x72,0x204c30(%rip)        # 626128 <target_prefix>
  4214f8:	83 3d a9 3f 20 00 00 	cmpl   $0x0,0x203fa9(%rip)        # 6254a8 <notify>
  4214ff:	0f 84 b1 00 00 00    	je     4215b6 <initialize_target+0x146>
  421505:	83 3d fc 3f 20 00 00 	cmpl   $0x0,0x203ffc(%rip)        # 625508 <is_checker>
  42150c:	0f 85 a4 00 00 00    	jne    4215b6 <initialize_target+0x146>
  421512:	be 00 01 00 00       	mov    $0x100,%esi
  421517:	48 89 e7             	mov    %rsp,%rdi
  42151a:	e8 b1 f8 fd ff       	callq  400dd0 <gethostname@plt>
  42151f:	85 c0                	test   %eax,%eax
  421521:	74 25                	je     421548 <initialize_target+0xd8>
  421523:	bf 40 32 42 00       	mov    $0x423240,%edi
  421528:	e8 23 f7 fd ff       	callq  400c50 <puts@plt>
  42152d:	bf 08 00 00 00       	mov    $0x8,%edi
  421532:	e8 b9 f8 fd ff       	callq  400df0 <exit@plt>
  421537:	48 89 e6             	mov    %rsp,%rsi
  42153a:	e8 c1 f6 fd ff       	callq  400c00 <strcasecmp@plt>
  42153f:	85 c0                	test   %eax,%eax
  421541:	74 21                	je     421564 <initialize_target+0xf4>
  421543:	83 c3 01             	add    $0x1,%ebx
  421546:	eb 05                	jmp    42154d <initialize_target+0xdd>
  421548:	bb 00 00 00 00       	mov    $0x0,%ebx
  42154d:	48 63 c3             	movslq %ebx,%rax
  421550:	48 8b 3c c5 80 51 62 	mov    0x625180(,%rax,8),%rdi
  421557:	00 
  421558:	48 85 ff             	test   %rdi,%rdi
  42155b:	75 da                	jne    421537 <initialize_target+0xc7>
  42155d:	b8 00 00 00 00       	mov    $0x0,%eax
  421562:	eb 05                	jmp    421569 <initialize_target+0xf9>
  421564:	b8 01 00 00 00       	mov    $0x1,%eax
  421569:	85 c0                	test   %eax,%eax
  42156b:	75 17                	jne    421584 <initialize_target+0x114>
  42156d:	48 89 e6             	mov    %rsp,%rsi
  421570:	bf 78 32 42 00       	mov    $0x423278,%edi
  421575:	e8 06 f7 fd ff       	callq  400c80 <printf@plt>
  42157a:	bf 08 00 00 00       	mov    $0x8,%edi
  42157f:	e8 6c f8 fd ff       	callq  400df0 <exit@plt>
  421584:	48 8d bc 24 00 01 00 	lea    0x100(%rsp),%rdi
  42158b:	00 
  42158c:	e8 b4 18 00 00       	callq  422e45 <init_driver>
  421591:	85 c0                	test   %eax,%eax
  421593:	79 21                	jns    4215b6 <initialize_target+0x146>
  421595:	48 8d b4 24 00 01 00 	lea    0x100(%rsp),%rsi
  42159c:	00 
  42159d:	bf b8 32 42 00       	mov    $0x4232b8,%edi
  4215a2:	b8 00 00 00 00       	mov    $0x0,%eax
  4215a7:	e8 d4 f6 fd ff       	callq  400c80 <printf@plt>
  4215ac:	bf 08 00 00 00       	mov    $0x8,%edi
  4215b1:	e8 3a f8 fd ff       	callq  400df0 <exit@plt>
  4215b6:	48 81 c4 08 21 00 00 	add    $0x2108,%rsp
  4215bd:	5b                   	pop    %rbx
  4215be:	5d                   	pop    %rbp
  4215bf:	c3                   	retq   

00000000004215c0 <main>:
  4215c0:	41 56                	push   %r14
  4215c2:	41 55                	push   %r13
  4215c4:	41 54                	push   %r12
  4215c6:	55                   	push   %rbp
  4215c7:	53                   	push   %rbx
  4215c8:	41 89 fc             	mov    %edi,%r12d
  4215cb:	48 89 f3             	mov    %rsi,%rbx
  4215ce:	be 51 22 42 00       	mov    $0x422251,%esi
  4215d3:	bf 0b 00 00 00       	mov    $0xb,%edi
  4215d8:	e8 03 f7 fd ff       	callq  400ce0 <signal@plt>
  4215dd:	be 03 22 42 00       	mov    $0x422203,%esi
  4215e2:	bf 07 00 00 00       	mov    $0x7,%edi
  4215e7:	e8 f4 f6 fd ff       	callq  400ce0 <signal@plt>
  4215ec:	be 9f 22 42 00       	mov    $0x42229f,%esi
  4215f1:	bf 04 00 00 00       	mov    $0x4,%edi
  4215f6:	e8 e5 f6 fd ff       	callq  400ce0 <signal@plt>
  4215fb:	83 3d 06 3f 20 00 00 	cmpl   $0x0,0x203f06(%rip)        # 625508 <is_checker>
  421602:	74 20                	je     421624 <main+0x64>
  421604:	be ed 22 42 00       	mov    $0x4222ed,%esi
  421609:	bf 0e 00 00 00       	mov    $0xe,%edi
  42160e:	e8 cd f6 fd ff       	callq  400ce0 <signal@plt>
  421613:	bf 05 00 00 00       	mov    $0x5,%edi
  421618:	e8 83 f6 fd ff       	callq  400ca0 <alarm@plt>
  42161d:	bd 82 33 42 00       	mov    $0x423382,%ebp
  421622:	eb 05                	jmp    421629 <main+0x69>
  421624:	bd 7d 33 42 00       	mov    $0x42337d,%ebp
  421629:	48 8b 05 90 3e 20 00 	mov    0x203e90(%rip),%rax        # 6254c0 <stdin@@GLIBC_2.2.5>
  421630:	48 89 05 b9 3e 20 00 	mov    %rax,0x203eb9(%rip)        # 6254f0 <infile>
  421637:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  42163d:	41 be 00 00 00 00    	mov    $0x0,%r14d
  421643:	e9 b9 00 00 00       	jmpq   421701 <main+0x141>
  421648:	83 e8 61             	sub    $0x61,%eax
  42164b:	3c 10                	cmp    $0x10,%al
  42164d:	0f 87 93 00 00 00    	ja     4216e6 <main+0x126>
  421653:	0f b6 c0             	movzbl %al,%eax
  421656:	ff 24 c5 c8 33 42 00 	jmpq   *0x4233c8(,%rax,8)
  42165d:	48 8b 3b             	mov    (%rbx),%rdi
  421660:	e8 8b fd ff ff       	callq  4213f0 <usage>
  421665:	be 9d 37 42 00       	mov    $0x42379d,%esi
  42166a:	48 8b 3d 57 3e 20 00 	mov    0x203e57(%rip),%rdi        # 6254c8 <optarg@@GLIBC_2.2.5>
  421671:	e8 2a f7 fd ff       	callq  400da0 <fopen@plt>
  421676:	48 89 05 73 3e 20 00 	mov    %rax,0x203e73(%rip)        # 6254f0 <infile>
  42167d:	48 85 c0             	test   %rax,%rax
  421680:	75 7f                	jne    421701 <main+0x141>
  421682:	48 8b 15 3f 3e 20 00 	mov    0x203e3f(%rip),%rdx        # 6254c8 <optarg@@GLIBC_2.2.5>
  421689:	be 8a 33 42 00       	mov    $0x42338a,%esi
  42168e:	48 8b 3d 3b 3e 20 00 	mov    0x203e3b(%rip),%rdi        # 6254d0 <stderr@@GLIBC_2.2.5>
  421695:	e8 66 f6 fd ff       	callq  400d00 <fprintf@plt>
  42169a:	b8 01 00 00 00       	mov    $0x1,%eax
  42169f:	e9 d6 00 00 00       	jmpq   42177a <main+0x1ba>
  4216a4:	ba 10 00 00 00       	mov    $0x10,%edx
  4216a9:	be 00 00 00 00       	mov    $0x0,%esi
  4216ae:	48 8b 3d 13 3e 20 00 	mov    0x203e13(%rip),%rdi        # 6254c8 <optarg@@GLIBC_2.2.5>
  4216b5:	e8 06 f7 fd ff       	callq  400dc0 <strtoul@plt>
  4216ba:	41 89 c6             	mov    %eax,%r14d
  4216bd:	eb 42                	jmp    421701 <main+0x141>
  4216bf:	ba 0a 00 00 00       	mov    $0xa,%edx
  4216c4:	be 00 00 00 00       	mov    $0x0,%esi
  4216c9:	48 8b 3d f8 3d 20 00 	mov    0x203df8(%rip),%rdi        # 6254c8 <optarg@@GLIBC_2.2.5>
  4216d0:	e8 4b f6 fd ff       	callq  400d20 <strtol@plt>
  4216d5:	41 89 c5             	mov    %eax,%r13d
  4216d8:	eb 27                	jmp    421701 <main+0x141>
  4216da:	c7 05 c4 3d 20 00 00 	movl   $0x0,0x203dc4(%rip)        # 6254a8 <notify>
  4216e1:	00 00 00 
  4216e4:	eb 1b                	jmp    421701 <main+0x141>
  4216e6:	40 0f be f6          	movsbl %sil,%esi
  4216ea:	bf a7 33 42 00       	mov    $0x4233a7,%edi
  4216ef:	b8 00 00 00 00       	mov    $0x0,%eax
  4216f4:	e8 87 f5 fd ff       	callq  400c80 <printf@plt>
  4216f9:	48 8b 3b             	mov    (%rbx),%rdi
  4216fc:	e8 ef fc ff ff       	callq  4213f0 <usage>
  421701:	48 89 ea             	mov    %rbp,%rdx
  421704:	48 89 de             	mov    %rbx,%rsi
  421707:	44 89 e7             	mov    %r12d,%edi
  42170a:	e8 a1 f6 fd ff       	callq  400db0 <getopt@plt>
  42170f:	89 c6                	mov    %eax,%esi
  421711:	3c ff                	cmp    $0xff,%al
  421713:	0f 85 2f ff ff ff    	jne    421648 <main+0x88>
  421719:	be 01 00 00 00       	mov    $0x1,%esi
  42171e:	44 89 ef             	mov    %r13d,%edi
  421721:	e8 4a fd ff ff       	callq  421470 <initialize_target>
  421726:	83 3d db 3d 20 00 00 	cmpl   $0x0,0x203ddb(%rip)        # 625508 <is_checker>
  42172d:	74 25                	je     421754 <main+0x194>
  42172f:	44 3b 35 ca 3d 20 00 	cmp    0x203dca(%rip),%r14d        # 625500 <authkey>
  421736:	74 1c                	je     421754 <main+0x194>
  421738:	44 89 f6             	mov    %r14d,%esi
  42173b:	bf e0 32 42 00       	mov    $0x4232e0,%edi
  421740:	b8 00 00 00 00       	mov    $0x0,%eax
  421745:	e8 36 f5 fd ff       	callq  400c80 <printf@plt>
  42174a:	b8 00 00 00 00       	mov    $0x0,%eax
  42174f:	e8 b7 07 00 00       	callq  421f0b <check_fail>
  421754:	8b 35 aa 3d 20 00    	mov    0x203daa(%rip),%esi        # 625504 <cookie>
  42175a:	bf ba 33 42 00       	mov    $0x4233ba,%edi
  42175f:	b8 00 00 00 00       	mov    $0x0,%eax
  421764:	e8 17 f5 fd ff       	callq  400c80 <printf@plt>
  421769:	48 8b 3d 30 3d 20 00 	mov    0x203d30(%rip),%rdi        # 6254a0 <buf_offset>
  421770:	e8 c6 0b 00 00       	callq  42233b <launch>
  421775:	b8 00 00 00 00       	mov    $0x0,%eax
  42177a:	5b                   	pop    %rbx
  42177b:	5d                   	pop    %rbp
  42177c:	41 5c                	pop    %r12
  42177e:	41 5d                	pop    %r13
  421780:	41 5e                	pop    %r14
  421782:	c3                   	retq   

0000000000421783 <scramble>:
  421783:	b8 00 00 00 00       	mov    $0x0,%eax
  421788:	eb 11                	jmp    42179b <scramble+0x18>
  42178a:	69 c8 32 c5 00 00    	imul   $0xc532,%eax,%ecx
  421790:	01 f9                	add    %edi,%ecx
  421792:	89 c2                	mov    %eax,%edx
  421794:	89 4c 94 d0          	mov    %ecx,-0x30(%rsp,%rdx,4)
  421798:	83 c0 01             	add    $0x1,%eax
  42179b:	83 f8 09             	cmp    $0x9,%eax
  42179e:	76 ea                	jbe    42178a <scramble+0x7>
  4217a0:	8b 44 24 ec          	mov    -0x14(%rsp),%eax
  4217a4:	69 c0 73 48 00 00    	imul   $0x4873,%eax,%eax
  4217aa:	89 44 24 ec          	mov    %eax,-0x14(%rsp)
  4217ae:	8b 44 24 dc          	mov    -0x24(%rsp),%eax
  4217b2:	69 c0 97 8b 00 00    	imul   $0x8b97,%eax,%eax
  4217b8:	89 44 24 dc          	mov    %eax,-0x24(%rsp)
  4217bc:	8b 44 24 f4          	mov    -0xc(%rsp),%eax
  4217c0:	69 c0 72 df 00 00    	imul   $0xdf72,%eax,%eax
  4217c6:	89 44 24 f4          	mov    %eax,-0xc(%rsp)
  4217ca:	8b 44 24 f0          	mov    -0x10(%rsp),%eax
  4217ce:	69 c0 3a 24 00 00    	imul   $0x243a,%eax,%eax
  4217d4:	89 44 24 f0          	mov    %eax,-0x10(%rsp)
  4217d8:	8b 44 24 f4          	mov    -0xc(%rsp),%eax
  4217dc:	69 c0 db 10 00 00    	imul   $0x10db,%eax,%eax
  4217e2:	89 44 24 f4          	mov    %eax,-0xc(%rsp)
  4217e6:	8b 44 24 d0          	mov    -0x30(%rsp),%eax
  4217ea:	69 c0 b8 f8 00 00    	imul   $0xf8b8,%eax,%eax
  4217f0:	89 44 24 d0          	mov    %eax,-0x30(%rsp)
  4217f4:	8b 44 24 e8          	mov    -0x18(%rsp),%eax
  4217f8:	69 c0 35 31 00 00    	imul   $0x3135,%eax,%eax
  4217fe:	89 44 24 e8          	mov    %eax,-0x18(%rsp)
  421802:	8b 44 24 e4          	mov    -0x1c(%rsp),%eax
  421806:	69 c0 75 a0 00 00    	imul   $0xa075,%eax,%eax
  42180c:	89 44 24 e4          	mov    %eax,-0x1c(%rsp)
  421810:	8b 44 24 f0          	mov    -0x10(%rsp),%eax
  421814:	69 c0 37 d9 00 00    	imul   $0xd937,%eax,%eax
  42181a:	89 44 24 f0          	mov    %eax,-0x10(%rsp)
  42181e:	8b 44 24 e4          	mov    -0x1c(%rsp),%eax
  421822:	69 c0 02 59 00 00    	imul   $0x5902,%eax,%eax
  421828:	89 44 24 e4          	mov    %eax,-0x1c(%rsp)
  42182c:	8b 44 24 d8          	mov    -0x28(%rsp),%eax
  421830:	69 c0 2e 95 00 00    	imul   $0x952e,%eax,%eax
  421836:	89 44 24 d8          	mov    %eax,-0x28(%rsp)
  42183a:	8b 44 24 e4          	mov    -0x1c(%rsp),%eax
  42183e:	69 c0 8f f5 00 00    	imul   $0xf58f,%eax,%eax
  421844:	89 44 24 e4          	mov    %eax,-0x1c(%rsp)
  421848:	8b 44 24 ec          	mov    -0x14(%rsp),%eax
  42184c:	69 c0 13 60 00 00    	imul   $0x6013,%eax,%eax
  421852:	89 44 24 ec          	mov    %eax,-0x14(%rsp)
  421856:	8b 44 24 d8          	mov    -0x28(%rsp),%eax
  42185a:	69 c0 5f 8c 00 00    	imul   $0x8c5f,%eax,%eax
  421860:	89 44 24 d8          	mov    %eax,-0x28(%rsp)
  421864:	8b 44 24 f0          	mov    -0x10(%rsp),%eax
  421868:	69 c0 b7 47 00 00    	imul   $0x47b7,%eax,%eax
  42186e:	89 44 24 f0          	mov    %eax,-0x10(%rsp)
  421872:	8b 44 24 e4          	mov    -0x1c(%rsp),%eax
  421876:	69 c0 ea 96 00 00    	imul   $0x96ea,%eax,%eax
  42187c:	89 44 24 e4          	mov    %eax,-0x1c(%rsp)
  421880:	8b 44 24 f4          	mov    -0xc(%rsp),%eax
  421884:	69 c0 4b 29 00 00    	imul   $0x294b,%eax,%eax
  42188a:	89 44 24 f4          	mov    %eax,-0xc(%rsp)
  42188e:	8b 44 24 f4          	mov    -0xc(%rsp),%eax
  421892:	69 c0 de 18 00 00    	imul   $0x18de,%eax,%eax
  421898:	89 44 24 f4          	mov    %eax,-0xc(%rsp)
  42189c:	8b 44 24 ec          	mov    -0x14(%rsp),%eax
  4218a0:	69 c0 f9 11 00 00    	imul   $0x11f9,%eax,%eax
  4218a6:	89 44 24 ec          	mov    %eax,-0x14(%rsp)
  4218aa:	8b 44 24 e8          	mov    -0x18(%rsp),%eax
  4218ae:	69 c0 4e 94 00 00    	imul   $0x944e,%eax,%eax
  4218b4:	89 44 24 e8          	mov    %eax,-0x18(%rsp)
  4218b8:	8b 44 24 d0          	mov    -0x30(%rsp),%eax
  4218bc:	69 c0 18 7c 00 00    	imul   $0x7c18,%eax,%eax
  4218c2:	89 44 24 d0          	mov    %eax,-0x30(%rsp)
  4218c6:	8b 44 24 f4          	mov    -0xc(%rsp),%eax
  4218ca:	69 c0 3e 21 00 00    	imul   $0x213e,%eax,%eax
  4218d0:	89 44 24 f4          	mov    %eax,-0xc(%rsp)
  4218d4:	8b 44 24 d8          	mov    -0x28(%rsp),%eax
  4218d8:	69 c0 2e 48 00 00    	imul   $0x482e,%eax,%eax
  4218de:	89 44 24 d8          	mov    %eax,-0x28(%rsp)
  4218e2:	8b 44 24 f4          	mov    -0xc(%rsp),%eax
  4218e6:	69 c0 98 42 00 00    	imul   $0x4298,%eax,%eax
  4218ec:	89 44 24 f4          	mov    %eax,-0xc(%rsp)
  4218f0:	8b 44 24 d4          	mov    -0x2c(%rsp),%eax
  4218f4:	69 c0 18 11 00 00    	imul   $0x1118,%eax,%eax
  4218fa:	89 44 24 d4          	mov    %eax,-0x2c(%rsp)
  4218fe:	8b 44 24 e4          	mov    -0x1c(%rsp),%eax
  421902:	69 c0 50 08 00 00    	imul   $0x850,%eax,%eax
  421908:	89 44 24 e4          	mov    %eax,-0x1c(%rsp)
  42190c:	8b 44 24 d0          	mov    -0x30(%rsp),%eax
  421910:	69 c0 e3 c5 00 00    	imul   $0xc5e3,%eax,%eax
  421916:	89 44 24 d0          	mov    %eax,-0x30(%rsp)
  42191a:	8b 44 24 e8          	mov    -0x18(%rsp),%eax
  42191e:	69 c0 2e ef 00 00    	imul   $0xef2e,%eax,%eax
  421924:	89 44 24 e8          	mov    %eax,-0x18(%rsp)
  421928:	8b 44 24 e8          	mov    -0x18(%rsp),%eax
  42192c:	69 c0 cf d4 00 00    	imul   $0xd4cf,%eax,%eax
  421932:	89 44 24 e8          	mov    %eax,-0x18(%rsp)
  421936:	8b 44 24 e8          	mov    -0x18(%rsp),%eax
  42193a:	69 c0 ae f7 00 00    	imul   $0xf7ae,%eax,%eax
  421940:	89 44 24 e8          	mov    %eax,-0x18(%rsp)
  421944:	8b 44 24 e8          	mov    -0x18(%rsp),%eax
  421948:	69 c0 d0 d3 00 00    	imul   $0xd3d0,%eax,%eax
  42194e:	89 44 24 e8          	mov    %eax,-0x18(%rsp)
  421952:	8b 44 24 dc          	mov    -0x24(%rsp),%eax
  421956:	69 c0 b1 ac 00 00    	imul   $0xacb1,%eax,%eax
  42195c:	89 44 24 dc          	mov    %eax,-0x24(%rsp)
  421960:	8b 44 24 d8          	mov    -0x28(%rsp),%eax
  421964:	69 c0 1a b1 00 00    	imul   $0xb11a,%eax,%eax
  42196a:	89 44 24 d8          	mov    %eax,-0x28(%rsp)
  42196e:	8b 44 24 ec          	mov    -0x14(%rsp),%eax
  421972:	69 c0 d9 05 00 00    	imul   $0x5d9,%eax,%eax
  421978:	89 44 24 ec          	mov    %eax,-0x14(%rsp)
  42197c:	8b 44 24 e4          	mov    -0x1c(%rsp),%eax
  421980:	69 c0 a9 02 00 00    	imul   $0x2a9,%eax,%eax
  421986:	89 44 24 e4          	mov    %eax,-0x1c(%rsp)
  42198a:	8b 44 24 ec          	mov    -0x14(%rsp),%eax
  42198e:	69 c0 e7 e5 00 00    	imul   $0xe5e7,%eax,%eax
  421994:	89 44 24 ec          	mov    %eax,-0x14(%rsp)
  421998:	8b 44 24 dc          	mov    -0x24(%rsp),%eax
  42199c:	69 c0 2d 27 00 00    	imul   $0x272d,%eax,%eax
  4219a2:	89 44 24 dc          	mov    %eax,-0x24(%rsp)
  4219a6:	8b 44 24 dc          	mov    -0x24(%rsp),%eax
  4219aa:	69 c0 0e 2c 00 00    	imul   $0x2c0e,%eax,%eax
  4219b0:	89 44 24 dc          	mov    %eax,-0x24(%rsp)
  4219b4:	8b 44 24 e0          	mov    -0x20(%rsp),%eax
  4219b8:	69 c0 d9 c8 00 00    	imul   $0xc8d9,%eax,%eax
  4219be:	89 44 24 e0          	mov    %eax,-0x20(%rsp)
  4219c2:	8b 44 24 d8          	mov    -0x28(%rsp),%eax
  4219c6:	69 c0 c0 90 00 00    	imul   $0x90c0,%eax,%eax
  4219cc:	89 44 24 d8          	mov    %eax,-0x28(%rsp)
  4219d0:	8b 44 24 d0          	mov    -0x30(%rsp),%eax
  4219d4:	69 c0 41 0a 00 00    	imul   $0xa41,%eax,%eax
  4219da:	89 44 24 d0          	mov    %eax,-0x30(%rsp)
  4219de:	8b 44 24 d0          	mov    -0x30(%rsp),%eax
  4219e2:	69 c0 39 80 00 00    	imul   $0x8039,%eax,%eax
  4219e8:	89 44 24 d0          	mov    %eax,-0x30(%rsp)
  4219ec:	8b 44 24 f4          	mov    -0xc(%rsp),%eax
  4219f0:	69 c0 f0 96 00 00    	imul   $0x96f0,%eax,%eax
  4219f6:	89 44 24 f4          	mov    %eax,-0xc(%rsp)
  4219fa:	8b 44 24 f4          	mov    -0xc(%rsp),%eax
  4219fe:	69 c0 1a f6 00 00    	imul   $0xf61a,%eax,%eax
  421a04:	89 44 24 f4          	mov    %eax,-0xc(%rsp)
  421a08:	8b 44 24 f0          	mov    -0x10(%rsp),%eax
  421a0c:	69 c0 f5 ea 00 00    	imul   $0xeaf5,%eax,%eax
  421a12:	89 44 24 f0          	mov    %eax,-0x10(%rsp)
  421a16:	8b 44 24 dc          	mov    -0x24(%rsp),%eax
  421a1a:	69 c0 46 88 00 00    	imul   $0x8846,%eax,%eax
  421a20:	89 44 24 dc          	mov    %eax,-0x24(%rsp)
  421a24:	8b 44 24 d4          	mov    -0x2c(%rsp),%eax
  421a28:	69 c0 61 7c 00 00    	imul   $0x7c61,%eax,%eax
  421a2e:	89 44 24 d4          	mov    %eax,-0x2c(%rsp)
  421a32:	8b 44 24 dc          	mov    -0x24(%rsp),%eax
  421a36:	69 c0 e1 bb 00 00    	imul   $0xbbe1,%eax,%eax
  421a3c:	89 44 24 dc          	mov    %eax,-0x24(%rsp)
  421a40:	8b 44 24 d8          	mov    -0x28(%rsp),%eax
  421a44:	69 c0 87 fa 00 00    	imul   $0xfa87,%eax,%eax
  421a4a:	89 44 24 d8          	mov    %eax,-0x28(%rsp)
  421a4e:	8b 44 24 e0          	mov    -0x20(%rsp),%eax
  421a52:	69 c0 8e f0 00 00    	imul   $0xf08e,%eax,%eax
  421a58:	89 44 24 e0          	mov    %eax,-0x20(%rsp)
  421a5c:	8b 44 24 ec          	mov    -0x14(%rsp),%eax
  421a60:	69 c0 e1 5b 00 00    	imul   $0x5be1,%eax,%eax
  421a66:	89 44 24 ec          	mov    %eax,-0x14(%rsp)
  421a6a:	8b 44 24 e0          	mov    -0x20(%rsp),%eax
  421a6e:	69 c0 f1 7b 00 00    	imul   $0x7bf1,%eax,%eax
  421a74:	89 44 24 e0          	mov    %eax,-0x20(%rsp)
  421a78:	8b 44 24 dc          	mov    -0x24(%rsp),%eax
  421a7c:	69 c0 9a dd 00 00    	imul   $0xdd9a,%eax,%eax
  421a82:	89 44 24 dc          	mov    %eax,-0x24(%rsp)
  421a86:	8b 44 24 d0          	mov    -0x30(%rsp),%eax
  421a8a:	69 c0 69 f2 00 00    	imul   $0xf269,%eax,%eax
  421a90:	89 44 24 d0          	mov    %eax,-0x30(%rsp)
  421a94:	8b 44 24 dc          	mov    -0x24(%rsp),%eax
  421a98:	69 c0 a6 16 00 00    	imul   $0x16a6,%eax,%eax
  421a9e:	89 44 24 dc          	mov    %eax,-0x24(%rsp)
  421aa2:	8b 44 24 e4          	mov    -0x1c(%rsp),%eax
  421aa6:	69 c0 66 80 00 00    	imul   $0x8066,%eax,%eax
  421aac:	89 44 24 e4          	mov    %eax,-0x1c(%rsp)
  421ab0:	8b 44 24 d4          	mov    -0x2c(%rsp),%eax
  421ab4:	69 c0 39 1c 00 00    	imul   $0x1c39,%eax,%eax
  421aba:	89 44 24 d4          	mov    %eax,-0x2c(%rsp)
  421abe:	8b 44 24 e8          	mov    -0x18(%rsp),%eax
  421ac2:	69 c0 0c f1 00 00    	imul   $0xf10c,%eax,%eax
  421ac8:	89 44 24 e8          	mov    %eax,-0x18(%rsp)
  421acc:	8b 44 24 e8          	mov    -0x18(%rsp),%eax
  421ad0:	69 c0 06 70 00 00    	imul   $0x7006,%eax,%eax
  421ad6:	89 44 24 e8          	mov    %eax,-0x18(%rsp)
  421ada:	8b 44 24 d0          	mov    -0x30(%rsp),%eax
  421ade:	69 c0 e9 1e 00 00    	imul   $0x1ee9,%eax,%eax
  421ae4:	89 44 24 d0          	mov    %eax,-0x30(%rsp)
  421ae8:	8b 44 24 ec          	mov    -0x14(%rsp),%eax
  421aec:	69 c0 ef d4 00 00    	imul   $0xd4ef,%eax,%eax
  421af2:	89 44 24 ec          	mov    %eax,-0x14(%rsp)
  421af6:	8b 44 24 d0          	mov    -0x30(%rsp),%eax
  421afa:	69 c0 c1 19 00 00    	imul   $0x19c1,%eax,%eax
  421b00:	89 44 24 d0          	mov    %eax,-0x30(%rsp)
  421b04:	8b 44 24 d8          	mov    -0x28(%rsp),%eax
  421b08:	69 c0 27 dc 00 00    	imul   $0xdc27,%eax,%eax
  421b0e:	89 44 24 d8          	mov    %eax,-0x28(%rsp)
  421b12:	8b 44 24 e0          	mov    -0x20(%rsp),%eax
  421b16:	69 c0 cb 7e 00 00    	imul   $0x7ecb,%eax,%eax
  421b1c:	89 44 24 e0          	mov    %eax,-0x20(%rsp)
  421b20:	8b 44 24 e4          	mov    -0x1c(%rsp),%eax
  421b24:	69 c0 5c 97 00 00    	imul   $0x975c,%eax,%eax
  421b2a:	89 44 24 e4          	mov    %eax,-0x1c(%rsp)
  421b2e:	8b 44 24 dc          	mov    -0x24(%rsp),%eax
  421b32:	69 c0 df d3 00 00    	imul   $0xd3df,%eax,%eax
  421b38:	89 44 24 dc          	mov    %eax,-0x24(%rsp)
  421b3c:	8b 44 24 e8          	mov    -0x18(%rsp),%eax
  421b40:	69 c0 ce 45 00 00    	imul   $0x45ce,%eax,%eax
  421b46:	89 44 24 e8          	mov    %eax,-0x18(%rsp)
  421b4a:	8b 44 24 e8          	mov    -0x18(%rsp),%eax
  421b4e:	69 c0 4b 76 00 00    	imul   $0x764b,%eax,%eax
  421b54:	89 44 24 e8          	mov    %eax,-0x18(%rsp)
  421b58:	8b 44 24 e8          	mov    -0x18(%rsp),%eax
  421b5c:	69 c0 d0 f7 00 00    	imul   $0xf7d0,%eax,%eax
  421b62:	89 44 24 e8          	mov    %eax,-0x18(%rsp)
  421b66:	8b 44 24 d0          	mov    -0x30(%rsp),%eax
  421b6a:	69 c0 dc c9 00 00    	imul   $0xc9dc,%eax,%eax
  421b70:	89 44 24 d0          	mov    %eax,-0x30(%rsp)
  421b74:	8b 44 24 d0          	mov    -0x30(%rsp),%eax
  421b78:	69 c0 dd eb 00 00    	imul   $0xebdd,%eax,%eax
  421b7e:	89 44 24 d0          	mov    %eax,-0x30(%rsp)
  421b82:	8b 44 24 e4          	mov    -0x1c(%rsp),%eax
  421b86:	69 c0 5d 2f 00 00    	imul   $0x2f5d,%eax,%eax
  421b8c:	89 44 24 e4          	mov    %eax,-0x1c(%rsp)
  421b90:	8b 44 24 ec          	mov    -0x14(%rsp),%eax
  421b94:	69 c0 e1 4a 00 00    	imul   $0x4ae1,%eax,%eax
  421b9a:	89 44 24 ec          	mov    %eax,-0x14(%rsp)
  421b9e:	8b 44 24 e8          	mov    -0x18(%rsp),%eax
  421ba2:	69 c0 41 bb 00 00    	imul   $0xbb41,%eax,%eax
  421ba8:	89 44 24 e8          	mov    %eax,-0x18(%rsp)
  421bac:	8b 44 24 d8          	mov    -0x28(%rsp),%eax
  421bb0:	69 c0 90 07 00 00    	imul   $0x790,%eax,%eax
  421bb6:	89 44 24 d8          	mov    %eax,-0x28(%rsp)
  421bba:	ba 00 00 00 00       	mov    $0x0,%edx
  421bbf:	b8 00 00 00 00       	mov    $0x0,%eax
  421bc4:	eb 0b                	jmp    421bd1 <scramble+0x44e>
  421bc6:	89 d1                	mov    %edx,%ecx
  421bc8:	8b 4c 8c d0          	mov    -0x30(%rsp,%rcx,4),%ecx
  421bcc:	01 c8                	add    %ecx,%eax
  421bce:	83 c2 01             	add    $0x1,%edx
  421bd1:	83 fa 09             	cmp    $0x9,%edx
  421bd4:	76 f0                	jbe    421bc6 <scramble+0x443>
  421bd6:	f3 c3                	repz retq 

0000000000421bd8 <getbuf>:
  421bd8:	48 83 ec 38          	sub    $0x38,%rsp
  421bdc:	48 89 e7             	mov    %rsp,%rdi
  421bdf:	e8 56 03 00 00       	callq  421f3a <Gets>
  421be4:	b8 01 00 00 00       	mov    $0x1,%eax
  421be9:	48 83 c4 38          	add    $0x38,%rsp
  421bed:	c3                   	retq   

0000000000421bee <touch1>:
  421bee:	48 83 ec 08          	sub    $0x8,%rsp
  421bf2:	c7 05 00 39 20 00 01 	movl   $0x1,0x203900(%rip)        # 6254fc <vlevel>
  421bf9:	00 00 00 
  421bfc:	bf ef 35 42 00       	mov    $0x4235ef,%edi
  421c01:	e8 4a f0 fd ff       	callq  400c50 <puts@plt>
  421c06:	bf 01 00 00 00       	mov    $0x1,%edi
  421c0b:	e8 19 05 00 00       	callq  422129 <validate>
  421c10:	bf 00 00 00 00       	mov    $0x0,%edi
  421c15:	e8 d6 f1 fd ff       	callq  400df0 <exit@plt>

0000000000421c1a <touch2>:
  421c1a:	48 83 ec 08          	sub    $0x8,%rsp
  421c1e:	89 fe                	mov    %edi,%esi
  421c20:	c7 05 d2 38 20 00 02 	movl   $0x2,0x2038d2(%rip)        # 6254fc <vlevel>
  421c27:	00 00 00 
  421c2a:	3b 3d d4 38 20 00    	cmp    0x2038d4(%rip),%edi        # 625504 <cookie>
  421c30:	75 1b                	jne    421c4d <touch2+0x33>
  421c32:	bf 18 36 42 00       	mov    $0x423618,%edi
  421c37:	b8 00 00 00 00       	mov    $0x0,%eax
  421c3c:	e8 3f f0 fd ff       	callq  400c80 <printf@plt>
  421c41:	bf 02 00 00 00       	mov    $0x2,%edi
  421c46:	e8 de 04 00 00       	callq  422129 <validate>
  421c4b:	eb 19                	jmp    421c66 <touch2+0x4c>
  421c4d:	bf 40 36 42 00       	mov    $0x423640,%edi
  421c52:	b8 00 00 00 00       	mov    $0x0,%eax
  421c57:	e8 24 f0 fd ff       	callq  400c80 <printf@plt>
  421c5c:	bf 02 00 00 00       	mov    $0x2,%edi
  421c61:	e8 75 05 00 00       	callq  4221db <fail>
  421c66:	bf 00 00 00 00       	mov    $0x0,%edi
  421c6b:	e8 80 f1 fd ff       	callq  400df0 <exit@plt>

0000000000421c70 <hexmatch>:
  421c70:	41 54                	push   %r12
  421c72:	55                   	push   %rbp
  421c73:	53                   	push   %rbx
  421c74:	48 83 ec 70          	sub    $0x70,%rsp
  421c78:	41 89 fc             	mov    %edi,%r12d
  421c7b:	48 89 f5             	mov    %rsi,%rbp
  421c7e:	e8 cd f0 fd ff       	callq  400d50 <random@plt>
  421c83:	48 89 c1             	mov    %rax,%rcx
  421c86:	48 ba 0b d7 a3 70 3d 	movabs $0xa3d70a3d70a3d70b,%rdx
  421c8d:	0a d7 a3 
  421c90:	48 f7 ea             	imul   %rdx
  421c93:	48 8d 04 0a          	lea    (%rdx,%rcx,1),%rax
  421c97:	48 c1 f8 06          	sar    $0x6,%rax
  421c9b:	48 89 ce             	mov    %rcx,%rsi
  421c9e:	48 c1 fe 3f          	sar    $0x3f,%rsi
  421ca2:	48 29 f0             	sub    %rsi,%rax
  421ca5:	48 8d 04 80          	lea    (%rax,%rax,4),%rax
  421ca9:	48 8d 04 80          	lea    (%rax,%rax,4),%rax
  421cad:	48 c1 e0 02          	shl    $0x2,%rax
  421cb1:	48 29 c1             	sub    %rax,%rcx
  421cb4:	48 8d 1c 0c          	lea    (%rsp,%rcx,1),%rbx
  421cb8:	44 89 e2             	mov    %r12d,%edx
  421cbb:	be 0c 36 42 00       	mov    $0x42360c,%esi
  421cc0:	48 89 df             	mov    %rbx,%rdi
  421cc3:	b8 00 00 00 00       	mov    $0x0,%eax
  421cc8:	e8 13 f1 fd ff       	callq  400de0 <sprintf@plt>
  421ccd:	ba 09 00 00 00       	mov    $0x9,%edx
  421cd2:	48 89 de             	mov    %rbx,%rsi
  421cd5:	48 89 ef             	mov    %rbp,%rdi
  421cd8:	e8 53 ef fd ff       	callq  400c30 <strncmp@plt>
  421cdd:	85 c0                	test   %eax,%eax
  421cdf:	0f 94 c0             	sete   %al
  421ce2:	0f b6 c0             	movzbl %al,%eax
  421ce5:	48 83 c4 70          	add    $0x70,%rsp
  421ce9:	5b                   	pop    %rbx
  421cea:	5d                   	pop    %rbp
  421ceb:	41 5c                	pop    %r12
  421ced:	c3                   	retq   

0000000000421cee <touch3>:
  421cee:	53                   	push   %rbx
  421cef:	48 89 fb             	mov    %rdi,%rbx
  421cf2:	c7 05 00 38 20 00 03 	movl   $0x3,0x203800(%rip)        # 6254fc <vlevel>
  421cf9:	00 00 00 
  421cfc:	48 89 fe             	mov    %rdi,%rsi
  421cff:	8b 3d ff 37 20 00    	mov    0x2037ff(%rip),%edi        # 625504 <cookie>
  421d05:	e8 66 ff ff ff       	callq  421c70 <hexmatch>
  421d0a:	85 c0                	test   %eax,%eax
  421d0c:	74 1e                	je     421d2c <touch3+0x3e>
  421d0e:	48 89 de             	mov    %rbx,%rsi
  421d11:	bf 68 36 42 00       	mov    $0x423668,%edi
  421d16:	b8 00 00 00 00       	mov    $0x0,%eax
  421d1b:	e8 60 ef fd ff       	callq  400c80 <printf@plt>
  421d20:	bf 03 00 00 00       	mov    $0x3,%edi
  421d25:	e8 ff 03 00 00       	callq  422129 <validate>
  421d2a:	eb 1c                	jmp    421d48 <touch3+0x5a>
  421d2c:	48 89 de             	mov    %rbx,%rsi
  421d2f:	bf 90 36 42 00       	mov    $0x423690,%edi
  421d34:	b8 00 00 00 00       	mov    $0x0,%eax
  421d39:	e8 42 ef fd ff       	callq  400c80 <printf@plt>
  421d3e:	bf 03 00 00 00       	mov    $0x3,%edi
  421d43:	e8 93 04 00 00       	callq  4221db <fail>
  421d48:	bf 00 00 00 00       	mov    $0x0,%edi
  421d4d:	e8 9e f0 fd ff       	callq  400df0 <exit@plt>

0000000000421d52 <test>:
  421d52:	48 83 ec 08          	sub    $0x8,%rsp
  421d56:	b8 00 00 00 00       	mov    $0x0,%eax
  421d5b:	e8 78 fe ff ff       	callq  421bd8 <getbuf>
  421d60:	89 c6                	mov    %eax,%esi
  421d62:	bf b8 36 42 00       	mov    $0x4236b8,%edi
  421d67:	b8 00 00 00 00       	mov    $0x0,%eax
  421d6c:	e8 0f ef fd ff       	callq  400c80 <printf@plt>
  421d71:	48 83 c4 08          	add    $0x8,%rsp
  421d75:	c3                   	retq   

0000000000421d76 <start_farm>:
  421d76:	b8 01 00 00 00       	mov    $0x1,%eax
  421d7b:	c3                   	retq   

0000000000421d7c <addval_314>:
  421d7c:	8d 87 48 89 c7 94    	lea    -0x6b3876b8(%rdi),%eax
  421d82:	c3                   	retq   

0000000000421d83 <getval_257>:
  421d83:	b8 48 89 c7 91       	mov    $0x91c78948,%eax
  421d88:	c3                   	retq   

0000000000421d89 <addval_435>:
  421d89:	8d 87 91 58 90 c3    	lea    -0x3c6fa76f(%rdi),%eax
  421d8f:	c3                   	retq   

0000000000421d90 <addval_298>:
  421d90:	8d 87 58 90 94 c3    	lea    -0x3c6b6fa8(%rdi),%eax
  421d96:	c3                   	retq   

0000000000421d97 <getval_395>:
  421d97:	b8 48 89 c7 c3       	mov    $0xc3c78948,%eax
  421d9c:	c3                   	retq   

0000000000421d9d <setval_456>:
  421d9d:	c7 07 48 89 c7 c3    	movl   $0xc3c78948,(%rdi)
  421da3:	c3                   	retq   

0000000000421da4 <setval_385>:
  421da4:	c7 07 7e 90 50 90    	movl   $0x9050907e,(%rdi)
  421daa:	c3                   	retq   

0000000000421dab <setval_471>:
  421dab:	c7 07 c2 6a 30 58    	movl   $0x58306ac2,(%rdi)
  421db1:	c3                   	retq   

0000000000421db2 <mid_farm>:
  421db2:	b8 01 00 00 00       	mov    $0x1,%eax
  421db7:	c3                   	retq   

0000000000421db8 <add_xy>:
  421db8:	48 8d 04 37          	lea    (%rdi,%rsi,1),%rax
  421dbc:	c3                   	retq   

0000000000421dbd <setval_341>:
  421dbd:	c7 07 cf 08 89 e0    	movl   $0xe08908cf,(%rdi)
  421dc3:	c3                   	retq   

0000000000421dc4 <addval_144>:
  421dc4:	8d 87 48 89 e0 90    	lea    -0x6f1f76b8(%rdi),%eax
  421dca:	c3                   	retq   

0000000000421dcb <getval_427>:
  421dcb:	b8 89 ca 60 c9       	mov    $0xc960ca89,%eax
  421dd0:	c3                   	retq   

0000000000421dd1 <getval_305>:
  421dd1:	b8 89 ca 08 c0       	mov    $0xc008ca89,%eax
  421dd6:	c3                   	retq   

0000000000421dd7 <addval_346>:
  421dd7:	8d 87 8b d6 c3 b3    	lea    -0x4c3c2975(%rdi),%eax
  421ddd:	c3                   	retq   

0000000000421dde <getval_327>:
  421dde:	b8 89 c1 94 c9       	mov    $0xc994c189,%eax
  421de3:	c3                   	retq   

0000000000421de4 <addval_374>:
  421de4:	8d 87 88 ca 20 d2    	lea    -0x2ddf3578(%rdi),%eax
  421dea:	c3                   	retq   

0000000000421deb <getval_323>:
  421deb:	b8 99 ca 38 c0       	mov    $0xc038ca99,%eax
  421df0:	c3                   	retq   

0000000000421df1 <setval_322>:
  421df1:	c7 07 48 89 e0 92    	movl   $0x92e08948,(%rdi)
  421df7:	c3                   	retq   

0000000000421df8 <setval_355>:
  421df8:	c7 07 48 89 e0 c3    	movl   $0xc3e08948,(%rdi)
  421dfe:	c3                   	retq   

0000000000421dff <setval_440>:
  421dff:	c7 07 48 89 e0 c2    	movl   $0xc2e08948,(%rdi)
  421e05:	c3                   	retq   

0000000000421e06 <setval_228>:
  421e06:	c7 07 48 8b e0 c3    	movl   $0xc3e08b48,(%rdi)
  421e0c:	c3                   	retq   

0000000000421e0d <setval_124>:
  421e0d:	c7 07 89 ca 90 c3    	movl   $0xc390ca89,(%rdi)
  421e13:	c3                   	retq   

0000000000421e14 <addval_386>:
  421e14:	8d 87 89 d6 c3 80    	lea    -0x7f3c2977(%rdi),%eax
  421e1a:	c3                   	retq   

0000000000421e1b <addval_320>:
  421e1b:	8d 87 8b d6 20 c9    	lea    -0x36df2975(%rdi),%eax
  421e21:	c3                   	retq   

0000000000421e22 <getval_368>:
  421e22:	b8 89 ca a4 c9       	mov    $0xc9a4ca89,%eax
  421e27:	c3                   	retq   

0000000000421e28 <getval_134>:
  421e28:	b8 89 c1 c4 d2       	mov    $0xd2c4c189,%eax
  421e2d:	c3                   	retq   

0000000000421e2e <addval_254>:
  421e2e:	8d 87 89 d6 84 db    	lea    -0x247b2977(%rdi),%eax
  421e34:	c3                   	retq   

0000000000421e35 <addval_176>:
  421e35:	8d 87 41 89 d6 94    	lea    -0x6b2976bf(%rdi),%eax
  421e3b:	c3                   	retq   

0000000000421e3c <setval_442>:
  421e3c:	c7 07 5d 48 09 e0    	movl   $0xe009485d,(%rdi)
  421e42:	c3                   	retq   

0000000000421e43 <getval_474>:
  421e43:	b8 89 ca 60 d2       	mov    $0xd260ca89,%eax
  421e48:	c3                   	retq   

0000000000421e49 <setval_284>:
  421e49:	c7 07 89 ca a4 d2    	movl   $0xd2a4ca89,(%rdi)
  421e4f:	c3                   	retq   

0000000000421e50 <setval_459>:
  421e50:	c7 07 89 c1 90 c3    	movl   $0xc390c189,(%rdi)
  421e56:	c3                   	retq   

0000000000421e57 <setval_230>:
  421e57:	c7 07 8b d6 20 db    	movl   $0xdb20d68b,(%rdi)
  421e5d:	c3                   	retq   

0000000000421e5e <setval_455>:
  421e5e:	c7 07 08 89 e0 c3    	movl   $0xc3e08908,(%rdi)
  421e64:	c3                   	retq   

0000000000421e65 <addval_464>:
  421e65:	8d 87 89 c1 78 c9    	lea    -0x36873e77(%rdi),%eax
  421e6b:	c3                   	retq   

0000000000421e6c <getval_317>:
  421e6c:	b8 99 c1 38 c9       	mov    $0xc938c199,%eax
  421e71:	c3                   	retq   

0000000000421e72 <addval_226>:
  421e72:	8d 87 89 c1 c3 dc    	lea    -0x233c3e77(%rdi),%eax
  421e78:	c3                   	retq   

0000000000421e79 <setval_162>:
  421e79:	c7 07 89 d6 90 c1    	movl   $0xc190d689,(%rdi)
  421e7f:	c3                   	retq   

0000000000421e80 <setval_280>:
  421e80:	c7 07 89 c1 78 db    	movl   $0xdb78c189,(%rdi)
  421e86:	c3                   	retq   

0000000000421e87 <setval_140>:
  421e87:	c7 07 89 c1 94 d2    	movl   $0xd294c189,(%rdi)
  421e8d:	c3                   	retq   

0000000000421e8e <setval_242>:
  421e8e:	c7 07 89 d6 30 c0    	movl   $0xc030d689,(%rdi)
  421e94:	c3                   	retq   

0000000000421e95 <end_farm>:
  421e95:	b8 01 00 00 00       	mov    $0x1,%eax
  421e9a:	c3                   	retq   
  421e9b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000421ea0 <save_char>:
  421ea0:	8b 05 7e 42 20 00    	mov    0x20427e(%rip),%eax        # 626124 <gets_cnt>
  421ea6:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  421eab:	7f 49                	jg     421ef6 <save_char+0x56>
  421ead:	8d 14 40             	lea    (%rax,%rax,2),%edx
  421eb0:	89 f9                	mov    %edi,%ecx
  421eb2:	c0 e9 04             	shr    $0x4,%cl
  421eb5:	83 e1 0f             	and    $0xf,%ecx
  421eb8:	0f b6 b1 e0 39 42 00 	movzbl 0x4239e0(%rcx),%esi
  421ebf:	48 63 ca             	movslq %edx,%rcx
  421ec2:	40 88 b1 20 55 62 00 	mov    %sil,0x625520(%rcx)
  421ec9:	8d 4a 01             	lea    0x1(%rdx),%ecx
  421ecc:	83 e7 0f             	and    $0xf,%edi
  421ecf:	0f b6 b7 e0 39 42 00 	movzbl 0x4239e0(%rdi),%esi
  421ed6:	48 63 c9             	movslq %ecx,%rcx
  421ed9:	40 88 b1 20 55 62 00 	mov    %sil,0x625520(%rcx)
  421ee0:	83 c2 02             	add    $0x2,%edx
  421ee3:	48 63 d2             	movslq %edx,%rdx
  421ee6:	c6 82 20 55 62 00 20 	movb   $0x20,0x625520(%rdx)
  421eed:	83 c0 01             	add    $0x1,%eax
  421ef0:	89 05 2e 42 20 00    	mov    %eax,0x20422e(%rip)        # 626124 <gets_cnt>
  421ef6:	f3 c3                	repz retq 

0000000000421ef8 <save_term>:
  421ef8:	8b 05 26 42 20 00    	mov    0x204226(%rip),%eax        # 626124 <gets_cnt>
  421efe:	8d 04 40             	lea    (%rax,%rax,2),%eax
  421f01:	48 98                	cltq   
  421f03:	c6 80 20 55 62 00 00 	movb   $0x0,0x625520(%rax)
  421f0a:	c3                   	retq   

0000000000421f0b <check_fail>:
  421f0b:	48 83 ec 08          	sub    $0x8,%rsp
  421f0f:	0f be 35 12 42 20 00 	movsbl 0x204212(%rip),%esi        # 626128 <target_prefix>
  421f16:	b9 20 55 62 00       	mov    $0x625520,%ecx
  421f1b:	8b 15 d7 35 20 00    	mov    0x2035d7(%rip),%edx        # 6254f8 <check_level>
  421f21:	bf db 36 42 00       	mov    $0x4236db,%edi
  421f26:	b8 00 00 00 00       	mov    $0x0,%eax
  421f2b:	e8 50 ed fd ff       	callq  400c80 <printf@plt>
  421f30:	bf 01 00 00 00       	mov    $0x1,%edi
  421f35:	e8 b6 ee fd ff       	callq  400df0 <exit@plt>

0000000000421f3a <Gets>:
  421f3a:	41 54                	push   %r12
  421f3c:	55                   	push   %rbp
  421f3d:	53                   	push   %rbx
  421f3e:	49 89 fc             	mov    %rdi,%r12
  421f41:	c7 05 d9 41 20 00 00 	movl   $0x0,0x2041d9(%rip)        # 626124 <gets_cnt>
  421f48:	00 00 00 
  421f4b:	48 89 fb             	mov    %rdi,%rbx
  421f4e:	eb 11                	jmp    421f61 <Gets+0x27>
  421f50:	48 8d 6b 01          	lea    0x1(%rbx),%rbp
  421f54:	88 03                	mov    %al,(%rbx)
  421f56:	0f b6 f8             	movzbl %al,%edi
  421f59:	e8 42 ff ff ff       	callq  421ea0 <save_char>
  421f5e:	48 89 eb             	mov    %rbp,%rbx
  421f61:	48 8b 3d 88 35 20 00 	mov    0x203588(%rip),%rdi        # 6254f0 <infile>
  421f68:	e8 f3 ed fd ff       	callq  400d60 <_IO_getc@plt>
  421f6d:	83 f8 ff             	cmp    $0xffffffff,%eax
  421f70:	74 05                	je     421f77 <Gets+0x3d>
  421f72:	83 f8 0a             	cmp    $0xa,%eax
  421f75:	75 d9                	jne    421f50 <Gets+0x16>
  421f77:	c6 03 00             	movb   $0x0,(%rbx)
  421f7a:	b8 00 00 00 00       	mov    $0x0,%eax
  421f7f:	e8 74 ff ff ff       	callq  421ef8 <save_term>
  421f84:	4c 89 e0             	mov    %r12,%rax
  421f87:	5b                   	pop    %rbx
  421f88:	5d                   	pop    %rbp
  421f89:	41 5c                	pop    %r12
  421f8b:	c3                   	retq   

0000000000421f8c <notify_server>:
  421f8c:	83 3d 75 35 20 00 00 	cmpl   $0x0,0x203575(%rip)        # 625508 <is_checker>
  421f93:	0f 85 8e 01 00 00    	jne    422127 <notify_server+0x19b>
  421f99:	53                   	push   %rbx
  421f9a:	48 81 ec 10 40 00 00 	sub    $0x4010,%rsp
  421fa1:	89 fb                	mov    %edi,%ebx
  421fa3:	8b 05 7b 41 20 00    	mov    0x20417b(%rip),%eax        # 626124 <gets_cnt>
  421fa9:	83 c0 64             	add    $0x64,%eax
  421fac:	3d 00 20 00 00       	cmp    $0x2000,%eax
  421fb1:	7e 19                	jle    421fcc <notify_server+0x40>
  421fb3:	bf 10 38 42 00       	mov    $0x423810,%edi
  421fb8:	b8 00 00 00 00       	mov    $0x0,%eax
  421fbd:	e8 be ec fd ff       	callq  400c80 <printf@plt>
  421fc2:	bf 01 00 00 00       	mov    $0x1,%edi
  421fc7:	e8 24 ee fd ff       	callq  400df0 <exit@plt>
  421fcc:	44 0f be 0d 54 41 20 	movsbl 0x204154(%rip),%r9d        # 626128 <target_prefix>
  421fd3:	00 
  421fd4:	83 3d cd 34 20 00 00 	cmpl   $0x0,0x2034cd(%rip)        # 6254a8 <notify>
  421fdb:	74 09                	je     421fe6 <notify_server+0x5a>
  421fdd:	44 8b 05 1c 35 20 00 	mov    0x20351c(%rip),%r8d        # 625500 <authkey>
  421fe4:	eb 06                	jmp    421fec <notify_server+0x60>
  421fe6:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
  421fec:	85 db                	test   %ebx,%ebx
  421fee:	74 07                	je     421ff7 <notify_server+0x6b>
  421ff0:	b9 f1 36 42 00       	mov    $0x4236f1,%ecx
  421ff5:	eb 05                	jmp    421ffc <notify_server+0x70>
  421ff7:	b9 f6 36 42 00       	mov    $0x4236f6,%ecx
  421ffc:	48 c7 44 24 08 20 55 	movq   $0x625520,0x8(%rsp)
  422003:	62 00 
  422005:	89 34 24             	mov    %esi,(%rsp)
  422008:	8b 15 5a 31 20 00    	mov    0x20315a(%rip),%edx        # 625168 <target_id>
  42200e:	be fb 36 42 00       	mov    $0x4236fb,%esi
  422013:	48 8d bc 24 10 20 00 	lea    0x2010(%rsp),%rdi
  42201a:	00 
  42201b:	b8 00 00 00 00       	mov    $0x0,%eax
  422020:	e8 bb ed fd ff       	callq  400de0 <sprintf@plt>
  422025:	83 3d 7c 34 20 00 00 	cmpl   $0x0,0x20347c(%rip)        # 6254a8 <notify>
  42202c:	74 78                	je     4220a6 <notify_server+0x11a>
  42202e:	4c 8d 4c 24 10       	lea    0x10(%rsp),%r9
  422033:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  422039:	48 8d 8c 24 10 20 00 	lea    0x2010(%rsp),%rcx
  422040:	00 
  422041:	48 8b 15 28 31 20 00 	mov    0x203128(%rip),%rdx        # 625170 <lab>
  422048:	48 8b 35 29 31 20 00 	mov    0x203129(%rip),%rsi        # 625178 <course>
  42204f:	48 8b 3d 0a 31 20 00 	mov    0x20310a(%rip),%rdi        # 625160 <user_id>
  422056:	e8 b3 0f 00 00       	callq  42300e <driver_post>
  42205b:	85 c0                	test   %eax,%eax
  42205d:	79 1e                	jns    42207d <notify_server+0xf1>
  42205f:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
  422064:	bf 17 37 42 00       	mov    $0x423717,%edi
  422069:	b8 00 00 00 00       	mov    $0x0,%eax
  42206e:	e8 0d ec fd ff       	callq  400c80 <printf@plt>
  422073:	bf 01 00 00 00       	mov    $0x1,%edi
  422078:	e8 73 ed fd ff       	callq  400df0 <exit@plt>
  42207d:	85 db                	test   %ebx,%ebx
  42207f:	74 19                	je     42209a <notify_server+0x10e>
  422081:	bf 40 38 42 00       	mov    $0x423840,%edi
  422086:	e8 c5 eb fd ff       	callq  400c50 <puts@plt>
  42208b:	bf 23 37 42 00       	mov    $0x423723,%edi
  422090:	e8 bb eb fd ff       	callq  400c50 <puts@plt>
  422095:	e9 85 00 00 00       	jmpq   42211f <notify_server+0x193>
  42209a:	bf 2d 37 42 00       	mov    $0x42372d,%edi
  42209f:	e8 ac eb fd ff       	callq  400c50 <puts@plt>
  4220a4:	eb 79                	jmp    42211f <notify_server+0x193>
  4220a6:	85 db                	test   %ebx,%ebx
  4220a8:	74 08                	je     4220b2 <notify_server+0x126>
  4220aa:	be f1 36 42 00       	mov    $0x4236f1,%esi
  4220af:	90                   	nop
  4220b0:	eb 05                	jmp    4220b7 <notify_server+0x12b>
  4220b2:	be f6 36 42 00       	mov    $0x4236f6,%esi
  4220b7:	bf 78 38 42 00       	mov    $0x423878,%edi
  4220bc:	b8 00 00 00 00       	mov    $0x0,%eax
  4220c1:	e8 ba eb fd ff       	callq  400c80 <printf@plt>
  4220c6:	48 8b 35 93 30 20 00 	mov    0x203093(%rip),%rsi        # 625160 <user_id>
  4220cd:	bf 34 37 42 00       	mov    $0x423734,%edi
  4220d2:	b8 00 00 00 00       	mov    $0x0,%eax
  4220d7:	e8 a4 eb fd ff       	callq  400c80 <printf@plt>
  4220dc:	48 8b 35 95 30 20 00 	mov    0x203095(%rip),%rsi        # 625178 <course>
  4220e3:	bf 41 37 42 00       	mov    $0x423741,%edi
  4220e8:	b8 00 00 00 00       	mov    $0x0,%eax
  4220ed:	e8 8e eb fd ff       	callq  400c80 <printf@plt>
  4220f2:	48 8b 35 77 30 20 00 	mov    0x203077(%rip),%rsi        # 625170 <lab>
  4220f9:	bf 4d 37 42 00       	mov    $0x42374d,%edi
  4220fe:	b8 00 00 00 00       	mov    $0x0,%eax
  422103:	e8 78 eb fd ff       	callq  400c80 <printf@plt>
  422108:	48 8d b4 24 10 20 00 	lea    0x2010(%rsp),%rsi
  42210f:	00 
  422110:	bf 56 37 42 00       	mov    $0x423756,%edi
  422115:	b8 00 00 00 00       	mov    $0x0,%eax
  42211a:	e8 61 eb fd ff       	callq  400c80 <printf@plt>
  42211f:	48 81 c4 10 40 00 00 	add    $0x4010,%rsp
  422126:	5b                   	pop    %rbx
  422127:	f3 c3                	repz retq 

0000000000422129 <validate>:
  422129:	53                   	push   %rbx
  42212a:	89 fb                	mov    %edi,%ebx
  42212c:	83 3d d5 33 20 00 00 	cmpl   $0x0,0x2033d5(%rip)        # 625508 <is_checker>
  422133:	74 60                	je     422195 <validate+0x6c>
  422135:	39 3d c1 33 20 00    	cmp    %edi,0x2033c1(%rip)        # 6254fc <vlevel>
  42213b:	74 14                	je     422151 <validate+0x28>
  42213d:	bf 62 37 42 00       	mov    $0x423762,%edi
  422142:	e8 09 eb fd ff       	callq  400c50 <puts@plt>
  422147:	b8 00 00 00 00       	mov    $0x0,%eax
  42214c:	e8 ba fd ff ff       	callq  421f0b <check_fail>
  422151:	8b 35 a1 33 20 00    	mov    0x2033a1(%rip),%esi        # 6254f8 <check_level>
  422157:	39 fe                	cmp    %edi,%esi
  422159:	74 1b                	je     422176 <validate+0x4d>
  42215b:	89 fa                	mov    %edi,%edx
  42215d:	bf a0 38 42 00       	mov    $0x4238a0,%edi
  422162:	b8 00 00 00 00       	mov    $0x0,%eax
  422167:	e8 14 eb fd ff       	callq  400c80 <printf@plt>
  42216c:	b8 00 00 00 00       	mov    $0x0,%eax
  422171:	e8 95 fd ff ff       	callq  421f0b <check_fail>
  422176:	0f be 35 ab 3f 20 00 	movsbl 0x203fab(%rip),%esi        # 626128 <target_prefix>
  42217d:	b9 20 55 62 00       	mov    $0x625520,%ecx
  422182:	89 fa                	mov    %edi,%edx
  422184:	bf 80 37 42 00       	mov    $0x423780,%edi
  422189:	b8 00 00 00 00       	mov    $0x0,%eax
  42218e:	e8 ed ea fd ff       	callq  400c80 <printf@plt>
  422193:	eb 44                	jmp    4221d9 <validate+0xb0>
  422195:	39 3d 61 33 20 00    	cmp    %edi,0x203361(%rip)        # 6254fc <vlevel>
  42219b:	74 18                	je     4221b5 <validate+0x8c>
  42219d:	bf 62 37 42 00       	mov    $0x423762,%edi
  4221a2:	e8 a9 ea fd ff       	callq  400c50 <puts@plt>
  4221a7:	89 de                	mov    %ebx,%esi
  4221a9:	bf 00 00 00 00       	mov    $0x0,%edi
  4221ae:	e8 d9 fd ff ff       	callq  421f8c <notify_server>
  4221b3:	eb 24                	jmp    4221d9 <validate+0xb0>
  4221b5:	0f be 15 6c 3f 20 00 	movsbl 0x203f6c(%rip),%edx        # 626128 <target_prefix>
  4221bc:	89 fe                	mov    %edi,%esi
  4221be:	bf c8 38 42 00       	mov    $0x4238c8,%edi
  4221c3:	b8 00 00 00 00       	mov    $0x0,%eax
  4221c8:	e8 b3 ea fd ff       	callq  400c80 <printf@plt>
  4221cd:	89 de                	mov    %ebx,%esi
  4221cf:	bf 01 00 00 00       	mov    $0x1,%edi
  4221d4:	e8 b3 fd ff ff       	callq  421f8c <notify_server>
  4221d9:	5b                   	pop    %rbx
  4221da:	c3                   	retq   

00000000004221db <fail>:
  4221db:	48 83 ec 08          	sub    $0x8,%rsp
  4221df:	83 3d 22 33 20 00 00 	cmpl   $0x0,0x203322(%rip)        # 625508 <is_checker>
  4221e6:	74 0a                	je     4221f2 <fail+0x17>
  4221e8:	b8 00 00 00 00       	mov    $0x0,%eax
  4221ed:	e8 19 fd ff ff       	callq  421f0b <check_fail>
  4221f2:	89 fe                	mov    %edi,%esi
  4221f4:	bf 00 00 00 00       	mov    $0x0,%edi
  4221f9:	e8 8e fd ff ff       	callq  421f8c <notify_server>
  4221fe:	48 83 c4 08          	add    $0x8,%rsp
  422202:	c3                   	retq   

0000000000422203 <bushandler>:
  422203:	48 83 ec 08          	sub    $0x8,%rsp
  422207:	83 3d fa 32 20 00 00 	cmpl   $0x0,0x2032fa(%rip)        # 625508 <is_checker>
  42220e:	74 14                	je     422224 <bushandler+0x21>
  422210:	bf 95 37 42 00       	mov    $0x423795,%edi
  422215:	e8 36 ea fd ff       	callq  400c50 <puts@plt>
  42221a:	b8 00 00 00 00       	mov    $0x0,%eax
  42221f:	e8 e7 fc ff ff       	callq  421f0b <check_fail>
  422224:	bf 00 39 42 00       	mov    $0x423900,%edi
  422229:	e8 22 ea fd ff       	callq  400c50 <puts@plt>
  42222e:	bf 9f 37 42 00       	mov    $0x42379f,%edi
  422233:	e8 18 ea fd ff       	callq  400c50 <puts@plt>
  422238:	be 00 00 00 00       	mov    $0x0,%esi
  42223d:	bf 00 00 00 00       	mov    $0x0,%edi
  422242:	e8 45 fd ff ff       	callq  421f8c <notify_server>
  422247:	bf 01 00 00 00       	mov    $0x1,%edi
  42224c:	e8 9f eb fd ff       	callq  400df0 <exit@plt>

0000000000422251 <seghandler>:
  422251:	48 83 ec 08          	sub    $0x8,%rsp
  422255:	83 3d ac 32 20 00 00 	cmpl   $0x0,0x2032ac(%rip)        # 625508 <is_checker>
  42225c:	74 14                	je     422272 <seghandler+0x21>
  42225e:	bf b5 37 42 00       	mov    $0x4237b5,%edi
  422263:	e8 e8 e9 fd ff       	callq  400c50 <puts@plt>
  422268:	b8 00 00 00 00       	mov    $0x0,%eax
  42226d:	e8 99 fc ff ff       	callq  421f0b <check_fail>
  422272:	bf 20 39 42 00       	mov    $0x423920,%edi
  422277:	e8 d4 e9 fd ff       	callq  400c50 <puts@plt>
  42227c:	bf 9f 37 42 00       	mov    $0x42379f,%edi
  422281:	e8 ca e9 fd ff       	callq  400c50 <puts@plt>
  422286:	be 00 00 00 00       	mov    $0x0,%esi
  42228b:	bf 00 00 00 00       	mov    $0x0,%edi
  422290:	e8 f7 fc ff ff       	callq  421f8c <notify_server>
  422295:	bf 01 00 00 00       	mov    $0x1,%edi
  42229a:	e8 51 eb fd ff       	callq  400df0 <exit@plt>

000000000042229f <illegalhandler>:
  42229f:	48 83 ec 08          	sub    $0x8,%rsp
  4222a3:	83 3d 5e 32 20 00 00 	cmpl   $0x0,0x20325e(%rip)        # 625508 <is_checker>
  4222aa:	74 14                	je     4222c0 <illegalhandler+0x21>
  4222ac:	bf c8 37 42 00       	mov    $0x4237c8,%edi
  4222b1:	e8 9a e9 fd ff       	callq  400c50 <puts@plt>
  4222b6:	b8 00 00 00 00       	mov    $0x0,%eax
  4222bb:	e8 4b fc ff ff       	callq  421f0b <check_fail>
  4222c0:	bf 48 39 42 00       	mov    $0x423948,%edi
  4222c5:	e8 86 e9 fd ff       	callq  400c50 <puts@plt>
  4222ca:	bf 9f 37 42 00       	mov    $0x42379f,%edi
  4222cf:	e8 7c e9 fd ff       	callq  400c50 <puts@plt>
  4222d4:	be 00 00 00 00       	mov    $0x0,%esi
  4222d9:	bf 00 00 00 00       	mov    $0x0,%edi
  4222de:	e8 a9 fc ff ff       	callq  421f8c <notify_server>
  4222e3:	bf 01 00 00 00       	mov    $0x1,%edi
  4222e8:	e8 03 eb fd ff       	callq  400df0 <exit@plt>

00000000004222ed <sigalrmhandler>:
  4222ed:	48 83 ec 08          	sub    $0x8,%rsp
  4222f1:	83 3d 10 32 20 00 00 	cmpl   $0x0,0x203210(%rip)        # 625508 <is_checker>
  4222f8:	74 14                	je     42230e <sigalrmhandler+0x21>
  4222fa:	bf dc 37 42 00       	mov    $0x4237dc,%edi
  4222ff:	e8 4c e9 fd ff       	callq  400c50 <puts@plt>
  422304:	b8 00 00 00 00       	mov    $0x0,%eax
  422309:	e8 fd fb ff ff       	callq  421f0b <check_fail>
  42230e:	be 05 00 00 00       	mov    $0x5,%esi
  422313:	bf 78 39 42 00       	mov    $0x423978,%edi
  422318:	b8 00 00 00 00       	mov    $0x0,%eax
  42231d:	e8 5e e9 fd ff       	callq  400c80 <printf@plt>
  422322:	be 00 00 00 00       	mov    $0x0,%esi
  422327:	bf 00 00 00 00       	mov    $0x0,%edi
  42232c:	e8 5b fc ff ff       	callq  421f8c <notify_server>
  422331:	bf 01 00 00 00       	mov    $0x1,%edi
  422336:	e8 b5 ea fd ff       	callq  400df0 <exit@plt>

000000000042233b <launch>:
  42233b:	55                   	push   %rbp
  42233c:	48 89 e5             	mov    %rsp,%rbp
  42233f:	48 89 fa             	mov    %rdi,%rdx
  422342:	48 8d 47 1e          	lea    0x1e(%rdi),%rax
  422346:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  42234a:	48 29 c4             	sub    %rax,%rsp
  42234d:	48 8d 7c 24 0f       	lea    0xf(%rsp),%rdi
  422352:	48 83 e7 f0          	and    $0xfffffffffffffff0,%rdi
  422356:	be f4 00 00 00       	mov    $0xf4,%esi
  42235b:	e8 30 e9 fd ff       	callq  400c90 <memset@plt>
  422360:	48 8b 05 59 31 20 00 	mov    0x203159(%rip),%rax        # 6254c0 <stdin@@GLIBC_2.2.5>
  422367:	48 39 05 82 31 20 00 	cmp    %rax,0x203182(%rip)        # 6254f0 <infile>
  42236e:	75 0f                	jne    42237f <launch+0x44>
  422370:	bf e4 37 42 00       	mov    $0x4237e4,%edi
  422375:	b8 00 00 00 00       	mov    $0x0,%eax
  42237a:	e8 01 e9 fd ff       	callq  400c80 <printf@plt>
  42237f:	c7 05 73 31 20 00 00 	movl   $0x0,0x203173(%rip)        # 6254fc <vlevel>
  422386:	00 00 00 
  422389:	b8 00 00 00 00       	mov    $0x0,%eax
  42238e:	e8 bf f9 ff ff       	callq  421d52 <test>
  422393:	83 3d 6e 31 20 00 00 	cmpl   $0x0,0x20316e(%rip)        # 625508 <is_checker>
  42239a:	74 14                	je     4223b0 <launch+0x75>
  42239c:	bf f1 37 42 00       	mov    $0x4237f1,%edi
  4223a1:	e8 aa e8 fd ff       	callq  400c50 <puts@plt>
  4223a6:	b8 00 00 00 00       	mov    $0x0,%eax
  4223ab:	e8 5b fb ff ff       	callq  421f0b <check_fail>
  4223b0:	bf fc 37 42 00       	mov    $0x4237fc,%edi
  4223b5:	e8 96 e8 fd ff       	callq  400c50 <puts@plt>
  4223ba:	c9                   	leaveq 
  4223bb:	c3                   	retq   

00000000004223bc <stable_launch>:
  4223bc:	53                   	push   %rbx
  4223bd:	48 89 3d 24 31 20 00 	mov    %rdi,0x203124(%rip)        # 6254e8 <global_offset>
  4223c4:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  4223ca:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  4223d0:	b9 32 01 00 00       	mov    $0x132,%ecx
  4223d5:	ba 07 00 00 00       	mov    $0x7,%edx
  4223da:	be 00 00 10 00       	mov    $0x100000,%esi
  4223df:	bf 00 60 58 55       	mov    $0x55586000,%edi
  4223e4:	e8 87 e8 fd ff       	callq  400c70 <mmap@plt>
  4223e9:	48 89 c3             	mov    %rax,%rbx
  4223ec:	48 3d 00 60 58 55    	cmp    $0x55586000,%rax
  4223f2:	74 32                	je     422426 <stable_launch+0x6a>
  4223f4:	be 00 00 10 00       	mov    $0x100000,%esi
  4223f9:	48 89 c7             	mov    %rax,%rdi
  4223fc:	e8 7f e9 fd ff       	callq  400d80 <munmap@plt>
  422401:	ba 00 60 58 55       	mov    $0x55586000,%edx
  422406:	be b0 39 42 00       	mov    $0x4239b0,%esi
  42240b:	48 8b 3d be 30 20 00 	mov    0x2030be(%rip),%rdi        # 6254d0 <stderr@@GLIBC_2.2.5>
  422412:	b8 00 00 00 00       	mov    $0x0,%eax
  422417:	e8 e4 e8 fd ff       	callq  400d00 <fprintf@plt>
  42241c:	bf 01 00 00 00       	mov    $0x1,%edi
  422421:	e8 ca e9 fd ff       	callq  400df0 <exit@plt>
  422426:	48 8d 90 f8 ff 0f 00 	lea    0xffff8(%rax),%rdx
  42242d:	48 89 15 fc 3c 20 00 	mov    %rdx,0x203cfc(%rip)        # 626130 <stack_top>
  422434:	48 89 e0             	mov    %rsp,%rax
  422437:	48 89 d4             	mov    %rdx,%rsp
  42243a:	48 89 c2             	mov    %rax,%rdx
  42243d:	48 89 15 9c 30 20 00 	mov    %rdx,0x20309c(%rip)        # 6254e0 <global_save_stack>
  422444:	48 8b 3d 9d 30 20 00 	mov    0x20309d(%rip),%rdi        # 6254e8 <global_offset>
  42244b:	e8 eb fe ff ff       	callq  42233b <launch>
  422450:	48 8b 05 89 30 20 00 	mov    0x203089(%rip),%rax        # 6254e0 <global_save_stack>
  422457:	48 89 c4             	mov    %rax,%rsp
  42245a:	be 00 00 10 00       	mov    $0x100000,%esi
  42245f:	48 89 df             	mov    %rbx,%rdi
  422462:	e8 19 e9 fd ff       	callq  400d80 <munmap@plt>
  422467:	5b                   	pop    %rbx
  422468:	c3                   	retq   
  422469:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000422470 <rio_readinitb>:
  422470:	89 37                	mov    %esi,(%rdi)
  422472:	c7 47 04 00 00 00 00 	movl   $0x0,0x4(%rdi)
  422479:	48 8d 47 10          	lea    0x10(%rdi),%rax
  42247d:	48 89 47 08          	mov    %rax,0x8(%rdi)
  422481:	c3                   	retq   

0000000000422482 <sigalrm_handler>:
  422482:	48 83 ec 08          	sub    $0x8,%rsp
  422486:	ba 00 00 00 00       	mov    $0x0,%edx
  42248b:	be f0 39 42 00       	mov    $0x4239f0,%esi
  422490:	48 8b 3d 39 30 20 00 	mov    0x203039(%rip),%rdi        # 6254d0 <stderr@@GLIBC_2.2.5>
  422497:	b8 00 00 00 00       	mov    $0x0,%eax
  42249c:	e8 5f e8 fd ff       	callq  400d00 <fprintf@plt>
  4224a1:	bf 01 00 00 00       	mov    $0x1,%edi
  4224a6:	e8 45 e9 fd ff       	callq  400df0 <exit@plt>

00000000004224ab <urlencode>:
  4224ab:	41 54                	push   %r12
  4224ad:	55                   	push   %rbp
  4224ae:	53                   	push   %rbx
  4224af:	48 83 ec 10          	sub    $0x10,%rsp
  4224b3:	48 89 fb             	mov    %rdi,%rbx
  4224b6:	48 89 f5             	mov    %rsi,%rbp
  4224b9:	b8 00 00 00 00       	mov    $0x0,%eax
  4224be:	48 c7 c1 ff ff ff ff 	mov    $0xffffffffffffffff,%rcx
  4224c5:	f2 ae                	repnz scas %es:(%rdi),%al
  4224c7:	48 f7 d1             	not    %rcx
  4224ca:	8d 41 ff             	lea    -0x1(%rcx),%eax
  4224cd:	e9 93 00 00 00       	jmpq   422565 <urlencode+0xba>
  4224d2:	0f b6 13             	movzbl (%rbx),%edx
  4224d5:	80 fa 2a             	cmp    $0x2a,%dl
  4224d8:	0f 94 c1             	sete   %cl
  4224db:	80 fa 2d             	cmp    $0x2d,%dl
  4224de:	0f 94 c0             	sete   %al
  4224e1:	08 c1                	or     %al,%cl
  4224e3:	75 1f                	jne    422504 <urlencode+0x59>
  4224e5:	80 fa 2e             	cmp    $0x2e,%dl
  4224e8:	74 1a                	je     422504 <urlencode+0x59>
  4224ea:	80 fa 5f             	cmp    $0x5f,%dl
  4224ed:	74 15                	je     422504 <urlencode+0x59>
  4224ef:	8d 42 d0             	lea    -0x30(%rdx),%eax
  4224f2:	3c 09                	cmp    $0x9,%al
  4224f4:	76 0e                	jbe    422504 <urlencode+0x59>
  4224f6:	8d 42 bf             	lea    -0x41(%rdx),%eax
  4224f9:	3c 19                	cmp    $0x19,%al
  4224fb:	76 07                	jbe    422504 <urlencode+0x59>
  4224fd:	8d 42 9f             	lea    -0x61(%rdx),%eax
  422500:	3c 19                	cmp    $0x19,%al
  422502:	77 09                	ja     42250d <urlencode+0x62>
  422504:	88 55 00             	mov    %dl,0x0(%rbp)
  422507:	48 8d 6d 01          	lea    0x1(%rbp),%rbp
  42250b:	eb 51                	jmp    42255e <urlencode+0xb3>
  42250d:	80 fa 20             	cmp    $0x20,%dl
  422510:	75 0a                	jne    42251c <urlencode+0x71>
  422512:	c6 45 00 2b          	movb   $0x2b,0x0(%rbp)
  422516:	48 8d 6d 01          	lea    0x1(%rbp),%rbp
  42251a:	eb 42                	jmp    42255e <urlencode+0xb3>
  42251c:	8d 42 e0             	lea    -0x20(%rdx),%eax
  42251f:	3c 5f                	cmp    $0x5f,%al
  422521:	0f 96 c1             	setbe  %cl
  422524:	80 fa 09             	cmp    $0x9,%dl
  422527:	0f 94 c0             	sete   %al
  42252a:	08 c1                	or     %al,%cl
  42252c:	74 45                	je     422573 <urlencode+0xc8>
  42252e:	0f b6 d2             	movzbl %dl,%edx
  422531:	be a8 3a 42 00       	mov    $0x423aa8,%esi
  422536:	48 89 e7             	mov    %rsp,%rdi
  422539:	b8 00 00 00 00       	mov    $0x0,%eax
  42253e:	e8 9d e8 fd ff       	callq  400de0 <sprintf@plt>
  422543:	0f b6 04 24          	movzbl (%rsp),%eax
  422547:	88 45 00             	mov    %al,0x0(%rbp)
  42254a:	0f b6 44 24 01       	movzbl 0x1(%rsp),%eax
  42254f:	88 45 01             	mov    %al,0x1(%rbp)
  422552:	0f b6 44 24 02       	movzbl 0x2(%rsp),%eax
  422557:	88 45 02             	mov    %al,0x2(%rbp)
  42255a:	48 8d 6d 03          	lea    0x3(%rbp),%rbp
  42255e:	48 83 c3 01          	add    $0x1,%rbx
  422562:	44 89 e0             	mov    %r12d,%eax
  422565:	44 8d 60 ff          	lea    -0x1(%rax),%r12d
  422569:	85 c0                	test   %eax,%eax
  42256b:	0f 85 61 ff ff ff    	jne    4224d2 <urlencode+0x27>
  422571:	eb 05                	jmp    422578 <urlencode+0xcd>
  422573:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  422578:	48 83 c4 10          	add    $0x10,%rsp
  42257c:	5b                   	pop    %rbx
  42257d:	5d                   	pop    %rbp
  42257e:	41 5c                	pop    %r12
  422580:	c3                   	retq   

0000000000422581 <rio_writen>:
  422581:	41 55                	push   %r13
  422583:	41 54                	push   %r12
  422585:	55                   	push   %rbp
  422586:	53                   	push   %rbx
  422587:	48 83 ec 08          	sub    $0x8,%rsp
  42258b:	41 89 fc             	mov    %edi,%r12d
  42258e:	48 89 f5             	mov    %rsi,%rbp
  422591:	49 89 d5             	mov    %rdx,%r13
  422594:	48 89 d3             	mov    %rdx,%rbx
  422597:	eb 28                	jmp    4225c1 <rio_writen+0x40>
  422599:	48 89 da             	mov    %rbx,%rdx
  42259c:	48 89 ee             	mov    %rbp,%rsi
  42259f:	44 89 e7             	mov    %r12d,%edi
  4225a2:	e8 b9 e6 fd ff       	callq  400c60 <write@plt>
  4225a7:	48 85 c0             	test   %rax,%rax
  4225aa:	7f 0f                	jg     4225bb <rio_writen+0x3a>
  4225ac:	e8 5f e6 fd ff       	callq  400c10 <__errno_location@plt>
  4225b1:	83 38 04             	cmpl   $0x4,(%rax)
  4225b4:	75 15                	jne    4225cb <rio_writen+0x4a>
  4225b6:	b8 00 00 00 00       	mov    $0x0,%eax
  4225bb:	48 29 c3             	sub    %rax,%rbx
  4225be:	48 01 c5             	add    %rax,%rbp
  4225c1:	48 85 db             	test   %rbx,%rbx
  4225c4:	75 d3                	jne    422599 <rio_writen+0x18>
  4225c6:	4c 89 e8             	mov    %r13,%rax
  4225c9:	eb 07                	jmp    4225d2 <rio_writen+0x51>
  4225cb:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  4225d2:	48 83 c4 08          	add    $0x8,%rsp
  4225d6:	5b                   	pop    %rbx
  4225d7:	5d                   	pop    %rbp
  4225d8:	41 5c                	pop    %r12
  4225da:	41 5d                	pop    %r13
  4225dc:	c3                   	retq   

00000000004225dd <rio_read>:
  4225dd:	41 56                	push   %r14
  4225df:	41 55                	push   %r13
  4225e1:	41 54                	push   %r12
  4225e3:	55                   	push   %rbp
  4225e4:	53                   	push   %rbx
  4225e5:	48 89 fb             	mov    %rdi,%rbx
  4225e8:	49 89 f6             	mov    %rsi,%r14
  4225eb:	49 89 d5             	mov    %rdx,%r13
  4225ee:	4c 8d 67 10          	lea    0x10(%rdi),%r12
  4225f2:	eb 2a                	jmp    42261e <rio_read+0x41>
  4225f4:	ba 00 20 00 00       	mov    $0x2000,%edx
  4225f9:	4c 89 e6             	mov    %r12,%rsi
  4225fc:	8b 3b                	mov    (%rbx),%edi
  4225fe:	e8 bd e6 fd ff       	callq  400cc0 <read@plt>
  422603:	89 43 04             	mov    %eax,0x4(%rbx)
  422606:	85 c0                	test   %eax,%eax
  422608:	79 0c                	jns    422616 <rio_read+0x39>
  42260a:	e8 01 e6 fd ff       	callq  400c10 <__errno_location@plt>
  42260f:	83 38 04             	cmpl   $0x4,(%rax)
  422612:	74 0a                	je     42261e <rio_read+0x41>
  422614:	eb 37                	jmp    42264d <rio_read+0x70>
  422616:	85 c0                	test   %eax,%eax
  422618:	74 3c                	je     422656 <rio_read+0x79>
  42261a:	4c 89 63 08          	mov    %r12,0x8(%rbx)
  42261e:	8b 6b 04             	mov    0x4(%rbx),%ebp
  422621:	85 ed                	test   %ebp,%ebp
  422623:	7e cf                	jle    4225f4 <rio_read+0x17>
  422625:	89 e8                	mov    %ebp,%eax
  422627:	4c 39 e8             	cmp    %r13,%rax
  42262a:	72 03                	jb     42262f <rio_read+0x52>
  42262c:	44 89 ed             	mov    %r13d,%ebp
  42262f:	4c 63 e5             	movslq %ebp,%r12
  422632:	48 8b 73 08          	mov    0x8(%rbx),%rsi
  422636:	4c 89 e2             	mov    %r12,%rdx
  422639:	4c 89 f7             	mov    %r14,%rdi
  42263c:	e8 ef e6 fd ff       	callq  400d30 <memcpy@plt>
  422641:	4c 01 63 08          	add    %r12,0x8(%rbx)
  422645:	29 6b 04             	sub    %ebp,0x4(%rbx)
  422648:	4c 89 e0             	mov    %r12,%rax
  42264b:	eb 0e                	jmp    42265b <rio_read+0x7e>
  42264d:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  422654:	eb 05                	jmp    42265b <rio_read+0x7e>
  422656:	b8 00 00 00 00       	mov    $0x0,%eax
  42265b:	5b                   	pop    %rbx
  42265c:	5d                   	pop    %rbp
  42265d:	41 5c                	pop    %r12
  42265f:	41 5d                	pop    %r13
  422661:	41 5e                	pop    %r14
  422663:	c3                   	retq   

0000000000422664 <rio_readlineb>:
  422664:	41 55                	push   %r13
  422666:	41 54                	push   %r12
  422668:	55                   	push   %rbp
  422669:	53                   	push   %rbx
  42266a:	48 83 ec 18          	sub    $0x18,%rsp
  42266e:	49 89 fd             	mov    %rdi,%r13
  422671:	48 89 f5             	mov    %rsi,%rbp
  422674:	49 89 d4             	mov    %rdx,%r12
  422677:	bb 01 00 00 00       	mov    $0x1,%ebx
  42267c:	eb 3d                	jmp    4226bb <rio_readlineb+0x57>
  42267e:	ba 01 00 00 00       	mov    $0x1,%edx
  422683:	48 8d 74 24 0f       	lea    0xf(%rsp),%rsi
  422688:	4c 89 ef             	mov    %r13,%rdi
  42268b:	e8 4d ff ff ff       	callq  4225dd <rio_read>
  422690:	83 f8 01             	cmp    $0x1,%eax
  422693:	75 12                	jne    4226a7 <rio_readlineb+0x43>
  422695:	48 8d 55 01          	lea    0x1(%rbp),%rdx
  422699:	0f b6 44 24 0f       	movzbl 0xf(%rsp),%eax
  42269e:	88 45 00             	mov    %al,0x0(%rbp)
  4226a1:	3c 0a                	cmp    $0xa,%al
  4226a3:	75 0f                	jne    4226b4 <rio_readlineb+0x50>
  4226a5:	eb 1b                	jmp    4226c2 <rio_readlineb+0x5e>
  4226a7:	85 c0                	test   %eax,%eax
  4226a9:	75 23                	jne    4226ce <rio_readlineb+0x6a>
  4226ab:	48 83 fb 01          	cmp    $0x1,%rbx
  4226af:	90                   	nop
  4226b0:	75 13                	jne    4226c5 <rio_readlineb+0x61>
  4226b2:	eb 23                	jmp    4226d7 <rio_readlineb+0x73>
  4226b4:	48 83 c3 01          	add    $0x1,%rbx
  4226b8:	48 89 d5             	mov    %rdx,%rbp
  4226bb:	4c 39 e3             	cmp    %r12,%rbx
  4226be:	72 be                	jb     42267e <rio_readlineb+0x1a>
  4226c0:	eb 03                	jmp    4226c5 <rio_readlineb+0x61>
  4226c2:	48 89 d5             	mov    %rdx,%rbp
  4226c5:	c6 45 00 00          	movb   $0x0,0x0(%rbp)
  4226c9:	48 89 d8             	mov    %rbx,%rax
  4226cc:	eb 0e                	jmp    4226dc <rio_readlineb+0x78>
  4226ce:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  4226d5:	eb 05                	jmp    4226dc <rio_readlineb+0x78>
  4226d7:	b8 00 00 00 00       	mov    $0x0,%eax
  4226dc:	48 83 c4 18          	add    $0x18,%rsp
  4226e0:	5b                   	pop    %rbx
  4226e1:	5d                   	pop    %rbp
  4226e2:	41 5c                	pop    %r12
  4226e4:	41 5d                	pop    %r13
  4226e6:	c3                   	retq   

00000000004226e7 <submitr>:
  4226e7:	41 57                	push   %r15
  4226e9:	41 56                	push   %r14
  4226eb:	41 55                	push   %r13
  4226ed:	41 54                	push   %r12
  4226ef:	55                   	push   %rbp
  4226f0:	53                   	push   %rbx
  4226f1:	48 81 ec 58 a0 00 00 	sub    $0xa058,%rsp
  4226f8:	49 89 fc             	mov    %rdi,%r12
  4226fb:	89 74 24 1c          	mov    %esi,0x1c(%rsp)
  4226ff:	48 89 54 24 10       	mov    %rdx,0x10(%rsp)
  422704:	49 89 cf             	mov    %rcx,%r15
  422707:	4d 89 c6             	mov    %r8,%r14
  42270a:	4d 89 cd             	mov    %r9,%r13
  42270d:	48 8b 9c 24 90 a0 00 	mov    0xa090(%rsp),%rbx
  422714:	00 
  422715:	c7 84 24 2c 20 00 00 	movl   $0x0,0x202c(%rsp)
  42271c:	00 00 00 00 
  422720:	ba 00 00 00 00       	mov    $0x0,%edx
  422725:	be 01 00 00 00       	mov    $0x1,%esi
  42272a:	bf 02 00 00 00       	mov    $0x2,%edi
  42272f:	e8 dc e6 fd ff       	callq  400e10 <socket@plt>
  422734:	89 c5                	mov    %eax,%ebp
  422736:	85 c0                	test   %eax,%eax
  422738:	79 4e                	jns    422788 <submitr+0xa1>
  42273a:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
  422741:	3a 20 43 
  422744:	48 89 03             	mov    %rax,(%rbx)
  422747:	48 b8 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rax
  42274e:	20 75 6e 
  422751:	48 89 43 08          	mov    %rax,0x8(%rbx)
  422755:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  42275c:	74 6f 20 
  42275f:	48 89 43 10          	mov    %rax,0x10(%rbx)
  422763:	48 b8 63 72 65 61 74 	movabs $0x7320657461657263,%rax
  42276a:	65 20 73 
  42276d:	48 89 43 18          	mov    %rax,0x18(%rbx)
  422771:	c7 43 20 6f 63 6b 65 	movl   $0x656b636f,0x20(%rbx)
  422778:	66 c7 43 24 74 00    	movw   $0x74,0x24(%rbx)
  42277e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  422783:	e9 83 06 00 00       	jmpq   422e0b <submitr+0x724>
  422788:	4c 89 e7             	mov    %r12,%rdi
  42278b:	e8 60 e5 fd ff       	callq  400cf0 <gethostbyname@plt>
  422790:	48 85 c0             	test   %rax,%rax
  422793:	75 75                	jne    42280a <submitr+0x123>
  422795:	48 b8 45 72 72 6f 72 	movabs $0x44203a726f727245,%rax
  42279c:	3a 20 44 
  42279f:	48 89 03             	mov    %rax,(%rbx)
  4227a2:	48 b8 4e 53 20 69 73 	movabs $0x6e7520736920534e,%rax
  4227a9:	20 75 6e 
  4227ac:	48 89 43 08          	mov    %rax,0x8(%rbx)
  4227b0:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  4227b7:	74 6f 20 
  4227ba:	48 89 43 10          	mov    %rax,0x10(%rbx)
  4227be:	48 b8 72 65 73 6f 6c 	movabs $0x2065766c6f736572,%rax
  4227c5:	76 65 20 
  4227c8:	48 89 43 18          	mov    %rax,0x18(%rbx)
  4227cc:	48 b8 41 75 74 6f 6c 	movabs $0x2062616c6f747541,%rax
  4227d3:	61 62 20 
  4227d6:	48 89 43 20          	mov    %rax,0x20(%rbx)
  4227da:	48 b8 73 65 72 76 65 	movabs $0x6120726576726573,%rax
  4227e1:	72 20 61 
  4227e4:	48 89 43 28          	mov    %rax,0x28(%rbx)
  4227e8:	c7 43 30 64 64 72 65 	movl   $0x65726464,0x30(%rbx)
  4227ef:	66 c7 43 34 73 73    	movw   $0x7373,0x34(%rbx)
  4227f5:	c6 43 36 00          	movb   $0x0,0x36(%rbx)
  4227f9:	89 ef                	mov    %ebp,%edi
  4227fb:	e8 b0 e4 fd ff       	callq  400cb0 <close@plt>
  422800:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  422805:	e9 01 06 00 00       	jmpq   422e0b <submitr+0x724>
  42280a:	48 c7 84 24 40 a0 00 	movq   $0x0,0xa040(%rsp)
  422811:	00 00 00 00 00 
  422816:	48 c7 84 24 48 a0 00 	movq   $0x0,0xa048(%rsp)
  42281d:	00 00 00 00 00 
  422822:	66 c7 84 24 40 a0 00 	movw   $0x2,0xa040(%rsp)
  422829:	00 02 00 
  42282c:	48 8b 48 18          	mov    0x18(%rax),%rcx
  422830:	48 63 50 14          	movslq 0x14(%rax),%rdx
  422834:	48 8d b4 24 44 a0 00 	lea    0xa044(%rsp),%rsi
  42283b:	00 
  42283c:	48 8b 39             	mov    (%rcx),%rdi
  42283f:	e8 4c e5 fd ff       	callq  400d90 <bcopy@plt>
  422844:	0f b7 44 24 1c       	movzwl 0x1c(%rsp),%eax
  422849:	66 c1 c8 08          	ror    $0x8,%ax
  42284d:	66 89 84 24 42 a0 00 	mov    %ax,0xa042(%rsp)
  422854:	00 
  422855:	ba 10 00 00 00       	mov    $0x10,%edx
  42285a:	48 8d b4 24 40 a0 00 	lea    0xa040(%rsp),%rsi
  422861:	00 
  422862:	89 ef                	mov    %ebp,%edi
  422864:	e8 97 e5 fd ff       	callq  400e00 <connect@plt>
  422869:	85 c0                	test   %eax,%eax
  42286b:	79 67                	jns    4228d4 <submitr+0x1ed>
  42286d:	48 b8 45 72 72 6f 72 	movabs $0x55203a726f727245,%rax
  422874:	3a 20 55 
  422877:	48 89 03             	mov    %rax,(%rbx)
  42287a:	48 b8 6e 61 62 6c 65 	movabs $0x6f7420656c62616e,%rax
  422881:	20 74 6f 
  422884:	48 89 43 08          	mov    %rax,0x8(%rbx)
  422888:	48 b8 20 63 6f 6e 6e 	movabs $0x7463656e6e6f6320,%rax
  42288f:	65 63 74 
  422892:	48 89 43 10          	mov    %rax,0x10(%rbx)
  422896:	48 b8 20 74 6f 20 74 	movabs $0x20656874206f7420,%rax
  42289d:	68 65 20 
  4228a0:	48 89 43 18          	mov    %rax,0x18(%rbx)
  4228a4:	48 b8 41 75 74 6f 6c 	movabs $0x2062616c6f747541,%rax
  4228ab:	61 62 20 
  4228ae:	48 89 43 20          	mov    %rax,0x20(%rbx)
  4228b2:	c7 43 28 73 65 72 76 	movl   $0x76726573,0x28(%rbx)
  4228b9:	66 c7 43 2c 65 72    	movw   $0x7265,0x2c(%rbx)
  4228bf:	c6 43 2e 00          	movb   $0x0,0x2e(%rbx)
  4228c3:	89 ef                	mov    %ebp,%edi
  4228c5:	e8 e6 e3 fd ff       	callq  400cb0 <close@plt>
  4228ca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  4228cf:	e9 37 05 00 00       	jmpq   422e0b <submitr+0x724>
  4228d4:	48 c7 c2 ff ff ff ff 	mov    $0xffffffffffffffff,%rdx
  4228db:	4c 89 ef             	mov    %r13,%rdi
  4228de:	b8 00 00 00 00       	mov    $0x0,%eax
  4228e3:	48 89 d1             	mov    %rdx,%rcx
  4228e6:	f2 ae                	repnz scas %es:(%rdi),%al
  4228e8:	48 f7 d1             	not    %rcx
  4228eb:	48 89 ce             	mov    %rcx,%rsi
  4228ee:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
  4228f3:	48 89 d1             	mov    %rdx,%rcx
  4228f6:	f2 ae                	repnz scas %es:(%rdi),%al
  4228f8:	48 f7 d1             	not    %rcx
  4228fb:	49 89 c8             	mov    %rcx,%r8
  4228fe:	4c 89 ff             	mov    %r15,%rdi
  422901:	48 89 d1             	mov    %rdx,%rcx
  422904:	f2 ae                	repnz scas %es:(%rdi),%al
  422906:	49 29 c8             	sub    %rcx,%r8
  422909:	4c 89 f7             	mov    %r14,%rdi
  42290c:	48 89 d1             	mov    %rdx,%rcx
  42290f:	f2 ae                	repnz scas %es:(%rdi),%al
  422911:	49 29 c8             	sub    %rcx,%r8
  422914:	48 8d 44 76 fd       	lea    -0x3(%rsi,%rsi,2),%rax
  422919:	49 8d 44 00 7b       	lea    0x7b(%r8,%rax,1),%rax
  42291e:	48 3d 00 20 00 00    	cmp    $0x2000,%rax
  422924:	76 72                	jbe    422998 <submitr+0x2b1>
  422926:	48 b8 45 72 72 6f 72 	movabs $0x52203a726f727245,%rax
  42292d:	3a 20 52 
  422930:	48 89 03             	mov    %rax,(%rbx)
  422933:	48 b8 65 73 75 6c 74 	movabs $0x747320746c757365,%rax
  42293a:	20 73 74 
  42293d:	48 89 43 08          	mov    %rax,0x8(%rbx)
  422941:	48 b8 72 69 6e 67 20 	movabs $0x6f6f7420676e6972,%rax
  422948:	74 6f 6f 
  42294b:	48 89 43 10          	mov    %rax,0x10(%rbx)
  42294f:	48 b8 20 6c 61 72 67 	movabs $0x202e656772616c20,%rax
  422956:	65 2e 20 
  422959:	48 89 43 18          	mov    %rax,0x18(%rbx)
  42295d:	48 b8 49 6e 63 72 65 	movabs $0x6573616572636e49,%rax
  422964:	61 73 65 
  422967:	48 89 43 20          	mov    %rax,0x20(%rbx)
  42296b:	48 b8 20 53 55 42 4d 	movabs $0x5254494d42555320,%rax
  422972:	49 54 52 
  422975:	48 89 43 28          	mov    %rax,0x28(%rbx)
  422979:	48 b8 5f 4d 41 58 42 	movabs $0x46554258414d5f,%rax
  422980:	55 46 00 
  422983:	48 89 43 30          	mov    %rax,0x30(%rbx)
  422987:	89 ef                	mov    %ebp,%edi
  422989:	e8 22 e3 fd ff       	callq  400cb0 <close@plt>
  42298e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  422993:	e9 73 04 00 00       	jmpq   422e0b <submitr+0x724>
  422998:	48 8d b4 24 30 40 00 	lea    0x4030(%rsp),%rsi
  42299f:	00 
  4229a0:	b9 00 04 00 00       	mov    $0x400,%ecx
  4229a5:	b8 00 00 00 00       	mov    $0x0,%eax
  4229aa:	48 89 f7             	mov    %rsi,%rdi
  4229ad:	f3 48 ab             	rep stos %rax,%es:(%rdi)
  4229b0:	4c 89 ef             	mov    %r13,%rdi
  4229b3:	e8 f3 fa ff ff       	callq  4224ab <urlencode>
  4229b8:	85 c0                	test   %eax,%eax
  4229ba:	0f 89 8a 00 00 00    	jns    422a4a <submitr+0x363>
  4229c0:	48 b8 45 72 72 6f 72 	movabs $0x52203a726f727245,%rax
  4229c7:	3a 20 52 
  4229ca:	48 89 03             	mov    %rax,(%rbx)
  4229cd:	48 b8 65 73 75 6c 74 	movabs $0x747320746c757365,%rax
  4229d4:	20 73 74 
  4229d7:	48 89 43 08          	mov    %rax,0x8(%rbx)
  4229db:	48 b8 72 69 6e 67 20 	movabs $0x6e6f6320676e6972,%rax
  4229e2:	63 6f 6e 
  4229e5:	48 89 43 10          	mov    %rax,0x10(%rbx)
  4229e9:	48 b8 74 61 69 6e 73 	movabs $0x6e6120736e696174,%rax
  4229f0:	20 61 6e 
  4229f3:	48 89 43 18          	mov    %rax,0x18(%rbx)
  4229f7:	48 b8 20 69 6c 6c 65 	movabs $0x6c6167656c6c6920,%rax
  4229fe:	67 61 6c 
  422a01:	48 89 43 20          	mov    %rax,0x20(%rbx)
  422a05:	48 b8 20 6f 72 20 75 	movabs $0x72706e7520726f20,%rax
  422a0c:	6e 70 72 
  422a0f:	48 89 43 28          	mov    %rax,0x28(%rbx)
  422a13:	48 b8 69 6e 74 61 62 	movabs $0x20656c6261746e69,%rax
  422a1a:	6c 65 20 
  422a1d:	48 89 43 30          	mov    %rax,0x30(%rbx)
  422a21:	48 b8 63 68 61 72 61 	movabs $0x6574636172616863,%rax
  422a28:	63 74 65 
  422a2b:	48 89 43 38          	mov    %rax,0x38(%rbx)
  422a2f:	66 c7 43 40 72 2e    	movw   $0x2e72,0x40(%rbx)
  422a35:	c6 43 42 00          	movb   $0x0,0x42(%rbx)
  422a39:	89 ef                	mov    %ebp,%edi
  422a3b:	e8 70 e2 fd ff       	callq  400cb0 <close@plt>
  422a40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  422a45:	e9 c1 03 00 00       	jmpq   422e0b <submitr+0x724>
  422a4a:	4c 89 24 24          	mov    %r12,(%rsp)
  422a4e:	4c 8d 8c 24 30 40 00 	lea    0x4030(%rsp),%r9
  422a55:	00 
  422a56:	4d 89 f8             	mov    %r15,%r8
  422a59:	4c 89 f1             	mov    %r14,%rcx
  422a5c:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
  422a61:	be 18 3a 42 00       	mov    $0x423a18,%esi
  422a66:	48 8d bc 24 30 60 00 	lea    0x6030(%rsp),%rdi
  422a6d:	00 
  422a6e:	b8 00 00 00 00       	mov    $0x0,%eax
  422a73:	e8 68 e3 fd ff       	callq  400de0 <sprintf@plt>
  422a78:	48 8d bc 24 30 60 00 	lea    0x6030(%rsp),%rdi
  422a7f:	00 
  422a80:	b8 00 00 00 00       	mov    $0x0,%eax
  422a85:	48 c7 c1 ff ff ff ff 	mov    $0xffffffffffffffff,%rcx
  422a8c:	f2 ae                	repnz scas %es:(%rdi),%al
  422a8e:	48 f7 d1             	not    %rcx
  422a91:	48 8d 51 ff          	lea    -0x1(%rcx),%rdx
  422a95:	48 8d b4 24 30 60 00 	lea    0x6030(%rsp),%rsi
  422a9c:	00 
  422a9d:	89 ef                	mov    %ebp,%edi
  422a9f:	e8 dd fa ff ff       	callq  422581 <rio_writen>
  422aa4:	48 85 c0             	test   %rax,%rax
  422aa7:	79 6b                	jns    422b14 <submitr+0x42d>
  422aa9:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
  422ab0:	3a 20 43 
  422ab3:	48 89 03             	mov    %rax,(%rbx)
  422ab6:	48 b8 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rax
  422abd:	20 75 6e 
  422ac0:	48 89 43 08          	mov    %rax,0x8(%rbx)
  422ac4:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  422acb:	74 6f 20 
  422ace:	48 89 43 10          	mov    %rax,0x10(%rbx)
  422ad2:	48 b8 77 72 69 74 65 	movabs $0x6f74206574697277,%rax
  422ad9:	20 74 6f 
  422adc:	48 89 43 18          	mov    %rax,0x18(%rbx)
  422ae0:	48 b8 20 74 68 65 20 	movabs $0x7475412065687420,%rax
  422ae7:	41 75 74 
  422aea:	48 89 43 20          	mov    %rax,0x20(%rbx)
  422aee:	48 b8 6f 6c 61 62 20 	movabs $0x7265732062616c6f,%rax
  422af5:	73 65 72 
  422af8:	48 89 43 28          	mov    %rax,0x28(%rbx)
  422afc:	c7 43 30 76 65 72 00 	movl   $0x726576,0x30(%rbx)
  422b03:	89 ef                	mov    %ebp,%edi
  422b05:	e8 a6 e1 fd ff       	callq  400cb0 <close@plt>
  422b0a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  422b0f:	e9 f7 02 00 00       	jmpq   422e0b <submitr+0x724>
  422b14:	89 ee                	mov    %ebp,%esi
  422b16:	48 8d bc 24 30 80 00 	lea    0x8030(%rsp),%rdi
  422b1d:	00 
  422b1e:	e8 4d f9 ff ff       	callq  422470 <rio_readinitb>
  422b23:	ba 00 20 00 00       	mov    $0x2000,%edx
  422b28:	48 8d b4 24 30 60 00 	lea    0x6030(%rsp),%rsi
  422b2f:	00 
  422b30:	48 8d bc 24 30 80 00 	lea    0x8030(%rsp),%rdi
  422b37:	00 
  422b38:	e8 27 fb ff ff       	callq  422664 <rio_readlineb>
  422b3d:	48 85 c0             	test   %rax,%rax
  422b40:	7f 7f                	jg     422bc1 <submitr+0x4da>
  422b42:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
  422b49:	3a 20 43 
  422b4c:	48 89 03             	mov    %rax,(%rbx)
  422b4f:	48 b8 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rax
  422b56:	20 75 6e 
  422b59:	48 89 43 08          	mov    %rax,0x8(%rbx)
  422b5d:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  422b64:	74 6f 20 
  422b67:	48 89 43 10          	mov    %rax,0x10(%rbx)
  422b6b:	48 b8 72 65 61 64 20 	movabs $0x7269662064616572,%rax
  422b72:	66 69 72 
  422b75:	48 89 43 18          	mov    %rax,0x18(%rbx)
  422b79:	48 b8 73 74 20 68 65 	movabs $0x6564616568207473,%rax
  422b80:	61 64 65 
  422b83:	48 89 43 20          	mov    %rax,0x20(%rbx)
  422b87:	48 b8 72 20 66 72 6f 	movabs $0x41206d6f72662072,%rax
  422b8e:	6d 20 41 
  422b91:	48 89 43 28          	mov    %rax,0x28(%rbx)
  422b95:	48 b8 75 74 6f 6c 61 	movabs $0x732062616c6f7475,%rax
  422b9c:	62 20 73 
  422b9f:	48 89 43 30          	mov    %rax,0x30(%rbx)
  422ba3:	c7 43 38 65 72 76 65 	movl   $0x65767265,0x38(%rbx)
  422baa:	66 c7 43 3c 72 00    	movw   $0x72,0x3c(%rbx)
  422bb0:	89 ef                	mov    %ebp,%edi
  422bb2:	e8 f9 e0 fd ff       	callq  400cb0 <close@plt>
  422bb7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  422bbc:	e9 4a 02 00 00       	jmpq   422e0b <submitr+0x724>
  422bc1:	4c 8d 44 24 20       	lea    0x20(%rsp),%r8
  422bc6:	48 8d 8c 24 2c 20 00 	lea    0x202c(%rsp),%rcx
  422bcd:	00 
  422bce:	48 8d 94 24 30 20 00 	lea    0x2030(%rsp),%rdx
  422bd5:	00 
  422bd6:	be af 3a 42 00       	mov    $0x423aaf,%esi
  422bdb:	48 8d bc 24 30 60 00 	lea    0x6030(%rsp),%rdi
  422be2:	00 
  422be3:	b8 00 00 00 00       	mov    $0x0,%eax
  422be8:	e8 83 e1 fd ff       	callq  400d70 <__isoc99_sscanf@plt>
  422bed:	e9 95 00 00 00       	jmpq   422c87 <submitr+0x5a0>
  422bf2:	ba 00 20 00 00       	mov    $0x2000,%edx
  422bf7:	48 8d b4 24 30 60 00 	lea    0x6030(%rsp),%rsi
  422bfe:	00 
  422bff:	48 8d bc 24 30 80 00 	lea    0x8030(%rsp),%rdi
  422c06:	00 
  422c07:	e8 58 fa ff ff       	callq  422664 <rio_readlineb>
  422c0c:	48 85 c0             	test   %rax,%rax
  422c0f:	7f 76                	jg     422c87 <submitr+0x5a0>
  422c11:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
  422c18:	3a 20 43 
  422c1b:	48 89 03             	mov    %rax,(%rbx)
  422c1e:	48 b8 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rax
  422c25:	20 75 6e 
  422c28:	48 89 43 08          	mov    %rax,0x8(%rbx)
  422c2c:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  422c33:	74 6f 20 
  422c36:	48 89 43 10          	mov    %rax,0x10(%rbx)
  422c3a:	48 b8 72 65 61 64 20 	movabs $0x6165682064616572,%rax
  422c41:	68 65 61 
  422c44:	48 89 43 18          	mov    %rax,0x18(%rbx)
  422c48:	48 b8 64 65 72 73 20 	movabs $0x6f72662073726564,%rax
  422c4f:	66 72 6f 
  422c52:	48 89 43 20          	mov    %rax,0x20(%rbx)
  422c56:	48 b8 6d 20 41 75 74 	movabs $0x616c6f747541206d,%rax
  422c5d:	6f 6c 61 
  422c60:	48 89 43 28          	mov    %rax,0x28(%rbx)
  422c64:	48 b8 62 20 73 65 72 	movabs $0x7265767265732062,%rax
  422c6b:	76 65 72 
  422c6e:	48 89 43 30          	mov    %rax,0x30(%rbx)
  422c72:	c6 43 38 00          	movb   $0x0,0x38(%rbx)
  422c76:	89 ef                	mov    %ebp,%edi
  422c78:	e8 33 e0 fd ff       	callq  400cb0 <close@plt>
  422c7d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  422c82:	e9 84 01 00 00       	jmpq   422e0b <submitr+0x724>
  422c87:	0f b6 84 24 30 60 00 	movzbl 0x6030(%rsp),%eax
  422c8e:	00 
  422c8f:	83 e8 0d             	sub    $0xd,%eax
  422c92:	75 15                	jne    422ca9 <submitr+0x5c2>
  422c94:	0f b6 84 24 31 60 00 	movzbl 0x6031(%rsp),%eax
  422c9b:	00 
  422c9c:	83 e8 0a             	sub    $0xa,%eax
  422c9f:	75 08                	jne    422ca9 <submitr+0x5c2>
  422ca1:	0f b6 84 24 32 60 00 	movzbl 0x6032(%rsp),%eax
  422ca8:	00 
  422ca9:	85 c0                	test   %eax,%eax
  422cab:	0f 85 41 ff ff ff    	jne    422bf2 <submitr+0x50b>
  422cb1:	ba 00 20 00 00       	mov    $0x2000,%edx
  422cb6:	48 8d b4 24 30 60 00 	lea    0x6030(%rsp),%rsi
  422cbd:	00 
  422cbe:	48 8d bc 24 30 80 00 	lea    0x8030(%rsp),%rdi
  422cc5:	00 
  422cc6:	e8 99 f9 ff ff       	callq  422664 <rio_readlineb>
  422ccb:	48 85 c0             	test   %rax,%rax
  422cce:	0f 8f 80 00 00 00    	jg     422d54 <submitr+0x66d>
  422cd4:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
  422cdb:	3a 20 43 
  422cde:	48 89 03             	mov    %rax,(%rbx)
  422ce1:	48 b8 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rax
  422ce8:	20 75 6e 
  422ceb:	48 89 43 08          	mov    %rax,0x8(%rbx)
  422cef:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  422cf6:	74 6f 20 
  422cf9:	48 89 43 10          	mov    %rax,0x10(%rbx)
  422cfd:	48 b8 72 65 61 64 20 	movabs $0x6174732064616572,%rax
  422d04:	73 74 61 
  422d07:	48 89 43 18          	mov    %rax,0x18(%rbx)
  422d0b:	48 b8 74 75 73 20 6d 	movabs $0x7373656d20737574,%rax
  422d12:	65 73 73 
  422d15:	48 89 43 20          	mov    %rax,0x20(%rbx)
  422d19:	48 b8 61 67 65 20 66 	movabs $0x6d6f726620656761,%rax
  422d20:	72 6f 6d 
  422d23:	48 89 43 28          	mov    %rax,0x28(%rbx)
  422d27:	48 b8 20 41 75 74 6f 	movabs $0x62616c6f74754120,%rax
  422d2e:	6c 61 62 
  422d31:	48 89 43 30          	mov    %rax,0x30(%rbx)
  422d35:	48 b8 20 73 65 72 76 	movabs $0x72657672657320,%rax
  422d3c:	65 72 00 
  422d3f:	48 89 43 38          	mov    %rax,0x38(%rbx)
  422d43:	89 ef                	mov    %ebp,%edi
  422d45:	e8 66 df fd ff       	callq  400cb0 <close@plt>
  422d4a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  422d4f:	e9 b7 00 00 00       	jmpq   422e0b <submitr+0x724>
  422d54:	8b 94 24 2c 20 00 00 	mov    0x202c(%rsp),%edx
  422d5b:	81 fa c8 00 00 00    	cmp    $0xc8,%edx
  422d61:	74 28                	je     422d8b <submitr+0x6a4>
  422d63:	48 8d 4c 24 20       	lea    0x20(%rsp),%rcx
  422d68:	be 78 3a 42 00       	mov    $0x423a78,%esi
  422d6d:	48 89 df             	mov    %rbx,%rdi
  422d70:	b8 00 00 00 00       	mov    $0x0,%eax
  422d75:	e8 66 e0 fd ff       	callq  400de0 <sprintf@plt>
  422d7a:	89 ef                	mov    %ebp,%edi
  422d7c:	e8 2f df fd ff       	callq  400cb0 <close@plt>
  422d81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  422d86:	e9 80 00 00 00       	jmpq   422e0b <submitr+0x724>
  422d8b:	48 8d b4 24 30 60 00 	lea    0x6030(%rsp),%rsi
  422d92:	00 
  422d93:	48 89 df             	mov    %rbx,%rdi
  422d96:	e8 a5 de fd ff       	callq  400c40 <strcpy@plt>
  422d9b:	89 ef                	mov    %ebp,%edi
  422d9d:	e8 0e df fd ff       	callq  400cb0 <close@plt>
  422da2:	0f b6 03             	movzbl (%rbx),%eax
  422da5:	83 e8 4f             	sub    $0x4f,%eax
  422da8:	75 18                	jne    422dc2 <submitr+0x6db>
  422daa:	0f b6 53 01          	movzbl 0x1(%rbx),%edx
  422dae:	83 ea 4b             	sub    $0x4b,%edx
  422db1:	75 11                	jne    422dc4 <submitr+0x6dd>
  422db3:	0f b6 53 02          	movzbl 0x2(%rbx),%edx
  422db7:	83 ea 0a             	sub    $0xa,%edx
  422dba:	75 08                	jne    422dc4 <submitr+0x6dd>
  422dbc:	0f b6 53 03          	movzbl 0x3(%rbx),%edx
  422dc0:	eb 02                	jmp    422dc4 <submitr+0x6dd>
  422dc2:	89 c2                	mov    %eax,%edx
  422dc4:	85 d2                	test   %edx,%edx
  422dc6:	74 30                	je     422df8 <submitr+0x711>
  422dc8:	bf c0 3a 42 00       	mov    $0x423ac0,%edi
  422dcd:	b9 05 00 00 00       	mov    $0x5,%ecx
  422dd2:	48 89 de             	mov    %rbx,%rsi
  422dd5:	f3 a6                	repz cmpsb %es:(%rdi),%ds:(%rsi)
  422dd7:	0f 97 c1             	seta   %cl
  422dda:	0f 92 c2             	setb   %dl
  422ddd:	38 d1                	cmp    %dl,%cl
  422ddf:	74 1e                	je     422dff <submitr+0x718>
  422de1:	85 c0                	test   %eax,%eax
  422de3:	75 0d                	jne    422df2 <submitr+0x70b>
  422de5:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  422de9:	83 e8 4b             	sub    $0x4b,%eax
  422dec:	75 04                	jne    422df2 <submitr+0x70b>
  422dee:	0f b6 43 02          	movzbl 0x2(%rbx),%eax
  422df2:	85 c0                	test   %eax,%eax
  422df4:	75 10                	jne    422e06 <submitr+0x71f>
  422df6:	eb 13                	jmp    422e0b <submitr+0x724>
  422df8:	b8 00 00 00 00       	mov    $0x0,%eax
  422dfd:	eb 0c                	jmp    422e0b <submitr+0x724>
  422dff:	b8 00 00 00 00       	mov    $0x0,%eax
  422e04:	eb 05                	jmp    422e0b <submitr+0x724>
  422e06:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  422e0b:	48 81 c4 58 a0 00 00 	add    $0xa058,%rsp
  422e12:	5b                   	pop    %rbx
  422e13:	5d                   	pop    %rbp
  422e14:	41 5c                	pop    %r12
  422e16:	41 5d                	pop    %r13
  422e18:	41 5e                	pop    %r14
  422e1a:	41 5f                	pop    %r15
  422e1c:	c3                   	retq   

0000000000422e1d <init_timeout>:
  422e1d:	53                   	push   %rbx
  422e1e:	89 fb                	mov    %edi,%ebx
  422e20:	85 ff                	test   %edi,%edi
  422e22:	74 1f                	je     422e43 <init_timeout+0x26>
  422e24:	85 ff                	test   %edi,%edi
  422e26:	79 05                	jns    422e2d <init_timeout+0x10>
  422e28:	bb 00 00 00 00       	mov    $0x0,%ebx
  422e2d:	be 82 24 42 00       	mov    $0x422482,%esi
  422e32:	bf 0e 00 00 00       	mov    $0xe,%edi
  422e37:	e8 a4 de fd ff       	callq  400ce0 <signal@plt>
  422e3c:	89 df                	mov    %ebx,%edi
  422e3e:	e8 5d de fd ff       	callq  400ca0 <alarm@plt>
  422e43:	5b                   	pop    %rbx
  422e44:	c3                   	retq   

0000000000422e45 <init_driver>:
  422e45:	55                   	push   %rbp
  422e46:	53                   	push   %rbx
  422e47:	48 83 ec 18          	sub    $0x18,%rsp
  422e4b:	48 89 fd             	mov    %rdi,%rbp
  422e4e:	be 01 00 00 00       	mov    $0x1,%esi
  422e53:	bf 0d 00 00 00       	mov    $0xd,%edi
  422e58:	e8 83 de fd ff       	callq  400ce0 <signal@plt>
  422e5d:	be 01 00 00 00       	mov    $0x1,%esi
  422e62:	bf 1d 00 00 00       	mov    $0x1d,%edi
  422e67:	e8 74 de fd ff       	callq  400ce0 <signal@plt>
  422e6c:	be 01 00 00 00       	mov    $0x1,%esi
  422e71:	bf 1d 00 00 00       	mov    $0x1d,%edi
  422e76:	e8 65 de fd ff       	callq  400ce0 <signal@plt>
  422e7b:	ba 00 00 00 00       	mov    $0x0,%edx
  422e80:	be 01 00 00 00       	mov    $0x1,%esi
  422e85:	bf 02 00 00 00       	mov    $0x2,%edi
  422e8a:	e8 81 df fd ff       	callq  400e10 <socket@plt>
  422e8f:	89 c3                	mov    %eax,%ebx
  422e91:	85 c0                	test   %eax,%eax
  422e93:	79 4f                	jns    422ee4 <init_driver+0x9f>
  422e95:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
  422e9c:	3a 20 43 
  422e9f:	48 89 45 00          	mov    %rax,0x0(%rbp)
  422ea3:	48 b8 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rax
  422eaa:	20 75 6e 
  422ead:	48 89 45 08          	mov    %rax,0x8(%rbp)
  422eb1:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  422eb8:	74 6f 20 
  422ebb:	48 89 45 10          	mov    %rax,0x10(%rbp)
  422ebf:	48 b8 63 72 65 61 74 	movabs $0x7320657461657263,%rax
  422ec6:	65 20 73 
  422ec9:	48 89 45 18          	mov    %rax,0x18(%rbp)
  422ecd:	c7 45 20 6f 63 6b 65 	movl   $0x656b636f,0x20(%rbp)
  422ed4:	66 c7 45 24 74 00    	movw   $0x74,0x24(%rbp)
  422eda:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  422edf:	e9 23 01 00 00       	jmpq   423007 <init_driver+0x1c2>
  422ee4:	bf c5 3a 42 00       	mov    $0x423ac5,%edi
  422ee9:	e8 02 de fd ff       	callq  400cf0 <gethostbyname@plt>
  422eee:	48 85 c0             	test   %rax,%rax
  422ef1:	75 68                	jne    422f5b <init_driver+0x116>
  422ef3:	48 b8 45 72 72 6f 72 	movabs $0x44203a726f727245,%rax
  422efa:	3a 20 44 
  422efd:	48 89 45 00          	mov    %rax,0x0(%rbp)
  422f01:	48 b8 4e 53 20 69 73 	movabs $0x6e7520736920534e,%rax
  422f08:	20 75 6e 
  422f0b:	48 89 45 08          	mov    %rax,0x8(%rbp)
  422f0f:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  422f16:	74 6f 20 
  422f19:	48 89 45 10          	mov    %rax,0x10(%rbp)
  422f1d:	48 b8 72 65 73 6f 6c 	movabs $0x2065766c6f736572,%rax
  422f24:	76 65 20 
  422f27:	48 89 45 18          	mov    %rax,0x18(%rbp)
  422f2b:	48 b8 73 65 72 76 65 	movabs $0x6120726576726573,%rax
  422f32:	72 20 61 
  422f35:	48 89 45 20          	mov    %rax,0x20(%rbp)
  422f39:	c7 45 28 64 64 72 65 	movl   $0x65726464,0x28(%rbp)
  422f40:	66 c7 45 2c 73 73    	movw   $0x7373,0x2c(%rbp)
  422f46:	c6 45 2e 00          	movb   $0x0,0x2e(%rbp)
  422f4a:	89 df                	mov    %ebx,%edi
  422f4c:	e8 5f dd fd ff       	callq  400cb0 <close@plt>
  422f51:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  422f56:	e9 ac 00 00 00       	jmpq   423007 <init_driver+0x1c2>
  422f5b:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  422f62:	00 
  422f63:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
  422f6a:	00 00 
  422f6c:	66 c7 04 24 02 00    	movw   $0x2,(%rsp)
  422f72:	48 8b 48 18          	mov    0x18(%rax),%rcx
  422f76:	48 63 50 14          	movslq 0x14(%rax),%rdx
  422f7a:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
  422f7f:	48 8b 39             	mov    (%rcx),%rdi
  422f82:	e8 09 de fd ff       	callq  400d90 <bcopy@plt>
  422f87:	66 c7 44 24 02 00 50 	movw   $0x5000,0x2(%rsp)
  422f8e:	ba 10 00 00 00       	mov    $0x10,%edx
  422f93:	48 89 e6             	mov    %rsp,%rsi
  422f96:	89 df                	mov    %ebx,%edi
  422f98:	e8 63 de fd ff       	callq  400e00 <connect@plt>
  422f9d:	85 c0                	test   %eax,%eax
  422f9f:	79 50                	jns    422ff1 <init_driver+0x1ac>
  422fa1:	48 b8 45 72 72 6f 72 	movabs $0x55203a726f727245,%rax
  422fa8:	3a 20 55 
  422fab:	48 89 45 00          	mov    %rax,0x0(%rbp)
  422faf:	48 b8 6e 61 62 6c 65 	movabs $0x6f7420656c62616e,%rax
  422fb6:	20 74 6f 
  422fb9:	48 89 45 08          	mov    %rax,0x8(%rbp)
  422fbd:	48 b8 20 63 6f 6e 6e 	movabs $0x7463656e6e6f6320,%rax
  422fc4:	65 63 74 
  422fc7:	48 89 45 10          	mov    %rax,0x10(%rbp)
  422fcb:	48 b8 20 74 6f 20 73 	movabs $0x76726573206f7420,%rax
  422fd2:	65 72 76 
  422fd5:	48 89 45 18          	mov    %rax,0x18(%rbp)
  422fd9:	66 c7 45 20 65 72    	movw   $0x7265,0x20(%rbp)
  422fdf:	c6 45 22 00          	movb   $0x0,0x22(%rbp)
  422fe3:	89 df                	mov    %ebx,%edi
  422fe5:	e8 c6 dc fd ff       	callq  400cb0 <close@plt>
  422fea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  422fef:	eb 16                	jmp    423007 <init_driver+0x1c2>
  422ff1:	89 df                	mov    %ebx,%edi
  422ff3:	e8 b8 dc fd ff       	callq  400cb0 <close@plt>
  422ff8:	66 c7 45 00 4f 4b    	movw   $0x4b4f,0x0(%rbp)
  422ffe:	c6 45 02 00          	movb   $0x0,0x2(%rbp)
  423002:	b8 00 00 00 00       	mov    $0x0,%eax
  423007:	48 83 c4 18          	add    $0x18,%rsp
  42300b:	5b                   	pop    %rbx
  42300c:	5d                   	pop    %rbp
  42300d:	c3                   	retq   

000000000042300e <driver_post>:
  42300e:	53                   	push   %rbx
  42300f:	48 83 ec 10          	sub    $0x10,%rsp
  423013:	4c 89 cb             	mov    %r9,%rbx
  423016:	45 85 c0             	test   %r8d,%r8d
  423019:	74 22                	je     42303d <driver_post+0x2f>
  42301b:	48 89 ce             	mov    %rcx,%rsi
  42301e:	bf dc 3a 42 00       	mov    $0x423adc,%edi
  423023:	b8 00 00 00 00       	mov    $0x0,%eax
  423028:	e8 53 dc fd ff       	callq  400c80 <printf@plt>
  42302d:	66 c7 03 4f 4b       	movw   $0x4b4f,(%rbx)
  423032:	c6 43 02 00          	movb   $0x0,0x2(%rbx)
  423036:	b8 00 00 00 00       	mov    $0x0,%eax
  42303b:	eb 39                	jmp    423076 <driver_post+0x68>
  42303d:	48 85 ff             	test   %rdi,%rdi
  423040:	74 26                	je     423068 <driver_post+0x5a>
  423042:	80 3f 00             	cmpb   $0x0,(%rdi)
  423045:	74 21                	je     423068 <driver_post+0x5a>
  423047:	4c 89 0c 24          	mov    %r9,(%rsp)
  42304b:	49 89 c9             	mov    %rcx,%r9
  42304e:	49 89 d0             	mov    %rdx,%r8
  423051:	48 89 f9             	mov    %rdi,%rcx
  423054:	48 89 f2             	mov    %rsi,%rdx
  423057:	be 50 00 00 00       	mov    $0x50,%esi
  42305c:	bf c5 3a 42 00       	mov    $0x423ac5,%edi
  423061:	e8 81 f6 ff ff       	callq  4226e7 <submitr>
  423066:	eb 0e                	jmp    423076 <driver_post+0x68>
  423068:	66 c7 03 4f 4b       	movw   $0x4b4f,(%rbx)
  42306d:	c6 43 02 00          	movb   $0x0,0x2(%rbx)
  423071:	b8 00 00 00 00       	mov    $0x0,%eax
  423076:	48 83 c4 10          	add    $0x10,%rsp
  42307a:	5b                   	pop    %rbx
  42307b:	c3                   	retq   

000000000042307c <check>:
  42307c:	89 f8                	mov    %edi,%eax
  42307e:	c1 e8 1c             	shr    $0x1c,%eax
  423081:	74 1d                	je     4230a0 <check+0x24>
  423083:	b9 00 00 00 00       	mov    $0x0,%ecx
  423088:	83 f9 1f             	cmp    $0x1f,%ecx
  42308b:	7f 0d                	jg     42309a <check+0x1e>
  42308d:	89 f8                	mov    %edi,%eax
  42308f:	d3 e8                	shr    %cl,%eax
  423091:	3c 0a                	cmp    $0xa,%al
  423093:	74 11                	je     4230a6 <check+0x2a>
  423095:	83 c1 08             	add    $0x8,%ecx
  423098:	eb ee                	jmp    423088 <check+0xc>
  42309a:	b8 01 00 00 00       	mov    $0x1,%eax
  42309f:	c3                   	retq   
  4230a0:	b8 00 00 00 00       	mov    $0x0,%eax
  4230a5:	c3                   	retq   
  4230a6:	b8 00 00 00 00       	mov    $0x0,%eax
  4230ab:	c3                   	retq   

00000000004230ac <gencookie>:
  4230ac:	53                   	push   %rbx
  4230ad:	83 c7 01             	add    $0x1,%edi
  4230b0:	e8 6b db fd ff       	callq  400c20 <srandom@plt>
  4230b5:	e8 96 dc fd ff       	callq  400d50 <random@plt>
  4230ba:	48 89 c7             	mov    %rax,%rdi
  4230bd:	89 c3                	mov    %eax,%ebx
  4230bf:	e8 b8 ff ff ff       	callq  42307c <check>
  4230c4:	85 c0                	test   %eax,%eax
  4230c6:	74 ed                	je     4230b5 <gencookie+0x9>
  4230c8:	89 d8                	mov    %ebx,%eax
  4230ca:	5b                   	pop    %rbx
  4230cb:	c3                   	retq   
  4230cc:	0f 1f 40 00          	nopl   0x0(%rax)

00000000004230d0 <__libc_csu_init>:
  4230d0:	41 57                	push   %r15
  4230d2:	41 89 ff             	mov    %edi,%r15d
  4230d5:	41 56                	push   %r14
  4230d7:	49 89 f6             	mov    %rsi,%r14
  4230da:	41 55                	push   %r13
  4230dc:	49 89 d5             	mov    %rdx,%r13
  4230df:	41 54                	push   %r12
  4230e1:	4c 8d 25 28 1d 20 00 	lea    0x201d28(%rip),%r12        # 624e10 <__frame_dummy_init_array_entry>
  4230e8:	55                   	push   %rbp
  4230e9:	48 8d 2d 28 1d 20 00 	lea    0x201d28(%rip),%rbp        # 624e18 <__init_array_end>
  4230f0:	53                   	push   %rbx
  4230f1:	4c 29 e5             	sub    %r12,%rbp
  4230f4:	31 db                	xor    %ebx,%ebx
  4230f6:	48 c1 fd 03          	sar    $0x3,%rbp
  4230fa:	48 83 ec 08          	sub    $0x8,%rsp
  4230fe:	e8 c5 da fd ff       	callq  400bc8 <_init>
  423103:	48 85 ed             	test   %rbp,%rbp
  423106:	74 1e                	je     423126 <__libc_csu_init+0x56>
  423108:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  42310f:	00 
  423110:	4c 89 ea             	mov    %r13,%rdx
  423113:	4c 89 f6             	mov    %r14,%rsi
  423116:	44 89 ff             	mov    %r15d,%edi
  423119:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
  42311d:	48 83 c3 01          	add    $0x1,%rbx
  423121:	48 39 eb             	cmp    %rbp,%rbx
  423124:	75 ea                	jne    423110 <__libc_csu_init+0x40>
  423126:	48 83 c4 08          	add    $0x8,%rsp
  42312a:	5b                   	pop    %rbx
  42312b:	5d                   	pop    %rbp
  42312c:	41 5c                	pop    %r12
  42312e:	41 5d                	pop    %r13
  423130:	41 5e                	pop    %r14
  423132:	41 5f                	pop    %r15
  423134:	c3                   	retq   
  423135:	90                   	nop
  423136:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  42313d:	00 00 00 

0000000000423140 <__libc_csu_fini>:
  423140:	f3 c3                	repz retq 

Disassembly of section .init:

0000000000400bc8 <_init>:
  400bc8:	48 83 ec 08          	sub    $0x8,%rsp
  400bcc:	48 8b 05 25 44 22 00 	mov    0x224425(%rip),%rax        # 624ff8 <__gmon_start__>
  400bd3:	48 85 c0             	test   %rax,%rax
  400bd6:	74 05                	je     400bdd <_init+0x15>
  400bd8:	e8 33 01 00 00       	callq  400d10 <__gmon_start__@plt>
  400bdd:	48 83 c4 08          	add    $0x8,%rsp
  400be1:	c3                   	retq   

Disassembly of section .plt:

0000000000400bf0 <.plt>:
  400bf0:	ff 35 12 44 22 00    	pushq  0x224412(%rip)        # 625008 <_GLOBAL_OFFSET_TABLE_+0x8>
  400bf6:	ff 25 14 44 22 00    	jmpq   *0x224414(%rip)        # 625010 <_GLOBAL_OFFSET_TABLE_+0x10>
  400bfc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400c00 <strcasecmp@plt>:
  400c00:	ff 25 12 44 22 00    	jmpq   *0x224412(%rip)        # 625018 <strcasecmp@GLIBC_2.2.5>
  400c06:	68 00 00 00 00       	pushq  $0x0
  400c0b:	e9 e0 ff ff ff       	jmpq   400bf0 <.plt>

0000000000400c10 <__errno_location@plt>:
  400c10:	ff 25 0a 44 22 00    	jmpq   *0x22440a(%rip)        # 625020 <__errno_location@GLIBC_2.2.5>
  400c16:	68 01 00 00 00       	pushq  $0x1
  400c1b:	e9 d0 ff ff ff       	jmpq   400bf0 <.plt>

0000000000400c20 <srandom@plt>:
  400c20:	ff 25 02 44 22 00    	jmpq   *0x224402(%rip)        # 625028 <srandom@GLIBC_2.2.5>
  400c26:	68 02 00 00 00       	pushq  $0x2
  400c2b:	e9 c0 ff ff ff       	jmpq   400bf0 <.plt>

0000000000400c30 <strncmp@plt>:
  400c30:	ff 25 fa 43 22 00    	jmpq   *0x2243fa(%rip)        # 625030 <strncmp@GLIBC_2.2.5>
  400c36:	68 03 00 00 00       	pushq  $0x3
  400c3b:	e9 b0 ff ff ff       	jmpq   400bf0 <.plt>

0000000000400c40 <strcpy@plt>:
  400c40:	ff 25 f2 43 22 00    	jmpq   *0x2243f2(%rip)        # 625038 <strcpy@GLIBC_2.2.5>
  400c46:	68 04 00 00 00       	pushq  $0x4
  400c4b:	e9 a0 ff ff ff       	jmpq   400bf0 <.plt>

0000000000400c50 <puts@plt>:
  400c50:	ff 25 ea 43 22 00    	jmpq   *0x2243ea(%rip)        # 625040 <puts@GLIBC_2.2.5>
  400c56:	68 05 00 00 00       	pushq  $0x5
  400c5b:	e9 90 ff ff ff       	jmpq   400bf0 <.plt>

0000000000400c60 <write@plt>:
  400c60:	ff 25 e2 43 22 00    	jmpq   *0x2243e2(%rip)        # 625048 <write@GLIBC_2.2.5>
  400c66:	68 06 00 00 00       	pushq  $0x6
  400c6b:	e9 80 ff ff ff       	jmpq   400bf0 <.plt>

0000000000400c70 <mmap@plt>:
  400c70:	ff 25 da 43 22 00    	jmpq   *0x2243da(%rip)        # 625050 <mmap@GLIBC_2.2.5>
  400c76:	68 07 00 00 00       	pushq  $0x7
  400c7b:	e9 70 ff ff ff       	jmpq   400bf0 <.plt>

0000000000400c80 <printf@plt>:
  400c80:	ff 25 d2 43 22 00    	jmpq   *0x2243d2(%rip)        # 625058 <printf@GLIBC_2.2.5>
  400c86:	68 08 00 00 00       	pushq  $0x8
  400c8b:	e9 60 ff ff ff       	jmpq   400bf0 <.plt>

0000000000400c90 <memset@plt>:
  400c90:	ff 25 ca 43 22 00    	jmpq   *0x2243ca(%rip)        # 625060 <memset@GLIBC_2.2.5>
  400c96:	68 09 00 00 00       	pushq  $0x9
  400c9b:	e9 50 ff ff ff       	jmpq   400bf0 <.plt>

0000000000400ca0 <alarm@plt>:
  400ca0:	ff 25 c2 43 22 00    	jmpq   *0x2243c2(%rip)        # 625068 <alarm@GLIBC_2.2.5>
  400ca6:	68 0a 00 00 00       	pushq  $0xa
  400cab:	e9 40 ff ff ff       	jmpq   400bf0 <.plt>

0000000000400cb0 <close@plt>:
  400cb0:	ff 25 ba 43 22 00    	jmpq   *0x2243ba(%rip)        # 625070 <close@GLIBC_2.2.5>
  400cb6:	68 0b 00 00 00       	pushq  $0xb
  400cbb:	e9 30 ff ff ff       	jmpq   400bf0 <.plt>

0000000000400cc0 <read@plt>:
  400cc0:	ff 25 b2 43 22 00    	jmpq   *0x2243b2(%rip)        # 625078 <read@GLIBC_2.2.5>
  400cc6:	68 0c 00 00 00       	pushq  $0xc
  400ccb:	e9 20 ff ff ff       	jmpq   400bf0 <.plt>

0000000000400cd0 <__libc_start_main@plt>:
  400cd0:	ff 25 aa 43 22 00    	jmpq   *0x2243aa(%rip)        # 625080 <__libc_start_main@GLIBC_2.2.5>
  400cd6:	68 0d 00 00 00       	pushq  $0xd
  400cdb:	e9 10 ff ff ff       	jmpq   400bf0 <.plt>

0000000000400ce0 <signal@plt>:
  400ce0:	ff 25 a2 43 22 00    	jmpq   *0x2243a2(%rip)        # 625088 <signal@GLIBC_2.2.5>
  400ce6:	68 0e 00 00 00       	pushq  $0xe
  400ceb:	e9 00 ff ff ff       	jmpq   400bf0 <.plt>

0000000000400cf0 <gethostbyname@plt>:
  400cf0:	ff 25 9a 43 22 00    	jmpq   *0x22439a(%rip)        # 625090 <gethostbyname@GLIBC_2.2.5>
  400cf6:	68 0f 00 00 00       	pushq  $0xf
  400cfb:	e9 f0 fe ff ff       	jmpq   400bf0 <.plt>

0000000000400d00 <fprintf@plt>:
  400d00:	ff 25 92 43 22 00    	jmpq   *0x224392(%rip)        # 625098 <fprintf@GLIBC_2.2.5>
  400d06:	68 10 00 00 00       	pushq  $0x10
  400d0b:	e9 e0 fe ff ff       	jmpq   400bf0 <.plt>

0000000000400d10 <__gmon_start__@plt>:
  400d10:	ff 25 8a 43 22 00    	jmpq   *0x22438a(%rip)        # 6250a0 <__gmon_start__>
  400d16:	68 11 00 00 00       	pushq  $0x11
  400d1b:	e9 d0 fe ff ff       	jmpq   400bf0 <.plt>

0000000000400d20 <strtol@plt>:
  400d20:	ff 25 82 43 22 00    	jmpq   *0x224382(%rip)        # 6250a8 <strtol@GLIBC_2.2.5>
  400d26:	68 12 00 00 00       	pushq  $0x12
  400d2b:	e9 c0 fe ff ff       	jmpq   400bf0 <.plt>

0000000000400d30 <memcpy@plt>:
  400d30:	ff 25 7a 43 22 00    	jmpq   *0x22437a(%rip)        # 6250b0 <memcpy@GLIBC_2.14>
  400d36:	68 13 00 00 00       	pushq  $0x13
  400d3b:	e9 b0 fe ff ff       	jmpq   400bf0 <.plt>

0000000000400d40 <time@plt>:
  400d40:	ff 25 72 43 22 00    	jmpq   *0x224372(%rip)        # 6250b8 <time@GLIBC_2.2.5>
  400d46:	68 14 00 00 00       	pushq  $0x14
  400d4b:	e9 a0 fe ff ff       	jmpq   400bf0 <.plt>

0000000000400d50 <random@plt>:
  400d50:	ff 25 6a 43 22 00    	jmpq   *0x22436a(%rip)        # 6250c0 <random@GLIBC_2.2.5>
  400d56:	68 15 00 00 00       	pushq  $0x15
  400d5b:	e9 90 fe ff ff       	jmpq   400bf0 <.plt>

0000000000400d60 <_IO_getc@plt>:
  400d60:	ff 25 62 43 22 00    	jmpq   *0x224362(%rip)        # 6250c8 <_IO_getc@GLIBC_2.2.5>
  400d66:	68 16 00 00 00       	pushq  $0x16
  400d6b:	e9 80 fe ff ff       	jmpq   400bf0 <.plt>

0000000000400d70 <__isoc99_sscanf@plt>:
  400d70:	ff 25 5a 43 22 00    	jmpq   *0x22435a(%rip)        # 6250d0 <__isoc99_sscanf@GLIBC_2.7>
  400d76:	68 17 00 00 00       	pushq  $0x17
  400d7b:	e9 70 fe ff ff       	jmpq   400bf0 <.plt>

0000000000400d80 <munmap@plt>:
  400d80:	ff 25 52 43 22 00    	jmpq   *0x224352(%rip)        # 6250d8 <munmap@GLIBC_2.2.5>
  400d86:	68 18 00 00 00       	pushq  $0x18
  400d8b:	e9 60 fe ff ff       	jmpq   400bf0 <.plt>

0000000000400d90 <bcopy@plt>:
  400d90:	ff 25 4a 43 22 00    	jmpq   *0x22434a(%rip)        # 6250e0 <bcopy@GLIBC_2.2.5>
  400d96:	68 19 00 00 00       	pushq  $0x19
  400d9b:	e9 50 fe ff ff       	jmpq   400bf0 <.plt>

0000000000400da0 <fopen@plt>:
  400da0:	ff 25 42 43 22 00    	jmpq   *0x224342(%rip)        # 6250e8 <fopen@GLIBC_2.2.5>
  400da6:	68 1a 00 00 00       	pushq  $0x1a
  400dab:	e9 40 fe ff ff       	jmpq   400bf0 <.plt>

0000000000400db0 <getopt@plt>:
  400db0:	ff 25 3a 43 22 00    	jmpq   *0x22433a(%rip)        # 6250f0 <getopt@GLIBC_2.2.5>
  400db6:	68 1b 00 00 00       	pushq  $0x1b
  400dbb:	e9 30 fe ff ff       	jmpq   400bf0 <.plt>

0000000000400dc0 <strtoul@plt>:
  400dc0:	ff 25 32 43 22 00    	jmpq   *0x224332(%rip)        # 6250f8 <strtoul@GLIBC_2.2.5>
  400dc6:	68 1c 00 00 00       	pushq  $0x1c
  400dcb:	e9 20 fe ff ff       	jmpq   400bf0 <.plt>

0000000000400dd0 <gethostname@plt>:
  400dd0:	ff 25 2a 43 22 00    	jmpq   *0x22432a(%rip)        # 625100 <gethostname@GLIBC_2.2.5>
  400dd6:	68 1d 00 00 00       	pushq  $0x1d
  400ddb:	e9 10 fe ff ff       	jmpq   400bf0 <.plt>

0000000000400de0 <sprintf@plt>:
  400de0:	ff 25 22 43 22 00    	jmpq   *0x224322(%rip)        # 625108 <sprintf@GLIBC_2.2.5>
  400de6:	68 1e 00 00 00       	pushq  $0x1e
  400deb:	e9 00 fe ff ff       	jmpq   400bf0 <.plt>

0000000000400df0 <exit@plt>:
  400df0:	ff 25 1a 43 22 00    	jmpq   *0x22431a(%rip)        # 625110 <exit@GLIBC_2.2.5>
  400df6:	68 1f 00 00 00       	pushq  $0x1f
  400dfb:	e9 f0 fd ff ff       	jmpq   400bf0 <.plt>

0000000000400e00 <connect@plt>:
  400e00:	ff 25 12 43 22 00    	jmpq   *0x224312(%rip)        # 625118 <connect@GLIBC_2.2.5>
  400e06:	68 20 00 00 00       	pushq  $0x20
  400e0b:	e9 e0 fd ff ff       	jmpq   400bf0 <.plt>

0000000000400e10 <socket@plt>:
  400e10:	ff 25 0a 43 22 00    	jmpq   *0x22430a(%rip)        # 625120 <socket@GLIBC_2.2.5>
  400e16:	68 21 00 00 00       	pushq  $0x21
  400e1b:	e9 d0 fd ff ff       	jmpq   400bf0 <.plt>

Disassembly of section .fini:

0000000000423144 <_fini>:
  423144:	48 83 ec 08          	sub    $0x8,%rsp
  423148:	48 83 c4 08          	add    $0x8,%rsp
  42314c:	c3                   	retq   
