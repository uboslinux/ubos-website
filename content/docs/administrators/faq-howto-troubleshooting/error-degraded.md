---
title: UBOS is in a "degraded" state
---

To figure out what's going on, execute:

```
% sudo ubos-admin status --problems
```

This should give you a description of which systemd units have failed.

Continue with {{% pageref "error-systemd-unit-failed.md" %}}.

