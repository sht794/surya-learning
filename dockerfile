FROM ubuntu:22.04


WORKDIR /app

COPY ./ /app/

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir -r requirements.txt

ENTRYPOINT [ "python3", "app.py" ]

