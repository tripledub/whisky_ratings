FROM postgres:10.3

COPY docker-healthcheck.sh /usr/local/bin/

COPY docker-entrypoint-initdb.d/ docker-entrypoint-initdb.d/

RUN mkdir /dumps

HEALTHCHECK CMD ["docker-healthcheck.sh"]