FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /root

# Locales
RUN apt-get update && apt-get install -y locales
ENV LANG="en_US.UTF-8" LC_ALL="en_US.UTF-8" LANGUAGE="en_US.UTF-8"
RUN command locale-gen en_US.UTF-8

RUN apt-get install -y \
    curl \
    fontconfig \
    git \
    tmux \
    tree \
    vim \
    unzip \
    wget \
    zsh


RUN sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes

RUN useradd --create-home --shell /bin/zsh jan && echo "jan:docker" | chpasswd && adduser jan sudo
USER jan:jan

RUN wget -P /home/jan/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip \
    && cd /home/jan/.local/share/fonts \
    && unzip FiraCode.zip \
    && rm FiraCode.zip \
    && fc-cache -fv

CMD [ "/bin/zsh" ]
WORKDIR /home/jan
