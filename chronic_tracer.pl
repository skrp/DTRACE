#!/usr/local/bin/perl
my ($call, $pid, $log) = @ARGV;
my $x = $$;
open(my $Lfh, '>>', $log);
$SIG{HUP} = \&SUICIDE;
die unless fork();
if ($x != $$)
{
  sleep 3600;
  kill("TERM", $x); # sent CTL-c to dtrae
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
sub SUICIDE
  { print $Lfh "$$ $trace\n"; die; }
