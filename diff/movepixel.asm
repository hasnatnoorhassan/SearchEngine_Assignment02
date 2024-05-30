.model small
.stack 100h
.data
.code

main proc

    ;set graphic mode
    mov ah,00h ;video mode
    mov al,13h
    int 10h
    ; mov ax,@data
    ; mov ds, ax

    mov ah,0ch
    mov al, 0Eh
    mov cx,0
    mov dx,50

    .REPEAT
        INT 10H
        dec cx
        mov al,00h
        int 21h
        inc cx
        mov al,0Eh
        call delay
        inc cx

    .UNTIL (cx==319)

    mov ah,0
    int 16h

    mov ax,3
    int 10h

    mov ah,4ch
    int 21h


main endp

delay proc

push ax
push bx
push cx
push dx

mov cx,1000
d1:
mov bx,10
d2:
dec bx
jnz d2
loop d1

pop dx
pop cx
pop bx
pop ax

ret 
delap endp


end main