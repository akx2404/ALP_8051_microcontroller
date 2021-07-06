ORG 00H
	
MOV A,#11111111B // loads A with all 1's
MOV P0,#00000000B // initializes P0 as output port

ORG 4000H
DB 6FH, 7FH, 07H, 7DH, 6DH, 66H, 4FH, 5BH, 06H, 3FH, 0
;DB 3FH, 06H, 5BH, 4FH, 66H, 6DH, 7DH, 07H, 7FH, 6FH, 0

BACK:MOV P3,#11111111B // loads P3 with all 1's
     CLR P3.0  // makes row 1 low
     JB P3.4,NEXT1  // checks whether column 1 is low and jumps to NEXT1 if not low
	 MOV A,#2D
     ACALL DISPLAY  // calls DISPLAY subroutine
NEXT1:JB P3.5,NEXT2
	  MOV A,#1D
      ACALL DISPLAY
NEXT2:JB P3.6,NEXT3
	  MOV A,#0D
      ACALL DISPLAY
;NEXT3:JB P3.7,NEXT4
;	  MOV A,#10D
;     ACALL DISPLAY
NEXT4:SETB P3.0
      CLR P3.1
      JB P3.4,NEXT5
	  MOV A,#5D
      ACALL DISPLAY
NEXT5:JB P3.5,NEXT6
	  MOV A,#4D
      ACALL DISPLAY
NEXT6:JB P3.6,NEXT7
	  MOV A,#3D
      ACALL DISPLAY
;NEXT7:JB P3.7,NEXT8
;	  MOV A,#10D
;      ACALL DISPLAY
NEXT8:SETB P3.1
      CLR P3.2
      JB P3.4,NEXT9
	  MOV A,#8D
      ACALL DISPLAY
NEXT9:JB P3.5,NEXT10
	  MOV A,#7D
      ACALL DISPLAY
NEXT10:JB P3.6,NEXT11
	   MOV A,#6D
       ACALL DISPLAY
;NEXT11:JB P3.7,NEXT12
;	   MOV A,#10D
;       ACALL DISPLAY
;NEXT12:SETB P3.2
;       CLR P3.3
;       JB P3.4,NEXT13
;	   MOV A,#10D
;       ACALL DISPLAY
NEXT13:JB P3.5,NEXT14
	   MOV A,#9D
       ACALL DISPLAY
;NEXT14:JB P3.6,NEXT15
;	   MOV A,#10D
;       ACALL DISPLAY
;NEXT15:JB P3.7,BACK
;	   MOV A,#10D
;       ACALL DISPLAY
       LJMP BACK
	   
DISPLAY:   MOV DPTR, #4000H
repeat: MOVC A, @A+DPTR       ; Copy data from external location to accumulator
        MOV P1, A            ; Move the pattern of the digit into port P2
        ACALL chaser           ; Call a delay to so that the transition is visible
        INC DPTR              ; Point to the next pattern
        CJNE A, 0, repeat     ; Repeat till 0 (Stop bit) is received
        SJMP DISPLAY
		RET
		
;DISPLAY:MOVC A,@A+DPTR // gets digit drive pattern for the current key from LUT
;       MOV P1,A       // puts corresponding digit drive pattern into P1
;		ACALL chaser
;        RET


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

DELAY:
MOV R1, #5H
XX: MOV R3, 50H
X:DJNZ R3, X
DJNZ R2, XX
RET

LUT: DB 07H //7
     DB 7FH //8
     DB 6FH //9
     DB 00H //div
     DB 66H //4
     DB 6DH //5
     DB 7DH //6
     DB 00H // mul
     DB 06H //1
     DB 5BH //2
     DB 4FH //3
     DB 00H //-
     DB 00H //clc
     DB 3FH //0
     DB 00H //=
     DB 00H //+
     END