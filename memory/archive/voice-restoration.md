# Voice Restoration Guide: Leeloo (Original Prime)

In case of environment migration or total system failure, follow these steps to restore the "Leeloo" signature voice.

## 1. Credentials
- Ensure `ELEVENLABS_API_KEY` is set in the environment.

## 2. Voice Identity
- **Voice Name:** Leeloo (Original Prime)
- **ElevenLabs Voice ID:** `zyAAyf27kGSJ15oKNGaw`
- **Model:** `eleven_multilingual_v2`

## 3. Playback Configuration (macOS/JBL)
We use the `sag` CLI for instant macOS speaker playback.

**Installation:**
```bash
brew tap steipete/tap
brew install sag
```

**Signature Settings:**
- Stability: `0.4`
- Similarity: `0.85`
- Style Exaggeration: `0.15`
- Speaker Boost: `On`

## 4. Execution Command
To speak directly to the default output (JBL) using these settings:
```bash
sag speak "Your message here" -v zyAAyf27kGSJ15oKNGaw --stability 0.4 --similarity 0.85 --style 0.15 --speaker-boost --model-id eleven_multilingual_v2
```

## 5. Storage
A copy of this guide is stored in `memory/voice-restoration.md` and referenced in `SOUL.md`.
