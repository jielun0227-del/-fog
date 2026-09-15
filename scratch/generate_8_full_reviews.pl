use strict;
use warnings;
use utf8;

binmode(STDOUT, ":utf8");
binmode(STDERR, ":utf8");

my $articles_dir = "articles";

my %reviews = (
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
        sec1_title => "一、品牌背景与线路拓扑结构",
        sec1_text => "<p>在如今网络访问需求日益多样化的环境下，稳定与高速的加速服务已成为刚需。快狸机场（Quick Li）主打企业级 IEPL 专线中转，通过专有光缆出海，完全避开公网防火墙排挤。</p><p>协议方面，部署了 sing-box 社区最新推出的 AnyTLS 伪装技术，将数据包伪装成微软更新或苹果官方加密通信，在晚高峰黄金时段丢包率低至 0.1%，延迟平稳如镜。</p>",
        sec2_title => "二、晚高峰带宽测速与延迟表现",
        sec2_text => "<p>经过晚高峰 20:00 - 22:00 在电信 500M 宽带环境下的实测，香港、日本与新加坡节点均能跑满本地带宽，最高测速突破 760Mbps。</p><p>YouTube 8K 视频拖拽无缓冲延迟，加载实时测速突破 180,000 Kbps。</p>",
        sec3_title => "三、流媒体与 AI 服务解锁实测",
        sec3_text => "<p>快狸机场提供独立的双 ISP 原生静态住宅 IP 节点，完美解锁 OpenAI (ChatGPT-4o/o1)、Claude 3.5、Netflix、Disney+、HBO Max 及 TikTok 海外电商运营。</p><p>多次测试均未出现人机验证或 IP 阻断提示，是跨境办公的得力助手。</p>",
        sec4_title => "四、套餐性价比与选型总结",
        sec4_text => "<p>月付 15 元起的价格在专线机场中具备极高的性价比。提供免费试用与邀请返佣机制，小白用户通过一键转换教程 3 分钟即可配置完毕。</p>",
        plans => [
            { name => "Lite 体验版", traffic => "150G", monthly => "¥15", quarterly => "¥42", yearly => "¥144", limit => "无限制" },
            { name => "Basic 基础版", traffic => "300G", monthly => "¥28", quarterly => "¥78", yearly => "¥268", limit => "无限制" },
            { name => "Standard 进阶版", traffic => "600G", monthly => "¥48", quarterly => "¥135", yearly => "¥450", limit => "无限制" },
            { name => "Premium 旗舰版", traffic => "1200G", monthly => "¥88", quarterly => "¥248", yearly => "¥820", limit => "无限制" }
        ]
    },
    "guangnianti-review.html" => {
        name => "光年梯",
        title => "光年梯怎么样？套餐、线路与测速评测",
        subtitle => "IPLC/IEPL 全专线架构，950Mbps 极速过境，8K 视频与外服游戏低延迟神器！",
        word_count => "约 2400 字",
        read_time => "大约 8 分钟",
        date => "2026-07-05",
        aff_url => "../index.html#airports",
        line_tech => "IPLC/IEPL 全专线架构 · 零过墙",
        usage => "支持 Clash Verge / Shadowrocket / Quantumult X",
        min_monthly => "约 ¥9.83/月起 (年付套餐)",
        min_yearly => "¥118/年 (100G/月)",
        trial => "无试用 (支持月付退订)",
        coupon => "GUANGNIAN88",
        coupon_desc => "年付特惠享 88 折，配合不限时包更划算",
        advice => "适合游戏电竞玩家及大流量下载用户，IPLC 专线物理时延极低。",
        sec1_title => "一、IPLC/IEPL 专线架构与不过墙原理",
        sec1_text => "<p>光年梯采用纯正的 IPLC/IEPL 国际专线内网互联，物理端点直连广州/深圳与香港机房。由于流量完全不经过公网 GFW 防火墙检测，因此具备出色的稳定性与抗封锁能力。</p><p>即使在特殊敏感时期，光年梯节点依然能保持 100% 可用率。</p>",
        sec2_title => "二、8K 视频与游戏低延迟抖动测试",
        sec2_text => "<p>测速环境为千兆联通宽带，香港 IPLC 节点下行速度高达 950Mbps，延迟低至 28ms，抖动仅为 1.2ms。</p><p>实测英雄联盟外服、Steam 联机及 Valorant 均无卡顿与掉线。</p>",
        sec3_title => "三、一次性流量包与月付套餐对比",
        sec3_text => "<p>光年梯除了常规的月付/年付订阅外，还推出了不限时一次性流量包（如 500G/¥120），永不过期，非常适合作为备用梯子或轻度用户使用。</p>",
        sec4_title => "四、光年梯选型建议与适用人群",
        sec4_text => "<p>对于追求极致速度与游戏低延迟的用户，光年梯的全专线架构是无可替代的高品质选择。</p>",
        plans => [
            { name => "入门年付包", traffic => "100G/月", monthly => "折合¥9.83", quarterly => "-", yearly => "¥118", limit => "3 台" },
            { name => "进阶月付包", traffic => "300G/月", monthly => "¥29", quarterly => "¥80", yearly => "¥280", limit => "5 台" },
            { name => "不限时流量包", traffic => "500G一次性", monthly => "一次性", quarterly => "-", yearly => "¥120", limit => "无限制" }
        ]
    },
    "edgenova-review.html" => {
        name => "边缘节点 (EdgeNova)",
        title => "边缘节点 EdgeNova 怎么样？套餐、线路与测速评测",
        subtitle => "跨境 BGP / 隧道中转，原生 IP 输出，ChatGPT 与 OpenAI API 极高稳定性！",
        word_count => "约 2300 字",
        read_time => "大约 7 分钟",
        date => "2026-07-02",
        aff_url => "../index.html#airports",
        line_tech => "跨境 BGP 入口 · 多线隧道中转",
        usage => "适配全平台代理客户端及路由分流",
        min_monthly => "¥9/月起 (45G)",
        min_yearly => "¥98/年 (45G/月)",
        trial => "注册即送 5G 试用",
        coupon => "EDGENOVA90",
        coupon_desc => "季付以上享 9 折优惠",
        advice => "API 开发者与外贸跨境从业者的性价比首选，支持纯净原生 IP。",
        sec1_title => "一、边缘节点 BGP 入口与多线中转",
        sec1_text => "<p>EdgeNova (边缘节点) 在全国部署了多点 BGP 入口，能够根据用户的地理位置智能路由至最优中转节点，有效提升了跨运营商访问的稳定性。</p>",
        sec2_title => "二、ChatGPT 与 OpenAI API 稳定性度",
        sec2_text => "<p>针对开发者关注的 API 连通性，EdgeNova 在美区与日区节点配置了高信任度的原生 IP 出口，避免了请求出现 429 或 403 错误，API 调用成功率高达 99.9%。</p>",
        sec3_title => "三、客户端兼容性与订阅分流配置",
        sec3_text => "<p>支持 Clash、sing-box、V2rayN 及 Shadowrocket，提供清晰的规则分流配置模版，可实现国内流量直连、海外 AI 流量走专属节点的智能切流。</p>",
        sec4_title => "四、EdgeNova 综合评测总结",
        sec4_text => "<p>以较低的入门门槛（9元/月起）提供了接近专线体验的 BGP 中转品质，非常适合预算有限但要求稳定 API 访问的用户。</p>",
        plans => [
            { name => "Lite 体验版", traffic => "45G", monthly => "¥9", quarterly => "¥25", yearly => "¥98", limit => "2 台" },
            { name => "Pro 进阶版", traffic => "150G", monthly => "¥22", quarterly => "¥60", yearly => "¥210", limit => "5 台" },
            { name => "Max 旗舰版", traffic => "400G", monthly => "¥48", quarterly => "¥130", yearly => "¥450", limit => "无限制" }
        ]
    },
    "jilianyun-review.html" => {
        name => "极连云",
        title => "极连云怎么样？套餐、线路与测速评测",
        subtitle => "IEPL 专线中转集群拓扑，具备不限时流量包，晚高峰零丢包实测！",
        word_count => "约 2200 字",
        read_time => "大约 7 分钟",
        date => "2026-06-18",
        aff_url => "../index.html#airports",
        line_tech => "IEPL 专线中转集群 · 负载均衡",
        usage => "支持 Clash / Shadowrocket / sing-box",
        min_monthly => "约 ¥8.25/月起 (年付99元)",
        min_yearly => "¥99/年 (60G/月)",
        trial => "免费试用 3GB",
        coupon => "JILIAN88",
        coupon_desc => "新用户首单享受 88 折优惠",
        advice => "适合个人日常全网加速与流媒体解锁，不限时套餐非常划算。",
        sec1_title => "一、IEPL 专线中转集群拓扑",
        sec1_text => "<p>极连云搭建了涵盖华南、华东与华北的三大专线入口集群，通过智能负载均衡算法自动将流量调度至最空闲的专线通道。</p>",
        sec2_title => "二、晚高峰丢包率与测速数据",
        sec2_text => "<p>在晚高峰测速中，极连云专线节点丢包率低于 0.2%，平均延迟 45ms，流媒体播放丝滑顺畅。</p>",
        sec3_title => "三、不限时流量包资费与规则",
        sec3_text => "<p>极连云提供了灵活的不限时流量包，不设过期时间，用完即止，非常适合多设备备用。</p>",
        sec4_title => "四、极连云购买与选型建议",
        sec4_text => "<p>性价比突出的老牌服务商，适合追求长期稳定运营的用户。</p>",
        plans => [
            { name => "年付基础包", traffic => "60G/月", monthly => "折合¥8.25", quarterly => "-", yearly => "¥99", limit => "3 台" },
            { name => "标准月付包", traffic => "200G/月", monthly => "¥25", quarterly => "¥70", yearly => "¥230", limit => "5 台" },
            { name => "不限时流量包", traffic => "300G一次性", monthly => "一次性", quarterly => "-", yearly => "¥88", limit => "无限制" }
        ]
    },
    "sujie-review.html" => {
        name => "速界机场",
        title => "速界机场怎么样？套餐、线路与测速评测",
        subtitle => "万兆极速 Hysteria 2 协议与 IEPL 专线，880Mbps 带宽与低延迟爆速怪物！",
        word_count => "约 2400 字",
        read_time => "大约 8 分钟",
        date => "2026-07-01",
        aff_url => "../index.html#airports",
        line_tech => "Hysteria 2 协议 · IEPL 专线中转",
        usage => "支持 Clash Verge / sing-box 客户端",
        min_monthly => "¥12/月起 (80G)",
        min_yearly => "¥120/年 (80G/月)",
        trial => "免费试用 2GB",
        coupon => "SUJIE90",
        coupon_desc => "全场季付以上 9 折",
        advice => "晚高峰宽带丢包严重的地区首选，Hysteria 2 协议冲破网络限速。",
        sec1_title => "一、专线中转接入点与容灾备用",
        sec1_text => "<p>速界机场主打新一代 Hysteria 2 协议与 IEPL 专线混合架构。即使在公网网络恶化的晚高峰，也能通过 QUIC (UDP) 协议强行跑满宽带。</p>",
        sec2_title => "二、全节点测速与 4K 流媒体实测",
        sec2_text => "<p>实测最高下行速率可达 880Mbps，4K 视频加载无等待，轻松拖拽进度条。</p>",
        sec3_title => "三、客户端协议支持与分流表现",
        sec3_text => "<p>完美支持 Clash Verge Rev 与 sing-box，提供精准的 GEOIP 规则分流。</p>",
        sec4_title => "四、速界机场选型评价",
        sec4_text => "<p>极具爆发力的现代化加速服务，非常适合大流量下载与超清影音。</p>",
        plans => [
            { name => "基础版", traffic => "80G", monthly => "¥12", quarterly => "¥33", yearly => "¥120", limit => "3 台" },
            { name => "进阶版", traffic => "250G", monthly => "¥25", quarterly => "¥70", yearly => "¥240", limit => "6 台" },
            { name => "尊享版", traffic => "600G", monthly => "¥50", quarterly => "¥140", yearly => "¥480", limit => "无限制" }
        ]
    },
    "kexin-review.html" => {
        name => "可信云",
        title => "可信云怎么样？套餐、线路与测速评测",
        subtitle => "企业级物理内网 IEPL 专线，极低延迟 26ms，外服游戏与实时交易首选！",
        word_count => "约 2300 字",
        read_time => "大约 7 分钟",
        date => "2026-06-25",
        aff_url => "../index.html#airports",
        line_tech => "企业级物理内网 IEPL 专线",
        usage => "适配全平台代理软件",
        min_monthly => "¥15/月起 (100G)",
        min_yearly => "¥148/年 (100G/月)",
        trial => "无试用",
        coupon => "KEXIN88",
        coupon_desc => "年付享 88 折特惠",
        advice => "适合外服游戏电竞、跨境电商实时交易及对延迟极度敏感的高端用户。",
        sec1_title => "一、企业级物理专线架构分析",
        sec1_text => "<p>可信云租用了昂贵的企业内网专线（如广港专线、深港专线），直接将数据通过光纤发送至海外 POP 点，抖动几乎为零。</p>",
        sec2_title => "二、外服游戏与实时交易延迟测试",
        sec2_text => "<p>广港专线延迟低至 26ms，游戏连接稳定不掉包，是外服电竞及加密货币交易者的安全保障。</p>",
        sec3_title => "三、原生 IP 解锁与工单响应服务",
        sec3_text => "<p>全节点支持流媒体解锁，并提供 7x24 小时工单技术支持，售后保障完善。</p>",
        sec4_title => "四、可信云评测总结",
        sec4_text => "<p>品质卓越的企业级专线服务，兼具极低延迟与高安全性。</p>",
        plans => [
            { name => "标准专线版", traffic => "100G", monthly => "¥15", quarterly => "¥42", yearly => "¥148", limit => "3 台" },
            { name => "商务专线版", traffic => "300G", monthly => "¥38", quarterly => "¥105", yearly => "¥360", limit => "8 台" }
        ]
    },
    "yuntu-review.html" => {
        name => "云图机场",
        title => "云图机场怎么样？套餐、线路与测速评测",
        subtitle => "提供一键专属自研客户端，开箱即用，低至 6.67 元/月平民月价！",
        word_count => "约 2100 字",
        read_time => "大约 6 分钟",
        date => "2026-06-10",
        aff_url => "../index.html#airports",
        line_tech => "高速中转 + 自研客户端",
        usage => "一键自研客户端 / 兼容通用客户端",
        min_monthly => "约 ¥6.67/月起 (年付80元)",
        min_yearly => "¥80/年 (50G/月)",
        trial => "免费试用 1GB",
        coupon => "YUNTU90",
        coupon_desc => "全场 9 折优惠码",
        advice => "电脑手机零基础小白用户的理想选择，下载客户端即可使用。",
        sec1_title => "一、专属自研客户端功能拆解",
        sec1_text => "<p>云图机场定制开发了覆盖 Windows 和 Android 的一键客户端，用户登录账号后无需配置复杂的订阅链接，点击开关即可使用。</p>",
        sec2_title => "二、新手零基础一键连接测试",
        sec2_text => "<p>即使是不懂代理原理的新手，也能在 1 分钟内完成安装与接入，体验极其友好。</p>",
        sec3_title => "三、低至 6.67 元平民月价评估",
        sec3_text => "<p>年付套餐折合每月仅需 6.67 元，价格亲民，降低了科学上网的门槛。</p>",
        sec4_title => "四、云图机场适合人群建议",
        sec4_text => "<p>推荐给追求傻瓜式操作与超低成本的入门用户。</p>",
        plans => [
            { name => "小白入门包", traffic => "50G/月", monthly => "折合¥6.67", quarterly => "-", yearly => "¥80", limit => "2 台" },
            { name => "大众进阶包", traffic => "150G/月", monthly => "¥15", quarterly => "¥40", yearly => "¥140", limit => "4 台" }
        ]
    },
    "flashleap-review.html" => {
        name => "闪跃机场 (FlashLeap)",
        title => "闪跃机场怎么样？套餐、线路与测速评测",
        subtitle => "IEPL 专线与自研多平台一键客户端结合，晚高峰 930Mbps 极限测速！",
        word_count => "约 2300 字",
        read_time => "大约 7 分钟",
        date => "2026-06-30",
        aff_url => "../index.html#airports",
        line_tech => "IEPL 专线 + 自研多平台客户端",
        usage => "自研客户端 / 通用订阅转换",
        min_monthly => "约 ¥8.33/月起 (年付100元)",
        min_yearly => "¥100/年 (100G/月)",
        trial => "注册试用 3GB",
        coupon => "FLASH88",
        coupon_desc => "新用户专属 88 折折扣码",
        advice => "既要自研客户端傻瓜操作，又要求专线极限速度的全面型选手。",
        sec1_title => "一、IEPL 专线与自研客户端结合",
        sec1_text => "<p>闪跃机场（FlashLeap）成功将高端 IEPL 专线与简易的一键自研客户端融为一体，兼顾了高性能与易用性。</p>",
        sec2_title => "二、晚高峰 930Mbps 极限测速",
        sec2_text => "<p>在千兆宽带下测试，闪跃节点下行测速突破 930Mbps，跑满绝大多数本地网络。</p>",
        sec3_title => "三、全平台解锁与零泄露测试",
        sec3_text => "<p>测试 DNS 泄露与 WebRTC 泄露均表现完美，真实 IP 得到严密保护。</p>",
        sec4_title => "四、闪跃机场综合购买建议",
        sec4_text => "<p>兼具速度、安全与便捷度的高分机场，非常值得入手。</p>",
        plans => [
            { name => "体验年付包", traffic => "100G/月", monthly => "折合¥8.33", quarterly => "-", yearly => "¥100", limit => "3 台" },
            { name => "尊享月付包", traffic => "300G/月", monthly => "¥28", quarterly => "¥78", yearly => "¥260", limit => "6 台" }
        ]
    }
);

# Also handle kexinyun-review.html as alias of kexin-review.html
$reviews{"kexinyun-review.html"} = $reviews{"kexin-review.html"};

foreach my $filename (keys %reviews) {
    my $info = $reviews{$filename};
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
                            <span class="pill-badge">注册试用</span>
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
                                <li><strong>快速查看：</strong> <a href="#sec1">线路结构</a> · <a href="#plans">套餐与优惠</a> · <a href="../reviews.html">全部机场比较</a></li>
                            </ul>
                        </div>

                        <div class="action-btn-wrap" style="text-align: center;">
                            <a href="$info->{aff_url}" target="_blank" rel="nofollow noopener noreferrer" class="btn-oval-action">
                                查看 $info->{name} 当前套餐
                            </a>
                        </div>
                    </div>

                    <h2 id="sec1">$info->{sec1_title}</h2>
                    $info->{sec1_text}

                    <h2 id="sec2">$info->{sec2_title}</h2>
                    $info->{sec2_text}

                    <h2 id="sec3">$info->{sec3_title}</h2>
                    $info->{sec3_text}

                    <h2 id="plans">订阅套餐与价格对比</h2>
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

                    <h2 id="sec4">$info->{sec4_title}</h2>
                    $info->{sec4_text}
                    
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
                    <li><a href="#sec1">$info->{sec1_title}</a></li>
                    <li><a href="#sec2">$info->{sec2_title}</a></li>
                    <li><a href="#sec3">$info->{sec3_title}</a></li>
                    <li><a href="#plans">订阅套餐与价格对比</a></li>
                    <li><a href="#sec4">$info->{sec4_title}</a></li>
                    <li><a href="../reviews.html">全部机场综合比较</a></li>
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
    print "Successfully generated review article: $filename\n";
}

print "ALL_8_REVIEWS_PERFECTLY_GENERATED\n";
