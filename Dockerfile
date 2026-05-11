FROM alpine:latest AS builder

RUN apk add --no-cache \
    curl \
    git \
    ansible

RUN ansible-pull -U https://github.com/xelofan/dotfiles playbook.yml

############################################################################

FROM alpine:latest

RUN apk add --no-cache \
    zsh \
    git \
    curl \
    wget \
    eza \
    zip unzip \
    openssh-client

COPY --from=builder /root/.oh-my-zsh /root/.oh-my-zsh
COPY --from=builder /root/.dotfiles /root/.dotfiles
COPY --from=builder /root/.zshrc /root/.zshrc

ENV SHELL=/bin/zsh

CMD ["zsh"]
