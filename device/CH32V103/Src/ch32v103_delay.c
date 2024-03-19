#include "stm32f1xx.h"
#include "ch32v103_delay.h"


extern uint32_t SystemCoreClock;
uint32_t SysTick_MHz;

void Delay_Init()
{
  SET_BIT(SysTick->CTLR, SysTick_CTLR_ENABLE_Msk);
}


void Delay_us(uint32_t us)
{
  
}
