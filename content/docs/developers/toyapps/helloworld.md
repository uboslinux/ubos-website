---
title: Hello World
weight: 10
---

## Introduction

Our version of Hello World is an extremely simple Web applications that that
just displays "Hello World" in a user's web browser. We use it to give you a
taste for what is involved to package a real web application
for UBOS. Here is a complete :-) screen shot:

![Screenshot](/images/helloworld-screenshot.png)

To obtain the source code:

```
% git clone https://github.com/uboslinux/ubos-toyapps
```

Go to subdirectory ``helloworld``.

## Package lifecycle and App deployment

The first thing to understand about how UBOS {{% gls App %}} are packaged and
deployed is the lifecycle of a package from the developer's perspective, and
then how a user deploys and undeploys the {{% gl App %}} contained in the
package to their website:

1. The developer creates the files for the package. If you have cloned the git
   repository above, you find the files for ``helloworld`` in directory
   ``helloworld``; or you can browse them
   [on github](<https://github.com/uboslinux/ubos-toyapps/tree/master/helloworld).
   They are:

   * ``index.php``: minimalistic PHP file printing "Hello World";

   * ``htaccess``: Apache configuration file fragment that makes Apache default to
     ``index.php`` when the {{% gl App %}} is installed;

   * ``PKGBUILD``: script used to create the package (see below);

   * ``ubos-manifest.json``: UBOS meta-data file (see below);

   * ``appicons``: icon files (optional) that will be used for the icon the user can click
     on to visit the {{% gl App %}}.

1. The developer creates the package by executing, in the package's root directory:

   ```
   % makepkg -f
   ```

   This will create the package file named ``helloworld-*-any.pkg.tar.xz`` (where
   ``*`` is a particular version number defined in the ``PKGBUILD`` file).
   ``makepkg`` is the packaging command for ``pacman`` packages, the types of
   packages we use in UBOS. (You can read more about ``pacman`` on the
   [Arch Linux Wiki](https://wiki.archlinux.org/index.php/Pacman).)

1. Once the package has been created, the developer makes the package available to the user.
   In the general case, this involves uploading the package to the {{% gl UBOS_Depot  %}},
   UBOS quality assurance etc etc, but for our purposes here, ignore all that and simply
   assume that the package file created by the developer has somehow arrived on the user's
   {{% gl Device %}}, such as by file transfer.

1. The user installs the package on the target device:

   ```
   % sudo pacman -U helloworld-*-any.pkg.tar.xz
   ```

   This command will install a locally built package locally, but it is equivalent to
   what happens when a user obtains the same {{% gl App %}} via the UBOS {{% gl Depot %}}.

   Note that this unpacks the package on the hard drive and runs whatever installation
   scripts that the package specifies (the latter is rare, e.g. Hello World does not
   have such scripts). However, installing the package does **not** deploy the {{% gl App %}}
   at any {{% gl Site %}} or virtual host. To do that, see the next step:

1. The user deploys the web {{% gl App %}} defined by the package at a particular
   {{% gl Site %}} (aka virtual host) with a command such as:

   ```
   % sudo ubos-admin createsite
   ```

   This commend asks some questions; answer the questions as you like, and use the
   {{% gl App %}} name ``helloworld`` (see also {{% pageref "/docs/users/firstsite.md" %}}).

   This will put all the right files in the right web server directories, activate
   needed Apache modules, restart servers, and the like. When this command completes,
   the {{% gl App %}} is ready for use.

1. The user can now visit the fully deployed {{% gl App %}} at the respective URL at
   which it was installed.

1. Now assume that a new version of the package is available. If the new package is
   available locally, the user can perform a software upgrade of the ``helloworld``
   package (only):

   ```
   % sudo ubos-admin update --pkgfile <pkgfile>
   ```

   where ``<pkgfile>`` is a new version of the package file created as shown above.
   If distributed through the UBOS {{% gl Depot %}}, the argument ``--pkgfile`` will be
   omitted, and UBOS will upgrade all software on the host to the most recent version.

1. Undeploy the {{% gl App %}} by undeploying the entire {{% gl Site %}}:

   ```
   % sudo ubos-admin undeploy --siteid <siteid>
   ```
   where ``<siteid>`` is the identifier of the installed {{% gl Site %}}. Note that
   this will keep the {{% gl App %}}'s package on the {{% gl Device %}} so it can be
   redeployed without re-installing the package.

1. If the user wishes to remove the package entirely:

   ```
   % sudo pacman -R helloworld
   ```

## Anatomy of the package

The ``PKGBUILD`` script's ``package`` method puts the package together on hehalf of
the developer:

```
package() {
# Manifest
    install -D -m0644 ${startdir}/ubos-manifest.json ${pkgdir}/ubos/lib/ubos/manifests/${pkgname}.json

# Icons
    install -D -m0644 ${startdir}/appicons/{72x72,144x144}.png -t ${pkgdir}/ubos/http/_appicons/${pkgname}/
    install -D -m0644 ${startdir}/appicons/license.txt         -t ${pkgdir}/ubos/http/_appicons/${pkgname}/

# Code
    install -D -m0644 ${startdir}/index.php -t ${pkgdir}/ubos/share/${pkgname}/
    install -D -m0644 ${startdir}/htaccess  -t ${pkgdir}/ubos/share/${pkgname}/
}
```

You can see that this script creates installs a few files in subdirectories of ``${pkgdir}``,
which is a staging directory for creating the package ``tar`` file. For more information about
``PKGBUILD``, consider the Arch Linux wiki
[PKGBUILD page](https://wiki.archlinux.org/index.php/Creating_packages);
there is nothing UBOS-specific about this.

This corresponds to what the package file contains after ``makepkg`` has completed:

```
% tar tfJ helloworld-*-any.pkg.tar.xz
.PKGINFO
.BUILDINFO
.MTREE
ubos/
ubos/lib/
ubos/http/
ubos/share/
ubos/share/helloworld/
ubos/share/helloworld/index.php
ubos/share/helloworld/htaccess
ubos/http/_appicons/
ubos/http/_appicons/helloworld/
ubos/http/_appicons/helloworld/72x72.png
ubos/http/_appicons/helloworld/144x144.png
ubos/http/_appicons/helloworld/license.txt
ubos/lib/ubos/
ubos/lib/ubos/manifests/
ubos/lib/ubos/manifests/helloworld.json
```

The first three files, ``.PKGINFO``, ``.BUILDINFO`` and ``.MTREE`` contain metadata that is
automatically generated by ``makepkg``.

Directory ``ubos/share/helloworld`` contains the files that constitute the application. For this
extremely simple {{% gl App %}}, there are only two: the PHP code that emits the "Hello World"
HTML, and an Apache ``htaccess`` file so this HTML is emitted even if the path ends with a slash
instead of ``index.php``. More complex web {{% gls App %}} would put the bulk of their
code and auxiliary files there.

In a typical Linux distro, these files would be located at ``/usr/share/helloworld`` or
perhaps at ``/srv/http/helloworld``. In UBOS, these files are located below ``/ubos``, which
is the place where users mount a large data disk if they have a separate disk.

![Hello world icon](/images/helloworld-icon.png)

The files below ``ubos/http/_appicons/`` are simply graphics files that can be used
by UBOS to show to the user a logo for the application. This image is shown to the right.
They are optional and are added in the ``package()`` section of ``PGKBUILD``.

Finally, ``ubos/lib/ubos/manifests/`` contains the {{% gl UBOS_Manifest %}} file for this
application, which describes what needs to happen upon ``ubos-admin deploy`` and when
other ``ubos-admin`` commands are executed. For details, read on:

## UBOS Manifest

For this {{% gl App %}}, the {{% gl UBOS_Manifest %}} file looks as follows:

```
{
  "type" : "app",

  "roles" : {
    "apache2" : {
      "defaultcontext" : "/hello",
      "depends" : [
        "php",
        "php-apache"
      ],
      "apache2modules" : [
        "php7"
      ],
      "appconfigitems" : [
        {
          "type"         : "file",
          "name"         : "index.php",
          "source"       : "index.php",
        },
        {
          "type"         : "file",
          "name"         : ".htaccess",
          "source"       : "htaccess",
        }
      ]
    }
  }
}
```

Let's discuss these items in sequence:

* ``"type" : "app"`` declares this to be an {{% gl App %}}, not an {{% gl Accessory %}}.
  (For a discussion of {{% gls Accessory %}}, see {{% pageref gladiwashere-php-mysql-footer.md %}}.

* This {{% gl App %}} only uses a single {{% gl Role %}}: ``apache2``. {{% gls App %}} could
  also specify other {{% gls Role %}}, such as ``mysql``, if they make use of MySQL in addition
  to Apache.

* By default, this {{% gl App %}} wants to be deployed at the relative path ``/hello`` of a
  {{% gl Site %}}. This can be overridden by the user in the {{% gl Site_JSON %}} file or when
  entering a different path during execution of ``ubos-admin createsite``.

* For the ``apache2`` role, this {{% gl App %}} requires packages ``php`` and ``php-apache``, as
  it is a PHP {{% gl App %}}. It requires that the Apache module ``php7`` has been enabled before
  it can be run.

* Finally, each installation of this {{% gl App %}} requires two files to be installed in the
  web server's document directory tree: a file called ``index.php``, which is simply copied,
  and a file called ``.htaccess`` which is copied from a slightly different name. By
  convention, the "source" path is relative to the package installation directory
  ``/ubos/share/helloworld``; and the destination path is relative to the correct directory
  from which Apache serves files, given the {{% gl Site %}} and context at which the {{% gl App %}}
  runs. Here, this may be ``/ubos/http/sites/sa6e789f5d919c464d2422f6620eaf9cba789c4a5/hello/``
  (auto-provisioned by UBOS).

When the user invokes ``ubos-admin deploy``, UBOS processes the {{% gl UBOS_Manifest %}} and
"makes it so". We recommend you package and then ``helloworld`` with the example commands above,
and then examine how UBOS made the {{% gl App %}} appear by, for example examining the
generated Apache configuration files below ``/etc/httpd``.

When the user invokes ``ubos-admin undeploy``, UBOS processes the {{% gl UBOS_Manifest %}} in
reverse sequence, and restores the system to its previous state.
