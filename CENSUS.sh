#!/usr/local/bin/bash
############################
# CENSUS - zdb status parser
#                 ---cronjob
pool=${1%/}
work_dir=${2%/}
d=$( date +%m%d%y );
zdb -C > "$work_dir"/$d;
new_sha=%( sha256 "$work_dir"/$d );
old_sha=%( cat "work_dir"/lastest );
if ($new_sha != $old_sha)
then
  diff_by_line ""$work_dir"/$d "work_dir"/lastest;
fi
