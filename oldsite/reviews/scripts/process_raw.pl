#!/usr/bin/perl -w

print "REMEMBER TO REMOVE DUPLICATE TXT FILES\n";
`rm all.txt`;
#`mv email.txt email.txt.BAK`;
`cat *.txt > all.raw`;
#`mv email.txt.BAK email.txt`;

open(RAWFILE, "all.raw");
open(SUMFILE, ">all.txt");

%jazz_arr = ();
%lindy_arr = ();
%partner_arr = ();
%show_arr = ();
%overall_arr = ();
%all_arr = ("jazz", \%jazz_arr, "lindy", \%lindy_arr, "partner", \%partner_arr, "show", \%show_arr, "overall", \%overall_arr);

%count_jazz_arr = ();
%count_lindy_arr = ();
%count_partner_arr = ();
%count_show_arr = ();
%count_overall_arr = ();
%all_count = ("jazz", \%count_jazz_arr, "lindy", \%count_lindy_arr, "partner", \%count_partner_arr, "show", \%count_show_arr, "overall", \%count_overall_arr);
foreach (<RAWFILE>) {
    if ($_ !~ /, :,,, :,,, :,,, :,,, :,,, / && $_ !~ /^$/) {
	@arr = split(/,,,|:/, $_);
	$name = $arr[0];
	$jazz = $arr[1];
	$lindy = $arr[3];
	$partner = $arr[5];
	$show = $arr[7];
	$overall = $arr[9];
	print "VALUES: $name $jazz $lindy $partner $show $overall\n";

	update_arrays($name, "jazz", $jazz);
	update_arrays($name, "lindy", $lindy);
	update_arrays($name, "partner", $partner);
	update_arrays($name, "show", $show);
	update_arrays($name, "overall", $overall);
    }
}

$label = "NAME";
$label = sprintf("%-20s", $label);
print SUMFILE "$label:\tJAZZ /    \tLINDY /    \tPARTNERING /\tSHOWMANSHIP /\tOVERALL /\n";

@names = keys(%jazz_arr);
foreach (@names) {
    $name = sprintf("%-20s", $_);
    print SUMFILE "$name:\t";

    $sum = $jazz_arr{$_};
    $count = $count_jazz_arr{$_};
    if ($count != 0) {
	$avg = sprintf("%.2f", $sum / $count);
    }
    else {
	$avg = 0;
    }
    print SUMFILE "$avg / $count\t";

    $sum = $lindy_arr{$_};
    $count = $count_lindy_arr{$_};
    if ($count != 0) {
	$avg = sprintf("%.2f", $sum / $count);
    }
    else {
	$avg = 0;
    }
    print SUMFILE "$avg / $count\t";    

    $sum = $partner_arr{$_};
    $count = $count_partner_arr{$_};
    if ($count != 0) {
	$avg = sprintf("%.2f", $sum / $count);
    }
    else {
	$avg = 0;
    }
    print SUMFILE "$avg / $count\t";

    $sum = $show_arr{$_};
    $count = $count_show_arr{$_};
    if ($count != 0) {
	$avg = sprintf("%.2f", $sum / $count);
    }
    else {
	$avg = 0;
    }
    print SUMFILE "$avg / $count\t";

    $sum = $overall_arr{$_};
    $count = $count_overall_arr{$_};
    if ($count != 0) {
	$avg = sprintf("%.2f", $sum / $count);
    }
    else {
	$avg = 0;
    }
    print SUMFILE "$avg / $count\t";

    print SUMFILE "\n";
}

close(SUMFILE);
close(RAWFILE);

sub update_arrays {
    my $name = $_[0];
    my $array_type = $_[1];
    my $value = $_[2];
    if (defined($value)) {
	$value =~ s/ //g;

	# CUMULATIVE SUM ARRAY
	my $orig_value = $all_arr{$array_type}{$name};
	if (!defined($orig_value)) {
	    $orig_value = 0;
	}
	if ($value =~ /\d/) {
	    $orig_value += $value;
	}
	$all_arr{$array_type}{$name} = $orig_value;
#    print "$name $orig_value\n";

	# COUNT ARRAY
	$orig_value = $all_count{$array_type}{$name};
	if (!defined($orig_value)) {
	    $orig_value = 0;
	}
	if ($value =~ /\d/) {
	    $orig_value += 1;
	}
	$all_count{$array_type}{$name} = $orig_value;
#    print "count: $name $orig_value\n";
    }
}
