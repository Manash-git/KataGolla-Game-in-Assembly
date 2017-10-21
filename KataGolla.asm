; A simple KataGolla  Game 

include 'EMU8086.INC'
org 100h
.stack 100h
.model small

; User Define Macro 

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
	choice db 0
	
  	Greeting_Text db 10,13
  				  db 09,09,'--  KataGolla Game  --'   
  	              db 10,13,10,13,'$'
  	
	Board_Default db '123456789$'   
	
  	Board_Structure DB ' | | ',10,13
    				DB '-----',10,13
     				DB ' | | ',10,13
     				DB '-----',10,13
      				DB ' | | ',10,13,10,13,'$'  
    
    Win_Combination		db 	1,2,3,4,5,6,7,8,9                     
                        db	1,4,7,2,5,8,3,6,9
                        db 	1,5,9,3,5,7
			     
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
	
	
	
	call MENU
	call SHOWBOARD    
		     
	jmp ExitGame
main endp

PLAY proc near

	printn "	Do you want to play ??"  
	linebreak
	printn "	If YES Press :: Y || If NO then press :: N"
	
	print "	Enter your Choice :: "
	scanch choice  
	linebreak 
	print "	Output :: "
	printch choice 
	linebreak

About:
	print "This game is "

PLAY endp
	
	
		
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

	