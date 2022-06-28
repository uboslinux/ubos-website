---
title: How can I debug the UBOS Mesh web application?
weight: 1020
---

## Problem

Something is going wrong in the web application. You would like to run
it in a debugger.

## Situation

Let's assume:

* you run your Java debugger (e.g. in an IDE like NetBeans) on your host
* you run the {{% gl mesh %}} in a Linux container

in a setup similar to the {{% pageref "/docs/developers/tutorials-mesh/" %}}.

## If you only run one JSVC-based Java app on your device/container

(That's probably true for you.)

### Edit the diet4j/JSVC default configuration

Edit `/etc/diet4j/diet4j-jsvc-defaults.conf`. This file contains
the defaults for running a JSVC daemon with `diet4j`. It contains
a commented-out section for debug flags.

For activating the Java debugger for all diet4j/JSVC processes, the
line should read:

```
JAVA_OPTS='-Xdebug -Xrunjdwp:transport=dt_socket,address=*:8888,server=y,suspend=y'
```

### Determine the right AppConfigId and restart the daemon

First, determine the AppConfigId of your {{% gl mesh %}} web application,
such as by executing:

```
% ubos-admin listsites --detail
* (s5f9a9cb99c115fd53e6de326d68eeddd12d1b623) :
    <root> (a33ac4a6a39c003d9c92aea5491f71fd172acfdf8)
        app:       ubos-mesh-underbars-mysql
            customizationpoint: fullappname: UBOS Personal Data Mesh
            customizationpoint: shortappname: UBOS Mesh
            customizationpoint: usehistory: 1
            customizationpoint: useindex: 1
        accessory: ubos-mesh-model-amazon
        accessory: ubos-mesh-model-facebook
        ...
```

Look for the hexadecimal identifier that starts with `a`. Here it is
`a33ac4a6a39c003d9c92aea5491f71fd172acfdf8`. This is the instance id for
the systemd service to restart, like this:

```
% sudo systemctl restart diet4j-jsvc@a33ac4a6a39c003d9c92aea5491f71fd172acfdf8.service
```
Replace the instance id with the AppConfigId from your deployment.

### Connect with your debugger

Then, connect to port 8888 in the container, or wherever you are running the
test, e.g. using the NetBeans "Attach Debugger" feature.

Make sure no firewall gets in the way of accessing this port. You can accomplish this
by making sure file `/etc/ubos/open-ports.d/java-debugging` exists in the container,
with content `8888/tcp`, and `sudo ubos-admin update` has been run to update the
firewall configuration.

{{% warning %}}
This invocation will open up your port 8888 to the world. If you do this for a Linux
container on the workstation you are running the debugger client, that's probably okay.
For server scenarios you may want to lock this down by not specifying `*` but something
more limited.
{{% /warning %}}

## If you run more than one diet4j/JSVC-based process on the same device

Then you probably want to be more specific and only activate Java debugging
for one of the daemons.

Instead of modifying the system-wide default, you create, or edit file
``/etc/diet4j/diet4j-jsvc-AAA.env`` (where `AAA`) is the AppConfigId from above,
and enter the ``JAVA_OPTS`` line there instead.

To see how it all hangs together, look at the systemd configuration file at
``/usr/lib/systemd/system/diet4j-jsvc@.service``.
