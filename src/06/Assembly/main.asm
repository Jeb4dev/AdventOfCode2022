; Non working solution for Advent of Code 2022 day 6.
; All it does is read the input file and print the content of it.

;Compiling and running
;nasm -f elf64 -g -F DWARF main.asm
;ld -e start -o main main.o
;./main

SYS_READ    equ 0
O_RDONLY    equ 0
SYS_OPEN    equ 2
SYS_CLOSE   equ 3
STDOUT      equ 1

section .data
    filename db "input.txt", 0

section .bss
    text resb 4096

section .text
    global _start

_start:
    ; open file
    mov rax, SYS_OPEN
    mov rdi, filename
    mov rsi, O_RDONLY
    mov rdx, 0
    syscall

    ; read file
    push rax
    mov rdi, rax
    mov rax, SYS_READ
    mov rsi, text
    mov rdx, 4096 ; file is 4096 char long
    syscall

    ; close file
    mov rax, SYS_CLOSE
    pop rdi
    syscall

    ; print text
    mov rax, 4
    mov rbx, STDOUT
    mov rcx, text
    int 0x80

    int 1