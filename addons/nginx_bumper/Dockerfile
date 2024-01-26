ARG BUILD_FROM
FROM $BUILD_FROM

# Setup base
RUN apk add --no-cache nginx openssl nginx-mod-stream

COPY nginx.conf /etc/nginx
COPY run.sh /
RUN chmod a+x /run.sh

CMD ["/run.sh"]

