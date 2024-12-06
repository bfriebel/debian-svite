ARG DEBIAN_SNAPSHOT=bullseye-20220328

FROM debian/snapshot:${DEBIAN_SNAPSHOT}

ARG TZ=Europe/Berlin
ARG WORKSPACE_USER=svite

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

# --- custom ---
RUN set -ex; \
    apt-get update; \
    apt-get install -y \
        sudo \
        locales \
        bash-completion \
        build-essential \
        nano \
        tree \
        git \
        git-lfs \
        p7zip-full \
        ; \
    rm -rf /var/lib/apt/lists/*

# set locale according to https://serverfault.com/a/689947 (https://web.archive.org/web/20240912091718/https://serverfault.com/questions/362903/how-do-you-set-a-locale-non-interactively-on-debian-ubuntu/689947#689947) 
# BUT follow recommendations for usage with ssh from https://wiki.debian.org/Locale#Standard (https://web.archive.org/web/20240912091751/https://wiki.debian.org/Locale#Standard)
RUN cp -f /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo "${TZ}" > /etc/timezone && \
    sed -i -e 's/# en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i -e 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure -f noninteractive locales && \
    echo ': "${LANG:=en_GB.UTF-8}"; export LANG' >> /etc/profile

RUN groupadd --gid 1000 "${WORKSPACE_USER}" && useradd --uid 1000 --gid "${WORKSPACE_USER}" --shell /bin/bash --create-home "${WORKSPACE_USER}"
RUN echo "${WORKSPACE_USER}:${WORKSPACE_USER}" | chpasswd
RUN usermod -aG sudo "${WORKSPACE_USER}"

VOLUME [ "/home/${WORKSPACE_USER}" ]

RUN echo "export LANG=en_GB.UTF-8" >> "/home/${WORKSPACE_USER}/.bashrc" \
    && echo "export LC_ALL=de_DE.UTF-8" >> "/home/${WORKSPACE_USER}/.bashrc"

USER ${WORKSPACE_USER}
WORKDIR /home/${WORKSPACE_USER}

CMD [ "/bin/bash" ]
