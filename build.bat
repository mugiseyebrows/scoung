@echo off
rem This file is generated from build.pbat, all edits will be lost
if exist "C:\Program Files\Git\usr\bin\patch.exe" set PATCH=C:\Program Files\Git\usr\bin\patch.exe
if not defined PATCH (
echo PATCH not found
exit /b
)
if exist "C:\Program Files\7-Zip\7z.exe" set P7Z=C:\Program Files\7-Zip\7z.exe
if not defined P7Z (
echo P7Z not found
exit /b
)
if exist "C:\Program Files\Git\mingw64\bin\curl.exe" set CURL=C:\Program Files\Git\mingw64\bin\curl.exe
if exist "C:\Windows\System32\curl.exe" set CURL=C:\Windows\System32\curl.exe
if not defined CURL (
echo CURL not found
exit /b
)
pushd %~dp0
set PATH=%CD%\mingw\bin;C:\Strawberry\perl\bin;C:\windows\system32;C:\windows
if not exist mingw-get-0.6.2-mingw32-beta-20131004-1-bin.zip "%CURL%" -L -o mingw-get-0.6.2-mingw32-beta-20131004-1-bin.zip https://netix.dl.sourceforge.net/project/mingw/Installer/mingw-get/mingw-get-0.6.2-beta-20131004-1/mingw-get-0.6.2-mingw32-beta-20131004-1-bin.zip
if not exist mingw\bin\mingw-get.exe "%P7Z%" x -y -omingw mingw-get-0.6.2-mingw32-beta-20131004-1-bin.zip
mingw-get.exe install mingw32-make "gcc-c++=4.6.2-1"
g++ -v
if exist "C:\Strawberry\perl\bin\perl.exe" set PERL=C:\Strawberry\perl\bin\perl.exe
if not defined PERL (
echo PERL not found
exit /b
)
if exist "%CD%\mingw\bin\gcc.exe" set MINGW=%CD%\mingw\bin\gcc.exe
if not defined MINGW (
echo MINGW not found
exit /b
)
if not exist "qt-everywhere-opensource-src-4.8.7.zip" "%CURL%" -L -o "qt-everywhere-opensource-src-4.8.7.zip" "https://download.qt.io/archive/qt/4.8/4.8.7/qt-everywhere-opensource-src-4.8.7.zip"
if not exist "qt-everywhere-opensource-src-4.8.7" "%P7Z%" x -y "qt-everywhere-opensource-src-4.8.7.zip"
pushd qt-everywhere-opensource-src-4.8.7
"%PATCH%" -N -p1 -i ..\0001-include-winerror.h.patch
call configure -prefix %CD%\..\Qt-4.8.7 -opensource -confirm-license -shared -platform win32-g++ -opengl desktop -debug-and-release -nomake tests -nomake examples
mingw32-make
popd
popd


