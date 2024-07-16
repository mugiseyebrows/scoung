@echo off
rem This file is generated from dev.pbat, all edits will be lost
pushd %~dp0
set PATH=%CD%\mingw32\bin;%CD%\Qt-4.8.7\bin;%CD%\mysql-5.5.62-win32\lib;C:\windows\system32;C:\windows
if exist "C:\qt\qtcreator-2.8.1\bin\qtcreator.exe" set QTCREATOR=C:\qt\qtcreator-2.8.1\bin\qtcreator.exe
if not defined QTCREATOR (
echo QTCREATOR not found
exit /b
)
"%QTCREATOR%"
popd