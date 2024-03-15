---
title: How to create a UBOS development VM for VirtualBox on `x86_64`
weight: 20
breadcrumbtitle: VirtualBox VM on `x86_64_
---

{{% note %}}
In our experience, VirtualBox on ARM is currently not mature enough yet to be used,
so use this recipe for on `x86_64` hosts only.
{{% /note %}}

### Install VirtualBox

1. Download and install [VirtualBox](https://virtualbox.org/) if you have not done so already.

### Obtain an Arch Linux image

1. Download an ISO from a mirror listed on https://archlinux.org/download/
   (e.g. `archlinux-2024.03.01-x86_64.iso`)

### Run the Arch Linux ISO as the virtual machine to create the development VM with

1. In VirtualBox, create a new virtual machine:

   * Click “New”.

   * Enter name: “ubosdev”.

   * ISO Image: select the ISO image you downloaded

   * Type: select “Linux”

   * Version: select “Arch Linux (64 bit)”.

   * Ignore section "Unattended install"

   * Section "Hardware": base memory 4GB

   * 2 CPUs

   * Leave "Enable EFI (special OSes only)" unchecked

   * Section "Hard Disk": "Create a Virtual Hard Disk Now"

   * with 60 GB. This only means the disk may grow up to 60GB, not that it starts out
     that large.

   * Disk type: VDI "(VirtualBox Disk Image)"

   * "Finish"

1. Click "Start" to start the virtual machine, accept the defaults in the boot loader (or just wait)
   and wait until the boot sequence ends and the root shell appears.

### Install Arch on the empty disk and configure it

1. Zero out the first bytes on the disk for extra robustness:

   ```
   # dd if=/dev/zero of=/dev/sda bs=1M count=8 conv=notrunc
   ```

1. Clear the partition table:

   ```
   # sgdisk --clear /dev/sda
   ```

1. Create the partitions (UEFI, /boot and /) and change them to the right types:

   ```
   # sgdisk --new=1::+1M /dev/sda
   # sgdisk --new=2::+512M /dev/sda
   # sgdisk --new=3:: /dev/sda
   # sgdisk --typecode=1:EF02 /dev/sda
   # sgdisk --typecode=2:EF00 /dev/sda
   ```

1. Make sure changes are in effect:

   ```
   # sync
   # partprobe /dev/sda
   ```

1. Create filesystems for partitions other than the UEFI partition:

   ```
   # mkfs.vfat  /dev/sda2
   # mkfs.btrfs /dev/sda3
   ```

1. Mount the partitions so we can install:

   ```
   # mount /dev/sda3 /mnt
   # mkdir /mnt/boot
   # mount /dev/sda2 /mnt/boot
   ```

1. Perform the actual install:

   ```
   # pacstrap /mnt base
   ```

1. Generate the right `fstab`:

   ```
   # genfstab -U -p /mnt >> /mnt/etc/fstab
   ```

1. Chroot into your future root disk and continue the installation:

   ```
   # arch-chroot /mnt
   ```

   1. Add the UBOS keyring so we can install our own packages:

      ```
      # curl -O https://depot.ubosfiles.net/green/$(uname -m)/os/ubos-keyring-0.9-1-any.pkg.tar.zst
      # pacman -U ubos-keyring-0.9-1-any.pkg.tar.zst
      # rm ubos-keyring-0.9-1-any.pkg.tar.zst
      ```

   1. Add the UBOS tools repo:

       ```
       # echo '' >> /etc/pacman.conf
       # echo '[ubos-tools-arch]' >> /etc/pacman.conf
       # echo 'Server = https://depot.ubosfiles.net/green/$arch/ubos-tools-arch' >> /etc/pacman.conf'
       ```

   1. Install more packages:

       ```
       # pacman -Sy
       # pacman -S sudo vim btrfs-progs virtualbox-guest-utils \
         gdm gnome-console gnome-control-center gnome-session gnome-settings-daemon \
         gnome-shell gnome-keyring nautilus \
         ubos-tools-arch
       ```

       When asked which alternatives to install, choose the defaults.

   1. Create a ramdisk:

       ```
       # mkinitcpio -p linux
       ```

   1. Configure the boot loader:

       ```
       # bootctl --path /boot install
       ```

    1. Install a locale:

       ```
       # perl -pi -e 's!#en_US.UTF-8 UTF-8!en_US.UTF-8 UTF-8!' /etc/locale.gen
       # locale-gen
       ```

   1. Set up networking:

       ```
       # echo '[Match]' > /etc/systemd/network/wired.network
       # echo 'Name=en*' >> /etc/systemd/network/wired.network
       # echo '' >> /etc/systemd/network/wired.network
       # echo '[Network]' >> /etc/systemd/network/wired.network
       # echo 'DHCP=ipv4' >> /etc/systemd/network/wired.network
       # echo 'IPForward=1' >> /etc/systemd/network/wired.network

       # systemctl enable systemd-networkd systemd-resolved
       ```

   1. Create a user with the right permissions and no password:

       ```
       # useradd -m ubosdev
       # chmod 755 ~ubosdev
       # passwd -d ubosdev
       # echo ubosdev ALL = NOPASSWD: ALL > /etc/sudoers.d/ubosdev
       # chmod 600 /etc/sudoers.d/ubosdev
       ```

   1. No root password:

       ```
       # passwd -d root
       ```

   1. Exit from the `arch-chroot` shell with `^D`.

1. Remainder of networking setup:

   ```
   # rm /mnt/etc/resolv.conf
   # ln -s /run/systemd/resolve/resolv.conf /mnt/etc/resolv.conf
   ```

1. Configure UEFI:

   * Loader configuration:

   ```
   # echo timeout 4 > /mnt/boot/loader/loader.conf
   # echo default arch >> /mnt/boot/loader/loader.conf
   ```

   * Boot entry configuration:

   ```
   # echo title Arch > /mnt/boot/loader/entries/arch.conf
   # echo linux /vmlinuz-linux >> /mnt/boot/loader/entries/arch.conf
   # echo initrd /initramfs-linux.img >> /mnt/boot/loader/entries/arch.conf
   # echo options root=PARTUUID=$(lsblk -o PARTUUID /dev/sda3 | tail -1 ) rw >> /mnt/boot/loader/entries/arch.conf
   ```

1. Power off the virtual machine:

   ```
   # systemctl poweroff
   ```

1. Remove the ISO file from the VM by clicking on the "[Optical Drive]" in "Storage" and
   selecting "remove".

{{% note %}}
IMPORTANT: Now set Settings / System /  "Enable EFI (special OSes only)", otherwise
the newly installed VM won't boot.
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

When you start it next, your virtual machine will be in the same state as the pre-configured
development VM described in {{% pageref "/docs/development/setup/" %}}. Continue there.

### Create a virtual appliance for distribution

1. In VirtualBox, right-click on the powered-off virtual machine `ubosdev`, and select
   "Export to OCI...".

1. In "Format settings", select "Open Virtualization Format 2.0"

1. Change the file name:

   * add the current date into the file name and the processor architecture, e.g.
     `ubosdev-x86_64-20221121.ova`.

   * Make sure to write into a directory that VirtualBox has access to, such as
     `~/VirtualBox VMs` -- VirtualBox may not have access to the `~/Documents` folder
     on the Mac and produce an obscure error message.

1. In "MAC Address Policy", select "Strip all network adapter MAC addresses".

1. In "Additionally", select "Write Manifest file" but not "Include ISO image files"
   and click "Next".

1. In the "Appliance settings", accept the defaults and click "Finish".

1. Writing the file will take a bit.

### Distribute the virtual appliance file

Upload the created `ubosdev-xxxx.ova` file with a command such as:

```
% s3cmd --no-guess-mime-type put ubosdev-xxx.ova s3://depot-ubosfiles/ubosdev/
```
