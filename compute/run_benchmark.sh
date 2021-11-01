#!/bin/bash
set -eux

export PGDATA=$(pwd)
export PGUSER=zenith_admin
export PGDATABASE=postgres

pg_ctl start -w -l pg.log

time pgbench -i -s 400   2>&1 | tee -a pgbench_init.log

pgbench -c 32 -P 1 -T 60   2>&1 | tee -a pgbench.log

pg_ctl stop
