; cofre.asm
;
; Created: 17/07/2021 19:27:45
; Author : Isaac, Alysson, Ana, Sthefania, Elias
;


; Replace with your application code
.include "m328pdef.inc"
.org 0x0000 

config:	
	;DEFINIÇÃO DAS SENHAS
	ldi r26, 0 ;XL
	ldi r27, 0 ;XH
	ldi r28, 0xE7 ;YL
	ldi r29, 0x03 ;YH
	ldi r30, 0 ;ZL
	ldi r31, 0 ;ZH

	;DEFINIÇÃO DO PWM
	ldi r16, 0b10100011
	sts 0x44, r16 ; define TCCR0A
	ldi r16, 0b00000011
	sts 0x45, r16 ; define TCCR0B 

	;DEFINIÇÃO DO TIMER 1
	ldi r16, 0x3d
	sts 0x89, r16 ; OCR1AH
	ldi r16, 0x09
	sts 0x88, r16 ; OCR1AL
	ldi r16, 0x00
	sts 0x80, r16 ; TCCR1A
	ldi r16, 0x00
	sts 0x82, r16 ; TCCR1C
	ldi r16, 0x23
	sts 0x6f, r16 ; TIMSK1
	ldi r17, 0x02
	ldi r16, 0x4c
	sts 0x81, r16 ; TCCR1B
	
	;DEFINIÇÃO DE ENTRADAS E SAÍDAS
	ldi r16, 0b11111111
    out DDRB, r16 ; define todas as portas PB como saída
	ldi r16, 0b11111000
	out DDRD, r16 ; define inputs/outputs das portas PD
	cbi DDRC, 1
	cbi DDRC, 2
	sbi DDRC, 3
	sbi DDRC, 4

	;DEFINIÇÃO DO CONVERSOR AD
    ldi r16, 0b01000000
    sts ADMUX, r16 ; define ADMUX como sendo com REFS = 01, ou seja pega a tensão 
				   ; de referência do AVCC em conjunto com capacitor
	ldi r16, 0b00000001
	sts DIDR0, r16

	rjmp desligado

setledred:
	ldi r16, 255
	sts 0x48, r16 ; define OCR0B
	ldi r16, 0
	sts 0x47, r16 ; define OCR0A
	cbi PORTD, 7
	ret

setledblue:
	ldi r16, 0
	sts 0x48, r16 ; define OCR0B
	ldi r16, 0
	sts 0x47, r16 ; define OCR0A
	ret

setledorange:
	ldi r16, 255
	sts 0x48, r16 ; define OCR0B
	ldi r16, 127
	sts 0x47, r16 ; define OCR0A
	cbi PORTD, 7
	ret

setledgreen:
	ldi r16, 0
	sts 0x48, r16 ; define OCR0B
	ldi r16, 255
	sts 0x47, r16 ; define OCR0A
	cbi PORTD, 7
	ret

delay:
	clr r17
	ldi r18, 10
	delay_loop:
		dec r17
		brne delay_loop
		dec r18
		brne delay_loop
		ret

timer05:
	sbi TIFR1, 1
	comeca:
		sbis TIFR1, 1
		rjmp comeca
		ret

conv:	
	ldi r16, 0b11100111
    sts ADCSRA, r16 ; define ADCSRA
	rcall delay
	lds r18, ADCL
	lds r19, ADCH
    lds r16, ADCL
	lds r17, ADCH
	cpi r17, 3
    breq atribuir3
    cpi r17, 2
    breq atribuir2
    cpi r17, 1
    breq atribuir1
	rjmp atribuir0

    atribuir3:
		ldi r17, 0b10011000
		rjmp saidapd
    atribuir2:
		ldi r17, 0b10010000
		rjmp saidapd
    atribuir1:
		ldi r17, 0b10001000
		rjmp saidapd
	atribuir0:
		ldi r17, 0b10000000
		rjmp saidapd
	
	saidapd:
		out PORTD, r17
		out PORTB, r16
		ret

desligado:
	rcall setledred
	cbi PORTC, 3
	sbi PORTC, 4
	clr r21
	clr r20
	sbis PINC, 1
	rjmp desligado
	rjmp botao_sinc

botao_sinc:
	sbic PINC, 1
	rjmp botao_sinc
	rjmp esperasenha

esperasenha:
	rcall setledblue
	cbi PORTC, 4
	rcall conv
	rjmp verificaon

verificaon:
	sbis PINC, 1
	rjmp verificaadd
	rjmp botao_sinc3

botao_sinc3:
	sbic PINC, 1
	rjmp botao_sinc3
	rjmp desligado

verificaadd:
	sbis PINC, 2
	rjmp esperasenha
	rjmp botao_sinc2

botao_sinc2:
	sbic PINC, 2
	rjmp botao_sinc2
	rjmp inseresenha

inseresenha:
	rcall setledorange
	ldi r16, 0b00000111
	sts ADCSRA, r16 ; desliga conversão
	rcall timer05
	cpi r20, 0
	breq comp_senha1
	cpi r20, 1
	breq comp_senha2
	cpi r20, 2
	breq comp_senha3

	comp_senha1:
		inc r20 
		cpse r18, r26
		rjmp esperasenha
		cpse r19, r27
		rjmp esperasenha
		inc r21
		rjmp esperasenha

	comp_senha2:
		inc r20 
		cpse r18, r28
		rjmp esperasenha
		cpse r19, r29
		rjmp esperasenha
		inc r21
		rjmp esperasenha
	
	comp_senha3:
		cpse r18, r30
		rjmp comparasenha
		cpse r19, r31
		rjmp esperasenha
		inc r21
		rjmp comparasenha

comparasenha:
	rcall setledorange
	cpi r21, 3
	breq aberto
	rjmp desligado

aberto:
	rcall setledgreen
	sbi PORTC, 3
	sbis PINC, 1
	rjmp aberto
	rjmp botao_sinc4

botao_sinc4:
	sbic PINC, 1
	rjmp botao_sinc4
	rjmp desligado