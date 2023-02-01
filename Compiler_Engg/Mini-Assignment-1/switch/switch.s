	.text
	.file	"switch.c"
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
	subq	$32, %rsp
	movl	$0, -4(%rbp)
	leaq	.L.str(%rip), %rdi
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	movb	%al, -21(%rbp)                  # 1-byte Spill
	callq	printf@PLT
                                        # kill: def $ecx killed $eax
	movb	-21(%rbp), %al                  # 1-byte Reload
	leaq	.L.str.1(%rip), %rdi
	leaq	-8(%rbp), %rsi
	callq	__isoc99_scanf@PLT
	movl	-8(%rbp), %eax
	movl	%eax, -20(%rbp)                 # 4-byte Spill
	subl	$1, %eax
	je	.LBB0_1
	jmp	.LBB0_5
.LBB0_5:
	movl	-20(%rbp), %eax                 # 4-byte Reload
	subl	$2, %eax
	je	.LBB0_2
	jmp	.LBB0_3
.LBB0_1:
	leaq	.L.str.2(%rip), %rdi
	movb	$0, %al
	callq	printf@PLT
	jmp	.LBB0_4
.LBB0_2:
	leaq	.L.str.3(%rip), %rdi
	movb	$0, %al
	callq	printf@PLT
	jmp	.LBB0_4
.LBB0_3:
	leaq	.L.str.4(%rip), %rdi
	movb	$0, %al
	callq	printf@PLT
.LBB0_4:
	xorl	%eax, %eax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"\nEnter the value of n (1/2/any other) :"
	.size	.L.str, 40

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"%d"
	.size	.L.str.1, 3

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"The value of n entered is 1"
	.size	.L.str.2, 28

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"The value of n entered is 2"
	.size	.L.str.3, 28

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	"The value of n entered is anything other than 1 and 2"
	.size	.L.str.4, 54

	.ident	"clang version 16.0.0 (https://github.com/llvm/llvm-project.git 6b940588a0fc77e60a61dc5e9a2fdcca1c1109e1)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym printf
	.addrsig_sym __isoc99_scanf
