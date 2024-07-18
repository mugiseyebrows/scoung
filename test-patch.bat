@echo off
rem This file is generated from test-patch.pbat, all edits will be lost
python whats-in-path.py -e exe > exes-in-path.txt
python whats-in-path.py -e dll > dlls-in-path.txt