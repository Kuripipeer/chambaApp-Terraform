#!/bin/bash
./ChambaApp-Back &
sleep 5
ngrok http 8080
