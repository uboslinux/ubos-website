---
title: Finishing the Arch development installation by adding UBOS tools
weight: 40
---

This applies to any physical or virtual machine that runs Arch.

## Add the UBOS tools repository

First, download and install the UBOS keyring, so pacman will allow you to download
and install UBOS tools:

```
% curl -O http://depot.ubos.net/green/x86_64/os/ubos-keyring-0.8-1-any.pkg.tar.xz
% sudo pacman -U ubos-keyring-0.8-1-any.pkg.tar.xz
```

The, as root, edit ``/etc/pacman.conf``, and append, at the end, the following section:

```
[ubos-tools-arch]
Server = http://depot.ubos.net/green/$arch/ubos-tools-arch
```

This will get you the UBOS development tools in the green, aka production, channel.

## Install the ubos-tools-arch metapackage

Execute:

```
% sudo pacman -Sy
% sudo pacman -S ubos-tools-arch
```

Now is a good time to install any other development tools you might want, such as:

```
% sudo pacman -S base-devel
% sudo pacman -S git
```

You are now ready to develop for UBOS.

If you are new to UBOS, you may want to work through {{% pageref toyapps.md %}}.

To run those {{% gls App %}} or test run your own {{% gl App %}}, you may want to
set up a UBOS container (preferred) or a dedicated UBOS test machine. Setup instructions
are at {{% pageref "/docs/users/installation.md" %}}.
