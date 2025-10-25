import os
import shutil
import time
from datetime import datetime
import hashlib

# Setări implicite
interval_backup = int(os.getenv("INTERVAL_BACKUP", "5"))
backup_dir = os.getenv("BACKUP_FOLDER", "./backups")
log_path = os.getenv("LOG_FOLDER", "./logs/system-state.log")
state_file = '.last_mtime'
hash_file = '.last_hash'

def get_hash_file(path):
    with open(path, 'rb') as f:
        return hashlib.sha256(f.read()).hexdigest()

def back_up_fisier():
    if not os.path.exists(log_path):
        print("Fișierul system-state.log nu există!")
        return

    os.makedirs(backup_dir, exist_ok=True)
    current_mtime = os.path.getmtime(log_path)
    mtime_datetime = datetime.fromtimestamp(current_mtime)
    formatted_time = mtime_datetime.strftime("%Y-%m-%d %H:%M")
    print(f"Fișierul a fost modificat la: {formatted_time}")

    current_hash = get_hash_file(log_path)

    last_mtime = 0
    last_hash = ""

    if os.path.exists(state_file):
        with open(state_file, 'r') as f:
            last_mtime = float(f.read())

    if os.path.exists(hash_file):
        with open(hash_file, 'r') as f:
            last_hash = f.read().strip()

    if current_mtime != last_mtime and current_hash != last_hash:
        timestamp = mtime_datetime.strftime("%Y%m%d_%H%M")
        backup_filename = f"monitoring_backup_{timestamp}.txt"
        backup_path = os.path.join(backup_dir, backup_filename)

        shutil.copy(log_path, backup_path)
        print(f"Backup-ul a fost creat: {backup_path}")

        with open(state_file, 'w') as f:
            f.write(str(current_mtime))
        with open(hash_file, 'w') as f:
            f.write(current_hash)
    else:
        print("Fișierul nu a fost modificat.")

while True:
    try:
        back_up_fisier()
        time.sleep(interval_backup)
    except Exception as e:
        print(f"Eroare în execuție: {e}")
