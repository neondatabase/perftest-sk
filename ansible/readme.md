# AWS deploy

Run deploy:

```bash
# Deploy safekeepers and compute, including configs for different benchmarks
ansible-playbook -i ../inventory/aws -v deploy.yml
```

# Benchmarks

## Test postgres without replication

Run on compute:
```
sudo su postgres
cd ~/compute_local/

export PGDATA=$(pwd)
export PGUSER=zenith_admin
export PGDATABASE=postgres
pg_ctl start -w -l pg.log
pgbench -i -s 40   2>&1 | tee -a pgbench_init.log
pgbench -c 32 -P 1 -T 60   2>&1 | tee -a pgbench.log
pg_ctl stop
```

## Run pgbench

```bash
sudo su postgres
cd ~/compute

tmux new-session -d -s bench bash \
    && tmux split-window -h -t bench bash \
    && tmux send -t bench:0.0 "./run_benchmark.sh" C-m

tmux attach -t bench

tmux kill-session -t bench
```
