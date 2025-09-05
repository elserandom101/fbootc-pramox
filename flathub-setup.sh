#!/bin/bash
set -xeuo pipefail

# Add flathub repo
flatpak --system remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Reinstall programs already installed through flathub
flatpak --system install -y --reinstall flathub $(flatpak list --app-runtime=org.fedoraproject.Platform --columns=application | tail -n +1 )

# Prioritize flathub
flatpak remote-modify --system --prio=1 flathub ||:

# Deprioritize fedora-flatpaks
flatpak remote-modify --system --prio=2 fedora ||:

# Add some useful things like codecs etc...
RUNEXTS=(
  "org.freedesktop.Platform.GL"
  "org.freedesktop.Platform.VulkanLayer"
  "org.freedesktop.Platform.codecs-extra"
)
flatpak --system install -y flathub "${RUNEXTS[@]}"

# Replace some default included applications
DEFPROG=(
  "org.mozilla.firefox"
)
flatpak -y --system install flathub "${DEFPROG[@]}"

exit 0
