---
title: Developing using a systemd-nspawn container (Linux host only)
weight: 10
---

## Prerequisites

This should work on all 64-bit `x86_64` Linux systems that run
[`systemd`](https://systemd.io/) -- that's most of them at this point --
and most (all?) 64-bit ARM Linux systems that run `systemd`. We have tested this
setup on Arch Linux on `x86_64` and `aarch64` and with Ubuntu on `x86_64`.

If you use ARM, replace all occurrences of `x86_64` in URLs and filenames
in this document with `aarch64`.

Here are the steps:

## Make sure `systemd-nspawn` is installed

Some Linux distros keep this `systemd` executable in a separate package that
you need to first install. For example, on Ubuntu, install it with:

```
% sudo apt install systemd-container
```

## Optional: btrfs filesystem

`systemd-nspawn` has built-in extra features when you use the
[`btrfs`](https://www.kernel.org/doc/html/latest/filesystems/btrfs.html) filesystem.
This can make container management much faster and take up less disk space. If you
can, we recommend a `btrfs` partition; if not, that's fine, too, it will work just
fine on other filesystems as well.

## Make sure your host allows Linux containers to access the internet

How to do this highly dependent on your networking setup. Here is a setup
that works for us on Arch Linux, using `systemd-networkd` for network
management. There are two steps:

1. Run both IPv4 and IPv6 based `iptables` on your host, otherwise the UBOS
   container cannot set up its own firewall and UBOS containers will boot into
   a `degraded` state. (That's not fatal, it just looks ugly and you might not
   see other problems as easily.) If you aren't already doing this, on the host:

   ```
   % [[ -e /etc/iptables/iptables.rules ]] || sudo cp /etc/iptables/empty.rules /etc/iptables/iptables.rules
   % [[ -e /etc/iptables/ip6tables.rules ]] || sudo cp /etc/iptables/empty.rules /etc/iptables/ip6tables.rules
   % sudo systemctl enable --now iptables ip6tables
   ```

   This will not actually perform any firewall functionality (the ruleset is empty,
   unless you set some yourself), but it will allow the UBOS container to set up its
   own firewall.

1. Make sure your host network interface forwards traffic from the the containers. Add
   `IPForward=1` to the relevant `.network` file so IP packets will be forwarded from the
   container to the public internet (e.g. for package downloads). For example,
   `/etc/systemd/networkd/wired.network` should read as follows:

   ```
   [Match]
   Name=en*

   [Network]
   DHCP=ipv4
   IPForward=1
   ```

   After you make a change to a `.network` file:

   ```
   % sudo systemctl daemon-reload
   % sudo systemctl restart systemd-networkd systemd-resolved
   ```

## Pick a project directory

We recommend you do all your UBOS-related development below a certain directory.
Let's say that directory is ``~/ubosdev-nspawn``. Create that directory and enter
it:

```
% mkdir ~/ubosdev-nspawn
% cd ~/ubosdev-nspawn
```

Then create a sub-directory for your project files:

```
% mkdir projects
```

## Pick a release channel to work on

By default, this setup uses the `yellow` {{% gl release_channel %}}.
This is the recommended {{% gl release_channel %}} for most application development.

{{% note %}}
If you want to develop on a {{% gl release_channel %}} other than `yellow`,
set the release channel as an environment variable for the setup command,
and replace the string `yellow` with the name of the alternate {{% gl release_channel %}}
in all other commands.
{{% /note %}}

## Download a container image

Download a container image. Go to http://depot.ubosfiles.net/yellow/x86_64/images/index.html
and look for the file ``ubos-develop_yellow_x86_64-container_LATEST.tar.xz``.

If you chose a `${CHANNEL}` other than `yellow`, replace the `yellow` in the above URL,
*and* then the `yellow` in the filename with the name of the `${CHANNEL}` you chose. Also
remember to replace `x86_64` with `aarch64` if you are on ARM.

We will call the name of the downloaded image file `${IMAGE}`. Download it into your
working directory.

## Unpack the container image

If your filesystem is `btrfs`, create a subvolume that becomes the filesystem
for your container:

```
% sudo btrfs subvol create ubos-develop-yellow
```

For all other filesystems, simply create a directory that becomes the filesystem
for your container:
```
% mkdir ubos-develop-yellow
```

Then unpack:

```
% ( cd ubos-develop-yellow; sudo tar xfJ ../ubos-develop_yellow_x86_64-container_LATEST.tar.xz )
```

## Start the container

In the project directory, run:

```
% sudo systemd-nspawn -b -n -M ubos-develop-yellow -D ubos-develop-yellow \
   --bind $(pwd)/projects:/home/ubosdev/projects --bind $HOME/.m2:/home/ubosdev/.m2 --bind /dev/fuse \
   --network-zone ubos-yellow
```

{{% note %}}

This is a mouthful. You can create yourself a shortcut of you like:

```
% echo sudo systemd-nspawn -b -n -M ubos-develop-yellow -D ubos-develop-yellow \
   --bind $(pwd)/projects:/home/ubosdev/projects --bind $HOME/.m2:/home/ubosdev/.m2 --bind /dev/fuse \
   --network-zone ubos-yellow \
   > start-container-yellow
% chmod 755 start-container-yellow
```
and run it as:
```
% ./start-container-yellow
```
{{% /note %}}

If your filesystem is `btrfs`, you can also add flag ``-x`` to this invocation.
When you do, `systemd-nspawn` will make all changes in a temporary filesystem instead,
and when you quit your container, your unpacked "directory" will still be unchanged.

## Open a shell in the container

The shell in which you ran the `systemd-nspawn` command now shows a login prompt.
You can login there as `root`
(with {{% pageref "/docs/operation/faq-howto-troubleshooting/faq-root-password" "this password" %}},
but if you do, we recommend you only use this shell to follow the system
log (e.g. with `journalctl -f`).

To do your development, open up a separate shell and execute:

``
% sudo machinectl shell ubosdev@ubos-develop-yellow
``

This gives you a shell in your container. You will execute your build
commands in this shell. You can open up as many shells on the container
as you like.

Note that your projects directory on the host that you created earlier,
is mounted into your container right where you are. You can see the same
files there on the host and in the container:

```
% ls -al projects
```

That makes sharing files between the host (where you can edit them with
the editor of your choice) and the container (where you build and run your
code) quite easy.

## Shut down the container

When you are done developing, shut down the container with:

`^]^]^]`

(three control-`]`'s, in a rapid sequence) in the shell that you ran `systemd-nspawn` in.

