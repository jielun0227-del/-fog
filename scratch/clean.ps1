$r = [char]::ConvertFromUtf32(0x1F680)
$p = [char]::ConvertFromUtf32(0x1F4CC)
$b = [char]::ConvertFromUtf32(0x1F4CA)
$s = [char]::ConvertFromUtf32(0x1F6E1)
$f = [char]::ConvertFromUtf32(0x26A1)

$files = Get-ChildItem -Path "articles\*.html"
foreach ($file in $files) {
    $txt = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $txt = $txt.Replace('<div class="logo-icon">', '').Replace('</div>', '')
    $txt = $txt.Replace('<span class="search-shortcut">⌘ K</span>', '')
    $txt = $txt.Replace($r, '').Replace($p, '').Replace($b, '').Replace($s, '').Replace($f, '')
    [System.IO.File]::WriteAllText($file.FullName, $txt, [System.Text.Encoding]::UTF8)
}
Write-Host "Articles cleaned successfully."
