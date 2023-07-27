FROM ubuntu:22.04

COPY squid.conf /usr/local/squid/etc/squid.conf

RUN set -x \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y curl build-essential libssl-dev ca-certificates \
    && cd /tmp \
    && curl -OL http://www.squid-cache.org/Versions/v6/squid-6.1.tar.gz \
    && tar xzvf squid-6.1.tar.gz \
    && cd squid-6.1 \
    && ./configure --with-default-user=proxy --with-openssl --enable-ssl-crtd \
    && make -j12 \
    && make install \
    && rm -rf /tmp/* \
    && chown -R proxy:proxy /usr/local/squid \
    && apt-get purge --no-install-recommends --no-install-suggests -y curl build-essential \
    && apt-get autoremove --no-install-recommends --no-install-suggests -y

EXPOSE 3128

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
