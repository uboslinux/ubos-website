---
title: How to profile the UBOS Personal Data Mesh web application
weight: 35
display: hide
---

{{% warning %}}
This doesn't currently work as we [still run on JDK 11](https://gitlab.com/ubos/ubos-mesh/-/issues/66)
and NetBeans only bundles support for 15 and 16. Once we have fixed this, we need to revisit
these instructions.
{{% /warning %}}

## Problem

Something is taking a long time or lots of memory in the web application. You would
like to run it in a profiler.

## Situation

Let's assume:

* you run your Java profiler client (e.g. in an IDE like NetBeans) on your host
* you run the {{% gl mesh %}} in a Linux container

in a setup similar to the {{% pageref "/docs/developers/tutorials-mesh/" %}}.

## If you only run one JSVC-based Java app on your device/container

(That's probably true for you.)

### Set up NetBeans

(The NetBeans GUI is really terrible about this flow.)

* Select Profile / Attach to External Process
* Click the "Configuration Session" in the toolbar
* Select "Attach" in the toolbar
* Select profile "Manually started remote Java process"
* Enter your container's hostname or IP address, and select your OS and JVM
* Select "create a Remote profiling pack" from Step 2, and save it (a ZIP file)
  to a directory that is mounted into your Linux container.
* Inside the container, unpack the generated ZIP file.
* Inside the container, run `bin/calibrate-16.sh`

### Modify the way the UBOS Mesh web application is run

Edit `/etc/diet4j/diet4j-jsvc-defaults.conf`. This file contains
the defaults for running a JSVC daemon with `diet4j`. It contains
a commented-out section for JAVA_OPTS (default content for debugging).

For activating the Java profiler for all diet4j/JSVC processes, the
line should read:

```
JAVA_OPTS='-XX:+UseLinuxPosixThreadCPUClocks -agentpath:<remote>/lib/deployed/jdk16/linux-amd64/libprofilerinterface.so=<remote>/lib,5140'
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

### Connect with the profiler

