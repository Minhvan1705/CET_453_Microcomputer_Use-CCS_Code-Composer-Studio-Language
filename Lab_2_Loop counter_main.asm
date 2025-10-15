;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer
		    NOP
	        NOP
	        NOP
	        NOP
	        NOP
	        NOP
	        NOP
	        NOP
	        MOV.W   #mystr,R4
	        MOV.W   #0200h,R5
	        MOV.W   #0000h,R6
	        MOV.W   #0000h,R7
	        MOV.W   #0000h,R8
	        MOV.W   #0000h,R9
	        MOV.W   #0000h,R10
	        MOV.W   #0000h,R11
	        MOV.W   #0200h,R11
;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------
main:                                   ; main program
        inc.w   R6                      ; increment loop counter
        mov.b	@R4, 0(R5)              ; copy data @ "at" the memory location indicated by R4 to the memory location indicated by R5
        inc.w   R4                      ; point to the next source byte
        inc.w   R5                      ; point to the next destination byte

        JMP main                        ; jump to beginning of main program
                                        ; (endless loop)
                                            

mystr
			.string "CET 453 is the best class I have ever taken!"
               		;         1         2         3          4
                	;12345678901234567890123456789012345678901234567

;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            
