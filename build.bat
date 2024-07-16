@echo off
rem This file is generated from build.pbat, all edits will be lost
set PATH=C:\Miniconda3;C:\Miniconda3\Scripts;%USERPROFILE%\Miniconda3;%USERPROFILE%\Miniconda3\Scripts;C:\mysql-8.2.0-winx64\bin;C:\mysql-8.2.0-winx64\lib;C:\Program Files\7-Zip;C:\Qt\Tools\mingw810_64\bin;C:\Qt\5.15.2\mingw81_64\bin;%PATH%
if exist "C:\Program Files\Git\mingw32\bin\curl.exe" set CURL=C:\Program Files\Git\mingw32\bin\curl.exe
if exist "C:\Program Files\Git\mingw64\bin\curl.exe" set CURL=C:\Program Files\Git\mingw64\bin\curl.exe
if exist "C:\Windows\System32\curl.exe" set CURL=C:\Windows\System32\curl.exe
if not defined CURL (
echo CURL not found
exit /b
)
if exist C:\Qt\5.15.2\mingw81_64\bin\qmake.exe goto toolchain_end
pip install aqtinstall
aqt install-qt windows desktop 5.15.2 win64_mingw81 -O C:\Qt
aqt install-tool windows desktop tools_mingw qt.tools.win64_mingw810 -O C:\Qt
:toolchain_end
7z a -y Qt-5.15.2-mingw81_64.zip C:\Qt\5.15.2\mingw81_64