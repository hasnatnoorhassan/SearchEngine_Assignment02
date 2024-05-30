;File Handling
.MODEL SMALL
.STACK 100H
.DATA

file db "MyFile.txt",0
buffer db 100 DUP("$")
Msg1 db "File Handling",'$'
FileHandle dw ?

.CODE

mov ax,@data
mov ds,ax

main proc

mov dx,offset file
mov al,0
mov ah,3dh
int 21h

mov bx,ax
mov dx,offset buffer
mov ah,3fh
int 21h

mov dx,offset buffer
mov ah,09h
int 21h

mov dx,offset file
mov al,2
mov ah,3dh
mov FileHandle,ax
int 21h

mov bx,FileHandle
mov cx,0
mov dx,0
mov ah,42h
mov al,2
int 21h

mov cx,lengthof msg1
dec cx
mov bx,FileHandle
mov dx,offset msg1
mov ah,40h
int 21h

mov ah,4ch
int 21h

main endp

END
