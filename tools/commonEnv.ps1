## Common between Install and Uninstall
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$GameName = "QuakeChampions Doom Edition"
$installLocation = "$(Join-Path $toolsDir $GameName)"
$startMenuDir = [IO.Path]::Combine($ENV:ProgramData, 'Microsoft\Windows\Start Menu\Programs', $GameName)

$ModPack = "QCDEv2.5.1.pk3"
$D4Tsprites = 'QCDE D4T New Sprites v1.1.1.pk3'
$HDFaces = 'QCDE--HDfaces2.5.pk3'
