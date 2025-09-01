FROM quay.io/fedora/fedora-kinoite:42
# Pull the upstream kinoite image to modify it
# Explicit versioning in order to avoid surprizes

# Make /opt immutable; See OPT_RO.md for details
COPY --chmod=0755 ./opt-ro.sh /tmp/opt-ro.sh
RUN /tmp/opt-ro.sh && rm /tmp/opt-ro.sh

# Adding a simple sysext-manager
COPY --chmod=0755 ./sysext-manager-install.sh /tmp/sysext-manager.sh
RUN /tmp/sysext-manager.sh && rm /tmp/sysext-manager.sh

# DNF plugin and kernel-install support
RUN dnf -y downgrade kernel
RUN dnf -y install dnf5-plugins

# Packages (filenames need to be better...)
RUN mkdir /usr/share/fkinoite-pramox
COPY --chmod=0644 ./AddedPackages /usr/share/fkinoite-pramox/AddedPackages
COPY --chmod=0644 ./RemovedPackages /usr/share/fkinoite-pramox/RemovedPackages
#RUN cat /usr/share/bpkgs-removed | grep -vE '^#' | xargs dnf -y remove --allowerasing
RUN cat /usr/share/bpkgs-added | grep -vE '^#' | xargs dnf -y install --allowerasing

# Final cleanups
RUN dnf clean all
RUN find /var/log -type f ! -empty -delete
RUN bootc container lint
