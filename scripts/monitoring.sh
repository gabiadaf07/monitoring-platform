#!/bin/bash

# Setăm variabila de mediu cu valoare implicită
INTERVAL="${INTERVAL:-5}"

# Directorul de backup (relativ la root-ul proiectului)
BACKUP_DIR="/home/admin0103/source/monitoring-platform/scripts/logs"
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
while true; do
    # Suprascrie fișierul la fiecare rulare
    {
        echo "=== $(date) ==="
        echo "--- Hostname ---"
        hostname

        echo "--- Uptime ---"
        uptime

        echo "--- CPU Usage ---"
        top -b -n 1 | head -n 10

        echo "--- Memory Usage ---"
        free -h

        echo "--- Disk Usage ---"
        df -h

        echo "--- Active Processes ---"
        ps -e --no-headers | wc -l

        echo "--- CPU Info ---"
        lscpu | tail -n 10

        echo "--- Disk Info ---"
        fdisk -l

        echo "--- CPU Temperature ---"
        sensors
    } > "$LOG_FILE"

    sleep "$INTERVAL"
done
