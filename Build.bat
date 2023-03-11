@ECHO OFF
ECHO.
ECHO ==============================================================================
ECHO Building HTML Notes from MarkDown -- !! DOES NOT WORK !!
ECHO ==============================================================================
ECHO.
robocopy src/static docs/static /E
ECHO.
set "md='.md\"'"
set "html='.html\"'"
for /r %%i in (/src/*.md) do (
    echo "Building %%~ni.html..."
    pandoc --standalone --template templates/template.html src/%%~ni.md -o docs/%%~ni.html
    powershell -Command "(Get-Content %cd%/docs/%%~ni.html) -replace %md%, %html% | Out-File -encoding Default %cd%/docs/%%~ni.html
    @REM %cd% == current directory
    @REM %%~ni == short filename
)
for /d /r %%i in (/src/*) do (
    for /r %%j in (/src/%%~ni/*.md) do (
        echo "Building %%~ni/%%~nj.md to HTML"
        pandoc --standalone --template templates/template.html src/%%~ni/%%~nj.md -o docs/%%~nj.html
        powershell -Command "(Get-Content %cd%/docs/%%~nj.html) -replace %md%, %html% | Out-File -encoding Default %cd%/docs/%%~nj.html
    )
    @REM %cd% == current directory
    @REM %%~ni == short filename
)
EXIT /B