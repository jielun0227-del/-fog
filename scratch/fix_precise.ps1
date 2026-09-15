$brandName = "$([char]0x673A)$([char]0x573A)Fog"
$nav1 = "$([char]0x673A)$([char]0x573A)$([char]0x63A8)$([char]0x8350)" # 机场推荐
$nav2 = "$([char]0x77E5)$([char]0x8B66)$([char]0x5E93)" # 知识库
$nav3 = "$([char]0x6587)$([char]0x7AE0)$([char]0x79D1)$([char]0x666E)" # 文章科普
$nav4 = "$([char]0x8BE6)$([char]0x7EC6)$([char]0x8BC4)$([char]0x6D4B)" # 详细评测
$nav5 = "$([char]0x5173)$([char]0x4E8E)" # 关于
$siteTitle = "$([char]0x673A)$([char]0x573A)Fog $([char]0x8BC4)$([char]0x6D4B)$([char]0x535A)$([char]0x5BA2)" # 机场Fog 测评博客
$teamTitle = "$([char]0x673A)$([char]0x573A)Fog $([char]0x8BC4)$([char]0x6D4B)$([char]0x56E2)$([char]0x961F)" # 机场Fog 测评团队
$rightsText = "$([char]0x4BFD)$([char]0x7559)$([char]0x6240)$([char]0x6709)$([char]0x6743)$([char]0x5229)$([char]0x3002)" # 保留所有权利。
$zap = "$([char]0x26A1)"

$old1 = "$([char]0x690F)$([char]0x6C41)$([char]0x7F51)$([char]0x7EDC)$([char]0x65E5)$([char]0x5FD7)" # 椰汁网络日志
$old2 = "$([char]0x690F)$([char]0x6C41)$([char]0x8BC4)$([char]0x6D4B)$([char]0x7EC4)" # 椰汁评测组
$old3 = "$([char]0x690F)$([char]0x6C41)$([char]0x7F51)$([char]0x7EDC)" # 椰汁网络
$old4 = "$([char]0x690F)$([char]0x6C41)" # 椰汁

$navHtml = @"
  <header class="navbar">
    <div class="nav-container">
      <a href="../index.html" class="logo">
        <span class="logo-icon">$zap</span>
        <span class="logo-text">$brandName</span>
      </a>
      <nav class="nav-links">
        <a href="../index.html">$nav1</a>
        <a href="../knowledge.html">$nav2</a>
        <a href="../articles.html">$nav3</a>
        <a href="../reviews.html">$nav4</a>
        <a href="../about.html">$nav5</a>
      </nav>
    </div>
  </header>
"@

$footerHtml = @"
  <footer class="site-footer">
    <div class="container">
      <p>&copy; 2026 $siteTitle. $rightsText</p>
    </div>
  </footer>
"@

$opt = [System.Text.RegularExpressions.RegexOptions]::Singleline
$headerRegex = New-Object System.Text.RegularExpressions.Regex('<header[^>]*>.*?</header>', $opt)
$footerRegex = New-Object System.Text.RegularExpressions.Regex('<footer[^>]*>.*?</footer>', $opt)
$utf8NoBOM = New-Object System.Text.UTF8Encoding($false)

$htmlFiles = Get-ChildItem -Path ".\articles" -Filter "*.html"

foreach ($file in $htmlFiles) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)

    # Replace legacy title and text names
    $content = $content -replace [regex]::Escape($old1), $siteTitle
    $content = $content -replace [regex]::Escape($old2), $teamTitle
    $content = $content -replace [regex]::Escape($old3), $siteTitle
    $content = $content -replace [regex]::Escape($old4), $brandName

    # CSS fix
    $content = [regex]::Replace($content, 'href=["''][^"'']*css/style\.css["'']', 'href="../styles.css"')

    if ($content -notmatch 'styles\.css') {
        $content = $content.Replace('</head>', "  <link rel=""stylesheet"" href=""../styles.css"">`n</head>")
    }

    # Replace ALL headers with clean navHtml once
    $content = $headerRegex.Replace($content, '')
    $content = [regex]::Replace($content, '(?i)<body[^>]*>', "`$0`n$navHtml")

    # Replace ALL footers with clean footerHtml once
    $content = $footerRegex.Replace($content, '')
    $content = $content.Replace('</body>', "$footerHtml`n</body>")

    [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBOM)
    Write-Output "Cleaned $($file.Name)"
}

Write-Output "PRECISE_SUCCESS"
