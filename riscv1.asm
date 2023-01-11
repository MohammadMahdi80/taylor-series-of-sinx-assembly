jal x0, main

fact:
	addi sp, sp, -8    
	sw   x1, 4(sp)   
	sw   x10, 0(sp)	  
	
	addi x5, x10, -1   
	bgt  x5, x0, L1    
	
	addi x10, x0, 1   
	addi sp, sp, 8    
	jalr x0, 0(x1)   
	
	L1:
		addi x10, x10, -1   
		jal x1, fact         
		
		addi x6, x10, 0      
		lw x10, 0(sp)	  
		lw x1, 4(sp)	  
		addi sp, sp, 8	 
		
		mul x10, x10, x6  
		
		jalr x0, 0(x1) 	     
		
power:
	bne x12, x0, X1
	addi x11, x0, 1
	jalr x0, 0(x1)
	X1:
	addi x5, x11, 0
	addi x6, x12, -1
	bgt x6, x0, L2
	jalr x0, 0(x1)
	L2:
		mul x11, x5, x11
		addi x6, x6, -1
		bgt x6, x0, L2
		jalr x0, 0(x1)
		
sine:
	fcvt.s.w f4, x0
	LOOP1:
		# calculate (-1)^k
		addi sp, sp, -12
		sw x1, 8(sp)
		sw x12, 4(sp)
		sw x11, 0(sp)
		
		addi x11, x11, -1
		jal x1, power
		addi x9, x11, 0 # result of this section
		
		lw x1, 8(sp)
		lw x12, 4(sp)
		lw x11, 0(sp)
		addi sp, sp, 12
		
		# calculate (2k+1)!
		addi sp, sp, -8
		sw x1, 4(sp)
		sw x10, 0(sp)
		
		addi x7, x0, 2
		mul x10, x7, x12 # x12 is k
		addi x10, x10, 1
		jal x1, fact
		addi x18, x10, 0 # result of this section

		lw x1, 4(sp)
		lw x10, 0(sp)
		addi sp, sp, 8
		
		# calculate x^(2k+1)
		addi sp, sp, -12
		sw x1, 8(sp)
		sw x12, 4(sp)
		sw x11, 0(sp)
		
		addi x28, x12, 0 # now x28 is k for this section
		addi x7, x0, 2
		mul x7, x7, x28
		addi x7, x7, 1
		addi x11, x13, 0
		addi x12, x7, 0
		jal x1, power
		addi x19, x11, 0 # result of this section
		
		lw x1, 8(sp)
		lw x12, 4(sp)
		lw x11, 0(sp)
		addi sp, sp, 12
		
		mul x7, x19, x9
		
		fcvt.s.w f1, x7
		fcvt.s.w f2, x18
		fdiv.s f3, f1, f2
		fadd.s f4, f4, f3
		
		
		addi x12, x12, -1
			
		bge x12, x0, LOOP1
		jalr x0, 0(x1)
			
main:
	addi x12, x0, 2 # n
	addi x13, x0, 1 # x
	jal x1, sine
	



		
		
