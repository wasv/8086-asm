    bits 16

section .code

global start
_start:
    MOV dx,MSG
    MOV ah,9
    INT 21h
    MOV ah,4Ch
    INT 21h

section .data

MSG:
    db 'Hello, World!',0Dh,0Ah,'$'
