#!/bin/sh
set -e

: ${REPO:=rancher/kubectl}
: ${KUBERNETES_RELEASE:=v1.21.3}

docker_image_build_and_push()
{
  docker buildx build \
    --build-arg ARCH=${1?required} \
    --build-arg KUBERNETES_RELEASE=${2?required} \
    --platform linux/${1} \
    --tag ${3?required}:${2}-${1} \
  ${4?required}
  docker image push ${3?required}:${2}-${1}
}

docker_manifest_create_and_push()
{
  images=$(docker image ls $1-* --format '{{.Repository}}:{{.Tag}}')
  docker manifest create --amend ${1?required} $images
  for img in $images; do
    docker manifest annotate $1 $1-${img##*-} --os linux --arch ${img##*-}
  done
  docker manifest push $1
}

docker_image_build_and_push amd64 ${KUBERNETES_RELEASE} ${REPO} $(dirname $0)/.
docker_image_build_and_push arm64 ${KUBERNETES_RELEASE} ${REPO} $(dirname $0)/.
docker_image_build_and_push s390x ${KUBERNETES_RELEASE} ${REPO} $(dirname $0)/.

docker_manifest_create_and_push ${REPO}:${KUBERNETES_RELEASE}
