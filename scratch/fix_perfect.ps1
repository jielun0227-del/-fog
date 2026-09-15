function u8($bytes) {
    return [System.Text.Encoding]::UTF8.GetString([byte[]]$bytes)
}

$brandName = u8 @(0xE6,0x9C,0xBA,0xE5,0x9C,0xBA,0x46,0x6F,0x67) # 机场Fog
$nav1 = u8 @(0xE6,0x9C,0xBA,0xE5,0x9C,0xBA,0xE6,0x8E,0xA8,0xE8,0x8D,0x90) # 机场推荐
$nav2 = u8 @(0xE7,0x9F,0xA5,0xE8,0xAF,0x86,0xE5,0xBA,0x93) # 知识库
$nav3 = u8 @(0xE6,0x95,0x87,0xE7,0xAB,0xA0,0xE7,0xA7,0x91,0xE6,0x99,0xAE) # 文章科普
$nav4 = u8 @(0xE8,0xAF,0xB8,0xE7,0xBB,0x86,0xE8,0xAF,0x84,0xE6,0xB5,0x8B) # 详细评测
$nav5 = u8 @(0xE5,0x85,0xB3,0xE4,0xBA,0x8E) # 关于

$siteTitle = u8 @(0xE6,0x9C,0xBA,0xE5,0x9C,0xBA,0x46,0x6F,0x67,0x20,0xE6,0xB5,0x8B,0xE8,0xAF,0x84,0xE5,0x8D,0x9A,0xE5,0xAE,0xA2) # 机场Fog 测评博客
$rightsText = u8 @(0xE4,0xBF,0x9D,0xE7,0x95,0x99,0xE6,0x8B,0x80,0xE6,0x9C,0x89,0xE6,0x9D,0x83,0xE5,0x88,0xA9,0xE3,0x80,0x82) # 保留所有权利。

$navHtml = @"
  <header class="navbar">
    <div class="nav-container">
      <a href="../index.html" class="logo">
        <span class="logo-icon">⚡</span>
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

$oldBrand1 = u8 @(0xE6,0xA4,0xB0,0xE6,0xB1,0x8D,0xE7,0xBD,0x91,0xE7,0xBB,0x9C,0xE6,0x97,0xA5,0xE5,0xBF,0x97) # 椰汁网络日志
$oldBrand2 = u8 @(0xE6,0xA4,0xB0,0xE6,0xB1,0x8D,0xE7,0xBD,0x91,0xE7,0xBB,0x9C) # 椰汁网络
$oldBrand3 = u8 @(0xE6,0xA4,0xB0,0xE6,0xB1,0x8D,0xE8,0xAF,0x84,0xE6,0xB5,0x8B,0xE7,0xBB,0x84) # 椰汁评测组
$oldBrand4 = u8 @(0xE6,0xA4,0xB0,0xE6,0xB1,0x8D) # 椰汁

$newTeam = u8 @(0xE6,0x9C,0xBA,0xE5,0x9C,0xBA,0x46,0x6F,0x67,0x20,0xE6,0xB5,0x8B,0xE8,0xAF,0x84,0xE5,0x9B,0xA2,0xE9,0x98,0x9F) # 机场Fog 测评团队

$opt = [System.Text.RegularExpressions.RegexOptions]::Singleline
$headerRegex = New-Object System.Text.RegularExpressions.Regex('(?s)<header[^>]*>.*?</header>', $opt)
$footerRegex = New-Object System.Text.RegularExpressions.Regex('(?s)<footer[^>]*>.*?</footer>', $opt)
$utf8NoBOM = New-Object System.Text.UTF8Encoding($false)

$htmlFiles = Get-ChildItem -Path ".\articles" -Filter "*.html"

foreach ($file in $htmlFiles) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)

    # Clean garbled text remnants if any
    $content = $content.Replace($oldBrand1, $siteTitle)
    $content = $content.Replace($oldBrand3, $newTeam)
    $content = $content.Replace($oldBrand2, $siteTitle)
    $content = $content.Replace($oldBrand4, $brandName)

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

Write-Output "PERFECT_CLEAN_FINISHED"
