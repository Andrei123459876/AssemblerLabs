.model tiny
.code
org 100h
begin:
mov dx, offset message
mov ah 	9h
int 21h
ret
message db "1234567 Word", 0Dh, 0Ah, '$'
	end begin