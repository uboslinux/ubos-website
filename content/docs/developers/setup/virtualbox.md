---
title: Developing using Arch on VirtualBox with a systemd-nspawn container
weight: 30
---

## Setup

1. Download the compressed VM file. This may take some time as it is large.

1. Uncompress the file with `xz`.

1. In VirtualBox, select "Add" and open the newly uncompressed `UBOS development.vbox` file.

1. Start the VM.

1. Logon as `ubosdev`, there is no password. `root` does not have a password either: we
   assume that's safe enough on your computer. If you don't think so, set one :-)

1. Pick a better screen resolution:

   * In "Search", type "Settings" and run it.
   * If there's an error message saying "Oops, something has gone wrong" about Network
   settings: ignore it, we are not running Network manager.
   * Select "Displays" and pick a resolution that makes sense for your computer setup.
   * Close the settings app.

1. in "Search", type "Console" and run it (you get the "Search" by selecting
   "Activities" in the menu bar)

1. Set up the UBOS development environment by running:

   ```
   % ubosdev-container setup --channel red --flavor mesh
   ```

   Use `--flavor mesh` if you plan to do UBOS Mesh development or you aren't certain.

   Note the argument specifying the `red` release channel; the `yellow` default one
   does not work yet.

   This might take 5-30 min, depending on your network, computer and disk speed.

1. Once this command is complete, you can shutdown the VM any time if you like.

## Ongoing development work

1. Run your Development VM

1. Determine which UBOS Linux container to run:

   ```
   % ubosdev-container list
   ```

1. Run your UBOS Linux container:

   ```
   % ubosdev-container run --name <name>
   ```

   where `<name>` is one of the names from the list, e.g. `ubos-mesh-develop-red`.

   This gives you console access to the container. You can shut it down with `^]`.

1. Connect with the Netbeans debugger:

   This requires that the Java VM was started with the default debugging flag. This flag
   is set by default in the default {{% gl Site_JSON %}} that's deployed when you
   create a container with ``--flavor mesh``.

   * Run NetBeans
   * Menu "Debug" / "Attach Debugger"
   * Select Debugger: "Java Debugger (JPDA)"
   * Select Connector: "Socket Attach (Attaches by socket to other VMs)"
   * Host: name of your container, e.g. `ubos-mesh-develop-red`
   * Port: 7777

