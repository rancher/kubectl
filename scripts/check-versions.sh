#!/usr/bin/env bash
set -e

archs="amd64 arm64 s390x"

for release in $(cat versions.txt); do
  for arch in $archs; do
    KUBECTL_URL="https://dl.k8s.io/release/${release}/bin/linux/${arch}/kubectl"
    echo "Checking if file exists at ${KUBECTL_URL}"
    curl --retry 10 --retry-connrefused -L -o /dev/null -sS --fail "${KUBECTL_URL}"
  done
done

echo "All versions exists for ${archs}"
