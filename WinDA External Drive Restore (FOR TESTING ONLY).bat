@ECHO off
REM TITLE
ECHO ======== Windows Deployment Automation ========

REM SET VARIABLES FOR FILE PATHS
SET /p user= "Enter username (User directory name): "
SET /p driveletter= "Enter External Drive Path: "
SET /p "localpath=%driveletter%:\Backups\%user%"
SET "userpath=C:\Users\%user%"

REM CREATE AND SET SUBDIRECTORIES FOR BOOKMARKS
IF EXIST "%userpath%\AppData\Local\Google\Chrome\User Data\Default" (
ECHO BOOKMARKS DIRECTORY ALREADY EXISTS!
TIMEOUT /T 5 /NOBREAK >NUL
} ELSE (
MKDIR %userpath%\AppData\Local\Google
MKDIR %userpath%\AppData\Local\Google\Chrome\
MKDIR %userpath%\AppData\Local\Google\Chrome\User Data\
MKDIR %userpath%\AppData\Local\Google\Chrome\User Data\Default
SET "localbookmarks=%localpath%\ChromeBookmarks"
SET "userbookmarks=%userpath%\AppData\Local\Google\Chrome\User Data\Default"
)

REM TRANSFER ESSENTIAL SUBDIRECTORIES FROM USER DIRECTORY IF FOUND IN C:\USERS\%user%
IF EXIST "%localpath%\Desktop" (
ROBOCOPY %localpath%\Desktop %userpath%\Desktop /E /L /COPY:DAT /Z /R:2 /W:5
) ELSE (
	ECHO Desktop not found  in %localpath%\
	TIMEOUT /T 5 /NOBREAK >NUL
)
IF EXIST "%localpath%\Documents" (
ROBOCOPY %localpath%\Documents %userpath%\Documents /E /L /COPY:DAT /Z /R:2 /W:5
) ELSE (
	ECHO Documents not found  in %localpath%\
	TIMEOUT /T 5 /NOBREAK >NUL
)
IF EXIST "%localpath%\Pictures" (
ROBOCOPY %localpath%\Pictures %userpath%\Pictures /E /L /COPY:DAT /Z /R:2 /W:5
) ELSE (
	ECHO Pictures not found  in %localpath%\
	TIMEOUT /T 5 /NOBREAK >NUL
)
ROBOCOPY %localpath%\Downloads %userpath%\Downloads /E /L /COPY:DAT /Z /R:2 /W:5

REM TRANSFER BOOKMARKS FROM DEFAULT PROFILE DIRECTORY IF IT EXISTS
IF EXIST "%localbookmarks%\Bookmarks" (
	ECHO Restoring Chrome Bookmarks to %userbookmarks%\!
	TIMEOUT /T 5 /NOBREAK >NUL
	ROBOCOPY "%localbookmarks%" "%userbookmarks%" "Bookmarks" /L /Z /R:2 /W:5
) ELSE (
	ECHO No bookmarks to restore in %localbookmarks%...
	TIMEOUT /T 3 /NOBREAK >NUL
)
REM FOR LOOP TO LOCATE EXTRA PROFILES (IN PROGRESS)

MSG * /TIME:999 "File Transfer Complete!"

REM END OF SCRIPT
COLOR 20
PAUSE