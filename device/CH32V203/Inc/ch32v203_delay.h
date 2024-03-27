#ifndef CH32V203_DELAY_H
#define CH32V203_DELAY_H

#include <stdint.h>

#ifdef __cplusplus
extern "C"{
#endif

void Delay_Init();
void Delay_us(uint32_t us);
void Delay_ms(uint32_t ms);

#ifdef __cplusplus
}
#endif

#endif
