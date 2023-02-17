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
if exist "C:\Program Files\Git\mingw32\bin\curl.exe" set CURL=C:\Program Files\Git\mingw32\bin\curl.exe
if exist "C:\Program Files\Git\mingw64\bin\curl.exe" set CURL=C:\Program Files\Git\mingw64\bin\curl.exe
if exist "C:\Windows\System32\curl.exe" set CURL=C:\Windows\System32\curl.exe
if not defined CURL (
echo CURL not found
exit /b
)
pushd %~dp0
set PATH=%CD%\mingw32\bin;C:\Qt-4.8.7\bin;C:\Strawberry\perl\bin;%CD%\OpenSSL\bin;%PATH%
if not exist i686-5.4.0-release-win32-dwarf-rt_v5-rev0.7z "%CURL%" -L -o i686-5.4.0-release-win32-dwarf-rt_v5-rev0.7z "https://netix.dl.sourceforge.net/project/mingw-w64/Toolchains%%20targetting%%20Win32/Personal%%20Builds/mingw-builds/5.4.0/threads-win32/dwarf/i686-5.4.0-release-win32-dwarf-rt_v5-rev0.7z"
if not exist mingw32 "%P7Z%" x -y i686-5.4.0-release-win32-dwarf-rt_v5-rev0.7z
if exist "C:\Strawberry\perl\bin\perl.exe" set PERL=C:\Strawberry\perl\bin\perl.exe
if not defined PERL (
echo PERL not found
exit /b
)
if exist "%CD%\mingw32\bin\gcc.exe" set MINGW=%CD%\mingw32\bin\gcc.exe
if not defined MINGW (
echo MINGW not found
exit /b
)
g++ -v
set qt_version=4.8.7
set maj_min=%qt_version:~0,3%
if "%maj_min%" equ "4.8" (
    if not exist "qt-everywhere-opensource-src-4.8.7.zip" "%CURL%" -L -o "qt-everywhere-opensource-src-4.8.7.zip" "https://download.qt.io/archive/qt/%maj_min%/4.8.7/qt-everywhere-opensource-src-4.8.7.zip"
) else (
    if not exist "qt-everywhere-opensource-src-4.8.7.zip" "%CURL%" -L -o "qt-everywhere-opensource-src-4.8.7.zip" "https://download.qt.io/archive/qt/%maj_min%/qt-everywhere-opensource-src-4.8.7.zip"
)
if not exist "qt-everywhere-opensource-src-4.8.7" "%P7Z%" x -y "qt-everywhere-opensource-src-4.8.7.zip"
if not exist mysql-5.5.62-win32.zip "%CURL%" -L -o mysql-5.5.62-win32.zip https://cdn.mysql.com/Downloads/MySQL-5.5/mysql-5.5.62-win32.zip
if not exist mysql-5.5.62-win32 "%P7Z%" x -y mysql-5.5.62-win32.zip
set MYSQL_INCLUDE=%CD%\mysql-5.5.62-win32\include
set MYSQL_BIN=%CD%\mysql-5.5.62-win32\lib
if not exist OpenSSL_1_0_1m.zip "%CURL%" -L -o OpenSSL_1_0_1m.zip https://github.com/mugiseyebrows/drenor/releases/download/OpenSSL_1_0_1m/OpenSSL_1_0_1m.zip
if not exist OpenSSL "%P7Z%" x -y OpenSSL_1_0_1m.zip
set OPENSSL_BIN=%CD%\OpenSSL\bin
set OPENSSL_INCLUDE=%CD%\OpenSSL\include
set OPENSSL_MODE=-openssl-linked OPENSSL_LIBS="-lssleay32 -llibeay32"
set mode=-debug-and-release
set exclude=-no-declarative -no-multimedia -no-xmlpatterns -no-webkit -no-scripttools -no-script -nomake tests -nomake examples
pushd qt-everywhere-opensource-src-4.8.7
    "%PATCH%" -N -p1 -i ..\0001-fix-doc-script.patch
    "%PATCH%" -N -p1 -i ..\0001-add-mysql-to-LIBS.patch
    call configure -prefix C:\Qt-4.8.7 -opensource -developer-build -confirm-license -shared -platform win32-g++ %OPENSSL_MODE% -opengl desktop %mode% %exclude% -plugin-sql-mysql -plugin-sql-odbc -I %MYSQL_INCLUDE% -L %MYSQL_BIN% -I %OPENSSL_INCLUDE% -L %OPENSSL_BIN%
    mingw32-make -j4
    if not exist "bin\sqldrivers" mkdir "bin\sqldrivers"
    copy /y plugins\sqldrivers\qsqlite4.dll bin\sqldrivers
    mingw32-make docs
    mingw32-make install
popd
copy /y "mingw32\bin\libstdc++-6.dll" "C:\Qt-4.8.7\bin"
copy /y mingw32\bin\libgcc_s_dw2-1.dll "C:\Qt-4.8.7\bin"
copy /y OpenSSL\bin\libeay32.dll "C:\Qt-4.8.7\bin"
copy /y OpenSSL\bin\ssleay32.dll "C:\Qt-4.8.7\bin"
if not exist "Qt-4.8.7.7z" "%P7Z%" a -y -mx9 "Qt-4.8.7.7z" "C:\Qt-4.8.7"
popd