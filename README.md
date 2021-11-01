# Safekeeper performance testing

## Prerequisites

0. Create and use pipenv
```sh
pipenv --python 3.10
pipenv shell
```

1. Install `ansible` and `boto`:
```sh
pip install ansible boto
```

2. Install Ansible Prometheus role:
```sh
ansible-galaxy install cloudalchemy.prometheus
brew install gnu-tar # only for macOS users
```

3. Install Terraform, for example on macOS:
```sh
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

4. Have a Docker daemon running locally.

# Local deploy

## Prepare local env for testing ansible scripts

1. Install vagrant and vm provider:
```bash
brew install vagrant
brew install virtualbox
```

2. Create private key for deploys:
```bash
# Create perftest.pem and perftest.pem.pub files
ssh-keygen -f perftest.pem
```

3. Create and provision vms:
```bash
vagrant up

# Test ssh access to safekeeeper1
ssh -i perftest.pem vagrant@192.168.56.200
```

4. Make sure zenith/inventory/vagrant has right IP addresses.

## Run deploy locally

```bash
# Base directory for all deploys
cd zenith

# Download latest zenith binaries
./get_binaries.sh

# Deploy safekeepers and compute
ansible-playbook \
    -i inventory/vagrant \
    --private-key ./perftest.pem \
    --skip-tags aws-specific \
    -v deploy.yml
    # '-l compute' can be used to run scripts for compute only
    # '--skip-tags binaries' can be used to skip binaries upload
```

To test safekeepers work:
```bash
# curl on HTTP port
curl 192.168.56.200:7676/metrics
```

To bind prometheus on localhost:8080:
```bash
ssh -i perftest.pem -L 8080:192.168.56.210:8080 vagrant@192.168.56.210
```

## Clean up

To clean up:
```bash
vagrant destroy -f
```

## Also

Deploy on macOS can fail if this env is not set:
```
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
```

# AWS deploy

## Run deploy on AWS

1. Get `perftest.pem` or any other existing ssh private key and put it with a `400` mode in a safe place. Also upload it to EC2 Key Pairs, to use it for vm creation. Currently it's called 'perftest'.

2. Export AWS keys in your active shell tab:
```sh
export AWS_ACCESS_KEY_ID=XXXXXXXXXXXXXXXXXXXX
export AWS_SECRET_ACCESS_KEY=XXXXXXXXxxxxxxXXXXXXXxxxXXXXXXXXXXXXXXXX
```

3. Create EC2 safekeepers and compute VMs


```bash
cd tf
terraform init
terraform plan
terraform apply
```

4. Update `/zenith/inventory/aws` with proper IP addresses.

```
TODO
```

5. Run deploy

```bash
# Base directory for all deploys
cd zenith

# Deploy safekeepers and compute
ansible-playbook \
    -i inventory/aws \
    --private-key ./perftest.pem \
    -v deploy.yml
```

# Benchmarks

## Test disk perf


```
pg_test_fsync
```

```
fio --name=random-write --ioengine=posixaio --rw=randwrite --bs=4k --numjobs=1 --size=4g --iodepth=1 --runtime=60 --time_based --end_fsync=1
```

```
fio --name=random-write --direct=1 --ioengine=psync --rw=randwrite --bs=4k --size=4g --numjobs=1 --iodepth=1 --runtime=60 --time_based
```

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
