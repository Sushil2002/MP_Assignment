%macro rw 3
mov rax, %1
mov rdi, 01
mov rsi, %2
mov rdx, %3
syscall
%endmacro

section .bss
carray resb 16
count resb 1
count1 resb 1
dest resb 40

section .data
array dq 1254ABC78963452Ch, 9654ABC78963452Ch, 7564ABC78963452Ch, 8434ABC78963452Ch, 6474ABC78963452Ch

strs db "SOURCE"
lens equ $-strs

strd db "DESTINATION"
lend equ $-strd

adstr db "ADDRESS: "
adlen equ $-adstr

valstr db "VALUE: "
vallen equ $-valstr

newline db 10

global _start
section .text
_start:
; Printing contents of Source array
mov byte[count1], 05h
rw 01, strs, lens
rw 01, newline, 1
mov rsi, array
again:
; Address printing
mov rbx, rsi

push rsi
rw 01, adstr, adlen
call hextoASCII
; Value at that address
rw 01, valstr, vallen
pop rsi
mov rbx, [rsi]
check:
push rsi
call hextoASCII

pop rsi
add rsi, 08h
dec byte[count1]
jnz again

mov rsi, array
mov rdi, dest
xor rcx, rcx
mov cl, 05h
cld
rep movsq

; Printing contents of Destination array
mov byte[count1], 05h
rw 01, strd, lend
rw 01, newline, 1
mov rsi, dest
again1:
; Address printing
mov rbx, rsi

push rsi
rw 01, adstr, adlen
call hextoASCII
; Value at that address
rw 01, valstr, vallen
pop rsi
mov rbx, [rsi]
check1:
push rsi
call hextoASCII

pop rsi
add rsi, 08h
dec byte[count1]
jnz again1

mov rax, 60
mov rdi, 00
syscall

hextoASCII:
mov rsi, carray
mov byte[count], 10h ;16 = 16 * 1 + 0
;mov dx, word[result]
up1:
rol rbx, 04h
mov rdx, rbx
and rdx, 000000000000000Fh
cmp dl, 09
jbe down1

add dl, 07h
down1:
add dl, 30h
mov [rsi], dl
inc rsi
dec byte[count]
jnz up1
check2:
rw 01, carray, 16
rw 01, newline, 1
ret