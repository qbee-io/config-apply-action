# Container image that runs your code
FROM alpine:3.19.1
ENV QBEE_CLI_VERSION="v1.2024.24"
ENV QBEE_CLI_CHECKSUM="555dbc6ca1f4c7ed3dc06c86e0c6bc1fde2931e74b671a269a278add8419fc47"

ADD https://github.com/qbee-io/qbee-cli/releases/download/${QBEE_CLI_VERSION}/qbee-cli-${QBEE_CLI_VERSION}.linux-amd64 \
    /usr/local/bin/

RUN chmod +x /usr/local/bin/qbee-cli-${QBEE_CLI_VERSION}.linux-amd64 && \
    ln -s /usr/local/bin/qbee-cli-${QBEE_CLI_VERSION}.linux-amd64 /usr/local/bin/qbee-cli

RUN echo "${QBEE_CLI_CHECKSUM}  /usr/local/bin/qbee-cli" | sha256sum -c -

    # Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["sh", "/entrypoint.sh"]
