---
title: The UBOS rsync server
---

``ubos-rsync-server`` is a {{% gl Package %}} that makes it easy for developers to support secure
file upload/download from UBOS-deployed {{% gls App %}} via ``rsync`` over ``ssh``. Using
this package is often very convenient for developers of {{% gls App %}} whose data should be
uploadable or downloadable from the command-line, not just via a web browser.

To do discuss it, we will use the ``docroot`` {{% gl App %}} available on UBOS that makes use
of ``ubos-rsync-server``. ``docroot`` is a simple web {{% gl App %}} for static web site hosting.
You may want to review its {{% pageref "/docs/users/apps/docroot.md" "end user documentation" %}} first.

To examine ``docroot``, please refer to its source code
[on Github](https://github.com/uboslinux/ubos-utilapps).

You notice that ``docroot`` consists of only a handful of files:

* ``tmpl/htaccess.tmpl`` is the (template for the) Apache configuration fragment for this
  {{% gl App %}}. Other than setting up permissions, PHP and some useful PHP environment variables,
  all this does is map the root of the installation URL (symbolically:
  ``${appconfig.context}/`` to a specific subdirectory called ``rsyncdir`` of the
  {{% gl AppConfiguration %}}'s data directory: ``/ubos/lib/docroot/${appconfig.appconfigid}/rsyncsubdir/``.)
  In other words, the files in this directory will be presented to the user by the web server.

* ``install`` only makes sure that the UBOS {{% gl Device %}} has a local user called ``docroot``.

* ``ubos-manifest.json`` is more interesting. First, it makes sure that the
  {{% gl AppConfiguration %}}'s data directory and the ``rsyncdir`` subdirectory exist (the latter
  is marked as "to be backed up"). Then, it makes sure the ``htaccess`` file is instantiated in
  put in the right place. Finally, it runs a script, which, as you can see from its full path,
  has been provided by ``ubos-rsync-server``; we get to that in a second. It ends with the
  declaration of the {{% gl Customization_Point %}} that enables the user to specify the public
  key used to upload during ``ubos-admin createsite``.

What does this ``provision-appconfig`` script do? (You can look at its source code
[here](https://github.com/uboslinux/ubos-packages/).)

In short, it edits the ``~/.ssh/authorized_keys`` file of the ``docroot`` user. Recall that
the ``~/.ssh/authorized_keys`` file contains the list of public keys that enable a remote
user to remotely log in, via ssh, into the ``docroot`` account on the current {{% gl Device %}}
with a public SSH key and no password.

This ``docroot`` user was created by and specifically for the ``docroot`` {{% gl App %}}. As
this user has no password, password-based authentication or login is not possible.
``provision-appconfig`` now edits its ``~/.ssh/authorized_keys`` file in a way that:

* only remote users are allowed to connect via ssh who are in possession of a valid SSH keypair
  whose public key has been added to this file;
* but they aren't allowed to start an arbitrary shell either, only upload data, and
* it only permits upload to the ``resyncdir`` of the specific {{% gl AppConfiguration %}} to
  which the SSH public key was added as a {{% gl Customization_Point %}}. Admittedly, this
  is an unusual configuration for SSH, but very appropriate for our purpose here.

This setup is a little tricky -- which is why we created this package, so you don't have to --
but the essence of the ``authorized_keys`` edits is the following:

* each installation of ``docroot`` on the same {{% gl Device %}} adds an addition authorized key to
  the ``authorized_keys`` file. This means that if you have five installations of ``docroot``
  on the same device, the ``authorized_keys`` file will contain five upload keys.

* incoming ``rsync-over-ssh`` connections will be examined by which {{% gl AppConfigId %}} they specify.
  Only if the correct combination of SSH key and {{% gl AppConfigId %}} is presented does the
  upload succeed. This prevents attackers who do not have the correct combination from
  accessing {{% gls AppConfiguration %}} they should not be able to access.

* Also, {{% gl AppConfigId %}} gets translated into the correct directory for the
  {{% gl AppConfiguration %}}, which happens to be the ``rsyncdir`` that goes with the
  {{% gl AppConfiguration %}}.

The result: The user can securely upload via ``rsync`` over ``ssh`` to their own
``docroot`` {{% gls Site %}}, but no others, even if others have ``docroot``
{{% gls Site %}} on the same {{% gl Device %}}.

``ubos-rsync-server`` can be used by any other {{% gl App %}} the same way: setup a
user that goes with the {{% gl App %}}, and have the {{% gl App %}}'s {{% gl UBOS_Manifest %}} invoke
``provision-appconfig`` just like ``docroot`` does.
