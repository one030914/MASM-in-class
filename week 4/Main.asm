.386
.model flat, stdcall
.stack 4096


include Irvine32.inc
;includelib Irvine32.lib
;includelib kernel32.lib
;includelib user32.lib
ExitProcess PROTO, dwExitCode:DWORD

.data
nums byte 5 dup(?)

.code
main PROC

	mov ecx, lengthof nums
	mov edi, type nums
	mov eax, 0
	mov edi, 0

L1: ;save array
	mov eax, 50
	call RandomRange
	mov nums[edi], al
	add edi, type nums
	loop L1

	mov ecx, lengthof nums
	mov edi, type nums
	mov eax, 0
	mov edi, 0

L2: ;load array
	mov al, nums[edi]
	add edi, type nums
	call WriteInt
	call Crlf
	loop L2

	INVOKE ExitProcess, eax
main ENDP

END main        ;specify the program's entry point