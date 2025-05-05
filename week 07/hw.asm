.386
.model flat, stdcall
.stack 4096


include Irvine32.inc
;includelib Irvine32.lib
;includelib kernel32.lib
;includelib user32.lib
ExitProcess PROTO, dwExitCode:DWORD

.data
ary0317_u1224051 word 6 dup(?)
len word ($ - ary0317_u1224051) / 2
sum word 0
string byte "Sum of array's gap: ", 0

.code
Init proc

	mov eax, 0
	movzx ecx, len
	mov esi, offset ary0317_u1224051
	ret

Init endp

Compare proc

	cmp ax, 0
	jnl Next
	not ax
	inc ax

Next:
	add sum, ax
	ret

Compare endp

main proc

	call Init

Random:
	mov eax, 99
	call RandomRange
	add eax, 1
	mov [esi], ax
	add esi, type word
	loop Random

	call Init
	dec ecx

L1:
	mov ax, word ptr [esi]
	add esi, type word
	sub ax, word ptr [esi]
	call Compare
	loop L1

	mov edx, offset string
	call WriteString
	movzx eax, sum
	call WriteInt
	call Crlf


	INVOKE ExitProcess, eax
main ENDP

END main