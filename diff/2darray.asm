.model small
.stack 100h 

.data
rowsize db 3
colsize db 4
arr db 1, 2, 3, 4
    db 5, 6, 7, 8
    db 9, 1, 0, 2

message1 db 'Enter row index: $'
message2 db 'Enter column index: $'
row db ?
col db ?

.code
main proc
mov ax, @data
mov ds, ax

mov si, offset arr
mov cx, 3
l1:
    push cx
    mov cx, 4
    l2:
        mov dl, [si]
        add dl, '0'
        mov ah, 02h
        int 21h
        inc si
    loop l2
    mov dl, 10 
    mov ah, 02h
    int 21h 
    mov dl, 13 
    mov ah, 02h
    int 21h
    pop cx
loop l1

lea dx, message1
mov ah, 09h
int 21h

mov ah, 01h
int 21h
sub al, 48
cmp al, rowsize
jae ext
mov row, al
mov ah, 02h
mov dx,0
mov dl, 10
int 21h
mov dl, 13
int 21h

lea dx, message2
mov ah, 09h
int 21h

mov ah, 01h
int 21h
sub al, 48
cmp al, colsize
jae ext
mov col, al

mov al, row
mul colsize
add al, col
mov si, offset arr
mov ah,0
add si, ax
mov dl, [si]
add dl,'0'
mov ah, 02h
int 21h



ext:
    mov ah, 4Ch      
    int 21h         

main endp
end main