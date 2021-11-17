#!/bin/bash
set -eux

echo $(pwd)
echo
echo "pg_test_fsync"
pg_test_fsync
echo
echo "random write"
fio --name=random-write --direct=1 --ioengine=psync --rw=randwrite --bs=4k --size=4g --numjobs=1 --iodepth=1 --runtime=60 --time_based
echo
echo "sequential read"
fio --name=seqread --direct=1 --ioengine=psync --rw=read --bs=4k --size=4g --numjobs=1 --iodepth=1 --runtime=60 --time_based
echo
echo "sequential write"
fio --name=seqwrite --direct=1 --ioengine=psync --rw=write --bs=4k --size=4g --numjobs=1 --iodepth=1 --runtime=60 --time_based
echo
df -h
