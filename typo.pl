#!/bin/perl

use strict;
use warnings;

sub min {
    my $rv = shift;
    for my $tmp (@_) {
        $rv = $tmp if $tmp < $rv;
    }
    return $rv;
}

sub editDistance {
    my ($left, $lenLeft, $right, $lenRight) = map { $_, length($_) } @_;

    return $lenRight unless $lenLeft;
    return $lenLeft unless $lenRight;
    
    my $shortLeft  = substr $left,  0, -1;
    my $shortRight = substr $right, 0, -1;
    return editDistance ($shortLeft, $shortRight) if substr($left, -1) eq substr($right, -1);

    return 1 + min(
        editDistance($left,       $shortRight), #insert
        editDistance($shortLeft,  $right),      #remove
        editDistance($shortLeft,  $shortRight)  #replace
    );
}

open(my $r, "<", "Dictionary.txt");
chomp(my (@data) = <$r>);
close($r);

my $size = $#data;
$size++;

my $str = <STDIN>;
chomp $str;

my @spl = split(' ', $str);
my $t = 0;
my $n_error = 0;

foreach my $val (@spl)
{
	if ( grep( /^$val$/, @data ) ) {
  		next;
	}

	$n_error++;
	my $min = 5654992;
	my (@arr);

	foreach my $word (@data)
	{
    		my $d = editDistance($val, $word, length($val), length($word));
    		if( $min > $d ) {
    			$min = $d;
    		}
    
    		push(@arr, $d);
	}

	my( @alternatives )= grep { $arr[$_] eq $min } 0..$#arr;
	my $two = 2;
	if( $min < 2 && grep( /^$two$/, @arr ) ) {
		my( @threshold )= grep { $arr[$_] eq 2 } 0..$#arr;
		push(@alternatives, @threshold);
	}

	my $f = \@data;
	
	foreach my $num (@alternatives)
	{
    		print "\n$val\n";
    		my $rep = $f->[$num];
    		
    		my $mlen = length($val);
    		if($mlen > length($rep)) {
    			$mlen = length($rep);
    		}
    		
    		my $i;
    		for ($i=0; $i<$mlen; $i++)
    		{
    			if(substr($val, $i, 1) ne substr($rep, $i, 1)) {
    				print "^\n";
    				last;
    			}
    			else {
    				print " ";
    			}
    		}
    		if($i == $mlen) {
    			print "^\n";
    		}
    		
    		print "Did you mean '$rep'? (y/n) ";
    
    		my $s = <STDIN>;
    		chomp $s;
    		if(($s eq "y") or ($s eq "Y")) {
    			$t++;
    			$val = $rep;
    			last;
    		}
	}
}
print "\n";
if($n_error == 0) {
	print "No typo found\n";
	exit;
}

print "$t correction(s) done..\n";
foreach my $val (@spl) 
{
	print "$val ";
}
print "\n";
