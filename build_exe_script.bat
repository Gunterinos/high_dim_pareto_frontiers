@echo off
setlocal
rem Builds ParetoExplorer.exe (one self-contained file) on Windows.
rem Needs Python 3.10+ and Node.js 18+ installed. Usage:
rem   build_exe.bat                  -> output to "Desktop\Pareto Frontier Explorer"
rem   build_exe.bat "C:\some\folder" -> output to that folder
cd /d "%~dp0"

set "OUT=%~1"
if "%OUT%"=="" set "OUT=%USERPROFILE%\Desktop\Pareto Frontier Explorer"
set "WORK=%TEMP%\pareto_explorer_build"

echo [1/4] Python environment
if not exist venv\Scripts\python.exe python -m venv venv || goto :error
venv\Scripts\python -m pip install --quiet -r requirements.txt pyinstaller || goto :error

pushd frontend
echo [2/4] Frontend packages
call npm install || goto :error

echo [3/4] Building frontend
call npm run build || goto :error
popd

echo [4/4] Packaging ParetoExplorer.exe
venv\Scripts\python -m PyInstaller --noconfirm --clean --onefile --name ParetoExplorer ^
  --distpath "%OUT%" --workpath "%WORK%" --specpath "%WORK%" ^
  --add-data "%CD%\frontend\dist;frontend\dist" ^
  --add-data "%CD%\data;data" ^
  --add-data "%CD%\survey_data;survey_data" ^
  app.py || goto :error

echo.
echo Done: "%OUT%\ParetoExplorer.exe"
pause
exit /b 0

:error
echo.
echo Build failed - see the messages above.
pause
exit /b 1
