@echo off
rem This file is generated from build.pbat, all edits will be lost
set PATH=C:\Program Files\7-Zip;C:\mingw540_32\bin;C:\Qt\4.8.7\mingw540_32\bin;C:\mysql-5.5.62-win32\lib;C:\mysql-5.5.62-win32\bin;C:\OpenSSL\bin;C:\Strawberry\perl\bin;C:\Miniconda3;C:\Miniconda3\Scripts;%USERPROFILE%\Miniconda3;%USERPROFILE%\Miniconda3\Scripts;%PATH%
if exist "C:\Program Files\Git\usr\bin\patch.exe" set PATCH=C:\Program Files\Git\usr\bin\patch.exe
if not defined PATCH (
echo PATCH not found
exit /b
)
if exist "C:\Program Files\Git\mingw32\bin\curl.exe" set CURL=C:\Program Files\Git\mingw32\bin\curl.exe
if exist "C:\Program Files\Git\mingw64\bin\curl.exe" set CURL=C:\Program Files\Git\mingw64\bin\curl.exe
if exist "C:\Windows\System32\curl.exe" set CURL=C:\Windows\System32\curl.exe
if not defined CURL (
echo CURL not found
exit /b
)
if exist C:\mingw540_32\bin\gcc.exe goto mingw_end
if not exist i686-5.4.0-release-win32-dwarf-rt_v5-rev0.7z "%CURL%" -L -o i686-5.4.0-release-win32-dwarf-rt_v5-rev0.7z "https://netix.dl.sourceforge.net/project/mingw-w64/Toolchains%%20targetting%%20Win32/Personal%%20Builds/mingw-builds/5.4.0/threads-win32/dwarf/i686-5.4.0-release-win32-dwarf-rt_v5-rev0.7z"
7z rn i686-5.4.0-release-win32-dwarf-rt_v5-rev0.7z mingw32 mingw540_32
7z x -y -oC:\ i686-5.4.0-release-win32-dwarf-rt_v5-rev0.7z
:mingw_end
if exist C:\mysql-5.5.62-win32\bin\mysql.exe goto mysql_end
if not exist mysql-5.5.62-win32.zip "%CURL%" -L -o mysql-5.5.62-win32.zip https://cdn.mysql.com/Downloads/MySQL-5.5/mysql-5.5.62-win32.zip
7z x -y -oC:\mysql-5.5.62-win32 mysql-5.5.62-win32.zip
:mysql_end
if exist C:\OpenSSL\bin\openssl.exe goto openssl_end
if not exist OpenSSL_1_0_1m.zip "%CURL%" -L -o OpenSSL_1_0_1m.zip https://github.com/mugiseyebrows/drenor/releases/download/OpenSSL_1_0_1m/OpenSSL_1_0_1m.zip
7z x -y -oC:\ OpenSSL_1_0_1m.zip
:openssl_end
move /y "C:\Program Files\OpenSSL" "C:\Program Files\OpenSSL_"
move /y "C:\mingw64" "C:\mingw64_"
where mugideploy > NUL 2>&1 || pip install mugideploy
where gcc
where mingw32-make
where perl
dir C:\OpenSSL\bin
dir C:\mysql-5.5.62-win32\lib
if not exist qt-everywhere-opensource-src-4.8.7.zip "%CURL%" -L -o qt-everywhere-opensource-src-4.8.7.zip https://download.qt.io/archive/qt/4.8/4.8.7/qt-everywhere-opensource-src-4.8.7.zip
if not exist qt-everywhere-opensource-src-4.8.7 7z x -y qt-everywhere-opensource-src-4.8.7.zip
set MYSQL_INCLUDE=C:\mysql-5.5.62-win32\include
set MYSQL_BIN=C:\mysql-5.5.62-win32\lib
set OPENSSL_BIN=C:\OpenSSL\bin
set OPENSSL_INCLUDE=C:\OpenSSL\include
set OPENSSL_MODE=-openssl-linked 
set OPENSSL_LIBS="-lssleay32 -llibeay32"
set mode=-debug-and-release
set exclude=-no-declarative -no-multimedia -no-xmlpatterns -no-webkit -no-scripttools -no-script -nomake tests -nomake examples
pushd qt-everywhere-opensource-src-4.8.7
    "%PATCH%" -N -p1 -i ..\0001-fix-doc-script.patch
    "%PATCH%" -N -p1 -i ..\0001-add-mysql-to-LIBS.patch
    call configure -prefix C:\Qt\4.8.7\mingw540_32 -opensource -developer-build -confirm-license -shared -platform win32-g++ %OPENSSL_MODE% -opengl desktop %mode% %exclude% -plugin-sql-mysql -plugin-sql-odbc -I %MYSQL_INCLUDE% -L %MYSQL_BIN% -I %OPENSSL_INCLUDE% -L %OPENSSL_BIN%
    mingw32-make -j4
    if not exist bin\sqldrivers mkdir bin\sqldrivers
    copy /y plugins\sqldrivers\qsqlite4.dll bin\sqldrivers
    mingw32-make docs
    mingw32-make install
popd
mugideploy copy-dep --bin C:\Qt\4.8.7\mingw540_32\bin\qmake.exe --dst C:\Qt\4.8.7\mingw540_32\bin
mugideploy copy-dep --bin C:\Qt\4.8.7\mingw540_32\bin\QtNetwork4.dll --dst C:\Qt\4.8.7\mingw540_32\bin
mugideploy copy-dep --bin C:\Qt\4.8.7\mingw540_32\plugins\sqldrivers\qsqlmysql4.dll --dst C:\Qt\4.8.7\mingw540_32\bin
7z a -y Qt-4.8.7.7z C:\Qt\4.8.7\mingw540_32