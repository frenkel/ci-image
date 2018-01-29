FROM ubuntu:17.10

RUN apt-get update

RUN apt-get install -y nodejs ruby-dev bundler build-essential zlib1g-dev libsqlite3-dev libpq-dev libmysqlclient-dev tzdata git ghostscript file imagemagick wget

RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
RUN tar -xf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
RUN mv wkhtmltox*/bin/wk* /usr/local/bin/
RUN rm -rf wkhtmltox*

RUN useradd -m ci_user
USER ci_user
WORKDIR /home/ci_user

CMD bash
