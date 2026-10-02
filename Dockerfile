FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Correctifs de sécurité des paquets système
RUN apt-get update \
    && apt-get upgrade -y \
    && rm -rf /var/lib/apt/lists/*

# Dépendances d'abord, pour profiter du cache Docker
# setuptools et wheel ne servent pas à l'exécution et embarquent des CVE
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt \
    && pip uninstall -y setuptools wheel

COPY server.py .
COPY streams/ streams/

# Utilisateur non-root
RUN useradd --create-home appuser
USER appuser

EXPOSE 8080

CMD ["python", "server.py"]
