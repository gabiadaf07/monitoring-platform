#!/bin/bash

# Setăm variabila de mediu cu valoare implicită
INTERVAL="${INTERVAL:-5}"

# Directorul de backup (relativ la root-ul proiectului)
BACKUP_DIR="./logs"
LOG_FILE="$BACKUP_DIR/system-state.log"

# Verificăm dacă directorul de loguri există
if [ ! -d "$BACKUP_DIR" ]; then
    echo "Directorul $BACKUP_DIR nu există. Se creează..."
    mkdir -p "$BACKUP_DIR"
    if [ $? -eq 0 ]; then
        echo "Directorul a fost creat cu succes."
    else
        echo "Eroare la crearea directorului $BACKUP_DIR."
        exit 1
    fi
else
    echo "Logul va fi salvat în: $LOG_FILE"
fi

# Adaugă data și ora în fișierul de log
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

    echo "--- Temperatura CPU ---"
    sensors
} >> "$LOG_FILE"
