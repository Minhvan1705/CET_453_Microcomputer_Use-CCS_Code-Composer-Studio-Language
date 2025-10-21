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


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------
main:       mov.w   #0x0000, R4     ; STEP 1 Initialize loop counter to zero
            mov.w   #0xFFFF, R5     ; STEP 2 Initialize variable 1
            mov.w   #0x0000, R6     ; STEP 3 Initialize variable 2
            mov.w   #0x0280, SP     ; STEP 4 Initialize Stack Pointer
loop:       inc.w   R4              ; STEP 5  Increment loop counter
            inc.w   R5				; STEP 6
            add.w   #0x0001, R5		; STEP 7
            add.w   R5,R6			; STEP 8
            sub.w   R5,R6			; STEP 9
            sub.w   R5,R6			; STEP 10
            push.w  #0x0000			; STEP 11
            pop.w   R8				; STEP 12
			call        #myFunction	; STEP 13
            NOP						; STEP 17 !!
            NOP						; STEP 18
            NOP						; STEP 19
            JMP     loop			; STEP 20

myFunction: mov.w  #0x0000,  R7		; STEP 14
            inc.w  R7				; STEP 15
            ret 					; STEP 16
                                            

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
            
