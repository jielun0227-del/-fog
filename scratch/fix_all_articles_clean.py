import os, glob

NAV_HTML = """      <nav class="nav-links">
        <a href="../index.html#airports-table" class="nav-link">机场推荐</a>
        <a href="../knowledge.html" class="nav-link">知识库</a>
        <a href="../articles.html" class="nav-link active">文章科普</a>
        <a href="../reviews.html" class="nav-link">详细评测</a>
        <a href="../about.html" class="nav-link">关于</a>
      </nav>"""

FOOTER_HTML = """  <footer class="site-footer">
    <div class="footer-container">
      <div class="footer-col brand-col">
        <h3>机场推荐与测评</h3>
        <p>2026 最新机场推荐与测评指南，致力于提供客观、透明、可验证的科学上网与 VPN 线路测试。</p>
        <p class="copyright">© 2026 机场Fog测评博客. 保留所有权利。</p>
      </div>
      <div class="footer-col">
        <h4>快速导航</h4>
        <ul>
          <li><a href="../index.html#airports-table">机场对比大表</a></li>
          <li><a href="../knowledge.html">知识库中心</a></li>
          <li><a href="../articles.html">文章科普</a></li>
          <li><a href="../reviews.html">详细评测</a></li>
          <li><a href="../about.html">关于我们</a></li>
        </ul>
      </div>
    </div>
  </footer>"""

def fix_file(filepath):
    with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
        content = f.read()
    
    # Replace obsolete blog name
    content = content.replace("椰汁网络日志", "机场Fog 测评博客")
    content = content.replace("椰汁网络", "机场Fog")
    
    # Replace css link if old style
    content = content.replace('<link rel="stylesheet" href="../css/style.css">', '<link rel="stylesheet" href="../styles.css">')
    
    # Replace navigation bar if old format
    if '<div class="nav-menu"' in content or '<span>椰汁网络日志</span>' in content or '<span>机场推荐</span>' in content:
        # Standardize header brand
        content = content.replace('<span>椰汁网络日志</span><div class="logo-dot"></div>', '<span>机场推荐与测评</span>')
        content = content.replace('<span>机场推荐</span>', '<span>机场推荐与测评</span>')
    
    # Replace garbled character placeholders if present
    content = content.replace('棣栭〉', '首页')
    content = content.replace('鏂囩珷绉戞櫘', '文章科普')
    content = content.replace('2026骞?鏈堟洿鏂?', '2026年9月更新')
    content = content.replace('2026骞?鏈堟洿鏂', '2026年9月更新')
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

all_articles = glob.glob('articles/*.html')
for art in all_articles:
    fix_file(art)

print(f"Processed {len(all_articles)} article files cleanly.")
