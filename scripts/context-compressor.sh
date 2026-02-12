#!/bin/bash
# Context Compressor - Auto-compact long sessions
# Run via cron or manually when context >80%
# Preserves: Decisions, facts, URLs, goals

SESSION_JSON="/Users/joshuamcmenamin/.openclaw/agents/main/sessions/sessions.json"
DISCORD_SESSION="/Users/joshuamcmenamin/.openclaw/agents/main/sessions/3f515fb7-505d-446b-9e78-3d2c2e8fcca8.jsonl"
MAIN_SESSION="/Users/joshuamcmenamin/.openclaw/agents/main/sessions/78c1dcbc-a4b4-4ff0-aadd-187fc1942529.jsonl"
MEMORY_DIR="/Users/joshuamcmenamin/.openclaw/workspace/memory"
DATE=$(date +%Y-%m-%d)

# Check context usage
check_context() {
    local session_file=$1
    if [ ! -f "$session_file" ]; then
        echo "Session file not found: $session_file"
        return 1
    fi
    
    # Count lines (rough proxy for size)
    local lines=$(wc -l < "$session_file")
    # Discord session typically ~2000 messages at full
    # Main session varies
    
    if [ $lines -gt 1800 ]; then
        echo "HIGH: $lines lines"
        return 0
    else
        echo "OK: $lines lines"
        return 1
    fi
}

# Extract key info from session
compress_session() {
    local session_file=$1
    local session_name=$2
    local output="$MEMORY_DIR/compressed-${session_name}-${DATE}.md"
    
    echo "# Compressed Session: $session_name - $DATE" > "$output"
    echo "" >> "$output"
    echo "## Key Decisions" >> "$output"
    grep -i "decision\|agreed\|confirmed\|will do\|next step" "$session_file" 2>/dev/null | tail -10 >> "$output"
    
    echo "" >> "$output"
    echo "## URLs / References" >> "$output"
    grep -oE 'https?://[^"[:space:]]+' "$session_file" 2>/dev/null | sort -u | tail -20 >> "$output"
    
    echo "" >> "$output"
    echo "## Facts Learned" >> "$output"
    grep -i "working\|fixed\|bug\|error\|config" "$session_file" 2>/dev/null | grep -v "error_code" | tail -10 >> "$output"
    
    echo "" >> "$output"
    echo "## Original Session" >> "$output"
    echo "- File: $(basename $session_file)" >> "$output"
    echo "- Lines: $(wc -l < $session_file)" >> "$output"
    echo "- Compressed: $DATE" >> "$output"
    
    echo "Compressed to: $output"
}

# Main execution
case "$1" in
    check)
        echo "Checking Discord session..."
        check_context "$DISCORD_SESSION"
        echo "Checking Main session..."
        check_context "$MAIN_SESSION"
        ;;
    compress-discord)
        if check_context "$DISCORD_SESSION"; then
            compress_session "$DISCORD_SESSION" "discord"
            echo "Consider: Clear old transcript if needed"
        fi
        ;;
    compress-main)
        if check_context "$MAIN_SESSION"; then
            compress_session "$MAIN_SESSION" "main"
        fi
        ;;
    *)
        echo "Context Compressor"
        echo "Usage: $0 [check|compress-discord|compress-main]"
        echo ""
        echo "This tool preserves key info while managing session bloat."
        ;;
esac
