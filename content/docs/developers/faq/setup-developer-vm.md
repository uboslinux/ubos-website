---
title: How to create a UBOS development VM for VirtualBox
weight: 2000
---

### Run the Arch Linux ISO as the virtual machine to create the appliance with

1. Download an ISO from a mirror listed on https://archlinux.org/download/
   (e.g. archlinux-2022.11.01-x86_64.iso)

1. In VirtualBox, create a new virtual machine:

   * Click “New”.

   * Enter name: “UBOS development”.

   * ISO Image: select the ISO image you downloaded

   * Type: select “Linux”

   * Version: select “Arch Linux (64 bit)”.

   * Ignore section "Unattended install"

   * Section "hardware": base memory 4GB

   * 2 CPUs

   * Leave "Enable EFI (special OSes only)" unchecked

   * Section "Hard Disk": "Create a Virtual Hard Disk Now"

   * with 60 GB

   * Disk type: VDI (VirtualBox Disk Image)

   * "Finish"

1. Start the virtual machine, accept the defaults in the boot loader (or just wait)
   and wait until the boot sequence ends and the root shell appears.

1. Install Arch on the empty disk:

   * Zero out bytes for extra robustness:

     ```
     # dd if=/dev/zero of=/dev/sda bs=1M count=8 conv=notrunc
     ```

   * Clear the partition table:

     ```
     # sgdisk --clear /dev/sda
     ```

   * Create the partitions (UEFI, /boot and /) and change them to the right types:

     ```
     # sgdisk --new=1::+1M /dev/sda
     # sgdisk --new=2::+100M /dev/sda
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

   * Mount the partitions so we can install:

     ```
     # mount /dev/sda3 /mnt
     # mkdir /mnt/boot
     # mount /dev/sda2 /mnt/boot
     ```

   * Perform the actual install:

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

   * Add the UBOS keyring so we can install our own packages

     ```
     # curl -O http://depot.ubos.net/green/$(uname -m)/os/ubos-keyring-0.8-1-any.pkg.tar.xz
     # pacman -U ubos-keyring-0.8-1-any.pkg.tar.xz
     ```

    * Add the UBOS tools repo:

      ```
      # echo '[ubos-tools-arch]' >> /etc/pacman.conf
      # echo 'Server = http://depot.ubos.net/green/$arch/ubos-tools-arch' >> /etc/pacman.conf'
      ```

    * Install more packages:

      ```
      # pacman -Sy
      # pacman -S sudo vim btrfs-progs virtualbox-guest-utils \
        gdm gnome-console gnome-control-center gnome-session gnome-settings-daemon \
        gnome-shell gnome-keyring nautilus \
        ubos-tools-arch
      ```

      When asked which alternatives to install, choose the defaults.

    * Create a ramdisk:

      ```
      # mkinitcpio -p linux
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

    * Create a user:

      ```
      # useradd -m ubosdev
      # passwd -d ubosdev
      # echo ubosdev ALL = NOPASSWD: ALL > /etc/sudoers.d/ubosdev
      # chmod 600 /etc/sudoers.d/ubosdev
      ``

    * No root password:

      ```
      # passwd -d root
      ```

    * Exit from the `arch-chroot` shell with `^D`.

  * Configure UEFI:

    ```
    # echo timeout 4 > /mnt/boot/loader/loader.conf
    # echo default arch >> /mnt/boot/loader/loader.conf

    # echo title Arch > /mnt/boot/loader/entries/arch.conf
    # echo linux /vmlinuz-linux >> /mnt/boot/loader/entries/arch.conf
    # echo initrd /initramfs-linux.img >> /mnt/boot/loader/entries/arch.conf
    # echo options root=PARTUUID=$(lsblk -o PARTUUID /dev/sda3 | tail -1 ) rw >> /mnt/boot/loader/entries/arch.conf
    ```

  * Set up networking:

    ```
    # rm /mnt/etc/resolv.conf
    # ln -s /run/systemd/resolve/resolv.conf /mnt/etc/resolv.conf
    # arch-chroot /mnt systemctl enable systemd-networkd systemd-resolved

    # echo '[Match]' > /mnt/etc/systemd/network/wired.network
    # echo 'Name=en*' >> /mnt/etc/systemd/network/wired.network
    # echo '' >> /mnt/etc/systemd/network/wired.network
    # echo '[Network]' >> /mnt/etc/systemd/network/wired.network
    # echo DHCP=ipv4 >> /mnt/etc/systemd/network/wired.network
    # echo IPForward=1 >> /mnt/etc/systemd/network/wired.network
    ```

1. Power off the virtual machine:

   ```
   # systemctl poweroff
   ```

1. Remove the ISO file from the VM by clicking on the "[Optical Drive]" in "Storage" and
   selecting "remove".

{{% note %}}
IMPORTANT: Now set Settings / System /  "Enable EFI (special OSses only)"
{{% /note %}}

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

1. The virtual machine is ready, presumably in `~/VirtualBox VMs/UBOS Development/UBOS Development.vdi`

1. Compress the file with `xz` and upload it.
For how to use this VM, go to {{% pageref "/docs/developers/setup/virtualbox.md" %}}.
