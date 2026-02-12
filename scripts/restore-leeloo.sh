#!/bin/bash
# restore-leeloo.sh — restore workspace to backup state

set -e

BACKUP_DIR="$HOME/Documents/openclaw-backups"
WORKSPACE="$HOME/.openclaw/workspace"

if [ $# -ne 1 ]; then
  echo "Usage: $0 <backup-file-or-date>"
  echo "  backup-file: full path to leeloo-YYYY-MM-DD.zip"
  echo "  date: YYYY-MM-DD (will look for leeloo-YYYY-MM-DD.zip)"
  echo ""
  echo "Examples:"
  echo "  $0 leeloo-2026-02-09.zip"
  echo "  $0 2026-02-09"
  exit 1
fi

INPUT="$1"

if [[ ! "$INPUT" =~ \.zip$ ]]; then
  BACKUP_FILE="$BACKUP_DIR/leeloo-$INPUT.zip"
else
  BACKUP_FILE="$INPUT"
fi

if [ ! -f "$BACKUP_FILE" ]; then
  echo "Backup file not found: $BACKUP_FILE"
  echo "Use 'scripts/list-backups.sh' to see available backups."
  exit 1
fi

echo "Restoring from: $BACKUP_FILE"
echo "Workspace: $WORKSPACE"
echo ""

# Confirm
read -p "This will overwrite files in workspace. Continue? (yes/no): " CONFIRM
if [ "$CONFIRM" != "yes" ]; then
  echo "Aborted."
  exit 1
fi

# Create temporary directory
TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

echo "Extracting..."
unzip -q "$BACKUP_FILE" -d "$TMPDIR"

# Find the extracted folder (should be one top-level)
TOP_DIR=$(find "$TMPDIR" -mindepth 1 -maxdepth 1 -type d | head -n1)
if [ -z "$TOP_DIR" ]; then
  echo "No top-level directory found in backup."
  exit 1
fi

echo "Copying to workspace..."
rsync -a --delete "$TOP_DIR"/ "$WORKSPACE"/

echo ""
echo "Restore complete. Please restart OpenClaw gateway:"
echo "  openclaw gateway restart"
