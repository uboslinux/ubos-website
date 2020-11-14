---
title: Installing a new Package or updating fails with a message about "invalid or corrupted package"
  or "key is disabled"
---

This and similar messages are triggered when UBOS cannot verify that a {{% gl Package %}}
you are trying to install or upgrade has been created by a trusted developer (i.e. one whose
public key is listed as "trusted" in ``pacman``'s trust database).

There are several conditions that cause these messages, such as:

* the signature for the {{% gl Package %}} file is invalid (e.g. just made up);

* the signature for the {{% gl Package %}} file is valid, but ``pacman``'s trust
  database does not have the needed public key to verify it;

* the signature for the {{% gl Package %}} file is valid, ``pacman``'s trust database
  has the public key to verify it, but the key is not marked as trusted there;

* the package indeed was created by a non-trusted developer. This is unlikely, unless
  you are a developer and you created the {{% gl Package %}} yourself. If you decide
  that you wish to trust the developer (such as yourself) in spite of UBOS' policies,
  use ``pacman-key`` to add the key to ``pacman``'s gpg database

* your trust database is out of date.

Try this:

* Update the trust database with

  ```
   sudo pacman-key --refresh-keys
   ```

* You can also weaken the ``pacman`` security requirements by making signatures optional by
  editing ``/etc/pacman.conf``. This is only recommended if you know what you are doing.
