; Program for Showing How to Switch to Another Page in Video Mode
.model small ; Define memory model as small
.stack 100h  ; Define stack size as 100h (256 bytes)
.data        ; Start of data segment
msg1 db " Welcome to Fakhar STEM Shere ! $"  ; Define a string variable
msg2 db " This is the 1st Page of the Video Mode! Press Enter to Continue - $"
msg3 db " Please Read the following Rules - $"
msg4 db " i)  Do Hard Work Always - $"
msg5 db " ii) Never Plgiarize - $"
.code          ; Start of code segment

start:         ; Start of program

    mov ax, @data  ; Move the address of the data segment into the AX register
    mov ds, ax     ; Move the address of the data segment into the DS register

    ; Set Video Mode for Scroll Up Window (25 x 80) To move up # of lines from Bottom
    mov ah, 6   ; Scroll Up Window -> Function to change Background Color
    mov al, 0  ; Lines to Scroll -> AL = 0 or 25 will Scroll whole screen
    mov bh, 6Eh ; Left Char for Background (4 ) & Right Char for Foreground (E) 
	mov ch, 0  ; CH Upper Row # minimum can be 0
	mov cl, 0  ; CL Left column # minimum can be 0
    mov dh, 24  ; Lower row # maximum can be 24
    mov dl, 79  ; Right column # maximum can be 79
    int 10h     ; Call interrupt 10h (BIOS video services)
    ; Set Cursor Position
    mov ah, 02h ; function to set cursor position
    mov bh, 0   ; Set 1st page number , Welcome Page of Game for example	
    mov dl, 8  ; Set DL for cursor column position
    mov dh, 6  ; Set DH for Cursor row position
    int 10h     ; Call interrupt 10h (BIOS video services)
    ; Print String
    mov dx, offset msg1  ; Load the offset address of the string 'msg' into the DX register
    mov ah, 09h         ; Set AH register to 09h (function to print a string)
    int 21h             ; Call interrupt 21h (DOS services)
	
	; Set Video Mode for Scroll Up Window II To move up # of lines from Bottom
    mov ah, 6   ; Scroll Up Window -> Function to change Background Color
    mov al, 0  ; Lines to Scroll -> AL = 0 or 25 will Scroll whole screen
    mov bh, 31h ; Left Char for Background (4 ) & Right Char for Foreground (E) 
	mov ch, 12  ; CH Upper Row # minimum can be 0
	mov cl, 0  ; CL Left column # minimum can be 0
    mov dh, 24  ; Lower row # maximum can be 24
    mov dl, 79  ; Right column # maximum can be 79
    int 10h     ; Call interrupt 10h (BIOS video services)
	
	; Set Cursor Position 2
    mov ah, 02h ; function to set cursor position
    mov bh, 0   ; Set 1st page number , Welcome Page of Game for example	
    mov dl, 8  ; Set DL for cursor column position
    mov dh, 15  ; Set DH for Cursor row position
    int 10h     ; Call interrupt 10h (BIOS video services)
    ; Print String
    mov dx, offset msg2  ; Load the offset address of the string 'msg' into the DX register
    mov ah, 09h         ; Set AH register to 09h (function to print a string)
    int 21h             ; Call interrupt 21h (DOS services)
	
	; Set Cursor Position out of Window
    mov ah, 02h ; function to set cursor position
    mov bh, 0   ; Set 1st page number , Welcome Page of Game for example	
    mov dl, 0  ; Set DL for cursor column position
    mov dh, 24  ; Set DH for Cursor row position
    int 10h     ; Call interrupt 10h (BIOS video services)
	
	; Switching to Page # 02 if We Press Enter Key from Keyboard 
	;Take Input For Enter
	page2:
	
	MOV AH, 08h ;input a character from Keyboard without displaying on the screen
	INT 21h
	
	CMP AL, 13
	JNE page2
	
;////////////////////////////////////////// Page 2 //////////////////////////////////////////
	
	;Select Page
		MOV AH, 05H
		MOV AL, 02H  ; This shows it is page # 02
		INT 10H
	; Set Video Mode for Scroll Up Window (25 x 80) To move up # of lines from Bottom
    mov ah, 6   ; Scroll Up Window -> Function to change Background Color
    mov al, 0  ; Lines to Scroll -> AL = 0 or 25 will Scroll whole screen
    mov bh, 71h ; Left Char for Background (4 ) & Right Char for Foreground (E) 
	mov ch, 0  ; CH Upper Row # minimum can be 0
	mov cl, 0  ; CL Left column # minimum can be 0
    mov dh, 24  ; Lower row # maximum can be 24
    mov dl, 79  ; Right column # maximum can be 79
    int 10h     ; Call interrupt 10h (BIOS video services)
	
	
	; Set Cursor Position On Page # 02
	mov ah, 02h ; function to set cursor position
    mov bh, 2   ; Set 2nd page number , Page # 02 For Game Rules	
    mov dl, 8  ; Set DL for cursor column position
    mov dh, 8  ; Set DH for Cursor row position
    int 10h     ; Call interrupt 10h (BIOS video services)
	
	mov dx, offset msg3  ; Load the offset address of the string 'msg' into the DX register
    mov ah, 09h         ; Set AH register to 09h (function to print a string)
    int 21h             ; Call interrupt 21h (DOS services)
	; Set Cursor For Rule # 1
	mov ah, 02h ; function to set cursor position
    mov bh, 2   ; Set 2nd page number , Page # 02 For Game Rules	
    mov dl, 8  ; Set DL for cursor column position
    mov dh, 10  ; Set DH for Cursor row position
    int 10h     ; Call interrupt 10h (BIOS video services)
	
	mov dx, offset msg4  ; Load the offset address of the string 'msg' into the DX register
    mov ah, 09h         ; Set AH register to 09h (function to print a string)
    int 21h             ; Call interrupt 21h (DOS services)
    
	; Set Cursor For Rule # 2
	mov ah, 02h ; function to set cursor position
    mov bh, 2   ; Set 2nd page number , Page # 02 For Game Rules	
    mov dl, 8  ; Set DL for cursor column position
    mov dh, 12  ; Set DH for Cursor row position
    int 10h     ; Call interrupt 10h (BIOS video services)
	
	mov dx, offset msg5  ; Load the offset address of the string 'msg' into the DX register
    mov ah, 09h         ; Set AH register to 09h (function to print a string)
    int 21h             ; Call interrupt 21h (DOS services)
; Set Cursor Position out of Window
    mov ah, 02h ; function to set cursor position
    mov bh, 2   ; Set 1st page number , Welcome Page of Game for example	
    mov dl, 0  ; Set DL for cursor column position
    mov dh, 24  ; Set DH for Cursor row position
    int 10h     ; Call interrupt 10h (BIOS video services)
	
	;To Clear the Screen Means If Your Want to Switch to Text Mode Press Enter Key
	;  Switching Video Mode to Text Mode
	
	ClearScreen:
	
	MOV AH, 08h ; input a character from Keyboard withouot displaying on the screen
	INT 21h
	
	CMP AL, 13
	JNE ClearScreen
	; Shifting Video Mode to Text Mode Means it Clears the Screen
	mov al , 03 ; function code for setting the text mode.
	mov ah,0    ; Video Mode
	int 10h		; Switching from Video Mode to Text Mode
	
	; Terminate Program
	Exit:
    mov ah, 4ch         ; Set AH register to 4Ch (function to terminate the program)
    int 21h             ; Call interrupt 21h (DOS services)

end start           ; End of program