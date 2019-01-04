	    .text
            .global _start
            
_start:

START:		
	    LDR 	R4, =TEST_NUM	 
            LDR		R4, [R4]		 
            
RESET:      MOV 	R0, #0			
            MOV		R5, #1			
            BL 		SORT			 
            CMP		R0, #1	
            BEQ		RESET		
            
SORT:	    LDR		R3,=TEST_NUM	 
	    ADD		R3, #4			 
LOOP:       LDR		R1, [R3]		
	    LDR         R2, [R3, #4]	 
            ADD		R3, #4			 
            CMP 	R1, R2			
            PUSH	{LR}			
            BLGT 	SWAP			
            POP		{LR}			 
            ADD		R5, #1			 
            CMP		R5, R4			
            MOVEQ	PC, LR		    
            B		LOOP		


SWAP:	      STR		R1, [R3]	     
            SUB		R3, #4			
            STR		R2, [R3]		
            MOV		R0, #1			
            MOV		PC, LR			 
            
TEST_NUM: 	.word	5,10,1,600,20,145,63,1,0

		      	.end
