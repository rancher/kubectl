FROM registry.suse.com/bci/bci-base:15.4.27.14.1 AS build

ARG ARCH
ARG KUBERNETES_RELEASE=v1.21.3
WORKDIR /bin
RUN set -x \
 && zypper -n install curl \
 && curl -fsSLO https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_RELEASE}/bin/linux/${ARCH}/kubectl \
 && chmod +x kubectl
RUN useradd -u 1000 -U -m kubectl

FROM scratch
COPY --from=build /bin/kubectl /bin/kubectl
COPY --from=build /etc/passwd /etc/passwd
COPY --from=build /etc/group /etc/group
USER kubectl
ENTRYPOINT ["/bin/kubectl"]
CMD ["help"]
