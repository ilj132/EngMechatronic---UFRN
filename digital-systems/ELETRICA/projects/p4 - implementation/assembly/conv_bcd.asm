;
; conv_hex_to_bcd.asm
;
; Created: 02/08/2021 11:02:17
; Author :
;


; Replace with your application code


conv_bcd:     
;SEPARA DIGITOS     
MOV R16, TEMPO				; R16 vai tratar das dezenas e tempo das unidades     
ANDI TEMPO, 0B0000_1111		; Limpa os 4 bits MAIS significativos, restando apenas o valor das unidades
MOV UN, TEMPO				; Transfere unidades para UN     
ANDI R16, 0B11110000		; Limpa os 4 bits MENOS significativos, restando o valor as dezenas (mas precisa ser deslocado ate o bit 0)     
LSR R16 ; (00ddd000)     
LSR R16 ; (000ddd00)     
LSR R16 ; (0000ddd0)     
LSR R16 ; (00000ddd) 
MOV DE, R16  ; transfere dezenas para DE  