---
title: Alternate development setup on Linux with systemd-nspawn and btrfs
weight: 50
---

## Introduction

For most developers, we recommend the two-container Docker develoment setup
described in {{% pageref first-app-with-docker.md %}}.

However, there are certain advantages to the following setup, if it is possible
for you. These advantages include:

* The UBOS firewall of the `ubos-target` container is the same as for any production
  {{% gl device %}}, while Docker operates its own firewall. This means the
  fidelity of testing your code in this setup is higher. This mostly matters for
  standalone {{% gls app %}} that open extra ports beyond HTTP and HTTPS.

* The turnaround time switching back to a pristine system to test on is lower,
  by the magic of btrfs subvolumes and copy-on-write.

* Also, we consider `systemd-nspawn` to be more flexible than Docker for our
  purposes here. Your opinion may vary :-)

The main downsides are that you cannot run this on a workstation that does not run Linux,
and the setup is a bit more involved.

## System requirements

You need:

* A workstation running Linux. We use Arch Linux, but it should work on any other
  modern distro that runs systemd. These instructions are written for Arch Linux;
  on other distros you may need to adjust same paths or install some extra packages.

* Your home directory, or some other file system you can write to, is btrfs.

Here are the steps:

## Configure your host to allow Linux containers to access the internet

There are two steps:

1. Run both IPv4 and IPv6 based `iptables` on your host, otherwise UBOS cannot set up its
   own firewall and UBOS containers will boot into a `degraded` state. If you aren't
   already doing this, on the host:

   ```
   % [[ -e /etc/iptables/iptables.rules ]] || sudo cp /etc/iptables/empty.rules /etc/iptables/iptables.rules
   % [[ -e /etc/iptables/ip6tables.rules ]] || sudo cp /etc/iptables/empty.rules /etc/iptables/ip6tables.rules
   % sudo systemctl enable --now iptables ip6tables
   ```

   This will not actually perform any firewall functionality (the ruleset is empty), but
   it will allow the UBOS container to set up its own firewall.

1. Make sure your host network interface forwards traffic from the the containers. If you use
   systemd-networkd for network management, add `IPForward=1` to the relevant `.network` file.
   For example, `/etc/systemd/nhetworkd/wired.network` should read as follows:

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

## Selecting a release channel on which to develop

By default, you may want to develop on the "yellow" {{% gl release_channel %}}, but
of course you can choose "red" or "green" instead.

In this document, we call the selected {{% gl release_channel %}} `${CHANNEL}` and
assume you selected "yellow".

## Create a working directory

Create a working directory, go to that directory, and download the setup script:

```
% mkdir ~/ubosdev-${CHANNEL}
% cd ~/ubosdev-${CHANNEL}
% curl -O https://raw.githubusercontent.com/uboslinux/setups-ubosdev/main/ubosdev-nspawn/setup.sh
```

If you choose the "yellow" {{% gl release_channel %}}, for example, this would be:

```
% mkdir ~/ubosdev-yellow
% cd ~/ubosdev-yellow
% curl -O https://raw.githubusercontent.com/uboslinux/setups-ubosdev/main/ubosdev-nspawn/setup.sh
```

The remainder of this document assumes you perform all commands on the host
in this directory.

## Download the base image

Download a "container" image:

* for the "yellow" channel: http://depot.ubos.net/yellow/x86_64/images/

Look for the file ``ubos_yellow_x86_64-container_LATEST.tar.xz``.

If you chose a `${CHANNEL}` other than "yellow", replace the "yellow" in the download URL
with the name of the `${CHANNEL}` you chose.

We will call the name of the downloaded image file `${IMAGE}`. Download it into your
working directory.

## Set up your containers

Run the setup script with the name of the downloaded image file as an argument:

```
% bash setup.sh ${IMAGE}
```

or if you use a channel other than "yellow", run it as:

```
% CHANNEL=${CHANNEL} bash setup.sh ${IMAGE}
```


This will:

* Check that your system meets the requirements for this setup.

* Create a btrfs subvolume called `ubos-${CHANNEL}` that contains the downloaded, unpacked UBOS image,
  with any recent updates applied. This will not be directly used. It is only used as a template
  for other subvolumes, so it's easy to go back to if you decide to reset one of your containers
  to a pristine state.

* Subvolume `ubos-develop-${CHANNEL}` is a copy-on-write copy of the `ubos-${CHANNEL}` subvolume,
  with development tools installed. You will use this to build your software.

* Subvolume `ubos-target-${CHANNEL}` is another copy-on-write copy of the `ubos-${CHANNEL}`
  subvolume, set up so that {{% gls package %}} built on `ubos-develop-${CHANNEL}` can be easily
  deployed to it and tested.

Running this script may take a few minutes to complete.

## Run your "development" container `ubos-develop-${CHANNEL}`

In a first shell, run all in one line, or with the backslashes at the end):

```
% sudo systemd-nspawn -b -n -M ubos-develop-${CHANNEL} -D ubos-develop-${CHANNEL} \
   --bind $(pwd):/home/ubosdev/project --bind $HOME/.m2:/home/ubosdev/.m2 --bind /dev/fuse \
   --network-zone ubos-${CHANNEL}
```

This is the console of your `ubos-develop-${CHANNEL}` container, and you can put that one
out of sight.

In a second shell, log in as your `ubosdev` development user:

```
% sudo machinectl shell ubosdev@ubos-develop-${CHANNEL}
```

## Run the `ubos-target-${CHANNEL}` container with an ephemeral file system

In a third shell, go to your working directory and start the container with the `-x` flag:

```
% cd ~/ubosdev-${CHANNEL}
% sudo systemd-nspawn -x -b -n -M ubos-target-${CHANNEL} -D ubos-target-${CHANNEL} \
   --bind /dev/fuse \
   --network-zone ubos-${CHANNEL}
```

By using the `-x` flag, we make the container use an ephemeral file system. This means that as
soon as you stop the container, all data in the container will be lost. This is great for the
`ubos-target-${CHANNEL}` container, because as soon as you restart it, you are back to
a pristine system for testing.

Log in as root with the
{{% pageref "/docs/administrators/faq-howto-troubleshooting/" "default password" %}}.

This shell is best used to display the system log, so you can watch for any problems during
deployment or operation of your code:

```
# journalctl -f
```

## Test that user `ubosdev` on `ubos-develop-${CHANNEL}` can ssh into `ubos-target-${CHANNEL}` as `shepherd`

In `ubosdev`'s shell:

```
% ssh -t shepherd@ubos-target-${CHANNEL} whoami
```

After the usual ssh confirmation when connecting to a new host for the first time,
it will print "shepherd".

## Build the first App

### Check out the code

We will be building the PHP / MySQL version of the Glad-I-Was-Here toy app.

In a shell on the host, go to your project directory and check out the code:

```
% cd ~/ubosdev-${CHANNEL}
% git clone https://github.com/uboslinux/ubos-toyapps.git
```

### Build the App

In the `ubosdev` shell in the `ubos-develop-${CHANNEL}` container, your project directory
is available as subdirectory `project` in `ubosdev`'s home directory.

Go to that directory, then below into the checked-out git directory. to where
the `PKGBUILD` of the {{% gl app %}} is that we are going to build:

```
% cd ~/project/ubos-toyapps/gladiwashere-php-mysql
```

Build with:

```
% makepkg -C -f
```

## Deploy the App to the `ubos-target-${CHANNEL}` container

In the `ubosdev` shell on the `ubos-develop-${CHANNEL}` container, in the directory where you built
your {{% gl app %}}:

```
% ubos-push --host ubos-target-${CHANNEL} gladiwashere-php-mysql-*.pkg*
```

(You may want to replace the `*`s and use the actual filename. You are looking for
the file with the long name that contains the `.pkg`.)

This will transfer the newly built {{% gl package %}} to the `ubos-target-${CHANNEL}` container, and
cleanly upgrade any {{% gls site %}} that use the {{% gl package %}} there. The first time,
this will take a little bit.

Right now your `ubos-target-${CHANNEL}` container is pristine and does not run any
{{% gl site %}}. You can check by pointing your browser to
`http://ubos-target-${CHANNEL}/`.

So from the `ubosdev` shell, we create a {{% gl site %}} on the target container that
runs your {{% gl app %}}:

```
% ssh -t shepherd@ubos-target-${CHANNEL} sudo ubos-admin createsite
```

Enter ``*`` (the {{% gl wildcard_hostname %}}) as the hostname, and a reasonable
user id, username, password and e-mail address (this toy app doesn't actually use
any of them, so the values don't matter in this tutorial.)

When asked for the first {{% gl app %}} to run, enter
``gladiwashere-php-mysql`` and an empty string for the context path and
the {{% gls accessory %}}.

It will say "Deploying..." and then take a little while because various
dependencies need to be downloaded and installed, such as Mariadb.

## Try out your deployed App!

Go to `http://ubos-target-${CHANNEL}/`. You will find your guestbook toyapp
there.

## Next steps

Then we recommend you work through {{% pageref "toyapps" %}}.

When you are done with your UBOS containers, enter `^]^]^]` in each. That will
close shells, and stop each container. You can restart them with the same
`systemd-nspawn` command you used to start them initially. Don't be surprised
that the `ubos-target-${CHANNEL}` will be reset to a pristine state, so
you will have to recreate/redeploy any {{% gl site %}} you had created there.

