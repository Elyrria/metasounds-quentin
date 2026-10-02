FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Dépendances d'abord, pour profiter du cache Docker
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY server.py .
COPY streams/ streams/

# Utilisateur non-root
RUN useradd --create-home appuser
USER appuser

EXPOSE 8080

CMD ["python", "server.py"]
