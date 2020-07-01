    RESB 0x100
    cpu 8086

section code

extern msg
global ..start
..start:
    MOV dx,MSG
    MOV ah,9
    INT 21h
    MOV ah,4Ch
    INT 21h

section data

MSG:
    db 'Hello, World!',0Dh,0Ah,'$'
group prog code data
