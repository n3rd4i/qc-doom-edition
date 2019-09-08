## Common between Install and Uninstall
$GameName = "QuakeChampions Doom Edition"
$installLocation = [IO.Path]::Combine($ENV:LocalAppData, 'Programs', "$GameName")
$startMenuDir = [IO.Path]::Combine($ENV:AppData, 'Microsoft\Windows\Start Menu\Programs', "$GameName")
$shortcutPath = [IO.Path]::Combine($ENV:UserProfile, 'Desktop', "$GameName.lnk")

$ModName = "QCDEv$ENV:ChocolateyPackageVersion"
$ModPack = "$ModName.pk3"
