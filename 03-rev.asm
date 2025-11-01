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
    msg1 db 0ah,0dh,"Enter String : $"
    msg2 db 0ah,0dh,"You Entered : $"
    msg3 db 0ah,0dh,"Length is : $"
    msg4 db 0ah,0dh,"Reversed String : $"
    msg5 db 0ah,0dh,"$"

    stri db 10, 10 dup(?)
    revstri db 10, 10 dup(?)

.code
    mov ax,@data
    mov ds,ax

    printmsg msg1
    lea dx,stri
    mov ah,0ah
    int 21h

    xor cx,cx
    mov cl,[stri+1]
    lea si,stri+2
    add si,cx
    mov byte ptr [si],"$"

    printmsg msg2
    printmsg stri+2

    printmsg msg3
    mov dl,[stri+1]
    add dl,30h
    mov ah,02h
    int 21h

    xor cx,cx
    mov cl,[stri+1]
    mov revstri[1],cl
    lea si,stri+2
    add si,cx
    dec si
    lea di,revstri+2

    loopi:
        cmp cl,0h
        je done
        mov al, byte ptr [si]
        mov byte ptr [di], al    
        dec si
        inc di
        dec cl
        jmp loopi

    done:
        mov byte ptr [di],'$'
        printmsg msg4
        printmsg revstri+2

        printmsg msg5

        mov ah,4ch
        int 21h

end