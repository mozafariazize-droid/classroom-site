FROM python:3.13-slim
WORKDIR /app
RUN apt-get update && apt-get install -y --no-install-recommends unzip && rm -rf /var/lib/apt/lists/*
COPY classroom_site_v16_public.zip /app/classroom_site_v16_public.zip
RUN unzip -q /app/classroom_site_v16_public.zip -d /app && pip install --no-cache-dir -r /app/classroom_site/requirements.txt
WORKDIR /app/classroom_site
ENV PYTHONUNBUFFERED=1
CMD gunicorn --bind 0.0.0.0:${PORT:-10000} app:app
