#!/usr/bin/env bash

# Define usage function
usage() {
    echo "Usage: $0 [-P optional image pull] kubectl_version"
    exit 1
}

: "${REPO:=rancher/kubectl}"

PULL=false
# Parse options
while getopts "P" opt; do
    case ${opt} in
        P)
            PULL=TRUE
            ;;
        \? )
            echo "Invalid option: $OPTARG" 1>&2
            usage
            ;;
        : )
            echo "Invalid option: $OPTARG requires an argument" 1>&2
            usage
            ;;
    esac
done
shift $((OPTIND -1))
# Check if required argument is provided
if [ $# -eq 0 ]; then
    echo "Missing required argument" 1>&2
    usage
fi
VERSION="${1:-UNSET}"

IMAGE_NAME="$REPO:$VERSION"
echo The image to be tested is "$IMAGE_NAME"

if [ "$PULL" == "TRUE" ]; then
  echo "Pulling image first..."
  if ! docker image pull "$IMAGE_NAME"; then
    echo "FAIL: Failed to pull image $IMAGE_NAME"
    exit 1
  fi
fi

echo "Testing run..."
OUT=$(docker run --rm "$IMAGE_NAME" version --client=true)
if [[ $OUT =~ .*${VERSION}.* ]]; then
  echo "PASS: Expected version found in output."
  exit 0
fi

echo "FAIL: Expected version not found in output."
echo "Output Found:"
echo "$OUT"
exit 1
