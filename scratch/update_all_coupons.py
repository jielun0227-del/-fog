import os
import re

coupons = {
    'edgenova-review.html': ('xk808', '边缘节点全场 8 折'),
    'kuaili-review.html': ('kl888', 'IEPL 专线特惠'),
    'sujie-review.html': ('sujie888', 'Hysteria2 爆速专线'),
    'jilianyun-review.html': ('jly888', 'BGP 多线性价比'),
    'yuntu-review.html': ('yt88', '新用户首购折扣'),
    'flashleap-review.html': ('kuaili', '极速月付体验'),
}

articles_dir = r'c:\Users\Lenovo\Desktop\机场fog\articles'

for fname, (code, note) in coupons.items():
    filepath = os.path.join(articles_dir, fname)
    if not os.path.exists(filepath):
        print(f"File not found: {fname}")
        continue
    
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Replace coupon-box-yellow section
    pattern = r'<div class="coupon-box-yellow">.*?</div>'
    
    new_box = f'''<div class="coupon-box-yellow">
                        <div class="coupon-title">⚠️ 优惠折扣</div>
                        <ul>
                            <li>折扣码：<code class="coupon-code">{code}</code> <button class="btn-copy-code" onclick="navigator.clipboard.writeText('{code}');alert('已复制折扣码！')">复制</button></li>
                            <li>{note}</li>
                        </ul>
                    </div>'''
    
    new_content = re.sub(pattern, new_box, content, flags=re.DOTALL)
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(new_content)
    print(f"Updated {fname} with coupon: {code}")
