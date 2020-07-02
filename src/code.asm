    cpu 8086

%include "inc/dos.inc"

    RESB 0x100
section code

extern msg

global ..start
..start:
    MOV dx,msg
    MOV ah,FC_PUTS
    INT 21h
    MOV ah,4Ch
    INT 21h

section data

group prog code data
