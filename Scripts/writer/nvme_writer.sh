#!/bin/bash

nvme-write ${DEVICE} --start-block=$1
						--block-count=$2 \
						--metadata-size=$3 \
						--data-size=$4 \
						--data $5 --latency