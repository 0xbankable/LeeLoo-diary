#!/bin/bash
# Quick ack daemon - pings Discord when busy
# Usage: ./ack-daemon.sh "task description"

TASK="${1:-working on it}"
CHANNEL="1469665836737368149"

message send discord "$CHANNEL" "⚡ $TASK"
