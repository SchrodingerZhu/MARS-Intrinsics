__builtin_memcpy_aligned_large:
	ble   $a2, 8, __builtin_memcpy_bytes
	ld    $t0, ($a1)
	sd    $t0, ($a0)
	subiu $a2, $a2, 8
	addiu $a1, $a1, 8
	addiu $a0, $a0, 8
	j     __builtin_memcpy_aligned_large
__builtin_memcpy_bytes:
	beqz  $a2, __builtin_memcpy_return
	lbu   $t0, ($a1)
	sb    $t0, ($a0)
	subiu $a2, $a2, 1
	addiu $a1, $a1, 1
	addiu $a0, $a0, 1
	j     __builtin_memcpy_bytes
__builtin_memcpy_return:
	jr    $ra	
__builtin_memcpy:
	ble   $a2, 8, __builtin_memcpy_bytes
	xor   $t8, $a0, $a1
	andi  $t8, $t0, 3 # whether the whole process can be aligned
	subu  $t1, $zero, $a0
	andi  $t1, $t1, 3 # destination alignment
__builtin_memcpy_prepare:
	# align destination
	# if the whole process can be aligned, this function will also do so
	beqz  $t1, __builtin_memcpy_check
	lbu   $t0, ($a1)
	sb    $t0, ($a0)
	subiu $a2, $a2, 1
	subiu $t1, $t1, 1
	addiu $a1, $a1, 1
	addiu $a0, $a0, 1
	j     __builtin_memcpy_prepare
__builtin_memcpy_check:
	beqz  $t8, __builtin_memcpy_aligned_large
__builtin_memcpy_unaligned_large:
	ble   $a2, 4, __builtin_memcpy_bytes
	lwl   $t0, 0($a1)
	lwr   $t0, 1($a1)
	sw    $t0, ($a0)
	subiu $a2, $a2, 4
	addiu $a1, $a1, 4
	addiu $a0, $a0, 4
	j      __builtin_memcpy_unaligned_large
