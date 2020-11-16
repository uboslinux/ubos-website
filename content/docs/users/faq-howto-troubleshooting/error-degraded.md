---
title: UBOS is in a "degraded" state
---

To figure out what's going on, execute:

```
% sudo ubos-admin status --problems
```

This should give you a description of which service(s) have failed. Let's
say it is ``foo.service`` (there is no such service as ``foo.service``:
place ``foo`` with the name of the service that failed on your {{% gl Device %}}.

1. Try to restart the service:

   ```
   % sudo systemctl restart foo.service
   ```

2. After a little while, check whether that fixed it by running
   ``sudo ubos-admin status --problems`` again. If not, read on.

3. To figure out why ``foo.service`` fails to start, ask for its
   log:

   ```
   % sudo journalctl -u foo.service
   ```

   If that brings up way too much information, you can limit the output
   to, say, the last 10 minutes, by invoking it as follows:

   ```
   % sudo journalctl -u foo.service --since -10m
   ```

That should give you enough information to figure out what the problem is.
