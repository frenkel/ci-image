FROM ubuntu:17.10

RUN apt-get update
RUN apt-get install -y nodejs ruby-dev bundler build-essential zlib1g-dev libsqlite3-dev libpq-dev libmysqlclient-dev tzdata
CMD bash
