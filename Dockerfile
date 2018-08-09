FROM alpine:latest

# dump1090
RUN apk add ncurses-dev git build-base
RUN git clone https://github.com/flightaware/dump1090.git /tmp/dump1090
WORKDIR /tmp/dump1090
RUN make BLADERF=no RTLSDR=no
RUN cp dump1090 view1090 /usr/local/bin/

# re-create the image without all of the build tools/artefacts
FROM nginx:alpine
RUN apk add --no-cache ncurses-libs supervisor socat
COPY --from=0 /usr/local/bin/* /usr/local/bin/
COPY --from=0 /tmp/dump1090/public_html/ /usr/share/nginx/html/
RUN mkdir /usr/share/nginx/html/data

COPY supervisord-*.ini /etc/supervisor.d/
CMD supervisord --configuration /etc/supervisord.conf --nodaemon
