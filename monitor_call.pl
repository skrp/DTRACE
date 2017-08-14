#!/usr/local/bin/perl
##################################
# MONITOR - syscall over many pids
# requires tcall.d 
my ($pid_file, $call, $sec) = @ARGV;
# get pid listing from file ######
die "no pid_file" unless defined $pid_file;
die "no $sec" unless defined $pid_file;
open(my $fh, '<', $pid_file);
my @pids = readline $fh; chomp @pids;
foreach (@pids)
{ 
	print "$_ : "; 
	my $avg = `dtrace -s tcall.d $call $_ $sec`; 
	$avg =~ s/\n//g;
	$avg =~ s/.*perl//;
	$avg =~ s/[\s\t]*//;
	print "$avg\n";
}
