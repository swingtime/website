#!/usr/bin/perl

# ---------------------------------------------------------------------
# Author:      Andy Huang (achuang@stanford.edu)
# Description: Creates the slideshow pages in the Slideshow2 directory.
# Requires:    Slideshow2/TEMPLATE.HTML
# ---------------------------------------------------------------------

$dir = "Slideshow2";

if (@ARGV != 0) {
    $startdir = @ARGV[0];
    print "starting at $startdir\n";
}

# Gather the date from the directories.
opendir(TOP_DIR, ".");
@dates = grep(/^\d\d\d\d-\d\d/, (sort readdir(TOP_DIR)));
closedir(TOP_DIR);

if ($startdir !~ /""/ && $startdir != 0) {
    $i = 0;
    foreach (@dates) {
	if (/$startdir/) {
	    splice(@dates, 0, $i);
	    break;
	}
	$i++;
    }
}

# Gather the collections.
opendir(COL_DIR, "Collections");
@collections = grep(/[^(.|CVS)]/, sort readdir(COL_DIR));
closedir(COL_DIR);

@title_picdir_map;
@titles;
@next_event_map;
@prev_event_map;
$prev_event_dir = "";
# Read the TITLE file from the given picture directory.
foreach $pic_dir (@dates) {
    if (open(TITLE, "$pic_dir/TITLE")) {
	$event_dates_str = $title_picdir_map{"$title"};
	@event_dates = split /&/, $event_dates_str, $num_dates;	
	foreach $ed (@event_dates) {
	    @next_event_map{"$ed"} = $pic_dir;
	}

	$title = "";
	foreach (<TITLE>) {
	    $title = "$title$_";
	}
	@multiday_event{"$title"} = 0;
	@title_picdir_map{"$title"} = $pic_dir;

	@next_event_map{"$prev_event_dir"} = $pic_dir;
	@prev_event_map{"$pic_dir"} = $prev_event_dir;
	@next_event_map{"$pic_dir"} = "";

	$prev_event_dir = $pic_dir;
    }
    else {
	@multiday_event{"$title"} += 1;
	$picdirs = $title_picdir_map{"$title"};
	@title_picdir_map{"$title"} = "$picdirs&$pic_dir";
	@prev_event_map{"$pic_dir"} = $prev_event_map{"$prev_event_dir"};
    }

    @titles{"$pic_dir"} = $title;
}

$isdate = 0;
foreach $pic_dir (@collections) {
    $n = 0;
    @first_image = ();
    @allimages = ();
    open(PIC_LIST, "Collections/$pic_dir");
    print "Reading list $pic_dir\n";    
    read_pic_list();
    close(PIC_LIST);
    print "Creating slideshow for $pic_dir\n";
    create_slideshow();
}

# Get all the images.
@first_image = ();
@allimages = ();
$n = 0;
$isdate = 1;
foreach $pic_dir (@dates) {

    $owner = "";
    if (open(OWNER, "$pic_dir/OWNER")) {
	foreach (<OWNER>) {
	    $owner = "$owner $_";
	}
	close(OWNER);
    }

    open(PIC_LIST, "$pic_dir/ORDER");
    read_pic_list();
    close(PIC_LIST);
}

create_slideshow();


sub create_slideshow() {
    @full_widths;
    @full_heights;
    @thumb_widths;
    @thumb_heights;
    foreach $img (@allimages) {
	$jhead = `./jhead $img\_600.jpg`;
	$jhead =~ /Resolution   : (\d*) x (\d*)/;
	$full_w = $1;
	$full_h = $2;
	$thumb_w = $1 / 6 * .5;
	$thumb_h = $2 / 6 * .5;

	@full_widths{$img} = $full_w;
	@full_heights{$img} = $full_h;
	@thumb_widths{$img} = $thumb_w;
	@thumb_heights{$img} = $thumb_h;
    }

    $templatefile = "$dir/TEMPLATE.HTML";
    $i = 0;
    print "Creating slideshow files...\n";
    foreach $img (@allimages) {
	open(TEMPLATE, "$templatefile");
	if ($isdate) {
	    $htmlfile = $img;
	}
	else {
	    $htmlfile = "$pic_dir/$img";
	}
	$htmlfile =~ s/\//-/g;
	print "$htmlfile\n";
	$newfile = "$dir/$htmlfile.html";
	open(NEW, ">$newfile");

	$full_w = $full_widths{"$img"};
	$full_h = $full_heights{"$img"};

	if ($isdate) { 
	    $slash_index = index($img, "/");
	    $pic_dir = substr($img, 0, $slash_index);
	}
	if ($isdate) {
	    $event = @titles{"$pic_dir"};
	}
	else {
	    $event = $pic_dir;
	    $event =~ s/\_/ /g;
	}

	foreach $l (<TEMPLATE>) {
	    if ($l =~ m/\[n(\+|\-)(\d+)image(\w+)\]/) {
		$sign = $1;
		$offset = $2;
		$type = $3;

		$image_name = "";
		if ($sign =~ /\+/) {
		    if ($i + $offset <= $n) {
			$image_name = @allimages[$i + $offset];
			$prev_image_name = @allimages[$i + $offset - 1];
		    }
		}
		elsif ($sign =~ /\-/) {
		    if ($i - $offset >= 0) {
			$image_name = @allimages[$i - $offset];
			if ($i - $offset - 1 >= 0) {
			    $prev_image_name = @allimages[$i - $offset - 1];
			}
		    }
		}

		# check pic dir
		if ($isdate) { 
		    $test_slash = index($image_name, "/");
		    $test_dir = substr($image_name, 0, $test_slash);
		    $test_event = @titles{"$test_dir"};

		    if ($event ne $test_event) {
			$image_name = "";
		    }
		}

		# create the replacement string
		$rep_str = "";
		if ($image_name ne "") {

		    $thumb_w = $thumb_widths{"$image_name"};
		    $thumb_h = $thumb_heights{"$image_name"};

		    if ($type =~ /thumb/) {
			$rep_str = "..\/$image_name\_T.jpg";
		    }
		    elsif ($type =~ /link/) {
			$image_name =~ s/\//-/;
			if ($isdate) {
			    $rep_str = "$image_name.html";
			}
			else {
			    $rep_str = "$pic_dir-$image_name.html";
			}
		    }
		    elsif ($type =~ /date/) {
			$image_date = substr($image_name, 0, 10);
			$prev_image_date = substr($prev_image_name, 0, 10);
			if ($isdate && $image_date !~ /$prev_image_date/) {
			    $year = get_year($image_date);
			    $month = get_month($image_date);
			    $month_text = get_month_abbrev($month);
			    $date = get_date($image_date);
			    $date_text = get_date_text($date);
			    $rep_str = "$month_text $date_text, $year";
			}
			else {
			    $l = "";
			}
		    }
		}
		else {
		    $l = "";
		}
		
		$l =~ s/\[n(\+|\-)(\d+)image$type\]/$rep_str/;

	    }

	    if ($l =~ /\[(\w*)\_event\_link\]/) {
		$type = $1;
		if ($type =~ /prev/) {
		    $event_dir = $prev_event_map{"$pic_dir"};
		}
		else {
		    $event_dir = $next_event_map{"$pic_dir"};
		}
		
		$link = $first_image{"$event_dir"};
		$link =~ s/\//-/;
		if ($link !~ /^$/) {
		    $l =~ s/\[(\w*)\_event\_link\]/$link.html/;
		}
		else {
		    $l = "";
		}
	    }

	    if ($l =~ /\[event\_index\_link\]/) {
		$link = "..\/EventIndex\/$pic_dir.html";
		$l =~ s/\[event\_index\_link\]/$link/;
	    }

	    if ($l =~ /\[ownerlink\]/) {
		$owner = $img_owners{"$img"};
		if ($owner !~ /\w+/) { $l = ""; }
		else { $l =~ s/\[ownerlink\]/$owner/; }
	    }
	    if ($l =~ /\[event\_title\]/) {
		$l =~ s/\[event\_title\]/$event/;
	    }
	    if ($l =~ /\[date\]/) {
		$str = "";
		if ($isdate) {
		    $y = get_year($pic_dir);
		    $m = get_month_text(get_month($pic_dir));
		    $d = get_date_text(get_date($pic_dir));
		    $str = "$d $m $y";
		}
		$l =~ s/\[date\]/$str/;
	    }
	    
	    $l =~ s/\[currentimage\]/..\/$img\_600.jpg/;
	    $l =~ s/\[thumbwidth\]/$thumb_w/;
	    $l =~ s/\[thumbheight\]/$thumb_h/;
	    $l =~ s/\[fullwidth\]/$full_w/;
	    $l =~ s/\[fullheight\]/$full_h/;
	    $l =~ s/\[description\]/$img_descs{"$img"}/;


	    print NEW $l;
	}
	
	close(NEW);
	close(TEMPLATE);

	$i++;
    }
}

sub read_pic_list() {
    $first_img_index = $n;
    foreach (<PIC_LIST>) {
	s/^ |\t|\n//;
	s/ |\t|\n$//;
	if ($_ =~ /\w+/) {
	    @img_desc = split /:/, $_, 2;
	    $image_name = @img_desc[0];
	    $image_desc = @img_desc[1];
	    @desc_owner = split /&/, $image_desc, 2;
	    $image_desc = @desc_owner[0];
	    $image_owner = @desc_owner[1];

	    $image_title = "$image_name";
	    if ($isdate) {
		$image_title = "$pic_dir\/$image_title";
	    }
	    @allimages[$n] = $image_title;

	    if ($image_desc !~ //) {
		if (open(DESC_FILE, "$pic_dir/$image_name.desc")) {
		    foreach (<DESC_FILE>) {
			$image_desc = "$image_desc $_";
		    }
		    close(DESC_FILE);
		}
	    }
	    $img_descs{"$image_title"} = "$image_desc";

	    if ($image_owner !~ //) {
		$img_owners{"$image_title"} = "$owner";
	    } else {
		$img_owners{"$image_title"} = "$image_owner";
	    }

	    $n++;
	}
    }

    @first_image{"$pic_dir"} = @allimages[$first_img_index];
}


sub get_year
{
    return substr($_[0], 0, 4);
}

sub get_month
{
    return substr($_[0], 5, 2);
}

sub get_date
{
    return substr($_[0], 8, 2);
}

sub get_month_abbrev
{
    @months = (Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec);
    return @months[$_[0] - 1];
}

sub get_month_text
{
    @months = (January, February, March, April, May, June, July, August, September, October, November, December);
    return @months[$_[0] - 1];
}

sub get_month_num_text
{
    my($date);
    $date = $_[0];
    if ($date =~ /0\d/) {
	$date = substr($date, 1, 1);
    }
    return $date;
}

sub get_date_text
{
    my($date);
    $date = $_[0];
    if ($date =~ /0\d/) {
	$date = substr($date, 1, 1);
    }
    return $date;
}

