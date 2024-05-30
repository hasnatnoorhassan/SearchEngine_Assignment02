.model small
.stack
.data
msg1 db "Enter 1 for byte array sum and 2 for Word array sum: $"
msg2 db "Input in array: $"
msg3 db 0ah,0dh,"Input the row number of which you want the sum: $"
msg4 db 0ah,0dh,"Sum: $"
array db 3 dup(3 dup(?))
array1 dw 3 dup(3 dup(?))
sumR db 0
.code
main proc
	mov ax,@data
	mov ds,ax
	mov ax,0
	mov bx,0
	mov cx,0
	mov dx,0
	
	mov si,0
	start:	
		lea dx,msg1
		mov ah,09
		int 21h
		mov ah,01
		int 21h
		sub al,48

		cmp al,1
		je startb
		cmp al,2
		je startw
		jmp exit
			
	startb:
			mov dx,10
			mov ah,02
			int 21h

			mov dx,13
			mov ah,02
			int 21h
			lea dx,msg2
			mov ah,09
			int 21h

	inputb:
		mov ah,01
		int 21h
		sub al,48
		mov array[si],al
		inc si
		cmp si,9
		je byte_sum
		jmp inputb

	startw:
			mov dx,10
			mov ah,02
			int 21h

			mov dx,13
			mov ah,02
			int 21h
			lea dx,msg2
			mov ah,09
			int 21h
	inputw:
		mov ah,01
		int 21h
		sub al,48
		mov array[si],al
		add si,2
		cmp si,18
		je word_sum
		jmp inputw

	byte_sum:
		call b_sum
		lea dx,msg4
		mov ah,09
		int 21h
		mov dx,ax
		add dx,48
		mov ah,02
		int 21h
		jmp exit	
	word_sum:
		call w_sum
		lea dx,msg4
		mov ah,09
		int 21h
		mov dx,ax
		add dx,48
		mov ah,02
		int 21h	

exit:
mov ah,4ch
int 21h
main endp

b_sum proc
	mov si,0
	mov ax,00
	lea dx,msg3
	mov ah,09
	int 21h
	mov ah,01
	int 21h
	sub al,48

	mov ah,00
	cmp al,1
	je sum1	
	cmp al,2
	je sum2
	cmp al,3
	je sum3
	jmp exit
	
	sum1:
		mov si,0
		mov bx,0
	sum_r1:
		mov al,array[bx+si]
		add sumR,al
		inc si
		cmp si,3
		jne sum_r1
		jmp exit
	sum2:
		mov si,0
		mov bx,3
	sum_r2:
		mov al,array[bx+si]
		add sumR,al
		inc si
		cmp si,3
		jne sum_r2
		jmp exit
	sum3:
		mov si,0
		mov bx,6
	sum_r3:
		mov al,array[bx+si]
		add sumR,al
		inc si
		cmp si,3
		jne sum_r1
	
	
exit:
	mov ah,00
	mov al,sumR
	
ret
b_sum endp

w_sum proc
	mov si,0
	mov ax,00
	lea dx,msg3
	mov ah,09
	int 21h
	mov ah,01
	int 21h
	sub al,48

	mov ah,00
	cmp al,1
	je sum1	
	cmp al,2
	je sum2
	cmp al,3
	je sum3
	jmp exit
	
	sum1:
		mov si,0
		mov bx,0
	sum_r1:
		mov al,array[bx+si]
		add sumR,al
		add si,2
		cmp si,6
		jne sum_r1
		jmp exit
	sum2:
		mov si,0
		mov bx,6
	sum_r2:
		mov al,array[bx+si]
		add sumR,al
		add si,2
		cmp si,6
		jne sum_r2
		jmp exit
	sum3:
		mov si,0
		mov bx,12
	sum_r3:
		mov al,array[bx+si]
		add sumR,al
		add si,2
		cmp si,6
		jne sum_r1
	
	
exit:
	mov ah,00
	mov al,sumR
	
ret
w_sum endp
end