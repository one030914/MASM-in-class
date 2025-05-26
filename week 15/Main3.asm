.386
.model flat, stdcall
.stack 4096


include Irvine32.inc
;includelib Irvine32.lib
;includelib kernel32.lib
;includelib user32.lib
ExitProcess PROTO, dwExitCode:DWORD

.data
	input byte "Please enter a number (10-20): ", 0
	error byte "The number not in range 10-20", 0
	arr byte 20 dup(0)
	n byte 0
	str1 byte "The array: ", 0
	space byte " ", 0
	str2 byte "The result: ", 0

.code
main PROC

	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0
	mov esi, 0

	mov edx, offset input
	call WriteString
	call ReadDec
	cmp eax, 10
	jb E1
	cmp eax, 20
	ja E1

	mov n, al
	mov edx, offset str1
	call WriteString
	mov esi, offset arr
	mov ecx, eax
RD:
	mov eax, 50
	call RandomRange
	inc eax
	call WriteDec
	mov edx, offset space
	call WriteString
	mov byte ptr [esi], al
	add esi, type arr
	loop RD
	call Crlf

	mov esi, offset arr
	movzx eax, n
	mov bl, 2
	div bl
	mov cl, al

Switch:
	movzx eax, byte ptr [esi]
	xchg al, byte ptr [esi + type arr]
	mov byte ptr [esi], al
	add esi, 2 * type arr
	loop Switch

	mov esi, offset arr
	movzx ecx, n
	mov edx, offset str2
	call WriteString
Write:
	mov al, byte ptr [esi]
	call WriteDec
	mov edx, offset space
	call WriteString
	add esi, type arr
	loop Write
	call Crlf
	jmp next

E1:
	mov edx, offset error
	call WriteString
	call Crlf
next:
	INVOKE ExitProcess, eax
main ENDP

END main