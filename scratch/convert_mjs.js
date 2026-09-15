import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const articlesDir = path.join(__dirname, '..', 'articles');

const files = fs.readdirSync(articlesDir).filter(f => f.endsWith('.html'));

const NAV_HEADER = `  <!-- Header / Navigation Bar -->
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
  </header>`;

const FOOTER = `  <!-- Footer Section -->
  <footer class="site-footer">
    <div class="footer-container">
      <p class="copyright">© 2026 机场Fog测评博客. 保留所有权利。</p>
      <p class="disclaimer">声明：本站提供的内容仅供网络技术交流与学术研究参考，请遵守当地法律法规。</p>
    </div>
  </footer>

  <script src="../script.js"></script>
</body>
</html>`;

files.forEach(file => {
  const filePath = path.join(articlesDir, file);
  let html = fs.readFileSync(filePath, 'utf8');

  if (!html.includes('椰汁网络日志') && !html.includes('css/style.css')) {
    return;
  }

  const titleMatch = html.match(/<title>(.*?)<\/title>/s);
  let title = titleMatch ? titleMatch[1].replace(' - 椰汁网络日志', ' - 机场Fog 测评博客') : '详细评测 - 机场Fog 测评博客';

  const descMatch = html.match(/<meta name="description" content="(.*?)"/s);
  let desc = descMatch ? descMatch[1] : '';

  const bodyMatch = html.match(/<section class="article-body">(.*?)<\/section>/s);
  let body = bodyMatch ? bodyMatch[1] : '';

  const h1Match = html.match(/<h1>(.*?)<\/h1>/s);
  let h1 = h1Match ? h1Match[1] : '详细评测与深度测试报告';

  body = body.replaceAll('椰汁网络日志', '机场Fog 测评博客').replaceAll('椰汁网络', '机场Fog');
  body = body.replaceAll('class="btn btn-glow"', 'class="btn-primary" style="padding: 0.85rem 2rem; font-size: 1.1rem; display: inline-block; text-decoration: none; border-radius: 8px;"');

  const newHtml = `<!DOCTYPE html>
<html lang="zh-CN" data-theme="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${title}</title>
  <meta name="description" content="${desc}">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Noto+Sans+SC:wght@400;500;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="../styles.css">
  <style>
    .article-table {
      width: 100%;
      border-collapse: collapse;
      margin: 1.5rem 0;
      font-size: 0.95rem;
      background: rgba(255, 255, 255, 0.02);
      border-radius: 8px;
      overflow: hidden;
      border: 1px solid var(--border-color);
    }
    .article-table th, .article-table td {
      padding: 0.75rem 1rem;
      border-bottom: 1px solid var(--border-color);
    }
    .article-table th {
      background: rgba(255, 255, 255, 0.05);
      font-weight: 600;
      color: var(--accent-primary);
    }
    .highlight-text { color: #10B981; font-weight: 600; }
    .warn-text { color: #EF4444; font-weight: 600; }
  </style>
</head>
<body>

${NAV_HEADER}

  <!-- Main Container -->
  <main class="main-content">
    
    <!-- Breadcrumb Navigation -->
    <nav class="breadcrumb" aria-label="Breadcrumb">
      <ol>
        <li><a href="../index.html">首页</a></li>
        <li class="separator">/</li>
        <li><a href="../reviews.html">详细评测</a></li>
        <li class="separator">/</li>
        <li class="current">详细评测</li>
      </ol>
    </nav>

    <!-- Article Hero Section -->
    <section class="article-hero">
      <h1 class="article-title">${h1}</h1>
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
${body}
          </div>

        </div>
      </div>
    </section>

  </main>

${FOOTER}`;

  fs.writeFileSync(filePath, newHtml, 'utf8');
  console.log(`Successfully converted ${file}`);
});
