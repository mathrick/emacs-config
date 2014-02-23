@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  REM ---------------- SELF EXTRACTOR BEGIN ----------------
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  REM DO NOT MODIFY ANYTHING BETWEEN THIS LINE AND SELF EXTRACTOR END
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  REM The settings you want to modify are below the self-extractor section
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  echo off
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  echo Unpacking the installer...
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  for /f "skip=12 delims=*" %%a in (%0) do (echo %%a >> "%~dp0__tmp__extract.ps1")
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  powershell -ExecutionPolicy unrestricted "%~dp0__tmp__extract.ps1"
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  del /f "%~dp0__tmp__extract.ps1"
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  goto :eof

------------------------- SELF EXTRACTOR END ---------------------------

# Powershell is insane, we need that
function any { $input | select-object -first 1 }

#################################
############ SETTINGS ###########
#################################
# Review those, make sure they are what you expect,
# then confirm by changing the value of
# $I_have_read_and_understood_the_settings
# to $true

# Your %HOME% will be set to $HOME (or the value you specify), unless
# it's already defined
$homedir = $Env:HOME, $HOME | any

# This is where things that don't have an installer (including Emacs)
# will be unpacked. By default they will just be subdirectories of
# your Download folder, which is fine place IMHO. Make sure it's the
# right path especially if you don't have an English Windows, and the
# folder is called something like "Pobrane"
$installdir = "$homedir\Downloads\"

# Change this to "yes" to signify you're fine with the values above
$I_have_read_and_understood_the_settings = $false
########## END SETTINGS ##########

if (!$I_have_read_and_understood_the_settings) 
{
        Write-Warning "You need to review and confirm the settings at the start of this script first."
        Write-Warning "Aborting."
        exit
}

$tmpdir = $Env:TMP, $Env:Temp | any

$bzrurl = "https://launchpad.net/bzr/2.6/2.6b1/+download/bzr-2.6b1-1-setup.exe"
$giturl = "http://msysgit.googlecode.com/files/Git-1.8.5.2-preview20131230.exe"
$curlurl = 

$web = New-Object System.Net.WebClient
$url = "http://teusje.files.wordpress.com/2011/02/giraffe-header1.png"
$file = "$pwd\myNewFilename.png"
# $web.DownloadFile($url,$file)
