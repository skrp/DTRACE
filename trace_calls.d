#!/sbin/dtrace
syscall:::entry
/pid == $1/
{
  @syscalls[probefunc] = count();
}
