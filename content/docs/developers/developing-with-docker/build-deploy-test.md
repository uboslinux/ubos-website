---
title: The Build-Deploy-Test cycle with the two-container setup
weight: 20
---

1. **Log into the development container:**

   Log into the development container ``ubos-develop`` if you aren't already:

   ```
   docker -i -t exec ubos-develop /bin/bash
   ```

   You are user ``ubosdev`` in this container. Your project's directory is
   in sub-directory ``project`` of ``ubosdev``'s home directory, and automatically
   synchronized between the container and the host.

1. **Build your project's package:**

   ```
   cd <<your-package-directory>>
   makepkg
   ```

   where ``<<your-package-directory>>`` is the directory that contains
   your {{% gl package %}}'s ``PKGBUILD``.

   You may need to use certain flags for ``makepkg``, such as:

   * `-f`: Rebuild, even if the package was previously built in this version
   * `-C`: remove old build artifacts before running the build

1. **Deploy your code to the ``ubos-target`` run and test container:**

   Assuming the name of your package is ``mypackage``, execute:

   ```
   ubos-push --host ubos-target mypackage.*.pkg*
   ```

   This will backup and then {{% gl deployment "undeploy all" %}} deployed
   {{% gls app %}}, {{% gls accessory %}} and {{% gls site %}} in container
   ``ubos-target``, upload and install your new package, and then redeploy
   the {{% gls site %}} and restore their data into the same configuration
   in which they were before.

   This is identical to what would happen if the user had run
   ``ubos-admin update`` on their {{% gl device %}}, except that
   UBOS does not make any changes to packages other than the ones
   provided to the ``ubos-push`` command.

   Of course, if you `ubos-push` your package to a pristine ``ubos-target``
   container, no {{% gl site %}} will be deployed yet, and so you may need to do
   that first, with a command such as:

   ```
   ssh -t shepherd@ubos-target sudo ubos-admin createsite
   ```

   answering the questions as they are asked. We recommend you deploy
   your {{% gl site %}} at {{% gl wildcard_hostname %}} ``*``, to make it
   easier to access it with the Docker-mapped port at ``http://localhost:8080/``.

1. **Access your site with a browser:**

    Go to ``http://localhost:8080/``. The Docker configuration in
    the Docker compose file maps this location to port 80 on your
    ``ubos-target`` container.

