use strict;
use warnings;
use utf8;
use File::Glob 'bsd_glob';

binmode(STDOUT, ":utf8");
binmode(STDERR, ":utf8");

my @files = bsd_glob("articles/*.html");

foreach my $filepath (@files) {
    open(my $fh, "<:encoding(UTF-8)", $filepath) or die "Cannot read $filepath: $!";
    local $/ = undef;
    my $content = <$fh>;
    close($fh);

    # 1. Add article-page-body class to body
    $content =~ s/<body([^>]*)>/<body$1 class="article-page-body">/i if $content !~ /article-page-body/;

    # 2. De-AI language filtering
    $content =~ s/作为一名[^，,]+[，,]//g;
    $content =~ s/在当今[^，,]+时代[，,]//g;
    $content =~ s/不可否认[，,]//g;
    $content =~ s/毫无疑问[，,]//g;
    $content =~ s/众所周知[，,]//g;
    $content =~ s/不得不说[，,]//g;
    $content =~ s/综上所述[，,]//g;
    $content =~ s/总而言之[，,]//g;
    $content =~ s/显而易见[，,]//g;

    # 3. Convert any raw markdown bold **text** to HTML <strong>text</strong>
    $content =~ s/\*\*([^\*\n]+)\*\*/<strong>$1<\/strong>/g;

    # 4. Standardize sidebar title to "此页内容"
    $content =~ s/<h3 class="widget-title">[^<]*相关推荐[^<]*<\/h3>/<h3 class="widget-title">此页内容<\/h3>/g;
    $content =~ s/<h3 class="widget-title">[^<]*目录[^<]*<\/h3>/<h3 class="widget-title">此页内容<\/h3>/g;

    open(my $out, ">:encoding(UTF-8)", $filepath) or die "Cannot write $filepath: $!";
    print $out $content;
    close($out);

    print "Applied white template & De-AI: $filepath\n";
}

print "ALL_WHITE_TEMPLATE_APPLIED\n";
