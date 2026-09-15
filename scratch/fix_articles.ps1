$allHtmlFiles = Get-ChildItem -Path "." -Recurse -Filter "*.html" | Where-Object { $_.FullName -notmatch '\\scratch\\' }

$standardNavbarArticle = @"
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

$standardFooter = @"
  <footer class="site-footer">
    <div class="container">
      <p>&copy; 2026 机场Fog 测评博客. 保留所有权利。</p>
    </div>
  </footer>
"@

$utf8NoBOM = New-Object System.Text.UTF8Encoding($false)

foreach ($file in $allHtmlFiles) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)

    # Global text cleanups
    $content = $content.Replace("椰汁网络日志", "机场Fog 测评博客")
    $content = $content.Replace("椰汁评测组", "机场Fog 测评团队")
    $content = $content.Replace("椰汁网络", "机场Fog 测评博客")
    $content = $content.Replace("椰汁", "机场Fog")

    # If it's inside articles directory
    if ($file.DirectoryName -match "articles") {
        # 1. Replace css path
        $content = [regex]::Replace($content, 'href=["''][^"'']*css/style\.css["'']', 'href="../styles.css"')
        if ($content -notmatch 'styles\.css') {
            $content = $content.Replace('</head>', "  <link rel=""stylesheet"" href=""../styles.css"">`n</head>")
        }

        # 2. Replace header
        if ($content -match '(?s)<header[^>]*>.*?</header>') {
            $content = [regex]::Replace($content, '(?s)<header[^>]*>.*?</header>', $standardNavbarArticle)
        } else {
            $content = [regex]::Replace($content, '(?i)<body[^>]*>', "$0`n$standardNavbarArticle")
        }

        # 3. Replace footer
        if ($content -match '(?s)<footer[^>]*>.*?</footer>') {
            $content = [regex]::Replace($content, '(?s)<footer[^>]*>.*?</footer>', $standardFooter)
        }
    }

    [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBOM)
    Write-Output "Cleaned: $($file.Name)"
}
Write-Output "Global cleanup completed successfully."
