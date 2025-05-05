.386
.model flat, stdcall
.stack 4096


include Irvine32.inc
;includelib Irvine32.lib
;includelib kernel32.lib
;includelib user32.lib
ExitProcess PROTO, dwExitCode:DWORD

.data
error byte "The number not in range 8 - 19", 0
arr byte 19 dup(?)

.code
MySub1 proc
	
	cmp eax, 8
	jb E1
	cmp eax, 19
	ja E1
	call MySub2
	jmp next

E1:
	mov edx, offset error
	call WriteString
	call Crlf

next:
	ret

MySub1 endp

MySub2 proc
	
	mov ecx, eax
	mov esi, offset arr
L1:
	mov eax, 50
	call RandomRange
	inc eax
	mov byte ptr [esi], al
	inc esi
	loop L1

	mov esi, offset arr
	mov ecx, lengthof arr
	mov ebx, type arr
	call DumpMem
	ret

MySub2 endp

main PROC

	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0
	mov esi, 0
	
	call ReadDec
	call MySub1

	INVOKE ExitProcess, eax
main ENDP

END main