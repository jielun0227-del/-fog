$files = Get-ChildItem "articles/*.html"
foreach ($f in $files) {
    $bytes = [System.IO.File]::ReadAllBytes($f.FullName)
    $text = [System.Text.Encoding]::UTF8.GetString($bytes)
    
    if ($text.Contains("椰汁网络日志") -or $text.Contains("椰汁网络") -or $text.Contains("../css/style.css") -or $text.Contains("nav-menu")) {
        $text = $text.Replace(" - 椰汁网络日志", " - 机场Fog 测评博客")
        $text = $text.Replace(" - 椰汁网络", " - 机场Fog 测评博客")
        $text = $text.Replace("椰汁网络日志", "机场Fog 测评博客")
        $text = $text.Replace("椰汁网络", "机场Fog")
        $text = $text.Replace("../css/style.css", "../styles.css")
        $text = $text.Replace("css/style.css", "styles.css")

        # Standard Header Replacement
        if ($text.Contains('<header class="header">')) {
            $oldHeaderPattern = '(?s)<header class="header">.*?</header>'
            $newHeader = '<header class="navbar"><div class="nav-container"><a href="../index.html" class="brand-title"><span>机场推荐与测评</span></a><div class="nav-search"><span class="search-icon">🔍</span><input type="text" id="globalSearchInput" placeholder="搜索机场名称、线路类型或特色..." /></div><nav class="nav-links"><a href="../index.html#airports-table" class="nav-link">机场推荐</a><a href="../knowledge.html" class="nav-link">知识库</a><a href="../articles.html" class="nav-link">文章科普</a><a href="../reviews.html" class="nav-link active">详细评测</a><a href="../about.html" class="nav-link">关于</a></nav><div class="nav-actions"><button id="themeToggleBtn" class="theme-toggle-btn" title="切换深色/浅色模式"><span class="sun-icon">☀️</span><span class="moon-icon">🌙</span></button></div></div></header>'
            $text = [regex]::Replace($text, $oldHeaderPattern, $newHeader)
        }

        # Standard Footer Replacement
        if ($text.Contains('<footer class="footer">')) {
            $oldFooterPattern = '(?s)<footer class="footer">.*?</footer>'
            $newFooter = '<footer class="site-footer"><div class="footer-container"><p class="copyright">© 2026 机场Fog测评博客. 保留所有权利。</p><p class="disclaimer">声明：本站提供的内容仅供网络技术交流与学术研究参考，请遵守当地法律法规。</p></div></footer><script src="../script.js"></script>'
            $text = [regex]::Replace($text, $oldFooterPattern, $newFooter)
        }

        $outBytes = [System.Text.Encoding]::UTF8.GetBytes($text)
        [System.IO.File]::WriteAllBytes($f.FullName, $outBytes)
        Write-Host "Standardized: $($f.Name)"
    }
}
