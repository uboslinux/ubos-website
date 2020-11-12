---
title: I want to run ssh on a non-standard port
---

Some people like to run the ssh daemon on a non-standard port, in the hope that fewer
attackers on the open internet probe it. Note that by default, UBOS only accepts public-key
based authentication, not password-based authentication, so it's not very likely that anybody
can guess your credentials even if they try many times.

But if you'd like to run the ssh daemon on a non-standard port anyway, do this:

* On your {{% gl Device %}}, edit ``/etc/ssh/sshd_config``. Look for the line that says
  ``#Port 22``. Remove the ``#`` and change the ``22`` to the port number you want. Save.
  (This configures the ssh daemon to listen to a different port.)

* Create new file ``/etc/ubos/open-ports.d/ssh`` and enter a single line with content
  ``<PPP>/tcp`` where ``<PPP>`` is the port number you picked. Save. (This tells UBOS
  which extra port to open in the firewall.)

* Execute ``sudo ubos-admin setnetconfig client``. Substitute the name of your
  {{% gl Networking_Configuration %}} for ``client`` if you are not using ``client``.
  (This will reconfigure the firewall.)

* Execute ``sudo systemctl restart sshd.service``. (This will restart the ssh daemon.)

