---
title: Developing using Arch Linux on VirtualBox x86_64 with a systemd-nspawn container
weight: 30
---

## Summary of the setup

{{% note %}}
This setup is for VirtualBox users on x86_64 hardware, such as Intel Macs,
Intel Windows PCs, and Intel Linux boxes. It does not work on Apple Silicon.
{{%/ note %}}

In brief:

* Download a virtual machine and run it in VirtualBox. It has all the tools you
  are going to need pre-installed -- build tools, git, IDE etc.
* In the virtual machine, run a single script, and you will have a UBOS Mesh
  site running that's even pre-configured for debugging.

Easy, right?


## Steps in detail

1. Download the this virtual appliance file:
   http://depot.ubos.net/ubosdev/ubosdev-x86_64-20221122.ova (1.5GB)

1. In VirtualBox, select "File" / "Import Appliance..."

1. Source: "Local File System" and then select the downloaded file. Select "Next".

1. Select "MAC Address Policy:" "Generate new MAC addresses for all network adapters"
   and "Import hard drives as VDI". Select "Finish".

1. Importing the appliance will take a little bit of time. It will show up in the
   list of VMs as `ubosdev 1` or such.

1. Start the VM.

1. Logon as `ubosdev`, there is no password. `root` does not have a password either: we
   assume that's safe enough on your computer. If you don't think so, set one :-)

1. Pick a better screen resolution:

   * In "Search", type "Settings" and run it.
   * If there's an error message saying "Oops, something has gone wrong" about Network
   settings: ignore it, we are not running Network manager.
   * Select "Displays" and pick a resolution that makes sense for your computer setup.
   * Close the settings app.

1. In "Search", type "Console" and run it (you get the "Search" by selecting
   "Activities" in the menu bar).

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

1. Run your Development VM.

1. Determine which UBOS Linux container to run:

   ```
   % ubosdev-container list
   ```

1. Run your UBOS Linux container:

   ```
   % ubosdev-container run --name <name>
   ```

   where `<name>` is one of the names from the list, e.g. `ubos-mesh-red`.

   This gives you console access to the container. You can shut it down with `^]`.

1. Access any deployed web app there from your development VM with the name
   of the container, e.g. `http://ubos-mesh-red/`. Firefox is pre-installed on
   the VM.

1. To edit your code, IDEs `geany` and `netbeans` are pre-installed on your
   development VM.

1. To open up a shell inside your development container, open a new terminal and
   execute:

   ```
   % sudo machinectl shell ubosdev@ubos-mesh-red
   ```

   if `ubos-mesh-red` is the name of your container.

1. To build your UBOS Mesh code, run the UBOS Mesh tools inside your development container:

   ```
   % mesh-clean
   % mesh-build
   % mesh-test
   ```

1. To debug your UBOS Mesh code, connect with the Netbeans debugger:

   This requires that the Java VM was started with the default debugging flag. This flag
   is set by default in the default {{% gl Site_JSON %}} that's deployed when you
   create a container with ``--flavor mesh``.

   * Run NetBeans
   * Menu "Debug" / "Attach Debugger"
   * Select Debugger: "Java Debugger (JPDA)"
   * Select Connector: "Socket Attach (Attaches by socket to other VMs)"
   * Host: name of your container, e.g. `ubos-mesh-develop-red`
   * Port: 7777

1. To shut down your container, in the terminal where you run it, hit `^]` three
   times in quick succession.

