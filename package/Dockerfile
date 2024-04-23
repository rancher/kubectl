FROM registry.suse.com/bci/bci-base:15.5 AS build

ARG TARGETPLATFORM
ARG KUBERNETES_RELEASE=v1.21.3
WORKDIR /bin
RUN set -x \
 && curl -fsSLO https://dl.k8s.io/release/${KUBERNETES_RELEASE}/bin/${TARGETPLATFORM}/kubectl \
 && chmod +x kubectl
RUN useradd -u 1000 -U -m kubectl

FROM scratch
COPY --from=build /bin/kubectl /bin/kubectl
COPY --from=build /etc/passwd /etc/passwd
COPY --from=build /etc/group /etc/group
USER kubectl
ENTRYPOINT ["/bin/kubectl"]
CMD ["help"]
