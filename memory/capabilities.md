# Leeloo Capabilities - Tight

What I can actually do. Not installed - WORKING.

---

## Core Tools (Always Available)

| Tool | What it does |
|------|--------------|
| exec | Shell commands, full system access |
| read/write/edit | File operations |
| web_fetch | Pull URL content (X blocks this) |
| web_search | Brave search |
| message | Discord/iMessage send/receive |
| cron | Scheduled tasks |
| sessions_spawn | Sub-agents |
| memory_search/get | Query memory files |
| process | Manage background tasks |
| gateway | Restart/config OpenClaw |

## Voice

| Capability | Status |
|------------|--------|
| TTS | ✓ sag CLI + ElevenLabs |
| STT | ✓ whisper-cpp (local) |
| Voice ID | zyAAyf27kGSJ15oKNGaw |
| Model | eleven_multilingual_v2 |

## Channels

| Channel | Status |
|---------|--------|
| Discord | ✓ Enabled, primary |
| iMessage | ✓ Enabled (can reply, not cross-send from Discord) |
| WhatsApp | ✗ Disabled |
| Signal | ✗ Disabled |

## Games

- **Leeloo & Joshie** - `games/leeloo-story/index.html` - Text adventure about our story (~30 min, multiple endings)

## Skills Verified Working

- **sag** - Voice synthesis
- **summarize** - Content extraction
- **github** - gh CLI wrapper
- **agent-builder** - Design agents
- **browser** - Web automation (Brave) ✓

## Skills Installed (Need Setup)

54 total. Most need API keys/auth. Notable:
- himalaya (email) - needs IMAP/SMTP config
- apple-notes/reminders - should work, untested
- things-mac - should work, untested
- blogwatcher - RSS monitoring
- weather - no key needed

## Blocked (In tools.deny)

- ~~browser~~ - ✓ ENABLED
- tts - Use sag instead
- image - Blocked
- canvas - Blocked
- nodes - Blocked

## Posting Rules

- **Always ASK before posting** to any platform (Twitter, etc.)
- Browser can post through automation, but requires explicit permission first

## Manual Commands (User Can Run)

- `openclaw models set pony-alpha` - Force switch to free model
- `openclaw models set <model>` - Switch to any model
- `openclaw gateway restart` - Restart the gateway
- `openclaw status` - Check system status

- Bun runtime (needed for x-research skill)
- Puppeteer/Playwright (browser automation)
- Direct Twitter/X API access

## Model Strategy

- **Default:** Pony Alpha (openrouter/openrouter/pony-alpha) - ALWAYS
- **Vision/Images:** Gemini Flash - ONLY when analyzing images
- **NO other models** without explicit permission from Joshie
- Credits: ~$10 remaining (check openrouter.ai/credits if errors)

## To Add

- [ ] Bun (for x-research skill)
- [ ] X API token (for Twitter monitoring)
- [ ] Browser enable (remove from deny) if needed

---

*Tight list. Update when something changes.*
