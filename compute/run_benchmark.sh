#!/bin/bash
set -eux

export PGDATA=$(pwd)
export PGUSER=zenith_admin
export PGDATABASE=postgres

pg_ctl start -w -l pg.log

pgbench -i -s 40   2>&1 | tee pgbench_init.log

pgbench -c 32 -P 1 -T 3600   2>&1 | tee pgbench.log

pg_ctl stop
