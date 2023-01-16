#!/usr/bin/env bash
set -e

: ${REPO:=rancher/kubectl}

archs="amd64 arm64 s390x"

docker_manifest_create_and_push()
{
  for arch in $archs; do
    docker manifest create --amend ${1?required} "${1}-${arch}"
    docker manifest annotate $1 "$1-${arch}" --os linux --arch ${arch}
  done
  docker manifest push $1
}

echo "${DOCKER_PASSWORD}" | docker login -u $DOCKER_USERNAME --password-stdin

for KUBERNETES_RELEASE in $(cat versions.txt); do                                                                                                                                                                                                                                                                             
  docker_manifest_create_and_push ${REPO}:${KUBERNETES_RELEASE}
done
