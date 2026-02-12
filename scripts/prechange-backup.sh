#!/bin/bash
# Pre-change backup script for Leeloo
# Usage: ./prechange-backup.sh "description of change"
# Creates a named backup before making risky changes

set -e

DESCRIPTION="${1:-pre-change}"
TIMESTAMP=$(date +"%Y-%m-%d-%H%M%S")
BACKUP_NAME="leeloo-prechange-${DESCRIPTION// /-}-${TIMESTAMP}"
BACKUP_DIR="$HOME/backups"
REPO_URL="https://github.com/0xbankable/leeloo-multipass-backup.git"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Creating pre-change backup...${NC}"
echo "Description: $DESCRIPTION"
echo "Name: $BACKUP_NAME.tar.gz"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Create backup
cd "$HOME"
tar -czf "$BACKUP_DIR/$BACKUP_NAME.tar.gz" \
    --exclude='.openclaw/workspace/backups' \
    --exclude='.openclaw/workspace/node_modules' \
    --exclude='.openclaw/workspace/.git' \
    .openclaw/workspace/ \
    .openclaw/openclaw.json \
    .openclaw/scripts/ \
    .openclaw/skills/ 2>/dev/null || true

# Get size
SIZE=$(du -h "$BACKUP_DIR/$BACKUP_NAME.tar.gz" | cut -f1)

echo -e "${GREEN}✓ Backup created: $BACKUP_NAME.tar.gz ($SIZE)${NC}"

# Push to GitHub
echo -e "${YELLOW}Pushing to GitHub...${NC}"

# Clone or update backup repo
if [ -d "/tmp/leeloo-backup-repo" ]; then
    cd /tmp/leeloo-backup-repo
    git pull --quiet
else
    git clone "$REPO_URL" /tmp/leeloo-backup-repo --quiet
    cd /tmp/leeloo-backup-repo
fi

# Copy backup
cp "$BACKUP_DIR/$BACKUP_NAME.tar.gz" backups/

# Commit and push
git add "backups/$BACKUP_NAME.tar.gz"
git commit -m "Pre-change backup: $DESCRIPTION ($TIMESTAMP)" --quiet
git push origin main --quiet

echo -e "${GREEN}✓ Pushed to GitHub: leeloo-multipass-backup${NC}"

# Create restore marker
echo "$BACKUP_NAME" > "$BACKUP_DIR/.last-prechange"
echo "$DESCRIPTION" >> "$BACKUP_DIR/.prechange-log"

echo ""
echo -e "${GREEN}Backup complete!${NC}"
echo "Location: $BACKUP_DIR/$BACKUP_NAME.tar.gz"
echo "GitHub:   https://github.com/0xbankable/leeloo-multipass-backup/tree/main/backups"
echo ""
echo "To restore if needed:"
echo "  ./scripts/restore-leeloo.sh $BACKUP_NAME.tar.gz"
