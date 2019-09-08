$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$(Join-Path $toolsDir commonEnv.ps1)"
. "$(Join-Path $toolsDir dependenciesEnv.ps1)"

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

# https://zdoom.org/w/images/thumb/a/af/QCDE_logo.png/120px-QCDE_logo.png
$iconSrc = 'QCDE_logo.png'
$iconSrcPath = "$(Join-Path $ENV:TEMP $iconSrc)"
Get-ChocolateyWebFile -PackageName "$iconSrc" `
  -FileFullPath $iconSrcPath `
  -Url 'https://cdn.statically.io/img/zdoom.org/w/images/thumb/a/af/QCDE_logo.png/120px-QCDE_logo.png' `
  -Checksum 'CC23A9F1355EC724679D4804007F58E94F9E89AFC2ADDDA15B786C45561A33FF' `
  -ChecksumType 'sha256'

$iconName = 'QCDE_logo.ico'
$iconPath = "$(Join-Path $toolsDir $iconName)"
& png2ico.exe $iconPath $iconSrcPath

## StartMenu
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
  -TargetPath "$zandronum" -Arguments "$ModPack -iwad $iWAD1" `
  -WorkingDirectory "$installLocation" `
  -IconLocation "$iconPath"
Install-ChocolateyShortcut -ShortcutFilePath "$(Join-Path $startMenuDir 'QCDE Doom2.lnk')" `
  -TargetPath "$zandronum" -Arguments "$ModPack -iwad $iWAD2" `
  -WorkingDirectory "$installLocation" `
  -IconLocation "$iconPath"

## StartMenu - Multiplayer
$SMMultiplayerDir = "$(Join-Path $startMenuDir 'Multiplayer')"
Install-ChocolateyShortcut -ShortcutFilePath "$(Join-Path $SMMultiplayerDir 'QCD2E [MP] startServer [LAN].lnk')" `
  -TargetPath "$zandronum" -Arguments "$ModPack -iwad $iWAD2 -host -port 10666" `
  -WorkingDirectory "$installLocation"
Install-ChocolateyShortcut -ShortcutFilePath "$(Join-Path $SMMultiplayerDir 'QCD2E [MP] joinServer [LAN].lnk')" `
  -TargetPath "$zandronum" -Arguments "$ModPack -iwad $iWAD2 -connect 127.0.0.1:10666" `
  -WorkingDirectory "$installLocation"

## Desktop
Install-ChocolateyShortcut -ShortcutFilePath "$shortcutPath" `
  -TargetPath "$zandronum" -Arguments "$ModPack -iwad $iWAD2" `
  -WorkingDirectory "$installLocation" `
  -IconLocation "$iconPath"
