.code16
.global _start
_start:
    MOVW $0x10c,%dx
    MOVB $9,%ah
    INT  $0x21
    MOVB $0x4C,%ah
    INT  $0x21
MSG:
    .ascii "Hello, World!\x0D\x0A$"
