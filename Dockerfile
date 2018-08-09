# docker run -it -p 4096:4096 zjb0807/asch bash
FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install curl sqlite3 ntp wget git libssl-dev openssl make gcc g++ autoconf automake python build-essential -y && \
    apt-get install libtool libtool-bin -y && \
    apt-get install vim jq -y

ENV USER asch
ENV NODE_VERSION v8
# create user
RUN adduser --disabled-password --gecos '' $USER

# switch user
USER $USER
WORKDIR /home/$USER
ENV HOME /home/$USER
ENV NVM_DIR $HOME/.nvm

# install nodejs
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash && \
    . ~/.nvm/nvm.sh && \
    nvm install $NODE_VERSION

# git clone asch sourece code
RUN git clone https://github.com/AschPlatform/asch && cd asch && chmod u+x aschd && \
    . ~/.nvm/nvm.sh && \
    npm install

# git clone asch-cli sourece code
RUN git clone https://github.com/AschPlatform/asch-cli && cd asch-cli && \
    . ~/.nvm/nvm.sh && \
    npm install

# git clone asch-frontend sourece code
RUN . ~/.nvm/nvm.sh && \
    npm install -g yarn && npm install -g quasar-cli && \
    git clone https://github.com/AschPlatform/asch-frontend-2.git && cd asch-frontend-2 && \
    #git clone -b develop https://github.com/AschPlatform/asch-frontend-2.git && cd asch-frontend-2 && \
    yarn install

WORKDIR /home/$USER/asch

CMD ["node", "app.js"]
