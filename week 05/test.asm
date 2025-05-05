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
summary2 byte "Sum of ary2_u1224051: ", 0
summary3 byte "Sum of ary3_u1224051: ", 0
sumary dword 3 dup(0)
sum dword 0

.code
addary_u1224051 PROC

	add sum, eax
	ret
addary_u1224051 ENDP

main PROC
	;init
	call Randomize
	mov eax, 0
	mov ecx, len1
	mov esi, type ary1_u1224051

S1:
	mov eax, 199
	call RandomRange
	add eax, 1
	call addary_u1224051
	mov ary1_u1224051[esi], al
	add esi, type ary1_u1224051
	;call DumpRegs
	loop S1

	push sum
	mov eax, 0
	mov ecx, len2
	mov esi, type ary2_u1224051

S2:
	mov eax, 199
	call RandomRange
	add eax, 1
	call addary_u1224051
	mov ary2_u1224051[esi], ax
	add esi, type ary2_u1224051
	;call DumpRegs
	loop S2

	push sum
	mov eax, 0
	mov ecx, len3
	mov esi, type ary3_u1224051

S3:
	mov eax, 199
	call RandomRange
	add eax, 1
	call addary_u1224051
	mov ary3_u1224051[esi], eax
	add esi, type ary3_u1224051
	;call DumpRegs
	loop S3

	push sum

	;output
	mov eax, 0
	mov ecx, 6
	mov esi, type ary1_u1224051
	mov edx, offset str1
	call WriteString
	call Crlf

C1:
	mov al, ary1_u1224051[esi]
	add esi, type ary1_u1224051
	call WriteInt
	call Crlf
	loop C1

	call Crlf
	mov eax, 0
	mov ecx, 6
	mov esi, type ary2_u1224051
	mov edx, offset str2
	call WriteString
	call Crlf

C2:
	mov ax, ary2_u1224051[esi]
	add esi, type ary2_u1224051
	call WriteInt
	call Crlf
	loop C2

	call Crlf
	mov eax, 0
	mov ecx, 6
	mov esi, type ary3_u1224051
	mov edx, offset str3
	call WriteString
	call Crlf

C3:
	mov eax, ary3_u1224051[esi]
	add esi, type ary3_u1224051
	call WriteInt
	call Crlf
	loop C3

	call Crlf

	mov ecx, 3
	mov esi, type sum

L1:
	pop sum
	mov eax, sum
	mov sumary[esi], eax
	add esi, type sumary
	loop L1

	mov edx, offset summary1
	call WriteString

	mov eax, sumary[3*type sumary]
	call WriteInt
	call Crlf

	mov edx, offset summary2
	call WriteString

	mov eax, sumary[2*type sumary]
	call WriteInt
	call Crlf

	mov edx, offset summary3
	call WriteString

	mov eax, sumary[1*type sumary]
	call WriteInt
	call Crlf

	INVOKE ExitProcess, eax
main ENDP

END main