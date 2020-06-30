BITS 16
ORG 100h

MOV dx,MSG
MOV ah,9
INT 21h
MOV ah,4Ch
INT 21h

MSG db 'Hello, World!',0Dh,0Ah,'$'
