@echo off
rem This file is generated from build-msys.pbat, all edits will be lost
set PATH=C:\Miniconda3;C:\Miniconda3\Scripts;%USERPROFILE%\Miniconda3;%USERPROFILE%\Miniconda3\Scripts;%RUNNER_TEMP%\msys64\ucrt64\bin;%RUNNER_TEMP%\msys64\ucrt64\share\qt6\bin;C:\msys64\ucrt64\bin;C:\msys64\ucrt64\share\qt6\bin;%PATH%
where mugideploy 1> NUL 2> NUL || pip install mugideploy
qmake6
mingw32-make -j4
mugideploy collect --bin release\main.exe --plugins sqldrivers