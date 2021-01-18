__builtin_exit:
	# a0 is already the return number, no need to modify
	li $v0, 17 # SYS_exit
	syscall

__builtin_printint:
	# a0 is the integer to print
	li $v0, 1
	syscall
	jr $ra
	
__builtin_printstr:
	li $v0, 4
	syscall
	jr $ra
	
__builtin_readstr:
	# a0 is the address, $a1 is the buffer size
	li $v0, 8
	syscall
	jr $ra

__builtin_malloc:
	# a0 is the size to allocate
	li $v0, 9
	syscall
	jr $ra

__builtin_putchar:
	li $v0, 11
	syscall
	jr $ra

__builtin_getchar:
	li $v0, 12
	syscall
	jr $ra

__builtin_open:
	# a0: filename
	# a1: flags
	# a2: mode
	li $v0, 13
	syscall
	jr $ra
		
__builtin_read:
	# a0, fd
	# a1, buffer address
	# a2, buffersize
	li $v0, 14
	syscall
	jr $ra
	
__builtin_write:
	# a0, fd
	# a1, buffer address
	# a2, buffersize
	li $v0, 15
	syscall
	jr $ra

__builtin_close:
	# a0, fd
	li $v0, 16
	syscall
	jr $ra

__builtin_millisleep:
	# a0, milliseconds
	li $v0, 32
	syscall
	jr $ra

__builtin_sleep:
	mul $a0, $a0, 1000
	move $t0, $ra
	jal __builtin_millisleep 
	jr $t0

__builtin_randomint:
	li $a0, 0
	li $v0, 41
	syscall
	move $v0, $a0
	jr $ra
