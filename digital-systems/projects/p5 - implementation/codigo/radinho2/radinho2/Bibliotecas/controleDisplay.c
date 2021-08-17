/*
 * controleDisplay.c
 *
 * Created: 12/08/2021 23:10:34
 *  Author: Lucas Augusto e Albertho Síziney
 */ 

#include "controleDisplay.h"

void pula_linha(uint8_t *Port)
{
//Nible Mais Signf.
*Port |= 0x0C; //(1100)
en_up_down(Port);
//Nible Menos Signf.
*Port ^= 0x0C; //(0000)
en_up_down(Port);
}

void limpa_lcd(uint8_t *Port)
{
uint8_t copia = *Port;
//Nible Mais Signf.
*Port = 0x00; //(0000)
en_up_down(Port);
//Nible Menos Signf.
*Port = 0x01; //(0001)
en_up_down(Port);
*Port = copia;
}

void en_up_down(uint8_t *Port){
_delay_ms(5);
*Port |= 0x10;
_delay_ms(5);
*Port ^= 0x10;
_delay_ms(5);
}

void inicia_display(uint8_t *Port)
{
uint8_t copia = *Port;
//ENVIAR 2 VEZES A INFORMA??O (0010) POIS ELE INICIALIZA NO MODO 8-BITS
//Nible Mais Signf.
*Port = 0b00000010; //(0010)
en_up_down(&PORTB);
//Nible Menos Signf.
*Port = 0b00000010; //(0010)
en_up_down(&PORTB);
*Port = 0b00001000; //(1000)
en_up_down(&PORTB);

//Liga LCD e cursor
//Nible Mais Signf.
*Port = 0b00000000; //(0000)
en_up_down(&PORTB);
//Nible Menos Signf.
*Port = 0b00001110; //(1110)
en_up_down(&PORTB);

//Habilita incremento
//Nible Mais Signf.
*Port = 0b00000000; //(0000)
en_up_down(&PORTB);
//Nible Menos Signf.
*Port = 0b00000110; //(0110)
en_up_down(&PORTB);
*Port = copia;
}

void set_display(uint8_t *Port, unsigned char val)
{
uint8_t simbol = 0x00;
switch(val)
{
case '0':
simbol = 0x30;
break;
case '1':
simbol = 0x31;
break;
case '2':
simbol = 0x32;
break;
case '3':
simbol = 0x33;
break;
case '4':
simbol = 0x34;
break;
case '5':
simbol = 0x35;
break;
case '6':
simbol = 0x36;
break;
case '7':
simbol = 0x37;
break;
case '8':
simbol = 0x38;
break;
case '9':
simbol = 0x39;
break;
case ':':
simbol = 0x3A;
break;
case '-':
simbol = 0x2D;
break;
case '.':
simbol = 0x2E;
break;
case 'A':
simbol = 0x41;
break;
case 'F':
simbol = 0x46;
break;
case 'H':
simbol = 0x48;
break;
case 'K':
simbol = 0x4B;
break;
case 'M':
simbol = 0x4D;
break;
case 'P':
simbol = 0x50;
break;
case 'S':
simbol = 0x53;
break;
case 'T':
simbol = 0x54;
break;
case 'b':
simbol = 0x62;
break;
case 'd':
simbol = 0x64;
break;
case 'g':
simbol = 0x67;
break;
case 'o':
simbol = 0x6F;
break;
case 's':
simbol = 0x73;
break;
case 'z':
simbol = 0x7A;
break;
case ' ':
simbol = 0x20;
break;
}
*Port |= 1 << PORTB5;
*Port |= simbol >> 4;
en_up_down(Port);
*Port ^= simbol >> 4;
*Port |= (simbol & 0x0F);
en_up_down(Port);
*Port ^= (simbol & 0x0F);
*Port ^= 1 << PORTB5;
}

void set_freq(uint8_t *Port, unsigned char *str)
{
int i = 0;
while(i<tam)
{
set_display(Port, *str++);
i++;
}
}

void set_str(uint8_t *Port, unsigned char *str)
{

while(*str)
{
set_display(Port, *str++);
}
}

void set_cell(uint8_t *Port,  unsigned int val){
//DEFINE A C?LULA DO DISPLAY A SER ESCRITA
uint8_t simbol = 0x00;
switch(val)
{
case 0:
simbol = 0x80;
break;
case 1:
simbol = 81;
break;
case 2:
simbol = 82;
break;
case 3:
simbol = 83;
break;
case 4:
simbol = 84;
break;
case 5:
simbol = 85;
break;
case 6:
simbol = 86;
break;
case 7:
simbol = 87;
break;
case 8:
simbol = 88;
break;
case 9:
simbol = 89;
break;
case 10:
simbol = 0x8A;
break;
case 11:
simbol = 0x8B;
break;
case 12:
simbol = 0x8C;
break;
case 13:
simbol = 0x8D;
break;
case 14:
simbol = 0x8E;
break;
case 15:
simbol = 0x8F;
break;
case 16:
simbol = 0xC0;
break;
case 17:
simbol = 0xC1;
break;
case 18:
simbol = 0xC2;
break;
case 19:
simbol = 0xC3;
break;
case 20:
simbol = 0xC4;
break;
case 21:
simbol = 0xC5;
break;
case 22:
simbol = 0xC6;
break;
case 23:
simbol = 0xC7;
break;
case 24:
simbol = 0xC8;
break;
case 25:
simbol = 0xC9;
break;
case 26:
simbol = 0xCA;
break;
case 27:
simbol = 0xCB;
break;
case 28:
simbol = 0xCC;
break;
case 29:
simbol = 0xCD;
break;
case 30:
simbol = 0xCE;
break;
case 31:
simbol = 0xCF;
break;
}
*Port &= 0xDF;
*Port |= simbol >> 4;
en_up_down(Port);
*Port ^= simbol >> 4;
*Port |= (simbol & 0x0F);
en_up_down(Port);
*Port ^= (simbol & 0x0F);
}

void converte_int_str(uint16_t valor_ADC, unsigned char *str)
{
for(uint8_t i = 0; i < tam; i++)
str[i] = 0 + 48;
str += tam-1;
do
{
*str += valor_ADC % 10;
valor_ADC /= 10;
str--;
} while (valor_ADC != 0);
}

void val_decimal(uint8_t *Port, uint8_t val)
{
unsigned char valor_ADC_str[tam];
converte_int_str(val, &valor_ADC_str);
set_cell(Port, 20);
set_str(Port, valor_ADC_str);
}

void val_binario(uint8_t *Port, uint8_t val)
{
uint16_t i;
set_cell(Port, 21);
for(i = 8; i > 0; i--)
{

if(val & 1 << i-1)
set_display(Port, '1');
else
set_display(Port, '0');
if(i % 2 != 0 && i != 1)
set_display(Port, '.');
}
}

void limpa_cursor (uint8_t *Port){
//Nible Mais Signf.
*Port &= 0xF0; //(0000)
en_up_down(Port);
//Nible Menos Signf.
*Port |= 0x0C; //(1100)
en_up_down(Port);
*Port ^= 0x0C;
}

void mapdec(uint8_t *Port, uint16_t valor_ADC, float *freq_P)
{
unsigned char aux_saida[tam];
unsigned char saida[tam];
float aux_adc=0;

aux_adc = ((((float)valor_ADC/ 1023)* 899) + 100);
*freq_P = aux_adc;
converte_int_str(*freq_P, &saida);
set_freq(Port, saida);
}