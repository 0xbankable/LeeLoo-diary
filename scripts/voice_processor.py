#!/usr/bin/env python3
"""
Converts an incoming OGG voice message file to WAV format for transcription.
This script prioritizes fixing the WAV conversion error for Discord voice input.
Usage: ./scripts/voice_processor.py <input_ogg_path> <output_wav_path>
"""
import subprocess
import sys
import os

def convert_ogg_to_wav(input_path, output_path):
    if not os.path.exists(input_path):
        print(f"Error: Input file not found at {input_path}")
        sys.exit(1)
        
    print(f"Starting conversion: {input_path} -> {output_path}")
    
    # Command to convert OGG (typically Opus codec) to WAV using ffmpeg
    command = [
        '/opt/homebrew/bin/ffmpeg', 
        '-i', input_path, 
        '-map', 'a:0', # Map the first audio stream
        '-acodec', 'pcm_s16le', # PCM 16-bit little-endian for standard WAV compatibility
        '-ar', '16000', # Standard sample rate for speech recognition
        '-ac', '1', # Mono channel
        '-y', # Overwrite output files without asking
        output_path
    ]
    
    try:
        result = subprocess.run(command, check=True, capture_output=True, text=True)
        print("Conversion successful!")
        # Optionally print some ffmpeg output for debugging if needed
        # print(result.stdout) 
        return True
    except subprocess.CalledProcessError as e:
        print(f"FFmpeg Error during conversion:")
        print(f"Stderr: {e.stderr}")
        print(f"Stdout: {e.stdout}")
        return False
    except FileNotFoundError:
        print("Error: ffmpeg command not found. Is it in PATH or correctly linked to /opt/homebrew/bin/ffmpeg?")
        return False

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Incorrect usage: Expected 2 arguments (input OGG path, output WAV path).")
        print(f"Example: {sys.argv[0]} /tmp/in.ogg /tmp/out.wav")
        sys.exit(1)
        
    input_file = sys.argv[1]
    output_file = sys.argv[2]
    
    if convert_ogg_to_wav(input_file, output_file):
        # Success: The file is now ready for the transcription step.
        pass
    else:
        # Failure: The main agent needs to know this conversion failed.
        sys.exit(1)