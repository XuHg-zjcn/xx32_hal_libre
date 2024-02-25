#!/usr/bin/python3
#############################################################################
'''创建新工程，链接或复制文件'''
# Copyright (C) 2022-2024  Xu Ruijun
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#############################################################################
import os
import shutil


def listdir_onlydir(path):
    lst = os.listdir(path)
    return filter(lambda x:os.path.isdir(os.path.join(path, x)), lst)

def listdir_onlyfile(path):
    lst = os.listdir(path)
    return filter(lambda x:os.path.isfile(os.path.join(path, x)), lst)

class NewProject:
    def __init__(self):
        self.dst_root = None
        self.model = None
        #源根目录
        self.src_root = os.getcwd()
        if os.path.basename(self.src_root) == 'tools':
            self.src_root = os.path.dirname(self.src_root)

    def input_model(self):
        supports = set(listdir_onlydir(os.path.join(self.src_root, 'device')))
        model = input('请输入型号:').upper()
        if model in supports:
            self.model = model
            return 0
        else:
            print('不支持该型号，支持列表：')
            print('\n'.join(supports))
            return -1

    def input_dir(self):
        """
        retval: 0正常退出，-1需要再试，1错误
        """
        d = input('请输入工程目录:')
        absd = os.path.abspath(d)
        if os.path.samefile(os.path.commonpath([absd, self.src_root]), self.src_root):
            while True:
                s = input('目标文件夹在源目录下，是否继续 确认(y), 取消(n):')
                if s == 'y':
                    break
                elif s == 'n':
                    return 1
        elif not os.path.exists(d):
            os.mkdir(d)
        elif not os.path.isdir(d):
            print('目标存在但不是文件夹')
            return -1
        elif len(os.listdir(d)) != 0:
            while True:
                s = input('目标文件夹非空，是否继续 确认(y), 取消(n), 列出(l):')
                if s == 'y':
                    break
                elif s == 'n':
                    return 1
                elif s == 'l':
                    os.system(f'ls {d} --color=auto -CF')
        self.dst_root = d
        return 0

    def input_info_loop(self):
        while True:
            r = self.input_model()
            if r > 0:
                return 1
            elif r == 0:
                break
        while True:
            r = self.input_dir()
            if r > 0:
                return 1
            elif r == 0:
                break
        return 0

    def lns_cp(self):
        def src_(*args):
            return os.path.join(self.src_root, *args)
        def dst_(*args):
           return os.path.join(self.dst_root, *args)
        device_path = os.path.join(self.src_root, 'device', self.model)
        os.symlink(src_("common"), dst_("common"))
        os.symlink(src_(device_path), dst_(self.model))
        os.symlink(src_(os.path.join(device_path, 'Makefile')), dst_('Makefile'))
        shutil.copytree(src_(os.path.join(device_path, 'User')), dst_('User'))


if __name__ == '__main__':
    prj = NewProject()
    r = prj.input_info_loop()
    if r > 0:
        exit()
    prj.lns_cp()
