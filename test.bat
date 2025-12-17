@echo off
rem This file is generated from test.pbat, all edits will be lost
set PATH=C:\Miniconda3;C:\Miniconda3\Scripts;%USERPROFILE%\Miniconda3;%USERPROFILE%\Miniconda3\Scripts;%LOCALAPPDATA%\Programs\Python\Python313;%LOCALAPPDATA%\Programs\Python\Python313\Scripts;C:\Python313;C:\Python313\Scripts;%PATH%
python -c "import psutil" || python -m pip install "psutil"
python test.py