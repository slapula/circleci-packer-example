#!/bin/bash
IMAGE_YML=manifest.json
ROOT_DIR=$(git rev-parse --show-toplevel)

set -x
cd "${ROOT_DIR}"

if ! git diff --quiet "packer/${IMAGE_YML}"; then
  git add "packer/${IMAGE_YML}"
  git commit -m "images: Updated by Packer [ci skip]"
  git push origin HEAD:${CIRCLE_BRANCH}
else
  echo "No changes for ${IMAGE_YML}."
fi
