import os, glob

def process_file(filepath):
    try:
        with open(filepath, 'rb') as f:
            raw = f.read()
        
        # Try UTF-8 first, fallback to gbk
        try:
            text = raw.decode('utf-8')
        except:
            text = raw.decode('gbk', errors='ignore')
            
        modified = False
        if '椰汁网络日志' in text or '椰汁网络' in text:
            text = text.replace('椰汁网络日志', '机场Fog 测评博客').replace('椰汁网络', '机场Fog')
            modified = True
            
        if 'css/style.css' in text:
            text = text.replace('css/style.css', 'styles.css')
            text = text.replace('../css/style.css', '../styles.css')
            modified = True
            
        if '棣栭〉' in text:
            text = text.replace('棣栭〉', '首页')
            modified = True
            
        if '鏂囩珷绉戞櫘' in text:
            text = text.replace('鏂囩珷绉戞櫘', '文章科普')
            modified = True

        if '2026骞' in text:
            text = text.replace('2026骞?鏈堟洿鏂?', '2026年9月更新').replace('2026骞?鏈堟洿鏂', '2026年9月更新')
            modified = True

        if modified:
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(text)
            print(f"Fixed: {filepath}")
    except Exception as e:
        print(f"Error on {filepath}: {e}")

files = glob.glob("articles/*.html")
for f in files:
    process_file(f)
