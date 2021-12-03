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

## Quick tools setup on fresh ubuntu
```bash
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh
gh auth login

git clone git@github.com:petuhovskiy/zenith-perftest.git
cd zenith-perftest

# TODO

apt install python3-pip
pip install pipenv
```