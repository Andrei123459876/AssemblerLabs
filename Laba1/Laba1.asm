.model small
.stack 100h
.code
begin: 
mov ax, @data
mov ds, ax
mov cx, 40			
mov dx, offset message
mov ah 	9h
int 21h
mov ah, 4Ch
int 21h
.data
message db "1234567 Word", 0Dh, 0Ah, '$'
	end begin