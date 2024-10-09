# Container image that runs your code
FROM alpine:3.19.4
ENV QBEE_CLI_VERSION="v1.2024.41.1"
ENV QBEE_CLI_CHECKSUM="2ea7db61e7442447fd63ae33c9df1e134477f797796d76a7ac13ac5d0817179f"

ADD https://github.com/qbee-io/qbee-cli/releases/download/${QBEE_CLI_VERSION}/qbee-cli-${QBEE_CLI_VERSION}.linux-amd64 \
    /usr/local/bin/

RUN chmod +x /usr/local/bin/qbee-cli-${QBEE_CLI_VERSION}.linux-amd64 && \
    ln -s /usr/local/bin/qbee-cli-${QBEE_CLI_VERSION}.linux-amd64 /usr/local/bin/qbee-cli

RUN echo "${QBEE_CLI_CHECKSUM}  /usr/local/bin/qbee-cli" | sha256sum -c -

    # Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["sh", "/entrypoint.sh"]
