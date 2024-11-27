ARG DEBIAN_SNAPSHOT=bullseye-20220328

FROM debian/snapshot:${DEBIAN_SNAPSHOT}

ARG TZ=Europe/Berlin
ARG USER=svite

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
  dpkg-reconfigure -f noninteractive locales && \
  echo ': "${LANG:=en_GB.UTF-8}"; export LANG' >> /etc/profile

RUN groupadd --gid 1000 "${USER}" && useradd --uid 1000 --gid "${USER}" --shell /bin/bash --create-home "${USER}"
RUN echo "${USER}:${USER}" | chpasswd
RUN usermod -aG sudo "${USER}"

RUN echo "export LANG=en_GB.UTF-8" >> /home/${USER}/.bashrc

USER ${USER}
WORKDIR /home/${USER}

CMD ["/bin/bash"]
