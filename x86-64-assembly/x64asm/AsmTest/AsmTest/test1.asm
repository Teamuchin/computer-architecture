.data
mybyte db 78
myword dw 88
myfloat real4 89.5

.code 
main proc



	lea rax, mybyte
	mov byte ptr[rax], 55



	ret
main endp
end