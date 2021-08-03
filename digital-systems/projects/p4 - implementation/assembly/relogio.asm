;
; relogio.asm
;
; Created: 28/07/2021 20:56:45
; Author : Isaac de Lyra, Sthefania Fernandes, Alysson Ferreira, Wesley Brito, Anny Beatriz
;


; Replace with your application code
.include "m328pdef.inc"
.def RH = r17
.def RM = r18
.def RW = r19
.def RH_H = r20
.def RH_L = r21
.def RM_H = r22
.def RM_L = r23

inicio:
    rjmp config

config:	

	;DEFINIÇÃO DO TIMER 1
	ldi r16, 0x3d
	sts 0x89, r16 ; OCR1AH
	ldi r16, 0x09
	sts 0x88, r16 ; OCR1AL
	ldi r16, 0x23
	sts 0x6f, r16 ; TIMSK1
	ldi r16, 0x4c
	sts 0x81, r16 ; TCCR1B


	; SET DE ENTRADAS/SAÍDAS 
	ldi r16,(1<<DDB1)|(1<<DDB2)|(1<<DDB3)|(1<<DDB5) ; Set MOSI and SCK output, all others input
	out DDRB, r16
	ldi r16,(1<<DDC2)|(1<<DDC3)|(1<<DDC4)|(1<<DDC5) ; PC2 a PC5: SAIDA DOS LEDS DO MODO DE OPERACAO
	out DDRC, r16
	ldi r16,(1<<DDD0)|(1<<DDD1)|(1<<DDD2)|(1<<DDD3) ; PD0 a PD3: SAIDA DOS LEDS DA SEMANA
	out DDRD, r16

	call SPI_RTC

	sbi PORTB,1
	cbi PORTB,1
	sbi PORTB,1
	sbi PORTB,2
	cbi PORTB,2
	sbi PORTB,2

	call setHours

	call SPI_DISPLAY
	; CONFIGURAÇÃO DO DISPLAY
	cbi PORTB,1
	ldi r16, 0x09
	call SPI_MasterTransmit
	ldi r16, 0x0F ;HABILITA DECODE MODE DO MAX7219
	call SPI_MasterTransmit
	sbi PORTB,1

	cbi PORTB,1
	ldi r16, 0xA
	call SPI_MasterTransmit
	ldi r16, 0xF ; CONFIGURA INTENSIDADE
	call SPI_MasterTransmit
	sbi PORTB,1

	cbi PORTB,1
	ldi r16, 0x0F
	call SPI_MasterTransmit
	ldi r16, 0x00 ;CONFIGURA O DISPLAY TEST
	call SPI_MasterTransmit
	sbi PORTB,1

	cbi PORTB,1
	ldi r16, 0xB
	call SPI_MasterTransmit
	ldi r16, 0x3 ;CONFIGURA O SCAN LIMIT
	call SPI_MasterTransmit
	sbi PORTB,1

	cbi PORTB,1
	ldi r16, 0x0C
	call SPI_MasterTransmit
	ldi r16, 0x01 ;CONFIGURA O SHUTDOWN MODE
	call SPI_MasterTransmit
	sbi PORTB,1

	;cbi PORTB,1
	clr RH
	clr RM
	clr RW

	rjmp run
	
SPI_DISPLAY:
	; Enable SPI, Master, set clock rate fck/16
    ldi r16,(1<<SPE)|(1<<MSTR)|(0<<CPHA)|(0<<SPR0)
    out SPCR, r16
    ret

SPI_RTC:
	; Enable SPI, Master, set clock rate fck/16
    ldi r16,(1<<SPE)|(1<<MSTR)|(1<<CPHA)|(0<<SPR0)
    out SPCR, r16
    ret

SPI_MasterTransmit:
; Start transmission of data (r16)
    out SPDR, r16
	Wait_Transmit:
		; Wait for transmission complete
		in r16, SPSR
		sbrs r16, SPIF
		rjmp Wait_Transmit
		ret

run:
	call read_rtc
	call conv_bcd
	call display_all
	

	sbic PIND, 6
	call RB_filter0
	sbic PIND, 7
	call AB_filter0

	call delay

	rjmp run

RB_filter0:
	sbic PIND, 6
	rjmp RB_filter0
	rjmp write_rtc

AB_filter0:
	sbic PIND, 7
	rjmp RB_filter0
	;rjmp write_alarm

acabou:
	call delay
	call delay
	call delay
	call delay
	call delay
	rjmp acabou

display_all:
	call SPI_DISPLAY
	sbi PORTB,2

	cbi PORTB, 1
	ldi r16, 0x1
	call SPI_MasterTransmit
	mov r16, RH_H
	call SPI_MasterTransmit
	sbi PORTB, 1

	cbi PORTB, 1
	ldi r16, 0x2
	call SPI_MasterTransmit
	mov r16, RH_L
	call SPI_MasterTransmit
	sbi PORTB, 1

	cbi PORTB, 1
	ldi r16, 0x3
	call SPI_MasterTransmit
	ldi r16, 0x1
	mov r16, RM_H
	call SPI_MasterTransmit
	sbi PORTB, 1

	cbi PORTB, 1
	ldi r16, 0x4
	call SPI_MasterTransmit
	ldi r16, 0x5
	mov r16, RM_L
	call SPI_MasterTransmit
	sbi PORTB, 1

	call delay

	ret

display_hours:
	call SPI_DISPLAY
	sbi PORTB,2

	cbi PORTB, 1
    ldi r16, 0x1
	call SPI_MasterTransmit
	mov r16, RH_H
	call SPI_MasterTransmit
	sbi PORTB, 1

	cbi PORTB, 1
	ldi r16, 0x2
	call SPI_MasterTransmit
	mov r16, RH_L
	call SPI_MasterTransmit
	sbi PORTB, 1

	cbi PORTB, 1
	ldi r16, 0x3
	call SPI_MasterTransmit
	ldi r16, 0xF
	call SPI_MasterTransmit
	sbi PORTB, 1

	cbi PORTB, 1
	ldi r16, 0x4
	call SPI_MasterTransmit
	ldi r16, 0xF
	call SPI_MasterTransmit
	sbi PORTB, 1

	call delay

	ret

display_minutes:
	call SPI_DISPLAY
	sbi PORTB,2

	cbi PORTB, 1
	ldi r16, 0x1
	call SPI_MasterTransmit
	ldi r16, 0xF
	call SPI_MasterTransmit
	sbi PORTB, 1

	cbi PORTB, 1
	ldi r16, 0x2
	call SPI_MasterTransmit
	ldi r16, 0xF
	call SPI_MasterTransmit
	sbi PORTB, 1

	cbi PORTB, 1
	ldi r16, 0x3
	call SPI_MasterTransmit
	mov r16, RM_H
	call SPI_MasterTransmit
	sbi PORTB, 1

	cbi PORTB, 1
	ldi r16, 0x4
	call SPI_MasterTransmit
	mov r16, RM_L
	call SPI_MasterTransmit
	sbi PORTB, 1

	call delay

	ret

write_rtc:
	clr RH
	clr RM
	clr RW
	rjmp timer_h

read_rtc:
	call SPI_RTC
	sbi PORTB,1

	sbi PORTB, 2

	cbi PORTB, 2
	ldi r16, 0x1
	call SPI_MasterTransmit
	call SPI_MasterTransmit
	;mov RM, r16	
	lds RM, 0x4E
	sbi PORTB, 2

	cbi PORTB, 2
	sbi PORTB, 2

	cbi PORTB, 2
	ldi r16, 0x2
	call SPI_MasterTransmit
	call SPI_MasterTransmit
	;mov RH, r16
	lds RH, 0x4E
	sbi PORTB, 2

	cbi PORTB, 2
	sbi PORTB, 2

	cbi PORTB, 2
	ldi r16, 0x3
	call SPI_MasterTransmit
	call SPI_MasterTransmit
	;mov RW, r16
	lds RW, 0x4E
	sbi PORTB, 2

	cbi PORTB, 2
	sbi PORTB, 2

	ret

delay:
	clr r17
	clr r18
	ldi r19,10
	delay_espera:
	dec r17
	brne delay_espera
	dec r18
	brne delay_espera
	dec r19
	brne delay_espera
	ret
	
conv_bcd:
	;SEPARA DIGITOS     
	mov RH_L, RH
	mov RH_H, RH				   
	cbr RH_L, 0B11110000		
	cbr RH_H, 0B00001111
	lsr RH_H  
	lsr RH_H    
	lsr RH_H   
	lsr RH_H  

	mov RM_L, RM
	mov RM_H, RM				   
	cbr RM_L, 0B11110000		
	cbr RM_H, 0B00001111
	lsr RM_H 
	lsr RM_H    
	lsr RM_H   
	lsr RM_H  
	ret

timer05:
    sbi TIFR1, 1
    comeca:
        sbis TIFR1, 1
        rjmp comeca
        ret

decrem_hours:
	dec RH
	call timer05
	cpi RH, 24
	brsh lock_hours_dec
	ret

lock_hours_dec:
	ldi RH, 0
	ret

increm_hours:
	inc RH
	call timer05
	cpi RH, 24
	brsh lock_hours_inc
	ret

lock_hours_inc:
	ldi RH, 23
	ret

decrem_min:
	dec RM
	call timer05
	cpi RM, 60
	brsh lock_min_dec
	ret

lock_min_dec:
	ldi RM, 0
	ret

increm_min:
	inc RM
	call timer05
	cpi RM, 60
	brsh lock_min_inc
	ret

lock_min_inc:
	ldi RM, 59
	ret

decrem_day:
	dec RW
	call timer05
	cpi RW, 1
	brlo lock_day_dec
	ret

lock_day_dec:
	ldi RW, 1
	ret

increm_day:
	inc RW
	call timer05
	cpi RW, 8
	brsh lock_day_inc
	ret

lock_day_inc:
	ldi RW, 7
	ret

timer_h:
	;call conv_bcd
	call display_hours
	sbic PIND, 4
	rcall increm_hours
	sbic PIND, 5
	rcall decrem_hours
	sbic PIND, 6
	rjmp RB_filter1
	rjmp timer_h

RB_filter1:
	sbic PIND, 6
	rjmp RB_filter1
	rjmp timer_m

timer_m:
	call conv_bcd
	call display_minutes
	sbic PIND, 4
	rcall increm_min
	sbic PIND, 5
	rcall decrem_min
	sbic PIND, 6
	rjmp RB_filter2
	rjmp timer_m

RB_filter2:
	sbic PIND, 6
	rjmp RB_filter2
	rjmp week

week:
	sbic PIND, 4
	rcall increm_day
	sbic PIND, 5
	rcall decrem_day
	sbic PIND, 6
	rjmp RB_filter3
	rjmp week

RB_filter3:
	sbic PIND, 6
	rjmp RB_filter3
	rjmp rec

setHours:
	call SPI_RTC

	
    sbi PINB,2 
    //seta os minutos
    cbi PINB, 2
    ldi r16, 0x81 ; endereço de escrita dos minutos
    call SPI_MasterTransmit
    ldi r16, 0x48
    call SPI_MasterTransmit
    sbi PINB, 2

    cbi PINB,2
    sbi PINB,2 

    //seta as hora
    cbi PINB, 2
    ldi r16, 0x82 ; endereço de escrita das horas
    call SPI_MasterTransmit
    ldi r16, 0x4
    call SPI_MasterTransmit
    sbi PINB, 2

    cbi PINB,2
    sbi PINB,2 

	//seta o dia
	cbi PINB, 2
    ldi r16, 0x83 ; endereço de escrita do dia
    call SPI_MasterTransmit
    ldi r16, 0x3
    call SPI_MasterTransmit
    sbi PINB, 2

    cbi PINB,2
    sbi PINB,2 

	ret


rec:
	call SPI_RTC
	call conv_h
	clr r16
	call conv_m

	cbi PINB,2
    sbi PINB,2 
    cbi PINB,2
    sbi PINB,2 

    //seta os minutos
    cbi PINB, 2
    ldi r16, 0x81 ; endereço de escrita dos minutos
    call SPI_MasterTransmit
    mov r16, RM
    call SPI_MasterTransmit
    sbi PINB, 2

    cbi PINB,2
    sbi PINB,2 

    //seta as hora
    cbi PINB, 2
    ldi r16, 0x82 ; endereço de escrita das horas
    call SPI_MasterTransmit
    mov r16, RH
    call SPI_MasterTransmit
    sbi PINB, 2

    cbi PINB,2
    sbi PINB,2 

	//seta o dia
	cbi PINB, 2
    ldi r16, 0x83 ; endereço de escrita das horas
    call SPI_MasterTransmit
    mov r16, RW
    call SPI_MasterTransmit
    sbi PINB, 2

    cbi PINB,2
    sbi PINB,2 

	rjmp run

conv_h:
	cpi RH, 20
	brsh subtrai20h
	cpi RH, 10
	brsh subtrai10h
	ret

subtrai20h:
	subi RH, 20
	ori RH, 0x20
	ret

subtrai10h:
	subi RH, 10
	ori RH, 0x10
	ret

conv_m: 
	cpi RM, 10
	brsh subtrai10m	
	sbrc r16, 2
	ori RM, 0x40
	sbrc r16, 1
	ori RM, 0x20
	sbrc r16, 0
	ori RM, 0x10
	ret

subtrai10m:
	subi RM, 10
	inc r16
	rjmp conv_m