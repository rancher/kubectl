#!/usr/bin/env bash
set -e

: ${REPO:=rancher/kubectl}

docker_image_build_and_push()
{
  docker build \
    --build-arg ARCH=${1?required} \
    --build-arg KUBERNETES_RELEASE=${2?required} \
    --platform linux/${1} \
    --tag ${3?required}:${2}-${1} \
  ${4?required}
  docker image push ${3?required}:${2}-${1}
}
echo "${DOCKER_PASSWORD}" | docker login -u $DOCKER_USERNAME --password-stdin

for KUBERNETES_RELEASE in $(cat versions.txt); do
  echo "Checking if image ${REPO}:${KUBERNETES_RELEASE}-${ARCH} already exists"
  if skopeo inspect "docker://${REPO}:${KUBERNETES_RELEASE}-${ARCH}" >/dev/null 2>&1; then
    echo "Image ${REPO}:${KUBERNETES_RELEASE}-${ARCH} already exists, skipping"
    continue
  fi
  echo "Image ${REPO}:${KUBERNETES_RELEASE}-${ARCH} does not exist, building and pushing"
  docker_image_build_and_push ${ARCH} ${KUBERNETES_RELEASE} ${REPO} ./package/
done
