# ==============================
# Stage-1
# ==============================
FROM debian:latest as debian-user

ARG DEBIAN_FRONTEND=noninteractive
ARG USER_NAME=nobody
ARG GROUP_NAME=nogroup
# ARG PASSWORD=${USER_NAME}
ARG USER_ID=1000
ARG GROUP_ID=${USER_ID}

SHELL ["/usr/bin/bash", "-ecx"]

# ==============================
# Update apt config
# ==============================
RUN echo "APT::Install-Recommends false;" > /etc/apt/apt.conf.d/00-install-recommends && \
    echo "APT::Install-Suggests false;" > /etc/apt/apt.conf.d/00-install-suggests

# ==============================
# Update package list
# ==============================
RUN apt update

# ==============================
# Create general user
# ==============================
RUN if [ ! "${USER_NAME}" = "nobody" ]; \
    then \
        apt install -y sudo && \
        groupadd -g ${GROUP_ID} ${GROUP_NAME} && \
        useradd -u ${USER_ID} -g ${GROUP_ID} --groups sudo -s /usr/bin/bash -m ${USER_NAME} && \
        # useradd -u ${USER_ID} -g ${GROUP_ID} --groups sudo -s /usr/bin/bash ${USER_NAME} && \
        echo "${USER_NAME} ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers.d/${USER_NAME} && \
        chmod 440 /etc/sudoers.d/${USERNAME}; \
    fi;


# ==============================
# Stage-2
# ==============================
FROM debian-user as hugo-dev

ARG USER_HOME=/home/${USER_NAME}
# ARG GO_VERSION=1.21.3
# ARG DART_SASS_VERSION=1.69.5
ARG HUGO_VERSION=0.120.3

SHELL ["/usr/bin/bash", "-ecx"]

USER ${USER_NAME}
WORKDIR ${USER_HOME}

# ==============================
# Install dependencies
# ==============================
# ENV PATH=${PATH}:/usr/local/go/bin
# RUN sudo -E apt install -y curl \
#                            wget \
#                            zip \
#                            unzip \
#                            git-all && \
#     rm -rf /usr/local/go && \
#     wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz && \
#     tar -xvzf go${GO_VERSION}.linux-amd64.tar.gz && \
#     sudo cp -rfv go /usr/local && \
#     rm -rf go \
#            go${GO_VERSION}.linux-amd64.tar.gz && \
#     wget https://github.com/sass/dart-sass/releases/download/${DART_SASS_VERSION}/dart-sass-${DART_SASS_VERSION}-linux-x64.tar.gz && \
#     tar -xvzf dart-sass-${DART_SASS_VERSION}-linux-x64.tar.gz && \
#     sudo cp -rfv dart-sass/* /usr/local/bin && \
#     rm -rf dart-sass \
#            dart-sass-${DART_SASS_VERSION}-linux-x64.tar.gz
RUN sudo -E apt install -y curl \
                           wget \
                           zip \
                           unzip \
                           git-all

# ==============================
# Install Hugo
# ==============================
RUN wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.deb && \
    sudo -E apt install -y ./hugo_extended_${HUGO_VERSION}_linux-amd64.deb && \
    rm -rf hugo_extended_${HUGO_VERSION}_linux-amd64.deb

# ==============================
# Purge unused packages
# ==============================
RUN sudo -E apt update && \
    sudo -E apt full-upgrade -y && \
    sudo -E apt autopurge -y && \
    sudo -E apt autoclean && \
    sudo rm -rf /var/lib/apt/lists