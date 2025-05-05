.386
.model flat, stdcall
.stack 4096


include Irvine32.inc
;includelib Irvine32.lib
;includelib kernel32.lib
;includelib user32.lib
ExitProcess PROTO, dwExitCode:DWORD

.data
ary1_u1224051 byte 6 dup(?)
len1 dword ($ - ary1_u1224051)
str1 byte "ary1_u1224051: ", 0

ary2_u1224051 word 6 dup(?)
len2 dword ($ - ary2_u1224051) / 2
str2 byte "ary2_u1224051", 0

ary3_u1224051 dword 6 dup(?)
len3 dword ($ - ary3_u1224051) / 4
str3 byte "ary3_u1224051", 0

summary1 byte "Sum of ary1_u1224051: ", 0
sum1 dword 0
summary2 byte "Sum of ary2_u1224051: ", 0
sum2 dword 0
summary3 byte "Sum of ary3_u1224051: ", 0
sum3 dword 0

.code
addary_u1224051 PROC
	push eax

	;if byte
	;else if word
	;else
	cmp ebx, 1
	je Rbyte
	cmp ebx, 2
	je Rword
	mov eax, dword ptr [esi]
	add sum3, eax
	jmp next

Rbyte:
	movzx eax, byte ptr [esi]
	add sum1, eax
	jmp next
Rword:
	movzx eax, word ptr [esi]
	add sum2, eax
next:

	pop eax
	ret
addary_u1224051 ENDP

main PROC
	;init
	mov eax, 0
	mov ebx, 0
	mov ecx, len1
	mov esi, offset ary1_u1224051

Save1:
	mov eax, 199
	call RandomRange
	add eax, 1
	mov byte ptr [esi], al
	mov ebx, type ary1_u1224051
	call addary_u1224051
	add esi, type ary1_u1224051
	loop Save1

	mov eax, 0
	mov ebx, 0
	mov ecx, len2
	mov esi, offset ary2_u1224051

Save2:
	mov eax, 199
	call RandomRange
	add eax, 1
	mov word ptr [esi], ax
	mov ebx, type ary2_u1224051
	call addary_u1224051
	add esi, type ary2_u1224051
	loop Save2

	mov eax, 0
	mov ebx, 0
	mov ecx, len3
	mov esi, offset ary3_u1224051

Save3:
	mov eax, 199
	call RandomRange
	add eax, 1
	mov dword ptr [esi], eax
	mov ebx, type ary3_u1224051
	call addary_u1224051
	add esi, type ary3_u1224051
	loop Save3

	;output array
	mov eax, 0
	mov ecx, 6
	mov esi, offset ary1_u1224051
	mov edx, offset str1
	call WriteString
	call Crlf

Out1:
	mov al, byte ptr [esi]
	add esi, type ary1_u1224051
	call WriteInt
	call Crlf
	loop Out1

	call Crlf
	mov eax, 0
	mov ecx, 6
	mov esi, offset ary2_u1224051
	mov edx, offset str2
	call WriteString
	call Crlf

Out2:
	mov ax, word ptr [esi]
	add esi, type ary2_u1224051
	call WriteInt
	call Crlf
	loop Out2

	call Crlf
	mov eax, 0
	mov ecx, 6
	mov esi, offset ary3_u1224051
	mov edx, offset str3
	call WriteString
	call Crlf

Out3:
	mov eax, dword ptr [esi]
	add esi, type ary3_u1224051
	call WriteInt
	call Crlf
	loop Out3

	;output sum of 3 arrays
	call Crlf
	mov edx, offset summary1
	call WriteString
	mov eax, sum1
	call WriteInt
	call Crlf
	
	mov edx, offset summary2
	call WriteString
	mov eax, sum2
	call WriteInt
	call Crlf

	mov edx, offset summary3
	call WriteString
	mov eax, sum3
	call WriteInt
	call Crlf

	INVOKE ExitProcess, eax
main ENDP

END main