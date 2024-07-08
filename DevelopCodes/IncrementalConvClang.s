	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 15	sdk_version 10, 15, 6
	.globl	__Z4initv               ## -- Begin function _Z4initv
	.p2align	4, 0x90
__Z4initv:                              ## @_Z4initv
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	leaq	_A(%rip), %rdi
	movl	$4000000, %esi          ## imm = 0x3D0900
	callq	___bzero
	movq	$-1000, %rbx            ## imm = 0xFC18
	leaq	_k(%rip), %r14
	.p2align	4, 0x90
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
	callq	_rand
	cltq
	imulq	$274877907, %rax, %rcx  ## imm = 0x10624DD3
	movq	%rcx, %rdx
	shrq	$63, %rdx
	sarq	$38, %rcx
	addl	%edx, %ecx
	imull	$1000, %ecx, %ecx       ## imm = 0x3E8
	subl	%ecx, %eax
	vcvtsi2ss	%eax, %xmm1, %xmm0
	vmovss	%xmm0, 4000(%r14,%rbx,4)
	callq	_rand
	cltq
	imulq	$274877907, %rax, %rcx  ## imm = 0x10624DD3
	movq	%rcx, %rdx
	shrq	$63, %rdx
	sarq	$38, %rcx
	addl	%edx, %ecx
	imull	$1000, %ecx, %ecx       ## imm = 0x3E8
	subl	%ecx, %eax
	vcvtsi2ss	%eax, %xmm1, %xmm0
	vmovss	%xmm0, 8000(%r14,%rbx,4)
	incq	%rbx
	jne	LBB0_1
## %bb.2:
	xorl	%ebx, %ebx
	leaq	_data(%rip), %r14
	.p2align	4, 0x90
LBB0_3:                                 ## =>This Inner Loop Header: Depth=1
	callq	_rand
	cltq
	imulq	$274877907, %rax, %rcx  ## imm = 0x10624DD3
	movq	%rcx, %rdx
	shrq	$63, %rdx
	sarq	$38, %rcx
	addl	%edx, %ecx
	imull	$1000, %ecx, %ecx       ## imm = 0x3E8
	subl	%ecx, %eax
	vcvtsi2ss	%eax, %xmm1, %xmm0
	vmovss	%xmm0, (%rbx,%r14)
	addq	$4, %rbx
	cmpq	$40000, %rbx            ## imm = 0x9C40
	jne	LBB0_3
## %bb.4:
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	__Z4Convv               ## -- Begin function _Z4Convv
	.p2align	4, 0x90
__Z4Convv:                              ## @_Z4Convv
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$4008, %rsp             ## imm = 0xFA8
	.cfi_offset %rbx, -24
	movq	___stack_chk_guard@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, -16(%rbp)
	leaq	-4016(%rbp), %rdi
	movl	$4000, %esi             ## imm = 0xFA0
	callq	___bzero
	xorl	%r11d, %r11d
	leaq	_data(%rip), %r8
	leaq	_A(%rip), %rdx
	leaq	_k(%rip), %r10
	movl	$-999, %r9d             ## imm = 0xFC19
	xorl	%eax, %eax
	.p2align	4, 0x90
LBB1_1:                                 ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB1_2 Depth 2
	vbroadcastss	(%r8,%r11,4), %ymm0
	movslq	%eax, %rcx
	movl	$1000, %eax             ## imm = 0x3E8
	subq	%rcx, %rax
	imulq	$4000, %rcx, %rdi       ## imm = 0xFA0
	leaq	(%rdx,%rdi), %rsi
	leaq	(%r10,%rax,4), %rax
	movl	$24, %ebx
	.p2align	4, 0x90
LBB1_2:                                 ##   Parent Loop BB1_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	vmovups	-4112(%rbp,%rbx,4), %ymm1
	vmovups	-4080(%rbp,%rbx,4), %ymm2
	vsubps	-96(%rsi,%rbx,4), %ymm1, %ymm1
	vsubps	-64(%rsi,%rbx,4), %ymm2, %ymm2
	vmulps	-96(%rax,%rbx,4), %ymm0, %ymm3
	vmulps	-64(%rax,%rbx,4), %ymm0, %ymm4
	vmovups	%ymm3, -96(%rsi,%rbx,4)
	vmovups	%ymm4, -64(%rsi,%rbx,4)
	vaddps	%ymm3, %ymm1, %ymm1
	vaddps	%ymm4, %ymm2, %ymm2
	vmovups	%ymm1, -4112(%rbp,%rbx,4)
	vmovups	%ymm2, -4080(%rbp,%rbx,4)
	vmovups	-4048(%rbp,%rbx,4), %ymm1
	vmovups	-4016(%rbp,%rbx,4), %ymm2
	vsubps	-32(%rsi,%rbx,4), %ymm1, %ymm1
	vsubps	(%rsi,%rbx,4), %ymm2, %ymm2
	vmulps	-32(%rax,%rbx,4), %ymm0, %ymm3
	vmulps	(%rax,%rbx,4), %ymm0, %ymm4
	vmovups	%ymm3, -32(%rsi,%rbx,4)
	vmovups	%ymm4, (%rsi,%rbx,4)
	vaddps	%ymm3, %ymm1, %ymm1
	vaddps	%ymm4, %ymm2, %ymm2
	vmovups	%ymm1, -4048(%rbp,%rbx,4)
	vmovups	%ymm2, -4016(%rbp,%rbx,4)
	addq	$32, %rbx
	cmpq	$1016, %rbx             ## imm = 0x3F8
	jne	LBB1_2
## %bb.3:                               ##   in Loop: Header=BB1_1 Depth=1
	vmovss	-48(%rbp), %xmm1        ## xmm1 = mem[0],zero,zero,zero
	vsubss	3968(%rdi,%rdx), %xmm1, %xmm1
	movl	$1992, %eax             ## imm = 0x7C8
	subq	%rcx, %rax
	vmulss	(%r10,%rax,4), %xmm0, %xmm2
	vmovss	%xmm2, 3968(%rdi,%rdx)
	vaddss	%xmm2, %xmm1, %xmm1
	vmovss	%xmm1, -48(%rbp)
	vmovss	-44(%rbp), %xmm1        ## xmm1 = mem[0],zero,zero,zero
	vsubss	3972(%rdi,%rdx), %xmm1, %xmm1
	movl	$1993, %eax             ## imm = 0x7C9
	subq	%rcx, %rax
	vmulss	(%r10,%rax,4), %xmm0, %xmm2
	vmovss	%xmm2, 3972(%rdi,%rdx)
	vaddss	%xmm2, %xmm1, %xmm1
	vmovss	%xmm1, -44(%rbp)
	vmovss	-40(%rbp), %xmm1        ## xmm1 = mem[0],zero,zero,zero
	vsubss	3976(%rdi,%rdx), %xmm1, %xmm1
	movl	$1994, %eax             ## imm = 0x7CA
	subq	%rcx, %rax
	vmulss	(%r10,%rax,4), %xmm0, %xmm2
	vmovss	%xmm2, 3976(%rdi,%rdx)
	vaddss	%xmm2, %xmm1, %xmm1
	vmovss	%xmm1, -40(%rbp)
	vmovss	-36(%rbp), %xmm1        ## xmm1 = mem[0],zero,zero,zero
	vsubss	3980(%rdi,%rdx), %xmm1, %xmm1
	movl	$1995, %eax             ## imm = 0x7CB
	subq	%rcx, %rax
	vmulss	(%r10,%rax,4), %xmm0, %xmm2
	vmovss	%xmm2, 3980(%rdi,%rdx)
	vaddss	%xmm2, %xmm1, %xmm1
	vmovss	%xmm1, -36(%rbp)
	vmovss	-32(%rbp), %xmm1        ## xmm1 = mem[0],zero,zero,zero
	vsubss	3984(%rdi,%rdx), %xmm1, %xmm1
	movl	$1996, %eax             ## imm = 0x7CC
	subq	%rcx, %rax
	vmulss	(%r10,%rax,4), %xmm0, %xmm2
	vmovss	%xmm2, 3984(%rdi,%rdx)
	vaddss	%xmm2, %xmm1, %xmm1
	vmovss	%xmm1, -32(%rbp)
	vmovss	-28(%rbp), %xmm1        ## xmm1 = mem[0],zero,zero,zero
	vsubss	3988(%rdi,%rdx), %xmm1, %xmm1
	movl	$1997, %eax             ## imm = 0x7CD
	subq	%rcx, %rax
	vmulss	(%r10,%rax,4), %xmm0, %xmm2
	vmovss	%xmm2, 3988(%rdi,%rdx)
	vaddss	%xmm2, %xmm1, %xmm1
	vmovss	%xmm1, -28(%rbp)
	vmovss	-24(%rbp), %xmm1        ## xmm1 = mem[0],zero,zero,zero
	vsubss	3992(%rdi,%rdx), %xmm1, %xmm1
	movl	$1998, %eax             ## imm = 0x7CE
	subq	%rcx, %rax
	vmulss	(%r10,%rax,4), %xmm0, %xmm2
	vmovss	%xmm2, 3992(%rdi,%rdx)
	vaddss	%xmm2, %xmm1, %xmm1
	vmovss	%xmm1, -24(%rbp)
	vmovss	-20(%rbp), %xmm1        ## xmm1 = mem[0],zero,zero,zero
	vsubss	3996(%rdi,%rdx), %xmm1, %xmm1
	movl	$1999, %eax             ## imm = 0x7CF
	subq	%rcx, %rax
	vmulss	(%r10,%rax,4), %xmm0, %xmm0
	vmovss	%xmm0, 3996(%rdi,%rdx)
	vaddss	%xmm0, %xmm1, %xmm0
	vmovss	%xmm0, -20(%rbp)
	cmpl	$998, %ecx              ## imm = 0x3E6
	movl	$1, %eax
	cmovgl	%r9d, %eax
	addl	%ecx, %eax
	incq	%r11
	cmpq	$10000, %r11            ## imm = 0x2710
	jne	LBB1_1
## %bb.4:
	movq	___stack_chk_guard@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	-16(%rbp), %rax
	jne	LBB1_6
## %bb.5:
	addq	$4008, %rsp             ## imm = 0xFA8
	popq	%rbx
	popq	%rbp
	vzeroupper
	retq
LBB1_6:
	vzeroupper
	callq	___stack_chk_fail
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3               ## -- Begin function main
LCPI2_0:
	.quad	4666723172467343360     ## double 1.0E+4
LCPI2_1:
	.quad	4756540486875873280     ## double 1.0E+10
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_main
	.p2align	4, 0x90
_main:                                  ## @main
Lfunc_begin0:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception0
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$4024, %rsp             ## imm = 0xFB8
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	movq	___stack_chk_guard@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, -48(%rbp)
	leaq	_A(%rip), %r15
	movl	$4000000, %esi          ## imm = 0x3D0900
	movq	%r15, %rdi
	callq	___bzero
	movq	$-4000, %rbx            ## imm = 0xF060
	leaq	_k(%rip), %r12
	.p2align	4, 0x90
LBB2_1:                                 ## =>This Inner Loop Header: Depth=1
	callq	_rand
	cltq
	imulq	$274877907, %rax, %rcx  ## imm = 0x10624DD3
	movq	%rcx, %rdx
	shrq	$63, %rdx
	sarq	$38, %rcx
	addl	%edx, %ecx
	imull	$1000, %ecx, %ecx       ## imm = 0x3E8
	subl	%ecx, %eax
	vcvtsi2ss	%eax, %xmm1, %xmm0
	vmovss	%xmm0, 4000(%rbx,%r12)
	callq	_rand
	cltq
	imulq	$274877907, %rax, %rcx  ## imm = 0x10624DD3
	movq	%rcx, %rdx
	shrq	$63, %rdx
	sarq	$38, %rcx
	addl	%edx, %ecx
	imull	$1000, %ecx, %ecx       ## imm = 0x3E8
	subl	%ecx, %eax
	vcvtsi2ss	%eax, %xmm1, %xmm0
	vmovss	%xmm0, 8000(%rbx,%r12)
	addq	$4, %rbx
	jne	LBB2_1
## %bb.2:
	xorl	%ebx, %ebx
	leaq	_data(%rip), %r13
	.p2align	4, 0x90
LBB2_3:                                 ## =>This Inner Loop Header: Depth=1
	callq	_rand
	cltq
	imulq	$274877907, %rax, %rcx  ## imm = 0x10624DD3
	movq	%rcx, %rdx
	shrq	$63, %rdx
	sarq	$38, %rcx
	addl	%edx, %ecx
	imull	$1000, %ecx, %ecx       ## imm = 0x3E8
	subl	%ecx, %eax
	vcvtsi2ss	%eax, %xmm1, %xmm0
	vmovss	%xmm0, (%rbx,%r13)
	addq	$4, %rbx
	cmpq	$40000, %rbx            ## imm = 0x9C40
	jne	LBB2_3
## %bb.4:
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	L_.str(%rip), %rsi
	movl	$5, %edx
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	movq	%rax, %r14
	movq	(%rax), %rax
	movq	-24(%rax), %rsi
	addq	%r14, %rsi
	leaq	-4048(%rbp), %rbx
	movq	%rbx, %rdi
	callq	__ZNKSt3__18ios_base6getlocEv
Ltmp0:
	movq	__ZNSt3__15ctypeIcE2idE@GOTPCREL(%rip), %rsi
	movq	%rbx, %rdi
	callq	__ZNKSt3__16locale9use_facetERNS0_2idE
Ltmp1:
## %bb.5:
	movq	(%rax), %rcx
Ltmp2:
	movq	%rax, %rdi
	movl	$10, %esi
	callq	*56(%rcx)
Ltmp3:
## %bb.6:
	movl	%eax, %ebx
	leaq	-4048(%rbp), %rdi
	callq	__ZNSt3__16localeD1Ev
	movsbl	%bl, %esi
	movq	%r14, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE3putEc
	movq	%r14, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE5flushEv
	callq	__ZNSt3__16chrono12steady_clock3nowEv
	movq	%rax, %r14
	leaq	-4048(%rbp), %rdi
	movl	$4000, %esi             ## imm = 0xFA0
	callq	___bzero
	xorl	%eax, %eax
	movl	$-999, %r8d             ## imm = 0xFC19
	xorl	%ecx, %ecx
	.p2align	4, 0x90
LBB2_7:                                 ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB2_8 Depth 2
	vbroadcastss	(%r13,%rax,4), %ymm0
	movslq	%ecx, %rdx
	movl	$1000, %ecx             ## imm = 0x3E8
	subq	%rdx, %rcx
	imulq	$4000, %rdx, %rsi       ## imm = 0xFA0
	leaq	(%r15,%rsi), %rdi
	leaq	(%r12,%rcx,4), %rbx
	movl	$24, %ecx
	.p2align	4, 0x90
LBB2_8:                                 ##   Parent Loop BB2_7 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	vmovups	-4144(%rbp,%rcx,4), %ymm1
	vmovups	-4112(%rbp,%rcx,4), %ymm2
	vsubps	-96(%rdi,%rcx,4), %ymm1, %ymm1
	vsubps	-64(%rdi,%rcx,4), %ymm2, %ymm2
	vmulps	-96(%rbx,%rcx,4), %ymm0, %ymm3
	vmulps	-64(%rbx,%rcx,4), %ymm0, %ymm4
	vmovups	%ymm3, -96(%rdi,%rcx,4)
	vmovups	%ymm4, -64(%rdi,%rcx,4)
	vaddps	%ymm3, %ymm1, %ymm1
	vaddps	%ymm4, %ymm2, %ymm2
	vmovups	%ymm1, -4144(%rbp,%rcx,4)
	vmovups	%ymm2, -4112(%rbp,%rcx,4)
	vmovups	-4080(%rbp,%rcx,4), %ymm1
	vmovups	-4048(%rbp,%rcx,4), %ymm2
	vsubps	-32(%rdi,%rcx,4), %ymm1, %ymm1
	vsubps	(%rdi,%rcx,4), %ymm2, %ymm2
	vmulps	-32(%rbx,%rcx,4), %ymm0, %ymm3
	vmulps	(%rbx,%rcx,4), %ymm0, %ymm4
	vmovups	%ymm3, -32(%rdi,%rcx,4)
	vmovups	%ymm4, (%rdi,%rcx,4)
	vaddps	%ymm3, %ymm1, %ymm1
	vaddps	%ymm4, %ymm2, %ymm2
	vmovups	%ymm1, -4080(%rbp,%rcx,4)
	vmovups	%ymm2, -4048(%rbp,%rcx,4)
	addq	$32, %rcx
	cmpq	$1016, %rcx             ## imm = 0x3F8
	jne	LBB2_8
## %bb.9:                               ##   in Loop: Header=BB2_7 Depth=1
	vmovss	-80(%rbp), %xmm1        ## xmm1 = mem[0],zero,zero,zero
	vsubss	3968(%rsi,%r15), %xmm1, %xmm1
	movl	$1992, %ecx             ## imm = 0x7C8
	subq	%rdx, %rcx
	vmulss	(%r12,%rcx,4), %xmm0, %xmm2
	vmovss	%xmm2, 3968(%rsi,%r15)
	vaddss	%xmm2, %xmm1, %xmm1
	vmovss	%xmm1, -80(%rbp)
	vmovss	-76(%rbp), %xmm1        ## xmm1 = mem[0],zero,zero,zero
	vsubss	3972(%rsi,%r15), %xmm1, %xmm1
	movl	$1993, %ecx             ## imm = 0x7C9
	subq	%rdx, %rcx
	vmulss	(%r12,%rcx,4), %xmm0, %xmm2
	vmovss	%xmm2, 3972(%rsi,%r15)
	vaddss	%xmm2, %xmm1, %xmm1
	vmovss	%xmm1, -76(%rbp)
	vmovss	-72(%rbp), %xmm1        ## xmm1 = mem[0],zero,zero,zero
	vsubss	3976(%rsi,%r15), %xmm1, %xmm1
	movl	$1994, %ecx             ## imm = 0x7CA
	subq	%rdx, %rcx
	vmulss	(%r12,%rcx,4), %xmm0, %xmm2
	vmovss	%xmm2, 3976(%rsi,%r15)
	vaddss	%xmm2, %xmm1, %xmm1
	vmovss	%xmm1, -72(%rbp)
	vmovss	-68(%rbp), %xmm1        ## xmm1 = mem[0],zero,zero,zero
	vsubss	3980(%rsi,%r15), %xmm1, %xmm1
	movl	$1995, %ecx             ## imm = 0x7CB
	subq	%rdx, %rcx
	vmulss	(%r12,%rcx,4), %xmm0, %xmm2
	vmovss	%xmm2, 3980(%rsi,%r15)
	vaddss	%xmm2, %xmm1, %xmm1
	vmovss	%xmm1, -68(%rbp)
	vmovss	-64(%rbp), %xmm1        ## xmm1 = mem[0],zero,zero,zero
	vsubss	3984(%rsi,%r15), %xmm1, %xmm1
	movl	$1996, %ecx             ## imm = 0x7CC
	subq	%rdx, %rcx
	vmulss	(%r12,%rcx,4), %xmm0, %xmm2
	vmovss	%xmm2, 3984(%rsi,%r15)
	vaddss	%xmm2, %xmm1, %xmm1
	vmovss	%xmm1, -64(%rbp)
	vmovss	-60(%rbp), %xmm1        ## xmm1 = mem[0],zero,zero,zero
	vsubss	3988(%rsi,%r15), %xmm1, %xmm1
	movl	$1997, %ecx             ## imm = 0x7CD
	subq	%rdx, %rcx
	vmulss	(%r12,%rcx,4), %xmm0, %xmm2
	vmovss	%xmm2, 3988(%rsi,%r15)
	vaddss	%xmm2, %xmm1, %xmm1
	vmovss	%xmm1, -60(%rbp)
	vmovss	-56(%rbp), %xmm1        ## xmm1 = mem[0],zero,zero,zero
	vsubss	3992(%rsi,%r15), %xmm1, %xmm1
	movl	$1998, %ecx             ## imm = 0x7CE
	subq	%rdx, %rcx
	vmulss	(%r12,%rcx,4), %xmm0, %xmm2
	vmovss	%xmm2, 3992(%rsi,%r15)
	vaddss	%xmm2, %xmm1, %xmm1
	vmovss	%xmm1, -56(%rbp)
	vmovss	-52(%rbp), %xmm1        ## xmm1 = mem[0],zero,zero,zero
	vsubss	3996(%rsi,%r15), %xmm1, %xmm1
	movl	$1999, %ecx             ## imm = 0x7CF
	subq	%rdx, %rcx
	vmulss	(%r12,%rcx,4), %xmm0, %xmm0
	vmovss	%xmm0, 3996(%rsi,%r15)
	vaddss	%xmm0, %xmm1, %xmm0
	vmovss	%xmm0, -52(%rbp)
	cmpl	$998, %edx              ## imm = 0x3E6
	movl	$1, %ecx
	cmovgl	%r8d, %ecx
	addl	%edx, %ecx
	incq	%rax
	cmpq	$10000, %rax            ## imm = 0x2710
	jne	LBB2_7
## %bb.10:
	vzeroupper
	callq	__ZNSt3__16chrono12steady_clock3nowEv
	subq	%r14, %rax
	movabsq	$2361183241434822607, %rcx ## imm = 0x20C49BA5E353F7CF
	imulq	%rcx
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$7, %rdx
	addq	%rax, %rdx
	vcvtsi2sd	%rdx, %xmm5, %xmm0
	vmovsd	%xmm0, -4056(%rbp)      ## 8-byte Spill
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	L_.str.1(%rip), %rsi
	movl	$17, %edx
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	movq	%rax, %rdi
	vmovsd	-4056(%rbp), %xmm0      ## 8-byte Reload
                                        ## xmm0 = mem[0],zero
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEd
	movq	%rax, %rbx
	movq	(%rax), %rax
	movq	-24(%rax), %rsi
	addq	%rbx, %rsi
	leaq	-4048(%rbp), %r14
	movq	%r14, %rdi
	callq	__ZNKSt3__18ios_base6getlocEv
Ltmp5:
	movq	__ZNSt3__15ctypeIcE2idE@GOTPCREL(%rip), %rsi
	movq	%r14, %rdi
	callq	__ZNKSt3__16locale9use_facetERNS0_2idE
Ltmp6:
## %bb.11:
	movq	(%rax), %rcx
Ltmp7:
	movq	%rax, %rdi
	movl	$10, %esi
	callq	*56(%rcx)
Ltmp8:
## %bb.12:
	movl	%eax, %r14d
	leaq	-4048(%rbp), %rdi
	callq	__ZNSt3__16localeD1Ev
	movsbl	%r14b, %esi
	movq	%rbx, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE3putEc
	movq	%rbx, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE5flushEv
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	L_.str.2(%rip), %rsi
	movl	$20, %edx
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	vmovsd	-4056(%rbp), %xmm0      ## 8-byte Reload
                                        ## xmm0 = mem[0],zero
	vdivsd	LCPI2_0(%rip), %xmm0, %xmm0
	movq	%rax, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEd
	movq	%rax, %rbx
	movq	(%rax), %rax
	movq	-24(%rax), %rsi
	addq	%rbx, %rsi
	leaq	-4048(%rbp), %r14
	movq	%r14, %rdi
	callq	__ZNKSt3__18ios_base6getlocEv
Ltmp10:
	movq	__ZNSt3__15ctypeIcE2idE@GOTPCREL(%rip), %rsi
	movq	%r14, %rdi
	callq	__ZNKSt3__16locale9use_facetERNS0_2idE
Ltmp11:
## %bb.13:
	movq	(%rax), %rcx
Ltmp12:
	movq	%rax, %rdi
	movl	$10, %esi
	callq	*56(%rcx)
Ltmp13:
## %bb.14:
	movl	%eax, %r14d
	leaq	-4048(%rbp), %rdi
	callq	__ZNSt3__16localeD1Ev
	movsbl	%r14b, %esi
	movq	%rbx, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE3putEc
	movq	%rbx, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE5flushEv
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	L_.str.3(%rip), %rsi
	movl	$20, %edx
	callq	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	vmovsd	LCPI2_1(%rip), %xmm0    ## xmm0 = mem[0],zero
	vdivsd	-4056(%rbp), %xmm0, %xmm0 ## 8-byte Folded Reload
	movq	%rax, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEd
	movq	%rax, %rbx
	movq	(%rax), %rax
	movq	-24(%rax), %rsi
	addq	%rbx, %rsi
	leaq	-4048(%rbp), %r14
	movq	%r14, %rdi
	callq	__ZNKSt3__18ios_base6getlocEv
Ltmp15:
	movq	__ZNSt3__15ctypeIcE2idE@GOTPCREL(%rip), %rsi
	movq	%r14, %rdi
	callq	__ZNKSt3__16locale9use_facetERNS0_2idE
Ltmp16:
## %bb.15:
	movq	(%rax), %rcx
Ltmp17:
	movq	%rax, %rdi
	movl	$10, %esi
	callq	*56(%rcx)
Ltmp18:
## %bb.16:
	movl	%eax, %r14d
	leaq	-4048(%rbp), %rdi
	callq	__ZNSt3__16localeD1Ev
	movsbl	%r14b, %esi
	movq	%rbx, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE3putEc
	movq	%rbx, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE5flushEv
	movq	___stack_chk_guard@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	-48(%rbp), %rax
	jne	LBB2_17
## %bb.23:
	xorl	%eax, %eax
	addq	$4024, %rsp             ## imm = 0xFB8
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
LBB2_17:
	callq	___stack_chk_fail
LBB2_22:
Ltmp19:
	jmp	LBB2_19
LBB2_21:
Ltmp14:
	jmp	LBB2_19
LBB2_20:
Ltmp9:
	jmp	LBB2_19
LBB2_18:
Ltmp4:
LBB2_19:
	movq	%rax, %rbx
	leaq	-4048(%rbp), %rdi
	callq	__ZNSt3__16localeD1Ev
	movq	%rbx, %rdi
	callq	__Unwind_Resume
	ud2
Lfunc_end0:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2
GCC_except_table2:
Lexception0:
	.byte	255                     ## @LPStart Encoding = omit
	.byte	255                     ## @TType Encoding = omit
	.byte	1                       ## Call site Encoding = uleb128
	.uleb128 Lcst_end0-Lcst_begin0
Lcst_begin0:
	.uleb128 Lfunc_begin0-Lfunc_begin0 ## >> Call Site 1 <<
	.uleb128 Ltmp0-Lfunc_begin0     ##   Call between Lfunc_begin0 and Ltmp0
	.byte	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp0-Lfunc_begin0     ## >> Call Site 2 <<
	.uleb128 Ltmp3-Ltmp0            ##   Call between Ltmp0 and Ltmp3
	.uleb128 Ltmp4-Lfunc_begin0     ##     jumps to Ltmp4
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp3-Lfunc_begin0     ## >> Call Site 3 <<
	.uleb128 Ltmp5-Ltmp3            ##   Call between Ltmp3 and Ltmp5
	.byte	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp5-Lfunc_begin0     ## >> Call Site 4 <<
	.uleb128 Ltmp8-Ltmp5            ##   Call between Ltmp5 and Ltmp8
	.uleb128 Ltmp9-Lfunc_begin0     ##     jumps to Ltmp9
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp8-Lfunc_begin0     ## >> Call Site 5 <<
	.uleb128 Ltmp10-Ltmp8           ##   Call between Ltmp8 and Ltmp10
	.byte	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp10-Lfunc_begin0    ## >> Call Site 6 <<
	.uleb128 Ltmp13-Ltmp10          ##   Call between Ltmp10 and Ltmp13
	.uleb128 Ltmp14-Lfunc_begin0    ##     jumps to Ltmp14
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp13-Lfunc_begin0    ## >> Call Site 7 <<
	.uleb128 Ltmp15-Ltmp13          ##   Call between Ltmp13 and Ltmp15
	.byte	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp15-Lfunc_begin0    ## >> Call Site 8 <<
	.uleb128 Ltmp18-Ltmp15          ##   Call between Ltmp15 and Ltmp18
	.uleb128 Ltmp19-Lfunc_begin0    ##     jumps to Ltmp19
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp18-Lfunc_begin0    ## >> Call Site 9 <<
	.uleb128 Lfunc_end0-Ltmp18      ##   Call between Ltmp18 and Lfunc_end0
	.byte	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
Lcst_end0:
	.p2align	2
                                        ## -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m ## -- Begin function _ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	.weak_def_can_be_hidden	__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	.p2align	4, 0x90
__ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m: ## @_ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Lfunc_begin1:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception1
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$40, %rsp
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	movq	%rdx, %r14
	movq	%rsi, %r15
	movq	%rdi, %rbx
Ltmp20:
	leaq	-80(%rbp), %rdi
	movq	%rbx, %rsi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryC1ERS3_
Ltmp21:
## %bb.1:
	cmpb	$0, -80(%rbp)
	je	LBB3_10
## %bb.2:
	movq	(%rbx), %rax
	movq	-24(%rax), %rax
	leaq	(%rbx,%rax), %r12
	movq	40(%rbx,%rax), %rdi
	movl	8(%rbx,%rax), %r13d
	movl	144(%rbx,%rax), %eax
	cmpl	$-1, %eax
	jne	LBB3_7
## %bb.3:
Ltmp23:
	movq	%rdi, -64(%rbp)         ## 8-byte Spill
	leaq	-56(%rbp), %rdi
	movq	%r12, %rsi
	callq	__ZNKSt3__18ios_base6getlocEv
Ltmp24:
## %bb.4:
Ltmp25:
	movq	__ZNSt3__15ctypeIcE2idE@GOTPCREL(%rip), %rsi
	leaq	-56(%rbp), %rdi
	callq	__ZNKSt3__16locale9use_facetERNS0_2idE
Ltmp26:
## %bb.5:
	movq	(%rax), %rcx
Ltmp27:
	movq	%rax, %rdi
	movl	$32, %esi
	callq	*56(%rcx)
	movb	%al, -41(%rbp)          ## 1-byte Spill
Ltmp28:
## %bb.6:
	leaq	-56(%rbp), %rdi
	callq	__ZNSt3__16localeD1Ev
	movsbl	-41(%rbp), %eax         ## 1-byte Folded Reload
	movl	%eax, 144(%r12)
	movq	-64(%rbp), %rdi         ## 8-byte Reload
LBB3_7:
	addq	%r15, %r14
	andl	$176, %r13d
	cmpl	$32, %r13d
	movq	%r15, %rdx
	cmoveq	%r14, %rdx
Ltmp30:
	movsbl	%al, %r9d
	movq	%r15, %rsi
	movq	%r14, %rcx
	movq	%r12, %r8
	callq	__ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
Ltmp31:
## %bb.8:
	testq	%rax, %rax
	jne	LBB3_10
## %bb.9:
	movq	(%rbx), %rax
	movq	-24(%rax), %rax
	leaq	(%rbx,%rax), %rdi
	movl	32(%rbx,%rax), %esi
	orl	$5, %esi
Ltmp33:
	callq	__ZNSt3__18ios_base5clearEj
Ltmp34:
LBB3_10:
	leaq	-80(%rbp), %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev
LBB3_11:
	movq	%rbx, %rax
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
LBB3_12:
Ltmp35:
	jmp	LBB3_15
LBB3_13:
Ltmp29:
	movq	%rax, %r14
	leaq	-56(%rbp), %rdi
	callq	__ZNSt3__16localeD1Ev
	jmp	LBB3_16
LBB3_14:
Ltmp32:
LBB3_15:
	movq	%rax, %r14
LBB3_16:
	leaq	-80(%rbp), %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev
	jmp	LBB3_18
LBB3_17:
Ltmp22:
	movq	%rax, %r14
LBB3_18:
	movq	%r14, %rdi
	callq	___cxa_begin_catch
	movq	(%rbx), %rax
	movq	-24(%rax), %rdi
	addq	%rbx, %rdi
Ltmp36:
	callq	__ZNSt3__18ios_base33__set_badbit_and_consider_rethrowEv
Ltmp37:
## %bb.19:
	callq	___cxa_end_catch
	jmp	LBB3_11
LBB3_20:
Ltmp38:
	movq	%rax, %rbx
Ltmp39:
	callq	___cxa_end_catch
Ltmp40:
## %bb.21:
	movq	%rbx, %rdi
	callq	__Unwind_Resume
	ud2
LBB3_22:
Ltmp41:
	movq	%rax, %rdi
	callq	___clang_call_terminate
Lfunc_end1:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2
GCC_except_table3:
Lexception1:
	.byte	255                     ## @LPStart Encoding = omit
	.byte	155                     ## @TType Encoding = indirect pcrel sdata4
	.uleb128 Lttbase0-Lttbaseref0
Lttbaseref0:
	.byte	1                       ## Call site Encoding = uleb128
	.uleb128 Lcst_end1-Lcst_begin1
Lcst_begin1:
	.uleb128 Ltmp20-Lfunc_begin1    ## >> Call Site 1 <<
	.uleb128 Ltmp21-Ltmp20          ##   Call between Ltmp20 and Ltmp21
	.uleb128 Ltmp22-Lfunc_begin1    ##     jumps to Ltmp22
	.byte	1                       ##   On action: 1
	.uleb128 Ltmp23-Lfunc_begin1    ## >> Call Site 2 <<
	.uleb128 Ltmp24-Ltmp23          ##   Call between Ltmp23 and Ltmp24
	.uleb128 Ltmp32-Lfunc_begin1    ##     jumps to Ltmp32
	.byte	1                       ##   On action: 1
	.uleb128 Ltmp25-Lfunc_begin1    ## >> Call Site 3 <<
	.uleb128 Ltmp28-Ltmp25          ##   Call between Ltmp25 and Ltmp28
	.uleb128 Ltmp29-Lfunc_begin1    ##     jumps to Ltmp29
	.byte	1                       ##   On action: 1
	.uleb128 Ltmp30-Lfunc_begin1    ## >> Call Site 4 <<
	.uleb128 Ltmp31-Ltmp30          ##   Call between Ltmp30 and Ltmp31
	.uleb128 Ltmp32-Lfunc_begin1    ##     jumps to Ltmp32
	.byte	1                       ##   On action: 1
	.uleb128 Ltmp33-Lfunc_begin1    ## >> Call Site 5 <<
	.uleb128 Ltmp34-Ltmp33          ##   Call between Ltmp33 and Ltmp34
	.uleb128 Ltmp35-Lfunc_begin1    ##     jumps to Ltmp35
	.byte	1                       ##   On action: 1
	.uleb128 Ltmp34-Lfunc_begin1    ## >> Call Site 6 <<
	.uleb128 Ltmp36-Ltmp34          ##   Call between Ltmp34 and Ltmp36
	.byte	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp36-Lfunc_begin1    ## >> Call Site 7 <<
	.uleb128 Ltmp37-Ltmp36          ##   Call between Ltmp36 and Ltmp37
	.uleb128 Ltmp38-Lfunc_begin1    ##     jumps to Ltmp38
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp37-Lfunc_begin1    ## >> Call Site 8 <<
	.uleb128 Ltmp39-Ltmp37          ##   Call between Ltmp37 and Ltmp39
	.byte	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp39-Lfunc_begin1    ## >> Call Site 9 <<
	.uleb128 Ltmp40-Ltmp39          ##   Call between Ltmp39 and Ltmp40
	.uleb128 Ltmp41-Lfunc_begin1    ##     jumps to Ltmp41
	.byte	1                       ##   On action: 1
	.uleb128 Ltmp40-Lfunc_begin1    ## >> Call Site 10 <<
	.uleb128 Lfunc_end1-Ltmp40      ##   Call between Ltmp40 and Lfunc_end1
	.byte	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
Lcst_end1:
	.byte	1                       ## >> Action Record 1 <<
                                        ##   Catch TypeInfo 1
	.byte	0                       ##   No further actions
	.p2align	2
                                        ## >> Catch TypeInfos <<
	.long	0                       ## TypeInfo 1
Lttbase0:
	.p2align	2
                                        ## -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.private_extern	__ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_ ## -- Begin function _ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
	.globl	__ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
	.weak_def_can_be_hidden	__ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
	.p2align	4, 0x90
__ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_: ## @_ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
Lfunc_begin2:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception2
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$56, %rsp
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	testq	%rdi, %rdi
	je	LBB4_20
## %bb.1:
	movq	%r8, %r12
	movq	%rcx, %r15
	movq	%rdi, %r13
	movl	%r9d, -68(%rbp)         ## 4-byte Spill
	movq	%rcx, %rax
	subq	%rsi, %rax
	movq	24(%r8), %rcx
	xorl	%r14d, %r14d
	subq	%rax, %rcx
	cmovgq	%rcx, %r14
	movq	%rdx, -88(%rbp)         ## 8-byte Spill
	movq	%rdx, %rbx
	subq	%rsi, %rbx
	testq	%rbx, %rbx
	jle	LBB4_3
## %bb.2:
	movq	(%r13), %rax
	movq	%r13, %rdi
	movq	%rbx, %rdx
	callq	*96(%rax)
	cmpq	%rbx, %rax
	jne	LBB4_20
LBB4_3:
	testq	%r14, %r14
	jle	LBB4_16
## %bb.4:
	movq	%r12, -80(%rbp)         ## 8-byte Spill
	cmpq	$23, %r14
	jae	LBB4_8
## %bb.5:
	leal	(%r14,%r14), %eax
	movb	%al, -64(%rbp)
	leaq	-64(%rbp), %rbx
	leaq	-63(%rbp), %r12
	jmp	LBB4_9
LBB4_8:
	leaq	16(%r14), %rbx
	andq	$-16, %rbx
	movq	%rbx, %rdi
	callq	__Znwm
	movq	%rax, %r12
	movq	%rax, -48(%rbp)
	orq	$1, %rbx
	movq	%rbx, -64(%rbp)
	movq	%r14, -56(%rbp)
	leaq	-64(%rbp), %rbx
LBB4_9:
	movzbl	-68(%rbp), %esi         ## 1-byte Folded Reload
	movq	%r12, %rdi
	movq	%r14, %rdx
	callq	_memset
	movb	$0, (%r12,%r14)
	testb	$1, -64(%rbp)
	je	LBB4_11
## %bb.10:
	movq	-48(%rbp), %rbx
	jmp	LBB4_12
LBB4_11:
	incq	%rbx
LBB4_12:
	movq	-80(%rbp), %r12         ## 8-byte Reload
	movq	(%r13), %rax
Ltmp42:
	movq	%r13, %rdi
	movq	%rbx, %rsi
	movq	%r14, %rdx
	callq	*96(%rax)
Ltmp43:
## %bb.13:
	movq	%rax, %rbx
	testb	$1, -64(%rbp)
	je	LBB4_15
## %bb.14:
	movq	-48(%rbp), %rdi
	callq	__ZdlPv
LBB4_15:
	cmpq	%r14, %rbx
	jne	LBB4_20
LBB4_16:
	movq	-88(%rbp), %rsi         ## 8-byte Reload
	subq	%rsi, %r15
	testq	%r15, %r15
	jle	LBB4_18
## %bb.17:
	movq	(%r13), %rax
	movq	%r13, %rdi
	movq	%r15, %rdx
	callq	*96(%rax)
	cmpq	%r15, %rax
	jne	LBB4_20
LBB4_18:
	movq	$0, 24(%r12)
	jmp	LBB4_21
LBB4_20:
	xorl	%r13d, %r13d
LBB4_21:
	movq	%r13, %rax
	addq	$56, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
LBB4_22:
Ltmp44:
	movq	%rax, %rbx
	testb	$1, -64(%rbp)
	je	LBB4_24
## %bb.23:
	movq	-48(%rbp), %rdi
	callq	__ZdlPv
LBB4_24:
	movq	%rbx, %rdi
	callq	__Unwind_Resume
	ud2
Lfunc_end2:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2
GCC_except_table4:
Lexception2:
	.byte	255                     ## @LPStart Encoding = omit
	.byte	255                     ## @TType Encoding = omit
	.byte	1                       ## Call site Encoding = uleb128
	.uleb128 Lcst_end2-Lcst_begin2
Lcst_begin2:
	.uleb128 Lfunc_begin2-Lfunc_begin2 ## >> Call Site 1 <<
	.uleb128 Ltmp42-Lfunc_begin2    ##   Call between Lfunc_begin2 and Ltmp42
	.byte	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp42-Lfunc_begin2    ## >> Call Site 2 <<
	.uleb128 Ltmp43-Ltmp42          ##   Call between Ltmp42 and Ltmp43
	.uleb128 Ltmp44-Lfunc_begin2    ##     jumps to Ltmp44
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp43-Lfunc_begin2    ## >> Call Site 3 <<
	.uleb128 Lfunc_end2-Ltmp43      ##   Call between Ltmp43 and Lfunc_end2
	.byte	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
Lcst_end2:
	.p2align	2
                                        ## -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.private_extern	___clang_call_terminate ## -- Begin function __clang_call_terminate
	.globl	___clang_call_terminate
	.weak_def_can_be_hidden	___clang_call_terminate
	.p2align	4, 0x90
___clang_call_terminate:                ## @__clang_call_terminate
## %bb.0:
	pushq	%rax
	callq	___cxa_begin_catch
	callq	__ZSt9terminatev
                                        ## -- End function
	.globl	_k                      ## @k
.zerofill __DATA,__common,_k,8000,4
	.globl	_A                      ## @A
.zerofill __DATA,__common,_A,4000000,4
	.globl	_data                   ## @data
.zerofill __DATA,__common,_data,40000,4
	.section	__DATA,__data
	.globl	_ke                     ## @ke
	.p2align	3
_ke:
	.quad	_k+4000

	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"Start"

L_.str.1:                               ## @.str.1
	.asciz	"Total Time (us): "

L_.str.2:                               ## @.str.2
	.asciz	"Time Per Data (us): "

L_.str.3:                               ## @.str.3
	.asciz	"Max Frequency (Hz): "

.subsections_via_symbols
