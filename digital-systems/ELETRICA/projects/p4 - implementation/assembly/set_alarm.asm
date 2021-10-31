; set_alarm.asm
; Created: 01/08/2021 21:28:57
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

	;LIGANDO OS ALARMES
	call SPI_MasterInit

	cbi PINB,2
    sbi PINB,2 

	clr RH
	clr RM
	clr RW
	rjmp on_h
	
	;DEFINIÇÃO DOS INPUTS/OUTPUTS
	
	;PD4,PD5,PD6,PD7 - botão INC, DEC, R, A


SPI_MasterInit:
	; Set MOSI and SCK output, all others input
	ldi r17,(1<<DDB2)|(1<<DDB3)|(1<<DDB5)
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

on_h:
	sbic PIND, 4
	call increm_hours
	sbic PIND, 5
	call decrem_hours
	sbic PIND, 7
	call AB_filter0
	rjmp on_h

AB_filter0:
	sbic PIND, 7
	rjmp AB_filter0
	rjmp on_m

on_m:
	sbic PIND, 4
	call increm_min
	sbic PIND, 5
	call decrem_min
	sbic PIND, 7
	call AB_filter1
	rjmp on_m

AB_filter1:
	sbic PIND, 7
	rjmp AB_filter1
	rjmp on_week

on_week:
	sbic PIND, 4
	call increm_day
	sbic PIND, 5
	call decrem_day
	sbic PIND, 7
	call AB_filter2
	rjmp on_week

AB_filter2:
	sbic PIND, 7
	rjmp AB_filter2
	rjmp rec_a1

rec_a1:
	call conv_h
	clr r16
	call conv_m
	call conv_w

    cbi PINB,2
    sbi PINB,2 

    //seta os minutos do alarme 1
    cbi PINB, 2
    ldi r16, 0x88 ; endereço de escrita dos minutos do alarme 1
    call SPI_MasterTransmit
    mov r16, RM
    call SPI_MasterTransmit
    sbi PINB, 2

    cbi PINB,2
    sbi PINB,2 

    //seta as horas do alarme 1 
    cbi PINB, 2
    ldi r16, 0x89 ; endereço de escrita das horas do alarme 1
    call SPI_MasterTransmit
    mov r16, RH
    call SPI_MasterTransmit
    sbi PINB, 2

    cbi PINB,2
    sbi PINB,2 

	//seta o dia do alarme 1
	cbi PINB, 2
    ldi r16, 0x8A ; endereço de escrita do dia do alarme 1
    call SPI_MasterTransmit
    mov r16, RW
    call SPI_MasterTransmit
    sbi PINB, 2

    cbi PINB,2
    sbi PINB,2 

	call off_h

off_h:
	sbic PIND, 4
	call increm_hours
	sbic PIND, 5
	call decrem_hours
	sbic PIND, 7
	call AB_filter3
	rjmp off_h

AB_filter3:
	sbic PIND, 7
	rjmp AB_filter3
	rjmp off_m

off_m:
	sbic PIND, 4
	call increm_min
	sbic PIND, 5
	call decrem_min
	sbic PIND, 7
	call AB_filter4
	rjmp off_m

AB_filter4:
	sbic PIND, 7
	rjmp AB_filter4
	rjmp off_week

off_week:
	sbic PIND, 4
	call increm_day
	sbic PIND, 5
	call decrem_day
	sbic PIND, 7
	call AB_filter5
	rjmp off_week

AB_filter5:
	sbic PIND, 7
	rjmp AB_filter5
	rjmp rec_a2

rec_a2:
	call conv_h
	clr r16
	call conv_m
	call conv_w

    cbi PINB,2
    sbi PINB,2 

    //seta os minutos do alarme 2
    cbi PINB, 2
    ldi r16, 0x8B ; endereço de escrita dos minutos do alarme 2
    call SPI_MasterTransmit
    mov r16, RM
    call SPI_MasterTransmit
    sbi PINB, 2

    cbi PINB,2
    sbi PINB,2 

    //seta as horas do alarme 2 
    cbi PINB, 2
    ldi r16, 0x8C ; endereço de escrita das horas do alarme 2
    call SPI_MasterTransmit
    mov r16, RH
    call SPI_MasterTransmit
    sbi PINB, 2

    cbi PINB,2
    sbi PINB,2 

	//seta o dia do alarme 2
	cbi PINB, 2
    ldi r16, 0x8D ; endereço de escrita do dia do alarme 2
    call SPI_MasterTransmit
    mov r16, RW
    call SPI_MasterTransmit
    sbi PINB, 2

    cbi PINB,2
    sbi PINB,2 

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

conv_w:
	ori RW, 0x40
	ret