#!/bin/bash

SERVER_DIR="mc_test_server"
CURRENT_DIR=$(pwd)
TARGET_PATH="$CURRENT_DIR/$SERVER_DIR"

if [ ! -d "$SERVER_DIR" ]; then
    echo "Server directory '$SERVER_DIR' does not exist. Nothing to do."
    exit 0
fi

echo "Scanning for active server processes in $TARGET_PATH..."

PIDS=$(pgrep java)

if [ -n "$PIDS" ]; then
    for PID in $PIDS; do
        if ls -l "/proc/$PID/cwd" 2>/dev/null | grep -q "$TARGET_PATH"; then
            echo "Force stopping server process (PID: $PID)..."
            kill -9 "$PID"
        fi
    done
fi

echo "Deleting server directory and all contents..."
rm -rf "$SERVER_DIR"

echo "Cleanup complete."