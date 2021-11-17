## Prerequisites

1. Create and use pipenv
```sh
pipenv --python 3.10
pipenv shell
```

2. Install `ansible`:
```sh
pip install ansible
ansible-galaxy collection install ansible.posix
```

3. Install Terraform, for example on macOS:
```sh
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

4. Prepare private key and init ssh-agent:
```bash
cd keys

# Fetch existing perftest.pem from somewhere
# or
# Create perftest.pem and perftest.pem.pub files
ssh-keygen -f perftest.pem

# Start SSH agent and add perftest.pem
eval `ssh-agent`
ssh-add ./keys/perftest.pem
```

5. Have a Docker daemon running locally.
