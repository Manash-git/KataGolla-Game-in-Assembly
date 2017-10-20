; A simple KataGolla  Game 

include 'EMU8086.INC'
org 100h
.stack 100h
.model small
.data  
  	
	Board_Dis_No 		db 	'123456789'   
  	Board_structure 	db 	10,13   
  	                    db 	' | | ',10,13  
  	                    db 	'-----',10,13
                        db 	' | | ',10,13 
                        db 	'-----',10,13
                        db 	' | | ',10,13  
    
    Win_Combination		db 	1,2,3,4,5,6,7,8,9                     
                        db	1,4,7,2,5,8,3,6,9
                        db 	1,5,9,3,5,7
	
	Board_Positinon 	db	1,3,5,11,13,15,21,23,25

.code  

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

SHOWBOARD proc
	  
	mov cx,9	  
	sub si,si
	
	print:
		
		 mov al,Board_Position[si]
		 mov di,al
		 
		
	
SHOWBOARD endp
		
		
Exit:	
	mov ah,4ch
	int 21h 
	
	main endp

end main

	