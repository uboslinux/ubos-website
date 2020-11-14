---
title: About
---

## UBOS History

Many people want more control over their data. This includes data such as family photos,
public posts, medical records, and the data from the Internet-of-Things sensors in their
home. For that reason, many geeks have set up their own servers at home or at a colocation.

The trouble is that operating your own server takes skill, and lots of time, so most people
cannot take back control over their data on their own.

We created <b>UBOS</b>, a new Linux distro, in order to make it simple to set up and
maintain a Linux server that runs common web applications and keeps data under control
of the owner of the server. It's our vision that everybody should have an server in their
home one day that stays independent of the big commercial and governmental overlords.
And runs UBOS of course :-)

For a comparison of UBOS to other distros, see [features](#features) below.

## UBOS Requirements

* Dramatically reduce the time needed for system administration of personally-owned
  "server" computers running web apps.

* Ability to run head-less, i.e. without a display or keyboard attached.

* High-level commands for installation, uninstallation, and other operations on
  server-side apps. E.g. a single command should be able to install and configure any
  kind of app including all of its dependencies, databases, virtual hosts, services etc.

* Automatic or high-level networking configuration including firewall and
  SSL/TLS setup.

* Make no assumptions about which apps are installed on which server, or even that
  any two UBOS servers will run the same apps. Every user is unique. This makes UBOS
  very different from Linux distros targeted towards data centers and server farms.

* Be available consistently across various hardware platforms.

## <a name="features"></a>UBOS Features

* With UBOS, <b>web applications can be installed, and fully configured with a single
  command</b>. This takes out the drudgery of software installation and configuration on
  servers and allows many more people to run their own websites.

     Wanting to run a, say, Python app should not require users having to know anything
     about Python; same about other languages, frameworks, databases and the like. You don't
     care about which language was used to create apps on your smart phone either.

     On UBOS, unlike other Linux distros, a typical user never has to edit a Linux-level
     configuration file (say in <code>/etc/</code>), provision a database, start or stop
     services, and the like.

* UBOS <b>fully automates app management at virtual hosts</b>. You can run, say, five
  different instances of Wordpress with different plugins and themes at five different
  hostnames on the same computer, or even at the same hostname (e.g. example.com/blog1,
  example.com/blog2 etc.).
  You can deploy all of them individually or at the same time with a single command.

     UBOS can specify your own SSL/TLS certificates for your site, or also automatically
     obtain certificates from [Letsencrypt.org](https://letsencrypt.org/).

* UBOS <b>pre-installs and pre-configures networking and other infrastructure</b>, so it
  is ready to be used as soon as it has booted. For example, not only does UBOS boot as a
  dhcp client, but also runs a web server with a default web application behind a
  preconfigured firewall. This allows the user to use UBOS immediately, with little to
  no systems configuration.

     On other distros, this is an open-ended manual process requiring substantial
     systems administration knowledge and even more patience.

* Systems that have two or more Ethernet interfaces can be turned into a <b>home router/gateway</b>
  with a single command. In this "gateway" configuration, UBOS automatically sets up
  network masquerading, a firewall, a local DNS and DHCP server.

     Apps installed on the system can either be only accessible on the local-area network,
     or also on the public internet.

* UBOS can <b>backup or restore</b> all, or any subset of installed applications on a device,
  including their entire configuration (like TLS) in a single command. Optionally,
  backups may be encrypted and/or automatically uploaded to Amazon S3.

* With the UBOS Staff (a USB device), much system administration can be performed without
  every having to connect a keyboard or a monitor to the device running UBOS. This means
  UBOS devices can be locked away into a closet or the attic, and don't need to take up
  desk space.

     The UBOS Staff can be used to set up SSH credentials for remote login, deploy new
     apps on new sites, and even configure the device to connect to a WiFi network.

* UBOS <b>"full-stack testing"</b> ensures that core UBOS operating system, networking,
  middleware, and apps, are all tested with each other before a new UBOS release is
  pushed out. This reduces the likelihood that, for example, an upgrade to the database
  or web server will break a web application.

     Some Linux distros perform similar testing with desktop applications, but we are not
     aware of any other distros that do it for server-side, web applications.

* Unlike most other distros, UBOS does not try to provide every conceivable package.
  Instead, we try to provide <b>as few packages as possible</b> by eliminating alternate
  packages that provide overlapping functionality. For example, we picked Apache over
  nginx (due to broader software support). To support the goals of UBOS, this has great
  advantages: it makes testing simpler, because UBOS has far less code, and far fewer
  configurations need to be tested. This in turn makes application developers' lives
  easier and installations less brittle.

     Users who wish to use other packages not provided through UBOS can still obtain those
     from the Arch Linux repositories. UBOS is a (compatible) derivative of Arch Linux.

* UBOS uses a {{% gl Rolling_Release "rolling-release" %}} development model.
  UBOS never requires major upgrades; instead, updates are made available incrementally.
  This ensures that devices can continue to be updated and keep running for the long-term.

* UBOS itself is all <b>free/libre and open software</b> for individuals, so there's no
  proprietary lock-in and you can keep us honest by reviewing our code.

     There is one exception: some hardware platforms, notably some versions of ARM,
     require "blobs" to function. (The Free Software Foundation provides a
     [great description](https://www.fsf.org/resources/hw/single-board-computers).
     UBOS bundles those blobs in order to be able to support those platforms. Of course,
     if you don't like proprietary blobs, only use UBOS on platforms where they aren't
     required. In of course, you can install and run whatever software you like, in
     addition to what is available through the official UBOS repositories.

## <a name="arch"></a>Thank you, Arch Linux, and Arch Linux ARM!

UBOS is a derivative of the [Arch Linux](http://archlinux.org/) distro,
and its ARM-based derivative [Arch Linux ARM](http://archlinuxarm.org/).
We try to use as many packages as possible directly from Arch. Thank you,
we couldn't do without you!

## Commercial support available

[Indie Computing Corp.](https://indiecomputing.com/) offers commercial support for UBOS.
[Contact us](http://indiecomputing.com/c/contact/).
