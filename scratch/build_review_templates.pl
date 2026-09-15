use strict;
use warnings;
use utf8;

binmode(STDOUT, ":utf8");
binmode(STDERR, ":utf8");

my $articles_dir = "articles";

my %airports = (
    "kuaili-review.html" => {
        name => "快狸机场",
        title => "快狸机场怎么样？套餐、线路与测速评测",
        subtitle => "一杯奶茶钱解锁 IEPL 企业专线与 AnyTLS 协议，晚高峰秒开 8K 与原生住宅 IP 完美解锁 AI！",
        word_count => "约 2500 字",
        read_time => "大约 8 分钟",
        date => "2026-07-06",
        aff_url => "https://yyo649929.kuailiaff.com/#/register?code=EjqxPHQZ",
        line_tech => "IEPL 企业专线 · AnyTLS 协议伪装",
        usage => "兼容 Clash / Shadowrocket / sing-box 客户端",
        min_monthly => "¥15/月起 (Lite 150G)",
        min_yearly => "¥144/年 (Lite 150G/月)",
        trial => "注册即送免费试用流量",
        coupon => "KUAILI888",
        coupon_desc => "季付 9 折 / 年付 8 折，限时新用户专属折上折",
        advice => "日常轻度追剧选 Lite 体验版（15元150G）；需要 ChatGPT / Claude AI 办公与 4K 8K 超清影音强烈推荐 Basic 或 Standard 套餐，享受干净的原生住宅 IP。",
        plans => [
            { name => "Lite 体验版", traffic => "150G", monthly => "¥15", quarterly => "¥42", yearly => "¥144", limit => "无限制" },
            { name => "Basic 基础版", traffic => "300G", monthly => "¥28", quarterly => "¥78", yearly => "¥268", limit => "无限制" },
            { name => "Standard 进阶版", traffic => "600G", monthly => "¥48", quarterly => "¥135", yearly => "¥450", limit => "无限制" },
            { name => "Premium 旗舰版", traffic => "1200G", monthly => "¥88", quarterly => "¥248", yearly => "¥820", limit => "无限制" }
        ],
        highlights => [
            "<strong>IEPL 企业级专线：</strong> 独立海底光缆直连，晚高峰零丢包、延迟平稳如镜，彻底告别公网堵塞。",
            "<strong>AnyTLS 深度伪装：</strong> sing-box 团队最新协议，完美去除代理特征，无感穿透严苛检测。",
            "<strong>原生住宅 IP 解锁：</strong> 完美支持 OpenAI, Claude, Netflix, Disney+, TikTok 等敏感服务及外贸跨境。"
        ]
    },
    "jilianyun-review.html" => {
        name => "极连云",
        title => "极连云怎么样？套餐、线路与测速评测",
        subtitle => "多节点负载均衡与全专线中转，极速稳定的老牌梯子服务商",
        word_count => "约 2200 字",
        read_time => "大约 7 分钟",
        date => "2026-06-18",
        aff_url => "../index.html#airports",
        line_tech => "公网中转 + IPLC 专线",
        usage => "支持 Clash / 小火箭 / sing-box",
        min_monthly => "¥18/月起",
        min_yearly => "¥168/年",
        trial => "免费试用 3GB",
        coupon => "JILIAN88",
        coupon_desc => "新用户首单享受 88 折优惠",
        advice => "适合个人日常全网加速与流媒体解锁，年付性价比极高。",
        plans => [
            { name => "基础版", traffic => "100G", monthly => "¥18", quarterly => "¥50", yearly => "¥168", limit => "3 台" },
            { name => "标准版", traffic => "250G", monthly => "¥32", quarterly => "¥90", yearly => "¥298", limit => "5 台" },
            { name => "高级版", traffic => "500G", monthly => "¥58", quarterly => "¥160", yearly => "¥520", limit => "无限制" }
        ],
        highlights => [
            "<strong>负载均衡节点：</strong> 自动分配最空闲服务器，保证连接流畅。",
            "<strong>全流媒体解锁：</strong> 包含港台、日韩、美区全套节点。"
        ]
    },
    "sujie-review.html" => {
        name => "速界机场",
        title => "速界机场怎么样？套餐、线路与测速评测",
        subtitle => "万兆极速 Hysteria 2 协议与 IPLC 顶级专线，爆速怪物！",
        word_count => "约 2400 字",
        read_time => "大约 8 分钟",
        date => "2026-07-01",
        aff_url => "../index.html#airports",
        line_tech => "Hysteria 2 + IPLC 专线",
        usage => "支持 Clash Verge / sing-box",
        min_monthly => "¥20/月起",
        min_yearly => "¥190/年",
        trial => "免费试用",
        coupon => "SUJIE90",
        coupon_desc => "全场季付以上 9 折",
        advice => "晚高峰丢包严重地区的首选加速神器。",
        plans => [
            { name => "极速版", traffic => "200G", monthly => "¥20", quarterly => "¥56", yearly => "¥190", limit => "5 台" },
            { name => "尊享版", traffic => "500G", monthly => "¥42", quarterly => "¥118", yearly => "¥390", limit => "无限制" }
        ],
        highlights => [
            "<strong>Hysteria 2 爆速协议：</strong> 抗丢包能力极强，轻松冲破带宽限制。",
            "<strong>IPLC 游戏专线：</strong> 极低延迟，适合外服电竞联机。"
        ]
    },
    "bianjieyun-review.html" => {
        name => "边界云",
        title => "边界云怎么样？套餐、线路与测速评测",
        subtitle => "高性价比公网中转与多节点冗余，平民追剧首选",
        word_count => "约 2100 字",
        read_time => "大约 7 分钟",
        date => "2026-05-20",
        aff_url => "../index.html#airports",
        line_tech => "BGP 多线中转",
        usage => "支持全平台代理客户端",
        min_monthly => "¥12/月起",
        min_yearly => "¥110/年",
        trial => "无试用",
        coupon => "BIANJIE95",
        coupon_desc => "全场 95 折",
        advice => "预算有限学生党及轻度浏览用户的实惠之选。",
        plans => [
            { name => "入门版", traffic => "100G", monthly => "¥12", quarterly => "¥33", yearly => "¥110", limit => "2 台" },
            { name => "畅享版", traffic => "300G", monthly => "¥26", quarterly => "¥72", yearly => "¥240", limit => "5 台" }
        ],
        highlights => [
            "<strong>超高性价比：</strong> 低至 12 元/月即可享受稳定出海。",
            "<strong>规则分流优化：</strong> 自动区分国内与海外流量。"
        ]
    },
    "shanhai-review.html" => {
        name => "山海机场",
        title => "山海机场怎么样？套餐、线路与测速评测",
        subtitle => "公网隧道中转与多线路冗余，日常追剧与学术科研高性价比",
        word_count => "约 2200 字",
        read_time => "大约 7 分钟",
        date => "2026-06-12",
        aff_url => "../index.html#airports",
        line_tech => "隧道中转 + 专线节点",
        usage => "支持全平台客户端",
        min_monthly => "¥16/月起",
        min_yearly => "¥150/年",
        trial => "试用流量包",
        coupon => "SHANHAI88",
        coupon_desc => "新用户首单 88 折",
        advice => "学术文献检索与 Google Scholar 访问推荐套餐。",
        plans => [
            { name => "科研版", traffic => "150G", monthly => "¥16", quarterly => "¥45", yearly => "¥150", limit => "3 台" },
            { name => "全能版", traffic => "400G", monthly => "¥36", quarterly => "¥100", yearly => "¥340", limit => "6 台" }
        ],
        highlights => [
            "<strong>学术节点优化：</strong> 稳定访问 IEEE, Nature, Science 等科研站点。",
            "<strong>多路线冗余：</strong> 主备节点自动切换。"
        ]
    },
    "huanyuyun-review.html" => {
        name => "寰宇云",
        title => "寰宇云怎么样？套餐、线路与测速评测",
        subtitle => "全球多节点覆盖与全平台客户端支持",
        word_count => "约 2000 字",
        read_time => "大约 6 分钟",
        date => "2026-05-15",
        aff_url => "../index.html#airports",
        line_tech => "BGP 跨境中转",
        usage => "全平台适配",
        min_monthly => "¥15/月起",
        min_yearly => "¥140/年",
        trial => "注册即送 2G",
        coupon => "HUANYU90",
        coupon_desc => "全场 9 折",
        advice => "多设备家庭共享首选。",
        plans => [
            { name => "标准套餐", traffic => "120G", monthly => "¥15", quarterly => "¥40", yearly => "¥140", limit => "3 台" }
        ],
        highlights => [
            "<strong>全平台支持：</strong> 覆盖 iOS, Android, Windows, macOS。"
        ]
    }
);

foreach my $filename (keys %airports) {
    my $info = $airports{$filename};
    my $plans_rows = "";
    foreach my $p (@{$info->{plans}}) {
        $plans_rows .= "        <tr>\n";
        $plans_rows .= "          <td><strong>$p->{name}</strong></td>\n";
        $plans_rows .= "          <td>$p->{traffic}</td>\n";
        $plans_rows .= "          <td>$p->{monthly}</td>\n";
        $plans_rows .= "          <td>$p->{quarterly}</td>\n";
        $plans_rows .= "          <td>$p->{yearly}</td>\n";
        $plans_rows .= "          <td>$p->{limit}</td>\n";
        $plans_rows .= "          <td><a href=\"$info->{aff_url}\" target=\"_blank\" class=\"btn-table-buy\">查看 $p->{name} 价格</a></td>\n";
        $plans_rows .= "        </tr>\n";
    }

    my $highlights_html = "";
    foreach my $h (@{$info->{highlights}}) {
        $highlights_html .= "                      <li>$h</li>\n";
    }

    my $filepath = "$articles_dir/$filename";
    open(my $out, ">:encoding(UTF-8)", $filepath) or die "Cannot write $filepath: $!";

    print $out <<"HTML";
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>$info->{title} - 机场Fog 测评博客</title>
    <meta name="description" content="$info->{subtitle}">
    <meta name="keywords" content="$info->{name}, 机场评测, 节点测速, 科学上网, 专线中转">
    <link rel="stylesheet" href="../styles.css">
</head>
<body class="article-page-body">

  <header class="navbar">
    <div class="nav-container">
      <a href="../index.html" class="logo">
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
  </header>

    <div class="layout-wrapper">
        <main class="main-content">
            <article class="article-detail-box">
                <header class="review-hero-header">
                    <h1 class="review-title">$info->{title}</h1>
                    <div class="review-meta-bar">
                        <span class="meta-reading">📖 $info->{word_count} • $info->{read_time}</span>
                        <div class="meta-tags">
                            <span class="tag-badge tag-blue">机场评测</span>
                            <span class="tag-badge tag-pink">机场推荐</span>
                            <span class="tag-badge tag-yellow">流媒体解锁</span>
                        </div>
                        <span class="meta-date">$info->{date}</span>
                    </div>
                </header>
                
                <section class="article-body">
                    <div class="review-summary-section">
                        <div class="feature-pills-row">
                            <span class="pill-badge">$info->{line_tech}</span>
                            <span class="pill-badge">注册免费试用</span>
                            <span class="pill-badge">全节点流媒体解锁</span>
                        </div>

                        <div class="cyan-summary-box">
                            <div class="summary-box-title">💡 30 秒看懂 $info->{name}</div>
                            <ul class="summary-list">
                                <li><strong>核心线路：</strong> $info->{line_tech}</li>
                                <li><strong>使用方式：</strong> $info->{usage}</li>
                                <li><strong>最低月均：</strong> $info->{min_monthly}</li>
                                <li><strong>最低年付：</strong> $info->{min_yearly}</li>
                                <li><strong>试用：</strong> $info->{trial}</li>
                                <li><strong>快速查看：</strong> <a href="#plans">套餐与优惠</a> · <a href="#highlights">核心特色</a> · <a href="../reviews.html">全部机场比较</a></li>
                            </ul>
                        </div>

                        <div class="action-btn-wrap" style="text-align: center;">
                            <a href="$info->{aff_url}" target="_blank" rel="nofollow noopener noreferrer" class="btn-oval-action">
                                查看 $info->{name} 当前套餐
                            </a>
                        </div>
                    </div>

                    <h2 id="highlights">一、$info->{name} 核心优势与技术特点</h2>
                    <p>$info->{subtitle}</p>
                    <ul>
$highlights_html                    </ul>

                    <h2 id="plans">二、订阅套餐与价格对比</h2>
                    <div class="table-responsive">
                        <table class="plans-table">
                            <thead>
                                <tr>
                                    <th>套餐</th>
                                    <th>流量/月</th>
                                    <th>月付</th>
                                    <th>季付</th>
                                    <th>年付</th>
                                    <th>设备限制</th>
                                    <th>购买</th>
                                </tr>
                            </thead>
                            <tbody>
$plans_rows                            </tbody>
                        </table>
                    </div>

                    <div class="payment-methods-row">
                        <strong>支付方式：</strong>
                        <span class="pay-pill">支付宝</span>
                        <span class="pay-pill">微信支付</span>
                        <span class="pay-pill">USDT</span>
                    </div>

                    <div class="coupon-box-yellow">
                        <div class="coupon-title">⚠️ 优惠折扣</div>
                        <ul>
                            <li>折扣码：<code class="coupon-code">$info->{coupon}</code> <button class="btn-copy-code" onclick="navigator.clipboard.writeText('$info->{coupon}');alert('已复制折扣码！')">复制</button></li>
                            <li>$info->{coupon_desc}</li>
                        </ul>
                    </div>

                    <div class="info-box-blue">
                        <div class="info-title">ℹ️ 新手建议</div>
                        <p>$info->{advice}</p>
                    </div>

                    <h2>三、总结与购买建议</h2>
                    <p>网络访问最宝贵的是时间与稳定性。$info->{name} 在线路连通率、速度以及性价比方面表现优异，无论是日常网页浏览、4K 影音还是 AI 办公都能带来极佳的体验。</p>
                    
                    <div style="text-align: center; margin: 2.5rem 0;">
                        <a href="$info->{aff_url}" target="_blank" rel="nofollow noopener noreferrer" class="btn-oval-action" style="background: #2563eb; color: #ffffff !important; border-color: #2563eb;">
                            立即前往 $info->{name} 官网注册体验
                        </a>
                    </div>
                </section>
            </article>
        </main>

        <aside class="sidebar">
            <div class="widget">
                <h3 class="widget-title">此页内容</h3>
                <ul class="widget-links">
                    <li><a href="#highlights">一、核心优势与技术特点</a></li>
                    <li><a href="#plans">二、订阅套餐与价格对比</a></li>
                    <li><a href="../reviews.html">三、全部机场综合比较</a></li>
                    <li><a href="../knowledge.html">四、客户端配置指南</a></li>
                </ul>
            </div>
        </aside>
    </div>

  <footer class="site-footer">
    <div class="container">
      <p>&copy; 2026 机场Fog 测评博客. 保留所有权利。</p>
    </div>
  </footer>

  <script src="../script.js"></script>
</body>
</html>
HTML

    close($out);
    print "Generated review template: $filename\n";
}

print "ALL_REVIEW_TEMPLATES_PERL_SUCCESS\n";
