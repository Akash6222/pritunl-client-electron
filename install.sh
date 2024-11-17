#!/bin/bash
LATEST_VERSION=$(curl -s https://api.github.com/repos/pritunl/pritunl-client-electron/releases/latest | jq -r '.tag_name')
URL="https://github.com/pritunl/pritunl-client-electron/releases/download/${LATEST_VERSION}/pritunl-client-electron-${LATEST_VERSION}-1-x86_64.pkg.tar.zst"
curl -LO "$URL"
echo "Downloaded: $(basename $URL)"
sudo pacman -U "$(basename $URL)"

