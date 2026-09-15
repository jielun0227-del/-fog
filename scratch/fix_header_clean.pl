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

my @files = bsd_glob("articles/*.html");

foreach my $filepath (@files) {
    open(my $fh, "<:encoding(UTF-8)", $filepath) or die "Cannot read $filepath: $!";
    local $/ = undef;
    my $content = <$fh>;
    close($fh);

    # Replace header completely
    if ($content =~ /<header class="navbar">.*?<\/header>/s) {
        $content =~ s/<header class="navbar">.*?<\/header>/$nav_html/s;
    } else {
        $content =~ s/(<body[^>]*>)/$1\n$nav_html/i;
    }

    # Remove duplicate consecutive headers
    while ($content =~ s/(<header class="navbar">.*?<\/header>\s*)(?=.*?<header class="navbar">)//s) {}

    open(my $out, ">:encoding(UTF-8)", $filepath) or die "Cannot write $filepath: $!";
    print $out $content;
    close($out);
    print "Header fixed: $filepath\n";
}

print "ALL_HEADERS_FIXED\n";
