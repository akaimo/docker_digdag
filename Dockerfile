FROM openjdk:8-jdk

ARG DIGDAG_VERSION=0.9.37

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

ENV POSTGRES_USER=digdag \
    POSTGRES_PASSWORD=digdag \
    POSTGRES_HOST=postgresql \
    POSTGRES_PORT=5432 \
    POSTGRES_DB=digdag \
    ENCRYPTION_KEY=MDEyMzQ1Njc4OTAxMjM0NQ==

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


