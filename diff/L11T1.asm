;Conditional Directives
.MODEL SMALL
.STACK 100H
.DATA

str1 db "COAL Lab # 11",'$'
str2 db "Conditional Directives",'$'
str3 db "Practice Tasks",'$'

.CODE

mov ax,@data
mov ds,ax

main proc

mov dl,65
mov cl,5

.REPEAT
mov ah,02h
int 21h
inc dl
dec cl
.UNTIL cl==0

mov dl,10
mov ah,02h
int 21h

mov dl,48
mov cl,0

.WHILE cl<5
mov ah,02h
int 21h
inc dl
inc cl
.ENDW

mov dl,10
mov ah,02h
int 21h

mov ah,01h
int 21h
sub al,48

mov cl,al
.IF cl==1
	mov dl,10
	mov ah,02h
	int 21h
	mov dx,offset str1
	mov ah,09h
	int 21h
.ELSEIF cl==2
	mov dl,10
	mov ah,02h
	int 21h
	mov dx,offset str2
	mov ah,09h
	int 21h
.ELSE
	mov dl,10
	mov ah,02h
	int 21h
	mov dx,offset str3
	mov ah,09h
	int 21h
.ENDIF

mov ah,4ch
int 21h

main endp

END
