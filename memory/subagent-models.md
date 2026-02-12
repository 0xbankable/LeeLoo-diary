# Subagent Model Architecture - Implemented

**Date:** 2026-02-11
**Status:** Active (takes effect next session)

---

## Main Agent (You)

**Model:** `openrouter/moonshotai/kimi-k2.5`
- **Alias:** `kimi`
- **Role:** Primary reasoning, conversation, decision-making
- **Cost:** ~$0.80/$2.00 per million tokens
- **Fallbacks:** GLM-4.5-free → OpenRouter Free

---

## Subagent Task-Specific Models

### 1. Coding Subagent
**Model:** `openrouter/z-ai/glm-5`  
**Alias:** `glm5`  
**Cost:** $0.60/$1.80 per million  
**Fallback:** `openrouter/qwen/qwen3-coder:free`  
**Use:** Complex coding, refactoring, debugging, architecture

### 2. Research Subagent
**Model:** `openrouter/deepseek/deepseek-r1-0528:free`  
**Alias:** `deepseek-r1`  
**Cost:** FREE  
**Fallback:** `openrouter/free`  
**Use:** Deep research, analysis, reasoning, o1-level tasks

### 3. Quick Tasks Subagent
**Model:** `openrouter/qwen/qwen3-coder:free`  
**Alias:** `qwen-coder`  
**Cost:** FREE  
**Fallback:** `openrouter/meta-llama/llama-3.3-70b-instruct:free`  
**Use:** Fast coding, simple scripts, lightweight tasks

### 4. General Purpose Subagent
**Model:** `openrouter/nvidia/nemotron-3-nano-30b-a3b:free`  
**Alias:** `nemotron`  
**Cost:** FREE  
**Fallback:** `openrouter/free`  
**Use:** General tasks, agentic workflows, 256K context

---

## Free Model Registry (All Subagents)

| Model | Alias | Context | Strengths |
|-------|-------|---------|-----------|
| DeepSeek-R1 | `deepseek-r1` | 163K | o1-level reasoning |
| Qwen3-Coder | `qwen-coder` | 262K | Coding specialist |
| Nemotron 3 Nano | `nemotron` | 256K | Agentic AI |
| Llama 3.3 70B | `llama-free` | 128K | Reliable general |
| GLM-4.5 Air | `glm5-free` | 131K | GLM quality |
| OpenRouter Free | `free` | Auto | Best available free |

---

## Usage Pattern

**When spawning subagents:**
```javascript
// Heavy coding - use GLM-5
sessions_spawn(task, { model: 'openrouter/z-ai/glm-5' })

// Research - use free DeepSeek-R1
sessions_spawn(task, { model: 'openrouter/deepseek/deepseek-r1-0528:free' })

// Quick tasks - use free Qwen
sessions_spawn(task, { model: 'openrouter/qwen/qwen3-coder:free' })
```

---

## Cost Optimization

| Task Type | Model | Cost |
|-----------|-------|------|
| Main (You) | Kimi K2.5 | ~$0.80/$2.00 |
| Complex Coding | GLM-5 | $0.60/$1.80 |
| Research | DeepSeek-R1 | FREE |
| Quick Coding | Qwen3-Coder | FREE |
| General | Nemotron | FREE |

**Estimated savings:** 60-70% on subagent costs vs using paid models for all tasks.

---

## Configuration Location

**File:** `~/.openclaw/openclaw.json`  
**Section:** `agents.defaults.subagents`

**Applies:** Next session restart
