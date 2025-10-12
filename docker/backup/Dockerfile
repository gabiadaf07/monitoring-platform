# Dockerfile pentru imaginea scriptului de backup Python.
FROM python:3.10-slim

WORKDIR /app

# Copiem fișierele din scripts/
COPY scripts/backup.py .
COPY scripts/backups/ backups/
COPY scripts/logs/ logs/

# Dacă ai requirements.txt
COPY scripts/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Setăm variabilele de mediu
ENV INTERVAL_BACKUP=5
ENV BACKUP_FOLDER=./backups
ENV LOG_FOLDER=./logs

# Asigurăm existența directoarelor
RUN mkdir -p $BACKUP_FOLDER $LOG_FOLDER

CMD ["python3", "backup.py"]
