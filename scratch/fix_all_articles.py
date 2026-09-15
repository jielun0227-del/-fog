import os
import glob
import re

articles_dir = r"c:\Users\Lenovo\Desktop\机场fog\articles"
html_files = glob.glob(os.path.join(articles_dir, "*.html"))

standard_navbar = '''  <header class="navbar">
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

standard_footer = '''  <footer class="site-footer">
    <div class="container">
      <p>&copy; 2026 机场Fog 测评博客. 保留所有权利。</p>
    </div>
  </footer>'''

def process_file(filepath):
    # Try reading as UTF-8, then GBK
    content = None
    for enc in ['utf-8', 'gbk', 'gb2312', 'utf-8-sig']:
        try:
            with open(filepath, 'r', encoding=enc) as f:
                content = f.read()
            break
        except UnicodeDecodeError:
            continue

    if content is None:
        print(f"Failed to read {filepath}")
        return

    # 1. Replace head links
    # Replace ../css/style.css with ../styles.css
    content = re.sub(r'href=["\'].*?css/style\.css["\']', 'href="../styles.css"', content)
    if 'styles.css' not in content:
        content = content.replace('</head>', '  <link rel="stylesheet" href="../styles.css">\n</head>')

    # Ensure font or viewport if missing
    if 'viewport' not in content:
        content = content.replace('<head>', '<head>\n  <meta name="viewport" content="width=device-width, initial-scale=1.0">')

    # 2. Replace Header
    # Match <header class="header">...</header> or <header class="navbar">...</header> or standard header
    header_pattern = re.compile(r'<header[^>]*>.*?</header>', re.DOTALL)
    if header_pattern.search(content):
        content = header_pattern.sub(standard_navbar, content)
    else:
        # insert after <body>
        content = re.sub(r'<body[^>]*>', r'\g<0>\n' + standard_navbar, content)

    # 3. Replace Footer
    footer_pattern = re.compile(r'<footer[^>]*>.*?</footer>', re.DOTALL)
    if footer_pattern.search(content):
        content = footer_pattern.sub(standard_footer, content)
    else:
        content = content.replace('</body>', standard_footer + '\n</body>')

    # 4. Clean up any remaining legacy site names or garbage terms
    content = content.replace('椰汁网络日志', '机场Fog 测评博客')
    content = content.replace('椰汁网络', '机场Fog 测评博客')
    content = content.replace('椰汁', '机场Fog')

    # Save cleanly as UTF-8
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    print(f"Updated: {os.path.basename(filepath)}")

for f in html_files:
    process_file(f)

print("All article files updated successfully.")
