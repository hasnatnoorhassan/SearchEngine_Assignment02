.model small
.stack 100h
.data
message db 'HASNAT NOOR HASSAN ANSARI! $'
.code

main proc

    ;set graphic mode
    ; mov ax,0Dh ;video mode
    ; int 10h
    mov ax,@data
    mov ds, ax

    MOV AH,6 ;INTERRUPT TO CHANGE BACKGROUND COLOR
    MOV AL,0 ;SINCE WE HAVE 25 ROWS HAVING 0 OR 25 HERE WILL SCROLL WHOLE SCREEN
    MOV BH, 30H  ; BH HAS BACKGROUNG COLOR AND BL HAS FOREGROUND COLOR
    MOV CH,0 
    MOV CL,0
    MOV DH,24
    MOV DL,79
    INT 10H

    ;SET CURSOR POSITION
    MOV AH,02H
    MOV BH,0
    MOV DL, 34
    MOV DH,13
    INT 10H

    ; PRINT
    MOV DX, OFFSET message
    MOV AH,09h
    INT 21H

    MOV AH,4ch
    INT 21H

main endp
end main