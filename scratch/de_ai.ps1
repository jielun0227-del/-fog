$files = Get-ChildItem -Path "articles\*.html"
foreach ($f in $files) {
    $c = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
    $c = $c -replace '<div class="logo-icon">\s*🚀\s*</div>', ''
    $c = $c -replace '<span class="search-shortcut">⌘ K</span>', ''
    $c = $c -replace '🚀', ''
    $c = $c -replace '📌', ''
    $c = $c -replace '📑', ''
    $c = $c -replace '⚡', ''
    $c = $c -replace '💡', ''
    $c = $c -replace '✨', ''
    [System.IO.File]::WriteAllText($f.FullName, $c, [System.Text.Encoding]::UTF8)
}
Write-Host "Done cleaning articles."
