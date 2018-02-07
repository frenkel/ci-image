FROM ubuntu:17.10

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y nodejs ruby-dev bundler build-essential zlib1g-dev libsqlite3-dev libpq-dev libmysqlclient-dev tzdata git ghostscript file imagemagick wget yarn && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
RUN tar -xf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
RUN mv wkhtmltox*/bin/wk* /usr/local/bin/
RUN rm -rf wkhtmltox*

RUN useradd -m ci_user
RUN su - ci_user -c 'bundle config path vendor/bundle'

USER ci_user
WORKDIR /home/ci_user

CMD bash
