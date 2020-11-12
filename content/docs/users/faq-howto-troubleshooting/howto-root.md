---
title: I need root
---

You should be able to do all typical systems administration with the ``shepherd`` account.
This account is permitted to perform ``sudo <cmd>`` for those commands that require ``root``
privileges, but no more, in order to cut down on inadvertent changes that will get in the
way of UBOS' way of doing things. So: "Root is not the account you are looking for."

However, if you insist, there are two easy ways of getting root:

* On a system where you have access to the console, you can simply log into the console
  as ``root``.

* As user ``shepherd``, invoke ``sudo su`` or ``sudo bash``. This will give you a ``root``
  shell.

## What is the default ``root`` password?

In UBOS versions prior to September 2020, there was no ``root`` password when attempting to
log in as ``root`` from the local console.

In UBOS versions since September 2020, the default ``root`` password is `"ubos!4vr"` (without
the quotes).

You can, and should change this to something else, for example by executing ``passwd``
as ``root``.

Network login for ``root`` was and continues to be disabled. To log into your device via ssh,
use the {{% gl Shepherd %}} account.

