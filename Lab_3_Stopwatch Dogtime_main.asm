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
init:   NOP
        MOV.W   #1234h,R4               ; Initialize source data to identifiable value 0x1234
        MOV.W   #0200h,R5               ; Initialize destination address to start of RAM
        MOV.W   #0000h,R6               ; Initialize loop counter to zero

;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------


main:                                   ; main program
        MOV.W	R4, 0(R5)               ; copy source data in R4 to the memory location indicated by R5
        INC.W   R4                      ; increment source data to next value
        ;INC.W   R5                      ; point to the next destination address (odd byte)
        ADD.W   #0002h, R5              ; point to the next destination address (even byte)
        INC.W   R6                      ; increment loop counter

        JMP main                        ; jump to beginning of main program
                                            

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
            
