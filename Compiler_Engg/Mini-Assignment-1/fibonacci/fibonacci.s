	.text
	.file	"fibonacci.c"
	.globl	fibo                            # -- Begin function fibo
	.p2align	4, 0x90
	.type	fibo,@function
fibo:                                   # @fibo
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	%edi, -8(%rbp)
	cmpl	$0, -8(%rbp)
	je	.LBB0_2
# %bb.1:
	cmpl	$1, -8(%rbp)
	jne	.LBB0_3
.LBB0_2:
	movl	-8(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB0_4
.LBB0_3:
	movl	-8(%rbp), %edi
	subl	$1, %edi
	callq	fibo
	movl	%eax, -12(%rbp)                 # 4-byte Spill
	movl	-8(%rbp), %edi
	subl	$2, %edi
	callq	fibo
	movl	%eax, %ecx
	movl	-12(%rbp), %eax                 # 4-byte Reload
	addl	%ecx, %eax
	movl	%eax, -4(%rbp)
.LBB0_4:
	movl	-4(%rbp), %eax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	fibo, .Lfunc_end0-fibo
	.cfi_endproc
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	$0, -4(%rbp)
	movl	$6, -8(%rbp)
	movl	-8(%rbp), %edi
	callq	fibo
	movl	%eax, -12(%rbp)
	movl	-12(%rbp), %esi
	leaq	.L.str(%rip), %rdi
	movb	$0, %al
	callq	printf@PLT
	xorl	%eax, %eax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"nth fibonacci element (here n=6): %d"
	.size	.L.str, 37

	.ident	"clang version 16.0.0 (https://github.com/llvm/llvm-project.git 6b940588a0fc77e60a61dc5e9a2fdcca1c1109e1)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym fibo
	.addrsig_sym printf
