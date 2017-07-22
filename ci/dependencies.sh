#!/bin/bash
set -e
CIRCLECI_CACHE_DIR="${HOME}/bin"
PACKER_VERSION="1.0.3"
PACKER_CHECKSUM="0e10169ef9cf3fd55dcc9dc213b9995170f7712e8a162ca2f5109d62bfbe7529"
PACKER_URL="https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip"

if [ ! -f "${CIRCLECI_CACHE_DIR}/packer" ] || [[ ! "$(packer version)" =~ "Packer v${PACKER_VERSION}" ]]; then
  wget -O /tmp/packer.zip "${PACKER_URL}"
  echo "${PACKER_CHECKSUM} /tmp/packer.zip" | sha256sum --check -
  unzip -oud "${CIRCLECI_CACHE_DIR}" /tmp/packer.zip
fi

packer version
