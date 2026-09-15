$allHtmlFiles = Get-ChildItem -Path "." -Recurse -Filter "*.html" | Where-Object { $_.FullName -notmatch '\\scratch\\' }
$utf8NoBOM = New-Object System.Text.UTF8Encoding($false)

foreach ($file in $allHtmlFiles) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    if ($content.Contains('data-theme="dark"')) {
        $content = $content.Replace('data-theme="dark"', 'data-theme="light"')
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBOM)
        Write-Host "Updated $($file.Name)"
    }
}
