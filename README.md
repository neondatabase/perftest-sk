# Safekeeper perf testing

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

2. Install Ansible AWS extension and prometheus role:
```sh
ansible-galaxy collection install amazon.aws
ansible-galaxy install cloudalchemy.prometheus
brew install gnu-tar # only for macOS users
```

3. Install Packer, for example on macOS:
```sh
brew install packer
```

4. Have a Docker daemon running locally.

## Prepare local env for playbook testing

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
```

To test safekeepers work:
```bash
# curl on HTTP port
curl 192.168.56.200:7676/metrics
```

To open prometheus:
```bash
ssh -i perftest.pem -L 8080:192.168.56.210:8080 vagrant@192.168.56.210
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

## Clean up

To clean up:
```bash
vagrant destroy -f
```

## Run deploy on AWS (TODO)

1. Get `pageserver.pem` or any other existing ssh private key and put it with a `400` mode in a safe place.

2. Export AWS keys in your active shell tab:
```sh
export AWS_ACCESS_KEY_ID=XXXXXXXXXXXXXXXXXXXX
export AWS_SECRET_ACCESS_KEY=XXXXXXXXxxxxxxXXXXXXXxxxXXXXXXXXXXXXXXXX
```

## Also

Deploy on macOS can fail if this env is not set:
```
OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
```