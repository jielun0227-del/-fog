/**
 * script.js - Interactive engine for 2026 Airport Review Blog
 */

// Master Dataset of 8 Featured Airports (Strict Order Specified by User)
const AIRPORTS_DATA = [
  {
    id: "kuaili",
    name: "快狸",
    logo: "https://i.eoht.net/logo/kuaili_logo.webp",
    url: "https://yyo649929.kuailiaff.com/#/register?code=EjqxPHQZ",
    priceText: "¥120 / ¥10·30GB/月",
    annualPrice: 120,
    monthlyPrice: 10.0,
    monthlyTraffic: 30,
    hasOneTime: false,
    hasTrial: false,
    lineType: "高速隧道中转",
    unlockInfo: "Netflix / YouTube / ChatGPT",
    tags: [],
    speedMbps: 760,
    pingMs: 45,
    desc: "快狸具备清晰的拓扑与优异的协议调度能力，线路晚高峰丢包率低。"
  },
  {
    id: "jiuyun",
    name: "九云",
    logo: "./images/jiuyun_logo.png",
    url: "https://888.jiuyundl.com/#/register?code=e5M4mtXM",
    priceText: "¥99 / ¥6·150GB/月",
    annualPrice: 99,
    monthlyPrice: 6.0,
    monthlyTraffic: 150,
    hasOneTime: true,
    hasTrial: false,
    lineType: "高速中转 / 优化节点",
    unlockInfo: "4K 流媒体 / 社交 / AI 解锁",
    tags: ["budget", "onetime"],
    speedMbps: 850,
    pingMs: 35,
    desc: "九云主打白菜价超高性价比，月付6元起（150G流量），并提供不限时应急流量包，适配追剧与日常上网。"
  },
  {
    id: "guangnianti",
    name: "光年梯",
    logo: "./images/guangnianti_logo.png",
    url: "https://1579.gntaff.com/#/?code=PzvG9uPl",
    priceText: "¥118 / 约¥9.83·100GB/月",
    annualPrice: 118,
    monthlyPrice: 9.83,
    monthlyTraffic: 100,
    hasOneTime: true,
    hasTrial: false,
    lineType: "IPLC / IEPL 全专线",
    unlockInfo: "YouTube 8K / ChatGPT / Netflix",
    tags: ["iepl", "onetime", "budget"],
    speedMbps: 950,
    pingMs: 29,
    desc: "光年梯主打极速传输与零抖动专线，全节点直连与低延迟对齐，支持一次性流量包与大流量月付。"
  },
  {
    id: "edgenova",
    name: "边缘节点",
    logo: "https://i.eoht.net/logo/edgenova_logo.webp",
    url: "https://everett7623.edgenovaaff.cc/#/register?code=tT3McfnN",
    priceText: "¥108 / ¥9·45GB/月",
    annualPrice: 108,
    monthlyPrice: 9.0,
    monthlyTraffic: 45,
    hasOneTime: false,
    hasTrial: false,
    lineType: "跨境 BGP / 隧道中转",
    unlockInfo: "ChatGPT / OpenAI API",
    tags: ["budget"],
    speedMbps: 820,
    pingMs: 40,
    desc: "边缘节点专注跨境企业访问优化与原生态原生 IP 输出。"
  },
  {
    id: "jilianyun",
    name: "极连云",
    logo: "./images/jilian_logo.png",
    url: "https://157935.jlyvipaff.com/#/register?code=Sm7oT61X",
    priceText: "¥99 / 约¥8.25·60GB/月",
    annualPrice: 99,
    monthlyPrice: 8.25,
    monthlyTraffic: 60,
    hasOneTime: true,
    hasTrial: false,
    lineType: "IEPL专线 / 隧道中转",
    unlockInfo: "Netflix / Disney+ / ChatGPT 4o",
    tags: ["iepl", "onetime", "budget"],
    speedMbps: 910,
    pingMs: 34,
    desc: "极连云提供优质 IEPL 过境专线与中转集群，晚高峰速率稳定，具备不限时一次性流量包选项。"
  },
  {
    id: "sujie",
    name: "速界",
    logo: "https://i.eoht.net/logo/sujie_logo.webp",
    url: "https://lqy001.speedworldaff.com/#/?code=ysM6ozIh",
    priceText: "¥90 / ¥7.5·50GB/月",
    annualPrice: 90,
    monthlyPrice: 7.5,
    monthlyTraffic: 50,
    hasOneTime: false,
    hasTrial: false,
    lineType: "IEPL企业级专线",
    unlockInfo: "Netflix / HBO / Gemini",
    tags: ["iepl", "budget"],
    speedMbps: 890,
    pingMs: 33,
    desc: "速界专注于游戏加速与实时语音服务，全节点均走专线低抖动传输。"
  },
  {
    id: "kexin",
    name: "可信云",
    logo: "./images/kexin_logo.png",
    url: "https://yp76688.kosingaff.com/#/register?code=KJxZyDig",
    priceText: "¥96 / ¥8·60GB/月",
    annualPrice: 96,
    monthlyPrice: 8.0,
    monthlyTraffic: 60,
    hasOneTime: false,
    hasTrial: false,
    lineType: "IEPL专线 (60GB~1.2TB)",
    unlockInfo: "ChatGPT 4o / 流媒体全解锁",
    tags: ["iepl", "budget"],
    speedMbps: 920,
    pingMs: 33,
    desc: "可信云拥有丰富的阶梯套餐（最高 1.2TB/月），全线采用 IEPL 专线过国境。"
  },
  {
    id: "yuntu",
    name: "云图",
    logo: "./images/yuntu_logo.png",
    url: "https://vip.ytjcok.org/#/register?code=Av0K1D4P",
    priceText: "¥96 / ¥8·80GB/月",
    annualPrice: 96,
    monthlyPrice: 8.0,
    monthlyTraffic: 80,
    hasOneTime: false,
    hasTrial: false,
    lineType: "BGP 中转 / 专属客户端",
    unlockInfo: "全平台 8K 解锁 / Gemini / Claude",
    tags: ["client", "budget"],
    speedMbps: 860,
    pingMs: 38,
    desc: "云图采用智能选路与云图专有分流规则，解锁全平台流媒体与 AI 工具，性价比出众。"
  },
  {
    id: "flashleap",
    name: "闪跃",
    logo: "./images/flashleap_logo.png",
    url: "https://jielun0227.flashleapaff.com/#/?code=uyTPETiU",
    priceText: "¥96 / ¥8·60GB/月",
    annualPrice: 96,
    monthlyPrice: 8.0,
    monthlyTraffic: 60,
    hasOneTime: false,
    hasTrial: false,
    lineType: "IEPL专线/自研客户端",
    unlockInfo: "Disney+ / Netflix / Claude",
    tags: ["client", "iepl", "budget"],
    speedMbps: 930,
    pingMs: 30,
    desc: "闪跃主打极致低延迟专线与多平台客户端集成，延迟低至 30ms。"
  }
];

// Current State variables
let currentFilter = "all";
let currentSearchTerm = "";
let currentSort = "default";

// DOM Loaded Initialization
document.addEventListener("DOMContentLoaded", () => {
  initTheme();
  renderAllComponents();
  bindEvents();
  initChecklist();
});

// Render Components
function renderAllComponents() {
  const filteredData = filterAndSortData();
  renderTable(filteredData);
  renderCards(filteredData);
  filterFeaturedAirports(filteredData);
  
  const countEl = document.getElementById("visibleCount");
  if (countEl) countEl.textContent = filteredData.length;
}

// Filter static featured cards on homepage
function filterFeaturedAirports(filteredData) {
  const container = document.getElementById("featuredAirportsGrid");
  if (!container) return;

  const cards = container.querySelectorAll(".airport-feature-card");

  cards.forEach(card => {
    const cardText = card.textContent.toLowerCase();
    const matchesSearch = !currentSearchTerm || cardText.includes(currentSearchTerm.toLowerCase());
    
    let matchesFilter = true;
    if (currentFilter !== "all") {
      const tags = card.dataset.tags || "";
      matchesFilter = tags.includes(currentFilter);
    }

    if (matchesSearch && matchesFilter) {
      card.style.display = "flex";
    } else {
      card.style.display = "none";
    }
  });
}

// Filter and Sort Logic
function filterAndSortData() {
  return AIRPORTS_DATA.filter(item => {
    // 1. Tag filter
    if (currentFilter !== "all") {
      if (!item.tags.includes(currentFilter)) return false;
    }
    
    // 2. Search term
    if (currentSearchTerm.trim() !== "") {
      const term = currentSearchTerm.toLowerCase();
      const matchName = item.name.toLowerCase().includes(term);
      const matchLine = item.lineType.toLowerCase().includes(term);
      const matchDesc = item.desc.toLowerCase().includes(term);
      const matchUnlock = item.unlockInfo.toLowerCase().includes(term);
      if (!matchName && !matchLine && !matchDesc && !matchUnlock) return false;
    }

    return true;
  }).sort((a, b) => {
    if (currentSort === "price-asc") return a.annualPrice - b.annualPrice;
    if (currentSort === "price-desc") return b.annualPrice - a.annualPrice;
    if (currentSort === "traffic-desc") return b.monthlyTraffic - a.monthlyTraffic;
    return 0; // default (preserves AIRPORTS_DATA array order)
  });
}

// Render Comparison Table
function renderTable(data) {
  const tbody = document.getElementById("airportTableBody");
  if (!tbody) return;

  if (data.length === 0) {
    tbody.innerHTML = `<tr><td colspan="7" style="text-align:center; padding: 2rem; color: var(--text-sub);">🔍 没有找到匹配的机场方案</td></tr>`;
    return;
  }

  tbody.innerHTML = data.map((item, idx) => `
    <tr>
      <td>
        <a href="articles/${item.id}-review.html" style="color: var(--text-main); font-weight: 700; text-decoration: none;">
          <span style="display:inline-block; width: 20px; text-align: center; color: var(--text-sub); font-size: 0.8rem; margin-right: 4px;">${idx + 1}.</span>${item.name}
        </a>
      </td>
      <td>
        <a class="pill-link" href="${item.url}" target="_blank" rel="sponsored noreferrer">
          <img src="${item.logo}" alt="${item.name}" width="24" height="24" onerror="this.onerror=null; this.src='https://i.eoht.net/logo/kuaili_logo.webp';">
          <span>官网注册入口</span>
        </a>
      </td>
      <td><strong style="color: var(--accent-primary);">${item.priceText}</strong></td>
      <td>${item.hasOneTime ? '<span class="tag-pill tag-green">有 (一次性包)</span>' : '<span class="tag-pill tag-gray">—</span>'}</td>
      <td><span class="tag-pill tag-blue">${item.lineType}</span></td>
      <td><span class="tag-pill tag-purple">${item.unlockInfo}</span></td>
      <td>
        <a class="pill-link" href="articles/${item.id}-review.html" style="border-color: var(--border-color); color: var(--text-muted);">
          查看完整评测
        </a>
      </td>
    </tr>
  `).join("");
}

// Render Benchmark Visualizer Bars
function renderBenchmark(data) {
  const container = document.getElementById("benchmarkGrid");
  if (!container) return;

  const items = data;

  container.innerHTML = items.map(item => {
    const barWidth = Math.min(100, Math.round((item.speedMbps / 1000) * 100));
    return `
      <div class="benchmark-card">
        <div class="card-top">
          <span class="ap-name">${item.name}</span>
          <span class="ping-val">延迟: ~${item.pingMs}ms</span>
        </div>
        <div class="bar-container">
          <div class="bar-label-row">
            <span>晚高峰峰值带宽</span>
            <strong>${item.speedMbps} Mbps</strong>
          </div>
          <div class="bar-bg">
            <div class="bar-fill" style="width: ${barWidth}%;"></div>
          </div>
        </div>
      </div>
    `;
  }).join("");
}

// Render Detailed Cards Grid
function renderCards(data) {
  const container = document.getElementById("reviewsGrid");
  if (!container) return;

  if (data.length === 0) {
    container.innerHTML = `<div style="grid-column: 1/-1; text-align:center; padding: 3rem; color: var(--text-sub);">没有匹配的机场详细评测。</div>`;
    return;
  }

  container.innerHTML = data.map((item, idx) => `
    <div class="review-card" id="airport-${item.id}">
      <div class="review-card-header">
        <div class="review-card-title">
          <img src="${item.logo}" alt="${item.name}" width="44" height="44" class="airport-logo" style="width: 44px; height: 44px; flex-shrink: 0; object-fit: cover;" onerror="this.onerror=null; this.src='https://i.eoht.net/logo/kuaili_logo.webp';">
          <div>
            <h3><span style="color: var(--accent-primary); font-size: 0.95rem; margin-right: 4px;">TOP ${idx + 1}</span> ${item.name}</h3>
            <div class="review-card-meta">
              <span class="tag-pill tag-blue">${item.lineType}</span>
              ${item.hasTrial ? '<span class="tag-pill tag-green">免费试用</span>' : ''}
              ${item.hasOneTime ? '<span class="tag-pill tag-purple">含一次性包</span>' : ''}
            </div>
          </div>
        </div>
      </div>

      <p style="font-size: 0.875rem; color: var(--text-muted);">${item.desc}</p>

      <div class="review-card-specs">
        <div class="spec-item">
          <span class="label">入门套餐</span>
          <span class="value">${item.priceText}</span>
        </div>
        <div class="spec-item">
          <span class="label">解锁保障</span>
          <span class="value">${item.unlockInfo}</span>
        </div>
        <div class="spec-item">
          <span class="label">晚高峰带宽</span>
          <span class="value" style="color: var(--accent-success);">${item.speedMbps} Mbps</span>
        </div>
        <div class="spec-item">
          <span class="label">平均延迟</span>
          <span class="value">${item.pingMs} ms</span>
        </div>
      </div>

      <div class="review-card-actions">
        <a href="${item.url}" target="_blank" rel="sponsored noreferrer" class="btn-primary">
          访问官网直达
        </a>
        <a href="articles/${item.id}-review.html" class="btn-secondary">
          完整评测
        </a>
      </div>
    </div>
  `).join("");
}

// Bind UI Events
function bindEvents() {
  const globalSearch = document.getElementById("globalSearchInput");
  const tableFilter = document.getElementById("tableFilterInput");

  if (globalSearch) {
    globalSearch.addEventListener("input", (e) => {
      currentSearchTerm = e.target.value;
      if (tableFilter) tableFilter.value = currentSearchTerm;
      renderAllComponents();
    });
  }

  if (tableFilter) {
    tableFilter.addEventListener("input", (e) => {
      currentSearchTerm = e.target.value;
      if (globalSearch) globalSearch.value = currentSearchTerm;
      renderAllComponents();
    });
  }

  // Keyboard shortcut Ctrl/Cmd + K
  document.addEventListener("keydown", (e) => {
    if ((e.metaKey || e.ctrlKey) && e.key === "k") {
      e.preventDefault();
      if (globalSearch) globalSearch.focus();
    }
  });

  // Filter Chips
  const filterChips = document.getElementById("filterChips");
  if (filterChips) {
    filterChips.addEventListener("click", (e) => {
      const btn = e.target.closest(".chip-btn");
      if (!btn) return;

      document.querySelectorAll(".chip-btn").forEach(b => b.classList.remove("active"));
      btn.classList.add("active");

      currentFilter = btn.dataset.filter;
      renderAllComponents();
    });
  }

  // Table Sort Dropdown
  const sortSelect = document.getElementById("tableSortSelect");
  if (sortSelect) {
    sortSelect.addEventListener("change", (e) => {
      currentSort = e.target.value;
      renderAllComponents();
    });
  }

  // Theme Toggle Button
  const themeBtn = document.getElementById("themeToggleBtn");
  if (themeBtn) {
    themeBtn.addEventListener("click", () => {
      const currentTheme = document.documentElement.getAttribute("data-theme") || "light";
      const newTheme = currentTheme === "dark" ? "light" : "dark";
      document.documentElement.setAttribute("data-theme", newTheme);
      localStorage.setItem("theme", newTheme);
    });
  }
}

// Theme Persistence Initialization
function initTheme() {
  const savedTheme = localStorage.getItem("theme") || "light";
  document.documentElement.setAttribute("data-theme", savedTheme);
}

// Global Filter Helper function
window.filterByTag = function(tag) {
  currentFilter = tag;
  const chip = document.querySelector(`.chip-btn[data-filter="${tag}"]`);
  if (chip) {
    document.querySelectorAll(".chip-btn").forEach(b => b.classList.remove("active"));
    chip.classList.add("active");
  }
  renderAllComponents();
  const tableSection = document.getElementById("airports-table");
  if (tableSection) tableSection.scrollIntoView({ behavior: "smooth" });
};

// Interactive Pre-Purchase Checklist
function initChecklist() {
  const checkboxes = document.querySelectorAll(".task-checkbox");
  const fillBar = document.getElementById("checkProgressFill");
  const textCount = document.getElementById("checkProgressText");

  if (!checkboxes || checkboxes.length === 0) return;

  function updateProgress() {
    let checkedCount = 0;
    checkboxes.forEach(cb => {
      if (cb.checked) checkedCount++;
    });

    const percent = Math.round((checkedCount / checkboxes.length) * 100);
    if (fillBar) fillBar.style.width = `${percent}%`;
    if (textCount) textCount.textContent = `已完成 ${checkedCount} / ${checkboxes.length} 项检查 (${percent}%)`;
  }

  checkboxes.forEach(cb => {
    cb.addEventListener("change", updateProgress);
  });

  updateProgress();
}

// Quantum Ladder Dynamic Perspective Canvas Animation (极光阶梯跃迁动效)
function initQuantumLadderCanvas() {
  let canvas = document.getElementById("quantumLadderCanvas");
  if (!canvas) {
    canvas = document.createElement("canvas");
    canvas.id = "quantumLadderCanvas";
    document.body.prepend(canvas);
  }

  const ctx = canvas.getContext("2d");
  let width = (canvas.width = window.innerWidth);
  let height = (canvas.height = window.innerHeight);

  window.addEventListener("resize", () => {
    width = canvas.width = window.innerWidth;
    height = canvas.height = window.innerHeight;
  });

  // Floating Quantum Particles rising upward
  const numParticles = 65;
  const particles = [];
  for (let i = 0; i < numParticles; i++) {
    particles.push({
      x: Math.random() * width,
      y: Math.random() * height,
      radius: Math.random() * 2 + 0.6,
      speedY: Math.random() * 1.2 + 0.4,
      opacity: Math.random() * 0.7 + 0.3,
      pulse: Math.random() * 0.03 + 0.01,
      color: Math.random() > 0.4 ? "#00F2FE" : (Math.random() > 0.5 ? "#4FACFE" : "#818CF8")
    });
  }

  let ladderOffset = 0;

  function animate() {
    ctx.clearRect(0, 0, width, height);

    // Dynamic gradient based on dark vs light mode
    const isLight = document.documentElement.getAttribute("data-theme") === "light";

    const bgGrad = ctx.createLinearGradient(0, 0, 0, height);
    if (isLight) {
      bgGrad.addColorStop(0, "rgba(251, 249, 245, 0.1)");
      bgGrad.addColorStop(0.5, "rgba(242, 239, 233, 0.25)");
      bgGrad.addColorStop(1, "rgba(251, 249, 245, 0.1)");
    } else {
      bgGrad.addColorStop(0, "rgba(7, 10, 19, 0.2)");
      bgGrad.addColorStop(0.5, "rgba(10, 15, 32, 0.35)");
      bgGrad.addColorStop(1, "rgba(7, 10, 19, 0.2)");
    }
    ctx.fillStyle = bgGrad;
    ctx.fillRect(0, 0, width, height);

    // Draw Perspective Glowing Quantum Ladder (中央发光透视阶梯)
    const centerX = width / 2;
    const vanishY = height * 0.12; // Vanishing horizon point
    const bottomY = height;
    const topWidth = 120;
    const bottomWidth = width * 0.75;

    ctx.save();
    
    // Ladder Side Rays Glow
    ctx.beginPath();
    ctx.moveTo(centerX - topWidth / 2, vanishY);
    ctx.lineTo(centerX - bottomWidth / 2, bottomY);
    ctx.lineTo(centerX + bottomWidth / 2, bottomY);
    ctx.lineTo(centerX + topWidth / 2, vanishY);
    ctx.closePath();

    const ladderGlow = ctx.createLinearGradient(0, vanishY, 0, bottomY);
    if (isLight) {
      ladderGlow.addColorStop(0, "rgba(158, 58, 38, 0.18)");
      ladderGlow.addColorStop(0.5, "rgba(74, 96, 84, 0.08)");
      ladderGlow.addColorStop(1, "rgba(251, 249, 245, 0.0)");
    } else {
      ladderGlow.addColorStop(0, "rgba(0, 242, 254, 0.25)");
      ladderGlow.addColorStop(0.5, "rgba(79, 172, 254, 0.08)");
      ladderGlow.addColorStop(1, "rgba(7, 10, 19, 0.0)");
    }
    ctx.fillStyle = ladderGlow;
    ctx.fill();

    // Ladder Rail Lines
    ctx.strokeStyle = isLight ? "rgba(158, 58, 38, 0.28)" : "rgba(0, 242, 254, 0.35)";
    ctx.lineWidth = 2;
    ctx.beginPath();
    ctx.moveTo(centerX - topWidth / 2, vanishY);
    ctx.lineTo(centerX - bottomWidth / 2, bottomY);
    ctx.moveTo(centerX + topWidth / 2, vanishY);
    ctx.lineTo(centerX + bottomWidth / 2, bottomY);
    ctx.stroke();

    // Horizontal Rungs moving upward (跃升阶梯横向光脉冲)
    ladderOffset = (ladderOffset + 0.6) % 35;
    const numRungs = 24;

    for (let i = 0; i < numRungs; i++) {
      let progress = (i * 35 + ladderOffset) / (numRungs * 35);
      if (progress > 1) progress -= 1;
      
      const currentY = vanishY + Math.pow(progress, 2.2) * (bottomY - vanishY);
      const currentHalfWidth = (topWidth / 2) + Math.pow(progress, 2.2) * ((bottomWidth - topWidth) / 2);
      
      const rungAlpha = Math.sin(progress * Math.PI) * 0.45;
      
      ctx.strokeStyle = isLight ? `rgba(158, 58, 38, ${rungAlpha})` : `rgba(0, 242, 254, ${rungAlpha})`;
      ctx.lineWidth = 1 + progress * 2;
      ctx.beginPath();
      ctx.moveTo(centerX - currentHalfWidth, currentY);
      ctx.lineTo(centerX + currentHalfWidth, currentY);
      ctx.stroke();
    }

    ctx.restore();

    // Draw & Update Floating Particles
    particles.forEach(p => {
      ctx.beginPath();
      ctx.arc(p.x, p.y, p.radius, 0, Math.PI * 2);
      ctx.fillStyle = isLight ? "#9E3A26" : p.color;
      ctx.globalAlpha = isLight ? p.opacity * 0.7 : p.opacity;
      ctx.shadowBlur = isLight ? 4 : 8;
      ctx.shadowColor = isLight ? "#9E3A26" : p.color;
      ctx.fill();
      ctx.shadowBlur = 0;
      ctx.globalAlpha = 1.0;

      p.y -= p.speedY;
      p.opacity += p.pulse;
      if (p.opacity > 0.8 || p.opacity < 0.2) p.pulse = -p.pulse;

      if (p.y < 0) {
        p.y = height + 10;
        p.x = Math.random() * width;
      }
    });

    requestAnimationFrame(animate);
  }

  animate();
}

// Auto init on DOM ready
document.addEventListener("DOMContentLoaded", () => {
  initQuantumLadderCanvas();
});
