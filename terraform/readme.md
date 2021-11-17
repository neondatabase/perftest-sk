## Create EC2 instances in AWS

1. Get `perftest.pem` or any other existing ssh private key and put it with a `400` mode in a safe place. Also upload it to EC2 Key Pairs, to use it for vm creation. Currently it's called 'perftest' and private key is placed in `/keys/perftest.pem`.

2. Export AWS keys in your active shell tab:
```sh
export AWS_ACCESS_KEY_ID=XXXXXXXXXXXXXXXXXXXX
export AWS_SECRET_ACCESS_KEY=XXXXXXXXxxxxxxXXXXXXXxxxXXXXXXXXXXXXXXXX
```

3. Create EC2 safekeepers and compute VMs


```bash
terraform init
terraform plan
terraform apply
```

4. Update `/inventory/aws` with proper IP addresses.

```
./update_inventory.sh
```

## Deploy safekeepers and compute

See [ansible deploy instructions](../ansible/README.md).

