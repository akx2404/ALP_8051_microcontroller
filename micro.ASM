ORG 4000H
DB 6FH, 7FH, 07H, 7DH, 6DH, 66H, 4FH, 5BH, 06H, 3FH, 0 ;digits 9 to 0


ORG 0000H
main:   MOV DPTR, #4000H
repeat: CLR A
        MOVC A, @A+DPTR       ; Copy data from external location to accumulator
        MOV P1, A             ; Move the pattern of the digit into port P2
        ACALL chaser           ; Call a delay to so that the transition is visible
        INC DPTR              ; Point to the next pattern
        CJNE A, 0, repeat     ; Repeat till 0 (Stop bit) is received
        SJMP main             ; Run this forever till externally stopped

chaser:
MOV P2, #0ffh
AGAIN:
MOV P2, #00000000B
ACALL DELAY
MOV P2, #00000001B
ACALL DELAY
MOV P2, #00000011B
ACALL DELAY
MOV P2, #00000111B
ACALL DELAY
MOV P2, #00001111B
ACALL DELAY
MOV P2, #00011111B
ACALL DELAY
MOV P2, #00111111B
ACALL DELAY
MOV P2, #01111111B
ACALL DELAY
MOV P2, #11111111B
ACALL DELAY
RET

;delay for the LED CHASER
DELAY:
MOV R1, #5H
XX: MOV R3, 50H
X:DJNZ R3, X
DJNZ R1, XX
RET


END