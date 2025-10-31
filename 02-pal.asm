.model small

printmsg macro msg
    push ax
    push dx

    lea dx,msg
    mov ah,09h
    int 21h

    pop dx
    pop ax
endm

.data
    msg1 db 0ah,0dh,"Enter string : $"
    msg2 db 0ah,0dh,"You entered : $"
    msg3 db 0ah,0dh,"It is a palindrome$"
    msg4 db 0ah,0dh,"It is not a palindrome$"
    msg5 db 0ah,0dh,"Length is : $"
    msg6 db 0ah,0dh,"$"

    buffer db 10, 10 dup(?)
    len db 0h

.code
    mov ax,@data
    mov ds,ax

    printmsg msg1

    lea dx,buffer
    mov ah,0ah
    int 21h
    
    mov bl,[buffer+1]
    lea si,buffer+2
    add si,bx
    mov byte ptr [si], "$"

    printmsg msg2
    printmsg buffer[02]

    mov al,buffer[1]
    mov len,al

    add al,30h
    mov dl,al

    printmsg msg5
    mov ah,02h
    int 21h

    xor cx,cx
    mov cl,len
    mov si,offset buffer+2
    mov di,si
    add di,cx
    dec di

    cmp_loop:
        cmp si,di
        jae palindrome
        
        mov dh,[si]
        mov dl,[di]
        cmp dh,dl
        jnz not_palindrome

        inc si
        dec di
        jmp cmp_loop

    palindrome:
        printmsg msg3
        jmp done

    not_palindrome:
        printmsg msg4

    done:
        mov ah,4ch
        int 21h

end
