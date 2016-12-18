#!/usr/bin/perl

$source_dir = @ARGV[0];
$target_dir = @ARGV[1];

opendir(IMG_DIR, $source_dir);
@img_files = grep(/\w*.[J|j][P|p][G|g]$/, (sort readdir(IMG_DIR)));
closedir(IMG_DIR);

$options_600 = "-quality 90 -geometry 600x450";
$options_T = "-quality 100 -geometry 100x75";

open(ORDERFILE, ">>$target_dir/ORDER");

print "Converting files in $source_dir and copying to $target_dir:\n";
foreach $f (@img_files) {
    print "$f\n";
    $imagename = $f;
    $imagename =~ s/.JPG//;
    print ORDERFILE "$imagename: \n";

    system "cp $source_dir/$f $target_dir/$imagename\_600.jpg";
    system "jhead -cmd \"convert $options_600 &i &o\" $target_dir/$imagename\_600.jpg";
    system "cp $source_dir/$f $target_dir/$imagename\_T.jpg";
    system "jhead -cmd \"convert $options_T &i &o\" $target_dir/$imagename\_T.jpg";

    system "chown ach $target_dir/$imagename\_600.jpg";
    system "chgrp ach $target_dir/$imagename\_600.jpg";
    system "chown ach $target_dir/$imagename\_T.jpg";
    system "chgrp ach $target_dir/$imagename\_T.jpg";
}

close(ORDERFILE);
system "chown ach $target_dir/ORDER";
system "chgrp ach $target_dir/ORDER";
