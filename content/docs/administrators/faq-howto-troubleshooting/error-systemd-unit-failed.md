---
title: 'ubos-admin status reports "Systemd unit ... has failed"'
---

For example, when you run `sudo ubos-admin status`, you may get output:

```
% sudo ubos-admin status
Problems:
 * Systemd unit snapper-cleanup.service has failed.
```
In this case, Systemd service `snapper-cleanup.service` has failed.

In the following, replace `snapper-cleanup.service`
with the name of the unit that failed):

1. Try to restart the service:

   ```
   % sudo systemctl restart snapper-cleanup.service
   ```

2. After a little while, check whether that fixed it by running
   ``sudo ubos-admin status --problems`` again. If not, read on.

3. To figure out why ``snapper-cleanup.service`` fails to start, ask for its
   log:

   ```
   % sudo journalctl -u snapper-cleanup.service
   ```

   If that brings up way too much information, you can limit the output
   to, say, the last 10 minutes, by invoking it as follows:

   ```
   % sudo journalctl -u snapper-cleanup.service --since -10m
   ```

That should give you enough information to figure out what the problem is.
