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
aqt install-tool windows desktop tools_qtcreator qt.tools.qtcreator -O C:\Qt
aqt install-tool windows desktop tools_mingw qt.tools.win64_mingw810 -O C:\Qt
:toolchain_end
if exist C:\mysql-8.2.0-winx64\bin\mysql.exe goto mysql820_end
pushd %~dp0
    if not exist mysql-8.2.0-winx64.zip "%CURL%" -L -o mysql-8.2.0-winx64.zip https://cdn.mysql.com/Downloads/MySQL-8.2/mysql-8.2.0-winx64.zip
    7z x -y -oC:\ mysql-8.2.0-winx64.zip
popd
:mysql820_end
if not exist qtbase-everywhere-src-5.15.2.zip "%CURL%" -L -o qtbase-everywhere-src-5.15.2.zip https://download.qt.io/official_releases/qt/5.15/5.15.2/submodules/qtbase-everywhere-src-5.15.2.zip
if not exist qtbase-everywhere-src-5.15.2 7z x -y qtbase-everywhere-src-5.15.2.zip
pushd qtbase-everywhere-src-5.15.2\src\plugins\sqldrivers
    qmake -- MYSQL_INCDIR="C:/mysql-8.2.0-winx64/include" MYSQL_LIBDIR="C:/mysql-8.2.0-winx64/lib"
    pushd mysql
        mingw32-make -j4
        mingw32-make install
    popd 
    copy /y C:\mysql-8.0.33-winx64\bin\libmysql.dll C:\Qt\5.15.2\mingw81_64\bin
    copy /y C:\mysql-8.0.33-winx64\bin\libssl-1_1-x64.dll C:\Qt\5.15.2\mingw81_64\bin
    copy /y C:\mysql-8.0.33-winx64\bin\libcrypto-1_1-x64.dll C:\Qt\5.15.2\mingw81_64\bin
popd
7z a -y Qt-5.15.2.zip C:\Qt\5.15.2
7z a -y QtCreator.zip C:\Qt\Tools\QtCreator
7z a -y mingw810_64.zip C:\Qt\Tools\mingw810_64