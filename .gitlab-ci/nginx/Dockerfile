ARG NGINX_VERSION=1.19

FROM nginx:$NGINX_VERSION-alpine-perl

RUN apk add --no-cache nginx-mod-http-perl

RUN chown -R nginx:nginx /etc/nginx/conf.d
RUN rm -rf /usr/share/nginx/html/index.html

USER nginx

COPY .gitlab-ci/nginx/nginx.conf /etc/nginx/nginx.conf
COPY .gitlab-ci/nginx/templates /etc/nginx/templates
COPY public/ /usr/share/nginx/html

ENV PUBLIC_PORT=80
