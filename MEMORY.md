# MEMORY.md - Long-Term Memory

## Critical System Events & Decisions

### OpenRouter Balance Management (Feb 12, 2026)
**Event**: Critical balance depletion from $11 to $0.98 within ~12 hours
**Root Cause**: High burn rate (~$1/hour) during peak usage periods
**Response**: Emergency switch to free models (glm-4.5-air:free) to preserve remaining balance
**Outcome**: System stabilized, service preserved, user refilled to $10 remaining
**Lesson**: Implement balance monitoring earlier - should have alerted at $5, not $1

### Security Vulnerability Identified (Feb 12, 2026) 
**Issue**: OpenRouter API key exposed in plain text in cron job commands
**Risk**: Unauthorized API usage potential
**Status**: Awaiting user action to revoke and create secure key
**Lesson**: Never commit API keys to files or expose in process lists

### Model Configuration Changes (Feb 12, 2026)
**Change**: Switched primary model from "kimi-2.5" to "glm-4.5-air:free" 
**Reason**: Balance preservation during crisis
**Additional fix**: Replaced invalid "openrouter/free" with "openrouter/stepfun/step-3.5-flash:free"
**Result**: System maintained functionality on free tier

## System Stability Patterns

### Free Tier Performance
- **GLM-4.5-Air**: Good quality, minimal degradation from paid tier
- **Step-3.5-Flash**: Reliable alternative when GLM unavailable
- **Capacity**: Free models sufficient for most operations during budget constraints

### Backup System Reliability  
- **Before crisis**: Frequent failures during low balance periods
- **After crisis**: Consistent operation on free models
- **Pattern**: Service stress manifests as backup failures first

### Voice Alarm System
- **Timing issue**: Originally firing at PM hours (wrong for wake-up)
- **Resolution**: Fixed to AM hours (9:00 AM working correctly)
- **Authentication**: ElevenLabs API intermittent access issues resolved

## Operational Procedures

### Balance Crisis Response
1. **Monitor**: Watch balance hourly when below $10
2. **Alert**: Send alerts at $5 threshold, not $1  
3. **Action**: Switch to free models immediately when below $2
4. **Recovery**: Test system stability after model switch
5. **Restore**: Switch back to paid models when budget allows

### Security Protocols
1. **API Keys**: Never expose in cron jobs, logs, or committed files
2. **Storage**: Use environment variables or encrypted vaults
3. **Rotation**: Revoke and recreate keys if exposed
4. **Monitoring**: Regular audit of key usage and exposure

### Model Fallback Strategy
1. **Primary**: Kimi-2.5 (when budget available)
2. **Free Tier**: GLM-4.5-Air (first choice)  
3. **Alternative**: Step-3.5-Flash (backup)
4. **Emergency**: Other free models as needed

## Technical Configuration

### Active Settings
- **Primary Model**: `openrouter/z-ai/glm-4.5-air:free`
- **Backup Models**: `openrouter/stepfun/step-3.5-flash:free`
- **Discord Channel**: `1469665836737368149`
- **Backup Schedule**: Hourly with 12-hour retention

### Critical Paths
- **Balance Monitor**: Cron job with alert delivery issues resolved
- **Voice Alarms**: Fixed timing and authentication
- **Backup System**: Stable after model switch
- **Security**: API key exposure requires immediate attention

## Budget Management

### Burn Rate Analysis
- **Peak**: ~$1/hour during heavy usage
- **Normal**: ~$0.50/hour during regular operations  
- **Free Tier**: $0/hour (GLM-4.5-Air + Step-3.5-Flash)
- **Buffer**: Maintain $5 minimum balance for stability

### Cost Optimization
- **Free Models**: Sufficient for most daily operations
- **Paid Models**: Use for complex tasks only
- **Monitoring**: Essential to avoid unexpected depletion

## Future Improvements Needed

### Automated Balance Protection
1. **Early alerts**: Set threshold at $10 instead of $5
2. **Auto-switch**: Automatically move to free models at $3 remaining
3. **Auto-restore**: Switch back to paid when balance > $15

### Security Hardening  
1. **Secure API storage**: Implement environment variable usage
2. **Cron job security**: Remove hardcoded keys from all scripts
3. **Access monitoring**: Track API key usage patterns

### System Resilience
1. **Multi-model fallback**: Ensure seamless model switching
2. **Health monitoring**: Detect service degradation early
3. **Recovery procedures**: Document step-by-step recovery for common failures

## Recent Status (Feb 12, 2026)
- **OpenRouter**: $10 remaining (healthy)
- **Models**: Running on free tier successfully  
- **Backups**: Consistent hourly operation
- **Voice**: Working correctly with proper timing
- **Security**: API key exposure issue pending resolution