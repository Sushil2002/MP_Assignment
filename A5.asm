%macro fun 3
mov rax, %1
mov rdi, 01
mov rsi, %2
mov rdx, %3
syscall
%endmacro fun

section .data
      msg db "Menu", 10 ,"1.Addition",10, "2.Subtraction",10, "3.Multiplication",10,"4.Division",10 ,"5.Exit" ,10
      len equ $-msg
   
      msg2 db "Enter your choice:->"
      len2 equ $-msg2
   
      msgadd db "Addition of the numbers is:->"
      lenadd equ $-msgadd
   
      msgsub db "Subtraction of numbers is:->"
      lensub equ $-msgsub
   
      msgmul db "Multiplication of the numbers is:->"
      lenmul equ $-msgmul
     
      msgdiv db "Division of the numbers is:->"
      lendiv equ $-msgdiv
     
      num1 db 05h
      num2 db 0Ah
      new db 10
      count db 20h
     
section .bss
      choice resb 01
      result resb 01
      convert resb 02

global _start
section .text
_start:
menu:    
     
      fun 01, msg , len
      fun 01, msg2 , len2
     
      fun 00, choice , 02
      sub byte[choice] ,30h
      mov al, byte[choice]
     
      cmp al , 01
      jz addition
     
      cmp al , 02
      jz subtraction
     
      cmp al , 03
      jz multiplication
     
      cmp al , 04
      jz division
     
      cmp al , 05
      jz exit
     
     
     
      addition:
        call addi
        jmp menu
       
     
      subtraction:
        call subt
        jmp menu
     
      multiplication:
        call mult
        jmp menu
   
      division:
        call divi
        jmp menu
       
     
     
exit:
mov rax, 60
mov rdi, 00
syscall


conversion:
       mov byte[count], 02h
       mov rsi, convert
       mov bl, byte[result]
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
 
   fun 01, convert, 02h
   fun 01, new, 01
 
ret

addi:
   mov cl , byte[num1]
   add cl , byte[num2]
   mov byte[result] , cl
   fun 01, msgadd, lenadd
   call conversion

ret

subt:
   mov cl , byte[num1]
   sub cl , byte[num2]
   mov byte[result] , cl
   fun 01, msgsub, lensub
   call conversion
ret

mult:
   mov al , byte[num1]
   mov cl , byte[num2]
   mul cl
   mov byte[result] , al
   fun 01, msgmul, lenmul
   call conversion
ret

divi:
   mov al , byte[num1]
   div byte[num2]
   
   mov byte[result] , al
   fun 01, msgdiv, lendiv
   call conversion
ret