#!/bin/bash
# Leeloo Essential Backup Script
# Backs up only what's needed to clone/restore Leeloo

set -e

BACKUP_ROOT="$HOME/Documents/openclaw-backups"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
HOURLY_DIR="$BACKUP_ROOT/leeloo-hourly"
DAILY_DIR="$BACKUP_ROOT/leeloo-daily"
CLONE_DIR="$BACKUP_ROOT/leeloo-clone-package"

# Create backup directories
mkdir -p "$HOURLY_DIR" "$DAILY_DIR" "$CLONE_DIR"

# Determine backup type (hourly or daily)
BACKUP_TYPE="${1:-hourly}"

if [ "$BACKUP_TYPE" = "hourly" ]; then
    DEST="$HOURLY_DIR/leeloo-$TIMESTAMP.zip"
    KEEP=12
else
    DEST="$DAILY_DIR/leeloo-$TIMESTAMP.zip"
    KEEP=7
fi

# Create temporary staging directory
STAGING=$(mktemp -d)
trap "rm -rf $STAGING" EXIT

# Copy essential Leeloo files
mkdir -p "$STAGING/workspace"
cp -r ~/.openclaw/workspace/{*.md,memory,scripts} "$STAGING/workspace/" 2>/dev/null || true

mkdir -p "$STAGING/config"
cp ~/.openclaw/openclaw.json "$STAGING/config/" 2>/dev/null || true

# Copy credentials if they exist
if [ -d ~/.openclaw/credentials ]; then
    cp -r ~/.openclaw/credentials "$STAGING/" 2>/dev/null || true
fi

# Copy voice files if they exist
if [ -d ~/.openclaw/voice ]; then
    cp -r ~/.openclaw/voice "$STAGING/" 2>/dev/null || true
fi

# Create backup archive (ZIP)
( cd "$STAGING" && zip -qr "$DEST" . )

echo "✅ Leeloo backup saved: $DEST"

# Clean up old backups (keep last N)
if [ "$BACKUP_TYPE" = "hourly" ]; then
    ls -t "$HOURLY_DIR"/leeloo-*.zip | tail -n +$((KEEP + 1)) | xargs rm -f 2>/dev/null || true
    echo "🧹 Kept last $KEEP hourly backups"
else
    ls -t "$DAILY_DIR"/leeloo-*.zip | tail -n +$((KEEP + 1)) | xargs rm -f 2>/dev/null || true
    echo "🧹 Kept last $KEEP daily backups"
fi

# Update clone package (always latest)
cp "$DEST" "$CLONE_DIR/leeloo-latest.zip"
echo "📦 Clone package updated: $CLONE_DIR/leeloo-latest.zip"
