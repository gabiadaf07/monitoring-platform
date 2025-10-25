FROM python:3.10-slim

WORKDIR /app

COPY ../../scripts/backup.py ./
COPY ../../requirements.txt ./

# Instalăm compilatorul și librăriile necesare
RUN apt-get update && apt-get install -y gcc python3-dev

# Instalăm pachetele Python
RUN pip install --no-cache-dir -r requirements.txt

ENV INTERVAL_BACKUP=5
ENV BACKUP_FOLDER=./backups
ENV LOG_FOLDER=./logs/system-state.log

CMD ["python3", "backup.py"]
