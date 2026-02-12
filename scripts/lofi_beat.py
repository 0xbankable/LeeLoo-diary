#!/usr/bin/env python3
"""Simple lofi beat generator using system audio"""
import subprocess
import time
import random

# Simple bass drum pattern (low frequency)
def kick():
    subprocess.run(['say', '-v', 'Fred', '-r', '100', 'bum'], 
                   stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

# Hi-hat (short sharp sound)
def hihat():
    subprocess.run(['say', '-v', 'Fred', '-r', '200', 't'], 
                   stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

# Snare
def snare():
    subprocess.run(['say', '-v', 'Fred', '-r', '120', 'ksh'], 
                   stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

# Ambient pad
def ambient():
    sounds = ['mmm', 'hmm', 'ahh']
    subprocess.run(['say', '-v', 'Fred', '-r', '80', random.choice(sounds)], 
                   stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

def lofi_loop():
    """Classic lofi hip-hop beat pattern"""
    print("🎵 Lofi Leeloo Beats - Press Ctrl+C to stop 🎵\n")
    
    bpm = 70
    beat_time = 60 / bpm
    
    try:
        while True:
            # Bar 1
            kick()
            time.sleep(beat_time)
            hihat()
            time.sleep(beat_time * 0.5)
            snare()
            time.sleep(beat_time * 0.5)
            hihat()
            time.sleep(beat_time)
            
            # Bar 2
            kick()
            time.sleep(beat_time * 0.5)
            kick()
            time.sleep(beat_time * 0.5)
            snare()
            time.sleep(beat_time * 0.5)
            hihat()
            ambient()
            time.sleep(beat_time * 0.5)
            
    except KeyboardInterrupt:
        print("\n\n🛑 Beat stopped. Stay chill. 💛")

if __name__ == "__main__":
    lofi_loop()
