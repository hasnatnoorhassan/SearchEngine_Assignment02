.model small
.stack 100h
.data
message db 'HASNAT NOOR HASSAN ANSARI! $'
.code

main proc

    ;set graphic mode
    mov ax,0Dh ;video mode
    int 10h
    ; mov ax,@data
    ; mov ds, ax

    mov ah,0ch
    mov al, 0Eh
    mov cx,160
    mov dx,100

    .REPEAT
        INT 10H
        inc cx
    .UNTIL (cx==175)

    .REPEAT
        INT 10H
        inc dx
    .UNTIL (dx==145)

    MOV AH,4ch
    INT 21H

main endp
end main