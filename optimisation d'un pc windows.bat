@echo off
title Outils d'Optimisation Windows
color 0B

:MENU
cls
echo ================================
echo     OPTIMISATION WINDOWS
echo ================================
echo 1. Nettoyer fichiers temporaires
echo 2. Vider le cache DNS
echo 3. Desactiver le mode hibernation
echo 4. Activer le mode performance maximale
echo 5. Verifier et reparer fichiers systeme (SFC)
echo 6. Nettoyer Windows Update (Cleanmgr)
echo 7. Desactiver services inutiles
echo 8. Fermer processus inutiles
echo 9. Tout executer
echo 0. Quitter
echo.
set /p choix=Choisis une option [0-9] : 

if "%choix%"=="1" goto nettoieTemp
if "%choix%"=="2" goto flushDNS
if "%choix%"=="3" goto disableHibernate
if "%choix%"=="4" goto perfMode
if "%choix%"=="5" goto sfcScan
if "%choix%"=="6" goto cleanMgr
if "%choix%"=="7" goto disableServices
if "%choix%"=="8" goto killTasks
if "%choix%"=="9" goto toutFaire
if "%choix%"=="0" exit
goto MENU

:nettoieTemp
echo Nettoyage des fichiers temporaires...
del /s /q %temp%\*.* >nul 2>&1
del /s /q C:\Windows\Temp\*.* >nul 2>&1
echo Fichiers temporaires supprimes.
pause
goto MENU

:flushDNS
echo Vider le cache DNS...
ipconfig /flushdns
echo DNS vide.
pause
goto MENU

:disableHibernate
echo Desactivation de hibernation...
powercfg -h off
echo Hibernation desactivee.
pause
goto MENU

:perfMode
echo Activation du mode performance maximale...
powercfg /setactive SCHEME_MAX
echo Mode performance active.
pause
goto MENU

:sfcScan
echo Verification des fichiers systeme...
sfc /scannow
pause
goto MENU

:cleanMgr
echo Ouverture de Cleanmgr (prepare les reglages avec /sageset:1 avant de utiliser /sagerun:1)...
cleanmgr /sagerun:1
pause
goto MENU

:disableServices
echo Desactivation de certains services inutiles...
sc stop DiagTrack >nul 2>&1
sc config DiagTrack start= disabled >nul 2>&1
sc stop WSearch >nul 2>&1
sc config WSearch start= disabled >nul 2>&1
echo Services désactives.
pause
goto MENU

:killTasks
echo Fermeture de certains processus...
taskkill /f /im OneDrive.exe >nul 2>&1
taskkill /f /im Microsoft.Photos.exe >nul 2>&1
echo Processus termines.
pause
goto MENU

:toutFaire
call :nettoieTemp
call :flushDNS
call :disableHibernate
call :perfMode
call :sfcScan
call :disableServices
call :killTasks
echo Toutes les optimisations ont ete effectuees.
pause
goto MENU
