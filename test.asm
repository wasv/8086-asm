    RESB 0x100
    cpu 8086

section code

extern msg
global ..start
..start:
    MOV dx,msg
    MOV ah,9
    INT 21h
    MOV ah,4Ch
    INT 21h

section data

group prog code data
