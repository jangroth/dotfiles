FROM debian:12.13-slim
ENV DEBIAN_FRONTEND=noninteractive

ARG USERNAME=jan
ENV HOME=/home/${USERNAME}

# Locales
ENV LANG="en_US.UTF-8" LC_ALL="en_US.UTF-8" LANGUAGE="en_US.UTF-8"
RUN apt-get update && apt-get install -y \
    curl \
    fd-find \
    fontconfig \
    git \
    gpg \
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

RUN mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://repo.charm.sh/apt/gpg.key | gpg --dearmor -o /etc/apt/keyrings/charm.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" > /etc/apt/sources.list.d/charm.list \
    && apt-get update && apt-get install -y glow \
    && rm -rf /var/lib/apt/lists/*

RUN sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

RUN useradd --create-home --shell /bin/zsh "${USERNAME}" && echo "${USERNAME}:docker" | chpasswd && adduser "${USERNAME}" sudo
USER ${USERNAME}:${USERNAME}
WORKDIR ${HOME}

RUN wget -P "${HOME}/.local/share/fonts" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip \
    && cd "${HOME}/.local/share/fonts" \
    && unzip FiraCode.zip \
    && rm FiraCode.zip \
    && fc-cache -fv

RUN mkdir -p ~/.local/bin \
    && ln -s "$(which fdfind)" ~/.local/bin/fd

RUN touch "${HOME}/.zshrc"

CMD [ "/bin/zsh" ]
