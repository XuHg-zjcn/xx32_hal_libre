#############################################################################
# 工具链配置文件
# Copyright (C) 2021-2023  Xu Ruijun
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#############################################################################

#请看README.md如何安装和使用
TOOL_CHAIN = arm-none-eabi-

OPENOCD = openocd
OCD_CFG =

STLINK = st-flash
STM32FLASH = stm32flash

#MCU操作(擦除,烧录,验证,复位等)的方式
MCU_OP = stm32flash

VERBOSE ?= YES

#输出文件目录
OBJODIR = obj
TARGET = obj/target
