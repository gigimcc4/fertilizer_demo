# one python image for soft_plc, plant_sim, edge_poller and the chat page.
# packages come from requirements.lock.txt, so everyone gets the same versions.
FROM python:3.13.13-slim

ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

WORKDIR /app
COPY requirements.lock.txt .
RUN pip install -r requirements.lock.txt

COPY . .
EXPOSE 8600
CMD ["python", "edge_poller.py"]
