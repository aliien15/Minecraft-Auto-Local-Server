#!/bin/bash

SERVER_DIR="mc_test_server"

echo -e "\n\n\n" | ./setup.sh

cd "$SERVER_DIR" || exit
./start.sh
