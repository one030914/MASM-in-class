.386
.model flat, stdcall
.stack 4096


include Irvine32.inc
;includelib Irvine32.lib
;includelib kernel32.lib
;includelib user32.lib
ExitProcess PROTO, dwExitCode:DWORD

.data
n sword ?
ary0317_u1224051 word 6 dup(?)
len word ($ - ary0317_u1224051) / 2

.code
Init proc

	mov eax, 0
	movzx ecx, len
	mov esi, offset ary0317_u1224051
	ret

Init endp

main proc

	call Init

Random:
	mov eax, 99
	call RandomRange
	add eax, 1
	mov [esi], ax
	add esi, type ary0317_u1224051
	loop Random

	call Crlf
	call Init

Print:
	mov ax, [esi]
	call WriteInt
	call Crlf
	add esi, type ary0317_u1224051
	loop Print

	call Crlf
	call Init
	dec ecx

L1:
	mov ax, word ptr [esi]
	add esi, type ary0317_u1224051
	sub ax, word ptr [esi]
	cmp ax, 0
	jg Greater
	jl Less

Greater:
	call WriteInt
	call Crlf
Less:
	call WriteInt
	call Crlf


	INVOKE ExitProcess, eax
main ENDP

END main