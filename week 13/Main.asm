.386
.model flat, stdcall
.stack 4096


include Irvine32.inc
;includelib Irvine32.lib
;includelib kernel32.lib
;includelib user32.lib
ExitProcess PROTO, dwExitCode:DWORD

.data
input byte 100 dup(0)
table byte 26 dup(0)
sum1AZ byte 0
sum2az byte 0
others byte 0
myQ1Msg BYTE "==sum1AZ===",0
myQ2Msg BYTE "==sum2az===",0
myQ3Msg BYTE "==others===",0

.code
get_freq proc
	mov esi, offset table
	movzx eax, byte ptr [edx]
	sub eax, 41h
	inc byte ptr [esi + eax]
	ret
get_freq endp

main PROC

	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0
	mov esi, 0
	
	mov edx, offset input
	mov ecx, sizeof input - 1
	call ReadString

	;mov esi, offset input
	mov ecx, eax
	;mov ebx, type input
	;call DumpMem
	
L1:
	cmp byte ptr [edx], 41h
	jae Upper
	jmp Other

Upper:
	cmp byte ptr [edx], 5Ah
	ja L2
	call get_freq
	inc sum1AZ
	jmp next

L2:
	cmp byte ptr [edx], 61h
	jb Other

Lower:
	cmp byte ptr [edx], 7Ah
	ja Lower
	inc sum2az
	jmp next

Other:
	inc others

next:
	add edx, type input
	loop L1

	mov edx, offset myQ1msg
	movzx eax, sum1AZ
	call WriteString
	call Crlf
	call WriteDec
	call Crlf
	
	mov esi, offset table
	mov ecx, lengthof table
	mov ebx, type table
	call DumpMem
	call Crlf

	mov edx, offset myQ2msg
	movzx eax, sum2az
	call WriteString
	call Crlf
	call WriteDec
	call Crlf

	mov edx, offset myQ3msg
	movzx eax, others
	call WriteString
	call Crlf
	call WriteDec
	call Crlf

	INVOKE ExitProcess, eax
main ENDP

END main