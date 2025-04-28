.386
.model flat, stdcall
.stack 4096


include Irvine32.inc
;includelib Irvine32.lib
;includelib kernel32.lib
;includelib user32.lib
ExitProcess PROTO, dwExitCode:DWORD

.data
zodiac byte "Rat", "Ox", "Tiger", "Rabbit", "Dragon", "Snake", "Horse", "Goat", "Monkey", "Rooster", "Dog", "Pig"

.code
main PROC

	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0

	call ReadDec
	sub ax, 4 ; offset
	mov bx, 12
	div bx

	movzx esi, dx
	mov edx, offset zodiac
	
	call DumpRegs
	call WriteString

	INVOKE ExitProcess, eax
main ENDP

END main