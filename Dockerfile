ARG TERRAFORM_VER
ARG ALPINE_VER

FROM alpine:$ALPINE_VER as base

FROM base AS base-amd64
ARG TERRAFORM_VER
ARG ALPINE_VER
ENV TERRAFORM_URL=https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/terraform_${TERRAFORM_VER}_linux_amd64.zip

FROM base AS base-arm64
ARG TERRAFORM_VER
ARG ALPINE_VER
ENV TERRAFORM_URL=https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/terraform_${TERRAFORM_VER}_linux_arm64.zip

FROM base AS base-arm
ARG TERRAFORM_VER
ARG ALPINE_VER
ENV TERRAFORM_URL=https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/terraform_${TERRAFORM_VER}_linux_arm.zip

FROM base AS base-386
ARG TERRAFORM_VER
ARG ALPINE_VER
ENV TERRAFORM_URL=https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/terraform_${TERRAFORM_VER}_linux_386.zip

FROM base-$TARGETARCH

RUN wget -q $TERRAFORM_URL -O terraform.zip \
 && unzip terraform.zip \
 && mv terraform /bin \
 && rm terraform.zip

ENTRYPOINT ["/bin/terraform"]
