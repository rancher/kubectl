ARG ALPINE=alpine:latest
FROM ${ALPINE} AS alpine
ARG ARCH
ARG KUBERNETES_RELEASE=v1.21.3
WORKDIR /bin
RUN set -x \
 && apk --no-cache add curl \
 && curl -fsSLO https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_RELEASE}/bin/linux/${ARCH}/kubectl \
 && chmod +x kubectl

FROM scratch
COPY --from=alpine /bin/kubectl /bin/kubectl
ENTRYPOINT ["/bin/kubectl"]
CMD ["help"]
