function b64($s) {
    return [System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($s))
}

$articlesDir = ".\articles"
$htmlFiles = Get-ChildItem -Path $articlesDir -Filter "*.html"

# Base64 encoded UTF-8 strings
$str1_old = b64 "5qSS5rax572R57uc6Z2Z5b+X" # 椰汁网络日志
$str1_new = b64 "gLu6uuiZlUZvZyDmtYvor4TmsJrmgqA=" # 机场Fog 测评博客

$str2_old = b64 "5qSS5rax6K+E5b2p57uE" # 椰汁评测组
$str2_new = b64 "gLu6uuiZlUZvZyDmtYvor4TZgouYnQ==" # 机场Fog 测评团队

$str3_old = b64 "5qSS5rax572R57uc" # 椰汁网络
$str3_new = b64 "gLu6uuiZlUZvZyDmtYvor4TmsJrmgqA=" # 机场Fog 测评博客

$str4_old = b64 "5qSS5rax" # 椰汁
$str4_new = b64 "gLu6uuiZgA==" # 机场Fog

# Standard Navbar HTML encoded in Base64
$nav_b64 = "ICA8aGVhZGVyIGNsYXNzPSJuYXZiYXIiPgogICAgPGRpdiBjbGFzcz0ibmF2LWNvbnRhaW5lciI+CiAgICAgIDxhIGhyZWY9Ii4uL2luZGV4Lmh0bWwiIGNsYXNzPSJsb2dvIj4KICAgICAgICA8c3BhbiBjbGFzcz0ibG9nby1pY29uIj7imqE8L3NwYW4+CiAgICAgICAgPHNwYW4gY2xhc3M9ImxvZ28tdGV4dCI+uLrqmZVGb2c8L3NwYW4+CiAgICAgIDwvYT4KICAgICAgPG5hdiBjbGFzcz0ibmF2LWxpbmtzIj4KICAgICAgICA8YSBocmVmPSIuLi9pbmRleC5odG1sIj66urrWu+iOszwvYT4KICAgICAgICA8YSBocmVmPSIuLi9rbm93bGVkZ2UuaHRtbCI+16qTseW6jzwvYT4KICAgICAgICA8YSBocmVmPSIuLi9hcnRpY2xlcy5odG1sIj6msL2Bp+6A4jwvYT4KICAgICAgICA8YSBocmVmPSIuLi9yZXZpZXdzLmh0bWwiPsa5tL7GsL2BPC9hPgogICAgICAgIDxhIGhyZWY9Ii4uL2Fib3V0Lmh0bWwiPrNxw7g8L2E+CiAgICAgIDwvbmF2PgogICAgPC9kaXY+CiAgPC9oZWFkZXI+"
$nav = b64 $nav_b64

# Standard Footer HTML encoded in Base64
$ftr_b64 = "ICA8Zm9vdGVyIGNsYXNzPSJzaXRlLWZvb3RlciI+CiAgICA8ZGl2IGNsYXNzPSJjb250YWluZXIiPgogICAgICA8cD4mY29weTsgMjAyNiC6uuqZlUZvZyDmtYvor4TmsJrmgqAuILGmvN7Rhb/l0KeAod48L3A+CiAgICA8L2Rpdj4KICA8L2Zvb3Rlcj4="
$ftr = b64 $ftr_b64

$opt = [System.Text.RegularExpressions.RegexOptions]::Singleline
$headerRegex = New-Object System.Text.RegularExpressions.Regex('<header[^>]*>.*?</header>', $opt)
$footerRegex = New-Object System.Text.RegularExpressions.Regex('<footer[^>]*>.*?</footer>', $opt)
$utf8NoBOM = New-Object System.Text.UTF8Encoding($false)

foreach ($file in $htmlFiles) {
    $raw = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    $clean = $raw.Replace($str1_old, $str1_new)
    $clean = $clean.Replace($str2_old, $str2_new)
    $clean = $clean.Replace($str3_old, $str3_new)
    $clean = $clean.Replace($str4_old, $str4_new)

    $clean = [regex]::Replace($clean, 'href=["''][^"'']*css/style\.css["'']', 'href="../styles.css"')

    if ($clean -notmatch 'styles\.css') {
        $clean = $clean.Replace('</head>', "  <link rel=""stylesheet"" href=""../styles.css"">`n</head>")
    }

    if ($headerRegex.IsMatch($clean)) {
        $clean = $headerRegex.Replace($clean, $nav)
    } else {
        $clean = [regex]::Replace($clean, '(?i)<body[^>]*>', "`$0`n$nav")
    }

    if ($footerRegex.IsMatch($clean)) {
        $clean = $footerRegex.Replace($clean, $ftr)
    } else {
        $clean = $clean.Replace('</body>', "$ftr`n</body>")
    }

    [System.IO.File]::WriteAllText($file.FullName, $clean, $utf8NoBOM)
    Write-Output "Processed $($file.Name)"
}
Write-Output "ALL_DONE"
