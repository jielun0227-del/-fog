import os
import glob
import re

html_files = []
for root, dirs, files in os.walk("."):
    if "scratch" in root or ".git" in root or ".gemini" in root:
        continue
    for file in files:
        if file.endswith(".html"):
            html_files.append(os.path.join(root, file))

nav_html = '''  <header class="navbar">
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
  </header>'''

footer_html = '''  <footer class="site-footer">
    <div class="container">
      <p>&copy; 2026 机场Fog 测评博客. 保留所有权利。</p>
    </div>
  </footer>'''

count = 0
for filepath in html_files:
    try:
        with open(filepath, "r", encoding="utf-8") as f:
            content = f.read()
    except Exception as e:
        print(f"Error reading {filepath}: {e}")
        continue

    orig = content
    content = content.replace("椰汁网络日志", "机场Fog 测评博客")
    content = content.replace("椰汁评测组", "机场Fog 测评团队")
    content = content.replace("椰汁网络", "机场Fog 测评博客")
    content = content.replace("椰汁", "机场Fog")

    if "articles" in filepath.replace("\\", "/"):
        content = re.sub(r'href=["\'][^"\']*css/style\.css["\']', 'href="../styles.css"', content)
        if "styles.css" not in content:
            content = content.replace("</head>", '  <link rel="stylesheet" href="../styles.css">\n</head>')

        if re.search(r'<header[^>]*>.*?</header>', content, flags=re.DOTALL):
            content = re.sub(r'<header[^>]*>.*?</header>', nav_html, content, flags=re.DOTALL)
        else:
            content = re.sub(r'<body[^>]*>', r'\g<0>\n' + nav_html, content, flags=re.IGNORECASE)

        if re.search(r'<footer[^>]*>.*?</footer>', content, flags=re.DOTALL):
            content = re.sub(r'<footer[^>]*>.*?</footer>', footer_html, content, flags=re.DOTALL)
        else:
            content = content.replace("</body>", footer_html + "\n</body>")

    if content != orig:
        with open(filepath, "w", encoding="utf-8") as f:
            f.write(content)
        count += 1
        print(f"Updated {os.path.basename(filepath)}")

print(f"Done. Updated {count} files.")
