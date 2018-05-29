#!/usr/bin/perl
use Cwd;

if (@ARGV < 1) {
    print "USAGE: ./createpage.pl [auditions|callbacks] [test|init]\n";
    exit;
}
if (@ARGV == 2) {
    if (@ARGV[1] =~ /init/) {
	$init = true;
    }
    $test = true;
}
$type = @ARGV[0];

`rm -f MODE-*`;
`touch MODE-$type`;
`mkdir $type`;
`mkdir $type/feedback_raw`;
`mkdir $type/feedback_html`;
`fs setacl -clear $type/feedback_raw`;
`fs setacl -clear $type/feedback_html`;
`fs setacl $type/feedback_raw system:www-servers write`;
`fs setacl $type/feedback_html system:www-servers write`;
`fs setacl $type/feedback_raw benzn rlidwka`;
`fs setacl $type/feedback_html benzn rlidwka`;
`ln -s ../sources/header.html .`;
`cd $type/feedback_raw; ln -s ../../../sources/.htaccess .; ln -s ../../../scripts/process_raw.pl`;
`cd $type/feedback_html; ln -s ../../../sources/.htaccess .`;

$currentdir = cwd;
print "$currentdir\n";
@tmparr = split(/\//, $currentdir);
$arrlen = @tmparr;
$reldir = $tmparr[$arrlen - 1];

# Process the image directory
$image_dir = "images";
opendir(DIR, "$image_dir/follows");
@follows = grep(/[.|\s]*\.[J|j][P|p][G|g]$/, (sort readdir(DIR)));
closedir(DIR);
opendir(DIR, "$image_dir/leads");
@leads = grep(/[.|\s]*\.[J|j][P|p][G|g]$/, (sort readdir(DIR)));
closedir(DIR);

$index = 0;
open(NAMES, "$image_dir/names_$type.txt");
foreach $name (<NAMES>) {

    if ($name =~ /-----/) {
	$index++;
	$i = 0;
    }
    else {
	$name =~ s/\n//;
	$name =~ s///;
	$id = $name;
#	$id =~ s/[(|)]//g;
#	$id =~ s/[-| ]/_/g;
	$id =~ s/ /_/g;
	print "$id\n";
	$imgfile = "$id.jpg";

	if ($index == 0) {
	    $orig = "follows/@follows[$i]";
	    push(@followids, $id);
	}
	elsif ($index == 1) {
	    $orig = "leads/@leads[$i]";
	    push(@leadids, $id);
	}
	
	if ($init) {

	    $newimg = $id;
	    $newimg =~ s/[(|)]//g;
	    $newimg =~ s/[-| ]/_/g;			    

	    $jhead = `./jhead "$image_dir/$orig"`;
	    $jhead =~ /Resolution\s*:\s*(\d*) x (\d*)/;
	    $w = $1;
	    $h = $2;
	    if ($w > $h) {
		$newwidth = $h * .75;
		$neworigin = ($w - $newwidth) / 2;
		`convert -quality 100 -crop ${newwidth}x${h}+${neworigin}+0 "$image_dir/$orig" "$image_dir/$orig.CROP"`;
		`convert -quality 100 -geometry 150x200 "$image_dir/$orig.CROP" "$image_dir/$newimg.jpg"`;
		print "cropping picture: $image_dir/$orig\n";
	    }
	    else {
		`convert -quality 100 -geometry 150x200 "$image_dir/$orig" "$image_dir/$newimg.jpg"`;
		print "$image_dir/$orig --> $image_dir/$newimg.jpg\n";
	    }
#	    `cp "$image_dir/$orig" "$image_dir/$id.jpg"`;
	}

	$i++;
    }
}
close(NAMES);

push(@sorted_ids, sort({$a cmp $b} @followids));
push(@sorted_ids, sort({$a cmp $b} @leadids));

open(NAMES, "external.txt");
foreach $name (<NAMES>) {
    $name =~ s/\n//;
    $id = $name;
    $id =~ s/ /_/g;
    print "$id\n";
    push(@external_ids, $id);
}
@external_ids = sort({$a->[1] cmp $b->[1] || $a->[0] cmp $b->[0]} @external_ids);
close(NAMES);

open(INDEX, ">index.html");
print INDEX "\<HTML\>\n";
print INDEX "\<HEAD\>\<TITLE\>Swingtime Peer Review Form\</TITLE\>\</HEAD\>\n";
print INDEX "\<FRAMESET ROWS=75,*\>\<FRAME SRC=\"header.html\"\>\n";
print INDEX "\<FRAME SRC=\"$type/peer-review.fft\"\>\</FRAMESET\>\n";
print INDEX "\</HTML\>\n";
close(INDEX);

if (!$test) {
    open(INDEX, ">../index.html");
    print INDEX "<HTML><HEAD><TITLE>Swingtime Peer Review Form</TITLE>\n";
    print INDEX "<META HTTP-EQUIV=\"refresh\" CONTENT=\"0;URL=http://www.stanford.edu/group/swingtime/reviews/$reldir/\"></HEAD>\n";
    print INDEX "<BODY><P>Please click <a href=\"http://www.stanford.edu/group/swingtime/reviews/$reldir\">here</a> if you are not automatically taken to the peer review page.</BODY></HTML>\n";
    close(INDEX);
}
    
open(DUE, "DUE_DATE");
$duedate = "";
foreach $l (<DUE>) {
    $duedate = "$duedate $l";
}
close(DUE);

open(TEMPLATE, "../sources/form.template");
open(HTML, ">$type/peer-review.fft");
process_template();

open(TEMPLATE, "../sources/reviewpages.template");
open(HTML, ">$type/reviewpages.html");
process_template();

sub process_template {
    $auditionsonly = 0;
    $callbacksonly = 0;
    $foreach_str = "";
    foreach $l (<TEMPLATE>) {
	if ($l =~ /\[endauditionsonly\]/) {
	    if ($type eq "callbacks") {
		$auditionsonly = 0;
	    }
	    $l = "";
	}
	if ($l =~ /\[endcallbacksonly\]/) {
	    if ($type eq "auditions") {
		$callbacksonly = 0;
	    }
	    $l = "";
	}

	if ($auditionsonly || $callbacksonly) {
	    next;
	}
	if ($l =~ /\[auditionsonly\]/) {
	    if ($type eq "callbacks") {
		$auditionsonly = 1;
	    }
	    $l = "";
	}
	if ($l =~ /\[callbacksonly\]/) {
	    if ($type eq "auditions") {
		$callbacksonly = 1;
	    }
	    $l = "";
	}

	if ($l =~ /\[duedate\]/) {
	    $l =~ s/\[duedate\]/$duedate/g;
	}
	if ($l =~ /\[dir\]/) {
	    $l =~ s/\[dir\]/$currentdir/g;
	}
	if ($l =~ /\[type\]/) {
	    $l =~ s/\[type\]/$type/g;
	}
	if ($l =~ /\[endforeach\]/) {
	    if ($foreach_bool) {
		@ids = @sorted_ids;
	    }
	    else {
		@ids = @external_ids;
	    }
	    
	    $foreach_bool = 0;
	    $foreach_bool_ext = 0;

	    $i = 0;
	    foreach $id (@ids) {
		$name = $id;
		$name =~ s/_/ /g;
		$id =~ s/[(|)]//g;
		$id =~ s/[-| ]/_/g;		
#		$id =~ s/-//g;
		
		$l = $foreach_str;
		$l =~ s/\[pic\]/$image_dir\/$id.jpg/g;
		$l =~ s/\[id\]/$id/g;
		$l =~ s/\[name\]/$name/;
		print HTML $l;
	    }
	    close(NAMES);

	    $foreach_str = "";
	    $l = "";
	}
	elsif ($foreach_bool || $foreach_bool_ext) {
	    $foreach_str = "$foreach_str$l";
	    $l = "";
	}
	elsif ($l =~ /\[foreach\]/) {
	    $foreach_bool = 1;
	    $l = ""
	    }
	elsif ($l =~ /\[foreachext\]/) {
	    $foreach_bool_ext = 1;
	    $l = ""
	    }

	print HTML $l;
    }

    close(HTML);
    close(TEMPLATE);
}


