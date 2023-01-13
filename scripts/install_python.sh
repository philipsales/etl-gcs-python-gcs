#!/bin/bash

## Tested on 
# Ubuntu            | 18.04    |

#Installing Repsoitory 
sudo apt-get update -y
sudo apt-get install -y python3-pip

#Install Pyenv
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
exec "$SHELL"

# Install Pyenv as source in .bashrc
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
source ~/.bashrc

# Install Python dependencies and specific version 
sudo apt-get install -y \
    build-essential \
    git \
    libreadline-dev \
    zlib1g-dev \
    libssl-dev \
    libbz2-dev \
    libsqlite3-dev

pyenv install 3.6.2
pyenv global 3.6.2                 
pyenv virtualenv  openrefine-python3.6_env