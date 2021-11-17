## Test disk perf

Postgres tool to test fsync speed:
```bash
pg_test_fsync
```

Test random write:
```bash
fio --name=random-write --direct=1 --ioengine=psync --rw=randwrite --bs=4k --size=4g --numjobs=1 --iodepth=1 --runtime=60 --time_based
```

More numjobs:
```
fio --name=random-write --direct=1 --ioengine=psync --rw=randwrite --bs=4k --size=4g --numjobs=4 --iodepth=1 --runtime=60 --time_based
```

Sequential read:
```
fio --name=seqread --direct=1 --ioengine=psync --rw=read --bs=4k --size=4g --numjobs=1 --iodepth=1 --runtime=60 --time_based
```

Sequential write:
```
fio --name=seqwrite --direct=1 --ioengine=psync --rw=write --bs=4k --size=4g --numjobs=1 --iodepth=1 --runtime=60 --time_based
```
