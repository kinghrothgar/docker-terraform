ARG TERRAFORM_VER=1.1.0
ARG ALPINE_VER=3.15

FROM alpine:$ALPINE_VERS as base

FROM base AS base-amd64
ARG TERRAFORM_VER
ARG ALPINE_VER
ENV TERRAFORM_URL=https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/terraform_${TERRAFORM_VER}_linux_amd64.zip

FROM base AS base-arm64
ARG TERRAFORM_VER
ARG ALPINE_VER
ENV TERRAFORM_URL=https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/terraform_${TERRAFORM_VER}_linux_arm64.zip

FROM base-$TARGETARCH

RUN wget $TERRAFORM_URL -O terraform.zip \
 && unzip terraform.zip \
 && mv terraform /bin \
 && rm terraform.zip
