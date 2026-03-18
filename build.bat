@echo off
rem This file is generated from build.pbat, all edits will be lost
set PATH=C:\Windows\System32;C:\Program Files\7-Zip;C:\Qt\4.8.7\msvc\bin;C:\mysql-8.2.0-winx64\lib;C:\mysql-8.2.0-winx64\bin;C:\Strawberry\perl\bin;C:\Miniconda3;C:\Miniconda3\Scripts;%USERPROFILE%\Miniconda3;%USERPROFILE%\Miniconda3\Scripts;%PATH%
if exist "C:\Program Files\Git\usr\bin\patch.exe" set PATCH=C:\Program Files\Git\usr\bin\patch.exe
if not defined PATCH (
echo PATCH not found
exit /b
)
if exist C:\mysql-8.2.0-winx64\bin\mysql.exe goto mysql_end
if not exist mysql-8.2.0-winx64.zip (
    echo downloading mysql-8.2.0-winx64.zip
    curl -L -o mysql-8.2.0-winx64.zip https://cdn.mysql.com/Downloads/MySQL-8.2/mysql-8.2.0-winx64.zip
)
7z x -y -oC:\ mysql-8.2.0-winx64.zip
:mysql_end
if exist C:\OpenSSL\bin\openssl.exe goto openssl_end
if not exist OpenSSL_1_0_1m.zip curl -L -o OpenSSL_1_0_1m.zip https://github.com/mugiseyebrows/drenor/releases/download/OpenSSL_1_0_1m/OpenSSL_1_0_1m.zip
7z x -y -oC:\ OpenSSL_1_0_1m.zip
:openssl_end
if exist "C:\Program Files\OpenSSL" move /y "C:\Program Files\OpenSSL" "C:\Program Files\OpenSSL_"
where mugideploy > NUL 2>&1 || pip install mugideploy
if not exist qt-everywhere-opensource-src-4.8.7.zip curl -L -o qt-everywhere-opensource-src-4.8.7.zip https://download.qt.io/archive/qt/4.8/4.8.7/qt-everywhere-opensource-src-4.8.7.zip
if not exist qt-everywhere-opensource-src-4.8.7 7z x -y qt-everywhere-opensource-src-4.8.7.zip
set OPENSSL_BIN=C:\OpenSSL\bin
set OPENSSL_INCLUDE=C:\OpenSSL\include
set OPENSSL_MODE=-openssl-linked 
set OPENSSL_LIBS="-lssleay32 -llibeay32"
set exclude=-no-declarative -no-multimedia  -no-accessibility -no-qt3support -no-xmlpatterns -no-webkit -no-scripttools -no-script -no-phonon -nomake tests -nomake examples -nomake demos -nomake tools
pushd qt-everywhere-opensource-src-4.8.7
    "%PATCH%" -N -p1 -i ..\0001-fix-doc-script.patch
    "%PATCH%" -N -p1 -i ..\0001-link-libmysql.patch
    "%PATCH%" -N -p1 -i ..\0001-typedef-my_bool.patch
    configure -prefix C:\Qt\4.8.7\msvc -opensource -developer-build -confirm-license -shared -platform win32-msvc2015 -opengl desktop -debug %exclude% -plugin-sql-mysql -plugin-sql-odbc -I C:\mysql-8.2.0-winx64\include -L C:\mysql-8.2.0-winx64\lib
    nmake || exit /b
    nmake install || exit /b
popd
7z a -y Qt-4.8.7.7z C:\Qt\4.8.7\msvc