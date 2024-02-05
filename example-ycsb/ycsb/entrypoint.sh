#!/bin/bash
set -eu

if [[ "${1-}" = "shell" ]]; then
    shift

    echo "****** entrypoint.sh:    executing shell..."
    exec /bin/sh "$@"
else
    echo "****** entrypoint.sh:    loading data based on ${WORKLOAD_NAME} with ${WORKLOAD_RECORD_COUNT} records..."
    /opt/ycsb/bin/ycsb load mongodb -s -P /opt/ycsb/workloads/${WORKLOAD_NAME} -P /opt/ycsb/conf/db.properties -p recordcount=${WORKLOAD_RECORD_COUNT}

    echo "****** entrypoint.sh:    executing benchmark for workload ${WORKLOAD_NAME}"
    exec /opt/ycsb/bin/ycsb run mongodb -s -P /opt/ycsb/workloads//${WORKLOAD_NAME} -P /opt/ycsb/conf/db.properties
fi
