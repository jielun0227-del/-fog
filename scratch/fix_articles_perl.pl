use strict;
use warnings;
use utf8;
use File::Glob 'bsd_glob';

binmode(STDOUT, ":utf8");
binmode(STDERR, ":utf8");

my $nav_html = <<'NAV';
  <header class="navbar">
    <div class="nav-container">
      <a href="../index.html" class="logo">
        <span class="logo-icon">⚡</span>
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

my $footer_html = <<'FOOTER';
  <footer class="site-footer">
    <div class="container">
      <p>&copy; 2026 机场Fog 测评博客. 保留所有权利。</p>
    </div>
  </footer>
FOOTER

my @files = bsd_glob("articles/*.html");

foreach my $filepath (@files) {
    open(my $fh, "<:encoding(UTF-8)", $filepath) or die "Cannot read $filepath: $!";
    local $/ = undef;
    my $content = <$fh>;
    close($fh);

    # Replace legacy text
    $content =~ s{椰汁网络日志}{机场Fog 测评博客}g;
    $content =~ s{椰汁评测组}{机场Fog 测评团队}g;
    $content =~ s{椰汁网络}{机场Fog 测评博客}g;
    $content =~ s{椰汁}{机场Fog}g;

    # Replace css link
    $content =~ s{href=["'][^"']*css/style\.css["']}{href="../styles.css"}g;
    if ($content !~ /styles\.css/) {
        $content =~ s{</head>}{  <link rel="stylesheet" href="../styles.css">\n</head>};
    }

    # Replace existing header with nav_html
    if ($content =~ /<header[^>]*>.*?<\/header>/s) {
        $content =~ s{<header[^>]*>.*?<\/header>}{$nav_html}s;
    } else {
        $content =~ s{(<body[^>]*>)}{$1\n$nav_html}i;
    }

    # Replace footer
    if ($content =~ /<footer[^>]*>.*?<\/footer>/s) {
        $content =~ s{<footer[^>]*>.*?<\/footer>}{$footer_html}s;
    } else {
        $content =~ s{</body>}{$footer_html\n</body>};
    }

    open(my $out, ">:encoding(UTF-8)", $filepath) or die "Cannot write $filepath: $!";
    print $out $content;
    close($out);

    print "Processed $filepath\n";
}

print "ALL_PERL_FIXES_COMPLETE\n";
