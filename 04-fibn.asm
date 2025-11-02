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
    msg1 db 0ah,0dh,"Enter limit : $"
    msg2 db 0ah,0dh,"Limit entered is : $"
    msg3 db 0ah,0dh,"The series is : $"
    msg4 db " $"

    num dw 0
    count dw 0

.code
    mov ax,@data
    mov ds,ax

    printmsg msg1
    call read

    mov cx,num
    cmp cx,0
    je exit

    printmsg msg2
    call print

    printmsg msg3
    mov num,0
    call print
    dec cx

    mov dl,30h
    mov ah,02h
    int 21h
    printmsg msg4

    cmp cx,0
    je exit
    mov num,1
    call print
    dec cx

    mov ax,0
    mov bx,1
    
    fib_loop:
        cmp cx,0
        je exit
        printmsg msg4

        add ax,bx
        mov num,ax
        call print
        
        mov dx,ax
        mov ax,bx
        mov bx,dx
        dec cx

        jmp fib_loop

    exit:
        mov ah,4ch
        int 21h

    read proc near
        push ax
        push bx
        push cx
        push dx

        mov num,0
        mov bx,10

        r1:
            mov ah,01h
            int 21h

            cmp al,0dh
            je r2

            sub al,30h
            mov dl,al

            mov ax,num
            mul bl
            add al,dl

            mov num,ax
            jmp r1

        r2:
            pop dx
            pop cx
            pop bx
            pop ax

            ret

    read endp
        
    print proc near
        push ax
        push bx
        push cx
        push dx

        mov ax,num
        mov bx,10

        p1:
            cmp ax,0h
            je p2

            xor dx,dx
            div bx
            push dx
            inc count
            jmp p1

        p2:
            cmp count,0h
            je p3

            pop dx
            add dl,30h
            mov ah,02h
            int 21h

            dec count
            jmp p2

        p3:
            pop dx
            pop cx
            pop bx
            pop ax

            ret


    print endp

end