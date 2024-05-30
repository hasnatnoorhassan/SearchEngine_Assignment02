.model small
.stack 100h

.data
message db 'here $'
matrix db 9 dup (?)


;input proc variables
input_message db 'Enter value: $'


;output proc variables
output_message db 'Matrix= $'

;row_max variable
row_max_message db 'Row max= $'

;diagonal_sum variable
diagonal_message db 'd sum= $'

;row_sum variables
row_sum_message db 'row sum= $'

;transpose 
t_matrix db 9 dup (0)
t_count dw 0

;get value
value_message db 'value= $'

.code

main PROC
    mov ax,@data
    mov ds,ax

    call input_matrix

    lea si,matrix
    call output_matrix

    call calculate_row_max

    call sum_left_diagonal

    call calculate_row_sum

    call transpose_matrix
    lea si, t_matrix
    call output_matrix

    call sort_p
    lea si,matrix
    call output_matrix

    call get_value


    exit:
        mov ah,4ch
        int 21h


    
main ENDP


;input matrix
input_matrix PROC

    mov cx, 3
    lea si,matrix

    loop2:
        push cx
        mov cx,3
        loop1:
            lea dx,input_message
            mov ah,09
            int 21h

            mov ah,01
            int 21h

            sub al,'0'

            mov [si],al

            mov dl, 10             
            mov ah, 02h             
            int 21h  
            mov dl, 13             
            mov ah, 02h             
            int 21h 

            inc si
        loop loop1

        pop cx

    loop loop2

    ret    
input_matrix ENDP



;output matrix
output_matrix PROC

        mov dl, 10             
        mov ah, 02h             
        int 21h  
        mov dl, 13             
        mov ah, 02h             
        int 21h  

    mov cx,3
    
    lea dx,output_message
    mov ah,09
    int 21h


    loop_2:
        mov dl, 10             
        mov ah, 02h             
        int 21h  
        mov dl, 13             
        mov ah, 02h             
        int 21h  
        push cx
        mov cx,3
        loop_1:
            mov dl,[si]
            add dl,'0'
            mov ah,02
            int 21h

            mov dl,20h
            mov ah,02
            int 21h
            inc si
        loop loop_1
        pop cx

    loop loop_2

    ret   
output_matrix ENDP


; calculate row max
calculate_row_max PROC
    lea si, matrix 
    ; row you need 
    mov ax, 2   


    mov cx, 3              
    mov bx, 0               
    dec ax                  
    mul cx                  
    add si,ax

max_loop:
    cmp bx, [si]   
    jle max_here
    jmp next_element


    max_here:
        mov bx,[si]
        mov bh,0
        jmp next_element

    next_element:
    inc si                  
    loop max_loop           

    mov dl, 10             
    mov ah, 02h             
    int 21h  
    mov dl, 13             
    mov ah, 02h             
    int 21h  

    lea dx,row_max_message
    mov ah,9
    int 21h

    mov dx, bx              
    add dx, '0'             
    mov ah, 02h             
    int 21h                

    ret                     
calculate_row_max ENDP


;calculate d sum
sum_left_diagonal PROC
    lea si, matrix     
    xor ax, ax         

    mov cx, 3     
    mov dx,0    

sum_diagonal_loop:
    mov dl, [si]       
    add ax, dx         

    add si, 4     
    loop sum_diagonal_loop

    push ax
    mov dl, 10             
    mov ah, 02h             
    int 21h  
    mov dl, 13             
    mov ah, 02h             
    int 21h  

    lea dx,diagonal_message
    mov ah,9
    int 21h

    pop ax
    mov dx, ax

    add dx, '0'             
    mov ah, 02h             
    int 21h  

    ret
sum_left_diagonal ENDP


calculate_row_sum PROC

    ; calculate row sum
    lea si, matrix 
    ; row you need 
    mov ax, 2    

    mov cx, 3              
    mov bx, 0               
    dec ax                  
    mul cx                  
    add si,ax

row_loop:
    add bx, [si]       
    inc si                  
    loop row_loop           

    mov dl, 10             
    mov ah, 02h             
    int 21h  
    mov dl, 13             
    mov ah, 02h             
    int 21h  
    lea dx,row_sum_message
    mov ah,09
    int 21h
    mov dx, bx              
    add dx, '0'             
    mov ah, 02h             
    int 21h                

    ret                     
calculate_row_sum ENDP

;transpose
transpose_matrix PROC
    lea si, matrix            

    mov cx, 3            

transpose_loop:
    push cx
    mov cx,3

    lea di, t_matrix 
    add di,t_count
    

    transpose_inner:
        mov al, [si]         
        mov [di], al         

        add si, 1            
        add di, 3     
    loop transpose_inner     
    pop cx
    inc t_count
    loop transpose_loop

    ret
transpose_matrix ENDP

sort_p proc
    mov cx,8
    lea si, matrix

    sort1:
        push cx
        mov cx,8
        lea si,matrix
    sort:
        mov bl,[si]
        mov bh,[si+1]
        cmp bl,bh
        ja swap
        inc si
        loop sort
        pop cx
        loop sort1
        jmp forw
        swap:
            mov al,[si]
            mov ah, [si+1]
            mov [si],ah
            mov [si+1],al
            inc si
            loop sort
            pop cx
        loop sort1
    forw:
    ret
sort_p endp

get_value proc
    lea si,matrix
    mov al, 2 ;row number
    mov bl, 1 ;col number
    mov cl,3

    mul cl
    add al, bl
    mov ah,0

    add si, ax

    mov dl, 10             
    mov ah, 02h             
    int 21h  
    mov dl, 13             
    mov ah, 02h             
    int 21h  
    
    lea dx,value_message
    mov ah,09
    int 21h



    mov dl, [si]
    add dl,'0'
    mov ah,2
    int 21h

    ret

get_value endp


end main

