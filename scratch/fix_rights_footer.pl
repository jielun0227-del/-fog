use strict;
use warnings;
use utf8;
use File::Glob 'bsd_glob';

binmode(STDOUT, ":utf8");
binmode(STDERR, ":utf8");

my @files = bsd_glob("articles/*.html");

foreach my $filepath (@files) {
    open(my $fh, "<:encoding(UTF-8)", $filepath) or die $!;
    local $/ = undef;
    my $content = <$fh>;
    close($fh);

    $content =~ s/䯽留所有权利/保留所有权利/g;
    $content =~ s/䯽/保/g;

    open(my $out, ">:encoding(UTF-8)", $filepath) or die $!;
    print $out $content;
    close($out);
}

print "RIGHTS_FOOTER_FIXED\n";
