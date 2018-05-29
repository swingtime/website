#!/usr/bin/perl

$template_dir = "TEMPLATES";
$data_dir = "DATA";
$tmp_dir = "TMP";
open(OUTLINE, "$data_dir/OUTLINE.TXT");

`rm -f TMP/*.HTML TMP/*.TXT TMP/*.FFT`;
`cp -f $data_dir/DATA* $tmp_dir`;

$currentdir = `pwd`;
if ($currentdir =~ /members/) {
    $members = 1;
}

if ($members) {
    `cp -f $template_dir/ATTENDANCE_TEMPLATE.FFT Attendance.fft`;
    `cp -f $template_dir/RSVP_TEMPLATE.FFT RSVP.fft`;
}

@mainmenus;
@submenus;
@mainlink;
@all;
int i;
foreach (<OUTLINE>) {
    s/\n//;
    if (/([\w|\s]*):/) {
	$mainmenu_txt = $1;
	@mainmenus[$i] = $mainmenu_txt;

	$submenus_txt = $_;
	$submenus_txt =~ s/$mainmenu_txt: //;
	@submenus{"$mainmenu_txt"} = $submenus_txt;

	@submenus_arr = split(/\, /,$submenus_txt);
	push(@all, @submenus_arr);
	@mainlink{"$mainmenu_txt"} = @submenus_arr[0];
    }
    else {
	@mainmenus[$i] = $_;

	push(@all, $_);
    }
    $i++;
}
close(OUTLINE);

create_from_template("$template_dir/MAIN_TEMPLATE.HTML",
		     "Site_Map.shtml", "SITEMAP");

# Create the performance data files.
opendir(DIR, "$data_dir");
@calendars = grep(/^CAL/, (sort readdir(DIR)));
closedir(DIR);
foreach $c (@calendars) {
    @calendar = ();
    open(DATA, "$data_dir/$c");
    $item = "";
    $tentative = 0;
    foreach (<DATA>) {
	if (/\?\?\?/) {
	    $tentative = 1;
	    s/\?\?\?/<br><i>[Unconfirmed - Please RSVP]<\/i>/;
	}
	
	if (/^\n$/) {
	    if (!$tentative || $members) {
		push(@calendar, $item);
	    }
	    $item = "";
	    $tentative = 0;
	}
	else {
	    s/\n/ /;
	    $item = "$item$_";
	}
    }
    close(DATA);
    
    $file = $c;
    $file =~ s/CAL/DATA/;
    $file =~ s/TXT/HTML/;
    @foreach_array = @calendar;
    create_from_template("$template_dir/CALENDAR_TEMPLATE.HTML",
			 "$tmp_dir/$file", "CALENDAR");
}

# Create the home announcement data file.
open(FILE, "$data_dir/ANNOUNCE.HTML") or die;
$announcement = "";
@announce_arr;
foreach (<FILE>) {
    s/\n/ /;
    if ($_ eq " ") {
	push(@announce_arr, $announcement);
	$announcement = "";
    }
    else {
	$announcement = "$announcement$_";
    }
}
if (!($announcement eq "")) {
    push(@announce_arr, $announcement);
}
close(FILE);
@foreach_array = @announce_arr;
create_from_template("$template_dir/HOME_TEMPLATE.HTML",
		     "$tmp_dir/DATA_Home.HTML", "HOME");
create_from_template("$template_dir/HOME_TEMPLATE.HTML",
		     "$tmp_dir/DATA_Member_Home.HTML", "HOME");


# Create the menu.html file.
@foreach_array = @mainmenus;
create_from_template("$template_dir/MENU_TEMPLATE.HTML",
		     "Menu.html", "MENU");

# Create the sub-menu files.
@images;
@credits;
@imgpages;
@borders;
foreach $m (@mainmenus) {
    $file = $m;
    $file =~ s/ /_/g;
    
    $submenus_txt = @submenus{"$m"};
    @submenus_arr = split(/\, /,$submenus_txt);
    @foreach_array = @submenus_arr;
    create_from_template("$template_dir/SUBMENU_TEMPLATE.HTML",
			 "$file.html", "MENU");

    if ($submenus_txt !~ /\w+/) {
	create_from_template("$template_dir/MAIN_TEMPLATE.HTML",
			     "$file.shtml", "$m");
    }
    else {
	foreach $sm (@submenus_arr) {
	    $file = $sm;
	    $file =~ s/ /_/g;
	    create_from_template("$template_dir/MAIN_TEMPLATE.HTML",
				 "$file.shtml", "$m");
	}
    }
}

# Create the photo credits page
@foreach_array = @images;
create_from_template("$template_dir/CREDITS_TEMPLATE.HTML",
		     "$tmp_dir/DATA_Site_Credits.HTML", "CREDITS");
create_from_template("$template_dir/MAIN_TEMPLATE.HTML",
		     "Site_Credits.shtml", "Gallery");

`ln -fs Home.shtml index.shtml`;
#`ln -fs Home.shtml Member_Home.shtml`;



sub create_from_template {
    my $template_filename = $_[0];
    my $html_filename = $_[1];
    my $extra = $_[2];

    print "called create on $template_filename $html_filename $extra\n";

    my $heading = $html_filename;
#    $heading =~ s/public\///;
    $heading =~ s/.shtml//;
    $heading =~ s/_/ /g;

    $html_filename =~ s/_\(\w*\)//;

    if ($extra !~ /MENU|CALENDAR|HOME|CREDITS/) {
	print "went into if stmt\n";
	$extra =~ s/ /_/g;
	$text = "";
	$datafilename = "$tmp_dir/DATA_$html_filename";
#	$datafilename =~ s/public\//public\/DATA_/;
	$datafilename =~ s/shtml/HTML/;
	$textdata = 0;
	if (open(DATA, "$datafilename") == 1) {
	    print "$datafilename\n";
	}
	else {
	    $textdata = 1;
	    $datafilename =~ s/HTML/TXT/;
	    if (open(DATA, "$datafilename") == 1) {
		print "$datafilename\n";
	    }
	    else {
		print "NOTE: No $datafilename found\n";
	    }
	}
	@topimgs = ();
	@borders = ();
	@botimgs = ();
	@rtimgs = ();
	@directives = ();
	$border = 1;
	$credit = "";
	$align = "";
	$show = 1;
	foreach (<DATA>) {
	    $directive = "";
	    if (/(\w\w\w*)img/) {
		$type = $1;
		$img = $_;
		if ($img =~ /,([\w\s]*)/) {
		    $credit = $1;
		    $img =~ s/,([\w\s]*)//;
		}
		
		if ($img =~ /,(\d)/) {
		    $border = $1;
		    $img =~ s/,\d//;
		}

		if ($img =~ /,(\w*)/) {
		    $img =~ s/,(\w*)//;
		    $align = $1;
		}

		if ($img =~ /,(.*)/) {
		    $img =~ s/,(.*)//;
		    $directive = $1;
		}

		$img =~ s/\w\w\w*img=//;
		push(@images, $img);
		@credits{"$img"} = $credit;
		@imgpages{"$img"} = $heading;
		@borders{"$img"} = $border;
		@directives{"$img"} = $directive;

		if ($type eq "bot") {
		    push(@botimgs, $img);
		}
		elsif ($type eq "top") {
		    push(@topimgs, $img);
		}
		elsif ($type eq "rt") {
		    push(@rtimgs, $img);
		}
	    }
	    elsif ($textdata) {
		if ($text eq "") {
		    $text = $_;
		}
		else {
		    $text = "$text<br>$_";
		}
	    }
	    else {
		$text = "$text$_";
	    }
	}
	close(DATA);
    }

    open(TEMPLATE, "$template_filename");
    open(HTML, ">$html_filename");

    foreach (<TEMPLATE>) {
	if (/\[endforeach\]/) {
	    $foreach_bool = 0;

	    $i = 0;
	    $multigig = 0;
	    foreach $foreach_item (@foreach_array) {
		$file = @mainlink{"$foreach_item"};
		if ($file !~ /\w+/) {
		    $file = $foreach_item;
		    $file =~ s/ \(\w*\)//;
		}

		$file =~ s/ /_/g;
		
		$_ = $foreach_str;
		s/\[file\]/$file/g;
		s/\[item\]/$foreach_item/g;

		$itermod2 = $i % 2;
		s/\[itermod2\]/$itermod2/g;		

		if ($extra =~ /CALENDAR/) {
		    @event = split(/ \# /,$foreach_item);

		    if ($foreach_item !~ /\?/ || $members) {
			$priorfulldate = $fulldate;
			$fulldate = @event[0];
			$take_attendance = @event[6] eq "attendance";
			if ($priorfulldate =~ /$fulldate/) {
			    $multigig++;
			}
			else {
			    $multigig = 0;
			}
			
			$day = get_day($fulldate) . "<br>";
			$month = get_month($fulldate);
			$month_num_txt = get_month_num_text($month);
			$month_txt = get_month_abbrev($month);
			$date = get_date($fulldate);
			$date_num_txt = get_date_text($date);
			$year = get_year($fulldate);
			$detailsfile = "";
			
			$date_abbrev = "$month.$date.$year";
			if ($multigig != 0) {
			    $date_abbrev = "$date_abbrev\_$multigig";
			}

			
			if ($members) {
			    if (open(TEST, "DATA/GIG_$date_abbrev.HTML") == 1) {
				$detailsfile = "GIGS/DETAILS_$date_abbrev.html";
				`cp DATA/GIG_$date_abbrev.HTML $detailsfile`;
				close(TEST);
			    }
			    elsif (open(TEST, "DATA/GIG_$date_abbrev.TXT") == 1) {
				$detailsfile = "GIGS/DETAILS_$date_abbrev.txt";
				`cp DATA/GIG_$date_abbrev.TXT $detailsfile`;
				close(TEST);
			    }
			    if ($take_attendance &&
				open(TEST, "GIGS/ATTEND_$date_abbrev.log") == 0) {
				print "creating new gig file: $date_abbrev.log\n";
				`cp TEMPLATES/GIGLOG_TEMPLATE.LOG GIGS/ATTEND_$date_abbrev.log`;
			    }
			    else {
				close(TEST);
			    }
			}
		    $date_full = "$day $month_txt $date_num_txt";
			$date =~ s/, \d\d\d\d//;
			$title = @event[1];
			$details = @event[2];
			$location = @event[3];
			$time = @event[4];
			$call = @event[4];
			$dress = @event[5];
			$notes = @event[7];
			
			s/\[date\]/$date_full/g;
			s/\[ev_title\]/$title/g;
			s/\[location\]/$location/g;
			s/\[call\]/$call/g;
			s/\[dress\]/$dress/g;
			s/\[notes\]/$notes/g;
			s/\[details\]/$details/g;
			if($take_attendance) {
			    $attendance_link = "<a href=\"http://www.stanford.edu/group/swingtime/members/Attendance.fft?gig=[date_abbrev]\" target=\"_blank\">Attendance</a>";
			    s/\[attendance\]/$attendance_link/g;
			} else {
			    s/\[attendance\]//g;
			}
			s/\[date_abbrev\]/$date_abbrev/g;

			if ($detailsfile eq "") {
			    s/\[detailslink\]//g;
			}
			else {
			    s/\[detailslink\]/, <a href="$detailsfile" target="_blank">Details<\/a>/g;
			}

#			if ($location && $time) {
#			    s/\[details\]/$location, $time/;
#			}
#			elsif ($location) {
#			    s/\[details\]/$location/;
#			}
#			elsif ($time) {
#			    s/\[details\]/$time/;
#			}
#			else {
#			    s/\[details\]//;
#			}
		    }
		    else {
			$_ = "";
		    }
		}
		elsif ($extra =~ /CREDITS/) {
		    if ($foreach_item =~ /logo.gif/) {
			next;
		    }
		    $border = @borders{"$foreach_item"};
		    s/\[imgborder\]/$border/;
		    $credit = @credits{"$foreach_item"};
		    s/\[imgcredit\]/$credit/;
		    $heading = @imgpages{"$foreach_item"};
		    s/\[imgheading\]/$heading/;
		    $link = "$heading.shtml";
		    $link =~ s/ /_/g;
		    s/\[imglink\]/$link/;
		}

		print HTML $_;
		$i++;
	    }

	    $foreach_str = "";
	    $_ = "";
	}
	elsif (/\[submenu\]/) {
	    if ($extra =~ /SITEMAP/) {
		s/\[submenu\]/Home/;		
	    }
	    else {
		s/\[submenu\]/$extra/;
	    }
	}
	elsif (/img\]/) {
	    if (/\[topimg\]/) {
		if (@topimgs != 0) {
		    foreach $i (@topimgs) {
			$border = @borders{"$i"};
			$directive = @directives{"$i"};
			s/\[topimg\]/<img border="$border" $directive align="right" src="$i">\[topimg\]/;
		    }
		    s/\[topimg\]//;
		}
		else {
		    s/\[topimg\]//;
		}
	    }
	    elsif (/\[botimg\]/) {
		if (@botimgs != 0) {
		    foreach $i (@botimgs) {
			$border = @borders{"$i"};
			$directive = @directives{"$i"};
			s/\[imgalign\]/$align/;
			s/\[botimg\]/<img border="$border" $directive src="$i">&nbsp;&nbsp;&nbsp;\[botimg\]/;
		    }
		    s/&nbsp;&nbsp;&nbsp;\[botimg\]//;
		}
		else {
		    $_ = "";		
		}
	    }
	    elsif (/\[rtimg\]/) {
		if (@rtimgs != 0) {
		    foreach $i (@rtimgs) {
			$border = @borders{"$i"};
			$directive = @directives{"$i"};
			s/\[rtimg\]/<img border="$border" $directive src="$i"><p>\[rtimg\]/;
		    }
		    s/\[rtimg\]//;
		}
		else {
		    $_ = "";		
		}
	    }
	}	

	if (/\[title\]/) {
	    if ($heading !~ /Home/) {
		s/\[title\]/:: Swingtime - $heading ::/;
	    }
	    else {
		s/\[title\]/:: Swingtime Swing Dance Troupe ::/;
	    }
	}
	elsif (/\[heading\]/) {
	    if ($heading !~ /Home/) {
		s/\[heading\]/$heading/;
	    }
	    else {
		$_ = "";
	    }
	}
	elsif (/\[pad\]/) {
	    if ($heading !~ /Home/) { 
		s/\[pad\]/5/;
	    }
	    else {
		s/\[pad\]/5/;		
	    }
	}
	elsif (/\[text\]/) {
	    if ($extra =~ /SITEMAP/) {
		$text = "";
		foreach $m (@mainmenus) {
		    if ($m eq "Home") {
			next;
		    }
		    $link = $m;
		    $link =~ s/ /_/g;

		    $submenus_txt = @submenus{"$m"};
		    if ($submenus_txt eq "") {
			$text = "$text\n<a href=\"$link.shtml\">$m</a><br>";
		    }
		    else {
			$text = "$text\n$m<br>";
		    }
		    @submenus_arr = split(/\, /,$submenus_txt);
		    foreach $sm (@submenus_arr) {
			$link = $sm;
			$link =~ s/ /_/g;
			$text = "$text\n&nbsp;&nbsp;&nbsp;<a href=\"$link.shtml\">$sm</a><br>";
		    }
		    
		    $text = "$text\n<p>"
		}
	    }

	    s/\[text\]/$text/;
	}
	elsif ($foreach_bool) {
	    $foreach_str = "$foreach_str$_";
	    $_ = "";
	}
	elsif (/\[foreach\]/) {
	    $foreach_bool = 1;
	    $_ = "";
	}

	print HTML $_;
    }
    close(HTML);
    close(TEMPLATE);
}

sub get_day
{
    return substr($_[0], 0, 3);
}

sub get_year
{
    return substr($_[0], 10, 4);
}

sub get_month
{
    return substr($_[0], 4, 2);
}

sub get_date
{
    return substr($_[0], 7, 2);
}

sub get_month_abbrev
{
    @months = (Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec);
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
