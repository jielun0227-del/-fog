import os, glob

article_files = glob.glob('articles/*.html')
emojis_and_residue = ['🚀', '📌', '📑', '⚡', '💡', '✨', '📊', '🛡️', '<div class="logo-icon">', '</div>', '<span class="search-shortcut">⌘ K</span>']

for fpath in article_files:
    with open(fpath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    content = content.replace('<div class="logo-icon">', '').replace('</div>', '')
    content = content.replace('<span class="search-shortcut">⌘ K</span>', '')
    for symbol in ['🚀', '📌', '📑', '⚡', '💡', '✨', '📊', '🛡️']:
        content = content.replace(symbol, '')
        
    with open(fpath, 'w', encoding='utf-8') as f:
        f.write(content)

print(f"Successfully cleaned {len(article_files)} files.")
