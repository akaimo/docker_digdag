FROM openjdk:8-jdk

ARG DIGDAG_VERSION=0.9.37

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

ENV PYTHON_VERSION 3.6.8
ENV PYTHON_ROOT $HOME/local/python-$PYTHON_VERSION
ENV PATH $PYTHON_ROOT/bin:$PATH
ENV PYENV_ROOT $HOME/.pyenv

ENV POSTGRES_USER=digdag \
    POSTGRES_PASSWORD=digdag \
    POSTGRES_HOST=postgresql \
    POSTGRES_PORT=5432 \
    POSTGRES_DB=digdag \
    ENCRYPTION_KEY=MDEyMzQ1Njc4OTAxMjM0NQ==

ENV TZ Asia/Tokyo

RUN set -x \
  && apt-get update \
  && apt-get install -y \
      curl \
      netcat \
      gettext-base \
  && rm -rf /var/lib/apt/lists/*

RUN set -x \
  && curl -o /usr/local/bin/digdag --create-dirs \
      -L "https://dl.digdag.io/digdag-${DIGDAG_VERSION}" \
  && chmod +x /usr/local/bin/digdag

RUN set -x \
  && apt-get update \
  && apt-get install -y \
      git \
      make \
      build-essential \
      libssl-dev \
      zlib1g-dev \
      libbz2-dev \
      libreadline-dev \
      libsqlite3-dev \
      wget \
      curl \
      llvm \
      libncurses5-dev \
      libncursesw5-dev \
      xz-utils \
      tk-dev \
      libffi-dev \
      liblzma-dev \
  && git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT \
  && $PYENV_ROOT/plugins/python-build/install.sh \
  && /usr/local/bin/python-build -v $PYTHON_VERSION $PYTHON_ROOT \
  && rm -rf $PYENV_ROOT \
  && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /requirements.txt
COPY entrypoint.sh /usr/local/bin
COPY server.properties /etc/digdag/server.properties

RUN set -x \
  && pip install -r requirements.txt \
  && chmod +x /usr/local/bin/entrypoint.sh

ENV DOCKER_CLIENT_VERSION 1.12.6

RUN set -x \
  && curl -fsSL https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_CLIENT_VERSION}.tgz \
  | tar -xzC /usr/local/bin --strip=1 docker/docker

EXPOSE 65432 65433

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/usr/local/bin/digdag", "server", "--config", "/etc/digdag/server.properties"]
