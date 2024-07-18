@echo off
rem This file is generated from test-mingw.pbat, all edits will be lost
set PATH=C:\Miniconda3;C:\Miniconda3\Scripts;%USERPROFILE%\Miniconda3;%USERPROFILE%\Miniconda3\Scripts;C:\Program Files\Meson;C:\Program Files\CMake\bin;C:\Program Files\7-Zip;%PATH%
if exist "C:\Program Files\Git\mingw32\bin\curl.exe" set CURL=C:\Program Files\Git\mingw32\bin\curl.exe
if exist "C:\Program Files\Git\mingw64\bin\curl.exe" set CURL=C:\Program Files\Git\mingw64\bin\curl.exe
if exist "C:\Windows\System32\curl.exe" set CURL=C:\Windows\System32\curl.exe
if not defined CURL (
echo CURL not found
exit /b
)
pip install mugicli
if exist C:\Qt\6.7.2\mingw1220_64\bin\qmake.exe goto qtbase671_end
if not exist qtbase-everywhere-src-6.7.2.zip "%CURL%" -L -o qtbase-everywhere-src-6.7.2.zip https://download.qt.io/official_releases/qt/6.7/6.7.2/submodules/qtbase-everywhere-src-6.7.2.zip
if not exist qtbase-everywhere-src-6.7.2 7z x -y qtbase-everywhere-src-6.7.2.zip
pushd qtbase-everywhere-src-6.7.2
    cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=C:/Qt/6.7.2/mingw1220_64 -DQT_QMAKE_TARGET_MKSPEC=win32-g++ -DQT_BUILD_TESTS=FALSE -DQT_BUILD_EXAMPLES=FALSE -DFEATURE_system_zlib=OFF .
    ninja Qt6Core.dll -j4
    ninja Qt6Gui.dll -j4
    ninja Qt6Widgets.dll -j4
    pyfind -iname *.dll *.exe *.a -stat | pysort > ..\stat1.txt
    pyfind -iname *.dll *.exe *.a *.obj -stat | pysort > ..\stat2.txt
popd
:qtbase671_end
echo yes