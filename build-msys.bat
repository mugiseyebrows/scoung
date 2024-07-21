@echo off
rem This file is generated from build-msys.pbat, all edits will be lost
set PATH=C:\Miniconda3;C:\Miniconda3\Scripts;%USERPROFILE%\Miniconda3;%USERPROFILE%\Miniconda3\Scripts;C:\msys64\ucrt64\bin;C:\msys64\ucrt64\share\qt6\bin;%PATH%
echo RUNNER_TEMP %RUNNER_TEMP%
where mugideploy 1> NUL 2> NUL || pip install mugideploy
where pyfind 1> NUL 2> NUL || pip install mugicli
qmake6 
mingw32-make -j4
mugideploy collect --bin release\main.exe --plugins sqldrivers
pyfind %RUNNER_TEMP% -abspath -maxdepth 1