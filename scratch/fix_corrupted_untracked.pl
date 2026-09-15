use strict;
use warnings;
use utf8;
use File::Glob 'bsd_glob';

binmode(STDOUT, ":utf8");
binmode(STDERR, ":utf8");

my @files = bsd_glob("articles/*.html");

foreach my $file (@files) {
    open(my $fh, "<:encoding(UTF-8)", $file) or die "Cannot read $file: $!";
    local $/ = undef;
    my $content = <$fh>;
    close($fh);

    if ($content =~ /机场Fog 测评博客</) {
        $content =~ s/机场Fog 测评博客//g;

        # Also ensure bold stars **text** are strong
        $content =~ s/\*\*([^\*\n]+)\*\*/<strong>$1<\/strong>/g;

        open(my $out, ">:encoding(UTF-8)", $file) or die "Cannot write $file: $!";
        print $out $content;
        close($out);
        print "Cleaned corrupted file: $file\n";
    }
}

print "UNTRACKED_CLEANUP_FINISHED\n";
