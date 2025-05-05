.386
.model flat, stdcall
.stack 4096


include Irvine32.inc
;includelib Irvine32.lib
;includelib kernel32.lib
;includelib user32.lib
ExitProcess PROTO, dwExitCode:DWORD

.data
ary0317_u1224051 word 10 dup(?)
len dword ($ - ary0317_u1224051) / 2
ary byte "The ary0317: ", 0
sum byte "Sum: ", 0

.code
new0317_u1224051 PROC

	push esi
	push ecx
	mov eax, 0
L1:
	add ax, ary0317_u1224051[esi]
	add esi, type ary0317_u1224051
	loop L1

	pop ecx
	pop esi
	ret
new0317_u1224051 ENDP

main PROC
	;init
	mov eax, 0
	mov ecx, len
	push ecx
	mov esi, offset ary0317_u1224051

Save:
	mov eax, 299
	call RandomRange
	add eax, 1
	mov [esi], ax
	add esi, type ary0317_u1224051
	loop Save

	mov eax, 0
	pop ecx
	push ecx
	mov esi, type ary0317_u1224051
	mov edx, offset ary
	call WriteString
	call Crlf

Load:
	mov ax, ary0317_u1224051[esi]
	call WriteInt
	call Crlf
	add esi, type ary0317_u1224051
	loop Load

	pop ecx
	mov esi, type ary0317_u1224051
	mov edx, offset sum
	call WriteString
	call new0317_u1224051
	call WriteInt
	call Crlf

	INVOKE ExitProcess, eax
main ENDP

END main