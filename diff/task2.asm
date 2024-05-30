.model small 
.stack
.data
	filename db "data.txt",0
	handler dw ?
	buffer db 100 dup('$')
.code
main proc
mov ax,@data
mov ds,ax

	lea dx,filename
	mov al,0
	mov ah,3dh
	int 21h
	mov handler,ax
	
	mov bx,handler
	lea dx,buffer
	mov ah,3fh
	int 21h

	;lea dx,buffer
	mov ah,09
	int 21h

	mov si,0
	comparison:
		mov al,buffer[si]
		cmp al,'!'
		je swap
		cmp al,'@'
		je swap
		cmp al,'#'
		je swap
		cmp al,'%'
		je swap
		cmp al,'^'
		je swap
		cmp al,'&'
		je swap
		cmp al,'*'
		je swap
		cmp al,'1'
		je swap
		cmp al,'2'
		je swap
		cmp al,'3'
		je swap
		cmp al,'4'
		je swap
		cmp al,'5'
		je swap
		cmp al,'6'
		je swap
		cmp al,'7'
		je swap
		cmp al,'8'
		je swap
		cmp al,'9'
		je swap
		cmp al,'0'
		je swap
		inc si
		cmp al,'$'
		je exit
		jmp comparison
	
	swap:
		mov buffer[si],' '
		inc si
		cmp al,'$'
		je exit
		jmp comparison
	

exit:
			mov dx,10
			mov ah,02
			int 21h

			mov dx,13
			mov ah,02
			int 21h
	lea dx,buffer
	mov ah,09
	int 21h
	mov ah,3eh
	mov bx,handler
	int 21h
mov ah,4ch
int 21h
main endp
end