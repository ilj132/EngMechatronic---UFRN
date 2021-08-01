; estados.asm
;
; Created: 31/07/2021 20:42:54
; Author : Isaac de Lyra, Sthefania Fernandes, Alysson Ferreira, Wesley Brito, Anny Beatriz
;


; Replace with your application code

.def RH = r17
.def RM = r18
.def RW = r19

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
	call SPI_MasterInit
	clr RH
	clr RM
	clr RW
	rjmp timer_h
	
	;DEFINIÇÃO DOS INPUTS/OUTPUTS
	
	;PD4,PD5,PD6,PD7 - botão INC, DEC, R, A


SPI_MasterInit:
	; Set MOSI and SCK output, all others input
	ldi r17,(1<<DDB3)|(1<<DDB5)|(1<<DDB2)
	out DDRB,r17
	; Enable SPI, Master, set clock rate fck/16
    ldi r17,(1<<SPE)|(1<<MSTR)|(1<<CPHA)|(1<<SPR0)
    out SPCR, r17
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
	sbic PIND, 4
	call increm_hours
	sbic PIND, 5
	call decrem_hours
	sbic PIND, 6
	call RB_filter0
	rjmp timer_h

RB_filter0:
	sbic PIND, 6
	rjmp RB_filter0
	rjmp timer_m

timer_m:
	sbic PIND, 4
	call increm_min
	sbic PIND, 5
	call decrem_min
	sbic PIND, 6
	call RB_filter1
	rjmp timer_m

RB_filter1:
	sbic PIND, 6
	rjmp RB_filter1
	rjmp week

week:
	sbic PIND, 4
	call increm_day
	sbic PIND, 5
	call decrem_day
	sbic PIND, 6
	call RB_filter2
	rjmp week

RB_filter2:
	sbic PIND, 6
	rjmp RB_filter2
	rjmp rec

rec:
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

    //seta a data
    cbi PINB, 2
    ldi r16, 0x84 ; endereço de escrita da data
    call SPI_MasterTransmit
    ldi r16, 0b00000001 ;
    call SPI_MasterTransmit
    sbi PINB, 2

    cbi PINB,2
    sbi PINB,2 

    //seta o mes
    cbi PINB, 2
    ldi r16, 0x85 ; endereço de escrita do mes
    call SPI_MasterTransmit
    ldi r16, 0b00001000
    call SPI_MasterTransmit
    sbi PINB, 2
    
    cbi PINB,2
    sbi PINB,2 

    //seta o ano
    cbi PINB, 2
    ldi r16, 0x86 ; endereço de escrita do ano
    call SPI_MasterTransmit
    ldi r16, 0b00100001
    call SPI_MasterTransmit
    sbi PINB, 2

    acabou:
        
        rjmp acabou

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
