$articlesDir = ".\articles"
$htmlFiles = Get-ChildItem -Path $articlesDir -Filter "*.html"

$nav = @"
  <header class="navbar">
    <div class="nav-container">
      <a href="../index.html" class="logo">
        <span class="logo-icon">⚡</span>
        <span class="logo-text">机场Fog</span>
      </a>
      <nav class="nav-links">
        <a href="../index.html">机场推荐</a>
        <a href="../knowledge.html">知识库</a>
        <a href="../articles.html">文章科普</a>
        <a href="../reviews.html">详细评测</a>
        <a href="../about.html">关于</a>
      </nav>
    </div>
  </header>
"@

$ftr = @"
  <footer class="site-footer">
    <div class="container">
      <p>&copy; 2026 机场Fog 测评博客. 保留所有权利。</p>
    </div>
  </footer>
"@

$opt = [System.Text.RegularExpressions.RegexOptions]::Singleline
$headerRegex = New-Object System.Text.RegularExpressions.Regex('<header[^>]*>.*?</header>', $opt)
$footerRegex = New-Object System.Text.RegularExpressions.Regex('<footer[^>]*>.*?</footer>', $opt)
$utf8NoBOM = New-Object System.Text.UTF8Encoding($false)

foreach ($file in $htmlFiles) {
    $raw = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    $clean = $raw.Replace('椰汁网络日志', '机场Fog 测评博客')
    $clean = $clean.Replace('椰汁评测组', '机场Fog 测评团队')
    $clean = $clean.Replace('椰汁网络', '机场Fog 测评博客')
    $clean = $clean.Replace('椰汁', '机场Fog')
    $clean = $clean.Replace('href="../css/style.css"', 'href="../styles.css"')
    $clean = $clean.Replace('href="css/style.css"', 'href="../styles.css"')

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
    Write-Output "Cleaned $($file.Name)"
}
Write-Output "Done!"
