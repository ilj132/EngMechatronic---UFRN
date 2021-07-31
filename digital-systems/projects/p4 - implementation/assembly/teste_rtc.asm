.include "m328pdef.inc"
rjmp start

delay:
	clr r20
	clr r21
	espera:
		dec r20
		brne espera
		dec r21
		brne espera
		ret

	start:

    call SPI_MasterInit

    cbi PINB,2
	sbi PINB,2 
	cbi PINB,2
	sbi PINB,2 
	
	call delay
	;seta os minutos
	cbi PINB, 2
    ldi r16, 0x81
    call SPI_MasterTransmit
    ldi r16, 0b00110100
    call SPI_MasterTransmit
	sbi PINB, 2
	call delay

	cbi PINB,2
	sbi PINB,2 

	//seta as hora
	cbi PINB, 2
    ldi r16, 0x82
    call SPI_MasterTransmit
    ldi r16, 0b00100010
    call SPI_MasterTransmit
	sbi PINB, 2
	call delay

	cbi PINB,2
	sbi PINB,2 

	//seta a data
	cbi PINB, 2
    ldi r16, 0x84
    call SPI_MasterTransmit
    ldi r16, 0b00010110
    call SPI_MasterTransmit
	sbi PINB, 2
	call delay

	cbi PINB,2
	sbi PINB,2 

	//seta o mes
	cbi PINB, 2
    ldi r16, 0x85
    call SPI_MasterTransmit
    ldi r16, 0b00000100
    call SPI_MasterTransmit
	sbi PINB, 2
	call delay
	
	cbi PINB,2
	sbi PINB,2 

	//seta o ano
	cbi PINB, 2
    ldi r16, 0x86
    call SPI_MasterTransmit
    ldi r16, 0b10011000
    call SPI_MasterTransmit
	sbi PINB, 2
	call delay

	acabou:
		
		rjmp acabou

    SPI_MasterInit:
; Set MOSI and SCK output, all others input
    ldi r17,(1<<DDB3)|(1<<DDB5)|(1<<DDB2)
    out DDRB,r17
; Enable SPI, Master, set clock rate fck/16
    ldi r17,(1<<SPE)|(1<<MSTR)|(1<<CPHA)|(1<<SPR0)
    out SPCR,r17
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