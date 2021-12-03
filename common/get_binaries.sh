#!/usr/bin/env sh
set -eux

#
# Export pre-built Zenith and Postgres binaries from the
# zenithdb/zenith:latest Docker image.
#

export DOCKER_IMAGE=arthurwow/zenith:latest

rm -rf zenith_install
mkdir zenith_install

docker pull $DOCKER_IMAGE
ID=$(docker create $DOCKER_IMAGE)

echo "Copying binaries from the temp container $ID"
docker cp $ID:/data/postgres_install.tar.gz .
tar -xzf postgres_install.tar.gz -C zenith_install && rm postgres_install.tar.gz

docker cp $ID:/usr/local/bin/pageserver zenith_install/bin/
docker cp $ID:/usr/local/bin/safekeeper zenith_install/bin/
docker cp $ID:/usr/local/bin/proxy zenith_install/bin/
docker cp $ID:/usr/local/bin/postgres zenith_install/bin/

echo "Deleting temp container $ID"
docker rm -v $ID

echo "Packaging Zenith binaries into zenith_install.tar.gz"
cd zenith_install && tar -czf ../zenith_install.tar.gz . && cd ..
