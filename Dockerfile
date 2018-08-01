FROM ubuntu:18.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y && DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs npm ruby-dev bundler build-essential zlib1g-dev libsqlite3-dev libpq-dev libmysqlclient-dev tzdata git ghostscript file imagemagick curl libcurl4-openssl-dev tnef chromium-browser xfonts-base xfonts-75dpi && rm -rf /var/lib/apt/lists/*

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y yarn && rm -rf /var/lib/apt/lists/*

RUN curl -Lo wkhtmltox_0.12.5-1.bionic_amd64.deb https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb
RUN dpkg -i wkhtmltox_0.12.5-1.bionic_amd64.deb
RUN rm -rf wkhtmltox*

RUN useradd -m ci_user
RUN su - ci_user -c 'bundle config path vendor/bundle'

USER ci_user
WORKDIR /home/ci_user

CMD bash
