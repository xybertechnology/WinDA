@echo off
REM TITLE
echo ======== Windows Deployment Automation ========

REM FORCED BUFFER
timeout /t 2 /nobreak >nul

REM SET VARIABLES FOR FILE PATHS
set /p user= "Enter username (User directory name): "
set /p target= "Enter IP Address/Hostname of the target computer: "
set "localBookmarks=C:\Users\%user%\AppData\Local\Google\Chrome\User Data"
set "targetBookmarks=\\%target%\C$\Users\%user%\AppData\Local\Google\Chrome\User Data"
set "chromeProfiles=C:\Users\%user%\AppData\Local\Google\Chrome\User Data\Profile *"

REM TRANSFER ESSENTIAL SUBDIRECTORIES FROM USER DIRECTORY
IF EXIST "C:\Users\%user%\Desktop" (
ROBOCOPY C:\Users\%user%\Desktop  \\%target%\C$\Users\%user%\Desktop /E /COPY:DAT /Z /R:2 /W:5
) ELSE (
	ECHO Desktop not found  in C:\Users\%user%
	TIMEOUT /T 5 /NOBREAK >NUL
)
IF EXIST "C:\Users\%user%\Documents" (
ROBOCOPY C:\Users\%user%\Documents \\%target%\C$\Users\%user%\Documents /E /COPY:DAT /Z /R:2 /W:5
) ELSE (
	ECHO Documents not found  in C:\Users\%user%
	TIMEOUT /T 5 /NOBREAK >NUL
)
IF EXIST "C:\Users\%user%\Pictures" (
ROBOCOPY C:\Users\%user%\Pictures \\%target%\C$\Users\%user%\Pictures /E /COPY:DAT /Z /R:2 /W:5
) ELSE (
	ECHO Pictures not found  in C:\Users\%user%
	TIMEOUT /T 5 /NOBREAK >NUL
)
ROBOCOPY C:\Users\%user%\Downloads \\%target%\C$\Users\%user%\Downloads /E /COPY:DAT /Z /R:2 /W:5

REM TRANSFER BOOKMARKS FROM DEFAULT PROFILE DIRECTORY IF IT EXISTS
IF EXIST "%localBookmarks%\Default\Bookmarks" (
	ECHO Found Chrome Bookmarks! Migrating to %targetBookmarks%\Default
	TIMEOUT /T 5 /NOBREAK >NUL
	ROBOCOPY "%localBookmarks%\Default" "%targetBookmarks%\Default" "Bookmarks" /Z /R:2 /W:5
) ELSE (
	ECHO Could Not Find Chrome Bookmarks in %targetBookmarks%\Default...
	TIMEOUT /T 3 /NOBREAK >NUL
)

REM FOR LOOP TO LOCATE EXTRA PROFILES (IN PROGRESS)
COLOR 20
MSG * /time:999 "File Transfer Complete!"
pause