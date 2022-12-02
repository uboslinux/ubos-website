---
title: How to create a UBOS development VM for Parallels on Apple Silicon
weight: 2010
---

### Run the Arch Linux ARM ISO as the virtual machine to create the appliance with

1. Download the ISO with the string "local" in it from https://pkgbuild.com/~tpowa/archboot/iso/aarch64/latest/
   (I had issues with the other ISOs in Nov 2022)

1. In Parallels, create a new virtual machine:

   * Click “+”.

   * Select "Install Windows or another OS from a DVD or image file", and "Continue".

   * Select "Choose Manually"*

   * Click "select a file" and select the downloaded ISO.

   * Ignore "Unable to detect operating system" and "Continue"

   * Select "Other Linux"

   * Enter name: “ubosdev”, check "Customize settings before installation",
     accept the other defaults, and "Create".

   * In the "Hardware" tab, enter 8192 MB for "Memory". (4096 produces a very strange
     error message later in the boot.)

   * Close the popup and click "Continue".

1. The VM automatically starts. Accept the defaults in the boot loader (or just wait).
   and wait until first the boot sequence ends, and then the "Starting assembling of
   archboot environment ..." with its 9 steps ends, and it asks you to hit ENTER.

1. Install Arch on the empty disk:

   * Do not use the "Archboot Arch Linux Installation" program that comes up. Instead,
     hit "OK" and then select the "Exit Install" option.

   * Zero out the first bytes on the disk for extra robustness:

     ```
     # dd if=/dev/zero of=/dev/sda bs=1M count=8 conv=notrunc
     ```

   * Clear the partition table:

     ```
     # sgdisk --clear /dev/sda
     ```

   * Create the partitions (UEFI, /boot and /) and change them to the right types.
     The boot directory needs more space than on the PC:

     ```
     # sgdisk --new=1::+1M /dev/sda
     # sgdisk --new=2::+512M /dev/sda
     # sgdisk --new=3:: /dev/sda
     # sgdisk --typecode=1:EF02 /dev/sda
     # sgdisk --typecode=2:EF00 /dev/sda
     ```

   * Make sure changes are in effect:

     ```
     # sync
     # partprobe /dev/sda
     ```

   * Create filesystems for partitions other than the UEFI partition:

     ```
     # mkfs.vfat  /dev/sda2
     # mkfs.btrfs /dev/sda3
     ```

     There may be warnings about "Cannot initialize conversion from codepage..." but they
     appear to be harmless and can be ignored.

   * Mount the partitions so we can install:

     ```
     # mount /dev/sda3 /mnt
     # mkdir /mnt/boot
     # mount /dev/sda2 /mnt/boot
     ```

   * Perform the actual install of the base packages:

     ```
     # pacstrap /mnt base
     ```

   * Generate the right `fstab`:

     ```
     # genfstab -p /mnt >> /mnt/etc/fstab
     ```

   * Chroot into your future root disk and finish the installation:

     ```
     # arch-chroot /mnt
     ```

   * Add the UBOS keyring so we can install our own packages:

     ```
     # curl -O http://depot.ubos.net/green/$(uname -m)/os/ubos-keyring-0.8-1-any.pkg.tar.xz
     # pacman -U ubos-keyring-0.8-1-any.pkg.tar.xz
     # rm ubos-keyring-0.8-1-any.pkg.tar.xz
     ```

    * Add the UBOS tools repo:

      ```
      # echo '' >> /etc/pacman.conf
      # echo '[ubos-tools-arch]' >> /etc/pacman.conf
      # echo 'Server = http://depot.ubos.net/green/$arch/ubos-tools-arch' >> /etc/pacman.conf'
      ```

    * Install more packages:

      ```
      # pacman -Sy
      # pacman -S linux-aarch64 mkinitcpio amd-ucode sudo vim btrfs-progs \
        gdm gnome-console gnome-control-center gnome-session gnome-settings-daemon \
        gnome-shell gnome-keyring nautilus \
        ubos-tools-arch
      ```

      When asked which alternatives to install, choose the defaults.

      If there is a warning about a directory below `/usr/lib/perl5`, ignore that.
      It needs fixing but doesn't currently hurt.

    * Create a ramdisk:

      ```
      # mkinitcpio -p linux-aarch64
      ```

    * Configure the boot loader:

      ```
      # bootctl --path /boot install
      ```

    * Install a locale:

      ```
      # perl -pi -e 's!#en_US.UTF-8 UTF-8!en_US.UTF-8 UTF-8!' /etc/locale.gen
      # locale-gen
      ```

    * Set up networking:

      ```
      # echo '[Match]' > /etc/systemd/network/wired.network
      # echo 'Name=en*' >> /etc/systemd/network/wired.network
      # echo '' >> /etc/systemd/network/wired.network
      # echo '[Network]' >> /etc/systemd/network/wired.network
      # echo 'DHCP=ipv4' >> /etc/systemd/network/wired.network
      # echo 'IPForward=1' >> /etc/systemd/network/wired.network

      # systemctl enable systemd-networkd systemd-resolved
      ```

    * Create a user:

      ```
      # useradd -m ubosdev
      # chmod 755 ~ubosdev
      # passwd -d ubosdev
      # echo ubosdev ALL = NOPASSWD: ALL > /etc/sudoers.d/ubosdev
      # chmod 600 /etc/sudoers.d/ubosdev
      ```

    * No root password:

      ```
      # passwd -d root
      ```

    * Exit from the `arch-chroot` shell with `^D`.

  * Remainder of networking setup:

    ```
    # rm /mnt/etc/resolv.conf
    # ln -s /run/systemd/resolve/resolv.conf /mnt/etc/resolv.conf
    ```

  * Configure UEFI:

    ```
    # echo timeout 4 > /mnt/boot/loader/loader.conf
    # echo default arch >> /mnt/boot/loader/loader.conf

    # echo title Arch > /mnt/boot/loader/entries/arch.conf
    # echo linux /Image >> /mnt/boot/loader/entries/arch.conf
    # echo initrd /amd-ucode.img >> /mnt/boot/loader/entries/arch.conf
    # echo initrd /initramfs-linux.img >> /mnt/boot/loader/entries/arch.conf
    # echo options root=PARTUUID=$(lsblk -o PARTUUID /dev/sda3 | tail -1 ) rootfstype=btrfs rw cgroup_disable=memory add_efi_memmap >> /mnt/boot/loader/entries/arch.conf
    ```

1. Power off the virtual machine:

   ```
   # systemctl poweroff
   ```

1. Remove the ISO file from the VM:

   * In the Parallels Control Center, click on the gears icon next to the "ubosdev" VM
   * Select CD/DVC
   * In the "Source" drop-down, select Disconnect.
   * Close the Configuration window

### Remaining configuration

1. Start the VM again.

1. At the console, log in as `ubosdev`. There is no password.

1. Fix the locale (command won't run earlier)

   ```
   % sudo localectl set-locale LANG=en_US.UTF-8
   ```

1. Enable Gnome:

   ```
   % sudo systemctl enable gdm
   ```

1. Power off the virtual machine:

   ```
   % sudo systemctl poweroff
   ```

### Create a virtual appliance for distribution

1. In the Parallels Control Center, right-click on the "ubosdev" VM and select
   "Prepare for transfer".

1. Click "Continue" and wait for the "Packing" process to finish. The VM now
   has subtitle "Package" and the gears icon has disappeared.

1. Right-click on the VM again, and select "Show in Finder".

1. Copy the file. Rename the copy and add the current date into the file name and
   the processor architecture, e.g. `ubosdev-aarch64-20221123.pvmp`.

1. Upload the created `ubosdev-xxxx.pvmp` file.

For how to use this VM, go to {{% pageref "/docs/developers/setup/parallels.md" %}}.
