import os, glob, re

article_files = glob.glob('articles/*.html')

for fpath in article_files:
    filename = os.path.basename(fpath)
    with open(fpath, 'r', encoding='utf-8') as f:
        html = f.read()

    # Extract title
    title_match = re.search(r'<title>(.*?)</title>', html, re.DOTALL)
    title = title_match.group(1) if title_match else '文章详情 - 机场测评博客'

    # Extract description meta
    desc_match = re.search(r'<meta name="description" content="(.*?)">', html)
    desc = desc_match.group(1) if desc_match else ''

    # Extract article title (h1)
    h1_match = re.search(r'<h1 class="article-title">(.*?)</h1>', html, re.DOTALL)
    h1_text = h1_match.group(1).strip() if h1_match else title.split('｜')[0]

    # Extract breadcrumb current text
    bc_match = re.search(r'<li class="current">(.*?)</li>', html, re.DOTALL)
    bc_text = bc_match.group(1).strip() if bc_match else h1_text

    # Extract article-meta inner items
    meta_match = re.search(r'<section class="article-hero">.*?(<div class="article-meta">.*?</div>|\s*<div class="article-meta">.*?</section>)', html, re.DOTALL)
    meta_html = """        <span class="meta-item">2026年更新</span>
        <span class="meta-dot">•</span>
        <span class="meta-item">深度阅读与指南</span>"""
    if meta_match:
        items = re.findall(r'<span class="meta-item">(.*?)</span>', meta_match.group(0))
        if items:
            meta_html = '        <span class="meta-item">' + '</span>\n        <span class="meta-dot">•</span>\n        <span class="meta-item">'.join(items) + '</span>'

    # Extract TOC items if any
    toc_items = re.findall(r'<li>\s*<a href="(#.*?)">(.*?)</a>\s*</li>', html)
    toc_html = ""
    if toc_items:
        toc_lis = "\n".join([f'        <li><a href="{href}">{text}</a></li>' for href, text in toc_items])
        toc_html = f"""    <!-- Table of Contents -->
    <div class="table-of-contents">
      <div class="toc-title">文章目录</div>
      <ul class="toc-list">
{toc_lis}
      </ul>
    </div>
"""

    # Extract all section.content-card blocks
    sections = re.findall(r'<section class="content-card.*?">(.*?)</section>', html, re.DOTALL)
    
    # If no section tag found, extract main body content between main tags
    if not sections:
        main_body_match = re.search(r'<main class="main-content">(.*?)</main>', html, re.DOTALL)
        if main_body_match:
            main_text = main_body_match.group(1)
            # Find all h2 blocks
            h2_blocks = re.split(r'(?=<h2)', main_text)
            sections = [b for b in h2_blocks if '<h2' in b]

    content_cards_html = ""
    if sections:
        for s in sections:
            s_clean = s.strip()
            # Clean residual tags
            s_clean = re.sub(r'</?div.*?>', '', s_clean)
            content_cards_html += f"""
    <!-- Section Block -->
    <section class="content-card">
      {s_clean}
    </section>
"""
    else:
        content_cards_html = """
    <section class="content-card">
      <p style="color: var(--text-muted); line-height: 1.8;">内容已更新，请查看具体小节。</p>
    </section>
"""

    # Assemble complete, perfectly valid HTML file
    new_html = f"""<!DOCTYPE html>
<html lang="zh-CN" data-theme="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{title}</title>
  <meta name="description" content="{desc}">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Noto+Sans+SC:wght@400;500;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="../styles.css">
</head>
<body>
  <!-- Header / Navigation Bar -->
  <header class="navbar">
    <div class="nav-container">
      <a href="../index.html" class="brand-title">
        <span>机场推荐与测评</span>
      </a>

      <div class="nav-search">
        <span class="search-icon">🔍</span>
        <input type="text" placeholder="搜索文章、原理或对比..." onclick="window.location.href='../articles.html'" />
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
  </header>

  <!-- Main Container -->
  <main class="main-content">
    
    <!-- Breadcrumb Navigation -->
    <nav class="breadcrumb" aria-label="Breadcrumb">
      <ol>
        <li><a href="../index.html">首页</a></li>
        <li class="separator">/</li>
        <li><a href="../articles.html">文章科普</a></li>
        <li class="separator">/</li>
        <li class="current">{bc_text}</li>
      </ol>
    </nav>

    <!-- Article Hero Section -->
    <section class="article-hero">
      <h1 class="article-title">{h1_text}</h1>
      <div class="article-meta">
{meta_html}
      </div>
    </section>

{toc_html}
{content_cards_html}

  </main>

  <!-- Footer Section -->
  <footer class="site-footer">
    <div class="footer-container">
      <div class="footer-col brand-col">
        <h3>机场推荐与测评</h3>
        <p>2026 最新机场推荐与测评指南，致力于提供客观、透明、可验证的科学上网与 VPN 线路测试。</p>
        <p class="copyright">© 2026 机场推荐与测评. All Rights Reserved.</p>
      </div>
      <div class="footer-col">
        <h4>快速导航</h4>
        <ul>
          <li><a href="../index.html#airports-table">机场对比大表</a></li>
          <li><a href="../knowledge.html">知识库中心</a></li>
          <li><a href="../articles.html">文章科普</a></li>
          <li><a href="../reviews.html">详细评测</a></li>
        </ul>
      </div>
    </div>
  </footer>

  <script src="../script.js"></script>
</body>
</html>
"""

    with open(fpath, 'w', encoding='utf-8') as f:
        f.write(new_html)

print(f"Rebuilt template for {len(article_files)} article HTML files successfully.")
