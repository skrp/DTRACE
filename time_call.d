#!/sbin/dtrace -s
syscall:::$2
/pid == $1/
callout_execute:::callout_start
{
        self->cstart = timestamp;
}

callout_execute:::callout_end
{

        @length = quantize(timestamp - self->cstart);
}
