
farm.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <start_farm>:
   0:	55                   	push   %rbp
   1:	48 89 e5             	mov    %rsp,%rbp
   4:	b8 01 00 00 00       	mov    $0x1,%eax
   9:	5d                   	pop    %rbp
   a:	c3                   	retq   

000000000000000b <addval_314>:
   b:	55                   	push   %rbp
   c:	48 89 e5             	mov    %rsp,%rbp
   f:	89 7d fc             	mov    %edi,-0x4(%rbp)
  12:	8b 45 fc             	mov    -0x4(%rbp),%eax
  15:	2d b8 76 38 6b       	sub    $0x6b3876b8,%eax
  1a:	5d                   	pop    %rbp
  1b:	c3                   	retq   

000000000000001c <getval_257>:
  1c:	55                   	push   %rbp
  1d:	48 89 e5             	mov    %rsp,%rbp
  20:	b8 48 89 c7 91       	mov    $0x91c78948,%eax
  25:	5d                   	pop    %rbp
  26:	c3                   	retq   

0000000000000027 <addval_435>:
  27:	55                   	push   %rbp
  28:	48 89 e5             	mov    %rsp,%rbp
  2b:	89 7d fc             	mov    %edi,-0x4(%rbp)
  2e:	8b 45 fc             	mov    -0x4(%rbp),%eax
  31:	2d 6f a7 6f 3c       	sub    $0x3c6fa76f,%eax
  36:	5d                   	pop    %rbp
  37:	c3                   	retq   

0000000000000038 <addval_298>:
  38:	55                   	push   %rbp
  39:	48 89 e5             	mov    %rsp,%rbp
  3c:	89 7d fc             	mov    %edi,-0x4(%rbp)
  3f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  42:	2d a8 6f 6b 3c       	sub    $0x3c6b6fa8,%eax
  47:	5d                   	pop    %rbp
  48:	c3                   	retq   

0000000000000049 <getval_395>:
  49:	55                   	push   %rbp
  4a:	48 89 e5             	mov    %rsp,%rbp
  4d:	b8 48 89 c7 c3       	mov    $0xc3c78948,%eax
  52:	5d                   	pop    %rbp
  53:	c3                   	retq   

0000000000000054 <setval_456>:
  54:	55                   	push   %rbp
  55:	48 89 e5             	mov    %rsp,%rbp
  58:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  5c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  60:	c7 00 48 89 c7 c3    	movl   $0xc3c78948,(%rax)
  66:	5d                   	pop    %rbp
  67:	c3                   	retq   

0000000000000068 <setval_385>:
  68:	55                   	push   %rbp
  69:	48 89 e5             	mov    %rsp,%rbp
  6c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  70:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  74:	c7 00 7e 90 50 90    	movl   $0x9050907e,(%rax)
  7a:	5d                   	pop    %rbp
  7b:	c3                   	retq   

000000000000007c <setval_471>:
  7c:	55                   	push   %rbp
  7d:	48 89 e5             	mov    %rsp,%rbp
  80:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  88:	c7 00 c2 6a 30 58    	movl   $0x58306ac2,(%rax)
  8e:	5d                   	pop    %rbp
  8f:	c3                   	retq   

0000000000000090 <mid_farm>:
  90:	55                   	push   %rbp
  91:	48 89 e5             	mov    %rsp,%rbp
  94:	b8 01 00 00 00       	mov    $0x1,%eax
  99:	5d                   	pop    %rbp
  9a:	c3                   	retq   

000000000000009b <add_xy>:
  9b:	55                   	push   %rbp
  9c:	48 89 e5             	mov    %rsp,%rbp
  9f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  a3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  a7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  ab:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  af:	48 01 d0             	add    %rdx,%rax
  b2:	5d                   	pop    %rbp
  b3:	c3                   	retq   

00000000000000b4 <setval_341>:
  b4:	55                   	push   %rbp
  b5:	48 89 e5             	mov    %rsp,%rbp
  b8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  bc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  c0:	c7 00 cf 08 89 e0    	movl   $0xe08908cf,(%rax)
  c6:	5d                   	pop    %rbp
  c7:	c3                   	retq   

00000000000000c8 <addval_144>:
  c8:	55                   	push   %rbp
  c9:	48 89 e5             	mov    %rsp,%rbp
  cc:	89 7d fc             	mov    %edi,-0x4(%rbp)
  cf:	8b 45 fc             	mov    -0x4(%rbp),%eax
  d2:	2d b8 76 1f 6f       	sub    $0x6f1f76b8,%eax
  d7:	5d                   	pop    %rbp
  d8:	c3                   	retq   

00000000000000d9 <getval_427>:
  d9:	55                   	push   %rbp
  da:	48 89 e5             	mov    %rsp,%rbp
  dd:	b8 89 ca 60 c9       	mov    $0xc960ca89,%eax
  e2:	5d                   	pop    %rbp
  e3:	c3                   	retq   

00000000000000e4 <getval_305>:
  e4:	55                   	push   %rbp
  e5:	48 89 e5             	mov    %rsp,%rbp
  e8:	b8 89 ca 08 c0       	mov    $0xc008ca89,%eax
  ed:	5d                   	pop    %rbp
  ee:	c3                   	retq   

00000000000000ef <addval_346>:
  ef:	55                   	push   %rbp
  f0:	48 89 e5             	mov    %rsp,%rbp
  f3:	89 7d fc             	mov    %edi,-0x4(%rbp)
  f6:	8b 45 fc             	mov    -0x4(%rbp),%eax
  f9:	2d 75 29 3c 4c       	sub    $0x4c3c2975,%eax
  fe:	5d                   	pop    %rbp
  ff:	c3                   	retq   

0000000000000100 <getval_327>:
 100:	55                   	push   %rbp
 101:	48 89 e5             	mov    %rsp,%rbp
 104:	b8 89 c1 94 c9       	mov    $0xc994c189,%eax
 109:	5d                   	pop    %rbp
 10a:	c3                   	retq   

000000000000010b <addval_374>:
 10b:	55                   	push   %rbp
 10c:	48 89 e5             	mov    %rsp,%rbp
 10f:	89 7d fc             	mov    %edi,-0x4(%rbp)
 112:	8b 45 fc             	mov    -0x4(%rbp),%eax
 115:	2d 78 35 df 2d       	sub    $0x2ddf3578,%eax
 11a:	5d                   	pop    %rbp
 11b:	c3                   	retq   

000000000000011c <getval_323>:
 11c:	55                   	push   %rbp
 11d:	48 89 e5             	mov    %rsp,%rbp
 120:	b8 99 ca 38 c0       	mov    $0xc038ca99,%eax
 125:	5d                   	pop    %rbp
 126:	c3                   	retq   

0000000000000127 <setval_322>:
 127:	55                   	push   %rbp
 128:	48 89 e5             	mov    %rsp,%rbp
 12b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 12f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 133:	c7 00 48 89 e0 92    	movl   $0x92e08948,(%rax)
 139:	5d                   	pop    %rbp
 13a:	c3                   	retq   

000000000000013b <setval_355>:
 13b:	55                   	push   %rbp
 13c:	48 89 e5             	mov    %rsp,%rbp
 13f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 143:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 147:	c7 00 48 89 e0 c3    	movl   $0xc3e08948,(%rax)
 14d:	5d                   	pop    %rbp
 14e:	c3                   	retq   

000000000000014f <setval_440>:
 14f:	55                   	push   %rbp
 150:	48 89 e5             	mov    %rsp,%rbp
 153:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 157:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 15b:	c7 00 48 89 e0 c2    	movl   $0xc2e08948,(%rax)
 161:	5d                   	pop    %rbp
 162:	c3                   	retq   

0000000000000163 <setval_228>:
 163:	55                   	push   %rbp
 164:	48 89 e5             	mov    %rsp,%rbp
 167:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 16b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 16f:	c7 00 48 8b e0 c3    	movl   $0xc3e08b48,(%rax)
 175:	5d                   	pop    %rbp
 176:	c3                   	retq   

0000000000000177 <setval_124>:
 177:	55                   	push   %rbp
 178:	48 89 e5             	mov    %rsp,%rbp
 17b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 17f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 183:	c7 00 89 ca 90 c3    	movl   $0xc390ca89,(%rax)
 189:	5d                   	pop    %rbp
 18a:	c3                   	retq   

000000000000018b <addval_386>:
 18b:	55                   	push   %rbp
 18c:	48 89 e5             	mov    %rsp,%rbp
 18f:	89 7d fc             	mov    %edi,-0x4(%rbp)
 192:	8b 45 fc             	mov    -0x4(%rbp),%eax
 195:	2d 77 29 3c 7f       	sub    $0x7f3c2977,%eax
 19a:	5d                   	pop    %rbp
 19b:	c3                   	retq   

000000000000019c <addval_320>:
 19c:	55                   	push   %rbp
 19d:	48 89 e5             	mov    %rsp,%rbp
 1a0:	89 7d fc             	mov    %edi,-0x4(%rbp)
 1a3:	8b 45 fc             	mov    -0x4(%rbp),%eax
 1a6:	2d 75 29 df 36       	sub    $0x36df2975,%eax
 1ab:	5d                   	pop    %rbp
 1ac:	c3                   	retq   

00000000000001ad <getval_368>:
 1ad:	55                   	push   %rbp
 1ae:	48 89 e5             	mov    %rsp,%rbp
 1b1:	b8 89 ca a4 c9       	mov    $0xc9a4ca89,%eax
 1b6:	5d                   	pop    %rbp
 1b7:	c3                   	retq   

00000000000001b8 <getval_134>:
 1b8:	55                   	push   %rbp
 1b9:	48 89 e5             	mov    %rsp,%rbp
 1bc:	b8 89 c1 c4 d2       	mov    $0xd2c4c189,%eax
 1c1:	5d                   	pop    %rbp
 1c2:	c3                   	retq   

00000000000001c3 <addval_254>:
 1c3:	55                   	push   %rbp
 1c4:	48 89 e5             	mov    %rsp,%rbp
 1c7:	89 7d fc             	mov    %edi,-0x4(%rbp)
 1ca:	8b 45 fc             	mov    -0x4(%rbp),%eax
 1cd:	2d 77 29 7b 24       	sub    $0x247b2977,%eax
 1d2:	5d                   	pop    %rbp
 1d3:	c3                   	retq   

00000000000001d4 <addval_176>:
 1d4:	55                   	push   %rbp
 1d5:	48 89 e5             	mov    %rsp,%rbp
 1d8:	89 7d fc             	mov    %edi,-0x4(%rbp)
 1db:	8b 45 fc             	mov    -0x4(%rbp),%eax
 1de:	2d bf 76 29 6b       	sub    $0x6b2976bf,%eax
 1e3:	5d                   	pop    %rbp
 1e4:	c3                   	retq   

00000000000001e5 <setval_442>:
 1e5:	55                   	push   %rbp
 1e6:	48 89 e5             	mov    %rsp,%rbp
 1e9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 1ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1f1:	c7 00 5d 48 09 e0    	movl   $0xe009485d,(%rax)
 1f7:	5d                   	pop    %rbp
 1f8:	c3                   	retq   

00000000000001f9 <getval_474>:
 1f9:	55                   	push   %rbp
 1fa:	48 89 e5             	mov    %rsp,%rbp
 1fd:	b8 89 ca 60 d2       	mov    $0xd260ca89,%eax
 202:	5d                   	pop    %rbp
 203:	c3                   	retq   

0000000000000204 <setval_284>:
 204:	55                   	push   %rbp
 205:	48 89 e5             	mov    %rsp,%rbp
 208:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 20c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 210:	c7 00 89 ca a4 d2    	movl   $0xd2a4ca89,(%rax)
 216:	5d                   	pop    %rbp
 217:	c3                   	retq   

0000000000000218 <setval_459>:
 218:	55                   	push   %rbp
 219:	48 89 e5             	mov    %rsp,%rbp
 21c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 220:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 224:	c7 00 89 c1 90 c3    	movl   $0xc390c189,(%rax)
 22a:	5d                   	pop    %rbp
 22b:	c3                   	retq   

000000000000022c <setval_230>:
 22c:	55                   	push   %rbp
 22d:	48 89 e5             	mov    %rsp,%rbp
 230:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 234:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 238:	c7 00 8b d6 20 db    	movl   $0xdb20d68b,(%rax)
 23e:	5d                   	pop    %rbp
 23f:	c3                   	retq   

0000000000000240 <setval_455>:
 240:	55                   	push   %rbp
 241:	48 89 e5             	mov    %rsp,%rbp
 244:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 248:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 24c:	c7 00 08 89 e0 c3    	movl   $0xc3e08908,(%rax)
 252:	5d                   	pop    %rbp
 253:	c3                   	retq   

0000000000000254 <addval_464>:
 254:	55                   	push   %rbp
 255:	48 89 e5             	mov    %rsp,%rbp
 258:	89 7d fc             	mov    %edi,-0x4(%rbp)
 25b:	8b 45 fc             	mov    -0x4(%rbp),%eax
 25e:	2d 77 3e 87 36       	sub    $0x36873e77,%eax
 263:	5d                   	pop    %rbp
 264:	c3                   	retq   

0000000000000265 <getval_317>:
 265:	55                   	push   %rbp
 266:	48 89 e5             	mov    %rsp,%rbp
 269:	b8 99 c1 38 c9       	mov    $0xc938c199,%eax
 26e:	5d                   	pop    %rbp
 26f:	c3                   	retq   

0000000000000270 <addval_226>:
 270:	55                   	push   %rbp
 271:	48 89 e5             	mov    %rsp,%rbp
 274:	89 7d fc             	mov    %edi,-0x4(%rbp)
 277:	8b 45 fc             	mov    -0x4(%rbp),%eax
 27a:	2d 77 3e 3c 23       	sub    $0x233c3e77,%eax
 27f:	5d                   	pop    %rbp
 280:	c3                   	retq   

0000000000000281 <setval_162>:
 281:	55                   	push   %rbp
 282:	48 89 e5             	mov    %rsp,%rbp
 285:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 289:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 28d:	c7 00 89 d6 90 c1    	movl   $0xc190d689,(%rax)
 293:	5d                   	pop    %rbp
 294:	c3                   	retq   

0000000000000295 <setval_280>:
 295:	55                   	push   %rbp
 296:	48 89 e5             	mov    %rsp,%rbp
 299:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 29d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 2a1:	c7 00 89 c1 78 db    	movl   $0xdb78c189,(%rax)
 2a7:	5d                   	pop    %rbp
 2a8:	c3                   	retq   

00000000000002a9 <setval_140>:
 2a9:	55                   	push   %rbp
 2aa:	48 89 e5             	mov    %rsp,%rbp
 2ad:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 2b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 2b5:	c7 00 89 c1 94 d2    	movl   $0xd294c189,(%rax)
 2bb:	5d                   	pop    %rbp
 2bc:	c3                   	retq   

00000000000002bd <setval_242>:
 2bd:	55                   	push   %rbp
 2be:	48 89 e5             	mov    %rsp,%rbp
 2c1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 2c5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 2c9:	c7 00 89 d6 30 c0    	movl   $0xc030d689,(%rax)
 2cf:	5d                   	pop    %rbp
 2d0:	c3                   	retq   

00000000000002d1 <end_farm>:
 2d1:	55                   	push   %rbp
 2d2:	48 89 e5             	mov    %rsp,%rbp
 2d5:	b8 01 00 00 00       	mov    $0x1,%eax
 2da:	5d                   	pop    %rbp
 2db:	c3                   	retq   
