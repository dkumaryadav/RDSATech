#!/bin/bash

# Initialize variables / read from CLI
DEVICE="/dev/nvme0n1"
START_BLOCK=0
BLOCK_COUNT=0
# 1GB = 1073741824
DATA_SIZE=10737418240
METADATA_SIZE=64
WRITE_OUTPUT_FILE="write_from_nvme_target.txt"

# ---------------- Connection 
# This will create a connection to a remote system specified by --traddr and --trsvcid
# trasport = rdma(N/W fabric is RDMA N/W i.e., ROCA, iWARP, Infiniband ) | fc(Fibre #channel n/w) | loop(local host) PORT: 4420 Used by default
echo "Starting connection"
	nvme connect --transport=rdma --traddr=192.168.1.1 

# ----------------  Get Namespace ID
# Assuming no Namespace changes are to be done (Attach / Create / Format)
# We can get the namespace id for the nvme block device
	nvme get-ns-id ${DEVICE}

echo "Write for 10GB started using 8 clients"
./nvme_writer.sh "$START_BLOCK" "$BLOCK_COUNT" "$METADATA_SIZE" "$DATA_SIZE" "$WRITE_OUTPUT_FILE" &
./nvme_writer.sh "$START_BLOCK" "$BLOCK_COUNT" "$METADATA_SIZE" "$DATA_SIZE" "$WRITE_OUTPUT_FILE" &
./nvme_writer.sh "$START_BLOCK" "$BLOCK_COUNT" "$METADATA_SIZE" "$DATA_SIZE" "$WRITE_OUTPUT_FILE" &
./nvme_writer.sh "$START_BLOCK" "$BLOCK_COUNT" "$METADATA_SIZE" "$DATA_SIZE" "$WRITE_OUTPUT_FILE" &
./nvme_writer.sh "$START_BLOCK" "$BLOCK_COUNT" "$METADATA_SIZE" "$DATA_SIZE" "$WRITE_OUTPUT_FILE" &
./nvme_writer.sh "$START_BLOCK" "$BLOCK_COUNT" "$METADATA_SIZE" "$DATA_SIZE" "$WRITE_OUTPUT_FILE" &
./nvme_writer.sh "$START_BLOCK" "$BLOCK_COUNT" "$METADATA_SIZE" "$DATA_SIZE" "$WRITE_OUTPUT_FILE" &
./nvme_writer.sh "$START_BLOCK" "$BLOCK_COUNT" "$METADATA_SIZE" "$DATA_SIZE" "$WRITE_OUTPUT_FILE" 
echo "Write for 10GB Completed"

echo "Disconnect"
# ---------------- Disconnect
	nvme disconnect
