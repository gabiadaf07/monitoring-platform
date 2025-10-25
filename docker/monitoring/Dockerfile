# Dockerfile pentru imaginea scriptului de monitorizare bash.
FROM ubuntu:22.04

RUN /app

COPY ../../scripts/monitoring.sh ./

RUN chmod +x monitoring.sh

CMD ["./monitoring.sh"]



 