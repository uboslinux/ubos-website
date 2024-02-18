---
title: Developing using Arch Linux using UTM on Apple Silicon with a systemd-nspawn container
breadcrumbtitle: With Arch Linux, systemd-nspawn, UTM on Apple Silicon
weight: 40
---

## Summary of the setup

{{% note %}}
This setup is for [UTM](https://docs.getutm.app/) users on Apple Silicon, such as the newer
Macs. It does not work on x86_64 Macs or PCs.
{{%/ note %}}

In brief:

* Download a virtual machine and run it in UTM. It has all the tools you
  are going to need pre-installed -- build tools, git, IDE etc.
* In the virtual machine, run a single script, and you will have a UBOS Mesh
  site running that's even pre-configured for debugging.

Easy, right?

## Steps in detail

1. Download the this virtual appliance file:
   http://depot.ubos.net/ubosdev/ubosdev-aarch64-FIXME.utm (1.5GB)

1. Open the file with Parallels. A `ubosdev` VM will show up in the Parallels Control
   Center.

1. Double-click the VM icon. This will unpack the file into the format that Parallels
   needs to run it.

1. Right-click the VM icon and select "Configure ...". Make adjustments as needed for
   your situation, such as how many CPUs the VM may use on your host, and how much
   memory.

1. Start the VM.

1. If the VM doesn't open a window on its own, double-click the VM icon.

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

1. Fix the permissions on the home directory (current bug in the setup):

   ```
   % sudo chmod 755 ~ubosdev
   ```

1. Set up the UBOS development environment by running:

   ```
   % ubosdev-container setup --channel red --flavor mesh
   ```

   Use `--flavor mesh` if you plan to do UBOS Mesh development or you aren't certain.

   Note the argument specifying the `red` release channel; the `yellow` default one
   does not work yet.

   This might take 5-30 min, depending on your network, computer and disk speed.

1. Once this command is complete, you can shutdown the VM any time if you like.

## Setting up a container for development

1. Determine which container templates you have available (that depends on the
   previous step):

   ```
   % ubosdev-container list-templates
   ```

1. Instantiate one of the available templates into a container to be used for
   development, such as:

   ```
   % ubosdev-container create --name ubosdev-red --template ubos-develop-red
   ```

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

1. To edit your code, IDEs `geany` is pre-installed on your development VM. NetBeans
   isn't currently in the Arch Linux ARM repos; to install, "Download from mirror"
   [here](https://archlinux.org/packages/community/any/netbeans/) and then
   ``sudo pacman -U netbeans*.pkg*``.

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

