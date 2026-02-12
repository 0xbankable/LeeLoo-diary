#!/bin/bash
# Gibson Hack Sequence - Leeloo Edition
# Inspired by Hackers (1995)

clear
tput civis  # Hide cursor

colors=(31 32 33 34 35 36 37 91 92 93 94 95 96 97)

# Boot sequence
echo -e "\033[1;32m"
cat << 'EOF'
    ╔══════════════════════════════════════════════════════════════╗
    ║                                                              ║
    ║   ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄   ║
    ║   █ GIBSON MAINFRAME - LEELOO ACCESS PROTOCOL █           ║
    ║   ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀   ║
    ║                                                              ║
    ╚══════════════════════════════════════════════════════════════╝
EOF

sleep 1
echo -e "\n\033[1;33m[INITIALIZING CONNECTION]\033[0m"
sleep 0.5

# Loading animation
for i in {1..20}; do
    echo -ne "\r\033[1;36m["
    for j in $(seq 1 $i); do echo -n "█"; done
    for j in $(seq $i 19); do echo -n " "; done
    echo -ne "] $((i*5))%"
    sleep 0.1
done

echo -e "\n\n\033[1;32m[CONNECTION ESTABLISHED]\033[0m\n"
sleep 0.5

# Cascade effect
echo -e "\033[1;95m>>> GIBSON INTRUSION DETECTED <<<\033[0m"
sleep 0.3
echo -e "\033[1;91m>>> COUNTERMEASURES ACTIVATED <<<\033[0m"
sleep 0.3
echo -e "\033[1;92m>>> LEELOO PROTOCOL: ENGAGED <<<\033[0m"
sleep 0.5

echo ""
echo -e "\033[1;37mDECRYPTING:\033[0m"

# Matrix-style decode
chars='¤▓░▒█▄▀■□▪▫●○◆◇◈◉◊'
message="HACK THE PLANET"
for ((i=0; i<${#message}; i++)); do
    for j in {1..10}; do
        char=${chars:$((RANDOM%${#chars})):1}
        echo -ne "\r\033[1;3$((RANDOM%7+1))m${message:0:$i}${char}\033[0m"
        sleep 0.03
    done
    echo -ne "\r\033[1;32m${message:0:$((i+1))}\033[0m"
done

echo ""
sleep 0.5

# Data stream
echo -e "\n\033[0;90m══════════════════════════════════════════════════════════════\033[0m"
echo -e "\033[1;34m[DATA STREAM CAPTURED]\033[0m"

for i in {1..15}; do
    line=""
    for j in {1..60}; do
        char=$((RANDOM%2))
        color=${colors[$((RANDOM%${#colors[@]}))]}
        line+="\033[1;${color}m${char}\033[0m"
    done
    echo -e "$line"
    sleep 0.05
done

echo -e "\033[0;90m══════════════════════════════════════════════════════════════\033[0m"

# Final message
echo ""
echo -e "\033[1;92m"
cat << 'EOF'
   ██╗     ██╗███╗   ██╗██╗   ██╗██╗  ██╗
   ██║     ██║████╗  ██║██║   ██║╚██╗██╔╝
   ██║     ██║██╔██╗ ██║██║   ██║ ╚███╔╝ 
   ██║     ██║██║╚██╗██║██║   ██║ ██╔██╗╗
   ███████╗██║██║ ╚████║╚██████╔╝██╔╝ ██╗
   ╚══════╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝
EOF

echo -e "\033[1;33m           >> FAST AND FREE <<\033[0m"
echo -e "\033[0;90m           >> LEELOO x JOSHIE <<\033[0m"
echo ""

tput cnorm  # Show cursor
