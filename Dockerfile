FROM rust:1-slim

ARG USERNAME=vscode

RUN rm -f /etc/apt/apt.conf.d/docker-clean && \
    echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && \
    apt-get --no-install-recommends install -y git

RUN addgroup --gid 1000 ${USERNAME} && \
    adduser --uid 1000 --gid 1000 --disabled-password ${USERNAME}

RUN mkdir /workspaces && \
    chown -R ${USERNAME}:${USERNAME} /workspaces

VOLUME [ "/workspaces" ]

USER ${USERNAME}
