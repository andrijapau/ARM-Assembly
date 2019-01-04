/* Note to reader, the subroutine "ones" is used to determine the number of consecutive ones.           *
 * The subroutine "zeros" is used to determine the number of consecutive zeros.                         *
 * The subroutine "alternate" is used to determine the number of consecutive alternating ones and zeros.*/
 
      .text
			.global _start

_start:		  LDR R4, =TEST_NUM  
			      MOV R5, #0			
            MOV R6, #0			
            MOV R7, #0	
            
LOOP:		
			LDR 	R1, [R4]		
            LDR 	R4, [R4,#4]	   
            CMP 	R1, #0			
            BEQ 	END
            
            BL 		ONES			
            CMP 	R5, R0			
            MOVLT 	R5, R0
            
            BL 		ZEROS		
            CMP 	R6, R0			
            MOVLT 	R6, R0
            
            BL 		ALTERNATE		
            CMP 	R7, R10			
            MOVLT 	R7, R10
            
            B 		LOOP
END: 		    B		END

ONES:		    MOV		R0, #0		
			      MOV		R9, R1			

ONES_LOOP:	LSR		R2, R9, #1		
			      AND		R9, R9, R2
            ADD		R0, #1 
            CMP		R9, #0
            BEQ		ONES_END	
            B		ONES_LOOP		
         
ONES_END:	  MOV		PC, LR			

ZEROS:		  LDR 	R2, = XOR_NUM
			      LDR 	R2, [R2]		
            EOR 	R1, R2, R1		
            MOV		R8, LR		
            BL		ONES 			
            MOV 	LR, R8			
            B		ZEROS_END		

ZEROS_END: 	MOV 	PC, LR			

ALTERNATE:	MOV		R0, #0
			      MOV		R10, R1

LOOP_ALT:   ASR		R2, R10, #1	
		      	EOR		R10, R10, R2	
            ADD		R0, #1		
            CMP     R10, #0
          	BEQ		END_ALT
            B		LOOP_ALT

END_ALT:  	MOV 	PC, LR
           
TEST_NUM:
	    .word 0x12345678
            .word 0x55567775
            .word 0xeeeeaaaa
            .word 0xffffffff
            .word 0x89898989

XOR_NUM:	.word 0xffffffff	
			    .word 0xaaaaaaaa
