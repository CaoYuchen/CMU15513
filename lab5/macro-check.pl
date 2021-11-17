#!/usr/bin/perl
use Getopt::Std;

##############################################################################
#
# This program checks a file for uses of the #define preprocessing directive.
# It flags any use in which a list of parameters is provided to the macro
#
##############################################################################

sub usage
{
    print STDERR "$_[0]\n";
    print STDERR "Usage: $0 [-h] [-i IGNORE_LIST] [-f INFILE]\n";
    print STDERR "Options:\n";
    print STDERR "  -h               Print this message\n";
    print STDERR "  -i IGNORE_PREFIX Prefix for allowed macros (Perl regex)\n";
    print STDERR "  -f INFILE        Specify input file\n";
    print STDERR "If no input file is specified, reads from stdin.\n";
    exit(0);
}


# The following is a list of macros that are provided as part of the sample code.
# These are the only allowed ones
$ok_prefix = "dbg_";

getopts('hi:f:');

if ($opt_h) {
    usage($ARGV[0]);
}

$infile = STDIN;
$fwarning = "";
if ($opt_f) {
    open($infile, "<", $opt_f) || die "Couldn't open '$opt_f': $!\n";
    $fwarning = " File $opt_f.";
}

if ($opt_i) {
    $ok_prefix = $opt_i;
}

$lineno = 1;
$startlineno = 1;
$line = "";

$mcount = 0;

while (<$infile>) {
    $nextline = $_;
    chomp($nextline);
    # See if this is line has a continuation
    if ($nextline =~ /^(.*)\\[\s]*$/) {
        $prefix = $1;
        $line = "$line$prefix";
    } else {
        $line = "$line$nextline";
        if ($line =~ /^[\s]*#[\s]*define[\s]+([\w]+)\(/) {
            $macname = $1;
            if ($lineno == $startlineno) {
                $linemsg = "Line $lineno contains";
            } else {
                $linemsg = "Lines $startlineno-$lineno contain";
            }
            if ($macname !~ /^$ok_prefix/) {
                print "ERROR:$fwarning $linemsg disallowed definition of macro '$macname'\n";
                $mcount += 1;
            }
        }
        $line = "";
        $startlineno = $lineno+1;
    }
    $lineno++;
}

if ($mcount > 0) {
    my $s = $mcount == 1 ? "" : "s";
    print "FATAL: $mcount macro$s detected.\n";
    exit(1);
}
