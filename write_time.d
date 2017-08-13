#!/sbin/dtrace -s
syscall::write:entry
/pid == $1/
{
  nsec = timestamp;
}
syscall::write:return
/pid == $1 && nsec != 0/
{
  printf("%d", timestamp - nsec);
}

