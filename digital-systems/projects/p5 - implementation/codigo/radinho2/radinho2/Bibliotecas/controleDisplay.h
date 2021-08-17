/*
 * controleDisplay.h
 *
 * Created: 12/08/2021 23:11:05
 *  Author: Lucas Augusto e Albertho Síziney
 */ 

#ifndef CONTROLEDISPLAY_H_
#define CONTROLEDISPLAY_H_

#define F_CPU 8000000UL
#define tam 3
#include <avr/io.h>
#include <util/delay.h>
#include <math.h>


void en_up_down(uint8_t *Port);
void inicia_display(uint8_t *Port);
void set_display(uint8_t *Port, unsigned char val);
void pula_linha(uint8_t *Port);
void limpa_lcd(uint8_t *Port);
void set_str(uint8_t *Port, unsigned char *str);
void converte_int_str(uint16_t valor_ADC, unsigned char *str);
void set_cell(uint8_t *Port,  unsigned int val);
void val_binario(uint8_t *Port, uint8_t val);
void val_decimal(uint8_t *Port, uint8_t val);
void limpa_cursor (uint8_t *Port);
void mapdec(uint8_t *Port, uint16_t valor_ADC, float *freq_P);
void set_freq(uint8_t *Port, unsigned char *str);
#endif /* CONTROLEDISPLAY_H_ */