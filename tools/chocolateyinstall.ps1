$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$(Join-Path $toolsDir commonEnv.ps1)"
. "$(Join-Path $toolsDir dependenciesEnv.ps1)"

## Install QC:DE game mod
$url = Get-ModdbDlUrl 'https://www.moddb.com/downloads/start/133718'
$packageArgs = @{
  packageName   = "$env:ChocolateyPackageName-mod"
  unzipLocation = $installLocation
  url           = $url
  checksum      = '3A8F35765E688F5EB9AA8A39C46D76F68692088A10BFD4EA45F591DDB7FAE054'
  checksumType  = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

## Install addon QC:DE Doom 4 Skin Pack v1.1.1
## https://www.moddb.com/mods/quake-champions-doom-edition/addons/qcde-doom-4-skin-pack
$url = Get-ModdbDlUrl 'https://www.moddb.com/addons/start/170672'
$packageArgs = @{
  packageName   = "$env:ChocolateyPackageName-d4-skin-pack"
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
  packageName   = "$env:ChocolateyPackageName-hd-portraits"
  unzipLocation = $installLocation
  url           = $url
  checksum      = '2F735F20031CB4902FE7BC812A99B0DF38BD51A7D375B6F7A9C1D6283E7D047A'
  checksumType  = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

$url = Get-ModdbDlUrl 'https://www.moddb.com/downloads/start/133876'
$packageArgs = @{
  packageName   = "$env:ChocolateyPackageName-mp-maps"
  unzipLocation = $installLocation
  url           = $url
  checksum      = '187C097B77048778DBD1203163DD6847D6C5DEF85BCFECF87D4D89EA50CBB871'
  checksumType  = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

## Download & Convert game shortcuts icon
## https://doomwiki.org/w/images/thumb/a/af/QCDE_logo.png/240px-QCDE_logo.png
$iconSrc = 'QCDE_logo.png'
$iconSrcPath = "$(Join-Path $ENV:TEMP $iconSrc)"
Get-ChocolateyWebFile -PackageName $iconSrc `
  -FileFullPath $iconSrcPath `
  -Url 'https://cdn.statically.io/img/doomwiki.org/w/images/thumb/a/af/QCDE_logo.png/240px-QCDE_logo.png' `
  -Checksum 'BFB51EE411113C140E092B3D586CBAE8593AF501FA0A6DC7D9AE072486BD5DCE' `
  -ChecksumType 'sha256'
$iconName = 'QCDE_logo.ico'
$iconPath = "$(Join-Path $toolsDir $iconName)"
& png2ico.exe $iconPath $iconSrcPath


## StartMenu shortcuts
Install-ChocolateyShortcut -ShortcutFilePath "$(Join-Path $startMenuDir 'QCDE Manual 2.7.lnk')" `
  -TargetPath "$(Join-Path $installLocation 'QCDE Manual 2.7.pdf')"
Install-ChocolateyShortcut -ShortcutFilePath "$(Join-Path $startMenuDir 'QCDE QuickGuide.lnk')" `
  -TargetPath "$(Join-Path $installLocation 'QCDE QuickGuide.txt')"
Install-ChocolateyShortcut -ShortcutFilePath "$(Join-Path $startMenuDir 'QCDE Readme.lnk')" `
  -TargetPath "$(Join-Path $installLocation 'QCDE Readme.txt')"
Install-ChocolateyShortcut -ShortcutFilePath "$(Join-Path $startMenuDir 'QCDE MapList.lnk')" `
  -TargetPath "$(Join-Path $installLocation 'QCDEmaps MapList')"
Install-ChocolateyShortcut -ShortcutFilePath "$(Join-Path $startMenuDir 'QCDE FAQ.lnk')" `
  -TargetPath "$(Join-Path $installLocation 'QCDE FAQ.txt')"
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
  -TargetPath "$zandronum" -Arguments "$ModPack `"$D4Tsprites`" `"$HDFaces`" `"$MPMaps`" -iwad $iWAD2 -host -port 10666" `
  -WorkingDirectory "$installLocation"
Install-ChocolateyShortcut -ShortcutFilePath "$(Join-Path $SMMultiplayerDir 'QCD2E [MP] joinServer [LAN].lnk')" `
  -TargetPath "$zandronum" -Arguments "$ModPack `"$D4Tsprites`" `"$HDFaces`" `"$MPMaps`" -iwad $iWAD2 -connect 127.0.0.1:10666" `
  -WorkingDirectory "$installLocation"
