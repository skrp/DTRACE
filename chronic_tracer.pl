#!/usr/local/bin/perl
my ($target, $call, $log) = @ARGV;
my $x = $$;
open(my $Tfh, '<', $target)
my @targ = readline $Tfh; 
chomp @targ; close $Tfh;
foreach (@targ)
{
  my $pid = $_;
  open(my $Lfh, '>>', $log);
  $SIG{HUP} = \&SUICIDE;
  die unless fork();
  if ($x != $$)
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
