section code

section data
global msg
msg:
    db 'Hello, World!',0Dh,0Ah,'$'
msglen equ $-msg

group prog code data
