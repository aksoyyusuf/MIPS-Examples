# ArrayUsage.asm


.data									# Global data here

	
	# Array 
	A:	.word 1, 1, 1, 1, 1, 1, 1, 1, 1, 1		
	
	# Array size	
	N:	.word 10						



.text 									# Program here
.globl main   
main:	
		addi $s0, $0, 0					# $s0 result
		la $s1, A						# $s1 array base address
		lw $s2, N						# $s2 array size
		addi $t0, $0, 0					# $t0 for temporary values
		addi $t1, $0, 0					# $t1 is i =  mainLoop counter
		addi $t2, $0, 1					# isDistinct flag
		
		mainLoop: 
				beq $t1, $s2, finish	# while(i < N)

				jal isDistinct
				
				# if element is not distinct, 
				# then don't increment result
				bne $t2, $v0, dontIncResult	
								
				addi $s0, $s0, 1		# if element is distinct, 
										# then increment result
		dontIncResult:		
				
				addi $t1, $t1, 1		# i++
				j mainLoop
		finish:
		
				add $a0, $0, $s0		# print $s0 result 
				addi $v0, $0, 1			# syscall 1 for print
				syscall
				
				addi $v0, $0, 10		# syscall 10 for exit
				syscall					# End of execution
				.end
		
isDistinct:
			
		addi $t3, $0, 0					# $t3 = j
		addi $t0, $0, 0					# $t0 for temporary values
		addi $t4, $0, 0					# $t4 for temporary values
		addi $t5, $0, 0					# $t5 for temporary values
		addi $v0, $0, 0					# #v0 return value
		
		sll $t0, $t1, 2					# $t0 = (i) * 4 byte offset	
		add $t0, $t0, $s1				# address of array[i]
		lw $t4, 0($t0)					# $t4 = array[i]

		funcLoop: 
				beq $t3, $t1, distinct		# while(j < i)
				
				sll $t0, $t3, 2			# $t0 = (j) * 4 byte offset
				add $t0, $t0, $s1		# $t0 = address of array[j]
				lw $t5, 0($t0)			# $t5 = array[j]
				
				# branch taken 
				# if array element is not distinct
				beq $t4, $t5, notDistinct	
										
				
				addi $t3, $t3, 1		# j++
				j funcLoop
		
		
		distinct:
				addi $v0, $0, 1			# return 1 when value is distinct,
										# return 0 when it is not
		notDistinct:
				jr $ra
	
	
		
	
