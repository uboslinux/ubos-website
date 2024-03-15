---
title: How to create a UBOS development VM for UTM on `x86_64` Apple computers
weight: 30
breadcrumbtitle: UTM VM on `x86_64` Apple
---

### Install UTM

1. Download and install [UTM](https://docs.getutm.app/) if you have not done so already.

### Obtain an Arch Linux image

1. Download an ISO from a mirror listed on https://archlinux.org/download/
   (e.g. `archlinux-2024.03.01-x86_64.iso`)

{{% warning %}}
Do not use the UTM-provided Arch Linux ARM image. It would run slowly in emulation mode
on an `x86_64` computer, and in our experience, has reliability issues.
{{% /warning %}}

### Run the Arch Linux ISO as the virtual machine to create the development VM with

1. In UTM, create a new virtual machine:

   * Click "Create a New Virtual Machine".

   * Select "Virtualize" (not "Emulate").

   * In "Operating System", select "Linux".

   * In "Linux", in the section "Boot ISO Image", browse to your downloaded ISO file and select that.
     Leave the options unchecked. Click "Continue".

   * In "Hardware", accept the default and click "Continue."

   * In "Storage", enter 60GB as the "size of the drive". Click "Continue".

   * In "Shared Directory", click "Continue".

   * In "Summary":

     * Change the name to "ubosdev".

     * Select "Open VM Settings"

     * Click "Save".

   * In the now-open settings dialog:

     * In the outline on the left, select the second "IDE Drive" (the one whose Image Type is
       "Disk Image", not "CD/DVD") and click "Delete". The wizard creates a virtual IDE drive,
       but we want something else.

     * In the outline on the left, section "Drives", click "New", and then Interface "VirtIO"
       and size 60GB. Click "Create".

     * Click "Save".

1. Now select "ubosdev" in the sidebar, and start it by clicking
   the run icon (">"). Accept the defaults in the boot loader (or just wait)
   and wait until the boot sequence ends and the root shell appears.

###  Install Arch on the empty disk and configure it


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
       # pacman -S linux mkinitcpio sudo vim btrfs-progs spice-vdagent qemu-guest-agent \
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

1. Select VM "ubosdev" in the outline, and the at the bottom in the right page, in the CD/DVD
   popup menu, select "Clear".

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

1. Detach the newly created root disk for `ubosdev`.

   UTM has no direct functionality for this ([issue filed](https://github.com/utmapp/UTM/issues/5841)),
   so we have to do it manually.

   * In UTM, select VM "ubosdev". In the popup, select "Show in Finder".

   * Quit UTM.

   * In the Finder, keep "ubosdev.utm" selected and in the popup, select "Show package contents".

   * In the Finder, open "config.plist" with a text editor.

   * In the first `array`, there are three `dict`s representing virtual hard drives.
     In the third `dict`, note the `string` for the `key` `ImageName`: this is the name
     of the file that contains the new boot disk. This name will be a long UUID-style name.

   * Leave the text editor open. In the Finder, open subdirectory "Data", and find the
     file whose name you identified in the previous step. Move this file out of the
     current directory into a temporary location; do not delete the file.

   * In the text editor, delete this third `dict` in its entirety.

   * Save "config.plist" and close the text editor.

1. Clone the bootstrap VM

   UTM also doesn't have much built-in functionality for this, so we use our existing,
   working VM as the template.

   * Start UTM again.

   * Run the Arch Linux VM, and make sure it boots without problem. Log in back as
     "root" / "root" and shut it back down with `systemctl poweroff`.

   * In UTM, select the Arch Linux VM, and in the popup, select "Clone" and confirm.

   * The cloned VM is now selected in UTM. In the popup, select "Edit".

   * Change the name to "ubosdev (ArchLinux)"

   * In the "System" tab, change the memory to 8192MB and save.

   * Select VM "ubosdev", and in the popup, select "Show in Finder"

   * Quit UTM.

   * In the Finder, keep "ubosdev (ArchLinux).utm" selected, and in the popup, select "Show Package Contents".

   * Open "config.plist" with a text editor.

   * In the first `array`, there are two `dict` elements. In the second of those elements,
     note the value for the `ImageName`.

   * In the Finder, select the "Data" directory. It should contain a file with the just
     noted name. Delete that file.

   * In the Finder, move to that same "Data" directory the file you previously put into
     a temporary location.

   * In the text editor, in the first array, in the second `dict` element,
     replace `string`s for keys `Identifier` and `ImageName` with the name of the
     file you previously put into a temporary location and now moved into "Data".
     Note that the `Identifier` does not want the extension, while `ImageName` does.

   * Save the plist file.

### Add virtual graphics for the "ubosdev" VM

1. In UTM, select the "ubosdev" VM, and in the popup, "Edit".

1. Under "Devices", click "New..." and "Display"

1. Click "Save".

### Remaining configuration

1. Start UTM again.

1. Start "ubosdev (ArchLinux)" VM.

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

