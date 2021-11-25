## compute

`deploy.yml` has tasks to create configs for 3 different tests:
- compute
- compute_local
- compute_sync

`compute` test is set up to use safekeepers deployed on 3 other nodes. It creates config from `postgresql.conf.j2`.

`compute_local` is created with initdb and default postgresql.conf.

`compute_sync` is set up for synchronous replication. It creates config from `postgresql-main.conf.j2`. After that basebackup is copied to safekeeper nodes, which set up standby for streaming replication.

## run benchmark manually

```bash
pg_ctl start -w -l pg.log

tmux kill-session -t bench || true

tmux new-session -d -s bench bash \
    && tmux split-window -h -t bench bash \
    && tmux send -t bench:0.0 "./run_benchmark.sh" C-m

pg_ctl stop -w
```

## parse stats from pg.log

```bash
grep "sending message" pg.log > send.log
awk '{print $9}' send.log > sizes.log

echo 'Total append messages (to all 3 safekeepers):' && wc -l send.log
echo 'Zero-length messages (all safekeepers):' && grep "len 0" send.log | wc -l
# grep -Fx "0" sizes.log | wc -l
```

## common psql environment

```
export PGDATA=$(pwd)
export PGUSER=zenith_admin
export PGDATABASE=postgres
```
