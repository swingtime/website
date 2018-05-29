#!/usr/bin/perl

$dir = "@ARGV[0]";

opendir(DIR, $dir);
@pics = grep(/.*\.[J|j][P|p][G|g]/, (sort readdir(DIR)));
closedir(DIR);

$n = 100;
print "renaming...\n";
foreach (@pics) {
    print "   $_ -> $n.jpg\n";
    `mv $dir/$_ $dir/$n.jpg`;
    $n++;
}
