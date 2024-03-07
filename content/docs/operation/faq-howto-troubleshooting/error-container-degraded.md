---
title: A UBOS container comes up degraded
---

Check which service(s) might have failed (see {{% pageref error-degraded.md %}}).

If it is related to IPv6, make sure you have IPv6 enabled on your host even if
you are not using it.

If you run the container on a UBOS host itself, it may be as easy as
``sudo ubos-admin setnetconfig client`` (or whatever netconfig you are running on the
host).
