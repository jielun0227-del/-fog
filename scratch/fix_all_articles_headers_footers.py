import glob
import re

files = glob.glob('articles/*.html')

clean_header = """  <!-- Header / Navigation Bar -->
  <header class="navbar">
    <div class="nav-container">
      <a href="../index.html" class="brand-title">
        <span>机场推荐</span>
      </a>

      <div class="nav-search">
        <span class="search-icon">🔍</span>
        <input type="text" placeholder="搜索文章、节点..." onclick="window.location.href='../articles.html'" />
      </div>

      <nav class="nav-links">
        <a href="../index.html#airports-table" class="nav-link">机场推荐</a>
        <a href="../knowledge.html" class="nav-link">知识库</a>
        <a href="../articles.html" class="nav-link active">文章科普</a>
        <a href="../reviews.html" class="nav-link">详细评测</a>
      </nav>

      <div class="nav-actions">
        <button id="themeToggleBtn" class="theme-toggle-btn" title="切换深色/浅色模式">
          <span class="sun-icon">☀️</span>
          <span class="moon-icon">🌙</span>
        </button>
      </div>
    </div>
  </header>"""

clean_footer = """  <!-- Footer Section -->
  <footer class="site-footer">
    <div class="footer-container">
      <div class="footer-col brand-col">
        <h3>机场推荐</h3>
        <p>2026 最新机场推荐指南，提供客观、透明、验证的科学上网与 VPN 线路测试。</p>
        <p class="copyright">© 2026 机场推荐. All Rights Reserved.</p>
      </div>
      <div class="footer-col">
        <h4>快速导航</h4>
        <ul>
          <li><a href="../index.html#airports-table">对比大表</a></li>
          <li><a href="../knowledge.html">知识库</a></li>
          <li><a href="../articles.html">文章科普</a></li>
          <li><a href="../reviews.html">详细评测</a></li>
        </ul>
      </div>
    </div>
  </footer>"""

for fpath in files:
    with open(fpath, 'r', encoding='utf-8', errors='ignore') as f:
        content = f.read()

    # Replace header block
    content = re.sub(r'<header class="navbar">.*?</header>', clean_header, content, flags=re.DOTALL)
    # Replace footer block
    content = re.sub(r'<footer class="site-footer">.*?</footer>', clean_footer, content, flags=re.DOTALL)

    # Clean up any residual garbled tokens
    garbled_patterns = [
        "鏈哄満", "鎺ㄨ崘", "娴 expose", "娴 cross", "娴 custom", "娴 test", "娴 size", "娴", "֪ʶ",
        "Ƽ", "¿", "ϸ", "Աȴ", "֪ʶ", "лɫ/ǳɫģʽ", "ҳ", "? 2026", "锟斤拷"
    ]
    
    # Specific targeted replacements for breadcrumbs or titling if present
    content = content.replace('鏈哄満鎺ㄨ崘', '机场推荐')
    content = content.replace('鏈哄満', '机场')
    content = content.replace('鎺ㄨ崘', '推荐')
    content = content.replace('֪ʶ庫', '知识库')
    content = content.replace('文章科普', '文章科普')

    with open(fpath, 'w', encoding='utf-8') as f:
        f.write(content)

print(f"Successfully fixed headers and footers for {len(files)} article files.")
