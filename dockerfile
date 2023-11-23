FROM debian:latest as hugo-dev

ARG DEBIAN_FRONTEND=noninteractive
SHELL ["/usr/bin/bash", "-ecx"]
WORKDIR /usr/local/share

# ==============================
# Update apt config
# ==============================
RUN echo "APT::Install-Recommends false;" > /etc/apt/apt.conf.d/00-install-recommends && \
    echo "APT::Install-Suggests false;" > /etc/apt/apt.conf.d/00-install-suggests && \
    apt update

# ==============================
# Install dependencies
# ==============================
RUN apt install -y curl \
                   wget \
                   zip \
                   unzip \
                   git-all

# ==============================
# Install Hugo
# ==============================
ARG HUGO_VERSION=0.120.3
RUN wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.deb && \
    apt install -y ./hugo_extended_${HUGO_VERSION}_linux-amd64.deb && \
    rm -rf ./hugo_extended_${HUGO_VERSION}_linux-amd64.deb

# ==============================
# Purge unused packages
# ==============================
RUN apt update && \
    apt full-upgrade -y && \
    apt autopurge -y && \
    apt autoclean && \
    rm -rf /var/lib/apt/lists