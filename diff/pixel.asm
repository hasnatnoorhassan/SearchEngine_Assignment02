.model small
.stack 100h

.data
    posX dw 40         ; Initial X position
    posY dw 12         ; Initial Y position

.code
    mov ax, @data      ; Initialize DS register
    mov ds, ax

    mov ah, 0          ; Clear the screen
    mov al, 3
    int 10h

    mov ah, 2          ; Set cursor position
    mov bh, 0          ; Page number
    mov dh, byte ptr [posY]     ; Y position
    mov dl, byte ptr [posX]     ; X position
    int 10h

    mov ah, 0          ; Wait for key press
    int 16h

movePixel:
    mov ah, 0          ; Read keyboard input
    int 16h
    cmp ah, 0
    jne processKey

    jmp movePixel

processKey:
    cmp ah, 4Bh        ; Left arrow
    je moveLeft
    cmp ah, 4Dh        ; Right arrow
    je moveRight
    cmp ah, 48h        ; Up arrow
    je moveUp
    cmp ah, 50h        ; Down arrow
    je moveDown
    jmp movePixel

moveLeft:
    mov ax, [posX]
    cmp ax, 0          ; Check if already at left boundary
    je movePixel
    dec ax             ; Decrement X position
    mov [posX], ax
    call updateCursor
    jmp movePixel

moveRight:
    mov ax, [posX]
    cmp ax, 79         ; Check if already at right boundary
    je movePixel
    inc ax             ; Increment X position
    mov [posX], ax
    call updateCursor
    jmp movePixel

moveUp:
    mov ax, [posY]
    cmp ax, 0          ; Check if already at top boundary
    je movePixel
    dec ax             ; Decrement Y position
    mov [posY], ax
    call updateCursor
    jmp movePixel

moveDown:
    mov ax, [posY]
    cmp ax, 24         ; Check if already at bottom boundary
    je movePixel
    inc ax             ; Increment Y position
    mov [posY], ax
    call updateCursor
    jmp movePixel

updateCursor:
    mov ah, 2          ; Set cursor position
    mov bh, 0          ; Page number
    mov dh, byte ptr[posY]     ; Y position
    mov dl, byte ptr [posX]     ; X position
    int 10h
    ret

end
