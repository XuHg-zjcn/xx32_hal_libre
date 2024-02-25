# STM32F1 HAL库移植到CH32V103
本文件夹从[STM32CubeF1的github仓库](https://github.com/STMicroelectronics/STM32CubeF1)的master分支commit 653375685428df9478b396c02e50e62f50f9067d复制部分内容(已复制内容与v1.8.5相同)

## 已删除的文件(夹)
### 无用内容
- CMSIS/ARM.CMSIS.pdsc
- CMSIS/Core_A/ (Cortex-A驱动，无用)
- CMSIS/Include/ (与CMSIS/Core/Include文件夹内容相同)
- CMSIS/Lib/ (用于ARM架构的二进制库，RISC-V架构无法使用)
- CMSIS/Device/ST/STM32F1xx/Source/Templates/arm/ (不支持的编译器)
- CMSIS/Device/ST/STM32F1xx/Source/Templates/gcc/linker/ (非自由，文件头部标有不允许分发)
- CMSIS/Device/ST/STM32F1xx/Source/Templates/iar/ (不支持的编译器)
### 暂时无用
- CMSIS/DSP/
- CMSIS/NN/
- CMSIS/RTOS/
- CMSIS/RTOS2/
### 没有许可证的文档
- CMSIS/docs/
- CMSIS/README.md
- CMSIS/Device/ST/STM32F1xx/_htmresc/
- CMSIS/Device/ST/STM32F1xx/Release_Notes.html
- CMSIS/Device/ST/STM32F1xx/README.md
- STM32F1xx_HAL_Driver/_htmresc/
- STM32F1xx_HAL_Driver/README.md
- STM32F1xx_HAL_Driver/Release_Notes.html
### 会导致编译或链接错误
- STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_cortex.c
- STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_timebase_rtc_alarm_template.c
### 已修改文件
- CMSIS/Core/Include/cmsis_gcc.h (修改内链汇编)
- Drivers/CMSIS/Core/Include/core_cm3.h (注释掉导致编译出错的代码)
- Drivers/CMSIS/Device/ST/STM32F1xx/Include/stm32f1xx.h (适配CH32V)
---

本README.md文件使用以下许可证
```
Copyright (C) 2023-2024 Xu Ruijun

Copying and distribution of this README file, with or without modification,
are permitted in any medium without royalty provided the copyright
notice and this notice are preserved.  This file is offered as-is,
without any warranty.
```
