#!/bin/bash
# Scout Monitoring Script - Social Media Intel
# Runs every 5 minutes via cron

LOG_FILE="$HOME/.openclaw/logs/scout-monitor.log"
DISCORD_CHANNEL="1469665836737368149"
GATEWAY_TOKEN="cef295f840e5ff3a6b55d0090eb36c5f7ad4679cf3e9e8a0dae9dfb2ff528eb8"

echo "[$(date)] Scout check starting..." >> "$LOG_FILE"

# Check OpenRouter Twitter
OPENROUTER_TWEETS=$(bird user-tweets @OpenRouterAI -n 3 2>/dev/null | head -20)
if [ -n "$OPENROUTER_TWEETS" ]; then
    # Check if new (compare to last check)
    LAST_CHECK=$(cat ~/.openclaw/scout/openrouter-last.txt 2>/dev/null || echo "")
    if [ "$OPENROUTER_TWEETS" != "$LAST_CHECK" ]; then
        echo "$OPENROUTER_TWEETS" > ~/.openclaw/scout/openrouter-last.txt
        echo "[$(date)] OpenRouter: New activity detected" >> "$LOG_FILE"
        # Send alert to Discord
        curl -s -X POST "http://127.0.0.1:18789/api/channels/discord/send" \
          -H "Authorization: Bearer $GATEWAY_TOKEN" \
          -H "Content-Type: application/json" \
          -d "{\"channel\":\"$DISCORD_CHANNEL\",\"message\":\"🤖 **Scout Alert** - OpenRouter activity detected:\\n\\n$OPENROUTER_TWEETS\"}" >> "$LOG_FILE" 2>&1
    fi
fi

# Check 0xDeployer Twitter
DEPLOYER_TWEETS=$(bird user-tweets @0xdeployer -n 3 2>/dev/null | head -20)
if [ -n "$DEPLOYER_TWEETS" ]; then
    LAST_CHECK=$(cat ~/.openclaw/scout/deployer-last.txt 2>/dev/null || echo "")
    if [ "$DEPLOYER_TWEETS" != "$LAST_CHECK" ]; then
        echo "$DEPLOYER_TWEETS" > ~/.openclaw/scout/deployer-last.txt
        echo "[$(date)] 0xDeployer: New activity detected" >> "$LOG_FILE"
        curl -s -X POST "http://127.0.0.1:18789/api/channels/discord/send" \
          -H "Authorization: Bearer $GATEWAY_TOKEN" \
          -H "Content-Type: application/json" \
          -d "{\"channel\":\"$DISCORD_CHANNEL\",\"message\":\"🚀 **Scout Alert** - 0xDeployer activity detected:\\n\\n$DEPLOYER_TWEETS\"}" >> "$LOG_FILE" 2>&1
    fi
fi

echo "[$(date)] Scout check complete" >> "$LOG_FILE"
