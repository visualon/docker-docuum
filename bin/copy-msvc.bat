@echo off

for /f "usebackq delims=#" %%a in (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere" -latest -property installationPath`) do call "%%a\Common7\Tools\VsDevCmd.bat" -arch=amd64

xcopy /i "%VCToolsRedistDir%onecore\x64\Microsoft.VC142.CRT" "windows/bin"
