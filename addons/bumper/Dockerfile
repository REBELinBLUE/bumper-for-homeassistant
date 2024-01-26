
ARG FROM_ARCH=arm64v8
ARG BUILD_FROM
FROM $BUILD_FROM as builder
ARG BUILD_ARCH
ARG S6_OVERLAY_VERSION=3.1.6.2


# Download QEMU, see https://github.com/ckulka/docker-multi-arch-example
ADD https://github.com/balena-io/qemu/releases/download/v3.0.0%2Bresin/qemu-3.0.0+resin-arm.tar.gz .
RUN tar zxvf qemu-3.0.0+resin-arm.tar.gz --strip-components 1
ADD https://github.com/balena-io/qemu/releases/download/v3.0.0%2Bresin/qemu-3.0.0+resin-aarch64.tar.gz .
RUN tar zxvf qemu-3.0.0+resin-aarch64.tar.gz --strip-components 1

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-${BUILD_ARCH}.tar.xz /tmp
RUN mkdir /tmp/untar
RUN tar -C /tmp/untar -Jxpf /tmp/s6-overlay-${BUILD_ARCH}.tar.xz

FROM $FROM_ARCH/python:3.7-alpine as base

# Add QEMU
# Add QEMU
COPY --from=builder qemu-arm-static /usr/bin
COPY --from=builder qemu-aarch64-static /usr/bin
COPY --from=builder /tmp/untar/* /
FROM base as builderfinal

# add build utils (gcc, others)
RUN apk add build-base

FROM base

COPY requirements.txt /requirements.txt

# install required python packages
RUN pip3 install -r requirements.txt

WORKDIR /bumper

# Copy only required folders instead of all
COPY create_certs create_certs/ 
COPY bumper bumper/
COPY certs certs/
COPY run.sh .  
RUN chmod a+x run.sh

CMD [ "/bin/sh", "/bumper/run.sh" ]
