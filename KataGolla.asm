; A simple KataGolla  Game 

include 'EMU8086.INC'
org 100h
.stack 100h
.model small

; User Define Macro 

tab macro
	mov ah,2
	mov dl,09h
	int 21h
endm

linebreak macro 
	mov ah,2
	mov dl,0ah
	int 21h
	mov dl,0dh
	int 21h
endm

PrintStr macro str
	mov ah,9
	lea dx,str
	int 21h
endm

scanch macro schar
	mov ah,1
	int 21h
	;sub al,'0'
	mov schar,al
endm

printch macro pchar
	mov ah,2 
	mov dl,pchar
	int 21h
endm

exit macro
	mov ah,4ch
	int 21h
endm


.data 
    count db 0
    MenuSelect db 0 
    AboutExit db 0 
	Playchoice db 0  
	
	About_Text db 09,10,13," KataGolla (also known as noughts and crosses or Xs and Os)",10,13
			   db 09," is a paper-and-pencil game for two players, X and O,",10,13
			   db 09," who take turns marking the spaces in a 3×3 grid.",10,13
			   db 09," The player who succeeds in placing three of their marks",10,13
			   db 09," in a horizontal, vertical, or diagonal row wins the game.",10,13,'$'
	
  	Greeting_Text db 10,13
  				  db 09,09,'--  KataGolla Game  --'   
  	              db 10,13,10,13,'$'
  	
	Board_Default db '123456789$'   
	
  	Board_Structure DB ' | | ',10,13
    				DB '-----',10,13
     				DB ' | | ',10,13
     				DB '-----',10,13
      				DB ' | | ',10,13,10,13,'$'  
    
			     
			;   DB '0|2|4'
    		;	DB '-----'
     		;	DB '14|16|18'
     		;	DB '-----'
      		;	DB '28|30|32'   
      				
    Board_Position db 0,2,4,14,16,18,28,30,32     
    

.code  
.startup 

main proc 
	mov ax,@data
	mov ds,ax
	
	; setting video mode
	
;	mov ah,0
;	mov al,12h
;	int 10h
	
	; Display colouring
	
	MOV AH, 06h    ; Scroll up function
	sub AL, AL     ; Clear entire screen
	XOR CX, CX     ; Upper left corner CH=row, CL=column
	MOV DX, 184FH  ; lower right corner DH=row, DL=column 
	MOV BH, 1Eh    ; YellowOnBlue   
	INT 10H
	
	; Print Greeting   
	printstr Greeting_Text
	
;	lea dx,Greeting_Text
;	mov ah,9
;	int 21h
	
;    printn "" 
     printn "  				  Welcome Folks " 
;    printn "" 
;    printn ""	 
;	 printn "  		  --  KataGolla Game  --"
	
	
	
;	call PLAY
;	call ABOUT
;	call SHOWBOARD  
	call Menu  
		     
	jmp ExitGame
main endp


	; Menu function 

Menu proc near
	linebreak
	printn "Choose your option."
	linebreak
	tab
	print "PLAY"
	tab
	printn "About"

	
	print "Press P :: PLAY" 
	tab
	linebreak
	print "Press A :: About"  
	
	Menuloop: 
	linebreak
	print "Enter::  "
	scanch MenuSelect
	cmp MenuSelect,'P'
	je PLAY
	cmp MenuSelect,'A'
	je ABOUT
	
	printn "Invalid command. Press again."
	loop Menuloop
	
	
	ret
Menu endp

PLAY proc near                                                   ; play function
	printn "	Do you want to play ??"  
	linebreak
	printn "	If YES Press :: Y || If NO then press :: N"
	
	PlayLoop:
	print "	Enter your Choice :: "
	scanch Playchoice  
	linebreak 
	print "	Output :: "
	printch Playchoice 
	linebreak
    
    
    cmp Playchoice,'Y'
    je GameON
    cmp Playchoice,'N'
    je ExitGame
    printn "Invalid Command. Press Again."
    loop PlayLoop
    
    
    ret
    
PLAY endp


ABOUT proc near                            						; about function
	
	
	PrintStr About_Text 
	
	linebreak
	printn " Developed For Assembly Lab." 
	linebreak 
	linebreak
	printn "Press E :: For Returing to main menu."
	
	
	AboutLoop: 
		print "Enter:: "
		scanch AboutExit
		cmp AboutExit,'E'
		je Menu
		printn "Invalid Command. Press Again."
        loop AboutLoop
	ret
	
ABOUT endp


GameON proc near
    call SHOWBOARD
    
player1:
    cmp count,10
    je tie
     print "X Enter your move (1 to 9):"
     mov ah,1        ;Enter Input
     int 21h
     
     sub al,31h
     cmp al,1
     jl player1
     cmp al,9
     jg player1
     
     dec al
     
     cbw
     
     mov si,ax
     mov al,Board_Default[si]
     
     cmp al,'X'
     je OMsg1
     cmp al,'O'
     je OMsg1
     
     mov Board_Default[si],'X'
     linebreak
     call showboard 
     inc count
     ; CHECK START
      
    mov si,0
	;sub si,si
	mov bx,0

rowx:
    cmp bx,3
    je colx
    cmp Board_Default[si],'X'
    jne nextx    
    cmp Board_Default[si+1],'X'
    jne nextx
    cmp Board_Default[si+2],'X' 
    je winX
    jne nextx
    
    nextx:
    add si,3
    inc bx
    jmp rowx
    
    
colx:
    cmp bx,6
    je corx1
    cmp Board_Default[si],'X'
    jne nextx1    
    cmp Board_Default[si+3],'X'
    jne nextx1
    cmp Board_Default[si+6],'X'
    je winX 
    jne nextx1
    
    nextx1:
    add di,1
    inc bx   
    jmp colx
    
corx1:
    
    cmp Board_Default[0],'X'
    jne corx2  
    cmp Board_Default[4],'X'
    jne corx2 
    cmp Board_Default[8],'X'
    je winX

corx2:
    
    cmp Board_Default[2],'X'
    jne player2 
    cmp Board_Default[4],'X'  
    jne player2 
    cmp Board_Default[6],'X'
    je winX 
    
    jne player2
    
     
OMsg1:
    print "The position is Already used."    
    jmp player1
player2:
    print " O Enter your move (1 to 9):"
     mov ah,1        ;Enter Input
     int 21h
     
     cmp al,1
     jl player1
     cmp al,9
     jg player1
     
     dec al
     sub al,31h
     cbw
     
     mov si,ax
     mov al,Board_Default[si]
     
     cmp al,'X'
     je OMsg2
     cmp al,'O'
     je OMsg2
     
     mov Board_Default[si],'O'
     linebreak  
     call showboard
     inc count
     
     mov si,0
	;sub si,si
	mov bx,0

rowO:
    cmp bx,3
    je colO
    cmp Board_Default[si],'O'
    jne nextO    
    cmp Board_Default[si+1],'O'
    jne nextO
    cmp Board_Default[si+2],'O' 
    je winO
    jne nextO
    
    nextO:
    add si,3
    inc bx
    jmp rowO
    
    
colO:
    cmp bx,6
    je corO1
    cmp Board_Default[si],'O'
    jne nextO1    
    cmp Board_Default[si+3],'O'
    jne nextO1
    cmp Board_Default[si+6],'O'
    je winO 
    jne nextO1
    
    nextO1:
    add di,1
    inc bx   
    jmp colO
    
corO1:
    
    cmp Board_Default[0],'O'
    jne corO2  
    cmp Board_Default[4],'O'
    jne corO2 
    cmp Board_Default[8],'O'
    je winO

corO2:
    
    cmp Board_Default[2],'O'
    jne player1  
    cmp Board_Default[4],'O'  
    jne player1
    cmp Board_Default[6],'O'
    je winO 
    
    jne player1
     
OMsg2:
    print "The position is Already used."    
    jmp player2
    
winx:
    printn "X Win"
    jmp ExitGame
    
winO: 
    printn "O win."
    jmp ExitGame

tie:
    printn "Match Tie"
    jmp ExitGame
        
    ret
GameON endp
            
            
            
SHOWBOARD proc near
	  
	    mov cx,9	  
		xor si,si
	
	GetBoardValue:	
		 mov al,Board_Position[si]
		 cbw
		 mov di,ax
		 mov al,Board_Default[si]
		 mov Board_structure[di],al
		 inc si
		 loop GetBoardValue
		 
;		 printn "Test before board"
		 
		 lea dx,Board_Structure    
		 mov ah,9
		 int 21h
;		 printn "Test After board"
		 
		 ret
		
	
SHOWBOARD endp
		

		
ExitGame:
	print "Thanks For Playing .."
		
	mov ah,4ch
	int 21h 
	

end main

	