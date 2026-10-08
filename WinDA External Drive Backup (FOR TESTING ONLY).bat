@ECHO off
REM TITLE
ECHO ======== Windows Deployment Automation ========

REM SET VARIABLES FOR FILE PATHS
SET /p user= "Enter username (User directory name): "
SET /p targetdrive= "External Drive Letter: "
SET "localBookmarks=C:\Users\%user%\AppData\Local\Google\Chrome\User Data"

REM CREATE AND SET BACKUP DIRECTORY
MKDIR %targetdrive%:\Backups
MKDIR %targetdrive%:\Backups\%user%
SET "targetpath=%targetdrive%:\Backups\%user%"

REM TRANSFER ESSENTIAL SUBDIRECTORIES FROM USER DIRECTORY IF FOUND IN C:\USERS\%user%
IF EXIST "C:\Users\%user%\Desktop" (
ROBOCOPY C:\Users\%user%\Desktop  %targetpath%\Desktop /E /L /COPY:DAT /Z /R:2 /W:5
) ELSE (
	ECHO Desktop not found  in C:\Users\%user%
	TIMEOUT /T 5 /NOBREAK >NUL
)
IF EXIST "C:\Users\%user%\Documents" (
ROBOCOPY C:\Users\%user%\Documents %targetpath%\Documents /E /L /COPY:DAT /Z /R:2 /W:5
) ELSE (
	ECHO Documents not found  in C:\Users\%user%
	TIMEOUT /T 5 /NOBREAK >NUL
)
IF EXIST "C:\Users\%user%\Pictures" (
ROBOCOPY C:\Users\%user%\Pictures %targetpath%\Pictures /E /L /COPY:DAT /Z /R:2 /W:5
) ELSE (
	ECHO Pictures not found  in C:\Users\%user%
	TIMEOUT /T 5 /NOBREAK >NUL
)
ROBOCOPY C:\Users\%user%\Downloads %targetpath%\Downloads /E /L /COPY:DAT /Z /R:2 /W:5

REM TRANSFER BOOKMARKS FROM DEFAULT PROFILE DIRECTORY IF IT EXISTS
IF EXIST "%localBookmarks%\Default\Bookmarks" (
	ECHO Found Chrome Bookmarks! Migrating to %targetpath%\ChromeBookmarks
	TIMEOUT /T 5 /NOBREAK >NUL
	ROBOCOPY "%localBookmarks%\Default" "%targetpath%\ChromeBookmarks" "Bookmarks" /Z /L /R:2 /W:5
) ELSE (
	ECHO Could Not Find Chrome Bookmarks in %localBookmarks%\Default...
	TIMEOUT /T 5 /NOBREAK >NUL
)
REM FOR LOOP TO LOCATE EXTRA PROFILES (IN PROGRESS)

MSG * /TIME:999 "File Transfer Complete!"

REM END OF SCRIPT
COLOR 20
PAUSE