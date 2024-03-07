---
title: 'What is the default "root" password?'
---

In UBOS versions prior to September 2020, there was no ``root`` password when attempting to
log in as ``root`` from the local console.

In UBOS versions since September 2020, the default ``root`` password is `"ubos!4vr"` (without
the quotes).

You can, and should change this to something else, for example by executing ``passwd``
as ``root``.

Network login for ``root`` was and continues to be disabled. To log into your device via ssh,
use the {{% gl Shepherd %}} account.
