FROM alpine:3.11.3

ARG TF_VERSION=0.12.20

# Required for `terraform init` tasks.
RUN apk add curl

RUN wget -O tf.zip \
    https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip && \
    unzip tf.zip -d /bin && \
    rm -rf tf.zip

VOLUME /tfconfig
WORKDIR /tfconfig

ENTRYPOINT ["terraform"]
CMD ["--help"]

LABEL maintainer="Peter J Langley"
