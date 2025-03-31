.386
.model flat, stdcall
.stack 4096


include Irvine32.inc
;includelib Irvine32.lib
;includelib kernel32.lib
;includelib user32.lib
ExitProcess PROTO, dwExitCode:DWORD

.data
var1 word 0

.code
;if (((al < bl) AND (bl >= cl)) OR cl==dl)
;True: var1 = 55
;False: var1 = 33
main proc
	mov eax, 1
	mov ebx, 3
	mov ecx, 1
	mov edx, 1
	call DumpRegs

	cmp al, bl
	jae L1
	cmp bl, cl
	jb L1
L1:
	mov var1, 33
	cmp cl, dl
	jne Next
	mov var1, 55
Next:
	mov eax, 0
	mov ax, var1
	call WriteInt

	INVOKE ExitProcess, eax
main ENDP

END main