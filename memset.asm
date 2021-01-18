__builtin_memset:
	# a0, address
	# a1, byte
	# a2, size
	bgeu $a2, 8, __builtin_memset_large
__builtin_memset_small:
	beqz $a2, __builtin_memset_return
	sb $a1, ($a0)
	addiu $a0, $a0, 1
	subiu $a2, $a2, 1
	j __builtin_memset_small 
__builtin_memset_large:
	rol $t0, $a1, 8
	or  $t0, $t0, $a1 
	rol $t1, $t0, 16
	or  $t1, $t1, $t0
	move $t0, $t1
	swr $t0, ($a0) 
	subu $t2, $zero, $a0 # alignment
	andi $t2, $a2, 3
	addu $a0, $a0, $t2
	subu $a2, $a2, $t2
__builtin_memset_large_loop:
	sd $t0, ($a0)
	addiu $a0, $a0, 8
	subiu $a2, $a2, 8
	bleu $a2, 8, __builtin_memset_small
	j __builtin_memset_large_loop
__builtin_memset_return:
	jr $ra
