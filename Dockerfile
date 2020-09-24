FROM docker.io/ubuntu:18.04

COPY src/setup-git-crypt.sh /src/setup-git-crypt.sh

RUN apt-get update \
    && apt-get install -y \
      build-essential \
      curl \
      libssl-dev \
      make \
    && apt-get clean

ENTRYPOINT bash /src/setup-git-crypt.sh