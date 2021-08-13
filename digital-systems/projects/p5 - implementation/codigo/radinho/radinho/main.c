/*
 * radinho.c
 *
 * Created: 12/08/2021 19:14:51
 * Author : Isaac de Lyra
 */ 
#define F_CPU 8000000UL //define frequência de operação da CPU 
#include <avr/io.h>
#include <util/delay.h>

int main(void)
{
	DDRB = 0b00100000;
    /* Replace with your application code */
    while (1) 
    {
		PORTB = 0b00100000;
		_delay_ms(250);
		PORTB = 0b00000000;
		_delay_ms(250);
    }
}

