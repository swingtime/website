#!/usr/bin/perl

$dir = "@ARGV[0]";

opendir(DIR, $dir);
@pics = grep(/.*\.[J|j][P|p][G|g]/, (sort readdir(DIR)));
closedir(DIR);

foreach $p (@pics) {
    `convert -geometry 300x200 $dir/$p $dir/T$p`;
}
