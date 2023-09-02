@REM Install-Module ps2exe
@REM Invoke-ps2exe .\AutomatedSetupWindows.ps1 .\AutomatedSetupWindows.exe

@echo off

REM Defina o caminho para o script PowerShell e o caminho de saída do executável
set PowerShellScript=.\AutomatedSetupWindows.ps1
set OutputExecutable=.\AutomatedSetupWindows.exe

REM Gere o executável usando o módulo ps2exe
powershell -NoProfile -ExecutionPolicy Bypass -Command "Install-Module ps2exe -Force; Invoke-ps2exe %PowerShellScript% %OutputExecutable%"
