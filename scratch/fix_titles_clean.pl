use strict;
use warnings;
use utf8;
use File::Glob 'bsd_glob';

binmode(STDOUT, ":utf8");
binmode(STDERR, ":utf8");

my @files = (bsd_glob("*.html"), bsd_glob("articles/*.html"));

foreach my $filepath (@files) {
    open(my $fh, "<:encoding(UTF-8)", $filepath) or die $!;
    local $/ = undef;
    my $content = <$fh>;
    close($fh);

    if ($content =~ /<title>([^<]*?) - <\/title>/) {
        $content =~ s/<title>([^<]*?) - <\/title>/<title>$1 - 机场Fog 测评博客<\/title>/g;
        open(my $out, ">:encoding(UTF-8)", $filepath) or die $!;
        print $out $content;
        close($out);
        print "Fixed title: $filepath\n";
    }
}

print "TITLES_CLEANED\n";
