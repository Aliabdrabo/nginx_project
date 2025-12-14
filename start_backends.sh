#!/bin/bash
echo "Starting Backend 1 on port 8081..."
cd backend1
python3 -m http.server 8081 &
BACKEND1_PID=$!

echo "Starting Backend 2 on port 8082..."
cd ../backend2
python3 -m http.server 8082 &
BACKEND2_PID=$!

echo "Backends started:"
echo "Backend1 PID: $BACKEND1_PID"
echo "Backend2 PID: $BACKEND2_PID"

cd ..

