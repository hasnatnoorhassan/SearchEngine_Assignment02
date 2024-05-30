.model small
.stack 100h
.data
filename db 'filefile.txt',0
filehandle dw ?
message db 'Enter message $'
buffer db 100 dup ('$')
buffer2 db 100h dup ('$')
cleanbuffer db 100h dup ('$')
cleanedBytes dw 0

.code

main PROC
    mov ax,@data
    mov ds,ax

    ;call createfile

    ;call writefile

    call read

    ; call clearfile

    ; call appendfile

    call cleanbuffer_p
    call clearfile
    call writebuffer





    exit:
        mov ah,4ch
        int 21h
    
main ENDP

;create file
createfile PROC

    ; Create the file
    MOV AH, 3Ch                ; DOS function: Create file
    MOV CX, 0                  ; File attribute: normal
    LEA DX, filename           ; DS:DX points to the filename
    INT 21h                    ; Call DOS interrupt

    MOV filehandle, AX         ; Save the file handle

    ; Close the file
    MOV AH, 3Eh                ; DOS function: Close file
    MOV BX, filehandle         ; File handle
    INT 21h   

    ret
    
createfile ENDP

;write
writefile PROC
        ;open an existing file
        mov ah,3dh
        lea dx,filename
        mov al,2
        int 21h

        mov filehandle,AX

        ; Write data
        lea dx,message
        mov ah,09h
        int 21h

        mov si,0
        mov cx,0
    again:
        mov ah,01h
        int 21h
        cmp al,13
        je write
        mov buffer[si],al
        inc si
        inc cx
        jmp again

    write:
        mov ah,40h
        mov bx,filehandle
        lea dx,buffer
        int 21h


        ; Close the file
        MOV AH, 3Eh                ; DOS function: Close file
        MOV BX, filehandle         ; File handle
        INT 21h                    ; Call DOS interrupt

        ret
    
writefile ENDP

;write
writebuffer PROC
        ;open an existing file
        mov ah,3dh
        lea dx,filename
        mov al,2
        int 21h

        mov filehandle,AX

        mov ah,40h
        mov bx,filehandle
        lea dx,cleanbuffer
        int 21h


        ; Close the file
        MOV AH, 3Eh                ; DOS function: Close file
        MOV BX, filehandle         ; File handle
        INT 21h                    ; Call DOS interrupt

        ret
    
writebuffer ENDP

;description
read PROC
        ;open an existing file
        mov ah,3dh
        lea dx,filename
        mov al,2
        int 21h

        mov filehandle,AX

        ; ; read
        ; mov ah,3fh
        ; lea dx,buffer2
        ; mov cx, 100h
        ; mov bx,filehandle
        ; int 21h

        ; lea dx,buffer2
        ; mov ah,09h
        ; int 21h


        ; ; Close the file
        ; MOV AH, 3Eh                ; DOS function: Close file
        ; MOV BX, filehandle         ; File handle
        ; INT 21h                    ; Call DOS interrupt

    read_loop:
        ; Read data from file
        mov ah, 3Fh
        lea dx, buffer
        mov cx, 100h              
        mov bx, filehandle
        int 21h

        ; AX now contains the number of bytes actually read
        cmp ax, 0                  ; Check if no more bytes were read (EOF)
        je close_file              ; If AX is 0, jump to close the file

        ; Display the buffer
        ; Null-terminate the buffer to use DOS function 09h for display
        mov si, ax                 ; AX contains number of bytes read
        mov byte ptr buffer[si], '$' ; Null-terminate the buffer
        lea dx, buffer
        mov ah, 09h
        int 21h

        jmp read_loop              ; Read the next chunk

    close_file:
        ; Close the file
        mov ah, 3Eh                ; DOS function: Close file
        mov bx, filehandle         ; File handle
        int 21h

        ret
    
read ENDP


; Clear file
clearfile PROC
    ; Create or truncate the file
    mov ah, 3Ch                ; DOS function: Create or truncate file
    mov cx, 0                  ; File attribute: normal
    lea dx, filename           ; DS:DX points to the filename
    int 21h                    ; Call DOS interrupt

    mov filehandle, ax         ; Save the file handle

    ; Close the file
    mov ah, 3Eh                ; DOS function: Close file
    mov bx, filehandle         ; File handle
    int 21h

    ret

clearfile ENDP


; Append data to the file
appendfile PROC
    ; Open the file in read/write mode
    mov ah, 3Dh
    lea dx, filename
    mov al, 2                  ; Open file in read/write mode
    int 21h

    mov filehandle, ax         ; Save the file handle

    ; Move file pointer to the end
    mov ah, 42h                ; DOS function: Move file pointer
    mov al, 2                  ; Move to end of file
    xor cx, cx                 ; High word of offset (0)
    xor dx, dx                 ; Low word of offset (0)
    mov bx, filehandle         ; File handle
    int 21h

      ; Write data
        lea dx,message
        mov ah,09h
        int 21h

        mov si,0
        mov cx,0
    again2:
        mov ah,01h
        int 21h
        cmp al,13
        je write2
        mov buffer[si],al
        inc si
        inc cx
        jmp again2

    write2:
        mov ah,40h
        mov bx,filehandle
        lea dx,buffer
        int 21h


        ; Close the file
        MOV AH, 3Eh                ; DOS function: Close file
        MOV BX, filehandle         ; File handle
        INT 21h                    ; Call DOS interrupt

    ret
appendfile endp

cleanbuffer_p proc
    mov si, 0
    mov di, 0
    mov cleanedBytes, 0        ; Initialize cleaned bytes count

clean_loop:
    cmp buffer[si], '$'        ; Check for end of buffer
    je end_clean

    mov al, buffer[si]         ; Load byte from buffer
    ; Check if the character is alphanumeric (A-Z, a-z, 0-9)
    cmp al, 'A'
    jl not_valid
    cmp al, 'Z'
    jle valid_char
    cmp al, 'a'
    jl not_valid
    cmp al, 'z'
    jle valid_char
    cmp al, '0'
    jl not_valid
    cmp al, '9'
    jle valid_char

not_valid:
    inc si
    jmp clean_loop

valid_char:
    mov cleanBuffer[di], al    ; Store valid character in clean buffer
    inc di
    inc si
    inc cleanedBytes           ; Increment cleaned bytes count
    jmp clean_loop

end_clean:
    ret

cleanbuffer_p endp


end main