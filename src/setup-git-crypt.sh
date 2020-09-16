#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o xtrace

#######################################
# Functions
#######################################
function parse_verion() {
  if [[ "${INPUT_GITCRYPT_VERSION}" == "latest" ]]; then
    echo "AGWA/git-crypt doesn't use proper GitHub Versioning, please use a version from https://github.com/AGWA/git-crypt/releases, or just use the action default"
    exit 1
    # gitCryptVersion=$(curl https://api.github.com/repos/AGWA/git-crypt/releases/latest | jq -r '.tag_name')
  else
    gitCryptVersion="${INPUT_GITCRYPT_VERSION}"
  fi
}

function download_extract_gitcrypt() {
  mkdir -p /tmp/git-crypt_${gitCryptVersion}
  curl -L https://github.com/AGWA/git-crypt/archive/${gitCryptVersion}.tar.gz \
    --output /tmp/git-crypt-${gitCryptVersion}.tar.gz
  tar -zxvf /tmp/git-crypt-${gitCryptVersion}.tar.gz --strip-components=1 -C /tmp/git-crypt_${gitCryptVersion}
  ls -lrt /tmp/git-crypt_${gitCryptVersion}
}

function build_gitcrypt() {
  cd /tmp/git-crypt_${gitCryptVersion}
  make -j
  cd /github/workspace
}

function install_gitcrypt() {
  mkdir -p bin
  mv /tmp/git-crypt_${gitCryptVersion}/git-crypt bin/git-crypt
}

#######################################
# Script
#######################################
parse_verion
download_extract_gitcrypt
build_gitcrypt
install_gitcrypt