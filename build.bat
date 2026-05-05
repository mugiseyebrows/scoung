@echo off
rem This file is generated from build.pbat, all edits will be lost
set PATH=C:\Windows\System32;C:\Program Files\7-Zip;C:\mingw5\mingw32\bin;C:\Qt\4.8.7\mingw_32\bin;C:\mysql-5.5.62-win32\lib;C:\mysql-5.5.62-win32\bin;C:\OpenSSL\bin;C:\Strawberry\perl\bin;%LOCALAPPDATA%\Programs\Python\Python313;%LOCALAPPDATA%\Programs\Python\Python313\Scripts;C:\Python313;C:\Python313\Scripts;%PATH%
if exist "C:\Program Files\Git\usr\bin\patch.exe" set PATCH=C:\Program Files\Git\usr\bin\patch.exe
if not defined PATCH (
echo PATCH not found
exit /b
)
if exist C:\mingw5\mingw32\bin\gcc.exe goto mingw_end
if not exist i686-5.4.0-release-win32-dwarf-rt_v5-rev0.7z curl -L -o i686-5.4.0-release-win32-dwarf-rt_v5-rev0.7z "https://netix.dl.sourceforge.net/project/mingw-w64/Toolchains%%20targetting%%20Win32/Personal%%20Builds/mingw-builds/5.4.0/threads-win32/dwarf/i686-5.4.0-release-win32-dwarf-rt_v5-rev0.7z"
7z x -y -oC:\mingw5 i686-5.4.0-release-win32-dwarf-rt_v5-rev0.7z
:mingw_end
if exist C:\mysql-5.5.62-win32\bin\mysql.exe goto mysql_end
if not exist mysql-5.5.62-win32.zip curl -L -o mysql-5.5.62-win32.zip https://cdn.mysql.com/Downloads/MySQL-5.5/mysql-5.5.62-win32.zip
7z x -y -oC:\ mysql-5.5.62-win32.zip
:mysql_end
if exist C:\OpenSSL\bin\openssl.exe goto openssl_end
if not exist OpenSSL_1_0_1m.zip curl -L -o OpenSSL_1_0_1m.zip https://github.com/mugiseyebrows/drenor/releases/download/OpenSSL_1_0_1m/OpenSSL_1_0_1m.zip
7z x -y -oC:\ OpenSSL_1_0_1m.zip
:openssl_end
python -c "import mugideploy" || python -m pip install "mugideploy"
if not exist qt-everywhere-opensource-src-4.8.7.zip (
    echo downloading qt-everywhere-opensource-src-4.8.7.zip
    curl -L -o qt-everywhere-opensource-src-4.8.7.zip https://download.qt.io/archive/qt/4.8/4.8.7/qt-everywhere-opensource-src-4.8.7.zip
)
if not exist qt-everywhere-opensource-src-4.8.7 7z x -y qt-everywhere-opensource-src-4.8.7.zip
pushd qt-everywhere-opensource-src-4.8.7
    "%PATCH%" -N -p1 -i ..\0001-fix-doc-script.patch
    "%PATCH%" -N -p1 -i ..\0001-add-mysql-to-LIBS.patch
    call configure -prefix C:\Qt\4.8.7\mingw_32 -opensource -developer-build -confirm-license -shared -platform win32-g++ -opengl desktop -debug-and-release -no-declarative -no-multimedia -no-xmlpatterns -no-webkit -no-scripttools -no-script -nomake tests -nomake examples -plugin-sql-odbc -plugin-sql-mysql -I C:/mysql-5.5.62-win32/include -L C:/mysql-5.5.62-win32/lib -openssl-linked -I C:/OpenSSL/include -L C:/OpenSSL/bin
    mingw32-make -j4 || exit /b
    if not exist bin\sqldrivers mkdir bin\sqldrivers
    copy /y plugins\sqldrivers\qsqlite4.dll bin\sqldrivers
    mingw32-make docs
    mingw32-make install
popd
mugideploy copy-dep --bin C:\Qt\4.8.7\mingw_32\bin\qmake.exe --dst C:\Qt\4.8.7\mingw_32\bin
mugideploy copy-dep --bin C:\Qt\4.8.7\mingw_32\bin\QtNetwork4.dll --dst C:\Qt\4.8.7\mingw_32\bin
mugideploy copy-dep --bin C:\Qt\4.8.7\mingw_32\plugins\sqldrivers\qsqlmysql4.dll --dst C:\Qt\4.8.7\mingw_32\bin
7z a -y Qt-4.8.7.7z C:\Qt\4.8.7\mingw_32