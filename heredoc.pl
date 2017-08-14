#!/usr/local/bin/perl
my ($pid) = @ARGV;
my $trace = <<END;
/sbin/dtrace -s '
syscall::write:entry
/pid == $pid/
{
  nsec = timestamp;
}
syscall::write:return
/pid == $pid && nsec != 0/
{
  printf("%d", timestamp - nsec);
}'
END
