.386
.model flat, stdcall
.stack 4096


include Irvine32.inc
;includelib Irvine32.lib
;includelib kernel32.lib
;includelib user32.lib
ExitProcess PROTO, dwExitCode:DWORD

.data
	ary2 word 10 dup(0)
	n word 0
	m word 0
	odd_v word 0
	odd_str byte "Odd index Sum: ", 0
	even_v word 0
	even_str byte "Even index Sum: ", 0

.code
MySub1 proc
	call ReadDec
	cmp eax, 1
	jb next
	cmp eax, 10
	ja next
	mov n, ax
	call MySub2

next:
	ret
MySub1 endp

MySub2 proc
	call ReadDec
	cmp eax, 50
	ja next

	push eax
	movzx ecx, n
	mov esi, offset ary2
RD:
	call RandomRange
	mov word ptr [esi], ax
	add esi, type ary2
	call ASMeven
	pop eax
	push eax
	loop RD

	mov esi, offset ary2
	mov ebx, type ary2
	mov ecx, lengthof ary2
	call DumpMem

	mov edx, offset odd_str
	call WriteString
	movzx eax, odd_v
	call WriteDec
	call Crlf

	mov edx, offset even_str
	call WriteString
	movzx eax, even_v
	call WriteDec
	call Crlf

next:
	ret
MySub2 endp

ASMeven proc
	
L1:
	test ecx, 1
	jne odd_

even_:
	add even_v, ax
	jmp next

odd_:
	add odd_v, ax

next:
	ret
ASMeven endp

main PROC

	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0
	mov esi, 0

	call MySub1

	INVOKE ExitProcess, eax
main ENDP

END main