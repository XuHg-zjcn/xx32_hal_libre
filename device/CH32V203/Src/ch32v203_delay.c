#include "stm32f1xx.h"
#include "ch32v203_delay.h"


extern uint32_t SystemCoreClock;
uint32_t SysTick_MHz;

void Delay_Init()
{
  SET_BIT(SysTick->CTRL, SysTick_CTRL_ENABLE_Msk);
  SysTick_MHz = SystemCoreClock/8000000;
}

void Delay_us(uint32_t us)
{
  uint64_t t = SysTick_GetCNT_Safe();
  t += SysTick_MHz*us;
  while(SysTick_GetCNT_Unsafe_Lesser() < t);
}

void Delay_ms(uint32_t ms)
{
  Delay_us(ms*1000);
}
