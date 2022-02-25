# Safekeeper performance testing

Content:
- [prerequisites.md](prerequisites.md) – tools to install
- [local](./local/readme.md) - test deploy locally with Vagrant
- [terraform](./terraform/readme.md) - create EC2 instances in AWS
- [ansible](./ansible/readme.md) - ansible scripts for deploy
- [results](./results/readme.md) - scripts for results collection

Specific directories:
- [common](./common/readme.md) - common scripts and zenith binaries
- [inventory](./inventory/readme.md) - inventory files for ansible
- [keys](./keys/readme.md) - SSH keys
- [compute](./compute/readme.md) - compute scripts and files
- [safekeepers](./safekeepers/readme.md) - safekeepers scripts and files


## Where to start

1. Clone this repo or get access to EC2 instance with everything already prepared
2. Read prerequisites
3. Run terraform scripts to deploy instances for tests
4. Go to ansible directory and run scripts to deploy binaries
5. Run ./launch.sh in ansible directory to run tests automatically

# Misc

## How to build zenith docker image
```
cd ./zenith
export TAG=your-repo/zenith:your-tag
sudo docker build --build-arg GIT_VERSION=$(git rev-parse HEAD) -t $TAG . && sudo docker push $TAG
```
