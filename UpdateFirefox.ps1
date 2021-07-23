$Pathx64 = "${env:Programw6432}\Mozilla Firefox\uninstall"
$Pathx86 = "${env:ProgramFiles(x86)}\Mozilla Firefox\uninstall"
$HelperPath = "C:\_Administration"
$DownloadLink = "https://ftp.mozilla.org/pub/firefox/releases/90.0b12/win64/de/Firefox%20Setup%2090.0b12.msi"

If(!(test-path $HelperPath))
{
      New-Item -ItemType Directory -Force -Path $HelperPath
}

if ((Test-Path $Pathx86) -eq $true) {
    Write-Host "I have x86 installed"
    $32BitIsInstalled = $true
    $Versionx86 = &"${env:ProgramFiles(x86)}\Mozilla Firefox\firefox.exe" -v | more
    $Versionx86 = $Versionx86.TrimStart("Mozilla Firefox")
    Write-Host "Version: $Verionx86"
    $DoUninstallx86 = &"${env:ProgramFiles(x86)}\Mozilla Firefox\uninstall\helper.exe" /S

}

if ((Test-Path $Pathx64) -eq $true) {
    write-host "I have x64 FireFox"
    $Versionx64 = &"${env:Programw6432}\Mozilla Firefox\firefox.exe" -v | more
    $Versionx64 = $Versionx64.TrimStart("Mozilla Firefox")
    Write-Host "Version: $Versionx64"
    wget $DownloadLink -OutFile $HelperPath\FireFox.msi
    $DoUninstallx64 = &"${env:Programw6432}\Mozilla Firefox\uninstall\helper.exe" /S
    wget $DownloadLink -OutFile $HelperPath\FireFox.msi
    taskkill /im "firefox.exe"
    $DoInstallx63 = &"$HelperPath\FireFox.msi" /qn
    $NewVersionx64 = &"${env:Programw6432}\Mozilla Firefox\firefox.exe" -v | more
    Write-Host "Now I have $NewVersionx64"
}