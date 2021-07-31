---
title: Continuing the Arch Linux installation on a PC or virtual machine
weight: 30
---

This section assumes that you have prepared your PC or virtual machine as
described in {{% pageref prepare-arch-pc.md %}} or {{% pageref prepare-arch-virtualbox.md %}}.

1. Once the boot process has finished and you get a root shell, you are not done: you only
   managed to boot from the install disk image, you do not have a runnable system yet. In
   this respect, ArchLinux is different from other Linux distros.

1. In the shell that came up, perform the actual installation. The following steps should
   work. If you need more information, consult the
   [Arch Linux installation guide](https://wiki.archlinux.org/index.php/Installation_Guide).

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
      # sgdisk --new=2::+100M /dev/sda
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
        #   pacman -S grub sudo vim
        ```

        If asked, choose to install from the ``core`` repository.

      * If you are on VirtualBox, also install the VirtualBox client tools:

        ```
        #   pacman -S virtualbox-guest-utils
        ```

        If asked, choose to install from the ``core`` repository.

      * Create a Ramdisk:

        ```
        #   mkinitcpio -p linux
        ```

      * Configure the Grub boot loader for legacy (BIOS) boot:

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

      * Create file ``/boot/loader/loader.conf`` with content:

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
        options root=PARTUUID=XXX rw
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

        Set this locale as the system locale:

        ```
        #   localectl set-locale LANG=en_US.UTF-8
        ```

      * Set a root password:

        ```
        #   passwd
        ```

        or set no password for root if you think you are secure enough without:

        ```
        #   passwd -d root
        ```

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
