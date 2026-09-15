import os, glob

replacements = {
    '鏈哄満鎺ㄨ崘涓庢祴璇?': '机场推荐与测评',
    '鏈哄満鎺ㄨ崘涓庢祴璇': '机场推荐与测评',
    '鏈哄満鎺ㄨ崘': '机场推荐',
    '鏈哄満瀵规瘮澶ц〃': '机场对比大表',
    '鐭ヨ瘑搴嗕腑蹇': '知识库中心',
    '鐭ヨ瘑搴?': '知识库',
    '鐭ヨ瘑搴': '知识库',
    '鏂囩珷绉戞櫘': '文章科普',
    '璇︾粏璇勬祴': '详细评测',
    '鍒囨崲娣辫壊/娴呰壊妯″紡': '切换深色/浅色模式',
    '棣栭〉': '首页',
    '2026骞?鏈堟洿鏂?': '2026年9月更新',
    '2026骞?鏈堟洿鏂': '2026年9月更新',
    '娣卞害闃呰涓庢寚鍗': '深度阅读与指南',
    '鎼滅储鏂囩珷銆佸師鐞嗘垨瀵规瘮...': '搜索文章、原理或对比...',
    '鎼滅储鏈哄満鍚嶇О銆佺嚎璺被鍨 spiritual...': '搜索机场名称、线路类型或特色...',
    '漏 2026': '© 2026',
    '漏': '©',
}

all_files = glob.glob('*.html') + glob.glob('*.js') + glob.glob('*.css') + glob.glob('articles/*.html')

modified_count = 0
for fpath in all_files:
    try:
        with open(fpath, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        continue

    orig_content = content
    for garbled, clean in replacements.items():
        if garbled in content:
            content = content.replace(garbled, clean)
            
    if content != orig_content:
        with open(fpath, 'w', encoding='utf-8') as f:
            f.write(content)
        modified_count += 1
        print(f"Fixed garbled text in: {fpath}")

print(f"Total files checked: {len(all_files)}, Fixed: {modified_count}")
