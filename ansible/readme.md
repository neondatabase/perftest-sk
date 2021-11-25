# Ansible scripts

Content:
- deploy.yml - install all dependencies, zenith binaries, run disk performance tests, init postgres base dirs for different tests, create safekeeper services
- bench_safekeepers.yml - run pgbench on 1xCompute+3xSafekeeper scheme
- bench_syncreplica.yml - run pgbench on 1xPostgres+3xQuorumSyncReplica
- bench_local.yml - run pgbench on 1xPostgres with default config
- cleanup.yml - remove all files produced by the tests


## Deploy

Run deploy:

```bash
# Deploy safekeepers and compute, including configs for different benchmarks
ansible-playbook -i ../inventory/aws -v deploy.yml
```

Deploy&run, but only safekeepers setups:
```bash
# Deploy safekeepers and compute, including configs for different benchmarks
ansible-playbook -i ../inventory/aws --skip-tags compute_sync -v deploy.yml && ansible-playbook -i ../inventory/aws -v bench_safekeepers.yml
```

Re-run test:
```bash
ansible-playbook -i ../inventory/aws -v cleanup.yml && ansible-playbook -i ../inventory/aws -v deploy.yml --skip-tags compute_sync,diskperf,install,storage,ping && ansible-playbook -i ../inventory/aws -v bench_safekeepers.yml
```

To copy binaries from current machine, set `use_docker` to `false` in `deploy.yml`. It will copy them from `../common/zenith_install.tar.gz`.

## Other scripts

To run other script:

```bash
ansible-playbook -i ../inventory/aws -v <script>.yml
```