$files = Get-ChildItem articles/*.html
foreach ($f in $files) {
    $txt = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
    $modified = $false
    if ($txt.Contains("椰汁网络日志") -or $txt.Contains("椰汁网络")) {
        $txt = $txt.Replace("椰汁网络日志", "机场Fog 测评博客").Replace("椰汁网络", "机场Fog")
        $modified = $true
    }
    if ($txt.Contains("css/style.css")) {
        $txt = $txt.Replace("css/style.css", "styles.css")
        $modified = $true
    }
    if ($txt.Contains("棣栭〉")) {
        $txt = $txt.Replace("棣栭〉", "首页").Replace("鏂囩珷绉戞櫘", "文章科普")
        $modified = $true
    }
    if ($modified) {
        [System.IO.File]::WriteAllText($f.FullName, $txt, [System.Text.Encoding]::UTF8)
        Write-Host "Updated: $($f.Name)"
    }
}
