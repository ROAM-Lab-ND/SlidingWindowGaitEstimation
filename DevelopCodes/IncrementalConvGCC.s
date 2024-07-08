	.text
	.p2align 4
__ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.isra.0:
LFB2527:
	pushq	%rbp
LCFI0:
	pushq	%rbx
LCFI1:
	subq	$8, %rsp
LCFI2:
	movq	(%rdi), %rax
	movq	-24(%rax), %rax
	movq	240(%rdi,%rax), %rbp
	testq	%rbp, %rbp
	je	L7
	cmpb	$0, 56(%rbp)
	movq	%rdi, %rbx
	je	L3
	movsbl	67(%rbp), %esi
L4:
	movq	%rbx, %rdi
	call	__ZNSo3putEc
	addq	$8, %rsp
LCFI3:
	popq	%rbx
LCFI4:
	movq	%rax, %rdi
	popq	%rbp
LCFI5:
	jmp	__ZNSo5flushEv
L3:
LCFI6:
	movq	%rbp, %rdi
	call	__ZNKSt5ctypeIcE13_M_widen_initEv
	movq	0(%rbp), %rax
	movl	$10, %esi
	movq	%rbp, %rdi
	call	*48(%rax)
	movsbl	%al, %esi
	jmp	L4
L7:
	call	__ZSt16__throw_bad_castv
LFE2527:
	.p2align 4
	.globl __Z4initv
__Z4initv:
LFB2152:
	pushq	%rbp
LCFI7:
	movl	$4000000, %edx
	xorl	%esi, %esi
	leaq	_A(%rip), %rdi
	pushq	%rbx
LCFI8:
	leaq	_k(%rip), %rbp
	leaq	4000(%rbp), %rbx
	subq	$8, %rsp
LCFI9:
	call	_memset
	.p2align 4,,10
	.p2align 3
L9:
	call	_rand
	vxorps	%xmm1, %xmm1, %xmm1
	addq	$4, %rbp
	movslq	%eax, %rdx
	movl	%eax, %ecx
	imulq	$274877907, %rdx, %rdx
	sarl	$31, %ecx
	sarq	$38, %rdx
	subl	%ecx, %edx
	imull	$1000, %edx, %edx
	subl	%edx, %eax
	vcvtsi2ssl	%eax, %xmm1, %xmm0
	vmovss	%xmm0, -4(%rbp)
	call	_rand
	vxorps	%xmm1, %xmm1, %xmm1
	movslq	%eax, %rdx
	movl	%eax, %ecx
	imulq	$274877907, %rdx, %rdx
	sarl	$31, %ecx
	sarq	$38, %rdx
	subl	%ecx, %edx
	imull	$1000, %edx, %edx
	subl	%edx, %eax
	vcvtsi2ssl	%eax, %xmm1, %xmm0
	vmovss	%xmm0, 3996(%rbp)
	cmpq	%rbp, %rbx
	jne	L9
	leaq	_data(%rip), %rbp
	leaq	40000(%rbp), %rbx
L10:
	call	_rand
	vxorps	%xmm2, %xmm2, %xmm2
	addq	$4, %rbp
	movslq	%eax, %rdx
	movl	%eax, %ecx
	imulq	$274877907, %rdx, %rdx
	sarl	$31, %ecx
	sarq	$38, %rdx
	subl	%ecx, %edx
	imull	$1000, %edx, %edx
	subl	%edx, %eax
	vcvtsi2ssl	%eax, %xmm2, %xmm0
	vmovss	%xmm0, -4(%rbp)
	cmpq	%rbx, %rbp
	jne	L10
	addq	$8, %rsp
LCFI10:
	popq	%rbx
LCFI11:
	popq	%rbp
LCFI12:
	ret
LFE2152:
	.p2align 4
	.globl __Z4Convv
__Z4Convv:
LFB2153:
	leaq	_data(%rip), %rdi
	xorl	%esi, %esi
	leaq	_k(%rip), %r9
	leaq	40000(%rdi), %r10
	leaq	_A(%rip), %r8
	.p2align 4,,10
	.p2align 3
L17:
	movslq	%esi, %rax
	vbroadcastss	(%rdi), %ymm1
	movq	%rax, %rdx
	imulq	$4000, %rax, %rax
	negq	%rdx
	leaq	4000(%r9,%rdx,4), %rcx
	leaq	(%r8,%rax), %rdx
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
L15:
	vmulps	(%rcx,%rax), %ymm1, %ymm0
	vmovaps	%ymm0, (%rdx,%rax)
	addq	$32, %rax
	cmpq	$4000, %rax
	jne	L15
	leal	1(%rsi), %eax
	subl	$999, %esi
	cmpl	$999, %eax
	cmovle	%eax, %esi
	addq	$4, %rdi
	cmpq	%rdi, %r10
	jne	L17
	vzeroupper
	ret
LFE2153:
	.cstring
lC0:
	.ascii "Start\0"
lC1:
	.ascii "Total Time (us): \0"
lC2:
	.ascii "Time Per Data (us): \0"
lC4:
	.ascii "Max Frequency (Hz): \0"
	.section __TEXT,__text_startup,regular,pure_instructions
	.p2align 4
	.globl _main
_main:
LFB2154:
	pushq	%rbp
LCFI13:
	pushq	%rbx
LCFI14:
	subq	$24, %rsp
LCFI15:
	call	__Z4initv
	movq	__ZSt4cout@GOTPCREL(%rip), %rbx
	movl	$5, %edx
	leaq	lC0(%rip), %rsi
	movq	%rbx, %rdi
	call	__ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l
	movq	%rbx, %rdi
	call	__ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.isra.0
	call	__ZNSt6chrono3_V212system_clock3nowEv
	movq	%rax, %rbp
	call	__Z4Convv
	call	__ZNSt6chrono3_V212system_clock3nowEv
	vxorps	%xmm0, %xmm0, %xmm0
	leaq	lC1(%rip), %rsi
	movq	%rbx, %rdi
	movabsq	$2361183241434822607, %rdx
	subq	%rbp, %rax
	movq	%rax, %rcx
	imulq	%rdx
	sarq	$63, %rcx
	sarq	$7, %rdx
	subq	%rcx, %rdx
	vcvtsi2sdq	%rdx, %xmm0, %xmm0
	movl	$17, %edx
	vmovsd	%xmm0, 8(%rsp)
	call	__ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l
	vmovsd	8(%rsp), %xmm0
	movq	%rbx, %rdi
	call	__ZNSo9_M_insertIdEERSoT_
	movq	%rax, %rdi
	call	__ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.isra.0
	movl	$20, %edx
	leaq	lC2(%rip), %rsi
	movq	%rbx, %rdi
	call	__ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l
	movq	%rbx, %rdi
	vmovsd	8(%rsp), %xmm1
	vdivsd	lC3(%rip), %xmm1, %xmm0
	call	__ZNSo9_M_insertIdEERSoT_
	movq	%rax, %rdi
	call	__ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.isra.0
	movl	$20, %edx
	leaq	lC4(%rip), %rsi
	movq	%rbx, %rdi
	call	__ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l
	movq	%rbx, %rdi
	vmovsd	lC5(%rip), %xmm0
	vdivsd	8(%rsp), %xmm0, %xmm0
	call	__ZNSo9_M_insertIdEERSoT_
	movq	%rax, %rdi
	call	__ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.isra.0
	addq	$24, %rsp
LCFI16:
	xorl	%eax, %eax
	popq	%rbx
LCFI17:
	popq	%rbp
LCFI18:
	ret
LFE2154:
	.p2align 4
__GLOBAL__sub_I_IncrementalConv.cpp:
LFB2524:
	pushq	%rbx
LCFI19:
	leaq	__ZStL8__ioinit(%rip), %rbx
	movq	%rbx, %rdi
	call	__ZNSt8ios_base4InitC1Ev
	movq	__ZNSt8ios_base4InitD1Ev@GOTPCREL(%rip), %rdi
	movq	%rbx, %rsi
	popq	%rbx
LCFI20:
	leaq	___dso_handle(%rip), %rdx
	jmp	___cxa_atexit
LFE2524:
	.globl _ke
	.data
	.align 3
_ke:
	.quad	_k+4000
	.globl _data
	.zerofill __DATA,__common,_data,40000,5
	.globl _A
	.zerofill __DATA,__common,_A,4000000,5
	.globl _k
	.zerofill __DATA,__common,_k,8000,5
	.zerofill __DATA,__bss,__ZStL8__ioinit,1,0
	.literal8
	.align 3
lC3:
	.long	0
	.long	1086556160
	.align 3
lC5:
	.long	536870912
	.long	1107468383
	.section __TEXT,__eh_frame,coalesced,no_toc+strip_static_syms+live_support
EH_frame1:
	.set L$set$0,LECIE1-LSCIE1
	.long L$set$0
LSCIE1:
	.long	0
	.byte	0x1
	.ascii "zR\0"
	.uleb128 0x1
	.sleb128 -8
	.byte	0x10
	.uleb128 0x1
	.byte	0x10
	.byte	0xc
	.uleb128 0x7
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x1
	.align 3
LECIE1:
LSFDE1:
	.set L$set$1,LEFDE1-LASFDE1
	.long L$set$1
LASFDE1:
	.long	LASFDE1-EH_frame1
	.quad	LFB2527-.
	.set L$set$2,LFE2527-LFB2527
	.quad L$set$2
	.uleb128 0
	.byte	0x4
	.set L$set$3,LCFI0-LFB2527
	.long L$set$3
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.set L$set$4,LCFI1-LCFI0
	.long L$set$4
	.byte	0xe
	.uleb128 0x18
	.byte	0x83
	.uleb128 0x3
	.byte	0x4
	.set L$set$5,LCFI2-LCFI1
	.long L$set$5
	.byte	0xe
	.uleb128 0x20
	.byte	0x4
	.set L$set$6,LCFI3-LCFI2
	.long L$set$6
	.byte	0xa
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.set L$set$7,LCFI4-LCFI3
	.long L$set$7
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.set L$set$8,LCFI5-LCFI4
	.long L$set$8
	.byte	0xe
	.uleb128 0x8
	.byte	0x4
	.set L$set$9,LCFI6-LCFI5
	.long L$set$9
	.byte	0xb
	.align 3
LEFDE1:
LSFDE3:
	.set L$set$10,LEFDE3-LASFDE3
	.long L$set$10
LASFDE3:
	.long	LASFDE3-EH_frame1
	.quad	LFB2152-.
	.set L$set$11,LFE2152-LFB2152
	.quad L$set$11
	.uleb128 0
	.byte	0x4
	.set L$set$12,LCFI7-LFB2152
	.long L$set$12
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.set L$set$13,LCFI8-LCFI7
	.long L$set$13
	.byte	0xe
	.uleb128 0x18
	.byte	0x83
	.uleb128 0x3
	.byte	0x4
	.set L$set$14,LCFI9-LCFI8
	.long L$set$14
	.byte	0xe
	.uleb128 0x20
	.byte	0x4
	.set L$set$15,LCFI10-LCFI9
	.long L$set$15
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.set L$set$16,LCFI11-LCFI10
	.long L$set$16
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.set L$set$17,LCFI12-LCFI11
	.long L$set$17
	.byte	0xe
	.uleb128 0x8
	.align 3
LEFDE3:
LSFDE5:
	.set L$set$18,LEFDE5-LASFDE5
	.long L$set$18
LASFDE5:
	.long	LASFDE5-EH_frame1
	.quad	LFB2153-.
	.set L$set$19,LFE2153-LFB2153
	.quad L$set$19
	.uleb128 0
	.align 3
LEFDE5:
LSFDE7:
	.set L$set$20,LEFDE7-LASFDE7
	.long L$set$20
LASFDE7:
	.long	LASFDE7-EH_frame1
	.quad	LFB2154-.
	.set L$set$21,LFE2154-LFB2154
	.quad L$set$21
	.uleb128 0
	.byte	0x4
	.set L$set$22,LCFI13-LFB2154
	.long L$set$22
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.set L$set$23,LCFI14-LCFI13
	.long L$set$23
	.byte	0xe
	.uleb128 0x18
	.byte	0x83
	.uleb128 0x3
	.byte	0x4
	.set L$set$24,LCFI15-LCFI14
	.long L$set$24
	.byte	0xe
	.uleb128 0x30
	.byte	0x4
	.set L$set$25,LCFI16-LCFI15
	.long L$set$25
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.set L$set$26,LCFI17-LCFI16
	.long L$set$26
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.set L$set$27,LCFI18-LCFI17
	.long L$set$27
	.byte	0xe
	.uleb128 0x8
	.align 3
LEFDE7:
LSFDE9:
	.set L$set$28,LEFDE9-LASFDE9
	.long L$set$28
LASFDE9:
	.long	LASFDE9-EH_frame1
	.quad	LFB2524-.
	.set L$set$29,LFE2524-LFB2524
	.quad L$set$29
	.uleb128 0
	.byte	0x4
	.set L$set$30,LCFI19-LFB2524
	.long L$set$30
	.byte	0xe
	.uleb128 0x10
	.byte	0x83
	.uleb128 0x2
	.byte	0x4
	.set L$set$31,LCFI20-LCFI19
	.long L$set$31
	.byte	0xe
	.uleb128 0x8
	.align 3
LEFDE9:
	.ident	"GCC: (Homebrew GCC 13.2.0) 13.2.0"
	.mod_init_func
_Mod.init:
	.align 3
	.quad	__GLOBAL__sub_I_IncrementalConv.cpp
	.subsections_via_symbols
