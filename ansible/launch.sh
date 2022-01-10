#!/bin/bash
set -eux

is_completed() {
    result=$(ssh -A admin@$(cd ../terraform && terraform output -raw compute_public_ip) -- sudo tail -n 1 /var/db/postgres/$1/pgbench.log | grep "(without initial connection time)")
    [[ ! -z "$result" ]]
}

wait_until_completed() {
    echo "Waiting until test $1 completes"
    until is_completed $1;
    do
        sleep 5
    done
    echo "Test is completed"
}

collect_results() {
    echo "Collecting results for test $1"
    cd ../results
    ansible-playbook -i ../inventory/aws -v ./report.yml --extra-vars "test_name=$1"
    ./create_report.sh
    cd ../ansible
}

# ansible-playbook -i ../inventory/aws -v bench_safekeepers.yml --extra-vars "connections_count=32"

run_test() {
    # $1 -- test name
    # $2 -- connections count
    echo "Running test for $2 connections in pgbench"
    ansible-playbook -i ../inventory/aws -v cleanup.yml
    ansible-playbook -i ../inventory/aws -v deploy.yml --skip-tags diskperf,install,storage,ping
    ansible-playbook -i ../inventory/aws -v "bench_$1.yml" --extra-vars "connections_count=$2"
    wait_until_completed $1
    collect_results $1
}

run_tests() {
    echo "Running tests in directory $1"
    for conns in {1,8,32,32}; do
        run_test $1 $conns
    done
}

run_tests compute
run_tests compute_sync
# run_tests compute_local

# run_test compute_sync 32
# run_test compute 32
# run_test compute_local 32
# run_test compute_sync 32
