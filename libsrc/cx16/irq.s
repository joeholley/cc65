;
; IRQ handling (CX16 version)
;

        .export         initirq, doneirq
        .import         callirq

        .include        "cx16.inc"

; ------------------------------------------------------------------------

.segment        "ONCE"

initirq:
        lda     IRQVec
        ldx     IRQVec+1
        sta     IRQInd+1
        stx     IRQInd+2
        lda     #<IRQStub
        ldx     #>IRQStub
        jmp     setvec

; ------------------------------------------------------------------------

.code

doneirq:
        lda     IRQInd+1
        ldx     IRQInd+2
setvec: sei
        sta     IRQVec
        stx     IRQVec+1
        cli
        rts

; ------------------------------------------------------------------------

.segment        "LOWCODE"

IRQStub:
        jsr     callirq                 ; Call the functions
        jmp     IRQInd                  ; Jump to the saved IRQ vector

; ------------------------------------------------------------------------

.data

IRQInd: jmp     $0000
