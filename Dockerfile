FROM python:3.11-slim

WORKDIR /opt/app-root/src
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app.py .
EXPOSE 8000
ENV PORT=8000
CMD ["python", "app.py"]
