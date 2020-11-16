---
title: Run UBOS with Docker
weight: 40
---

UBOS is available on the Docker hub. To run UBOS using Docker:

1. Make sure you have a reasonably recent Docker installation on your machine.

1. Boot UBOS with a command such as this:

   ```
   % docker run \
       -i -t \
       --cap-add NET_ADMIN --cap-add NET_BIND_SERVICE --cap-add NET_BROADCAST \
       --cap-add NET_RAW --cap-add SYS_ADMIN \
       -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
       -e container=docker \
       ubos/ubos-green \
       /usr/lib/systemd/systemd
   ```

   While that looks somewhat intimidating, all this command really says is: "Boot the image called
   ``ubos/ubos-green``, keep the terminal around, and give it the privileges it needs."

1. When the boot process is finished, log in as user ``root``.
   For password, see {{% pageref "/docs/users/faq-howto-troubleshooting/howto-root.md" %}}. Alternatively, execute
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

1. You are now ready for {{% pageref "/docs/users/firstsite.md" %}}.

1. To shut down your Docker container, execute

   ```
   % systemctl poweroff
   ```

## About that run command

If you are interested in the details of the complicated run command, let's unpack it:

<table>
 <tr>
  <td>
   <code>docker run</code>
  </td>
  <td>
   Run a Docker image.
  </td>
 </tr>
 <tr>
  <td>
   <code>-i -t</code>
  </td>
  <td>
   Keep a terminal open on the command-line, so you can log into UBOS.
  </td>
 </tr>
 <tr>
  <td>
   <code>--cap-add NET_ADMIN ...</code>
  </td>
  <td>
   Grant certain needed capabilities to the container running UBOS. These
   are required so UBOS can manage networking using <code>systemd-networkd</code>
   and its firewall using <code>iptables</code>.
  </td>
 </tr>
 <tr>
  <td>
   <code>--v /sys/fs/cgroup:/sys/fs/cgroup:ro</code>
  </td>
  <td>
   Make the "cgroup" device hierarchy available to the container in read-only
   mode. This is needed so Docker can successfully boot an entire operating system
   like UBOS.
  </td>
 </tr>
 <tr>
  <td>
   <code>-e container=docker</code>
  </td>
  <td>
   Tell UBOS that it is running under Docker.
  </td>
 </tr>
 <tr>
  <td>
   <code>ubos/ubos-green</code>
  </td>
  <td>
   The UBOS version to download and to run. Here we run the most recent release of UBOS
   on the "green" {{% gl Release_Channel %}}. To see what UBOS versions are available via Docker,
   go to the UBOS section on the [Docker hub](https://hub.docker.com/u/ubos/).
  </td>
 </tr>
 <tr>
  <td>
   <code>/usr/lib/systemd/systemd</code>
  </td>
  <td>
   Run systemd, which will start the UBOS operating system, instead of running some other
   kind of command.
  </td>
 </tr>
</table>

P.S. If you understand Docker better than we do, and there is a way of making the above
command-line shorter, please do [let us know](/community/). Thank you!
