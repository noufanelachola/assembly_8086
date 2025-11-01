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


.code
    mov ax,@data
    mov ds,ax

     

end