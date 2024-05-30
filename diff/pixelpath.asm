.model small
.stack 100h

.data
    x dw 160     ; Initial X position (center of the screen)
    y dw 100     ; Initial Y position (center of the screen)
    counter db 0ch

.code
main:
    mov ax, @data
    mov ds, ax

    ; Set graphics mode 13h (320x200, 256 colors)
    mov ax, 13h
    int 10h

    ; Draw initial pixel at (160, 100)
    call DrawPixel

WaitForKey:
    ; Wait for a key press
    mov ah, 00h
    int 16h

    ; Check which key is pressed
    cmp ah, 48h   ; Up arrow key
    je MoveUp
    cmp ah, 50h   ; Down arrow key
    je MoveDown
    cmp ah, 4Bh   ; Left arrow key
    je MoveLeft
    cmp ah, 4Dh   ; Right arrow key
    je MoveRight
    jmp WaitForKey

MoveUp:
    ; Erase current pixel
    ;call ErasePixel
    dec word ptr [y]
    call DrawPixel
    jmp WaitForKey

MoveDown:
    ; Erase current pixel
    ;call ErasePixel
    inc word ptr [y]
    call DrawPixel
    jmp WaitForKey

MoveLeft:
    ; Erase current pixel
   ; call ErasePixel
    dec word ptr [x]
    call DrawPixel
    jmp WaitForKey

MoveRight:
    ; Erase current pixel
   ; call ErasePixel
    inc word ptr [x]
    call DrawPixel
    jmp WaitForKey

DrawPixel:
    ; Draw pixel at (x, y)
    ; Input: [x], [y]
    mov ax, 0A000h
    mov es, ax
    mov di, [y]
    mov ax, 320
    mul di
    add ax, [x]
    mov di, ax
    mov al, counter  ; Color (12h)
    inc counter
    stosb
    ret

ErasePixel:
    ; Erase pixel at (x, y)
    ; Input: [x], [y]
    mov ax, 0A000h
    mov es, ax
    mov di, [y]
    mov ax, 320
    mul di
    add ax, [x]
    mov di, ax
    mov al, 00h  ; Color (black)
    stosb
    ret

end main
