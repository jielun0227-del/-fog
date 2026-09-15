import re
import glob

NAV_HEADER = """  <!-- Header / Navigation Bar -->
  <header class="navbar">
    <div class="nav-container">
      <a href="../index.html" class="brand-title">
        <span>机场推荐与测评</span>
      </a>

      <div class="nav-search">
        <span class="search-icon">🔍</span>
        <input type="text" id="globalSearchInput" placeholder="搜索机场名称、线路类型或特色..." />
      </div>

      <nav class="nav-links">
        <a href="../index.html#airports-table" class="nav-link">机场推荐</a>
        <a href="../knowledge.html" class="nav-link">知识库</a>
        <a href="../articles.html" class="nav-link">文章科普</a>
        <a href="../reviews.html" class="nav-link active">详细评测</a>
        <a href="../about.html" class="nav-link">关于</a>
      </nav>

      <div class="nav-actions">
        <button id="themeToggleBtn" class="theme-toggle-btn" title="切换深色/浅色模式">
          <span class="sun-icon">☀️</span>
          <span class="moon-icon">🌙</span>
        </button>
      </div>
    </div>
  </header>"""

FOOTER = """  <!-- Footer Section -->
  <footer class="site-footer">
    <div class="footer-container">
      <p class="copyright">© 2026 机场Fog测评博客. 保留所有权利。</p>
      <p class="disclaimer">声明：本站提供的内容仅供网络技术交流与学术研究参考，请遵守当地法律法规。</p>
    </div>
  </footer>

  <script src="../script.js"></script>
</body>
</html>"""

def update_legacy_article(filepath):
    try:
        with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
            html = f.read()

        if '椰汁网络日志' not in html and 'css/style.css' not in html:
            return

        title_match = re.search(r'<title>(.*?)</title>', html, re.DOTALL)
        title = title_match.group(1).replace(' - 椰汁网络日志', ' - 机场Fog 测评博客') if title_match else "详细评测 - 机场Fog 测评博客"

        desc_match = re.search(r'<meta name="description" content="(.*?)"', html, re.DOTALL)
        desc = desc_match.group(1) if desc_match else ""

        body_match = re.search(r'<section class="article-body">(.*?)</section>', html, re.DOTALL)
        body = body_match.group(1) if body_match else ""

        h1_match = re.search(r'<h1>(.*?)</h1>', html, re.DOTALL)
        h1 = h1_match.group(1) if h1_match else "详细评测与深度测试报告"

        body = body.replace('椰汁网络日志', '机场Fog 测评博客').replace('椰汁网络', '机场Fog')
        body = re.sub(r'class="btn btn-glow"', 'class="btn-primary" style="padding: 0.85rem 2rem; font-size: 1.1rem; display: inline-block; text-decoration: none; border-radius: 8px;"', body)

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
  <style>
    .article-table {{
      width: 100%;
      border-collapse: collapse;
      margin: 1.5rem 0;
      font-size: 0.95rem;
      background: rgba(255, 255, 255, 0.02);
      border-radius: 8px;
      overflow: hidden;
      border: 1px solid var(--border-color);
    }}
    .article-table th, .article-table td {{
      padding: 0.75rem 1rem;
      border-bottom: 1px solid var(--border-color);
    }}
    .article-table th {{
      background: rgba(255, 255, 255, 0.05);
      font-weight: 600;
      color: var(--accent-primary);
    }}
    .highlight-text {{ color: #10B981; font-weight: 600; }}
    .warn-text {{ color: #EF4444; font-weight: 600; }}
  </style>
</head>
<body>

{NAV_HEADER}

  <!-- Main Container -->
  <main class="main-content">
    
    <!-- Breadcrumb Navigation -->
    <nav class="breadcrumb" aria-label="Breadcrumb">
      <ol>
        <li><a href="../index.html">首页</a></li>
        <li class="separator">/</li>
        <li><a href="../articles.html">文章科普</a></li>
        <li class="separator">/</li>
        <li class="current">科普与评测</li>
      </ol>
    </nav>

    <!-- Article Hero Section -->
    <section class="article-hero">
      <h1 class="article-title">{h1}</h1>
      <div class="article-meta">
        <span class="meta-item">2026年9月更新</span>
        <span class="meta-dot">•</span>
        <span class="meta-item">独立客观点评 • 线路性能实测</span>
      </div>
    </section>

    <!-- Article Layout -->
    <section class="catalog-section" style="padding-top: 1rem;">
      <div class="catalog-grid" style="grid-template-columns: 1fr;">
        <div class="catalog-main">
          
          <div class="content-card">
{body}
          </div>

        </div>
      </div>
    </section>

  </main>

{FOOTER}
"""
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(new_html)
        print(f"Successfully converted: {filepath}")
    except Exception as e:
        print(f"Failed to convert {filepath}: {e}")

for file in glob.glob("articles/*.html"):
    update_legacy_article(file)
