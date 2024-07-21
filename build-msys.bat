@echo off
rem This file is generated from build-msys.pbat, all edits will be lost
set PATH=C:\msys64\ucrt64\bin;C:\msys64\ucrt64\share\qt6\bin;C:\Miniconda3;C:\Miniconda3\Scripts;%USERPROFILE%\Miniconda3;%USERPROFILE%\Miniconda3\Scripts;%PATH%
qmake6
mingw32-make -j4
where mugideploy 1> NUL 2> NUL || pip install mugideploy
mugideploy collect --bin release\main.exe --plugins sqldrivers