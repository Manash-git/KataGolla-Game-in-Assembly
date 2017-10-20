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
.code  

main proc 
	mov ax,@data
	mov ds,ax
	
	
	
	mov ah,4ch
	int 21h 
	
	main endp

end main

	