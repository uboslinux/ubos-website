---
title: Run UBOS with Docker
weight: 40
---

UBOS is available on the Docker hub. To run UBOS using Docker:

1. Make sure you have a reasonably recent Docker installation on your machine.

1. Boot UBOS with a command such as this:

   ```
   % docker run -i -t --privileged -p 8080:80 ubos/ubos-green
   ```

   <div class="admonition note"><p class="admonition-title">Note</p>
   <p>Depending on your Docker installation, you may need to run this
   command with <code>sudo</code>.</p></div>

   While that looks somewhat intimidating, all this command really says is: "Boot the image called
   ``ubos/ubos-green``, keep the terminal around, give it the privileges it needs, and
   let me access it with a web browser through my local 8080 port."

   As UBOS is a full operating system, not just an application running in a container, it
   needs the ``--privileged`` flag.

1. When the boot process is finished, log in as user ``root``.
   For password, see {{% pageref "/docs/operation/faq-howto-troubleshooting/howto-root.md" %}}. Alternatively, execute
   ``docker exec -i -t <name> /bin/bash`` or such in a separate terminal to obtain a
   root shell in the container.

1. Now: wait. UBOS needs to generate a few cryptographic keys before it is ready to use
   and initialize a few other things on the first boot. That might take a few minutes.
   To determine whether UBOS ready, execute:

   ```
   % systemctl is-system-running
   ```

   The Docker container takes entropy from the host computer, so make sure the host system
   provides enough. Depending your Linux distro, you may be able to generate more by
   typing on the keyboard, moving the mouse, generating hard drive activity etc. You can
   also run:

   ```
   % sudo systemctl start haveged
   ```
   on your host (not in your Docker container).

1. Check that your Docker container has acquired an IP address:

   ```
   % ip addr
   ```

   Make sure you are connected to the internet before attempting to proceed.

1. Update UBOS to the latest and greatest:

   ```
   % sudo ubos-admin update
   ```

1. You are now ready for {{% pageref "/docs/operation/firstsite.md" %}}.

1. To shut down your Docker container, execute

   ```
   % systemctl poweroff
   ```
