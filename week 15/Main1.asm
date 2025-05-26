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
	str1 byte 20 dup(0)
	random byte "The string is: ", 0
	table byte 26 dup(0)
	summarize byte "Summarizing...", 0

.code
get_freq proc
	push esi
	
	mov esi, offset table
	inc byte ptr [esi + eax]

	pop esi
	ret
get_freq endp

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
	mov ecx, eax
	mov esi, offset str1
	
RD:
	mov eax, 'Z'
	call RandomRange
	sub eax, 'A'
	cmp eax, 0
	jb n
	cmp eax, 26
	ja n

	call get_freq
	add eax, 'A'
	mov byte ptr [esi], al
	add esi, type str1
	jmp next

n:
	inc ecx

next:
	loop RD

	mov edx, offset random
	call WriteString
	mov edx, offset str1
	call WriteString
	call Crlf

	mov edx, offset summarize
	call WriteString
	call Crlf
	mov esi, offset table
	mov ebx, type table
	mov ecx, lengthof table
	call DumpMem
	jmp next2

E1:
	mov edx, offset error
	call WriteString
	call Crlf

next2:
	INVOKE ExitProcess, eax
main ENDP

END main