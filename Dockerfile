ARG SERVER_ROOT=/srv/app
ARG RUBY_VERSION=2.6.6

FROM ruby:${RUBY_VERSION}-alpine AS gem
ARG SERVER_ROOT

RUN apk add --no-cache postgresql-dev build-base ca-certificates zlib-dev libressl-dev git

RUN mkdir -p ${SERVER_ROOT}
COPY Gemfile Gemfile.lock ${SERVER_ROOT}/

WORKDIR ${SERVER_ROOT}
RUN gem install bundler:2.1.4 \
    && bundle config --local deployment 'true' \
    && bundle config --local frozen 'true' \
    && bundle config --local no-cache 'true' \
    && bundle config --local system 'true' \
    && bundle config --local without 'development test' \
    && bundle install -j "$(getconf _NPROCESSORS_ONLN)" \
    && find /${SERVER_ROOT}/vendor/bundle -type f -name '*.c' -delete \
    && find /${SERVER_ROOT}/vendor/bundle -type f -name '*.o' -delete \
    && find /usr/local/bundle -type f -name '*.c' -delete \
    && find /usr/local/bundle -type f -name '*.o' -delete \
    && rm -rf /usr/local/bundle/cache/*.gem

FROM ruby:${RUBY_VERSION}-alpine
ARG SERVER_ROOT

RUN apk add --no-cache tzdata libstdc++ git postgresql-libs

RUN adduser -h ${SERVER_ROOT} -D -s /bin/nologin rails rails

COPY --from=gem /usr/local/bundle/config /usr/local/bundle/config
COPY --chown=rails:rails --from=gem /usr/local/bundle /usr/local/bundle
COPY --chown=rails:rails --from=gem /${SERVER_ROOT}/vendor/bundle /${SERVER_ROOT}/vendor/bundle

RUN mkdir -p ${SERVER_ROOT}

ENV RAILS_ENV=production
ENV RAILS_LOG_TO_STDOUT=true
ENV SERVER_ROOT=$SERVER_ROOT

COPY --chown=rails:rails . ${SERVER_ROOT}

USER rails
WORKDIR ${SERVER_ROOT}

EXPOSE 3000
ENTRYPOINT ["bin/entrypoint"]
CMD ["server"]
