#!/bin/bash
IMAGE_JSON=manifest.json
ROOT_DIR=$(git rev-parse --show-toplevel)

set -x

cp "${IMAGE_JSON}" "${ROOT_DIR}"
cd "${ROOT_DIR}"

if ! git diff --quiet "${IMAGE_JSON}"; then
  git add "${IMAGE_JSON}"
  git commit -m "images: Updated by Packer [ci skip]"
  git push origin HEAD:${CIRCLE_BRANCH}
else
  echo "No changes for ${IMAGE_JSON}."
fi
