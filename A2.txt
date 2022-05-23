%macro fun 3
mov rax, %1
mov rdi, 01
mov rsi, %2
mov rdx, %3
syscall
%endmacro fun

section .data
        msg1 db "Enter the string :"
        len1 equ $-msg1
        msg2 db "The length of string is:"
        len2 equ $-msg2
        new db 10
        count db 20h
section .bss
         slen resb 01
         sarray resb 20
         convert resb 02
global _start
section .text
_start:
    fun 01, msg1 ,len1
    fun 00,sarray, 20h
    mov rsi, sarray
   
 again:
    mov al,[rsi]
    cmp al, 0Ah
    jnz next
    jmp exit
   
next:
      inc byte[slen]
      inc rsi
      dec byte[count]
      jnz again
exit:
     mov byte[count], 02h
     mov rsi, convert
     mov bl, byte[slen]
up:
   rol bl, 04
   mov dl, bl
   and dl, 0Fh
   cmp dl, 09h
   jbe ath
   add dl, 07h
ath:
   add dl, 30h
   mov[rsi], dl
   inc rsi
   dec byte[count]
   jnz up
   fun 01, msg2, len2
   fun 01, convert, 02h
   fun 01, new, 01
 

 
mov rax, 60
mov rdi, 00
syscall
