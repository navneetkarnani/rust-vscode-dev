FROM rust:1-slim

ARG USERNAME=vscode
ARG USER_ID=1000
ARG GROUP_ID=1000

RUN addgroup --gid ${GROUP_ID} ${USERNAME} && \
    adduser --uid ${USER_ID} --gid ${GROUP_ID} --disabled-password ${USERNAME}

RUN mkdir /workspaces && \
    chown -R ${USERNAME}:${USERNAME} /workspaces

VOLUME [ "/workspaces" ]

RUN rustup component add clippy rustfmt rust-docs

RUN apt-get update && \
    apt-get --no-install-recommends install -y git curl && \
    apt-get autoremove && \
    apt-get clean

USER ${USERNAME}
