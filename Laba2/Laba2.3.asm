.model small

.stack 100h

.data

size equ 10h
max_string_size equ 200
max_word_size equ 50
;sim_zero equ 30h
;sim_nine equ 39h
;message db "1234567 1341f123 a 1 312312  Word13123 123123213 ", 0Dh, 0Ah, '$'
message db 30, ?, 30 dup ('$')
numberstring db "number", '$'
buf db 200 dup ('?') 

print_symb macro symb
    mov dl, symb  
    mov ah, 06h
    int 21h    
endm

.code
begin: 
	mov ax, @data
	mov ds, ax
	mov es, ax
	
	mov ah,0ah
    lea dx, message
    int 21h 
	
	mov bx, 2 ;bx:=2
	mov si, 2
	mov di, offset buf
	mov cx, max_string_size
	cld
string1:
	;mov bx message[si]
	cmp message[si], '0'
	jae checkn1
	jmp notnumber
checkn1:
	cmp message[si], '9'
	jbe checkn2
notnumber:					;space
	cmp message[si], ' '
	jne notspace
	push cx
	mov cx, max_word_size
skipspace1:
	inc si
	cmp message[si], ' '
loope skipspace1
	mov ax, si 						;keep curent position
	push si
	mov si, offset numberstring
	;cld
	mov cx, 6
;movenumber:
rep	movsb
	;cmp [si], '$' 
	;loop movenumber
	
	mov si, offset message
	add	si, bx
	sub ax, bx 						;lenght of word
	mov cx, ax
movestring:
	movsb
	;cmp [si], '$' 
	loop movestring 
	
	pop si
	pop cx
	mov bx, si 						;keep word position
	;inc bx
	jmp continue
	
notspace:					;not space
	push cx
	mov cx, max_word_size
skipword:
	inc si
	cmp message[si], '$'
	je dollarcheck
	cmp message[si], ' '
loopne skipword

skipspace2:
	inc si
	cmp message[si], ' '
loope skipspace2
dollarcheck:
	mov ax, si 						;keep curent position
	push si
	mov si, offset message
	add	si, bx						;si:=message[bx]
	sub ax, bx 						;lenght of word
	mov cx, ax
movestring1:
	movsb
	;cmp [si], '$' 
	loop movestring1 
	pop si
	pop cx
	mov bx, si
	jmp continue
checkn2:
	inc si
continue:
	cmp message[si], '$' 
loopne string1
	

	print_symb 0dh  
	print_symb 0ah
	;mov cx, 40
	mov [di], '$'
	mov dx, offset buf
	mov ah,	9h
	int 21h
	mov ah, 4Ch
	int 21h
end begin