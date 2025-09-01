# `/opt` is read-only once again
In this derivative, `/opt` is a symlink to `/usr/opt`, meaning that it is read-only.
Any writable files under `/opt` need to be symlinked to equivalents under `/var/opt` or `/etc/opt`.

## Upstream policy
The default upstream fedora policy, at the time of this being written (1-Sep-2025), is different.
It is to make `/opt` a symlink to `/var/opt`, to allow modifications in it.
This is because some software in `/opt` store writable files like logs, configs, state etc.. in `/opt` itself.

## Why not so here
Keeping `/opt` immutable means that just like software strictly under `/usr`, software here too is protected from arbitrary changes.
It upholds the same immutable/atomic guarantees for `/opt` as `/usr`.

## Writable files?
They need to be symlinked to equivalents under `/var/opt`, which is where writable parts of `/opt` are supposed to be.
`/etc/opt` for config files

## Why symlink to `/usr/opt`
Atomicity and immutability are strongly guaranteed mainly for `/usr`, and thus `/opt` too is put there.

## `/opt/local`
Symlinked to `/var/usrlocal/opt`
