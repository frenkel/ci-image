FROM ubuntu:20.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y && DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs libnode-dev node-gyp npm ruby-dev bundler build-essential zlib1g-dev libpq-dev libmariadbclient-dev tzdata git ghostscript file imagemagick libmagickwand-dev curl libcurl4-gnutls-dev tnef xfonts-base xfonts-75dpi pkg-config autoconf cmake libxslt1-dev libxml2-dev jq && rm -rf /var/lib/apt/lists/*

# also include bundler 1
RUN gem install bundler -v '~> 1.0'
RUN gem install bundler -v '~> 2.0'
# speedup nokogiri install by using system libraries instead of compiling them during gem install
RUN bundle config build.nokogiri --use-system-libraries

# install Google Chrome, because chromium-browser can only be installed as snap, which requires
# snapd, which requires cgroups, which requires ...
RUN apt-get update && apt-get install -y software-properties-common && rm -rf /var/lib/apt/lists/*
RUN add-apt-repository universe
RUN curl -LO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN apt-get update && apt-get install --fix-broken -y ./google-chrome-stable_current_amd64.deb && rm -rf /var/lib/apt/lists/*
RUN rm google-chrome-stable_current_amd64.deb

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y yarn && rm -rf /var/lib/apt/lists/*

RUN curl -LO https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb
RUN dpkg -i wkhtmltox_0.12.5-1.bionic_amd64.deb
RUN rm -rf wkhtmltox_0.12.5-1.bionic_amd64.deb

RUN useradd -m ci_user
RUN su - ci_user -c 'bundle config path vendor/bundle'

USER ci_user
WORKDIR /home/ci_user

CMD bash
