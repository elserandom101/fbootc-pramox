#!/bin/bash
set -xeuo pipefail

# See OPT_RO.md for details like "why"
if ! [ "$(realpath /opt)" = "/usr/opt" ]
then
  [ -d /opt ] && mv /opt /usr/opt
  [ "$(realpath /opt)" = "/var/opt" ] && mv /var/opt /opt && mkdir /var/opt
  mkdir /usr/opt 2>/dev/null ||:
  rm -f /opt ||:
  ln -sf usr/opt /opt
end

exit 0
