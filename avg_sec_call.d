syscall:::entry
/pid == $1/
{
	self->ts = timestamp;
}
syscall::write:return
/self->ts && pid == $1/
{
	@time[execname] = avg(timestamp - self->ts);
	self->ts = 0;
}
