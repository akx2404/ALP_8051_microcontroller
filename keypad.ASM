ORG 4000H
DB 3FH, 06H, 5BH, 4FH, 66H, 6DH, 7DH, 07H, 7FH, 6FH, 0
;DB 3FH, 06H, 5BH, 4FH, 66H, 6DH, 7DH, 07H, 7FH, 6FH, 0
; Lookup table for digits 0 to 9

ORG 0000H
main:   MOV DPTR, #4000H
repeat: CLR A
        MOVC A, @A+DPTR       ; Copy data from external location to accumulator
        MOV P1, A             ; Move the pattern of the digit into port P2
        ACALL delay           ; Call a delay to so that the transition is visible
        INC DPTR              ; Point to the next pattern
        CJNE A, 0, repeat     ; Repeat till 0 (Stop bit) is received
        SJMP main             ; Run this forever till externally stopped

; generate a decent enough delay between transitions
delay: 
        MOV R0, #08H
LP2:    MOV R1, #0FFH
LP1:    MOV R2, #0FFH
LP3:    DJNZ R2, LP3 
        DJNZ R1, LP1
        DJNZ R0, LP2
        RET
END