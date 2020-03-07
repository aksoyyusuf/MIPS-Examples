# NestedFuncCall.asm

.data								# Global data here


.text 								# Program here
.globl main   
main:	
		addi $s0, $0, 0				# int result = 0
		addi $s1, $0, 5				# int a = 5
		addi $s2, $0, 3				# int b = 3
		
		addi $t0, $0, 0				# $t0 for temporary values
		addi $t1, $0, 0				# $t1 for temporary values
		
		beq $s1, $s2, equal			#if(a!=b)
		
									# when a is not equal to b
		add $a0, $0, $s1 			# argument 0 is a
		add $a1, $0, $s2			# argument 1 is b
		jal test					# call test(a, b)
		add $s0, $0, $v0			# result = test(a, b)
		
		j mainDone
		
equal:	add $t0, $s1, $s2			# when a is equal to b		
		addi $t1, $0, 2
		mult $t0,$t1
		mflo $s0	
		
mainDone:

		add $a0, $0, $s0			# print $s0 result 
		addi $v0, $0, 1				# syscall 1 for print
		syscall

		ori $v0, 0x0010				# syscall 10 for exit
		syscall						# End of execution
		.end
		
############## Test function ##############
test:	addi $sp, $sp, -4				# allocate space from stack
		sw $ra, 0($sp)				# push return address to stack

		addi $t0, $0, 0				# $t0 for temporary values
		add $t1, $0, $a0			# $t1 = a
		add $t2, $0, $a1			# $t2 = b
		
		
		slt $t0, $t1, $t2			# if(a>b) 
		
		add $a0, $0, $t1			# argument 0 is a	
		add $a1, $0, $t2			# argument 1 is b	
		beq $t0, $0, aIsGreater					
		
		jal subtract				# when a is greater then b
		j testDone
		
aIsGreater:											
		jal multiply				# when a is not greater then b

	
testDone:	
		lw $ra, 0($sp)				# pull return address from stack	
		addi $sp, $sp, 4			# clear stack
		jr $ra						# return to caller


############## Multiply function ##############
multiply:
		addi $t0, $0, 0				# $t0 for temporary values
		
		mult $a0, $a1				# a*b
		mflo $t0					# $t0 = (a * b)
		addi $t0, $t0, 3			# $t0 = (a * b) + 3								
		
		add $v0, $0, $t0			# return value = (a * b) + 3
		
		jr $ra						# return to caller

############## Subtract function ##############
subtract:
		addi $t0, $0, 0				# $t0 for temporary values
		addi $t1, $0, 4				# $t1 for temporary values
		
		sub $t0, $a0, $a1			# $t0 = (a - b)
		mult $t0, $t1				# 4 * (a - b)
		mflo $v0					# return value = 4 * (a - b)
		
		jr $ra						# return to caller


	
		