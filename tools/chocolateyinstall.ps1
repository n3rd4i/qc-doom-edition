﻿$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$(Join-Path $toolsDir commonEnv.ps1)"
. "$(Join-Path $toolsDir dependenciesEnv.ps1)"

## Install QC:DE game mod
$url = Get-ModdbDlUrl 'https://www.moddb.com/downloads/start/133718'
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $installLocation
  url           = $url
  softwareName  = 'qc-doom-edition*'
  checksum      = '4B4E43245FBF3CBEBCF1B666546482D65F5D0D71F2DF7CED6ADF578EDC8623B6'
  checksumType  = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

## Install addon QC:DE Doom 4 Skin Pack v1.1.1
## https://www.moddb.com/mods/quake-champions-doom-edition/addons/qcde-doom-4-skin-pack
$url = Get-ModdbDlUrl 'https://www.moddb.com/addons/start/170672'
$packageArgs = @{
  packageName   = "$env:ChocolateyPackageName" + "D4T"
  unzipLocation = $installLocation
  url           = $url
  checksum      = '183A4B5002EC88CFAD0185D258343C387B557CF4B6D6F9EAD279EC008C1A3446'
  checksumType  = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

## Install addon QC:DE HD Portraits v2.5
## https://www.moddb.com/mods/quake-champions-doom-edition/downloads/qcde-hd-portraits
$url = Get-ModdbDlUrl 'https://www.moddb.com/downloads/start/136555'
$packageArgs = @{
  packageName   = "$env:ChocolateyPackageName" + "HD_Portraits"
  unzipLocation = $installLocation
  url           = $url
  checksum      = '54E7D9831C13B296836511DC2D570A7867B571C37FBA9B1F5F0B5BAB65C45B95'
  checksumType  = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

## Download & Convert game shortcuts icon
## https://zdoom.org/w/images/thumb/a/af/QCDE_logo.png/120px-QCDE_logo.png
$iconSrc = 'QCDE_logo.png'
$iconSrcPath = "$(Join-Path $ENV:TEMP $iconSrc)"
Get-ChocolateyWebFile -PackageName $iconSrc `
  -FileFullPath $iconSrcPath `
  -Url 'https://cdn.statically.io/img/zdoom.org/w/images/thumb/a/af/QCDE_logo.png/120px-QCDE_logo.png' `
  -Checksum 'B6A40C0F44E880F184F3D973A8F2D956D96FD0C6B0DB0BE023A16AC3D513A00F' `
  -ChecksumType 'sha256'
$iconName = 'QCDE_logo.ico'
$iconPath = "$(Join-Path $toolsDir $iconName)"
& png2ico.exe $iconPath $iconSrcPath


## StartMenu shortcuts
Install-ChocolateyShortcut -ShortcutFilePath "$(Join-Path $startMenuDir 'QCDE QuickGuide.lnk')" `
  -TargetPath "$(Join-Path $installLocation 'QCDE QuickGuide.txt')"
Install-ChocolateyShortcut -ShortcutFilePath "$(Join-Path $startMenuDir 'QCDE Readme.lnk')" `
  -TargetPath "$(Join-Path $installLocation 'QCDE Readme.txt')"
Install-ChocolateyShortcut -ShortcutFilePath "$(Join-Path $startMenuDir 'QCDE FAQ.lnk')" `
  -TargetPath "$(Join-Path $installLocation 'QCDE FAQ.txt')"
Install-ChocolateyShortcut -ShortcutFilePath "$(Join-Path $startMenuDir 'QCDE PvE Rebalance (2.5).lnk')" `
  -TargetPath "$(Join-Path $installLocation 'QCDE PvE Rebalance (2.5).txt')"
Install-ChocolateyShortcut -ShortcutFilePath "$(Join-Path $startMenuDir 'QCDE Changelog.lnk')" `
  -TargetPath "$(Join-Path $installLocation 'QCDE Changelog.txt')"

Install-ChocolateyShortcut -ShortcutFilePath "$(Join-Path $startMenuDir 'QCDE Doom1.lnk')" `
  -TargetPath "$zandronum" -Arguments "$ModPack `"$D4Tsprites`" `"$HDFaces`" -iwad $iWAD1" `
  -WorkingDirectory "$installLocation" `
  -IconLocation "$iconPath"
Install-ChocolateyShortcut -ShortcutFilePath "$(Join-Path $startMenuDir 'QCDE Doom2.lnk')" `
  -TargetPath "$zandronum" -Arguments "$ModPack `"$D4Tsprites`" `"$HDFaces`" -iwad $iWAD2" `
  -WorkingDirectory "$installLocation" `
  -IconLocation "$iconPath"


## StartMenu - Multiplayer shortcuts
$SMMultiplayerDir = "$(Join-Path $startMenuDir 'Multiplayer')"
Install-ChocolateyShortcut -ShortcutFilePath "$(Join-Path $SMMultiplayerDir 'QCD2E [MP] startServer [LAN].lnk')" `
  -TargetPath "$zandronum" -Arguments "$ModPack `"$D4Tsprites`" `"$HDFaces`" -iwad $iWAD2 -host -port 10666" `
  -WorkingDirectory "$installLocation"
Install-ChocolateyShortcut -ShortcutFilePath "$(Join-Path $SMMultiplayerDir 'QCD2E [MP] joinServer [LAN].lnk')" `
  -TargetPath "$zandronum" -Arguments "$ModPack `"$D4Tsprites`" `"$HDFaces`" -iwad $iWAD2 -connect 127.0.0.1:10666" `
  -WorkingDirectory "$installLocation"

## Desktop
Install-ChocolateyShortcut -ShortcutFilePath "$shortcutPath" `
  -TargetPath "$zandronum" -Arguments "$ModPack `"$D4Tsprites`" `"$HDFaces`" -iwad $iWAD2" `
  -WorkingDirectory "$installLocation" `
  -IconLocation "$iconPath"