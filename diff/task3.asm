.model small 
.stack
.data
	filename db "story.txt",0
	handler dw ?
	buffer db 1000 dup('$')
	countv db 0
	msg1 db "Vowel count in file: $"
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
	mov si,0
	comp_vowel:
		mov al,buffer[si]
		cmp al,'a'
		JE count_vowel
		cmp al,'e'
		JE count_vowel
		cmp al,'i'
		JE count_vowel
		cmp al,'o'
		JE count_vowel
		cmp al,'u'
		JE count_vowel

		cmp al,'A'
		JE count_vowel
		cmp al,'E'
		JE count_vowel
		cmp al,'I'
		JE count_vowel
		cmp al,'O'
		JE count_vowel
		cmp al,'U'
		JE count_vowel
		inc si
		cmp al,'$'
		je exit
		jmp comp_vowel
	count_vowel:
		inc countv
		inc si
		cmp al,'$'
		je exit
		jmp comp_vowel

exit:
	lea dx,msg1
	mov ah,09
	int 21h
	mov dl,countv
	add dl,48
	mov ah,02
	int 21h
	mov ah,3eh
	mov bx,handler
	int 21h
mov ah,4ch
int 21h
main endp
end