---
title: LEFTOVER
weight: 400
---

---
title: Prepare a VirtualBox virtual machine to develop for UBOS on Arch Linux
weight: 20
breadcrumbtitle: VirtualBox
---

Use these instructions if you like to create your setup from scratch, rather than
using one of the pre-built UBOS development images as described in
{{% pageref "/docs/development/setup/virtualbox/" %}}.

{{% warning %}}
These instructions require a `x86_64` system. They are unlikely to work on ARM, such as
Apple Silicon.
{{% /warning %}}

First prepare a suitable virtual machine. Installation for VMWare is quite similar although not
documented in detail here (we are sure you can figure it out).

1. [Download VirtualBox from here](https://www.virtualbox.org/wiki/Downloads) and install it
   if you haven't already.

1. Download a 64bit Arch Linux boot image from [here](https://www.archlinux.org/download/),
   such as `archlinux-x86_64.iso` and save it in a convenient place. You only need it for
   the installation and you can delete it later.

1. In VirtualBox, create a new virtual machine:

   * Click "New".

   * Enter name: "ubosdev".

   * ISO Image: select select the ISO image you downloaded.

   * Type: "Linux"

   * Version: "Other Linux (64 bit)"

   * In the "Hardware" section, select the amount of RAM you want to give it. 4096MB is a
     good start, and you can change that later.

   * In the "Hard Disk" section, "Create a Virtual Hard Disk now". We suggest type "VDI"
     with at least 60GB of space. This is dynamically allocated, so if you don't use the full
     60GB, it won't take up as much space on your host system.

   * Click "Finish".

1. Now start the virtual machine by selecting it in the sidebar, and clicking "Start".
   When it asks you, select the Arch Linux boot image ISO file that you downloaded earlier
   as the start-up disk. You need to select the little icon there to get a file
   selection dialog. Click "Start". The virtual machine should now be booting.

1. The Arch Linux boot loader has several options. Accept the default by pressing the Return key.

Continue with {{% pageref install-arch.md %}}.


---
title: Continuing the Arch Linux installation on a physical or virtual machine
weight: 30
---

This section assumes that you have prepared your PC or virtual machine as
described in {{% pageref prepare-arch-pc.md %}}, {{% pageref prepare-arch-virtualbox.md %}}
or {{% pageref prepare-arch-utm.md %}}.

1. Once the boot process has finished and you get a root shell, you are not done: you only
   managed to boot from the install disk image, you do not have a runnable system yet. In
   this respect, ArchLinux is different from other Linux distros.

1. In the shell that came up, perform the actual installation. The following steps should
   work. If you need more information, consult the
   [Arch Linux installation guide](https://wiki.archlinux.org/index.php/Installation_Guide).

   1. Update your boostrap system and make sure you have all packages installed that we
      need later:

      ```
      # pacman -Syu
      # pacman -S btrfs-progs gptfdisk parted dosfstools arch-install-scripts
      ```

      If it asks you a question, accept the defaults.

   1. Determine the name of the actual disk you will be using for your Arch Linux system.
      This is often ``/dev/sda`` but may be something like ``/dev/vdb`` on UTM. ``lsblk``
      may be helpful: look for a disk that is not currently mounted.

      For these instructions, we will assume the disk is ``/dev/sda``. If it isn't in your
      case, make sure to replace it with the correct name in all commands below.

   1. Partition your root disk ``/dev/sda`` in a way that makes sense to you. If you are not
      sure, here is a somewhat complicated scheme (sorry!) that should work with dual BIOS
      and EFI boot. (This could be simpler if we knew more about your PC,  but we don't, and
      so we rather be safe.)

      We start by zeroing out some bytes; sometimes there are strange leftovers from previous
      installs:

      ```
      # dd if=/dev/zero of=/dev/sda bs=1M count=8 conv=notrunc
      ```

      Clear the partition table:

      ```
      # sgdisk --clear /dev/sda
      ```

      Create the partition and change them to the right types:

      ```
      # sgdisk --new=1::+1M /dev/sda
      # sgdisk --new=2::+512M /dev/sda
      # sgdisk --new=3:: /dev/sda
      # sgdisk --typecode=1:EF02 /dev/sda
      # sgdisk --typecode=2:EF00 /dev/sda
      ```

      Make sure changes are in effect:

      ```
      # sync
      # partprobe /dev/sda
      ```

   1. Create filesystems for your partitions 2 and 3 (the first does not need one).
      Partition 2 must be a DOS partition per the UEFI spec. For the 3rd (main) partition,
      you could use any filesystem, but we recommend ``btrfs`` as it is tightly integrated
      with ``systemd-nspawn``, the ``systemd`` container tool. This may save you a
      substantial amount of disk space if you might run several UBOS instances in containers
      later on, e.g. for testing. Execute:

      ```
      # mkfs.vfat  /dev/sda2
      # mkfs.btrfs /dev/sda3
      ```

   1. Mount your future root partition in a place where you can install software:

      ```
      # mount /dev/sda3 /mnt
      ```

      and add the ``/boot`` partition:

      ```
      # mkdir /mnt/boot
      # mount /dev/sda2 /mnt/boot
      ```

   1. Make sure you have a network connection:

      ```
      # ip addr
      ```

      will show whether you have an IP address, and which networking devices
      are available. If you are in VirtualBox and have trouble, here is
      [more information on VirtualBox networking modes](http://www.virtualbox.org/manual/ch06.html).
      By default, your machine is looking for a DHCP server to obtain an
      IP address from on all available network interfaces.

   1. Perform the actual install. This will download and install a lot of packages and
      thus may take a while, depending on your network speed:

      ```
      # pacstrap /mnt base
      ```

      There may be a few messages about locales; ignore them for now.

   1. Create the right ``fstab`` by executing:

      ```
      # genfstab -p /mnt >> /mnt/etc/fstab
      ```

   1. Chroot into your future root disk and finish the installation:

      ```
      # arch-chroot /mnt
      ```

      * If you chose btrfs, install the btrfs tools:

        ```
        #   pacman -S btrfs-progs
        ```

      * You also need a boot loader, ``sudo`` and an editor such as ``vim``:

        ```
        #   pacman -S grub sudo vim mkinitcpio linux
        ```

        If you are given a choice, choose the default.

      * If you are on VirtualBox, also install the VirtualBox client tools:

        ```
        #   pacman -S virtualbox-guest-utils
        ```

        If asked, choose to install from the ``core`` repository.

      * Create a Ramdisk:

        ```
        #   mkinitcpio -p linux
        ```

      * If you are on old physical `x86_64` PC, or you are running VirtualBox, configure
        the Grub boot loader for legacy (BIOS) boot. Skip this step if you can do
        EFI-based boot or if you are on ARM.

        ```
        #   grub-install --target=i386-pc --recheck /dev/sda
        #   grub-mkconfig -o /boot/grub/grub.cfg
        ```

      * Configure the systemd boot loader for modern (UEFI) boot:

        ```
        #   bootctl --path /boot install
        ```

      * UEFI boot needs some more data. Create directory ``/boot/loader/entries`` if it does
        not exist yet:

        ```
        #   mkdir /boot/loader/entries
        ```

      * Create file ``/boot/loader/loader.conf``, using an editor like ``vim`` with content:

        ```
        timeout 4
        default arch
        ```

      * Determine the PARTUUID of the root partition (not: disk) and put it into the to-be-edited
        file that will need it:

        ```
        #   lsblk -o PARTUUID /dev/sda3 > /boot/loader/entries/arch.conf
        ```

      * Now edit the created file ``/boot/loader/entries/arch.conf`` so that it looks like
        this, where ``XXX`` is the PARTUUID contained in the file when you first opened it.

        ```
        title Arch
        linux /vmlinuz-linux
        initrd /initramfs-linux.img
        options root=PARTUUID=XXX rw init=/usr/lib/systemd/systemd
        ```

        (sorry, this is a bit more complicated than we'd like; thanks UEFI!)

      * Install a Locale. Edit ``/etc/locale.gen``, and uncomment this line:

        ```
        #en_US.UTF-8 UTF-8
        ```

        so it looks like this:

        ```
        en_US.UTF-8 UTF-8
        ```

        You can also uncomment whatever other locales you might want. Then run:

        ```
        #   locale-gen
        ```

      * Set a root password:

        ```
        #   passwd
        ```

        or set no password for root if you think you are secure enough without:

        ```
        #   passwd -d root
        ```

        Do not skip this step, otherwise you will not be able to log into your system.

      * Exit from the chroot shell with ctrl-d.

   1. Set up networking. There are many options. We recommend using ``systemd-networkd``
      and ``systemd-resolved`` in the way UBOS does it so UBOS containers and the Arch
      Linux host play nicely:

      ```
      # rm /mnt/etc/resolv.conf
      # ln -s /run/systemd/resolve/resolv.conf /mnt/etc/resolv.conf
      # arch-chroot /mnt systemctl enable systemd-networkd systemd-resolved
      ```

      Also create file ``/mnt/etc/systemd/network/wired.network`` with the following
      content:

      ```
      [Match]
      Name=en*

      [Network]
      DHCP=ipv4
      IPForward=1
      ```

      The ``IPForward`` setting is necessary if you plan to run or test UBOS in a
      Linux container, so it can reach the internet.

   1. Shut down the machine:

      ```
      # systemctl poweroff
      ```

   1. While the machine is shut down, remove the installation medium from the drive. If
      you are on VirtualBox, remove the ISO file from the virtual CD/DVD drive. To do that:

      * Select the virtual machine in the sidebar.

      * Click "Settings".

      * Pick the "Storage" tab.

      * In the "Storage Tree", select the virtual CD/DVD drive.

      * In the right pane, click the little CD icon and select
        "Remove disk from virtual drive" in the pop-up that comes up.

      * Click OK.

   1. Then, start the machine again and log on as root with the password you set
      earlier.

   1. Set this locale as the system locale:

      ```
      # localectl set-locale LANG=en_US.UTF-8
      ```

   1. Create a non-root user (example: ``joe``, change as needed). Use this user when
      developing instead of doing everything as ``root``. Also allow the user to become
      ``root`` with ``sudo`` as needed, and set a password for it:

      ```
      # useradd -m joe
      # passwd joe
      # cat > /etc/sudoers.d/joe
      joe ALL = NOPASSWD: ALL
      ^D
      # chmod 600 /etc/sudoers.d/joe
      ```

   1. Install the desktop environment you might want to use. For example, to use
      KDE with the plasma desktop:

      ```
      # pacman -S xorg-server sddm plasma-meta konsole
      # systemctl enable sddm
      ```

      Pick the fonts you like, such as ``ttf-liberation`` or ``noto-fonts``, and
      ``phonon-qt5-gstreamer`` for the QT5 backend.

      However, there have been recent reports that KDE has problems with display
      resolutions in a virtualized environment. So it may be easier to run Gnome
      (and you may prefer that anyway):

      ```
      # pacman -S gnome
      # systemctl enable gdm
      ```

   1. If you are on VirtualBox, enable the VirtualBox client tools:

      ```
      # systemctl enable vboxservice
      ```

Continue to {{% pageref install-ubos-tools.md %}}.











This applies to any physical or virtual machine that runs Arch.

## Add the UBOS tools repository

First, download and install the UBOS keyring, so pacman will allow you to download
and install UBOS tools:

```
% curl -O http://depot.ubosfiles.net/green/x86_64/os/ubos-keyring-0.9-1-any.pkg.tar.zst
% sudo pacman -U ubos-keyring-0.9-1-any.pkg.tar.zst
```

The, as root, edit ``/etc/pacman.conf``, and append, at the end, the following section:

```
[ubos-tools-arch]
Server = http://depot.ubosfiles.net/green/$arch/ubos-tools-arch
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
