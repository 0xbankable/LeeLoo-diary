#!/bin/bash
# Secure OpenRouter Balance Check
# API key is read from environment - never hardcoded

export OPENROUTER_API_KEY="${OPENROUTER_API_KEY:-$(cat ~/.openclaw/credentials/openrouter.txt 2>/dev/null || echo "")}"

if [ -z "$OPENROUTER_API_KEY" ]; then
    echo "Error: No API key found"
    exit 1
fi

# Check balance
curl -s https://openrouter.ai/api/v1/credits \
  -H "Authorization: Bearer $OPENROUTER_API_KEY" | \
  jq -r '.data | "Credits: \(.total_credits) | Used: \(.total_usage) | Remaining: \( (.total_credits - .total_usage) | tonumber | floor)"'
