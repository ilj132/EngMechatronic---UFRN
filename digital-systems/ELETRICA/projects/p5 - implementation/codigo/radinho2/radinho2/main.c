/*
 * radinho2.c
 *
 * Created: 14/08/2021 23:11:05
 * Author : Isaac de Lyra, Lucas Augusto, Albertho Síziney, Lucas Batista, Sthefania Fernandes(quase Ferreira)
 */ 

#include <avr/io.h>
#include "Bibliotecas/controleDisplay.h"
#include <math.h>

int main(void)
{
	//Declaracao portas
	DDRB = 0xFF; //PIN B OUT
	DDRD = 0xFF; //PIN D OUT
	ADMUX = 1 << REFS0;
	ADCSRA = 1 << ADEN | 1 << ADSC | 1 << ADATE | 1 << ADPS2; // | 1 << ADPS1 | 1 << ADPS0;
	ADCSRB = 0x00;
	DIDR0 = 0x03;
	unsigned char valor_ADC_str[tam];
	uint16_t valor_ADC = 0, novo_valor_ADC = 0;
	
	//Inicializa??o display modo 4-BITS
	inicia_display(&PORTB);
	uint8_t freq = 0;
	uint8_t modo = 1;
	PORTB |= 1 << PORTB6; // Acendo o led vermelho
	
	//int freq_port = 100;
	float freq_P = 0;
	float Ts = 0.0002;
	float t = 0;
	float c = 0;
	uint8_t offset = 127;
	uint8_t Ap = 127;
	uint8_t output = 0;
	float portadora = 0;
	
	int flag_m = 0; //vai para alto quando o botao m for pressionado
	int flag_p = 0; //vai para alto quando o botao p for pressionado
	int flag_r = 0; //vai para alto quando o botao r for pressionado
	
	int flag_AM = 0; //vai para alto quando o botao m for pressionado
	int flag_FM = 0; //vai para alto quando o botao p for pressionado
	int flag_ASK = 0; //vai para alto quando o botao r for pressionado
	int flag_FSK = 0; //vai para alto quando o botao r for pressionado
	limpa_cursor (&PORTB);
	while(1)
	{
		//ESTADO MODULACAO
		if((PINC & 1 << 4) |  flag_m == 1 ) // Se botao M foi pressionado
		{
			flag_m == 0;
			freq = 0;
			
			ADMUX |= 1 << MUX0;
			while(!(PINC & 1 << 3) && !(PINC & 1 << 2))
			{
				PORTB &= 0x3F; //Apaga os leds
				PORTB |= 1 << PORTB6; // Acendo o led vermelho
				ADCSRA |= 1 << ADSC;
				valor_ADC = ADC;
				
				while(!(PINC & 1 << 3) && !(PINC & 1 << 2) && (valor_ADC <= 255)) // ESCOLHA DO MODO AM
				{
					flag_AM = 1;
					flag_FM = 0;
					flag_ASK = 0;
					flag_FSK = 0;
					set_cell(&PORTB, 0);
					set_str(&PORTB, "Mod: AM  F:---Hz");
					//Posicionar-se na 2 lin 1 col
					pula_linha(&PORTB);
					set_str(&PORTB, "Msg:---         ");
					ADCSRA |= 1 << ADSC;
					valor_ADC = ADC;
					//Aciona a flag caso seja pressionado algum botao
					if(PINC & 1 << 3)
					flag_p = 1;
					else if(PINC & 1 << 2)
					flag_r = 1;
				}
				_delay_ms(5);
				ADCSRA |= 1 << ADSC;
				valor_ADC = ADC;
				
				while(!(PINC & 1 << 3) && !(PINC & 1 << 2) && (valor_ADC > 255 && valor_ADC <= 510 )) // ESCOLHA DO MODO FM
				{
					flag_AM = 0;
					flag_FM = 1;
					flag_ASK = 0;
					flag_FSK = 0;
					set_cell(&PORTB, 0);
					set_str(&PORTB, "Mod: FM  F:---Hz");
					//Posicionar-se na 2 lin 1 col
					pula_linha(&PORTB);
					set_str(&PORTB, "Msg:---         ");
					ADCSRA |= 1 << ADSC;
					valor_ADC = ADC;
					//Aciona a flag caso seja pressionado algum botao
					if(PINC & 1 << 3)
					flag_p = 1;
					else if(PINC & 1 << 2)
					flag_r = 1;
				}
				_delay_ms(5);
				ADCSRA |= 1 << ADSC;
				valor_ADC = ADC;
				
				while(!(PINC & 1 << 3) && !(PINC & 1 << 2) && (valor_ADC > 510 && valor_ADC <= 765 )) // ESCOLHA DO MODO ASK
				{
					flag_AM = 0;
					flag_FM = 0;
					flag_ASK = 1;
					flag_FSK = 0;
					set_cell(&PORTB, 0);
					set_str(&PORTB, "Mod: ASK T:---bs");
					//Posicionar-se na 2 lin 1 col
					pula_linha(&PORTB);
					set_str(&PORTB, "Msg: --.--.--.--");
					ADCSRA |= 1 << ADSC;
					valor_ADC = ADC;
					//Aciona a flag caso seja pressionado algum botao
					if(PINC & 1 << 3)
					flag_p = 1;
					else if(PINC & 1 << 2)
					flag_r = 1;
				}
				_delay_ms(5);
				ADCSRA |= 1 << ADSC;
				valor_ADC = ADC;
				
				while(!(PINC & 1 << 3) && !(PINC & 1 << 2) && (valor_ADC > 765)) // ESCOLHA DO MODO FSK
				{
					flag_AM = 0;
					flag_FM = 0;
					flag_ASK = 0;
					flag_FSK = 1;
					set_cell(&PORTB, 0);
					set_str(&PORTB, "Mod: FSK T:---bs");
					//Posicionar-se na 2 lin 1 col
					pula_linha(&PORTB);
					//PORTB = 1 << PB5;
					set_str(&PORTB, "Msg: --.--.--.--");
					ADCSRA |= 1 << ADSC;
					valor_ADC = ADC;
					//Aciona a flag caso seja pressionado algum botao
					if(PINC & 1 << 3)
					flag_p = 1;
					else if(PINC & 1 << 2)
					flag_r = 1;
				}
				_delay_ms(5);
				ADCSRA |= 1 << ADSC;
				valor_ADC = ADC;
			}
		} // END ESTADO MODULACAO
		
		//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//
		
		//ESTADO PORTADORA
		if((PINC & 1 << 3) |  flag_p == 1 ) // Se bot?o P foi pressionado
		{
			flag_p = 0;
			
			PORTB &= 0x3F; //Apaga os leds
			PORTB |= 1 << PORTB6; // Acendo o led vermelho
			
			while(!(PINC & 1 << 4) && !(PINC & 1 << 2))
			{
				while(!(PINC & 1 << 4) && !(PINC & 1 << 2) && (flag_AM == 1)) // ESCOLHA DA FREQ (AM)
				{
					if(!freq)
					{
						freq = 1;
						set_cell(&PORTB, 0);
						set_str(&PORTB, "Mod: AM  P:   Hz");
						//Posicionar-se na 2 lin 1 col
						pula_linha(&PORTB);
						set_str(&PORTB, "Msg:---");
						ADCSRA |= 1 << ADSC;
						valor_ADC = ADC;
						set_cell(&PORTB, 11);
						mapdec(&PORTB,valor_ADC, &freq_P);
					}
					else
					{
						ADCSRA |= 1 << ADSC;
						novo_valor_ADC = ADC;
						if(novo_valor_ADC != valor_ADC)
						{
							valor_ADC = novo_valor_ADC;
							set_cell(&PORTB, 11);
							mapdec(&PORTB,valor_ADC, &freq_P);
						}
					}
					//Aciona a flag caso seja pressionado algum botao
					if(PINC & 1 << 4)
					flag_m = 1;
					else if(PINC & 1 << 2)
					flag_r = 1;
				}_delay_ms(5);
				
				while(!(PINC & 1 << 4) && !(PINC & 1 << 2) && (flag_FM == 1)) // ESCOLHA DA FREQ (FM)
				{
					if(!freq)
					{
						freq = 1;
						set_cell(&PORTB, 0);
						set_str(&PORTB, "Mod: FM  P:   Hz");
						//Posicionar-se na 2 lin 1 col
						pula_linha(&PORTB);
						set_str(&PORTB, "Msg:---");
						ADCSRA |= 1 << ADSC;
						valor_ADC = ADC;
						set_cell(&PORTB, 11);
						mapdec(&PORTB,valor_ADC, &freq_P);
					}
					else
					{
						ADCSRA |= 1 << ADSC;
						novo_valor_ADC = ADC;
						if(novo_valor_ADC != valor_ADC)
						{
							valor_ADC = novo_valor_ADC;
							set_cell(&PORTB, 11);
							mapdec(&PORTB,valor_ADC, &freq_P);
						}
					}
					//Aciona a flag caso seja pressionado algum botao
					if(PINC & 1 << 4)
					flag_m = 1;
					else if(PINC & 1 << 2)
					flag_r = 1;
				}_delay_ms(5);
				
				while(!(PINC & 1 << 4) && !(PINC & 1 << 2) && (flag_ASK == 1)) // ESCOLHA DA FREQ (ASK)
				{
					if(!freq)
					{
						freq = 1;
						set_cell(&PORTB, 0);
						set_str(&PORTB, "Mod: ASK P:   Hz");
						//Posicionar-se na 2 lin 1 col
						pula_linha(&PORTB);
						set_str(&PORTB, "Msg: --.--.--.--");
						ADCSRA |= 1 << ADSC;
						valor_ADC = ADC;
						set_cell(&PORTB, 11);
						mapdec(&PORTB,valor_ADC, &freq_P);
					}
					else
					{
						ADCSRA |= 1 << ADSC;
						novo_valor_ADC = ADC;
						if(novo_valor_ADC != valor_ADC)
						{
							valor_ADC = novo_valor_ADC;
							set_cell(&PORTB, 11);
							mapdec(&PORTB,valor_ADC, &freq_P);
						}
					}
					//Aciona a flag caso seja pressionado algum botao
					if(PINC & 1 << 4)
					flag_m = 1;
					else if(PINC & 1 << 2)
					flag_r = 1;
				}_delay_ms(5);
				
				while(!(PINC & 1 << 4) && !(PINC & 1 << 2) && (flag_FSK == 1)) // ESCOLHA DA FREQ (FSK)
				{
					if(!freq)
					{
						freq = 1;
						set_cell(&PORTB, 0);
						set_str(&PORTB, "Mod: FSK P:   Hz");
						//Posicionar-se na 2 lin 1 col
						pula_linha(&PORTB);
						set_str(&PORTB, "Msg: --.--.--.--");
						ADCSRA |= 1 << ADSC;
						valor_ADC = ADC;
						set_cell(&PORTB, 11);
						mapdec(&PORTB,valor_ADC, &freq_P);
					}
					else
					{
						ADCSRA |= 1 << ADSC;
						novo_valor_ADC = ADC;
						if(novo_valor_ADC != valor_ADC)
						{
							valor_ADC = novo_valor_ADC;
							set_cell(&PORTB, 11);
							mapdec(&PORTB,valor_ADC, &freq_P);
						}
					}
					//Aciona a flag caso seja pressionado algum botao
					if(PINC & 1 << 4)
					flag_m = 1;
					else if(PINC & 1 << 2)
					flag_r = 1;
				}_delay_ms(5);
			}
		}
		// END ESTADO PORTADORA
		
		//MODULAÇÃO
		if(flag_AM || flag_FM || flag_ASK || flag_FSK)
		{
			if(ADMUX & 1){ // Se estiver lendo o potenciometro, troca para o sinal
				ADMUX ^= 1;
			}
			ADCSRA |= 1 << ADSC;
			valor_ADC = ADC;
			valor_ADC /= 4;
			if(flag_AM)
			{
				portadora = cos(2*M_PI*freq_P*t);
				output = (0.5*valor_ADC)*portadora + offset;
			}
			else if(flag_FM)
			{
				output = Ap * cos(2 * M_PI * t * (freq_P + valor_ADC)) + offset;
			}
			else if(flag_ASK)
			{
				portadora = cos(2 * M_PI * freq_P * t);
				output = (0.5 * valor_ADC) * portadora + offset;
			}
			else if(flag_FSK)
			{
				for(unsigned i=0 ; i<8 ; i++){
					if(valor_ADC & 1 << i){
						output =  Ap *cos(4 * M_PI * t * freq_P) + offset;
					}
					else{
						output =  Ap * cos(2 * M_PI * t * freq_P) + offset;
					}
				}
			}
			PORTD = output;
			PORTB &= 0x3F; // Apaga os leds
			PORTB |= 1 << PORTB7; // Acendo o led azul
			c = freq_P * t;
			t += Ts;
			if(c >= 1)
			{
				t = 0;
			}
			 			if(flag_AM || flag_FM)
			 			{
			 				val_decimal(&PORTB, output);
			 			}
			 			else if(flag_ASK || flag_FSK)
			 			{
			 				val_binario(&PORTB, output);
			 			}

		} // FIM DA MODULAÇÃO
	} // END WHILE (1)
} // END INT MAIN