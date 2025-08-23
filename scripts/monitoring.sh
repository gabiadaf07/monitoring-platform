#!/bin/bash

#Setam variabila de mediu cu valoare implicita
INTERVAL="${INTERVAL:-5}"

# Fișierul în care se salvează log-urile
LOG_FILE="/home/admin0103/source/logs/system-state.log"
echo "Log salvat in: $LOG_FILE"

# Adaugă data și ora
echo "=== $(date) ===" >> "$LOG_FILE"

# Scrie log-urile în fișier
{
    echo "--- top ---"
    top -b -n 1 | head -n 10

    echo "--- lscpu ---"
    lscpu | tail -n 10

    echo "--- fdisk ---"
    fdisk -l

    echo "--- free ---"
    free -h

    echo "--- Temperatura CPU----"
    sensors

} > "$LOG_FILE"

