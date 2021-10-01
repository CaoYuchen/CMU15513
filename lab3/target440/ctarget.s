
./ctarget:     file format elf64-x86-64


Disassembly of section .text:

0000000000421300 <_start>:
  421300:	31 ed                	xor    %ebp,%ebp
  421302:	49 89 d1             	mov    %rdx,%r9
  421305:	5e                   	pop    %rsi
  421306:	48 89 e2             	mov    %rsp,%rdx
  421309:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  42130d:	50                   	push   %rax
  42130e:	54                   	push   %rsp
  42130f:	49 c7 c0 20 30 42 00 	mov    $0x423020,%r8
  421316:	48 c7 c1 b0 2f 42 00 	mov    $0x422fb0,%rcx
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
  421400:	bf 40 30 42 00       	mov    $0x423040,%edi
  421405:	b8 00 00 00 00       	mov    $0x0,%eax
  42140a:	e8 71 f8 fd ff       	callq  400c80 <printf@plt>
  42140f:	bf 78 30 42 00       	mov    $0x423078,%edi
  421414:	e8 37 f8 fd ff       	callq  400c50 <puts@plt>
  421419:	bf f0 31 42 00       	mov    $0x4231f0,%edi
  42141e:	e8 2d f8 fd ff       	callq  400c50 <puts@plt>
  421423:	bf a0 30 42 00       	mov    $0x4230a0,%edi
  421428:	e8 23 f8 fd ff       	callq  400c50 <puts@plt>
  42142d:	bf 0a 32 42 00       	mov    $0x42320a,%edi
  421432:	e8 19 f8 fd ff       	callq  400c50 <puts@plt>
  421437:	eb 2d                	jmp    421466 <usage+0x76>
  421439:	bf 26 32 42 00       	mov    $0x423226,%edi
  42143e:	b8 00 00 00 00       	mov    $0x0,%eax
  421443:	e8 38 f8 fd ff       	callq  400c80 <printf@plt>
  421448:	bf c8 30 42 00       	mov    $0x4230c8,%edi
  42144d:	e8 fe f7 fd ff       	callq  400c50 <puts@plt>
  421452:	bf f0 30 42 00       	mov    $0x4230f0,%edi
  421457:	e8 f4 f7 fd ff       	callq  400c50 <puts@plt>
  42145c:	bf 44 32 42 00       	mov    $0x423244,%edi
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
  421487:	e8 00 1b 00 00       	callq  422f8c <gencookie>
  42148c:	89 05 72 40 20 00    	mov    %eax,0x204072(%rip)        # 625504 <cookie>
  421492:	89 c7                	mov    %eax,%edi
  421494:	e8 f3 1a 00 00       	callq  422f8c <gencookie>
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
  4214f1:	c6 05 30 4c 20 00 63 	movb   $0x63,0x204c30(%rip)        # 626128 <target_prefix>
  4214f8:	83 3d a9 3f 20 00 00 	cmpl   $0x0,0x203fa9(%rip)        # 6254a8 <notify>
  4214ff:	0f 84 b1 00 00 00    	je     4215b6 <initialize_target+0x146>
  421505:	83 3d fc 3f 20 00 00 	cmpl   $0x0,0x203ffc(%rip)        # 625508 <is_checker>
  42150c:	0f 85 a4 00 00 00    	jne    4215b6 <initialize_target+0x146>
  421512:	be 00 01 00 00       	mov    $0x100,%esi
  421517:	48 89 e7             	mov    %rsp,%rdi
  42151a:	e8 b1 f8 fd ff       	callq  400dd0 <gethostname@plt>
  42151f:	85 c0                	test   %eax,%eax
  421521:	74 25                	je     421548 <initialize_target+0xd8>
  421523:	bf 20 31 42 00       	mov    $0x423120,%edi
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
  421570:	bf 58 31 42 00       	mov    $0x423158,%edi
  421575:	e8 06 f7 fd ff       	callq  400c80 <printf@plt>
  42157a:	bf 08 00 00 00       	mov    $0x8,%edi
  42157f:	e8 6c f8 fd ff       	callq  400df0 <exit@plt>
  421584:	48 8d bc 24 00 01 00 	lea    0x100(%rsp),%rdi
  42158b:	00 
  42158c:	e8 94 17 00 00       	callq  422d25 <init_driver>
  421591:	85 c0                	test   %eax,%eax
  421593:	79 21                	jns    4215b6 <initialize_target+0x146>
  421595:	48 8d b4 24 00 01 00 	lea    0x100(%rsp),%rsi
  42159c:	00 
  42159d:	bf 98 31 42 00       	mov    $0x423198,%edi
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
  4215ce:	be 31 21 42 00       	mov    $0x422131,%esi
  4215d3:	bf 0b 00 00 00       	mov    $0xb,%edi
  4215d8:	e8 03 f7 fd ff       	callq  400ce0 <signal@plt>
  4215dd:	be e3 20 42 00       	mov    $0x4220e3,%esi
  4215e2:	bf 07 00 00 00       	mov    $0x7,%edi
  4215e7:	e8 f4 f6 fd ff       	callq  400ce0 <signal@plt>
  4215ec:	be 7f 21 42 00       	mov    $0x42217f,%esi
  4215f1:	bf 04 00 00 00       	mov    $0x4,%edi
  4215f6:	e8 e5 f6 fd ff       	callq  400ce0 <signal@plt>
  4215fb:	83 3d 06 3f 20 00 00 	cmpl   $0x0,0x203f06(%rip)        # 625508 <is_checker>
  421602:	74 20                	je     421624 <main+0x64>
  421604:	be cd 21 42 00       	mov    $0x4221cd,%esi
  421609:	bf 0e 00 00 00       	mov    $0xe,%edi
  42160e:	e8 cd f6 fd ff       	callq  400ce0 <signal@plt>
  421613:	bf 05 00 00 00       	mov    $0x5,%edi
  421618:	e8 83 f6 fd ff       	callq  400ca0 <alarm@plt>
  42161d:	bd 62 32 42 00       	mov    $0x423262,%ebp
  421622:	eb 05                	jmp    421629 <main+0x69>
  421624:	bd 5d 32 42 00       	mov    $0x42325d,%ebp
  421629:	48 8b 05 90 3e 20 00 	mov    0x203e90(%rip),%rax        # 6254c0 <stdin@@GLIBC_2.2.5>
  421630:	48 89 05 b9 3e 20 00 	mov    %rax,0x203eb9(%rip)        # 6254f0 <infile>
  421637:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  42163d:	41 be 00 00 00 00    	mov    $0x0,%r14d
  421643:	e9 b9 00 00 00       	jmpq   421701 <main+0x141>
  421648:	83 e8 61             	sub    $0x61,%eax
  42164b:	3c 10                	cmp    $0x10,%al
  42164d:	0f 87 93 00 00 00    	ja     4216e6 <main+0x126>
  421653:	0f b6 c0             	movzbl %al,%eax
  421656:	ff 24 c5 a8 32 42 00 	jmpq   *0x4232a8(,%rax,8)
  42165d:	48 8b 3b             	mov    (%rbx),%rdi
  421660:	e8 8b fd ff ff       	callq  4213f0 <usage>
  421665:	be 7d 36 42 00       	mov    $0x42367d,%esi
  42166a:	48 8b 3d 57 3e 20 00 	mov    0x203e57(%rip),%rdi        # 6254c8 <optarg@@GLIBC_2.2.5>
  421671:	e8 2a f7 fd ff       	callq  400da0 <fopen@plt>
  421676:	48 89 05 73 3e 20 00 	mov    %rax,0x203e73(%rip)        # 6254f0 <infile>
  42167d:	48 85 c0             	test   %rax,%rax
  421680:	75 7f                	jne    421701 <main+0x141>
  421682:	48 8b 15 3f 3e 20 00 	mov    0x203e3f(%rip),%rdx        # 6254c8 <optarg@@GLIBC_2.2.5>
  421689:	be 6a 32 42 00       	mov    $0x42326a,%esi
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
  4216ea:	bf 87 32 42 00       	mov    $0x423287,%edi
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
  421719:	be 00 00 00 00       	mov    $0x0,%esi
  42171e:	44 89 ef             	mov    %r13d,%edi
  421721:	e8 4a fd ff ff       	callq  421470 <initialize_target>
  421726:	83 3d db 3d 20 00 00 	cmpl   $0x0,0x203ddb(%rip)        # 625508 <is_checker>
  42172d:	74 25                	je     421754 <main+0x194>
  42172f:	44 3b 35 ca 3d 20 00 	cmp    0x203dca(%rip),%r14d        # 625500 <authkey>
  421736:	74 1c                	je     421754 <main+0x194>
  421738:	44 89 f6             	mov    %r14d,%esi
  42173b:	bf c0 31 42 00       	mov    $0x4231c0,%edi
  421740:	b8 00 00 00 00       	mov    $0x0,%eax
  421745:	e8 36 f5 fd ff       	callq  400c80 <printf@plt>
  42174a:	b8 00 00 00 00       	mov    $0x0,%eax
  42174f:	e8 97 06 00 00       	callq  421deb <check_fail>
  421754:	8b 35 aa 3d 20 00    	mov    0x203daa(%rip),%esi        # 625504 <cookie>
  42175a:	bf 9a 32 42 00       	mov    $0x42329a,%edi
  42175f:	b8 00 00 00 00       	mov    $0x0,%eax
  421764:	e8 17 f5 fd ff       	callq  400c80 <printf@plt>
  421769:	48 8b 3d 30 3d 20 00 	mov    0x203d30(%rip),%rdi        # 6254a0 <buf_offset>
  421770:	e8 27 0b 00 00       	callq  42229c <stable_launch>
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
  421bdf:	e8 36 02 00 00       	callq  421e1a <Gets>
  421be4:	b8 01 00 00 00       	mov    $0x1,%eax
  421be9:	48 83 c4 38          	add    $0x38,%rsp
  421bed:	c3                   	retq   

0000000000421bee <touch1>:
  421bee:	48 83 ec 08          	sub    $0x8,%rsp
  421bf2:	c7 05 00 39 20 00 01 	movl   $0x1,0x203900(%rip)        # 6254fc <vlevel>
  421bf9:	00 00 00 
  421bfc:	bf cf 34 42 00       	mov    $0x4234cf,%edi
  421c01:	e8 4a f0 fd ff       	callq  400c50 <puts@plt>
  421c06:	bf 01 00 00 00       	mov    $0x1,%edi
  421c0b:	e8 f9 03 00 00       	callq  422009 <validate>
  421c10:	bf 00 00 00 00       	mov    $0x0,%edi
  421c15:	e8 d6 f1 fd ff       	callq  400df0 <exit@plt>

0000000000421c1a <touch2>:
  421c1a:	48 83 ec 08          	sub    $0x8,%rsp
  421c1e:	89 fe                	mov    %edi,%esi
  421c20:	c7 05 d2 38 20 00 02 	movl   $0x2,0x2038d2(%rip)        # 6254fc <vlevel>
  421c27:	00 00 00 
  421c2a:	3b 3d d4 38 20 00    	cmp    0x2038d4(%rip),%edi        # 625504 <cookie>
  421c30:	75 1b                	jne    421c4d <touch2+0x33>
  421c32:	bf f8 34 42 00       	mov    $0x4234f8,%edi
  421c37:	b8 00 00 00 00       	mov    $0x0,%eax
  421c3c:	e8 3f f0 fd ff       	callq  400c80 <printf@plt>
  421c41:	bf 02 00 00 00       	mov    $0x2,%edi
  421c46:	e8 be 03 00 00       	callq  422009 <validate>
  421c4b:	eb 19                	jmp    421c66 <touch2+0x4c>
  421c4d:	bf 20 35 42 00       	mov    $0x423520,%edi
  421c52:	b8 00 00 00 00       	mov    $0x0,%eax
  421c57:	e8 24 f0 fd ff       	callq  400c80 <printf@plt>
  421c5c:	bf 02 00 00 00       	mov    $0x2,%edi
  421c61:	e8 55 04 00 00       	callq  4220bb <fail>
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
  421cbb:	be ec 34 42 00       	mov    $0x4234ec,%esi
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
  421d11:	bf 48 35 42 00       	mov    $0x423548,%edi
  421d16:	b8 00 00 00 00       	mov    $0x0,%eax
  421d1b:	e8 60 ef fd ff       	callq  400c80 <printf@plt>
  421d20:	bf 03 00 00 00       	mov    $0x3,%edi
  421d25:	e8 df 02 00 00       	callq  422009 <validate>
  421d2a:	eb 1c                	jmp    421d48 <touch3+0x5a>
  421d2c:	48 89 de             	mov    %rbx,%rsi
  421d2f:	bf 70 35 42 00       	mov    $0x423570,%edi
  421d34:	b8 00 00 00 00       	mov    $0x0,%eax
  421d39:	e8 42 ef fd ff       	callq  400c80 <printf@plt>
  421d3e:	bf 03 00 00 00       	mov    $0x3,%edi
  421d43:	e8 73 03 00 00       	callq  4220bb <fail>
  421d48:	bf 00 00 00 00       	mov    $0x0,%edi
  421d4d:	e8 9e f0 fd ff       	callq  400df0 <exit@plt>

0000000000421d52 <test>:
  421d52:	48 83 ec 08          	sub    $0x8,%rsp
  421d56:	b8 00 00 00 00       	mov    $0x0,%eax
  421d5b:	e8 78 fe ff ff       	callq  421bd8 <getbuf>
  421d60:	89 c6                	mov    %eax,%esi
  421d62:	bf 98 35 42 00       	mov    $0x423598,%edi
  421d67:	b8 00 00 00 00       	mov    $0x0,%eax
  421d6c:	e8 0f ef fd ff       	callq  400c80 <printf@plt>
  421d71:	48 83 c4 08          	add    $0x8,%rsp
  421d75:	c3                   	retq   
  421d76:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  421d7d:	00 00 00 

0000000000421d80 <save_char>:
  421d80:	8b 05 9e 43 20 00    	mov    0x20439e(%rip),%eax        # 626124 <gets_cnt>
  421d86:	3d ff 03 00 00       	cmp    $0x3ff,%eax
  421d8b:	7f 49                	jg     421dd6 <save_char+0x56>
  421d8d:	8d 14 40             	lea    (%rax,%rax,2),%edx
  421d90:	89 f9                	mov    %edi,%ecx
  421d92:	c0 e9 04             	shr    $0x4,%cl
  421d95:	83 e1 0f             	and    $0xf,%ecx
  421d98:	0f b6 b1 c0 38 42 00 	movzbl 0x4238c0(%rcx),%esi
  421d9f:	48 63 ca             	movslq %edx,%rcx
  421da2:	40 88 b1 20 55 62 00 	mov    %sil,0x625520(%rcx)
  421da9:	8d 4a 01             	lea    0x1(%rdx),%ecx
  421dac:	83 e7 0f             	and    $0xf,%edi
  421daf:	0f b6 b7 c0 38 42 00 	movzbl 0x4238c0(%rdi),%esi
  421db6:	48 63 c9             	movslq %ecx,%rcx
  421db9:	40 88 b1 20 55 62 00 	mov    %sil,0x625520(%rcx)
  421dc0:	83 c2 02             	add    $0x2,%edx
  421dc3:	48 63 d2             	movslq %edx,%rdx
  421dc6:	c6 82 20 55 62 00 20 	movb   $0x20,0x625520(%rdx)
  421dcd:	83 c0 01             	add    $0x1,%eax
  421dd0:	89 05 4e 43 20 00    	mov    %eax,0x20434e(%rip)        # 626124 <gets_cnt>
  421dd6:	f3 c3                	repz retq 

0000000000421dd8 <save_term>:
  421dd8:	8b 05 46 43 20 00    	mov    0x204346(%rip),%eax        # 626124 <gets_cnt>
  421dde:	8d 04 40             	lea    (%rax,%rax,2),%eax
  421de1:	48 98                	cltq   
  421de3:	c6 80 20 55 62 00 00 	movb   $0x0,0x625520(%rax)
  421dea:	c3                   	retq   

0000000000421deb <check_fail>:
  421deb:	48 83 ec 08          	sub    $0x8,%rsp
  421def:	0f be 35 32 43 20 00 	movsbl 0x204332(%rip),%esi        # 626128 <target_prefix>
  421df6:	b9 20 55 62 00       	mov    $0x625520,%ecx
  421dfb:	8b 15 f7 36 20 00    	mov    0x2036f7(%rip),%edx        # 6254f8 <check_level>
  421e01:	bf bb 35 42 00       	mov    $0x4235bb,%edi
  421e06:	b8 00 00 00 00       	mov    $0x0,%eax
  421e0b:	e8 70 ee fd ff       	callq  400c80 <printf@plt>
  421e10:	bf 01 00 00 00       	mov    $0x1,%edi
  421e15:	e8 d6 ef fd ff       	callq  400df0 <exit@plt>

0000000000421e1a <Gets>:
  421e1a:	41 54                	push   %r12
  421e1c:	55                   	push   %rbp
  421e1d:	53                   	push   %rbx
  421e1e:	49 89 fc             	mov    %rdi,%r12
  421e21:	c7 05 f9 42 20 00 00 	movl   $0x0,0x2042f9(%rip)        # 626124 <gets_cnt>
  421e28:	00 00 00 
  421e2b:	48 89 fb             	mov    %rdi,%rbx
  421e2e:	eb 11                	jmp    421e41 <Gets+0x27>
  421e30:	48 8d 6b 01          	lea    0x1(%rbx),%rbp
  421e34:	88 03                	mov    %al,(%rbx)
  421e36:	0f b6 f8             	movzbl %al,%edi
  421e39:	e8 42 ff ff ff       	callq  421d80 <save_char>
  421e3e:	48 89 eb             	mov    %rbp,%rbx
  421e41:	48 8b 3d a8 36 20 00 	mov    0x2036a8(%rip),%rdi        # 6254f0 <infile>
  421e48:	e8 13 ef fd ff       	callq  400d60 <_IO_getc@plt>
  421e4d:	83 f8 ff             	cmp    $0xffffffff,%eax
  421e50:	74 05                	je     421e57 <Gets+0x3d>
  421e52:	83 f8 0a             	cmp    $0xa,%eax
  421e55:	75 d9                	jne    421e30 <Gets+0x16>
  421e57:	c6 03 00             	movb   $0x0,(%rbx)
  421e5a:	b8 00 00 00 00       	mov    $0x0,%eax
  421e5f:	e8 74 ff ff ff       	callq  421dd8 <save_term>
  421e64:	4c 89 e0             	mov    %r12,%rax
  421e67:	5b                   	pop    %rbx
  421e68:	5d                   	pop    %rbp
  421e69:	41 5c                	pop    %r12
  421e6b:	c3                   	retq   

0000000000421e6c <notify_server>:
  421e6c:	83 3d 95 36 20 00 00 	cmpl   $0x0,0x203695(%rip)        # 625508 <is_checker>
  421e73:	0f 85 8e 01 00 00    	jne    422007 <notify_server+0x19b>
  421e79:	53                   	push   %rbx
  421e7a:	48 81 ec 10 40 00 00 	sub    $0x4010,%rsp
  421e81:	89 fb                	mov    %edi,%ebx
  421e83:	8b 05 9b 42 20 00    	mov    0x20429b(%rip),%eax        # 626124 <gets_cnt>
  421e89:	83 c0 64             	add    $0x64,%eax
  421e8c:	3d 00 20 00 00       	cmp    $0x2000,%eax
  421e91:	7e 19                	jle    421eac <notify_server+0x40>
  421e93:	bf f0 36 42 00       	mov    $0x4236f0,%edi
  421e98:	b8 00 00 00 00       	mov    $0x0,%eax
  421e9d:	e8 de ed fd ff       	callq  400c80 <printf@plt>
  421ea2:	bf 01 00 00 00       	mov    $0x1,%edi
  421ea7:	e8 44 ef fd ff       	callq  400df0 <exit@plt>
  421eac:	44 0f be 0d 74 42 20 	movsbl 0x204274(%rip),%r9d        # 626128 <target_prefix>
  421eb3:	00 
  421eb4:	83 3d ed 35 20 00 00 	cmpl   $0x0,0x2035ed(%rip)        # 6254a8 <notify>
  421ebb:	74 09                	je     421ec6 <notify_server+0x5a>
  421ebd:	44 8b 05 3c 36 20 00 	mov    0x20363c(%rip),%r8d        # 625500 <authkey>
  421ec4:	eb 06                	jmp    421ecc <notify_server+0x60>
  421ec6:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
  421ecc:	85 db                	test   %ebx,%ebx
  421ece:	74 07                	je     421ed7 <notify_server+0x6b>
  421ed0:	b9 d1 35 42 00       	mov    $0x4235d1,%ecx
  421ed5:	eb 05                	jmp    421edc <notify_server+0x70>
  421ed7:	b9 d6 35 42 00       	mov    $0x4235d6,%ecx
  421edc:	48 c7 44 24 08 20 55 	movq   $0x625520,0x8(%rsp)
  421ee3:	62 00 
  421ee5:	89 34 24             	mov    %esi,(%rsp)
  421ee8:	8b 15 7a 32 20 00    	mov    0x20327a(%rip),%edx        # 625168 <target_id>
  421eee:	be db 35 42 00       	mov    $0x4235db,%esi
  421ef3:	48 8d bc 24 10 20 00 	lea    0x2010(%rsp),%rdi
  421efa:	00 
  421efb:	b8 00 00 00 00       	mov    $0x0,%eax
  421f00:	e8 db ee fd ff       	callq  400de0 <sprintf@plt>
  421f05:	83 3d 9c 35 20 00 00 	cmpl   $0x0,0x20359c(%rip)        # 6254a8 <notify>
  421f0c:	74 78                	je     421f86 <notify_server+0x11a>
  421f0e:	4c 8d 4c 24 10       	lea    0x10(%rsp),%r9
  421f13:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  421f19:	48 8d 8c 24 10 20 00 	lea    0x2010(%rsp),%rcx
  421f20:	00 
  421f21:	48 8b 15 48 32 20 00 	mov    0x203248(%rip),%rdx        # 625170 <lab>
  421f28:	48 8b 35 49 32 20 00 	mov    0x203249(%rip),%rsi        # 625178 <course>
  421f2f:	48 8b 3d 2a 32 20 00 	mov    0x20322a(%rip),%rdi        # 625160 <user_id>
  421f36:	e8 b3 0f 00 00       	callq  422eee <driver_post>
  421f3b:	85 c0                	test   %eax,%eax
  421f3d:	79 1e                	jns    421f5d <notify_server+0xf1>
  421f3f:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
  421f44:	bf f7 35 42 00       	mov    $0x4235f7,%edi
  421f49:	b8 00 00 00 00       	mov    $0x0,%eax
  421f4e:	e8 2d ed fd ff       	callq  400c80 <printf@plt>
  421f53:	bf 01 00 00 00       	mov    $0x1,%edi
  421f58:	e8 93 ee fd ff       	callq  400df0 <exit@plt>
  421f5d:	85 db                	test   %ebx,%ebx
  421f5f:	74 19                	je     421f7a <notify_server+0x10e>
  421f61:	bf 20 37 42 00       	mov    $0x423720,%edi
  421f66:	e8 e5 ec fd ff       	callq  400c50 <puts@plt>
  421f6b:	bf 03 36 42 00       	mov    $0x423603,%edi
  421f70:	e8 db ec fd ff       	callq  400c50 <puts@plt>
  421f75:	e9 85 00 00 00       	jmpq   421fff <notify_server+0x193>
  421f7a:	bf 0d 36 42 00       	mov    $0x42360d,%edi
  421f7f:	e8 cc ec fd ff       	callq  400c50 <puts@plt>
  421f84:	eb 79                	jmp    421fff <notify_server+0x193>
  421f86:	85 db                	test   %ebx,%ebx
  421f88:	74 08                	je     421f92 <notify_server+0x126>
  421f8a:	be d1 35 42 00       	mov    $0x4235d1,%esi
  421f8f:	90                   	nop
  421f90:	eb 05                	jmp    421f97 <notify_server+0x12b>
  421f92:	be d6 35 42 00       	mov    $0x4235d6,%esi
  421f97:	bf 58 37 42 00       	mov    $0x423758,%edi
  421f9c:	b8 00 00 00 00       	mov    $0x0,%eax
  421fa1:	e8 da ec fd ff       	callq  400c80 <printf@plt>
  421fa6:	48 8b 35 b3 31 20 00 	mov    0x2031b3(%rip),%rsi        # 625160 <user_id>
  421fad:	bf 14 36 42 00       	mov    $0x423614,%edi
  421fb2:	b8 00 00 00 00       	mov    $0x0,%eax
  421fb7:	e8 c4 ec fd ff       	callq  400c80 <printf@plt>
  421fbc:	48 8b 35 b5 31 20 00 	mov    0x2031b5(%rip),%rsi        # 625178 <course>
  421fc3:	bf 21 36 42 00       	mov    $0x423621,%edi
  421fc8:	b8 00 00 00 00       	mov    $0x0,%eax
  421fcd:	e8 ae ec fd ff       	callq  400c80 <printf@plt>
  421fd2:	48 8b 35 97 31 20 00 	mov    0x203197(%rip),%rsi        # 625170 <lab>
  421fd9:	bf 2d 36 42 00       	mov    $0x42362d,%edi
  421fde:	b8 00 00 00 00       	mov    $0x0,%eax
  421fe3:	e8 98 ec fd ff       	callq  400c80 <printf@plt>
  421fe8:	48 8d b4 24 10 20 00 	lea    0x2010(%rsp),%rsi
  421fef:	00 
  421ff0:	bf 36 36 42 00       	mov    $0x423636,%edi
  421ff5:	b8 00 00 00 00       	mov    $0x0,%eax
  421ffa:	e8 81 ec fd ff       	callq  400c80 <printf@plt>
  421fff:	48 81 c4 10 40 00 00 	add    $0x4010,%rsp
  422006:	5b                   	pop    %rbx
  422007:	f3 c3                	repz retq 

0000000000422009 <validate>:
  422009:	53                   	push   %rbx
  42200a:	89 fb                	mov    %edi,%ebx
  42200c:	83 3d f5 34 20 00 00 	cmpl   $0x0,0x2034f5(%rip)        # 625508 <is_checker>
  422013:	74 60                	je     422075 <validate+0x6c>
  422015:	39 3d e1 34 20 00    	cmp    %edi,0x2034e1(%rip)        # 6254fc <vlevel>
  42201b:	74 14                	je     422031 <validate+0x28>
  42201d:	bf 42 36 42 00       	mov    $0x423642,%edi
  422022:	e8 29 ec fd ff       	callq  400c50 <puts@plt>
  422027:	b8 00 00 00 00       	mov    $0x0,%eax
  42202c:	e8 ba fd ff ff       	callq  421deb <check_fail>
  422031:	8b 35 c1 34 20 00    	mov    0x2034c1(%rip),%esi        # 6254f8 <check_level>
  422037:	39 fe                	cmp    %edi,%esi
  422039:	74 1b                	je     422056 <validate+0x4d>
  42203b:	89 fa                	mov    %edi,%edx
  42203d:	bf 80 37 42 00       	mov    $0x423780,%edi
  422042:	b8 00 00 00 00       	mov    $0x0,%eax
  422047:	e8 34 ec fd ff       	callq  400c80 <printf@plt>
  42204c:	b8 00 00 00 00       	mov    $0x0,%eax
  422051:	e8 95 fd ff ff       	callq  421deb <check_fail>
  422056:	0f be 35 cb 40 20 00 	movsbl 0x2040cb(%rip),%esi        # 626128 <target_prefix>
  42205d:	b9 20 55 62 00       	mov    $0x625520,%ecx
  422062:	89 fa                	mov    %edi,%edx
  422064:	bf 60 36 42 00       	mov    $0x423660,%edi
  422069:	b8 00 00 00 00       	mov    $0x0,%eax
  42206e:	e8 0d ec fd ff       	callq  400c80 <printf@plt>
  422073:	eb 44                	jmp    4220b9 <validate+0xb0>
  422075:	39 3d 81 34 20 00    	cmp    %edi,0x203481(%rip)        # 6254fc <vlevel>
  42207b:	74 18                	je     422095 <validate+0x8c>
  42207d:	bf 42 36 42 00       	mov    $0x423642,%edi
  422082:	e8 c9 eb fd ff       	callq  400c50 <puts@plt>
  422087:	89 de                	mov    %ebx,%esi
  422089:	bf 00 00 00 00       	mov    $0x0,%edi
  42208e:	e8 d9 fd ff ff       	callq  421e6c <notify_server>
  422093:	eb 24                	jmp    4220b9 <validate+0xb0>
  422095:	0f be 15 8c 40 20 00 	movsbl 0x20408c(%rip),%edx        # 626128 <target_prefix>
  42209c:	89 fe                	mov    %edi,%esi
  42209e:	bf a8 37 42 00       	mov    $0x4237a8,%edi
  4220a3:	b8 00 00 00 00       	mov    $0x0,%eax
  4220a8:	e8 d3 eb fd ff       	callq  400c80 <printf@plt>
  4220ad:	89 de                	mov    %ebx,%esi
  4220af:	bf 01 00 00 00       	mov    $0x1,%edi
  4220b4:	e8 b3 fd ff ff       	callq  421e6c <notify_server>
  4220b9:	5b                   	pop    %rbx
  4220ba:	c3                   	retq   

00000000004220bb <fail>:
  4220bb:	48 83 ec 08          	sub    $0x8,%rsp
  4220bf:	83 3d 42 34 20 00 00 	cmpl   $0x0,0x203442(%rip)        # 625508 <is_checker>
  4220c6:	74 0a                	je     4220d2 <fail+0x17>
  4220c8:	b8 00 00 00 00       	mov    $0x0,%eax
  4220cd:	e8 19 fd ff ff       	callq  421deb <check_fail>
  4220d2:	89 fe                	mov    %edi,%esi
  4220d4:	bf 00 00 00 00       	mov    $0x0,%edi
  4220d9:	e8 8e fd ff ff       	callq  421e6c <notify_server>
  4220de:	48 83 c4 08          	add    $0x8,%rsp
  4220e2:	c3                   	retq   

00000000004220e3 <bushandler>:
  4220e3:	48 83 ec 08          	sub    $0x8,%rsp
  4220e7:	83 3d 1a 34 20 00 00 	cmpl   $0x0,0x20341a(%rip)        # 625508 <is_checker>
  4220ee:	74 14                	je     422104 <bushandler+0x21>
  4220f0:	bf 75 36 42 00       	mov    $0x423675,%edi
  4220f5:	e8 56 eb fd ff       	callq  400c50 <puts@plt>
  4220fa:	b8 00 00 00 00       	mov    $0x0,%eax
  4220ff:	e8 e7 fc ff ff       	callq  421deb <check_fail>
  422104:	bf e0 37 42 00       	mov    $0x4237e0,%edi
  422109:	e8 42 eb fd ff       	callq  400c50 <puts@plt>
  42210e:	bf 7f 36 42 00       	mov    $0x42367f,%edi
  422113:	e8 38 eb fd ff       	callq  400c50 <puts@plt>
  422118:	be 00 00 00 00       	mov    $0x0,%esi
  42211d:	bf 00 00 00 00       	mov    $0x0,%edi
  422122:	e8 45 fd ff ff       	callq  421e6c <notify_server>
  422127:	bf 01 00 00 00       	mov    $0x1,%edi
  42212c:	e8 bf ec fd ff       	callq  400df0 <exit@plt>

0000000000422131 <seghandler>:
  422131:	48 83 ec 08          	sub    $0x8,%rsp
  422135:	83 3d cc 33 20 00 00 	cmpl   $0x0,0x2033cc(%rip)        # 625508 <is_checker>
  42213c:	74 14                	je     422152 <seghandler+0x21>
  42213e:	bf 95 36 42 00       	mov    $0x423695,%edi
  422143:	e8 08 eb fd ff       	callq  400c50 <puts@plt>
  422148:	b8 00 00 00 00       	mov    $0x0,%eax
  42214d:	e8 99 fc ff ff       	callq  421deb <check_fail>
  422152:	bf 00 38 42 00       	mov    $0x423800,%edi
  422157:	e8 f4 ea fd ff       	callq  400c50 <puts@plt>
  42215c:	bf 7f 36 42 00       	mov    $0x42367f,%edi
  422161:	e8 ea ea fd ff       	callq  400c50 <puts@plt>
  422166:	be 00 00 00 00       	mov    $0x0,%esi
  42216b:	bf 00 00 00 00       	mov    $0x0,%edi
  422170:	e8 f7 fc ff ff       	callq  421e6c <notify_server>
  422175:	bf 01 00 00 00       	mov    $0x1,%edi
  42217a:	e8 71 ec fd ff       	callq  400df0 <exit@plt>

000000000042217f <illegalhandler>:
  42217f:	48 83 ec 08          	sub    $0x8,%rsp
  422183:	83 3d 7e 33 20 00 00 	cmpl   $0x0,0x20337e(%rip)        # 625508 <is_checker>
  42218a:	74 14                	je     4221a0 <illegalhandler+0x21>
  42218c:	bf a8 36 42 00       	mov    $0x4236a8,%edi
  422191:	e8 ba ea fd ff       	callq  400c50 <puts@plt>
  422196:	b8 00 00 00 00       	mov    $0x0,%eax
  42219b:	e8 4b fc ff ff       	callq  421deb <check_fail>
  4221a0:	bf 28 38 42 00       	mov    $0x423828,%edi
  4221a5:	e8 a6 ea fd ff       	callq  400c50 <puts@plt>
  4221aa:	bf 7f 36 42 00       	mov    $0x42367f,%edi
  4221af:	e8 9c ea fd ff       	callq  400c50 <puts@plt>
  4221b4:	be 00 00 00 00       	mov    $0x0,%esi
  4221b9:	bf 00 00 00 00       	mov    $0x0,%edi
  4221be:	e8 a9 fc ff ff       	callq  421e6c <notify_server>
  4221c3:	bf 01 00 00 00       	mov    $0x1,%edi
  4221c8:	e8 23 ec fd ff       	callq  400df0 <exit@plt>

00000000004221cd <sigalrmhandler>:
  4221cd:	48 83 ec 08          	sub    $0x8,%rsp
  4221d1:	83 3d 30 33 20 00 00 	cmpl   $0x0,0x203330(%rip)        # 625508 <is_checker>
  4221d8:	74 14                	je     4221ee <sigalrmhandler+0x21>
  4221da:	bf bc 36 42 00       	mov    $0x4236bc,%edi
  4221df:	e8 6c ea fd ff       	callq  400c50 <puts@plt>
  4221e4:	b8 00 00 00 00       	mov    $0x0,%eax
  4221e9:	e8 fd fb ff ff       	callq  421deb <check_fail>
  4221ee:	be 05 00 00 00       	mov    $0x5,%esi
  4221f3:	bf 58 38 42 00       	mov    $0x423858,%edi
  4221f8:	b8 00 00 00 00       	mov    $0x0,%eax
  4221fd:	e8 7e ea fd ff       	callq  400c80 <printf@plt>
  422202:	be 00 00 00 00       	mov    $0x0,%esi
  422207:	bf 00 00 00 00       	mov    $0x0,%edi
  42220c:	e8 5b fc ff ff       	callq  421e6c <notify_server>
  422211:	bf 01 00 00 00       	mov    $0x1,%edi
  422216:	e8 d5 eb fd ff       	callq  400df0 <exit@plt>

000000000042221b <launch>:
  42221b:	55                   	push   %rbp
  42221c:	48 89 e5             	mov    %rsp,%rbp
  42221f:	48 89 fa             	mov    %rdi,%rdx
  422222:	48 8d 47 1e          	lea    0x1e(%rdi),%rax
  422226:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  42222a:	48 29 c4             	sub    %rax,%rsp
  42222d:	48 8d 7c 24 0f       	lea    0xf(%rsp),%rdi
  422232:	48 83 e7 f0          	and    $0xfffffffffffffff0,%rdi
  422236:	be f4 00 00 00       	mov    $0xf4,%esi
  42223b:	e8 50 ea fd ff       	callq  400c90 <memset@plt>
  422240:	48 8b 05 79 32 20 00 	mov    0x203279(%rip),%rax        # 6254c0 <stdin@@GLIBC_2.2.5>
  422247:	48 39 05 a2 32 20 00 	cmp    %rax,0x2032a2(%rip)        # 6254f0 <infile>
  42224e:	75 0f                	jne    42225f <launch+0x44>
  422250:	bf c4 36 42 00       	mov    $0x4236c4,%edi
  422255:	b8 00 00 00 00       	mov    $0x0,%eax
  42225a:	e8 21 ea fd ff       	callq  400c80 <printf@plt>
  42225f:	c7 05 93 32 20 00 00 	movl   $0x0,0x203293(%rip)        # 6254fc <vlevel>
  422266:	00 00 00 
  422269:	b8 00 00 00 00       	mov    $0x0,%eax
  42226e:	e8 df fa ff ff       	callq  421d52 <test>
  422273:	83 3d 8e 32 20 00 00 	cmpl   $0x0,0x20328e(%rip)        # 625508 <is_checker>
  42227a:	74 14                	je     422290 <launch+0x75>
  42227c:	bf d1 36 42 00       	mov    $0x4236d1,%edi
  422281:	e8 ca e9 fd ff       	callq  400c50 <puts@plt>
  422286:	b8 00 00 00 00       	mov    $0x0,%eax
  42228b:	e8 5b fb ff ff       	callq  421deb <check_fail>
  422290:	bf dc 36 42 00       	mov    $0x4236dc,%edi
  422295:	e8 b6 e9 fd ff       	callq  400c50 <puts@plt>
  42229a:	c9                   	leaveq 
  42229b:	c3                   	retq   

000000000042229c <stable_launch>:
  42229c:	53                   	push   %rbx
  42229d:	48 89 3d 44 32 20 00 	mov    %rdi,0x203244(%rip)        # 6254e8 <global_offset>
  4222a4:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  4222aa:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  4222b0:	b9 32 01 00 00       	mov    $0x132,%ecx
  4222b5:	ba 07 00 00 00       	mov    $0x7,%edx
  4222ba:	be 00 00 10 00       	mov    $0x100000,%esi
  4222bf:	bf 00 60 58 55       	mov    $0x55586000,%edi
  4222c4:	e8 a7 e9 fd ff       	callq  400c70 <mmap@plt>
  4222c9:	48 89 c3             	mov    %rax,%rbx
  4222cc:	48 3d 00 60 58 55    	cmp    $0x55586000,%rax
  4222d2:	74 32                	je     422306 <stable_launch+0x6a>
  4222d4:	be 00 00 10 00       	mov    $0x100000,%esi
  4222d9:	48 89 c7             	mov    %rax,%rdi
  4222dc:	e8 9f ea fd ff       	callq  400d80 <munmap@plt>
  4222e1:	ba 00 60 58 55       	mov    $0x55586000,%edx
  4222e6:	be 90 38 42 00       	mov    $0x423890,%esi
  4222eb:	48 8b 3d de 31 20 00 	mov    0x2031de(%rip),%rdi        # 6254d0 <stderr@@GLIBC_2.2.5>
  4222f2:	b8 00 00 00 00       	mov    $0x0,%eax
  4222f7:	e8 04 ea fd ff       	callq  400d00 <fprintf@plt>
  4222fc:	bf 01 00 00 00       	mov    $0x1,%edi
  422301:	e8 ea ea fd ff       	callq  400df0 <exit@plt>
  422306:	48 8d 90 f8 ff 0f 00 	lea    0xffff8(%rax),%rdx
  42230d:	48 89 15 1c 3e 20 00 	mov    %rdx,0x203e1c(%rip)        # 626130 <stack_top>
  422314:	48 89 e0             	mov    %rsp,%rax
  422317:	48 89 d4             	mov    %rdx,%rsp
  42231a:	48 89 c2             	mov    %rax,%rdx
  42231d:	48 89 15 bc 31 20 00 	mov    %rdx,0x2031bc(%rip)        # 6254e0 <global_save_stack>
  422324:	48 8b 3d bd 31 20 00 	mov    0x2031bd(%rip),%rdi        # 6254e8 <global_offset>
  42232b:	e8 eb fe ff ff       	callq  42221b <launch>
  422330:	48 8b 05 a9 31 20 00 	mov    0x2031a9(%rip),%rax        # 6254e0 <global_save_stack>
  422337:	48 89 c4             	mov    %rax,%rsp
  42233a:	be 00 00 10 00       	mov    $0x100000,%esi
  42233f:	48 89 df             	mov    %rbx,%rdi
  422342:	e8 39 ea fd ff       	callq  400d80 <munmap@plt>
  422347:	5b                   	pop    %rbx
  422348:	c3                   	retq   
  422349:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000422350 <rio_readinitb>:
  422350:	89 37                	mov    %esi,(%rdi)
  422352:	c7 47 04 00 00 00 00 	movl   $0x0,0x4(%rdi)
  422359:	48 8d 47 10          	lea    0x10(%rdi),%rax
  42235d:	48 89 47 08          	mov    %rax,0x8(%rdi)
  422361:	c3                   	retq   

0000000000422362 <sigalrm_handler>:
  422362:	48 83 ec 08          	sub    $0x8,%rsp
  422366:	ba 00 00 00 00       	mov    $0x0,%edx
  42236b:	be d0 38 42 00       	mov    $0x4238d0,%esi
  422370:	48 8b 3d 59 31 20 00 	mov    0x203159(%rip),%rdi        # 6254d0 <stderr@@GLIBC_2.2.5>
  422377:	b8 00 00 00 00       	mov    $0x0,%eax
  42237c:	e8 7f e9 fd ff       	callq  400d00 <fprintf@plt>
  422381:	bf 01 00 00 00       	mov    $0x1,%edi
  422386:	e8 65 ea fd ff       	callq  400df0 <exit@plt>

000000000042238b <urlencode>:
  42238b:	41 54                	push   %r12
  42238d:	55                   	push   %rbp
  42238e:	53                   	push   %rbx
  42238f:	48 83 ec 10          	sub    $0x10,%rsp
  422393:	48 89 fb             	mov    %rdi,%rbx
  422396:	48 89 f5             	mov    %rsi,%rbp
  422399:	b8 00 00 00 00       	mov    $0x0,%eax
  42239e:	48 c7 c1 ff ff ff ff 	mov    $0xffffffffffffffff,%rcx
  4223a5:	f2 ae                	repnz scas %es:(%rdi),%al
  4223a7:	48 f7 d1             	not    %rcx
  4223aa:	8d 41 ff             	lea    -0x1(%rcx),%eax
  4223ad:	e9 93 00 00 00       	jmpq   422445 <urlencode+0xba>
  4223b2:	0f b6 13             	movzbl (%rbx),%edx
  4223b5:	80 fa 2a             	cmp    $0x2a,%dl
  4223b8:	0f 94 c1             	sete   %cl
  4223bb:	80 fa 2d             	cmp    $0x2d,%dl
  4223be:	0f 94 c0             	sete   %al
  4223c1:	08 c1                	or     %al,%cl
  4223c3:	75 1f                	jne    4223e4 <urlencode+0x59>
  4223c5:	80 fa 2e             	cmp    $0x2e,%dl
  4223c8:	74 1a                	je     4223e4 <urlencode+0x59>
  4223ca:	80 fa 5f             	cmp    $0x5f,%dl
  4223cd:	74 15                	je     4223e4 <urlencode+0x59>
  4223cf:	8d 42 d0             	lea    -0x30(%rdx),%eax
  4223d2:	3c 09                	cmp    $0x9,%al
  4223d4:	76 0e                	jbe    4223e4 <urlencode+0x59>
  4223d6:	8d 42 bf             	lea    -0x41(%rdx),%eax
  4223d9:	3c 19                	cmp    $0x19,%al
  4223db:	76 07                	jbe    4223e4 <urlencode+0x59>
  4223dd:	8d 42 9f             	lea    -0x61(%rdx),%eax
  4223e0:	3c 19                	cmp    $0x19,%al
  4223e2:	77 09                	ja     4223ed <urlencode+0x62>
  4223e4:	88 55 00             	mov    %dl,0x0(%rbp)
  4223e7:	48 8d 6d 01          	lea    0x1(%rbp),%rbp
  4223eb:	eb 51                	jmp    42243e <urlencode+0xb3>
  4223ed:	80 fa 20             	cmp    $0x20,%dl
  4223f0:	75 0a                	jne    4223fc <urlencode+0x71>
  4223f2:	c6 45 00 2b          	movb   $0x2b,0x0(%rbp)
  4223f6:	48 8d 6d 01          	lea    0x1(%rbp),%rbp
  4223fa:	eb 42                	jmp    42243e <urlencode+0xb3>
  4223fc:	8d 42 e0             	lea    -0x20(%rdx),%eax
  4223ff:	3c 5f                	cmp    $0x5f,%al
  422401:	0f 96 c1             	setbe  %cl
  422404:	80 fa 09             	cmp    $0x9,%dl
  422407:	0f 94 c0             	sete   %al
  42240a:	08 c1                	or     %al,%cl
  42240c:	74 45                	je     422453 <urlencode+0xc8>
  42240e:	0f b6 d2             	movzbl %dl,%edx
  422411:	be 88 39 42 00       	mov    $0x423988,%esi
  422416:	48 89 e7             	mov    %rsp,%rdi
  422419:	b8 00 00 00 00       	mov    $0x0,%eax
  42241e:	e8 bd e9 fd ff       	callq  400de0 <sprintf@plt>
  422423:	0f b6 04 24          	movzbl (%rsp),%eax
  422427:	88 45 00             	mov    %al,0x0(%rbp)
  42242a:	0f b6 44 24 01       	movzbl 0x1(%rsp),%eax
  42242f:	88 45 01             	mov    %al,0x1(%rbp)
  422432:	0f b6 44 24 02       	movzbl 0x2(%rsp),%eax
  422437:	88 45 02             	mov    %al,0x2(%rbp)
  42243a:	48 8d 6d 03          	lea    0x3(%rbp),%rbp
  42243e:	48 83 c3 01          	add    $0x1,%rbx
  422442:	44 89 e0             	mov    %r12d,%eax
  422445:	44 8d 60 ff          	lea    -0x1(%rax),%r12d
  422449:	85 c0                	test   %eax,%eax
  42244b:	0f 85 61 ff ff ff    	jne    4223b2 <urlencode+0x27>
  422451:	eb 05                	jmp    422458 <urlencode+0xcd>
  422453:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  422458:	48 83 c4 10          	add    $0x10,%rsp
  42245c:	5b                   	pop    %rbx
  42245d:	5d                   	pop    %rbp
  42245e:	41 5c                	pop    %r12
  422460:	c3                   	retq   

0000000000422461 <rio_writen>:
  422461:	41 55                	push   %r13
  422463:	41 54                	push   %r12
  422465:	55                   	push   %rbp
  422466:	53                   	push   %rbx
  422467:	48 83 ec 08          	sub    $0x8,%rsp
  42246b:	41 89 fc             	mov    %edi,%r12d
  42246e:	48 89 f5             	mov    %rsi,%rbp
  422471:	49 89 d5             	mov    %rdx,%r13
  422474:	48 89 d3             	mov    %rdx,%rbx
  422477:	eb 28                	jmp    4224a1 <rio_writen+0x40>
  422479:	48 89 da             	mov    %rbx,%rdx
  42247c:	48 89 ee             	mov    %rbp,%rsi
  42247f:	44 89 e7             	mov    %r12d,%edi
  422482:	e8 d9 e7 fd ff       	callq  400c60 <write@plt>
  422487:	48 85 c0             	test   %rax,%rax
  42248a:	7f 0f                	jg     42249b <rio_writen+0x3a>
  42248c:	e8 7f e7 fd ff       	callq  400c10 <__errno_location@plt>
  422491:	83 38 04             	cmpl   $0x4,(%rax)
  422494:	75 15                	jne    4224ab <rio_writen+0x4a>
  422496:	b8 00 00 00 00       	mov    $0x0,%eax
  42249b:	48 29 c3             	sub    %rax,%rbx
  42249e:	48 01 c5             	add    %rax,%rbp
  4224a1:	48 85 db             	test   %rbx,%rbx
  4224a4:	75 d3                	jne    422479 <rio_writen+0x18>
  4224a6:	4c 89 e8             	mov    %r13,%rax
  4224a9:	eb 07                	jmp    4224b2 <rio_writen+0x51>
  4224ab:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  4224b2:	48 83 c4 08          	add    $0x8,%rsp
  4224b6:	5b                   	pop    %rbx
  4224b7:	5d                   	pop    %rbp
  4224b8:	41 5c                	pop    %r12
  4224ba:	41 5d                	pop    %r13
  4224bc:	c3                   	retq   

00000000004224bd <rio_read>:
  4224bd:	41 56                	push   %r14
  4224bf:	41 55                	push   %r13
  4224c1:	41 54                	push   %r12
  4224c3:	55                   	push   %rbp
  4224c4:	53                   	push   %rbx
  4224c5:	48 89 fb             	mov    %rdi,%rbx
  4224c8:	49 89 f6             	mov    %rsi,%r14
  4224cb:	49 89 d5             	mov    %rdx,%r13
  4224ce:	4c 8d 67 10          	lea    0x10(%rdi),%r12
  4224d2:	eb 2a                	jmp    4224fe <rio_read+0x41>
  4224d4:	ba 00 20 00 00       	mov    $0x2000,%edx
  4224d9:	4c 89 e6             	mov    %r12,%rsi
  4224dc:	8b 3b                	mov    (%rbx),%edi
  4224de:	e8 dd e7 fd ff       	callq  400cc0 <read@plt>
  4224e3:	89 43 04             	mov    %eax,0x4(%rbx)
  4224e6:	85 c0                	test   %eax,%eax
  4224e8:	79 0c                	jns    4224f6 <rio_read+0x39>
  4224ea:	e8 21 e7 fd ff       	callq  400c10 <__errno_location@plt>
  4224ef:	83 38 04             	cmpl   $0x4,(%rax)
  4224f2:	74 0a                	je     4224fe <rio_read+0x41>
  4224f4:	eb 37                	jmp    42252d <rio_read+0x70>
  4224f6:	85 c0                	test   %eax,%eax
  4224f8:	74 3c                	je     422536 <rio_read+0x79>
  4224fa:	4c 89 63 08          	mov    %r12,0x8(%rbx)
  4224fe:	8b 6b 04             	mov    0x4(%rbx),%ebp
  422501:	85 ed                	test   %ebp,%ebp
  422503:	7e cf                	jle    4224d4 <rio_read+0x17>
  422505:	89 e8                	mov    %ebp,%eax
  422507:	4c 39 e8             	cmp    %r13,%rax
  42250a:	72 03                	jb     42250f <rio_read+0x52>
  42250c:	44 89 ed             	mov    %r13d,%ebp
  42250f:	4c 63 e5             	movslq %ebp,%r12
  422512:	48 8b 73 08          	mov    0x8(%rbx),%rsi
  422516:	4c 89 e2             	mov    %r12,%rdx
  422519:	4c 89 f7             	mov    %r14,%rdi
  42251c:	e8 0f e8 fd ff       	callq  400d30 <memcpy@plt>
  422521:	4c 01 63 08          	add    %r12,0x8(%rbx)
  422525:	29 6b 04             	sub    %ebp,0x4(%rbx)
  422528:	4c 89 e0             	mov    %r12,%rax
  42252b:	eb 0e                	jmp    42253b <rio_read+0x7e>
  42252d:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  422534:	eb 05                	jmp    42253b <rio_read+0x7e>
  422536:	b8 00 00 00 00       	mov    $0x0,%eax
  42253b:	5b                   	pop    %rbx
  42253c:	5d                   	pop    %rbp
  42253d:	41 5c                	pop    %r12
  42253f:	41 5d                	pop    %r13
  422541:	41 5e                	pop    %r14
  422543:	c3                   	retq   

0000000000422544 <rio_readlineb>:
  422544:	41 55                	push   %r13
  422546:	41 54                	push   %r12
  422548:	55                   	push   %rbp
  422549:	53                   	push   %rbx
  42254a:	48 83 ec 18          	sub    $0x18,%rsp
  42254e:	49 89 fd             	mov    %rdi,%r13
  422551:	48 89 f5             	mov    %rsi,%rbp
  422554:	49 89 d4             	mov    %rdx,%r12
  422557:	bb 01 00 00 00       	mov    $0x1,%ebx
  42255c:	eb 3d                	jmp    42259b <rio_readlineb+0x57>
  42255e:	ba 01 00 00 00       	mov    $0x1,%edx
  422563:	48 8d 74 24 0f       	lea    0xf(%rsp),%rsi
  422568:	4c 89 ef             	mov    %r13,%rdi
  42256b:	e8 4d ff ff ff       	callq  4224bd <rio_read>
  422570:	83 f8 01             	cmp    $0x1,%eax
  422573:	75 12                	jne    422587 <rio_readlineb+0x43>
  422575:	48 8d 55 01          	lea    0x1(%rbp),%rdx
  422579:	0f b6 44 24 0f       	movzbl 0xf(%rsp),%eax
  42257e:	88 45 00             	mov    %al,0x0(%rbp)
  422581:	3c 0a                	cmp    $0xa,%al
  422583:	75 0f                	jne    422594 <rio_readlineb+0x50>
  422585:	eb 1b                	jmp    4225a2 <rio_readlineb+0x5e>
  422587:	85 c0                	test   %eax,%eax
  422589:	75 23                	jne    4225ae <rio_readlineb+0x6a>
  42258b:	48 83 fb 01          	cmp    $0x1,%rbx
  42258f:	90                   	nop
  422590:	75 13                	jne    4225a5 <rio_readlineb+0x61>
  422592:	eb 23                	jmp    4225b7 <rio_readlineb+0x73>
  422594:	48 83 c3 01          	add    $0x1,%rbx
  422598:	48 89 d5             	mov    %rdx,%rbp
  42259b:	4c 39 e3             	cmp    %r12,%rbx
  42259e:	72 be                	jb     42255e <rio_readlineb+0x1a>
  4225a0:	eb 03                	jmp    4225a5 <rio_readlineb+0x61>
  4225a2:	48 89 d5             	mov    %rdx,%rbp
  4225a5:	c6 45 00 00          	movb   $0x0,0x0(%rbp)
  4225a9:	48 89 d8             	mov    %rbx,%rax
  4225ac:	eb 0e                	jmp    4225bc <rio_readlineb+0x78>
  4225ae:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  4225b5:	eb 05                	jmp    4225bc <rio_readlineb+0x78>
  4225b7:	b8 00 00 00 00       	mov    $0x0,%eax
  4225bc:	48 83 c4 18          	add    $0x18,%rsp
  4225c0:	5b                   	pop    %rbx
  4225c1:	5d                   	pop    %rbp
  4225c2:	41 5c                	pop    %r12
  4225c4:	41 5d                	pop    %r13
  4225c6:	c3                   	retq   

00000000004225c7 <submitr>:
  4225c7:	41 57                	push   %r15
  4225c9:	41 56                	push   %r14
  4225cb:	41 55                	push   %r13
  4225cd:	41 54                	push   %r12
  4225cf:	55                   	push   %rbp
  4225d0:	53                   	push   %rbx
  4225d1:	48 81 ec 58 a0 00 00 	sub    $0xa058,%rsp
  4225d8:	49 89 fc             	mov    %rdi,%r12
  4225db:	89 74 24 1c          	mov    %esi,0x1c(%rsp)
  4225df:	48 89 54 24 10       	mov    %rdx,0x10(%rsp)
  4225e4:	49 89 cf             	mov    %rcx,%r15
  4225e7:	4d 89 c6             	mov    %r8,%r14
  4225ea:	4d 89 cd             	mov    %r9,%r13
  4225ed:	48 8b 9c 24 90 a0 00 	mov    0xa090(%rsp),%rbx
  4225f4:	00 
  4225f5:	c7 84 24 2c 20 00 00 	movl   $0x0,0x202c(%rsp)
  4225fc:	00 00 00 00 
  422600:	ba 00 00 00 00       	mov    $0x0,%edx
  422605:	be 01 00 00 00       	mov    $0x1,%esi
  42260a:	bf 02 00 00 00       	mov    $0x2,%edi
  42260f:	e8 fc e7 fd ff       	callq  400e10 <socket@plt>
  422614:	89 c5                	mov    %eax,%ebp
  422616:	85 c0                	test   %eax,%eax
  422618:	79 4e                	jns    422668 <submitr+0xa1>
  42261a:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
  422621:	3a 20 43 
  422624:	48 89 03             	mov    %rax,(%rbx)
  422627:	48 b8 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rax
  42262e:	20 75 6e 
  422631:	48 89 43 08          	mov    %rax,0x8(%rbx)
  422635:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  42263c:	74 6f 20 
  42263f:	48 89 43 10          	mov    %rax,0x10(%rbx)
  422643:	48 b8 63 72 65 61 74 	movabs $0x7320657461657263,%rax
  42264a:	65 20 73 
  42264d:	48 89 43 18          	mov    %rax,0x18(%rbx)
  422651:	c7 43 20 6f 63 6b 65 	movl   $0x656b636f,0x20(%rbx)
  422658:	66 c7 43 24 74 00    	movw   $0x74,0x24(%rbx)
  42265e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  422663:	e9 83 06 00 00       	jmpq   422ceb <submitr+0x724>
  422668:	4c 89 e7             	mov    %r12,%rdi
  42266b:	e8 80 e6 fd ff       	callq  400cf0 <gethostbyname@plt>
  422670:	48 85 c0             	test   %rax,%rax
  422673:	75 75                	jne    4226ea <submitr+0x123>
  422675:	48 b8 45 72 72 6f 72 	movabs $0x44203a726f727245,%rax
  42267c:	3a 20 44 
  42267f:	48 89 03             	mov    %rax,(%rbx)
  422682:	48 b8 4e 53 20 69 73 	movabs $0x6e7520736920534e,%rax
  422689:	20 75 6e 
  42268c:	48 89 43 08          	mov    %rax,0x8(%rbx)
  422690:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  422697:	74 6f 20 
  42269a:	48 89 43 10          	mov    %rax,0x10(%rbx)
  42269e:	48 b8 72 65 73 6f 6c 	movabs $0x2065766c6f736572,%rax
  4226a5:	76 65 20 
  4226a8:	48 89 43 18          	mov    %rax,0x18(%rbx)
  4226ac:	48 b8 41 75 74 6f 6c 	movabs $0x2062616c6f747541,%rax
  4226b3:	61 62 20 
  4226b6:	48 89 43 20          	mov    %rax,0x20(%rbx)
  4226ba:	48 b8 73 65 72 76 65 	movabs $0x6120726576726573,%rax
  4226c1:	72 20 61 
  4226c4:	48 89 43 28          	mov    %rax,0x28(%rbx)
  4226c8:	c7 43 30 64 64 72 65 	movl   $0x65726464,0x30(%rbx)
  4226cf:	66 c7 43 34 73 73    	movw   $0x7373,0x34(%rbx)
  4226d5:	c6 43 36 00          	movb   $0x0,0x36(%rbx)
  4226d9:	89 ef                	mov    %ebp,%edi
  4226db:	e8 d0 e5 fd ff       	callq  400cb0 <close@plt>
  4226e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  4226e5:	e9 01 06 00 00       	jmpq   422ceb <submitr+0x724>
  4226ea:	48 c7 84 24 40 a0 00 	movq   $0x0,0xa040(%rsp)
  4226f1:	00 00 00 00 00 
  4226f6:	48 c7 84 24 48 a0 00 	movq   $0x0,0xa048(%rsp)
  4226fd:	00 00 00 00 00 
  422702:	66 c7 84 24 40 a0 00 	movw   $0x2,0xa040(%rsp)
  422709:	00 02 00 
  42270c:	48 8b 48 18          	mov    0x18(%rax),%rcx
  422710:	48 63 50 14          	movslq 0x14(%rax),%rdx
  422714:	48 8d b4 24 44 a0 00 	lea    0xa044(%rsp),%rsi
  42271b:	00 
  42271c:	48 8b 39             	mov    (%rcx),%rdi
  42271f:	e8 6c e6 fd ff       	callq  400d90 <bcopy@plt>
  422724:	0f b7 44 24 1c       	movzwl 0x1c(%rsp),%eax
  422729:	66 c1 c8 08          	ror    $0x8,%ax
  42272d:	66 89 84 24 42 a0 00 	mov    %ax,0xa042(%rsp)
  422734:	00 
  422735:	ba 10 00 00 00       	mov    $0x10,%edx
  42273a:	48 8d b4 24 40 a0 00 	lea    0xa040(%rsp),%rsi
  422741:	00 
  422742:	89 ef                	mov    %ebp,%edi
  422744:	e8 b7 e6 fd ff       	callq  400e00 <connect@plt>
  422749:	85 c0                	test   %eax,%eax
  42274b:	79 67                	jns    4227b4 <submitr+0x1ed>
  42274d:	48 b8 45 72 72 6f 72 	movabs $0x55203a726f727245,%rax
  422754:	3a 20 55 
  422757:	48 89 03             	mov    %rax,(%rbx)
  42275a:	48 b8 6e 61 62 6c 65 	movabs $0x6f7420656c62616e,%rax
  422761:	20 74 6f 
  422764:	48 89 43 08          	mov    %rax,0x8(%rbx)
  422768:	48 b8 20 63 6f 6e 6e 	movabs $0x7463656e6e6f6320,%rax
  42276f:	65 63 74 
  422772:	48 89 43 10          	mov    %rax,0x10(%rbx)
  422776:	48 b8 20 74 6f 20 74 	movabs $0x20656874206f7420,%rax
  42277d:	68 65 20 
  422780:	48 89 43 18          	mov    %rax,0x18(%rbx)
  422784:	48 b8 41 75 74 6f 6c 	movabs $0x2062616c6f747541,%rax
  42278b:	61 62 20 
  42278e:	48 89 43 20          	mov    %rax,0x20(%rbx)
  422792:	c7 43 28 73 65 72 76 	movl   $0x76726573,0x28(%rbx)
  422799:	66 c7 43 2c 65 72    	movw   $0x7265,0x2c(%rbx)
  42279f:	c6 43 2e 00          	movb   $0x0,0x2e(%rbx)
  4227a3:	89 ef                	mov    %ebp,%edi
  4227a5:	e8 06 e5 fd ff       	callq  400cb0 <close@plt>
  4227aa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  4227af:	e9 37 05 00 00       	jmpq   422ceb <submitr+0x724>
  4227b4:	48 c7 c2 ff ff ff ff 	mov    $0xffffffffffffffff,%rdx
  4227bb:	4c 89 ef             	mov    %r13,%rdi
  4227be:	b8 00 00 00 00       	mov    $0x0,%eax
  4227c3:	48 89 d1             	mov    %rdx,%rcx
  4227c6:	f2 ae                	repnz scas %es:(%rdi),%al
  4227c8:	48 f7 d1             	not    %rcx
  4227cb:	48 89 ce             	mov    %rcx,%rsi
  4227ce:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
  4227d3:	48 89 d1             	mov    %rdx,%rcx
  4227d6:	f2 ae                	repnz scas %es:(%rdi),%al
  4227d8:	48 f7 d1             	not    %rcx
  4227db:	49 89 c8             	mov    %rcx,%r8
  4227de:	4c 89 ff             	mov    %r15,%rdi
  4227e1:	48 89 d1             	mov    %rdx,%rcx
  4227e4:	f2 ae                	repnz scas %es:(%rdi),%al
  4227e6:	49 29 c8             	sub    %rcx,%r8
  4227e9:	4c 89 f7             	mov    %r14,%rdi
  4227ec:	48 89 d1             	mov    %rdx,%rcx
  4227ef:	f2 ae                	repnz scas %es:(%rdi),%al
  4227f1:	49 29 c8             	sub    %rcx,%r8
  4227f4:	48 8d 44 76 fd       	lea    -0x3(%rsi,%rsi,2),%rax
  4227f9:	49 8d 44 00 7b       	lea    0x7b(%r8,%rax,1),%rax
  4227fe:	48 3d 00 20 00 00    	cmp    $0x2000,%rax
  422804:	76 72                	jbe    422878 <submitr+0x2b1>
  422806:	48 b8 45 72 72 6f 72 	movabs $0x52203a726f727245,%rax
  42280d:	3a 20 52 
  422810:	48 89 03             	mov    %rax,(%rbx)
  422813:	48 b8 65 73 75 6c 74 	movabs $0x747320746c757365,%rax
  42281a:	20 73 74 
  42281d:	48 89 43 08          	mov    %rax,0x8(%rbx)
  422821:	48 b8 72 69 6e 67 20 	movabs $0x6f6f7420676e6972,%rax
  422828:	74 6f 6f 
  42282b:	48 89 43 10          	mov    %rax,0x10(%rbx)
  42282f:	48 b8 20 6c 61 72 67 	movabs $0x202e656772616c20,%rax
  422836:	65 2e 20 
  422839:	48 89 43 18          	mov    %rax,0x18(%rbx)
  42283d:	48 b8 49 6e 63 72 65 	movabs $0x6573616572636e49,%rax
  422844:	61 73 65 
  422847:	48 89 43 20          	mov    %rax,0x20(%rbx)
  42284b:	48 b8 20 53 55 42 4d 	movabs $0x5254494d42555320,%rax
  422852:	49 54 52 
  422855:	48 89 43 28          	mov    %rax,0x28(%rbx)
  422859:	48 b8 5f 4d 41 58 42 	movabs $0x46554258414d5f,%rax
  422860:	55 46 00 
  422863:	48 89 43 30          	mov    %rax,0x30(%rbx)
  422867:	89 ef                	mov    %ebp,%edi
  422869:	e8 42 e4 fd ff       	callq  400cb0 <close@plt>
  42286e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  422873:	e9 73 04 00 00       	jmpq   422ceb <submitr+0x724>
  422878:	48 8d b4 24 30 40 00 	lea    0x4030(%rsp),%rsi
  42287f:	00 
  422880:	b9 00 04 00 00       	mov    $0x400,%ecx
  422885:	b8 00 00 00 00       	mov    $0x0,%eax
  42288a:	48 89 f7             	mov    %rsi,%rdi
  42288d:	f3 48 ab             	rep stos %rax,%es:(%rdi)
  422890:	4c 89 ef             	mov    %r13,%rdi
  422893:	e8 f3 fa ff ff       	callq  42238b <urlencode>
  422898:	85 c0                	test   %eax,%eax
  42289a:	0f 89 8a 00 00 00    	jns    42292a <submitr+0x363>
  4228a0:	48 b8 45 72 72 6f 72 	movabs $0x52203a726f727245,%rax
  4228a7:	3a 20 52 
  4228aa:	48 89 03             	mov    %rax,(%rbx)
  4228ad:	48 b8 65 73 75 6c 74 	movabs $0x747320746c757365,%rax
  4228b4:	20 73 74 
  4228b7:	48 89 43 08          	mov    %rax,0x8(%rbx)
  4228bb:	48 b8 72 69 6e 67 20 	movabs $0x6e6f6320676e6972,%rax
  4228c2:	63 6f 6e 
  4228c5:	48 89 43 10          	mov    %rax,0x10(%rbx)
  4228c9:	48 b8 74 61 69 6e 73 	movabs $0x6e6120736e696174,%rax
  4228d0:	20 61 6e 
  4228d3:	48 89 43 18          	mov    %rax,0x18(%rbx)
  4228d7:	48 b8 20 69 6c 6c 65 	movabs $0x6c6167656c6c6920,%rax
  4228de:	67 61 6c 
  4228e1:	48 89 43 20          	mov    %rax,0x20(%rbx)
  4228e5:	48 b8 20 6f 72 20 75 	movabs $0x72706e7520726f20,%rax
  4228ec:	6e 70 72 
  4228ef:	48 89 43 28          	mov    %rax,0x28(%rbx)
  4228f3:	48 b8 69 6e 74 61 62 	movabs $0x20656c6261746e69,%rax
  4228fa:	6c 65 20 
  4228fd:	48 89 43 30          	mov    %rax,0x30(%rbx)
  422901:	48 b8 63 68 61 72 61 	movabs $0x6574636172616863,%rax
  422908:	63 74 65 
  42290b:	48 89 43 38          	mov    %rax,0x38(%rbx)
  42290f:	66 c7 43 40 72 2e    	movw   $0x2e72,0x40(%rbx)
  422915:	c6 43 42 00          	movb   $0x0,0x42(%rbx)
  422919:	89 ef                	mov    %ebp,%edi
  42291b:	e8 90 e3 fd ff       	callq  400cb0 <close@plt>
  422920:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  422925:	e9 c1 03 00 00       	jmpq   422ceb <submitr+0x724>
  42292a:	4c 89 24 24          	mov    %r12,(%rsp)
  42292e:	4c 8d 8c 24 30 40 00 	lea    0x4030(%rsp),%r9
  422935:	00 
  422936:	4d 89 f8             	mov    %r15,%r8
  422939:	4c 89 f1             	mov    %r14,%rcx
  42293c:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
  422941:	be f8 38 42 00       	mov    $0x4238f8,%esi
  422946:	48 8d bc 24 30 60 00 	lea    0x6030(%rsp),%rdi
  42294d:	00 
  42294e:	b8 00 00 00 00       	mov    $0x0,%eax
  422953:	e8 88 e4 fd ff       	callq  400de0 <sprintf@plt>
  422958:	48 8d bc 24 30 60 00 	lea    0x6030(%rsp),%rdi
  42295f:	00 
  422960:	b8 00 00 00 00       	mov    $0x0,%eax
  422965:	48 c7 c1 ff ff ff ff 	mov    $0xffffffffffffffff,%rcx
  42296c:	f2 ae                	repnz scas %es:(%rdi),%al
  42296e:	48 f7 d1             	not    %rcx
  422971:	48 8d 51 ff          	lea    -0x1(%rcx),%rdx
  422975:	48 8d b4 24 30 60 00 	lea    0x6030(%rsp),%rsi
  42297c:	00 
  42297d:	89 ef                	mov    %ebp,%edi
  42297f:	e8 dd fa ff ff       	callq  422461 <rio_writen>
  422984:	48 85 c0             	test   %rax,%rax
  422987:	79 6b                	jns    4229f4 <submitr+0x42d>
  422989:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
  422990:	3a 20 43 
  422993:	48 89 03             	mov    %rax,(%rbx)
  422996:	48 b8 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rax
  42299d:	20 75 6e 
  4229a0:	48 89 43 08          	mov    %rax,0x8(%rbx)
  4229a4:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  4229ab:	74 6f 20 
  4229ae:	48 89 43 10          	mov    %rax,0x10(%rbx)
  4229b2:	48 b8 77 72 69 74 65 	movabs $0x6f74206574697277,%rax
  4229b9:	20 74 6f 
  4229bc:	48 89 43 18          	mov    %rax,0x18(%rbx)
  4229c0:	48 b8 20 74 68 65 20 	movabs $0x7475412065687420,%rax
  4229c7:	41 75 74 
  4229ca:	48 89 43 20          	mov    %rax,0x20(%rbx)
  4229ce:	48 b8 6f 6c 61 62 20 	movabs $0x7265732062616c6f,%rax
  4229d5:	73 65 72 
  4229d8:	48 89 43 28          	mov    %rax,0x28(%rbx)
  4229dc:	c7 43 30 76 65 72 00 	movl   $0x726576,0x30(%rbx)
  4229e3:	89 ef                	mov    %ebp,%edi
  4229e5:	e8 c6 e2 fd ff       	callq  400cb0 <close@plt>
  4229ea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  4229ef:	e9 f7 02 00 00       	jmpq   422ceb <submitr+0x724>
  4229f4:	89 ee                	mov    %ebp,%esi
  4229f6:	48 8d bc 24 30 80 00 	lea    0x8030(%rsp),%rdi
  4229fd:	00 
  4229fe:	e8 4d f9 ff ff       	callq  422350 <rio_readinitb>
  422a03:	ba 00 20 00 00       	mov    $0x2000,%edx
  422a08:	48 8d b4 24 30 60 00 	lea    0x6030(%rsp),%rsi
  422a0f:	00 
  422a10:	48 8d bc 24 30 80 00 	lea    0x8030(%rsp),%rdi
  422a17:	00 
  422a18:	e8 27 fb ff ff       	callq  422544 <rio_readlineb>
  422a1d:	48 85 c0             	test   %rax,%rax
  422a20:	7f 7f                	jg     422aa1 <submitr+0x4da>
  422a22:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
  422a29:	3a 20 43 
  422a2c:	48 89 03             	mov    %rax,(%rbx)
  422a2f:	48 b8 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rax
  422a36:	20 75 6e 
  422a39:	48 89 43 08          	mov    %rax,0x8(%rbx)
  422a3d:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  422a44:	74 6f 20 
  422a47:	48 89 43 10          	mov    %rax,0x10(%rbx)
  422a4b:	48 b8 72 65 61 64 20 	movabs $0x7269662064616572,%rax
  422a52:	66 69 72 
  422a55:	48 89 43 18          	mov    %rax,0x18(%rbx)
  422a59:	48 b8 73 74 20 68 65 	movabs $0x6564616568207473,%rax
  422a60:	61 64 65 
  422a63:	48 89 43 20          	mov    %rax,0x20(%rbx)
  422a67:	48 b8 72 20 66 72 6f 	movabs $0x41206d6f72662072,%rax
  422a6e:	6d 20 41 
  422a71:	48 89 43 28          	mov    %rax,0x28(%rbx)
  422a75:	48 b8 75 74 6f 6c 61 	movabs $0x732062616c6f7475,%rax
  422a7c:	62 20 73 
  422a7f:	48 89 43 30          	mov    %rax,0x30(%rbx)
  422a83:	c7 43 38 65 72 76 65 	movl   $0x65767265,0x38(%rbx)
  422a8a:	66 c7 43 3c 72 00    	movw   $0x72,0x3c(%rbx)
  422a90:	89 ef                	mov    %ebp,%edi
  422a92:	e8 19 e2 fd ff       	callq  400cb0 <close@plt>
  422a97:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  422a9c:	e9 4a 02 00 00       	jmpq   422ceb <submitr+0x724>
  422aa1:	4c 8d 44 24 20       	lea    0x20(%rsp),%r8
  422aa6:	48 8d 8c 24 2c 20 00 	lea    0x202c(%rsp),%rcx
  422aad:	00 
  422aae:	48 8d 94 24 30 20 00 	lea    0x2030(%rsp),%rdx
  422ab5:	00 
  422ab6:	be 8f 39 42 00       	mov    $0x42398f,%esi
  422abb:	48 8d bc 24 30 60 00 	lea    0x6030(%rsp),%rdi
  422ac2:	00 
  422ac3:	b8 00 00 00 00       	mov    $0x0,%eax
  422ac8:	e8 a3 e2 fd ff       	callq  400d70 <__isoc99_sscanf@plt>
  422acd:	e9 95 00 00 00       	jmpq   422b67 <submitr+0x5a0>
  422ad2:	ba 00 20 00 00       	mov    $0x2000,%edx
  422ad7:	48 8d b4 24 30 60 00 	lea    0x6030(%rsp),%rsi
  422ade:	00 
  422adf:	48 8d bc 24 30 80 00 	lea    0x8030(%rsp),%rdi
  422ae6:	00 
  422ae7:	e8 58 fa ff ff       	callq  422544 <rio_readlineb>
  422aec:	48 85 c0             	test   %rax,%rax
  422aef:	7f 76                	jg     422b67 <submitr+0x5a0>
  422af1:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
  422af8:	3a 20 43 
  422afb:	48 89 03             	mov    %rax,(%rbx)
  422afe:	48 b8 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rax
  422b05:	20 75 6e 
  422b08:	48 89 43 08          	mov    %rax,0x8(%rbx)
  422b0c:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  422b13:	74 6f 20 
  422b16:	48 89 43 10          	mov    %rax,0x10(%rbx)
  422b1a:	48 b8 72 65 61 64 20 	movabs $0x6165682064616572,%rax
  422b21:	68 65 61 
  422b24:	48 89 43 18          	mov    %rax,0x18(%rbx)
  422b28:	48 b8 64 65 72 73 20 	movabs $0x6f72662073726564,%rax
  422b2f:	66 72 6f 
  422b32:	48 89 43 20          	mov    %rax,0x20(%rbx)
  422b36:	48 b8 6d 20 41 75 74 	movabs $0x616c6f747541206d,%rax
  422b3d:	6f 6c 61 
  422b40:	48 89 43 28          	mov    %rax,0x28(%rbx)
  422b44:	48 b8 62 20 73 65 72 	movabs $0x7265767265732062,%rax
  422b4b:	76 65 72 
  422b4e:	48 89 43 30          	mov    %rax,0x30(%rbx)
  422b52:	c6 43 38 00          	movb   $0x0,0x38(%rbx)
  422b56:	89 ef                	mov    %ebp,%edi
  422b58:	e8 53 e1 fd ff       	callq  400cb0 <close@plt>
  422b5d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  422b62:	e9 84 01 00 00       	jmpq   422ceb <submitr+0x724>
  422b67:	0f b6 84 24 30 60 00 	movzbl 0x6030(%rsp),%eax
  422b6e:	00 
  422b6f:	83 e8 0d             	sub    $0xd,%eax
  422b72:	75 15                	jne    422b89 <submitr+0x5c2>
  422b74:	0f b6 84 24 31 60 00 	movzbl 0x6031(%rsp),%eax
  422b7b:	00 
  422b7c:	83 e8 0a             	sub    $0xa,%eax
  422b7f:	75 08                	jne    422b89 <submitr+0x5c2>
  422b81:	0f b6 84 24 32 60 00 	movzbl 0x6032(%rsp),%eax
  422b88:	00 
  422b89:	85 c0                	test   %eax,%eax
  422b8b:	0f 85 41 ff ff ff    	jne    422ad2 <submitr+0x50b>
  422b91:	ba 00 20 00 00       	mov    $0x2000,%edx
  422b96:	48 8d b4 24 30 60 00 	lea    0x6030(%rsp),%rsi
  422b9d:	00 
  422b9e:	48 8d bc 24 30 80 00 	lea    0x8030(%rsp),%rdi
  422ba5:	00 
  422ba6:	e8 99 f9 ff ff       	callq  422544 <rio_readlineb>
  422bab:	48 85 c0             	test   %rax,%rax
  422bae:	0f 8f 80 00 00 00    	jg     422c34 <submitr+0x66d>
  422bb4:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
  422bbb:	3a 20 43 
  422bbe:	48 89 03             	mov    %rax,(%rbx)
  422bc1:	48 b8 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rax
  422bc8:	20 75 6e 
  422bcb:	48 89 43 08          	mov    %rax,0x8(%rbx)
  422bcf:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  422bd6:	74 6f 20 
  422bd9:	48 89 43 10          	mov    %rax,0x10(%rbx)
  422bdd:	48 b8 72 65 61 64 20 	movabs $0x6174732064616572,%rax
  422be4:	73 74 61 
  422be7:	48 89 43 18          	mov    %rax,0x18(%rbx)
  422beb:	48 b8 74 75 73 20 6d 	movabs $0x7373656d20737574,%rax
  422bf2:	65 73 73 
  422bf5:	48 89 43 20          	mov    %rax,0x20(%rbx)
  422bf9:	48 b8 61 67 65 20 66 	movabs $0x6d6f726620656761,%rax
  422c00:	72 6f 6d 
  422c03:	48 89 43 28          	mov    %rax,0x28(%rbx)
  422c07:	48 b8 20 41 75 74 6f 	movabs $0x62616c6f74754120,%rax
  422c0e:	6c 61 62 
  422c11:	48 89 43 30          	mov    %rax,0x30(%rbx)
  422c15:	48 b8 20 73 65 72 76 	movabs $0x72657672657320,%rax
  422c1c:	65 72 00 
  422c1f:	48 89 43 38          	mov    %rax,0x38(%rbx)
  422c23:	89 ef                	mov    %ebp,%edi
  422c25:	e8 86 e0 fd ff       	callq  400cb0 <close@plt>
  422c2a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  422c2f:	e9 b7 00 00 00       	jmpq   422ceb <submitr+0x724>
  422c34:	8b 94 24 2c 20 00 00 	mov    0x202c(%rsp),%edx
  422c3b:	81 fa c8 00 00 00    	cmp    $0xc8,%edx
  422c41:	74 28                	je     422c6b <submitr+0x6a4>
  422c43:	48 8d 4c 24 20       	lea    0x20(%rsp),%rcx
  422c48:	be 58 39 42 00       	mov    $0x423958,%esi
  422c4d:	48 89 df             	mov    %rbx,%rdi
  422c50:	b8 00 00 00 00       	mov    $0x0,%eax
  422c55:	e8 86 e1 fd ff       	callq  400de0 <sprintf@plt>
  422c5a:	89 ef                	mov    %ebp,%edi
  422c5c:	e8 4f e0 fd ff       	callq  400cb0 <close@plt>
  422c61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  422c66:	e9 80 00 00 00       	jmpq   422ceb <submitr+0x724>
  422c6b:	48 8d b4 24 30 60 00 	lea    0x6030(%rsp),%rsi
  422c72:	00 
  422c73:	48 89 df             	mov    %rbx,%rdi
  422c76:	e8 c5 df fd ff       	callq  400c40 <strcpy@plt>
  422c7b:	89 ef                	mov    %ebp,%edi
  422c7d:	e8 2e e0 fd ff       	callq  400cb0 <close@plt>
  422c82:	0f b6 03             	movzbl (%rbx),%eax
  422c85:	83 e8 4f             	sub    $0x4f,%eax
  422c88:	75 18                	jne    422ca2 <submitr+0x6db>
  422c8a:	0f b6 53 01          	movzbl 0x1(%rbx),%edx
  422c8e:	83 ea 4b             	sub    $0x4b,%edx
  422c91:	75 11                	jne    422ca4 <submitr+0x6dd>
  422c93:	0f b6 53 02          	movzbl 0x2(%rbx),%edx
  422c97:	83 ea 0a             	sub    $0xa,%edx
  422c9a:	75 08                	jne    422ca4 <submitr+0x6dd>
  422c9c:	0f b6 53 03          	movzbl 0x3(%rbx),%edx
  422ca0:	eb 02                	jmp    422ca4 <submitr+0x6dd>
  422ca2:	89 c2                	mov    %eax,%edx
  422ca4:	85 d2                	test   %edx,%edx
  422ca6:	74 30                	je     422cd8 <submitr+0x711>
  422ca8:	bf a0 39 42 00       	mov    $0x4239a0,%edi
  422cad:	b9 05 00 00 00       	mov    $0x5,%ecx
  422cb2:	48 89 de             	mov    %rbx,%rsi
  422cb5:	f3 a6                	repz cmpsb %es:(%rdi),%ds:(%rsi)
  422cb7:	0f 97 c1             	seta   %cl
  422cba:	0f 92 c2             	setb   %dl
  422cbd:	38 d1                	cmp    %dl,%cl
  422cbf:	74 1e                	je     422cdf <submitr+0x718>
  422cc1:	85 c0                	test   %eax,%eax
  422cc3:	75 0d                	jne    422cd2 <submitr+0x70b>
  422cc5:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  422cc9:	83 e8 4b             	sub    $0x4b,%eax
  422ccc:	75 04                	jne    422cd2 <submitr+0x70b>
  422cce:	0f b6 43 02          	movzbl 0x2(%rbx),%eax
  422cd2:	85 c0                	test   %eax,%eax
  422cd4:	75 10                	jne    422ce6 <submitr+0x71f>
  422cd6:	eb 13                	jmp    422ceb <submitr+0x724>
  422cd8:	b8 00 00 00 00       	mov    $0x0,%eax
  422cdd:	eb 0c                	jmp    422ceb <submitr+0x724>
  422cdf:	b8 00 00 00 00       	mov    $0x0,%eax
  422ce4:	eb 05                	jmp    422ceb <submitr+0x724>
  422ce6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  422ceb:	48 81 c4 58 a0 00 00 	add    $0xa058,%rsp
  422cf2:	5b                   	pop    %rbx
  422cf3:	5d                   	pop    %rbp
  422cf4:	41 5c                	pop    %r12
  422cf6:	41 5d                	pop    %r13
  422cf8:	41 5e                	pop    %r14
  422cfa:	41 5f                	pop    %r15
  422cfc:	c3                   	retq   

0000000000422cfd <init_timeout>:
  422cfd:	53                   	push   %rbx
  422cfe:	89 fb                	mov    %edi,%ebx
  422d00:	85 ff                	test   %edi,%edi
  422d02:	74 1f                	je     422d23 <init_timeout+0x26>
  422d04:	85 ff                	test   %edi,%edi
  422d06:	79 05                	jns    422d0d <init_timeout+0x10>
  422d08:	bb 00 00 00 00       	mov    $0x0,%ebx
  422d0d:	be 62 23 42 00       	mov    $0x422362,%esi
  422d12:	bf 0e 00 00 00       	mov    $0xe,%edi
  422d17:	e8 c4 df fd ff       	callq  400ce0 <signal@plt>
  422d1c:	89 df                	mov    %ebx,%edi
  422d1e:	e8 7d df fd ff       	callq  400ca0 <alarm@plt>
  422d23:	5b                   	pop    %rbx
  422d24:	c3                   	retq   

0000000000422d25 <init_driver>:
  422d25:	55                   	push   %rbp
  422d26:	53                   	push   %rbx
  422d27:	48 83 ec 18          	sub    $0x18,%rsp
  422d2b:	48 89 fd             	mov    %rdi,%rbp
  422d2e:	be 01 00 00 00       	mov    $0x1,%esi
  422d33:	bf 0d 00 00 00       	mov    $0xd,%edi
  422d38:	e8 a3 df fd ff       	callq  400ce0 <signal@plt>
  422d3d:	be 01 00 00 00       	mov    $0x1,%esi
  422d42:	bf 1d 00 00 00       	mov    $0x1d,%edi
  422d47:	e8 94 df fd ff       	callq  400ce0 <signal@plt>
  422d4c:	be 01 00 00 00       	mov    $0x1,%esi
  422d51:	bf 1d 00 00 00       	mov    $0x1d,%edi
  422d56:	e8 85 df fd ff       	callq  400ce0 <signal@plt>
  422d5b:	ba 00 00 00 00       	mov    $0x0,%edx
  422d60:	be 01 00 00 00       	mov    $0x1,%esi
  422d65:	bf 02 00 00 00       	mov    $0x2,%edi
  422d6a:	e8 a1 e0 fd ff       	callq  400e10 <socket@plt>
  422d6f:	89 c3                	mov    %eax,%ebx
  422d71:	85 c0                	test   %eax,%eax
  422d73:	79 4f                	jns    422dc4 <init_driver+0x9f>
  422d75:	48 b8 45 72 72 6f 72 	movabs $0x43203a726f727245,%rax
  422d7c:	3a 20 43 
  422d7f:	48 89 45 00          	mov    %rax,0x0(%rbp)
  422d83:	48 b8 6c 69 65 6e 74 	movabs $0x6e7520746e65696c,%rax
  422d8a:	20 75 6e 
  422d8d:	48 89 45 08          	mov    %rax,0x8(%rbp)
  422d91:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  422d98:	74 6f 20 
  422d9b:	48 89 45 10          	mov    %rax,0x10(%rbp)
  422d9f:	48 b8 63 72 65 61 74 	movabs $0x7320657461657263,%rax
  422da6:	65 20 73 
  422da9:	48 89 45 18          	mov    %rax,0x18(%rbp)
  422dad:	c7 45 20 6f 63 6b 65 	movl   $0x656b636f,0x20(%rbp)
  422db4:	66 c7 45 24 74 00    	movw   $0x74,0x24(%rbp)
  422dba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  422dbf:	e9 23 01 00 00       	jmpq   422ee7 <init_driver+0x1c2>
  422dc4:	bf a5 39 42 00       	mov    $0x4239a5,%edi
  422dc9:	e8 22 df fd ff       	callq  400cf0 <gethostbyname@plt>
  422dce:	48 85 c0             	test   %rax,%rax
  422dd1:	75 68                	jne    422e3b <init_driver+0x116>
  422dd3:	48 b8 45 72 72 6f 72 	movabs $0x44203a726f727245,%rax
  422dda:	3a 20 44 
  422ddd:	48 89 45 00          	mov    %rax,0x0(%rbp)
  422de1:	48 b8 4e 53 20 69 73 	movabs $0x6e7520736920534e,%rax
  422de8:	20 75 6e 
  422deb:	48 89 45 08          	mov    %rax,0x8(%rbp)
  422def:	48 b8 61 62 6c 65 20 	movabs $0x206f7420656c6261,%rax
  422df6:	74 6f 20 
  422df9:	48 89 45 10          	mov    %rax,0x10(%rbp)
  422dfd:	48 b8 72 65 73 6f 6c 	movabs $0x2065766c6f736572,%rax
  422e04:	76 65 20 
  422e07:	48 89 45 18          	mov    %rax,0x18(%rbp)
  422e0b:	48 b8 73 65 72 76 65 	movabs $0x6120726576726573,%rax
  422e12:	72 20 61 
  422e15:	48 89 45 20          	mov    %rax,0x20(%rbp)
  422e19:	c7 45 28 64 64 72 65 	movl   $0x65726464,0x28(%rbp)
  422e20:	66 c7 45 2c 73 73    	movw   $0x7373,0x2c(%rbp)
  422e26:	c6 45 2e 00          	movb   $0x0,0x2e(%rbp)
  422e2a:	89 df                	mov    %ebx,%edi
  422e2c:	e8 7f de fd ff       	callq  400cb0 <close@plt>
  422e31:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  422e36:	e9 ac 00 00 00       	jmpq   422ee7 <init_driver+0x1c2>
  422e3b:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
  422e42:	00 
  422e43:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
  422e4a:	00 00 
  422e4c:	66 c7 04 24 02 00    	movw   $0x2,(%rsp)
  422e52:	48 8b 48 18          	mov    0x18(%rax),%rcx
  422e56:	48 63 50 14          	movslq 0x14(%rax),%rdx
  422e5a:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
  422e5f:	48 8b 39             	mov    (%rcx),%rdi
  422e62:	e8 29 df fd ff       	callq  400d90 <bcopy@plt>
  422e67:	66 c7 44 24 02 00 50 	movw   $0x5000,0x2(%rsp)
  422e6e:	ba 10 00 00 00       	mov    $0x10,%edx
  422e73:	48 89 e6             	mov    %rsp,%rsi
  422e76:	89 df                	mov    %ebx,%edi
  422e78:	e8 83 df fd ff       	callq  400e00 <connect@plt>
  422e7d:	85 c0                	test   %eax,%eax
  422e7f:	79 50                	jns    422ed1 <init_driver+0x1ac>
  422e81:	48 b8 45 72 72 6f 72 	movabs $0x55203a726f727245,%rax
  422e88:	3a 20 55 
  422e8b:	48 89 45 00          	mov    %rax,0x0(%rbp)
  422e8f:	48 b8 6e 61 62 6c 65 	movabs $0x6f7420656c62616e,%rax
  422e96:	20 74 6f 
  422e99:	48 89 45 08          	mov    %rax,0x8(%rbp)
  422e9d:	48 b8 20 63 6f 6e 6e 	movabs $0x7463656e6e6f6320,%rax
  422ea4:	65 63 74 
  422ea7:	48 89 45 10          	mov    %rax,0x10(%rbp)
  422eab:	48 b8 20 74 6f 20 73 	movabs $0x76726573206f7420,%rax
  422eb2:	65 72 76 
  422eb5:	48 89 45 18          	mov    %rax,0x18(%rbp)
  422eb9:	66 c7 45 20 65 72    	movw   $0x7265,0x20(%rbp)
  422ebf:	c6 45 22 00          	movb   $0x0,0x22(%rbp)
  422ec3:	89 df                	mov    %ebx,%edi
  422ec5:	e8 e6 dd fd ff       	callq  400cb0 <close@plt>
  422eca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  422ecf:	eb 16                	jmp    422ee7 <init_driver+0x1c2>
  422ed1:	89 df                	mov    %ebx,%edi
  422ed3:	e8 d8 dd fd ff       	callq  400cb0 <close@plt>
  422ed8:	66 c7 45 00 4f 4b    	movw   $0x4b4f,0x0(%rbp)
  422ede:	c6 45 02 00          	movb   $0x0,0x2(%rbp)
  422ee2:	b8 00 00 00 00       	mov    $0x0,%eax
  422ee7:	48 83 c4 18          	add    $0x18,%rsp
  422eeb:	5b                   	pop    %rbx
  422eec:	5d                   	pop    %rbp
  422eed:	c3                   	retq   

0000000000422eee <driver_post>:
  422eee:	53                   	push   %rbx
  422eef:	48 83 ec 10          	sub    $0x10,%rsp
  422ef3:	4c 89 cb             	mov    %r9,%rbx
  422ef6:	45 85 c0             	test   %r8d,%r8d
  422ef9:	74 22                	je     422f1d <driver_post+0x2f>
  422efb:	48 89 ce             	mov    %rcx,%rsi
  422efe:	bf bc 39 42 00       	mov    $0x4239bc,%edi
  422f03:	b8 00 00 00 00       	mov    $0x0,%eax
  422f08:	e8 73 dd fd ff       	callq  400c80 <printf@plt>
  422f0d:	66 c7 03 4f 4b       	movw   $0x4b4f,(%rbx)
  422f12:	c6 43 02 00          	movb   $0x0,0x2(%rbx)
  422f16:	b8 00 00 00 00       	mov    $0x0,%eax
  422f1b:	eb 39                	jmp    422f56 <driver_post+0x68>
  422f1d:	48 85 ff             	test   %rdi,%rdi
  422f20:	74 26                	je     422f48 <driver_post+0x5a>
  422f22:	80 3f 00             	cmpb   $0x0,(%rdi)
  422f25:	74 21                	je     422f48 <driver_post+0x5a>
  422f27:	4c 89 0c 24          	mov    %r9,(%rsp)
  422f2b:	49 89 c9             	mov    %rcx,%r9
  422f2e:	49 89 d0             	mov    %rdx,%r8
  422f31:	48 89 f9             	mov    %rdi,%rcx
  422f34:	48 89 f2             	mov    %rsi,%rdx
  422f37:	be 50 00 00 00       	mov    $0x50,%esi
  422f3c:	bf a5 39 42 00       	mov    $0x4239a5,%edi
  422f41:	e8 81 f6 ff ff       	callq  4225c7 <submitr>
  422f46:	eb 0e                	jmp    422f56 <driver_post+0x68>
  422f48:	66 c7 03 4f 4b       	movw   $0x4b4f,(%rbx)
  422f4d:	c6 43 02 00          	movb   $0x0,0x2(%rbx)
  422f51:	b8 00 00 00 00       	mov    $0x0,%eax
  422f56:	48 83 c4 10          	add    $0x10,%rsp
  422f5a:	5b                   	pop    %rbx
  422f5b:	c3                   	retq   

0000000000422f5c <check>:
  422f5c:	89 f8                	mov    %edi,%eax
  422f5e:	c1 e8 1c             	shr    $0x1c,%eax
  422f61:	74 1d                	je     422f80 <check+0x24>
  422f63:	b9 00 00 00 00       	mov    $0x0,%ecx
  422f68:	83 f9 1f             	cmp    $0x1f,%ecx
  422f6b:	7f 0d                	jg     422f7a <check+0x1e>
  422f6d:	89 f8                	mov    %edi,%eax
  422f6f:	d3 e8                	shr    %cl,%eax
  422f71:	3c 0a                	cmp    $0xa,%al
  422f73:	74 11                	je     422f86 <check+0x2a>
  422f75:	83 c1 08             	add    $0x8,%ecx
  422f78:	eb ee                	jmp    422f68 <check+0xc>
  422f7a:	b8 01 00 00 00       	mov    $0x1,%eax
  422f7f:	c3                   	retq   
  422f80:	b8 00 00 00 00       	mov    $0x0,%eax
  422f85:	c3                   	retq   
  422f86:	b8 00 00 00 00       	mov    $0x0,%eax
  422f8b:	c3                   	retq   

0000000000422f8c <gencookie>:
  422f8c:	53                   	push   %rbx
  422f8d:	83 c7 01             	add    $0x1,%edi
  422f90:	e8 8b dc fd ff       	callq  400c20 <srandom@plt>
  422f95:	e8 b6 dd fd ff       	callq  400d50 <random@plt>
  422f9a:	48 89 c7             	mov    %rax,%rdi
  422f9d:	89 c3                	mov    %eax,%ebx
  422f9f:	e8 b8 ff ff ff       	callq  422f5c <check>
  422fa4:	85 c0                	test   %eax,%eax
  422fa6:	74 ed                	je     422f95 <gencookie+0x9>
  422fa8:	89 d8                	mov    %ebx,%eax
  422faa:	5b                   	pop    %rbx
  422fab:	c3                   	retq   
  422fac:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000422fb0 <__libc_csu_init>:
  422fb0:	41 57                	push   %r15
  422fb2:	41 89 ff             	mov    %edi,%r15d
  422fb5:	41 56                	push   %r14
  422fb7:	49 89 f6             	mov    %rsi,%r14
  422fba:	41 55                	push   %r13
  422fbc:	49 89 d5             	mov    %rdx,%r13
  422fbf:	41 54                	push   %r12
  422fc1:	4c 8d 25 48 1e 20 00 	lea    0x201e48(%rip),%r12        # 624e10 <__frame_dummy_init_array_entry>
  422fc8:	55                   	push   %rbp
  422fc9:	48 8d 2d 48 1e 20 00 	lea    0x201e48(%rip),%rbp        # 624e18 <__init_array_end>
  422fd0:	53                   	push   %rbx
  422fd1:	4c 29 e5             	sub    %r12,%rbp
  422fd4:	31 db                	xor    %ebx,%ebx
  422fd6:	48 c1 fd 03          	sar    $0x3,%rbp
  422fda:	48 83 ec 08          	sub    $0x8,%rsp
  422fde:	e8 e5 db fd ff       	callq  400bc8 <_init>
  422fe3:	48 85 ed             	test   %rbp,%rbp
  422fe6:	74 1e                	je     423006 <__libc_csu_init+0x56>
  422fe8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  422fef:	00 
  422ff0:	4c 89 ea             	mov    %r13,%rdx
  422ff3:	4c 89 f6             	mov    %r14,%rsi
  422ff6:	44 89 ff             	mov    %r15d,%edi
  422ff9:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
  422ffd:	48 83 c3 01          	add    $0x1,%rbx
  423001:	48 39 eb             	cmp    %rbp,%rbx
  423004:	75 ea                	jne    422ff0 <__libc_csu_init+0x40>
  423006:	48 83 c4 08          	add    $0x8,%rsp
  42300a:	5b                   	pop    %rbx
  42300b:	5d                   	pop    %rbp
  42300c:	41 5c                	pop    %r12
  42300e:	41 5d                	pop    %r13
  423010:	41 5e                	pop    %r14
  423012:	41 5f                	pop    %r15
  423014:	c3                   	retq   
  423015:	90                   	nop
  423016:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  42301d:	00 00 00 

0000000000423020 <__libc_csu_fini>:
  423020:	f3 c3                	repz retq 

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

0000000000423024 <_fini>:
  423024:	48 83 ec 08          	sub    $0x8,%rsp
  423028:	48 83 c4 08          	add    $0x8,%rsp
  42302c:	c3                   	retq   
