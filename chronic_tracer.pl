#!/usr/local/bin/perl
my ($call, $pid) = @ARGV;
my $x = $$;
die unless fork();
if ($x != $$)
{
  sleep 3600;
  kill("TERM", $x);
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
