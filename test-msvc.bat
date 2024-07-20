@echo off
rem This file is generated from test-msvc.pbat, all edits will be lost
set PATH=C:\Miniconda3;C:\Miniconda3\Scripts;%USERPROFILE%\Miniconda3;%USERPROFILE%\Miniconda3\Scripts;C:\Program Files\Meson;C:\Program Files\CMake\bin;C:\Program Files\Git\mingw64\bin;C:\Program Files\Git\mingw32\bin;C:\Windows\System32;C:\Program Files\7-Zip;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build;C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build;C:\Qt\6.7.2\msvc2019_64\bin;%PATH%
where mugideploy 2> NUL || pip install mugideploy
where pyfind 2> NUL || pip install mugicli
:: where(gcc, qmake, cmake, ninja, libpq.dll, libmysql.dll)
if exist C:\Qt\6.7.2\mingw1220_64\bin\qmake.exe goto qtbase672_end
:: move is faster than rmdir
if not exist qtbase-everywhere-src-6.7.2.zip curl -L -o qtbase-everywhere-src-6.7.2.zip https://download.qt.io/official_releases/qt/6.7/6.7.2/submodules/qtbase-everywhere-src-6.7.2.zip
if not exist qtbase-everywhere-src-6.7.2 7z x -y qtbase-everywhere-src-6.7.2.zip
pushd qtbase-everywhere-src-6.7.2
    call vcvars64.bat
    cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=C:/Qt/6.7.2/msvc2019_64 -DQT_QMAKE_TARGET_MKSPEC=win32-msvc -DQT_BUILD_TESTS=FALSE -DQT_BUILD_EXAMPLES=FALSE -DFEATURE_system_zlib=OFF .
    cmake --build . --parallel
    cmake --install .
    pyfind C:\Qt\6.7.2\msvc2019_64 > ..\listing1.txt
popd
qmake
nmake
pyfind -maxdepth 3 > listing2.txt
:qtbase672_end
echo yes