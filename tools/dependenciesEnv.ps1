$zandronumLocation = "$ENV:ZANDRONUM_INSTALL_DIR"
$zandronum = "$(Join-Path $zandronumLocation zandronum.exe)"

# $freedoomLocation = [IO.Path]::Combine($ENV:LocalAppData, 'Programs', 'FreeDoom')
# $freeDoomTools = [IO.Path]::Combine($ENV:ChocolateyInstall, 'lib', 'freedoom', 'tools')

# located in $ENV:DOOMWADDIR
$iWAD1 = "freedoom1.wad"
$iWAD2 = "freedoom2.wad"
