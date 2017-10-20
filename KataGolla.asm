; A simple KataGolla  Game 

include 'EMU8086.INC'
org 100h
.stack 100h
.model small
.data  
  	
	Board_Default db '123456789$'   
	
  	Board_Structure DB ' | | ',0DH,0AH
    				DB '-----',0DH,0AH
     				DB ' | | ',0DH,0AH
     				DB '-----',0DH,0AH
      				DB ' | | ',0DH,0AH,0DH,0AH,'$'  
    
    Win_Combination		db 	1,2,3,4,5,6,7,8,9                     
                        db	1,4,7,2,5,8,3,6,9
                        db 	1,5,9,3,5,7
			     
			;   DB '0|2|4',0DH,0AH
    		;	DB '-----',0DH,0AH
     		;	DB '14|16|18',0DH,0AH
     		;	DB '-----',0DH,0AH
      		;	DB '28|30|32',     
      				
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
	
    printn "" 
    print "  			  Welcome Folks " 
    printn "" 
    printn ""	 
	printn "  		  --  KataGolla Game  --"
	
	call SHOWBOARD 
	jmp EXIT
main endp

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
		 
		 printn "Test before board"
		 
		 lea dx,Board_Structure    
		 mov ah,9
		 int 21h
		 printn "Test After board"
		 
		 ret
		
	
SHOWBOARD endp
		
		
Exit:	
	mov ah,4ch
	int 21h 
	

end main

	