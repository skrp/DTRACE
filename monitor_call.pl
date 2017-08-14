#!/usr/local/bin/perl
##################################
# MONITOR - syscall over many pids
# requires fd_tcall.d 
my ($pid_file, $sec) = @ARGV;
die "no pid_file" unless defined $pid_file;
die "no $sec" unless defined $pid_file;
open(my $fh, '<', $pid_file);
my @pids = readline $fh; chomp @pids;
foreach (@pids)
{ 
	print "$_ : "; 
	my $avg = `dtrace -s fk_tcall.d openat $_ $sec`; 
	$avg =~ s/\n//g;
	$avg =~ s/.*perl//;
	$avg =~ s/[\s\t]*//;
	print "$avg\n";
}
