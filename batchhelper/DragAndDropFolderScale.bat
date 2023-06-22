@echo off
setlocal

rem Verify that a folder was passed by drag and drop
if "%~1"=="" (
    echo Please drag a folder on the script.
    pause
    exit /b
)

rem Determine the path to the executable file
set "executable_path=%~dp0realesrgan-ncnn-vulkan.exe"

rem Check if the executable file exists
if not exist "%executable_path%" (
    echo The executable file was not found: %executable_path%
    echo DragAndDropFolderScale.bat script must be located next to the exe in the folder for this to work
    echo.
    echo +--- README_windows.md
    echo +--- DragAndDropFolderScale.bat
    echo +--- realesrgan-ncnn-vulkan.exe
    echo +--- models
    echo     +--- realesr-animevideov3-x2.bin
    echo     +--- realesr-animevideov3-x2.param
    echo     +--- realesrgan-x4plus.bin
    echo     \--- ...
    echo +--- vcomp140.dll
    echo \--- vcomp140d.dll
    echo.
    echo ===============================
    echo :::: Download ::::
    echo https://github.com/xinntao/Real-ESRGAN-ncnn-vulkan
    echo.
    pause
    exit /b
)

rem To select model
echo Please select a model:
echo 1 - realesr-animevideov3
echo 2 - realesrgan-x4plus
echo 3 - realesrgan-x4plus-anime
echo 4 - realesrnet-x4plus

choice /C 1234 /N

if errorlevel 4 (
    set "model=realesrnet-x4plus"
) else if errorlevel 3 (
    set "model=realesrgan-x4plus-anime"
) else if errorlevel 2 (
    set "model=realesrgan-x4plus"
) else (
    set "model=realesr-animevideov3"
)

:again
echo Please enter upscale ratio number (can be 2, 3, 4)
set /p number=
if not defined number goto again

rem Change to the directory of the passed folder
cd /d "%~dp1"

rem Create the new folder with the suffix "_scale"
mkdir "%~n1_%model%_scale_%number%"

rem Saving the folder path
set "folder_path=%~dp1%~n1_%model%_scale_%number%"

rem run "realesrgan-ncnn-vulkan.exe" with the parameters
"%executable_path%" -i "%~dp1%~n1" -o "%folder_path%" -n %model% -s %number%

endlocal
exit