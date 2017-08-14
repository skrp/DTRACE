#!/sbin/dtrace -s
dtrace:::BEGIN
{
	i = 0;
}
syscall::$1:entry
/pid == $2/
{
	self->ts = timestamp;
}
syscall::$1:return
/self->ts && i < 10/
{
	@time[execname] = avg(timestamp - self->ts);
	self->ts = 0;
}
profile:::tick-1sec
/i < $3/
{
	i = i + 1;
}
profile:::tick-1sec
/i == $3/
{
	exit(0);
}
