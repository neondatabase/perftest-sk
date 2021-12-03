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


# Misc

## common psql environment

```
export PGDATA=$(pwd)
export PGUSER=zenith_admin
export PGDATABASE=postgres
```

## build zenith docker image
```
cd ./zenith
docker build --build-arg GIT_VERSION=$(git rev-parse HEAD) -t arthurwow/zenith:latest .
docker push arthurwow/zenith:latest
```
