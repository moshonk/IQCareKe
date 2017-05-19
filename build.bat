@echo off
set IS_ELEVATED=0
setlocal EnableDelayedExpansion

net session >nul 2>&1
if %errorLevel% == 0 (
	rem echo Success: Administrative permissions confirmed.
) else (
	echo Failure: Current permissions inadequate. Run as administrator
	pause
	exit /b 1
)

FOR /F %%I IN ("%0") DO SET BATDIR=%%~dpI
CD /D %BATDIR%
@echo %BATDIR%

Set config=debug 
set log=builder.log
set msbuildpath=C:\Windows\Microsoft.NET\Framework\v4.0.30319
@Echo Cleaning references folder
del %BATDIR%\References\* /F /Q
@Echo Cleaning package folder
del %BATDIR%\Package\* /F /Q
@Echo Cleaning Release folder
del %BATDIR%\Release\* /F /Q

@echo "Starting building in %config% mode"
@echo "Starting building in %config% mode devenv" > %log%

@echo "********** Building Entities **********" >> %log%
@echo ********** Building Entities **********
"C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.com" /rebuild %config% "%BATDIR%\Solutions\Entities\Entities.sln" >> %log%
@echo "********** Building Interface **********" >> %log%
@echo ********** Building Interface **********
"C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.com" /rebuild %config% "%BATDIR%\Solutions\Interfaces\Interfaces.sln" >> %log%
@echo "********** Building Application **********" >> %log%
@echo ********** Building Application **********
"C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.com" /rebuild %config% "%BATDIR%\Solutions\Application\Application.sln" >> %log%
@echo "********** Building DataAccess **********" >> %log%
@echo ********** Building DataAccess **********
"C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.com" /rebuild %config% "%BATDIR%\Solutions\DataAccess\DataAccess.sln" >> %log%
@echo "********** Building Businessprocess **********" >> %log%
@echo ********** Building Businessprocess **********
"C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.com" /rebuild %config% "%BATDIR%\Solutions\BusinessProcess\BusinessProcess.sln" >> %log%
echo "********** Building IQCare.Library **********" >> %log%
@echo ********** Building IQCare.Library  **********
"C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.com" /rebuild %config% "%BATDIR%\Solutions\IQCare.Library\IQCare.Library.sln" >> %log%
echo "********** Building IQCare.Lookup **********" >> %log%
@echo ********** Building IQCare.Lookup **********
"C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.com" /rebuild %config% "%BATDIR%\Solutions\IQLookup\IQCare.Lookup.sln" >> %log%
echo "********** Building Presentation **********" >> %log%
@echo ********** Building Presentation **********
"C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.com" /build %config% "%BATDIR%\Solutions\Presentation\Presentation.sln" >> %log%
echo "********** Building Billing **********" >> %log%
@echo ********** Building Billing **********
"C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.com" /build %config% "%BATDIR%\Solutions\Billing\IQCare.Billing.sln" >> %log%
echo "********** Building IQCare.CCC **********" >> %log%
@echo ********** Building IQCare.CCC **********
"C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.com" /build %config% "%BATDIR%\Solutions\IQCare.CCC\IQCare.CCC.sln" >> %log%
if /I %config%== release (
echo "********** Building IQCare Service **********" >> %log%
@echo ********** Building IQCare Service **********
"C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.com" /build %config% "%BATDIR%\Solutions\IQCareService\IQCareService.sln" >> %log%
echo "********** Building IQCare Management **********" >> %log%
@echo ********** Building IQCare Management **********
"C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.com" /build %config% "%BATDIR%\Solutions\IQCare Management\IQCare Management.sln" >> %log%
echo "********** Building IQCare.Release **********" >> %log%
@echo ********** Building IQCare.Release **********
"C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.com" /build %config% "%BATDIR%\Solutions\IQCare.Release\IQCare.Release.sln" >> %log%
)
@echo "********** Completed building  devenv**********" >> %log%
@echo ********** Completed building  devenv**********
echo "********** Scripts **********" >> %log%
XCOPY %BATDIR%\Scripts\* %BATDIR%\Release\Scripts /s /i >nul
COPY %BATDIR%\batch.bat %BATDIR%\Release\batch.bat /Y > nul

@echo ********** END OF BUILINDING & PACKAGING **********

echo

