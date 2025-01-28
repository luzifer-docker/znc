#!/bin/bash
set -euxo pipefail

makepkgs=(
  curl
)

runpkgs=(
  znc
)

# Install required package
apk --no-cache add "${makepkgs[@]}" "${runpkgs[@]}"

# Add gosu for privilege de-escalation
curl -sSfLo /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64"
chmod +x /usr/local/bin/gosu

# Add korvike for template processing
curl -sSfL "https://github.com/Luzifer/korvike/releases/download/v${KORVIKE_VERSION}/korvike_linux_amd64.tgz" | tar -xz -C /usr/local/bin

# Remove make-only packages
apk --no-cache del "${makepkgs[@]}"
