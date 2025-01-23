/*******************************************************************************
 * Startup file for CH32V203
 * Copyright (C) 2023 Xu Ruijun
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its contributors
 * may be used to endorse or promote products derived from this software without
 * specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
 * THE POSSIBILITY OF SUCH DAMAGE.
 ******************************************************************************/

        .section	.text.Reset_Handler
        .weak		Reset_Handler
        .align  2
Reset_Handler:
// Set global pointer
.option push
.option norelax
	lui gp, %hi(__global_pointer$)
	addi gp, gp, %lo(__global_pointer$)
.option pop

// Set stack pointer
	lui sp, %hi(_stack_end)
	addi sp, sp, %lo(_stack_end)


CopyData_Init:
	la a0, _data_begin_vma       //begin address of .data/.sdata in FLASH
	lui a1, %hi(_data_begin_lma)   //begin address of .data/.sdata in RAM
	addi a1, a1, %lo(_data_begin_lma)
	lui a2, %hi(_data_end_lma)     //end address of .data/.sdata in RAM
	addi a2, a2, %lo(_data_end_lma)
	bgeu a1, a2, FillBSS_Init
CopyData_Loop:
	lw a3, (a0)
	sw a3, (a1)
	addi a0, a0, 4
	addi a1, a1, 4
	bltu a1, a2, CopyData_Loop

// Fill .bss and .sbss to zeros
FillBSS_Init:
	lui a1, %hi(_bss_begin)
	addi a1, a1, %lo(_bss_begin)
	lui a2, %hi(_bss_end)
	addi a2, a2, %lo(_bss_end)
	bgeu a1, a2, VecTab_Init
FillBSS_Loop:
	sw zero, (a1)
	addi a1, a1, 4
	bltu a1, a2, FillBSS_Loop

VecTab_Init:
	la a0, vectab
	ori a0, a0, 1
	csrw mtvec, a0
	li a0, 0x1888
	csrs mstatus, a0 //将mstatus寄存器的MIE和MPIE置位
	//li a0, 0x01
	//csrs 0x804, a0 //开启硬件压栈

Entry:
	//Init clocks and other system config
	jal SystemInit

	//Exit Reset_Handler entry main
        la t0, main
        csrw mepc, t0
	mret

	.section .vectab,"ax",%progbits
	.align  4
vectab:
.option rvc	//Disallow Compress Instruction in the table
	j	Reset_Handler
	j	Reset_Handler
	j	NMI_Handler
	j	HardFault_Handler
	j	Default_Handler
	j	ECall_M_Handler
	j	Default_Handler
	j	Default_Handler
	j	ECall_U_Handler
	j	Breakpoint_Handler
	j	Default_Handler
	j	Default_Handler
	j	SysTick_Handler
	j	Default_Handler
	j	SWI_Handler
	j	Default_Handler
	j	WWDG_IRQHandler
	j	PVD_IRQHandler
	j	TAMPER_IRQHandler
	j	RTC_IRQHandler
	j	FLASH_IRQHandler
	j	RCC_IRQHandler
	j	EXTI0_IRQHandler
	j	EXTI1_IRQHandler
	j	EXTI2_IRQHandler
	j	EXTI3_IRQHandler
	j	EXTI4_IRQHandler
	j	DMA1_Channel1_IRQHandler
	j	DMA1_Channel2_IRQHandler
	j	DMA1_Channel3_IRQHandler
	j	DMA1_Channel4_IRQHandler
	j	DMA1_Channel5_IRQHandler
	j	DMA1_Channel6_IRQHandler
	j	DMA1_Channel7_IRQHandler
	j	ADC1_2_IRQHandler
	j	Default_Handler	//USB_HP_CAN1_TX_IRQHandler	//CH32V103 has no CAN, USB IRQ are USBHD_IRQHandler
	j	Default_Handler	//USB_LP_CAN1_RX0_IRQHandler	//CH32V103 has no CAN, USB IRQ are USBHD_IRQHandler
	j	Default_Handler //CAN1_RX1_IRQHandler		//CH32V103 has no CAN
	j	Default_Handler //CAN1_SCE_IRQHandler		//CH32V103 has no CAN
	j	EXTI9_5_IRQHandler
	j	TIM1_BRK_IRQHandler
	j	TIM1_UP_IRQHandler
	j	TIM1_TRG_COM_IRQHandler
	j	TIM1_CC_IRQHandler
	j	TIM2_IRQHandler
	j	TIM3_IRQHandler
	j	TIM4_IRQHandler
	j	I2C1_EV_IRQHandler
	j	I2C1_ER_IRQHandler
	j	I2C2_EV_IRQHandler
	j	I2C2_ER_IRQHandler
	j	SPI1_IRQHandler
	j	SPI2_IRQHandler
	j	USART1_IRQHandler
	j	USART2_IRQHandler
	j	USART3_IRQHandler
	j	EXTI15_10_IRQHandler
	j	RTC_Alarm_IRQHandler
	j	USBWakeUp_IRQHandler
	j	USBHD_IRQHandler
.option rvc	//Allow Compress Instruction After

	.section	.text.Default_Handler
	.weak		Default_Handler
	.align  	2
	.weak	NMI_Handler
	.weak	HardFault_Handler
	.weak	ECall_M_Handler
	.weak	ECall_U_Handler
	.weak	Breakpoint_Handler
	.weak	SysTick_Handler
	.weak	SWI_Handler
	.weak	WWDG_IRQHandler
	.weak	PVD_IRQHandler
	.weak	TAMPER_IRQHandler
	.weak	RTC_IRQHandler
	.weak	FLASH_IRQHandler
	.weak	RCC_IRQHandler
	.weak	EXTI0_IRQHandler
	.weak	EXTI1_IRQHandler
	.weak	EXTI2_IRQHandler
	.weak	EXTI3_IRQHandler
	.weak	EXTI4_IRQHandler
	.weak	DMA1_Channel1_IRQHandler
	.weak	DMA1_Channel2_IRQHandler
	.weak	DMA1_Channel3_IRQHandler
	.weak	DMA1_Channel4_IRQHandler
	.weak	DMA1_Channel5_IRQHandler
	.weak	DMA1_Channel6_IRQHandler
	.weak	DMA1_Channel7_IRQHandler
	.weak	ADC1_2_IRQHandler
	.weak	EXTI9_5_IRQHandler
	.weak	TIM1_BRK_IRQHandler
	.weak	TIM1_UP_IRQHandler
	.weak	TIM1_TRG_COM_IRQHandler
	.weak	TIM1_CC_IRQHandler
	.weak	TIM2_IRQHandler
	.weak	TIM3_IRQHandler
	.weak	TIM4_IRQHandler
	.weak	I2C1_EV_IRQHandler
	.weak	I2C1_ER_IRQHandler
	.weak	I2C2_EV_IRQHandler
	.weak	I2C2_ER_IRQHandler
	.weak	SPI1_IRQHandler
	.weak	SPI2_IRQHandler
	.weak	USART1_IRQHandler
	.weak	USART2_IRQHandler
	.weak	USART3_IRQHandler
	.weak	EXTI15_10_IRQHandler
	.weak	RTC_Alarm_IRQHandler
	.weak	USBWakeUp_IRQHandler
	.weak	USBHD_IRQHandler

NMI_Handler:
HardFault_Handler:
ECall_M_Handler:
ECall_U_Handler:
Breakpoint_Handler:
SysTick_Handler:
SWI_Handler:
WWDG_IRQHandler:
PVD_IRQHandler:
TAMPER_IRQHandler:
RTC_IRQHandler:
FLASH_IRQHandler:
RCC_IRQHandler:
EXTI0_IRQHandler:
EXTI1_IRQHandler:
EXTI2_IRQHandler:
EXTI3_IRQHandler:
EXTI4_IRQHandler:
DMA1_Channel1_IRQHandler:
DMA1_Channel2_IRQHandler:
DMA1_Channel3_IRQHandler:
DMA1_Channel4_IRQHandler:
DMA1_Channel5_IRQHandler:
DMA1_Channel6_IRQHandler:
DMA1_Channel7_IRQHandler:
ADC1_2_IRQHandler:
EXTI9_5_IRQHandler:
TIM1_BRK_IRQHandler:
TIM1_UP_IRQHandler:
TIM1_TRG_COM_IRQHandler:
TIM1_CC_IRQHandler:
TIM2_IRQHandler:
TIM3_IRQHandler:
TIM4_IRQHandler:
I2C1_EV_IRQHandler:
I2C1_ER_IRQHandler:
I2C2_EV_IRQHandler:
I2C2_ER_IRQHandler:
SPI1_IRQHandler:
SPI2_IRQHandler:
USART1_IRQHandler:
USART2_IRQHandler:
USART3_IRQHandler:
EXTI15_10_IRQHandler:
RTC_Alarm_IRQHandler:
USBWakeUp_IRQHandler:
USBHD_IRQHandler:

Default_Handler:
	j	Default_Handler
