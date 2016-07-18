FROM alpine:3.3

ENV LANG en_US.UTF-8

# used to interpolate the version in the urls below
ENV ELIXIR_VERSION 1.3.2

# set the workdir and add app code to container
WORKDIR /code
ADD . /code



# erlang related dependencies
RUN apk --update add build-base \
                     ca-certificates \
                     erlang \
                     erlang-crypto \
                     erlang-syntax-tools \
                     erlang-parsetools \
                     erlang-inets \
                     erlang-ssl \
                     erlang-public-key \
                     erlang-eunit \
                     erlang-asn1 \
                     erlang-sasl \
                     erlang-erl-interface \
                     erlang-dev \
                     git \
                     inotify-tools \
                     postgresql-client \
                     nodejs \
                     wget && \
    rm -rf /var/cache/apk/* && \
    update-ca-certificates


# Elixir related dependencies
RUN apk --update add --virtual build-dependencies wget ca-certificates && \
    wget https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip && \
    mkdir -p /opt/elixir-${ELIXIR_VERSION}/ && \
    unzip Precompiled.zip -d /opt/elixir-${ELIXIR_VERSION}/ && \
    rm Precompiled.zip && \
    apk del build-dependencies && \
    rm -rf /etc/ssl && \
    rm -rf /var/cache/apk/*

# add Elixir to $PATH
ENV PATH $PATH:/opt/elixir-${ELIXIR_VERSION}/bin

# install/update hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix hex.info

# get and install Phoenix
RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez