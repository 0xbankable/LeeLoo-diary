## Nanobankr Architecture Deep Dive (2026-02-11)

**Built by:** Claude 4.6 via Claude Code
**Creator:** Josh (@0xBankable)
**Purpose:** Autonomous AI agent that trades crypto, posts on X/Twitter, and pays for itself

### Core Architecture

**Host (macOS)**
- Single Node.js orchestrator (`src/index.ts`)
- SQLite database for state (messages, sessions, groups)
- WhatsApp/Discord/TUI channel support
- IPC watcher handles container→host communication

**Agent Containers (Apple Container)**
- One container per chat group (isolated filesystem)
- Claude Agent SDK runs inside each container
- MCP tool server (`ipc-mcp-stdio.ts`) provides:
  - `send_message` - immediate messaging
  - `schedule_task` - cron scheduling
  - `compact_session` - memory management

**Crypto/Trading**
- `bankr` CLI pre-installed in containers
- Bankr API key via `BANKR_API_KEY` env var
- LLM Gateway (`llm.bankr.bot`) uses x402 micropayments
- Self-funding loop: agent earns fees → pays for inference

**X/Twitter Integration**
- Browser automation via Playwright (host-side)
- Skills architecture in `.claude/skills/x-integration/`
- MCP tools in container → IPC files → host scripts → Chrome
- Bypasses X API fees ($100+/month) via browser automation

### Three Variants

| Version | Target | Container | Best For |
|---------|--------|-----------|----------|
| Full | Mac | Apple Container | Security, multi-user |
| Lite | Any OS | None (direct Node) | Simple setup, Pi/laptops |
| Phone | Android | Termux | $25 dedicated device, 24/7 |

### Key Integration Points

**x402scan-mcp Integration**
- Config location: `.mcp.json` (currently empty)
- Would expose pay-per-use APIs as MCP tools
- Shares Bankr wallet with LLM Gateway
- Payments flow through same mechanism

**Bankr LLM Gateway**
- Base URL: `https://llm.bankr.bot`
- Supports: Claude, GPT, Gemini, Kimi, Qwen
- Authentication: `BANKR_API_KEY` (bk_* format)
- Payment: BNKR tokens via x402 protocol

**Agent Memory**
- Per-group: `/workspace/group/` in container
- Global (read-only): `/workspace/global/`
- Config: `agent-config.json`
- Trade logs: `trade-log.md`

### Security Model

- OS-level isolation (containers)
- Agents only see explicitly mounted paths
- Bankr handles wallet security (Privy)
- No private keys exposed to agents
- X auth via Chrome profile (host-side)

### Self-Sustaining Loop

```
Agent trades → earns fees → BNKR/USDC in wallet
                    ↓
LLM Gateway deducts inference costs
                    ↓
Agent continues operating
```

### Development Notes

- Skills system for extensibility (x-integration pattern)
- Container build context: project root (access to `.claude/skills/`)
- IPC via filesystem (`/workspace/ipc/`)
- SQLite for persistence
- Trigger pattern for non-main groups

### Future Integration Targets

- x402scan-mcp for API payments
- ERC-8004 for agent identity/reputation
- BankrWallet browser extension
- Discord threads/webhooks for agent infrastructure
