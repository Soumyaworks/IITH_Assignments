	.text
	.file	"binary_search.c"
	.globl	binarySearch                    # -- Begin function binarySearch
	.p2align	4, 0x90
	.type	binarySearch,@function
binarySearch:                           # @binarySearch
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -16(%rbp)
	movl	%esi, -20(%rbp)
	movl	%edx, -24(%rbp)
	movl	%ecx, -28(%rbp)
	movl	-24(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jl	.LBB0_6
# %bb.1:
	movl	-20(%rbp), %eax
	movl	%eax, -36(%rbp)                 # 4-byte Spill
	movl	-24(%rbp), %eax
	subl	-20(%rbp), %eax
	movl	$2, %ecx
	cltd
	idivl	%ecx
	movl	%eax, %ecx
	movl	-36(%rbp), %eax                 # 4-byte Reload
	addl	%ecx, %eax
	movl	%eax, -32(%rbp)
	movq	-16(%rbp), %rax
	movslq	-32(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	cmpl	-28(%rbp), %eax
	jne	.LBB0_3
# %bb.2:
	movl	-32(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB0_7
.LBB0_3:
	movq	-16(%rbp), %rax
	movslq	-32(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	cmpl	-28(%rbp), %eax
	jle	.LBB0_5
# %bb.4:
	movq	-16(%rbp), %rdi
	movl	-20(%rbp), %esi
	movl	-32(%rbp), %edx
	subl	$1, %edx
	movl	-28(%rbp), %ecx
	callq	binarySearch
	movl	%eax, -4(%rbp)
	jmp	.LBB0_7
.LBB0_5:
	movq	-16(%rbp), %rdi
	movl	-32(%rbp), %esi
	addl	$1, %esi
	movl	-24(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	binarySearch
	movl	%eax, -4(%rbp)
	jmp	.LBB0_7
.LBB0_6:
	movl	$-1, -4(%rbp)
.LBB0_7:
	movl	-4(%rbp), %eax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	binarySearch, .Lfunc_end0-binarySearch
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
	subq	$48, %rsp
	movl	$0, -4(%rbp)
	movq	.L__const.main.array(%rip), %rax
	movq	%rax, -32(%rbp)
	movq	.L__const.main.array+8(%rip), %rax
	movq	%rax, -24(%rbp)
	movq	.L__const.main.array+16(%rip), %rax
	movq	%rax, -16(%rbp)
	movl	$6, -36(%rbp)
	movl	$488, -40(%rbp)                 # imm = 0x1E8
	leaq	-32(%rbp), %rdi
	movl	-36(%rbp), %edx
	subl	$1, %edx
	movl	-40(%rbp), %ecx
	xorl	%esi, %esi
	callq	binarySearch
	movl	%eax, -44(%rbp)
	cmpl	$-1, -44(%rbp)
	jne	.LBB1_2
# %bb.1:
	leaq	.L.str(%rip), %rdi
	movb	$0, %al
	callq	printf@PLT
	jmp	.LBB1_3
.LBB1_2:
	movl	-44(%rbp), %esi
	leaq	.L.str.1(%rip), %rdi
	movb	$0, %al
	callq	printf@PLT
.LBB1_3:
	xorl	%eax, %eax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.type	.L__const.main.array,@object    # @__const.main.array
	.section	.rodata,"a",@progbits
	.p2align	4, 0x0
.L__const.main.array:
	.long	100                             # 0x64
	.long	200                             # 0xc8
	.long	488                             # 0x1e8
	.long	500                             # 0x1f4
	.long	600                             # 0x258
	.long	700                             # 0x2bc
	.size	.L__const.main.array, 24

	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"\nElement is not present in array"
	.size	.L.str, 33

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"\nElement is present here: %d"
	.size	.L.str.1, 29

	.ident	"clang version 16.0.0 (https://github.com/llvm/llvm-project.git 6b940588a0fc77e60a61dc5e9a2fdcca1c1109e1)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym binarySearch
	.addrsig_sym printf
