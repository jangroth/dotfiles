FROM debian:12.13-slim
ENV DEBIAN_FRONTEND=noninteractive

# Locales
ENV LANG="en_US.UTF-8" LC_ALL="en_US.UTF-8" LANGUAGE="en_US.UTF-8"
RUN apt-get update && apt-get install -y \
    bat \
    curl \
    fd-find \
    fontconfig \
    git \
    locales \
    make \
    python3 \
    shellcheck \
    shfmt \
    tmux \
    tree \
    unzip \
    vim \
    wget \
    zsh \
    && locale-gen en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

RUN sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes

RUN useradd --create-home --shell /bin/zsh jan && echo "jan:docker" | chpasswd && adduser jan sudo
USER jan:jan
WORKDIR /home/jan

RUN wget -P /home/jan/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip \
    && cd /home/jan/.local/share/fonts \
    && unzip FiraCode.zip \
    && rm FiraCode.zip \
    && fc-cache -fv

RUN mkdir -p ~/.local/bin \
    && ln -s $(which fdfind) ~/.local/bin/fd \
    && ln -s $(which batcat) ~/.local/bin/bat

RUN touch /home/jan/.zshrc

CMD [ "/bin/zsh" ]
