/*
 * Modulacao.c
 *
 * Created: 14/08/2021 20:33:56
 * Author : Lucas B && Isaac L && Sthefania F
 */ 

#include <avr/io.h>
#include <math.h>

#define pi 3.1415926535

int main(void)
{
    //Declaração portas
    DDRD = 0xFF; //PIN D OUT
    ADMUX = 1 << REFS0;
    ADCSRA = 1 << ADEN | 1 << ADSC | 1 << ADATE | 1 << ADPS1| 1 << ADPS0;
    ADCSRB = 0x00;
    DIDR0 = 0x03;

    
    float Ts = 0.0002;
    float t = 0;
    float c = 0;
	float freq_port = 500;
	
    uint8_t offset = 127;
	uint8_t Ap = 127;
    uint8_t output = 0;    
    uint16_t valor_ADC = 0;
	uint16_t pot = 0;
	
	float portadora = 0;
    //Inicialização portas
    PORTB = 0b00000000;
    
    /* Replace with your application code */
    while (1) 
    {
        ADCSRA |= 1 << ADSC;
        while (!(ADCSRA & 0b00010000));
		ADCSRA|=(1<<ADIF);
        valor_ADC = ADC;
        valor_ADC = valor_ADC/4; //10 bits -> 8 bits
        
		//MODULAÇÃO AM
		
		portadora = cos(2*pi*freq_port*t);
		output =  (0.5*valor_ADC)*portadora + offset;
		
		//MODULAÇÃO FM
		//float frequencia = freq_port + 0.2*valor_ADC;
		//output =  Ap*cos(2*pi*t*(freq_port + 0.2*127*cos(2*pi*10*t)))+offset;
		//output =  Ap*cos(2*pi*t*(freq_port + valor_ADC))+offset;
		//output = valor_ADC;
      
		
		//MODULAÇÃO FSK
		/*for(unsigned i=0 ; i<8 ; i++){
			if(valor_ADC & 1 << i){
				output =  Ap*cos(4*pi*t*freq_port)+offset;;
			}
			else{
				output =  Ap*cos(2*pi*t*freq_port)+offset;;
			}
		}*/
		
		PORTD = output;
		
		c=freq_port*t;
        t += Ts;
        if (c>= 1){
			t= 0;
		}
        
    }
}