/*******************************************************************************
 * GCC Linker script for STM32F103x8
 * Copyright (C) 2023-2024 Xu Ruijun
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

ENTRY( Reset_Handler )
PROVIDE( _stack_size = 2048 );


MEMORY
{
  FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 64K
  RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 20K
}

PROVIDE( _estack = ORIGIN(RAM) + LENGTH(RAM) );
PROVIDE( _stack_begin = _estack - _stack_size );

SECTIONS
{
  .isr_vectab :
  {
    . = ALIGN(4);
    KEEP(*(.isr_vector))
    . = ALIGN(4);
  } >FLASH

  PROVIDE( _program_begin = . );
  .text           :
  {
    *(.text.Reset_Handler) /*CPU上电后执行的第一条指令在0x00000000, Reset_Handler需要放在这里*/
    *(.vectab)             /*中断向量表每项只能放置一条跳转指令，跳转空间只有±2KB空间*/
    *(.text.*Handler)
    *(.text)
    *(.text.*)
  } >FLASH AT>FLASH

  .rodata         : /*只读数据*/
  {
    . = ALIGN(4);
    *(.rodata .rodata.*)
  } >FLASH AT>FLASH

  PROVIDE( _sidata = . );
  .data           : /*已初始化的变量*/
  {
    . = ALIGN(4);
    PROVIDE( _sdata = . );
    *(.data .data.*)
    PROVIDE( _edata = . );
  } >RAM AT>FLASH
  PROVIDE( _program_end = . - _data_begin_lma + data_begin_vma ); /*程序结束，FLASH此后可以写自定义数据*/

  .bss            : /*未初始化的变量*/
  {
    . = ALIGN(4);
    PROVIDE( _sbss = . );
    *(.sbss .sbss.*)
    *(.bss .bss.*)
    *(COMMON)
    PROVIDE( _ebss = . );
    ASSERT(( _ebss <= _stack_begin ), "Error: RAM no space");
  } >RAM
}

