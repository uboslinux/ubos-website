---
title: Rapid create/test cycle for UBOS Packages
---

It's important to be able to test {{% gls Package %}} in development quickly. Here's
the setup we use:

* As recommended, use an Arch Linux development host with the UBOS Arch tools
  installed (see {{% pageref "/docs/developers/setting-up-development-machine/" %}})

* Run UBOS in a container started from the development host (see
  {{% pageref "/docs/users/installation/x86_container.md" %}}). It may be
  advantageous to bind your home directory into the container, for example by
  adding ``--bind /home/joe`` to the ``systemd-nspawn`` command that starts
  the container.

* Determine the container's IP address and point a friendly hostname to it.
  In the container:

  ```
  % ip addr
  ```

  On the host, add a line like this:

  ```
  10.0.0.2 testhost
  ```

  to your ``/etc/hosts`` file, assuming the container has IP address
  ``10.0.0.2``. You can also use systemd's built-in local DNS server
  for named containers.

* Install your in-development package in the container. If you have used the
  ``--bind`` option described above, in the container:

  ```
  % sudo pacman -U --noconfirm /home/joe/path/to/your/package.pkg.xz
  ```

* Create a {{% gl Site %}} with the hostname you picked, in the container
  that runs your {{% gl App %}}. In the container:

  ```
  % sudo ubos-admin createsite
  ```

  Specify the test host you picked above, and the name of your package.

* Use a browser on your host to access your {{% gl App %}}, e.g. at ``http://testhost/``.

* When you make changes to your package on the host, update that installed {{% gl App %}}
  in the container by repackaging, and deploying. On the host:

  ```
  % makepkg -f
  ```

  In the container:

  ```
  % sudo ubos-admin update --pkg /home/joe/path/to/your/package.pkg.xz
  ```

  Alternatively, you can use ``ubos-push`` (part of the UBOS tools for Arch) if
  you set up ssh access for the ``shepherd`` account in the container. Then, on the
  host:

  ```
  % ubos-push -h testhost package.pkg.xz
  ```
