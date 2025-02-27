ARG BUILD_FROM=ghcr.io/hassio-addons/base:17.2.1
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install MinIO (pin the version)
ARG MINIO_VERSION="RELEASE.2024-03-21T23-13-43Z"
RUN \
    curl -J -L -o /usr/bin/minio \
        "https://dl.min.io/server/minio/release/linux-amd64/archive/minio.${MINIO_VERSION}" \
    && chmod +x /usr/bin/minio

# Copy root filesystem
COPY rootfs /

# Labels
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Your Name <your@email.com>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Add-ons" \
    org.opencontainers.image.authors="Kalw <hassio@mail.indolore.net>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://github.com/kalw/hassio-addons" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION} 