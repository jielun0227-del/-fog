use strict;
use warnings;
use utf8;
use File::Glob 'bsd_glob';

binmode(STDOUT, ":utf8");
binmode(STDERR, ":utf8");

# Find all HTML files in root and articles
my @files = (bsd_glob("*.html"), bsd_glob("articles/*.html"));

# Standard White Navbar for Articles
my $nav_article = <<'NAV';
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
NAV

# Standard White Navbar for Root pages
my $nav_root = <<'NAV';
  <header class="navbar">
    <div class="nav-container">
      <a href="index.html" class="logo">
        <span class="logo-text">机场Fog</span>
      </a>
      <nav class="nav-links">
        <a href="index.html">机场推荐</a>
        <a href="knowledge.html">知识库</a>
        <a href="articles.html">文章科普</a>
        <a href="reviews.html">详细评测</a>
        <a href="about.html">关于</a>
      </nav>
    </div>
  </header>
NAV

foreach my $filepath (@files) {
    open(my $fh, "<:encoding(UTF-8)", $filepath) or die "Cannot read $filepath: $!";
    local $/ = undef;
    my $content = <$fh>;
    close($fh);

    # 1. Strip ALL Emojis (📅 🏷️ 👤 ⚙️ ⚡ 🎯 🚀 🤖 🌐 🔒 💻 💡 🛡️ 📶 📱 🔑 🛠 📌 📝 🌟 🔍 etc.)
    $content =~ s/[\x{1F300}-\x{1F9FF}\x{2600}-\x{26FF}\x{2700}-\x{27BF}\x{FE0F}]//g;

    # 2. Update Headers
    if ($filepath =~ /^articles\//) {
        if ($content =~ /<header[^>]*>.*?<\/header>/s) {
            $content =~ s/<header[^>]*>.*?<\/header>/$nav_article/s;
        }
    } else {
        if ($content =~ /<header class="navbar">.*?<\/header>/s) {
            $content =~ s/<header class="navbar">.*?<\/header>/$nav_root/s;
        }
    }

    # 3. Clean stray icons in logo
    $content =~ s/<span class="logo-icon"><\/span>//g;
    $content =~ s/<span class="search-icon">[^<]*<\/span>//g;

    # 4. Clean stray AI language remnants
    $content =~ s/作为一名[^，,]+[，,]//g;
    $content =~ s/在当今[^，,]+时代[，,]//g;
    $content =~ s/不可否认[，,]//g;
    $content =~ s/毫无疑问[，,]//g;
    $content =~ s/众所周知[，,]//g;
    $content =~ s/不得不说[，,]//g;

    # 5. Clean meta headers
    $content =~ s/发布日期：/发布日期：/g;
    $content =~ s/分类：/分类：/g;
    $content =~ s/作者：/作者：/g;

    open(my $out, ">:encoding(UTF-8)", $filepath) or die "Cannot write $filepath: $!";
    print $out $content;
    close($out);

    print "Cleaned emojis & white theme: $filepath\n";
}

print "ALL_EMOJIS_STRIPPED_WHITE_NAVBAR_APPLIED\n";
