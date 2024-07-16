@echo off
rem This file is generated from pull-mingw8.pbat, all edits will be lost
set PATH=C:\Miniconda3;C:\Miniconda3\Scripts;%USERPROFILE%\Miniconda3;%USERPROFILE%\Miniconda3\Scripts;C:\Program Files\7-Zip;%PATH%
pip install aqtinstall
aqt install-tool windows desktop tools_mingw qt.tools.win64_mingw810 -O C:\Qt
7z a -y mingw810_64.7z C:\Qt\Tools\mingw810_64