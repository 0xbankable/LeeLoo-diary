#!/bin/bash
# list-backups.sh — show available Leeloo backups

BASE_DIR="$HOME/Documents/openclaw-backups"
echo "Available Leeloo backups:"
echo ""

if [ ! -d "$BASE_DIR" ]; then
  echo "Backup directory does not exist: $BASE_DIR"
  exit 1
fi

echo "Hourly (leeloo-hourly):"
ls -lh "$BASE_DIR"/leeloo-hourly/leeloo-*.zip 2>/dev/null | awk '{print $9, "(" $5 ")" }' | sort -r

echo ""
echo "Daily (leeloo-daily):"
ls -lh "$BASE_DIR"/leeloo-daily/leeloo-*.zip 2>/dev/null | awk '{print $9, "(" $5 ")" }' | sort -r

echo ""
echo "Clone package (latest):"
ls -lh "$BASE_DIR"/leeloo-clone-package/leeloo-latest.zip 2>/dev/null || echo "  not yet created"
