FROM ubuntu:17.10

RUN apt-get update && apt-get install -y nodejs npm ruby-dev bundler build-essential zlib1g-dev libsqlite3-dev libpq-dev libmysqlclient-dev tzdata git ghostscript file imagemagick curl libcurl4-openssl-dev tnef chromium-browser git && rm -rf /var/lib/apt/lists/*

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y yarn && rm -rf /var/lib/apt/lists/*

RUN curl -Lo wkhtmltox-0.12.4_linux-generic-amd64.tar.xz https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
RUN tar -xf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
RUN mv wkhtmltox*/bin/wk* /usr/local/bin/
RUN rm -rf wkhtmltox*

RUN useradd -m ci_user
RUN su - ci_user -c 'bundle config path vendor/bundle'

USER ci_user
WORKDIR /home/ci_user

CMD bash
