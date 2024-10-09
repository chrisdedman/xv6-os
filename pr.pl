#!/usr/bin/perl

use POSIX qw(strftime);

# Check for help argument
if ($ARGV[0] eq "-h") {
    shift @ARGV;
    $h = $ARGV[0];
    shift @ARGV;
} else {
    $h = $ARGV[0];
}

$page = 0;
$now = strftime "%b %e %H:%M %Y", localtime;

# Read input lines
@lines = <>;

for ($i = 0; $i < @lines; $i += 50) {
    print "\n\n";
    ++$page;
    print "$now  $h  Page $page\n";
    print "\n\n";

    # Print 50 lines at a time
    for ($j = $i; $j < @lines && $j < $i + 50; $j++) {
        $lines[$j] =~ s!//DOC.*!!;  # Remove comments
        print $lines[$j];
    }

    # Print empty lines if less than 50 lines in the last batch
    for (; $j < $i + 50; $j++) {
        print "\n";
    }

    # Check for sheet number in first line
    $sheet = "";
    if ($lines[$i] =~ /^([0-9][0-9])[0-9][0-9] /) {
        $sheet = "Sheet $1";
    }

    print "\n\n";
    print "$sheet\n";
    print "\n\n";
}
