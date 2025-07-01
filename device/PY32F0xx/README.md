此模板工程复制来源于
https://github.com/OpenPuya/PY32F0xx_Firmware

删除了原有MDK和IAR有关文件
- Drivers/CMSIS/Device/PY32F0xx/Source/arm/
- Drivers/CMSIS/Device/PY32F0xx/Source/iar/

复制GCC相关文件
- Drivers/CMSIS/Device/PY32F0xx/Source/gcc （从Projects例程的EIDE工程中复制）
- Drivers/CMSIS/Device/PY32F0xx/Source/system_py32f0xx.c（从Projects/PY32F003-STK/Example复制，这个文件含GCC驱动）
- Templates/\*/Src/system_py32f0xx.c （同上）

删除了Cortex内核公共文件
- Drivers/CMSIS/DSP_Lib

删除了一些未测试的模板工程
- Templates文件夹下只保留了PY32F003x8的模板工程
