	section .data

EXIT_SUCCESS equ 0
SYS_exit equ 60
SA48 equ 48

input db "Please input a number: "
input1 db "Please input the second number: "
endLine db 0xA, 0xD

	section .bss

First resw 2
lenFirst resw 1
storeF resw 1

	section .text
	global _start

_start:

	mov rax, 1
	mov rdi, 1
	mov rsi, input
	mov rdx, 23
	syscall

	mov rax, 0
	mov rdi, 0
	mov rsi, First
	mov rdx, rcx
	syscall

	mov rcx, -1
	LoopF:
		inc rcx
		cmp byte [rsi+rcx], 0x00
	jne LoopF

	dec rcx
	mov word[lenFirst], cx
	dec rcx


	LoopFS:
		cmp rcx, 0
		jl EndLoopFS
		mov ax, word[First+rcx]
		sub ax, SA48
		mov word[First+rcx], ax
		dec rcx
		jmp LoopFS 
	EndLoopFS:


	mov word[storeF], 0
	mov r9w, -1
	mov rcx, -1
	LoopFSI:
		inc r9w
		cmp r9w, word[lenFirst]
		jae EndLoopFSI

		inc rcx

		mov ax, 10
		mul word[storeF]

		mov word[storeF], ax
		mov word[storeF+2], dx

		mov ax, word[storeF]
		add ax, word[First+rcx]
		mov word[storeF], ax

		jmp LoopFSI
	EndLoopFSI

	mov ax, word[storeF]
	dec ax
	and ax, word[storeF]

	jnp ReturnOne
		add ax, SA48
		mov word[storeF], ax
	jmp DisplayV
	ReturnOne:
		mov ax, 1
		add ax, SA48
		mov word[storeF], ax
	DisplayV:

	mov rax, 1
	mov rdi, 1
	mov rsi, storeF
	mov rdx, 1
	syscall

	mov rax, 1
    mov rdi, 1
    mov rsi, endLine
    mov rdx, 1
    syscall
	
	mov rax, SYS_exit
	mov rdi, EXIT_SUCCESS
	syscall
	