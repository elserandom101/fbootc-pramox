# source and info: https://github.com/travier/sysexts-manager
VERSION="0.3.0" # sysexts-manager version
VERSION_ID="42" # Fedora release
ARCH="x86-64"   # or arm64
URL="https://github.com/travier/sysexts-manager/releases/download/sysexts-manager/"
NAME="sysexts-manager-${VERSION}-${VERSION_ID}-${ARCH}.raw"
install -d -m 0755 -o 0 -g 0 "/var/lib/extensions"{,.d} "/run/extensions"
curl --silent --fail --location "${URL}/${NAME}" \
    | bash -c "cat > /var/lib/extensions.d/${NAME}"
ln -snf "/var/lib/extensions.d/${NAME}" "/var/lib/extensions/sysexts-manager.raw"
restorecon -RFv "/var/lib/extensions"{,.d} "/run/extensions"
systemctl enable systemd-sysext.service
