#!/usr/bin/env bash
set -e

: "${REPO:=rancher/kubectl}"
: "${EXISTING_VERSIONS:=''}"

while IFS= read -r KUBERNETES_RELEASE; do
  echo "Checking if image ${REPO}:${KUBERNETES_RELEASE} exists"
  for RELEASE_VERSION in $EXISTING_VERSIONS; do
    if [ "$KUBERNETES_RELEASE" == "$RELEASE_VERSION" ]; then
      echo "Image ${REPO}:${KUBERNETES_RELEASE} already exists, skipping"
      continue 2
    fi
  done

  echo "Image ${REPO}:${KUBERNETES_RELEASE} does not exist, adding to new versions list"
  echo "${KUBERNETES_RELEASE}" >> new-versions.txt
done < versions.txt

