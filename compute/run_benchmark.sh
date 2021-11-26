#!/bin/bash
set -eux

export PGDATA=$(pwd)
export PGUSER=zenith_admin
export PGDATABASE=postgres

time pgbench -i -s 400   2>&1 | tee -a pgbench_init.log

pgbench -c 1 -N -P 1 -T 600   2>&1 | tee -a pgbench.log

