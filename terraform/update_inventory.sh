#!/bin/bash

cat <<EOF | tee ../inventory/aws
[compute:vars]
ansible_user=admin

[safekeepers:vars]
ansible_user=admin

[safekeepers]
$(terraform output -raw safekeepers_ips | awk 'NF{print $0 " main_dir=/storage"}')

[compute]
$(terraform output -raw compute_ips | awk 'NF{print $0 " main_dir=/var/db/postgres"}')
EOF