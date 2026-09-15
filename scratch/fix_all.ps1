$files = Get-ChildItem "articles/*.html"
foreach ($f in $files) {
    $raw = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
    if ($raw.Contains("椰汁网络日志") -or $raw.Contains("椰汁网络") -or $raw.Contains("../css/style.css")) {
        $clean = $raw
        $clean = $clean.Replace(" - 椰汁网络日志", " - 机场Fog 测评博客")
        $clean = $clean.Replace(" - 椰汁网络", " - 机场Fog 测评博客")
        $clean = $clean.Replace("../css/style.css", "../styles.css")
        $clean = $clean.Replace("css/style.css", "styles.css")
        $clean = $clean.Replace("<span>椰汁网络日志</span><div class=""logo-dot""></div>", "<span>机场推荐与测评</span>")
        $clean = $clean.Replace("<span>椰汁网络日志</span>", "<span>机场推荐与测评</span>")
        $clean = $clean.Replace("椰汁网络日志", "机场Fog 测评博客")
        $clean = $clean.Replace("椰汁网络", "机场Fog")

        if ($clean.Contains('<div class="nav-menu"')) {
            $oldNavPattern = '(?s)<div class="nav-menu".*?</div>'
            $newNav = '<nav class="nav-links"><a href="../index.html#airports-table" class="nav-link">机场推荐</a><a href="../knowledge.html" class="nav-link">知识库</a><a href="../articles.html" class="nav-link">文章科普</a><a href="../reviews.html" class="nav-link active">详细评测</a><a href="../about.html" class="nav-link">关于</a></nav>'
            $clean = [regex]::Replace($clean, $oldNavPattern, $newNav)
        }

        if ($clean.Contains('<footer class="footer">')) {
            $oldFooterPattern = '(?s)<footer class="footer">.*?</footer>'
            $newFooter = '<footer class="site-footer"><div class="footer-container"><p class="copyright">© 2026 机场Fog测评博客. 保留所有权利。</p><p class="disclaimer">声明：本站提供的内容仅供网络技术交流与学术研究参考，请遵守当地法律法规。</p></div></footer>'
            $clean = [regex]::Replace($clean, $oldFooterPattern, $newFooter)
        }

        [System.IO.File]::WriteAllText($f.FullName, $clean, [System.Text.Encoding]::UTF8)
        Write-Host "Cleaned file: $($f.Name)"
    }
}
