# Local deploy

## Prepare local env for testing ansible scripts

1. Install vagrant and vm provider:
```bash
brew install vagrant
brew install virtualbox
```

2. Create and provision vms:
```bash
vagrant up

# Test ssh access to safekeeeper1
ssh vagrant@192.168.56.200
```

3. Make sure zenith/inventory/vagrant has right IP addresses.

## Run deploy locally

```bash
# Optional: download latest zenith binaries, 
cd common && ./get_binaries.sh

# Deploy safekeepers and compute
cd ansible && ansible-playbook \
    -i ../inventory/vagrant \
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

## Clean up

To clean up:
```bash
vagrant destroy -f
```
