#!/usr/local/bin/perl
#############################
# CHRONIC - 420 timing checks
my ($target, $call, $log) = @ARGV;
open(my $Tfh, '<', $target)
my @targ = readline $Tfh; 
chomp @targ; close $Tfh;
foreach (@targ)
{ # ITER OVER CERTAIN PROCS #
  my $pid = $_;
  my $x = $$;
  open(my $Lfh, '>>', $log);
  $SIG{HUP} = \&SUICIDE;
  die unless fork();
  if ($x != $$)
# RUN DTRACE FOR 1HR ########
  {
    sleep 3600;
    kill("HUP", $x); # sent CTL-c to dtrace
  }
  my $trace = <<END;
  /sbin/dtrace -s '
  syscall:::$call
  /pid == $pid/
  callout_execute:::callout_start
  {
          self->cstart = timestamp;
  }

  callout_execute:::callout_end
  {

          @length = quantize(timestamp - self->cstart);
  }'
  END
}
sub SUICIDE
  { print $Lfh "$$ $trace\n"; die; }
