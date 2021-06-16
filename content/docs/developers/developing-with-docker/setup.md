---
title: Setting up the two-Docker-container development environment
weight: 10
---

To set this up:

{{% note %}}
Depending on your computer's setup, you may need to prefix
all ``docker`` and ``docker-compose`` commands with ``sudo``.
{{% /note %}}

1. Make sure you have **Docker and Docker Composer installed**.

   For how to do this for your operating system, please refer to the
   [Docker documentation](https://www.docker.com/get-started).

   The description on this poage been tested with Docker Desktop for Macintosh, and the
   Docker command-line tools on Arch Linux. However, we don't see a reason why
   it shouldn't work with other host operating systems.

1. **Add the recommended Docker Compose file** to your working directory:

    In a shell on your development machine, go to the parent directory of the
    directory that contains your project's ``PKGBUILD``. Or, if you are working on
    several packages, go to a common parent directory of all your projects.

    Download [this Docker compose file](https://github.com/uboslinux/ubosdev-docker/docker-compose.yml)
    and save it to this directory.

1. **Start the containers**:

   ```
   docker-compose up
   ```

   Later, when you are done, you can turn off your containers by stopping this
   process with ^C.

1. On `ubos-develop`, **generate an SSH keypair:**

   You will use this key pair to securely deploy the packages you build in
   container ``ubos-develop`` to container ``ubos-run``, where you run and test them.
   There is no advantage of reusing an existing key pair, so create a new one.

   In a separate shell, log into container ``ubos-develop`` as
   preconfigured user ``ubosdev``:

   ```
   docker exec -i -t -u ubosdev ubos-develop /bin/bash
   ```

   Then generate the key pair:

   ```
   ssh-keygen
   ```

   Accept the defaults for where to save the files and empty passphrase.

   Print the public key to the terminal:

   ```
   cat ~/.ssh/id_rsa.pub
   ```
   (Note the file extension ``.pub`` for the public key)

1. On `ubos-target`, **create a shepherd user that permits login from `ubos-develop`**

   In a third shell, log into the run container as ``root``, and set up the
   ``shepherd`` user (the default administrative user on UBOS) with the
   public key printed above on the second terminal:

   ```
   docker exec -i -t ubos-target /bin/bash
   ```

   And then, execute:

   ```
   ubos-admin setup-shepherd --add-key
   ```

   When prompted, copy-paste the multi-line public key string from above into the terminal,
   and end the multi-line input with ^D.

   You do not need this third shell on ``ubos-run`` any more, and can close
   it now. However, it is sometimes useful to watch the system log on the
   ``ubos-run`` system, so perhaps you want to keep it open while
   running a command such as ``journalctl -f``.

1. **Test the ssh setup**

   In the shell on ``ubos-develop``, execute:

   ```
   ssh -t shepherd@ubos-target whoami
   ```

   After the initial ssh authenticity warnings, this should print: "shepherd".

The setup is complete. You can now {{% pageref "build-deploy-test.md" "deploy your first package" %}}.
