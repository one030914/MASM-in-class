.386
.model flat, stdcall
.stack 4096


include Irvine32.inc
;includelib Irvine32.lib
;includelib kernel32.lib
;includelib user32.lib
ExitProcess PROTO, dwExitCode:DWORD

.data
	Q1 BYTE "==Q1=========================",
	sname byte "nuu_GarryAdam", 0
	n_len dword ($ - sname) - 1

	Q2 BYTE "==Q2=========================",0
	mydiff_u1224051 dword 8 dup(?)
	ary_len dword ($ - mydiff_u1224051) / 4
	ary_str byte "Random list: ", 0
	odd_str byte "Odd index Sum: ", 0
	odd_v dword 0
	even_str byte "Even index Sum: ", 0
	even_v dword 0

	Q3 BYTE "==Q3=========================",0
	Rval byte ?
	r_str byte "Rval: ", 0
	Xval byte 10
	x_str byte "Xval: ", 0
	Yval byte 5
	y_str byte "Yval: ", 0
	Zval byte 3
	z_str byte "Zval: ", 0

.code
main PROC
	;init
	mov eax, 0
	mov ebx, 0
	mov ecx, n_len
	mov edx, offset Q1
	call WriteString
	call Crlf
	mov edx, offset sname
	call WriteString
	call Crlf
	mov esi, offset sname

	;Q1
save:
	mov eax, [esi]
	push eax
	add esi, type byte
	loop save

	mov ecx, n_len
	mov esi, offset sname

load:
	pop eax
	mov byte ptr [esi], al
	add esi, type byte
	loop load

	mov edx, offset sname
	call WriteString
	call Crlf
	call Crlf

	mov edx, offset Q2
	call WriteString
	call Crlf
	mov eax, 0
	push eax
	mov ecx, ary_len
	push ecx
	mov esi, 0

	;Q2
random:
	mov eax, 250
	call RandomRange
	inc eax
	mov mydiff_u1224051[esi], eax
	test ecx, 1
	jne Odd_

Even_:
	add even_v, eax
	jmp next

Odd_:
	add odd_v, eax

next:
	add esi, type dword
	loop random

	pop ecx
	pop eax
	mov esi, offset mydiff_u1224051
	mov edx, offset ary_str
	call WriteString
	call Crlf

aryout:
	mov eax, dword ptr [esi]
	call WriteInt
	call Crlf
	add esi, type dword
	loop aryout
	call Crlf

	mov edx, offset even_str
	call WriteString
	mov eax, even_v
	call WriteInt
	call Crlf

	mov edx, offset odd_str
	call WriteString
	mov eax, odd_v
	call WriteInt
	call Crlf
	call Crlf

	;Q3
	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, offset Q3
	call WriteString
	call Crlf

	mov edx, offset x_str
	call WriteString
	movzx eax, Xval
	call WriteInt
	call Crlf
	mov edx, offset y_str
	call WriteString
	movzx eax, Yval
	call WriteInt
	call Crlf
	mov edx, offset z_str
	call WriteString
	movzx eax, Zval
	call WriteInt
	call Crlf

	movzx eax, Yval
	sub al, Zval
	add al, Xval
	mov Rval, al
	mov edx, offset r_str
	call WriteString
	call WriteInt
	call Crlf

	INVOKE ExitProcess, eax
main ENDP

END main