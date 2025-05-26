.386
.model flat, stdcall
.stack 4096


include Irvine32.inc
;includelib Irvine32.lib
;includelib kernel32.lib
;includelib user32.lib
ExitProcess PROTO, dwExitCode:DWORD

.data
	big byte 12h, 34h, 56h, 78h
	little dword 0

.code
main PROC

	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0
	mov esi, 0

	mov eax, dword ptr big
	mov little, eax
	call WriteHex
	INVOKE ExitProcess, eax
main ENDP

END main