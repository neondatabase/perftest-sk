#!/bin/bash

cat <<EOF | tee ../zenith/inventory/aws
[compute:vars]
ansible_user=admin

[safekeepers:vars]
ansible_user=admin

[safekeepers]
$(terraform output -raw safekeepers_ips)

[compute]
$(terraform output -raw compute_ips)
EOF