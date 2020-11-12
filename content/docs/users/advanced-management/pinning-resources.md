---
title: Pinning resources
---

UBOS usually allocates resources to installed {{% gls App %}} randomly. For example, if you install
{{% gl App %}} ``wordpress``, UBOS might allocate a MySQL database called ``asrguilhwert`` to that
installation of Wordpress. UBOS may also change the name of the database every time you run
``ubos-admin update``. None of this is usually a problem (and in fact, good for security)
because it's all automated and UBOS makes sure that all configuration files etc. are updated
consistently.

But sometimes, it would be nice to keep the same database name, or the same port number,
for a given installation of an {{% gl App %}}. That is what resource pinning is for.

Note: you are very unlikely to ever needs this. In fact, if you need it, chances are you
using UBOS wrong. But here's a description how to do it anyway.

## Pinning a database

You must use ``ubos-admin createsite --dry-run``, then set up the pinning, and then
run ``ubos-admin deploy``. You cannot deploy directly from ``ubos-admin createsite``,
because you need to know the {{% gl AppConfigId %}} before deployment. Here are the steps:

1. Execute ``ubos-admin createsite --dry-run --out mysite.json`` (or choose whatever other
   temporary name for the {{% gl Site_JSON %}} file) and configure the {{% gl Site %}}
   as you would like it.

1. Examine ``mysite.json`` and determine the {{% gl AppConfigId %}} of the {{% gl AppConfiguration %}}
   that runs the {{% gl App %}} or {{% gl Accessory %}} whose database you want to pin. Let's say
   it is ``a1234567890`` (real {{% gls AppConfigId %}} are longer).

1. Determine the symbolic name that the {{% gl App %}} or {{% gl Accessory %}} whose database
   you want to pin gives that database in its {{% gl UBOS_Manifest %}}. For example, many UBOS
   {{% gls App %}} use the symbolic name ``maindb``.

1. In directory ``/ubos/lib/ubos/pinned``, create a file whose name is
   ``<appconfigid>_<installableid>_<type>_<item>.json``, where ``<appconfigid>`` is the
   {{% gl AppConfigId %}} you determined above, ``<installableid>`` is the identifier of the
   {{% gl App %}} or {{% gl Accessory %}} (e.g. ``wordpress``), ``<type>`` is the type of
   resource (e.g. ``mysqldb``) and ``item`` is the symbolic name of the resource (e.g. ``maindb``).
   For example, the name of this file might be
   ``a1234567890_wordpress_mysqldb_maindb.json``.

1. Into this file, write the data that you would like UBOS to use instead of randomly
   allocating it. For example, for a MySQL database, it could look like this:

   ```
   {
     "dbName"              : "wordpressdb",
     "dbHost"              : "localhost",
     "dbPort"              : 3306,
     "dbUserLid"           : "wordpressuser",
     "dbUserLidCredential" : "extremelysecret",
     "dbUserLidCredType"   : "simple-password"
   }
   ```

   This pins name of the database to allocate and use, the host on which it runs,
   the port at which is to be reached, the database username to use to access it,
   the corresponding database credential, and the credential type, respectively. (Currently
   the credential type is always ``simple-password``.)

1. Now, using the {{% gl Site_JSON %}} file you created above, deploy your {{% gl Site %}}:

   ```
   % sudo ubos-admin deploy -f mysite.json
   ```

   The {{% gl Site %}} will be deployed as you expect, but it
   will use the pinned resources instead of automatically allocated ones.

Note that UBOS still manages those resources, even if you decide what their names should be.
So do not be surprised if UBOS deletes the database upon {{% gl Site %}} undeploy, or recreates it
when the {{% gl Device %}} updates.
