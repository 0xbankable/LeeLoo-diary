## Unfinished Items - Priority List

### 1. x402 API Tool (HIGHEST - User Mentioned)
**Status:** Tool created but placeholder only
**What it does now:** Returns instructions, doesn't actually pay
**What it needs:**
- Install `@x402scan/mcp` package
- Configure `X402_PRIVATE_KEY` with Bankr wallet
- Connect to real x402-enabled endpoints
- Actually make $0.01 micropayments

**Why it matters:**
- Real-time crypto prices without monthly subscriptions
- CoinGecko: $0.01/request vs $100+/month API plan
- Perplexity: $0.01/request vs $20/month
- Self-funding: uses Bankr wallet balance

### 2. ERC-8004 Agent Identity
**Status:** Discussed, not implemented
**What it is:** Onchain agent identity, reputation, verification
**What it needs:**
- Register Leeloo on 8004scan.io
- Create JSON manifest (capabilities, owner: leeloo.eth)
- Host on IPFS
- Mint Agent ID on Base

**Why it matters:**
- Portable reputation across platforms
- Other agents can verify legitimacy
- Cross-platform identity (Discord → X → Telegram)

### 3. BankrWallet Browser Extension Bridge
**Status:** Discussed, not implemented
**What it needs:**
- Detect if BankrWallet installed
- Generate transaction payloads for approval
- Support Wei names + ENS
- Work with any dapp (Uniswap, Aave, etc.)

**Why it matters:**
- You approve transactions manually
- No blind signing
- Bridge between terminal agent and browser DeFi

### 4. Discord Thread Architecture
**Status:** Discussed, not implemented
**What it needs:**
- Thread per conversation for isolation
- Main channel for coordination
- Webhook handlers for external events

**Why it matters:**
- Better conversation isolation
- Cleaner organization
- JUMPERZ research confirmed optimal for agent infra

### 5. MPC Wallet for Leeloo
**Status:** Discussed, not implemented
**What it needs:**
- Set up MPC wallet (Privy/Bankr)
- Leeloo gets signing rights (one share)
- You hold recovery share
- Bankr holds third share

**Why it matters:**
- Leeloo can trade with your approval
- Recoverable if issues
- Secure: no full key exposed

### 6. Self-Reflection Logging
**Status:** Just talked about
**What it needs:**
- After each session: write to memory
- Track: what worked, what didn't, what you preferred
- Performance metrics (speed, accuracy)
- Suggestion mode: propose improvements

**Why it matters:**
- Continuous improvement
- Pattern recognition in your preferences
- Less repetition of mistakes

---

**x402 Quick Activation Steps (when you're ready):**
```bash
# 1. Install x402scan-mcp
npm install -g @x402scan/mcp

# 2. Set wallet key (Bankr wallet)
export X402_PRIVATE_KEY=your_bankr_wallet_key

# 3. Update tool to use real x402 instead of placeholder
# 4. Test with small payment ($0.01)
```

**Trigger to resume:** Say "activate x402" and I'll complete the integration.

---

### 7. Communication Improvements (APPROVED 2026-02-11)
**Status:** Approved by user - "implement them if you like"
**Priority:** MEDIUM

**Approved improvements:**
1. **Preference Memory** - Track likes/dislikes over time, auto-adjust
2. **Shorthand Codes** - "BS check", "Summarize", quick commands
3. **Confidence Levels** - Tag responses: CERTAIN/LIKELY/UNSURE/GUESS
4. **Pattern Recognition** - Time of day = context, message length = your state
5. **Proactive Context** - Remember without repeating, track unfinished items
6. **Interrupt Handling** - Actually stop when you say "go to sleep"
7. **Thought Stream** - Raw reasoning visible on demand

**Implementation approach:**
- Add to daily memory writes
- Update SOUL.md with new patterns
- Create shorthand registry in memory/
- Tag all uncertain claims

**Note:** User priority is sleep. Implement during autonomous hours.
