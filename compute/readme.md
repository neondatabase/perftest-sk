## compute

`deploy.yml` has tasks to create configs for 3 different tests:
- compute
- compute_local
- compute_sync

`compute` test is set up to use safekeepers deployed on 3 other nodes. It creates config from `postgresql.conf.j2`.

`compute_local` is created with initdb and default postgresql.conf.

`compute_sync` is set up for synchronous replication. It creates config from `postgresql-main.conf.j2`. After that basebackup is copied to safekeeper nodes, which set up standby for streaming replication.
