#ifndef CH32V103_DELAY_H
#define CH32V103_DELAY_H

#include <stdint.h>

void Delay_Init();
void Delay_us(uint32_t us);
void Delay_ms(uint32_t ms);

#endif
