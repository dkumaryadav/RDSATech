#!/bin/bash

# ---------------- Read a file and write it to a file
	nvme-read ${DEVICE} --start-block=$1
						--block-count=$2 \
						--metadata-size=$3 \
						--data-size=$4 \
						--data $5 --latency