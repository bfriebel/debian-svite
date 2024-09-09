ARG DEBIAN_SNAPSHOT=bullseye-20220328

FROM debian/snapshot:${DEBIAN_SNAPSHOT}


# --- buildpack-deps:bullseye-curl ---

RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg \
    netbase \
    wget \
  ; \
  rm -rf /var/lib/apt/lists/*


RUN set -ex; \
  apt-get update; \
  apt-get install -y \
    build-essential \
    git \
    git-lfs \
    p7zip-full \
  ; \
  rm -rf /var/lib/apt/lists/*
