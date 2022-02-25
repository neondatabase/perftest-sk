#!/bin/bash
set -eux

export PGDATA=$(pwd)
export PGUSER=zenith_admin
export PGDATABASE=postgres

./collect_metrics.sh "before init"

time pgbench -i -s ${PGBENCH_SCALE:-400}   2>&1 | tee -a pgbench_init.log

./collect_metrics.sh "after init"

pgbench -c ${CONNECTIONS_COUNT:-1} -N -P 1 -T ${PGBENCH_TIME:-600}   2>&1 | tee -a pgbench.log

./collect_metrics.sh "after benchmark"
