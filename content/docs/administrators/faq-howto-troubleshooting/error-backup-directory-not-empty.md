---
title: "Cannot create a temporary backup; the backup directory is not empty"
---

You have run into a UBOS safety feature. Previously, you must have performed some kind
of ``ubos-admin`` operation (like a system update or site redeploy) on your
{{% gl Device %}} that encountered a problem of some kind.

This is not supposed to happen. However, it can happen if, for example, the power went
out during a UBOS administration operation, or if you made some change to your system
outside of what UBOS expects you to do. (The reason you are encouraged to not become
``root``.) It's also possible you ran out of disk space during some operation, or,
heavens forbid, you ran into UBOS bug.

When UBOS recognizes that there was a problem, it keeps a copy of the potentially affected
data around in directory ``/ubos/backup/update``. This is now still there, and UBOS will
refuse to perform other operations until you have disposed of that data there.

When this message appears, you should:

* check that all data you expect to be there is still managed by the {{% gl app %}} or
  {{% gls App %}} running on your {{% gl Device %}}. Depending on which {{% gls App %}}
  you have {{% gl Deployment deployed %}}, one way of doing this may be to log into your
  {{% gls App %}} over the web, and make sure your files, blog posts, uploads, and such
  (depending on your {{% gls App %}}) are all still there.

* if you are quite certain that everything is there, it appears that UBOS was overly careful
  and you can delete directory ``/ubos/backup/update``. UBOS is trying to err on the side
  of being overly careful, instead of on the side of risking data loss.

* If one or all of your {{% gls App %}} appear to be non-functional, or data appears to be
  missing, try to run ``sudo ubos-admin update-stage2``. This may or may not succeed,
  depending on what the original problem was.

* if all fails, move the entire ``/ubos/backup/update`` directory, recursively, into
  a safe place. Then re-install your applications and manually restore the
  data contained in this directory hierarchy to the {{% gls App %}}.

* or, if you are just fooling around with UBOS and there is no valuable data on your
  {{% gl Device %}} that could conceivably be lost, you can simply delete the
  ``/ubos/backup/update`` directory hierarchy and continue what you were doing.
