const fs = require('fs');
const path = require('path');

const articlesDir = path.join(__dirname, 'articles');
const files = fs.readdirSync(articlesDir).filter(f => f.endsWith('.html'));

let replacedCount = 0;

files.forEach(file => {
  const filePath = path.join(articlesDir, file);
  let content = fs.readFileSync(filePath, 'utf8');
  
  let modified = false;
  
  if (content.includes('椰汁网络日志') || content.includes('椰汁网络')) {
    content = content.replaceAll('椰汁网络日志', '机场Fog 测评博客');
    content = content.replaceAll('椰汁网络', '机场Fog');
    modified = true;
  }
  
  if (content.includes('css/style.css')) {
    content = content.replaceAll('css/style.css', 'styles.css');
    content = content.replaceAll('../css/style.css', '../styles.css');
    modified = true;
  }

  if (content.includes('棣栭〉')) {
    content = content.replaceAll('棣栭〉', '首页');
    modified = true;
  }

  if (content.includes('鏂囩珷绉戞櫘')) {
    content = content.replaceAll('鏂囩珷绉戞櫘', '文章科普');
    modified = true;
  }

  if (content.includes('2026骞?鏈堟洿鏂?')) {
    content = content.replaceAll('2026骞?鏈堟洿鏂?', '2026年9月更新');
    modified = true;
  }

  if (modified) {
    fs.writeFileSync(filePath, content, 'utf8');
    replacedCount++;
  }
});

console.log(`Successfully updated ${replacedCount} article files.`);
