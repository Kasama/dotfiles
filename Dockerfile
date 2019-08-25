FROM ubuntu:eoan

WORKDIR /root

ENV TERM=xterm-256color

RUN apt-get update && \
    apt-get install -y git nodejs npm curl python3 python3-pip tmux

RUN curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz | tar xzf - -C /usr --strip-components 1 && \
    git clone http://github.com/Kasama/dotfiles --recurse-submodules --depth=1 && \
    python ~/dotfiles/dotty/dotty.py ~/dotfiles/dottyrc.json

RUN npm install -g neovim && \
    pip3 install neovim

CMD [ "tmux" ]
