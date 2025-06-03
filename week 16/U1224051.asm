.386
.model flat, stdcall
.stack 4096


include Irvine32.inc
;includelib Irvine32.lib
;includelib kernel32.lib
;includelib user32.lib
ExitProcess PROTO, dwExitCode:DWORD

.data
Q1Msg BYTE "==Q1=========================",0
Q1ary byte 15 dup(0)
Q1len byte 0
max byte 0
min byte 0
Q2Msg BYTE "==Q2=========================",0
Q2ary byte 50 dup(0)
table byte 26 dup(0)
Q3Msg BYTE "==Q3=========================",0
Q4Msg BYTE "==Q4=========================",0
year word 0
not byte "NOT", 0
leap byte "Leap Year", 0

.code
init proc
	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0
	mov esi, 0
	ret
init endp

newSub1 proc
	call ReadDec
	cmp eax, 10
	jb next
	cmp eax, 15
	ja next
	mov Q1len, al
	call newSub2
	
next:
	ret
newSub1 endp

newSub2 proc
	call ReadDec
	cmp eax, 200
	jae next
	mov cl, Q1len
	mov esi, offset Q1ary
	mov ebx, eax

RD:
	mov eax, ebx
	call RandomRange
	mov byte ptr [esi], al
	add esi, type Q1ary
	loop RD

	mov esi, offset Q1ary
	mov ebx, type Q1ary
	movzx ecx, Q1len
	call DumpMem

	call init
	call newSub3

next:
	ret
newSub2 endp

newSub3 proc
	movzx ecx, Q1len
	mov esi, offset Q1ary

L1:
	mov dl, byte ptr [esi]
	cmp dl, al
	ja Above
	cmp dl, bl
	jbe Below
	jmp next

Above:
	mov al, dl
	mov max, cl
	jmp next

Below:
	mov bl, dl
	mov min, cl

next:
	add esi, type Q1ary
	loop L1

	mov al, max
	mov al, Q1len
	sub al, max
	mov bl, Q1len
	sub bl, min
	mov esi, offset Q1ary
	movzx edx, byte ptr [esi + eax]
	xchg dl, byte ptr [esi + ebx]
	mov byte ptr [esi + eax], dl

	mov esi, offset Q1ary
	mov ebx, type Q1ary
	movzx ecx, Q1len
	call DumpMem
	
	ret
newSub3 endp

;newSub4 proc

;newSub4 endp

;newSub5 proc

;newSub5 endp

newSub6 proc
	call ReadDec
	cmp eax, 1500
	jbe next
	mov year, ax
	call newSub7

next:
	ret
newSub6 endp

newSub7 proc
	movzx eax, year
	div 4
	cmp edx, 0
	jne n
	movzx eax, year
	div 100
	cmp edx, 0
	jne n
	movzx eax, year
	div 400
	cmp edx, 0
	jne n

y:
	mov edx, offset leap
	call WriteString
	call Crlf
	jmp next
n:
	mov edx, offset not
	call WriteString
	call Crlf
next:
	ret
newSub7 endp

main PROC

	call init
	;Q1
	mov edx, offset Q1Msg
	call WriteString
	call Crlf

	call newSub1

	;Q2
	call init
	mov edx, offset Q2Msg
	call WriteString
	call Crlf

	mov edx, offset Q2ary
	mov ecx, sizeof Q2ary - 1
	call ReadString
	cmp eax, 15
	jbe Q2next
	call DumpRegs

Q2next:
	

	;Q3
	call init
	mov edx, offset Q3Msg
	call WriteString
	call Crlf

	;Q4
	call init
	mov edx, offset Q4Msg
	call WriteString
	call Crlf

	call newSub6

	INVOKE ExitProcess, eax
main ENDP

END main