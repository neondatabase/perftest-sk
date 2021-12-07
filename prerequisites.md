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

sudo apt install python3-pip
pip install pipenv

git clone git@github.com:petuhovskiy/zenith-perftest.git
cd zenith-perftest
pipenv install
pipenv shell

pip install ansible
ansible-galaxy collection install ansible.posix

sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform

cat > env.sh
chmod +x ./env.sh

cd keys
cat > perftest.pem
chmod 0600 perftest.pem
cd ..

cd terraform
terraform init

git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```