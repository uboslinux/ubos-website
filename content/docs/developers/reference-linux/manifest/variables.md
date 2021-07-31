---
title: Variables available at deploy or undeploy
weight: 70
---

When an {{% gl App %}} or {{% gl Accessory %}} is deployed or undeployed, the involved
scripts, templates and the Manifest JSON may refer to certain symbolic names, also
known as variables.

See also {{% pageref functions.md %}}.

## Commonly-used variables

The following symbolic names are currently defined and commonly used by developers when
packaging their {{% gls App %}} or {{% gls Accessory %}} for UBOS. They are listed
alphabetically.

``${apache2.gname}``
: Name of the Linux group used for running the Apache web server.
  This is convenient for setting ownership of files.

  Example: ``http``

``${apache2.uname}``
: Name of the Linux user account used for running the Apache web server.
  This is convenient for setting ownership of files.

  Example: ``http``

``${appconfig.accessoryids}``
: The identifiers of all {{% gls Accessory %}} at this {{% gl AppConfiguration %}},
  separated by commas.

  Example: ``wordpress-plugin-webmention,wordpress-theme-p2``

``${appconfig.apache2.appconfigfragmentfile}``
: The name of the Apache2 configuration fragment which may be written
  by this {{% gl AppConfiguration %}}.

  Example: ``/etc/httpd/ubos/appconfigs/s753ca4a344f56c38aad05172dee6a53f6647af62/a9f52884fef255d617981fb0a94916bf67bcf64b5.conf``

``${appconfig.apache2.dir}``
: The directory in which Apache requires this {{% gl AppConfiguration %}}'s web server
  files. No trailing slash.

  Example: ``/ubos/http/sites/s753ca4a344f56c38aad05172dee6a53f6647af62/blog`` (if
  the {{% gl AppConfiguration %}} is at relative path ``/blog`` on a {{% gl Site %}}
  with {{% gl SiteId %}} ``s753ca4a344f56c38aad05172dee6a53f6647af62``)

``${appconfig.appconfigparsdir}``
: The directory in which this {{% gl AppConfiguration %}}'s customization points are
  stored. This directory contains a subdirectory each for each installable at the
  {{% gl AppConfiguration %}}, which in turn contains the files for the customization points.

  Example: ``/ubos/lib/ubos/appconfigpars/a9f52884fef255d617981fb0a94916bf67bcf64b5/``

``${appconfig.appid}``
: The identifier of the {{% gl App %}} at this {{% gl AppConfiguration %}}.

  Example: ``wordpress``

``${appconfig.appconfigid}``
: The identifier of the {{% gl AppConfiguration %}} as specified in the
  {{% gl Site_JSON %}} file.

  Example: ``a9f52884fef255d617981fb0a94916bf67bcf64b5``

``${appconfig.cachedir}``
: Name of a directory in which this {{% gl AppConfiguration %}} should cache any
  data it needs to cache.

  Example: ``/var/cache/a9f52884fef255d617981fb0a94916bf67bcf64b5``

``${appconfig.context}``
: Context path for this {{% gl AppConfiguration %}} as specified in the
  {{% gl Site_JSON %}} file (or, if not given, the default from the
  {{% gl UBOS_Manifest %}}). No trailing slash. The root context is a
  zero-length string.

  Examples: ``/blog`` or (empty string)

``${appconfig.contextnoslashorroot}``
: Context path for this {{% gl AppConfiguration %}} as specified in the
  {{% gl Site_JSON %}} file (or, if not given, the default from the
  {{% gl UBOS_Manifest %}}), but without either leading or trailing slash.
  The root context is represented as the string ``ROOT``.
  This variable makes some Tomcat configuration statements easier.

  Examples: ``blog`` or ``ROOT``

``${appconfig.contextorslash}``
: Context path for this {{% gl AppConfiguration %}} as specified in the
  {{% gl Site_JSON %}} file (or, if not given, the default from the
  {{% gl UBOS_Manifest %}}). No trailing slash. However, the root context
  is a single slash.
  This variable makes some Apache configuration statements easier that
  usually take a context path without trailing slash, but require a single
  slash when the context path would otherwise be empty.

  Examples: ``/blog`` or ``/``

``${appconfig.cronjobfile}``
: If this {{% gl AppConfiguration %}} needs to define one or more cron jobs, this
  is the preferred filename it should use for this purpose.

  Example: ``/etc/cron.d/50-a9f52884fef255d617981fb0a94916bf67bcf64b5``

``${appconfig.datadir}``
: A directory in which this {{% gl AppConfiguration %}} should preferably store data
  (outside of the webserver's ``DocumentRoot``). No trailing slash. While this
  variable is pre-defined, the {{% gl App %}} is responsible for actually creating
  the directory in its {{% gl UBOS_Manifest %}}.

  Example: ``/ubos/lib/wordpress/a9f52884fef255d617981fb0a94916bf67bcf64b5``

``${appconfig.mysql.dbhost.maindb}``
: Database host for the MySQL database whose symbolic name in the
  {{% gl UBOS_Manifest %}} is ``maindb``. Replace ``maindb`` with the symbolic name
  you used in the {{% gl UBOS_Manifest %}}.

  Example: ``localhost``

``${appconfig.mysql.dbname.maindb}``
: Actual name of the MySQL database whose symbolic name in the
  {{% gl UBOS_Manifest %}} is ``maindb``. Replace ``maindb`` with the symbolic name
  you used in the {{% gl UBOS_Manifest %}}.

  Example: ``database477``

``${appconfig.mysql.dbport.maindb}``
: Database port for the MySQL database whose symbolic name in the
  {{% gl UBOS_Manifest %}} is ``maindb``. Replace ``maindb`` with the symbolic name
  you used in the {{% gl UBOS_Manifest %}}.

  Example: ``3306``

``${appconfig.mysql.dbuser.maindb}``
: Database user for the MySQL database whose symbolic name in the
  {{% gl UBOS_Manifest %}} is ``maindb``. Replace ``maindb`` with the symbolic name
  you used in the {{% gl UBOS_Manifest %}}.

  Example: ``fred``

``${appconfig.mysql.dbusercredential.maindb}``
: Database password for the MySQL database whose symbolic name in the
  {{% gl UBOS_Manifest %}} is ``maindb``. Replace ``maindb`` with the symbolic name
  you used in the {{% gl UBOS_Manifest %}}.

  Example: ``n0ts0s3cr3t``

``${appconfig.postgresql.dbhost.maindb}``
: Database host for the Postgresql database whose symbolic name in the
  {{% gl UBOS_Manifest %}} is ``maindb``. Replace ``maindb`` with the symbolic name
  you used in the {{% gl UBOS_Manifest %}}.

  Example: ``localhost``

``${appconfig.postgresql.dbname.maindb}``
: Actual name of the Postgresql database whose symbolic name in the
  {{% gl UBOS_Manifest %}} is ``maindb``. Replace ``maindb`` with the symbolic name
  you used in the {{% gl UBOS_Manifest %}}.

  Example: ``database477``

``${appconfig.postgresql.dbport.maindb}``
: Database port for the Postgresql database whose symbolic name in the
  {{% gl UBOS_Manifest %}} is ``maindb``. Replace ``maindb`` with the symbolic name
  you used in the {{% gl UBOS_Manifest %}}.

  Example: ``3306``

``${appconfig.postgresql.dbuser.maindb}``
: Database user for the Postgresql database whose symbolic name in the
  {{% gl UBOS_Manifest %}} is ``maindb``. Replace ``maindb`` with the symbolic name
  you used in the {{% gl UBOS_Manifest %}}.

  Example: ``fred``

``${appconfig.postgresql.dbusercredential.maindb}``
: Database password for the Postgresql database whose symbolic name in the
  {{% gl UBOS_Manifest %}} is ``maindb``. Replace ``maindb`` with the symbolic name
  you used in the {{% gl UBOS_Manifest %}}.

  Example: ``n0ts0s3cr3t``

``${appconfig.tcpport.someport}``
: The port number allocated for the TCP port whose symbolic port name in the
  {{% gl UBOS_Manifest %}} is ``someport``. Replace ``someport`` with the symbolic name
  you used in the {{% gl UBOS_Manifest %}}.

  Example: ``5432``

``${appconfig.tomcat8.contextfile}``
: The name of the Tomcat8 context configuration file which may be written
  by this {{% gl AppConfiguration %}}.

  Example: ``/etc/tomcat8/Catalina/example.com/ROOT.xml``

``${appconfig.tomcat8.dir}``
: The directory in which Tomcat requires this {{% gl AppConfiguration %}}'s application server
  files. No trailing slash.

  Example: ``/ubos/lib/tomcat8/sites/s753ca4a344f56c38aad05172dee6a53f6647af62/a9f52884fef255d617981fb0a94916bf67bcf64b5``

``${appconfig.udpport.someport}``
: The port number allocated for the UDP port whose symbolic port name in the
  {{% gl UBOS_Manifest %}} is ``someport``. Replace ``someport`` with the symbolic name
  you used in the {{% gl UBOS_Manifest %}}.

  Example: ``5432``

``${host.cachedir}``
: Name of a directory in which to cache data on this device.

  Example: ``/var/cache``

``${host.tmpdir}``
: Name of a directory in which to create temporary files. By using this symbolic
  name, the location of temporarily files can be moved to a partition that has
  sufficient space (say ``/ubos/tmp`` vs ``/tmp``) without impacting {{% gls App %}}.

  Example: ``/ubos/tmp``

``${hostname}``
: Name of the current host as returned by the OS. This is often
  different from ``${site.hostname}``, which is a virtual host name
  for a {{% gl Site %}}.

  Example: ``host-1-2-3-4.example.org``

``${installable.accessoryinfo.appid}``
: Only exists for {{% gls Accessory %}}, not for {{% gls App %}}. The value of the
  ``accessoryinfo`` / ``appid`` provided in the {{% gl Accessory %}}'s
  {{% gl UBOS_Manifest %}} to identify the {{% gl App %}} for which this is an
  {{% gl Accessory %}}.

  Example: ``wordpress``

``${installable.accessoryinfo.accessoryid}``
: Only exists for {{% gls Accessory %}}, not for {{% gls App %}}. The value of the
  ``accessoryinfo`` / ``accessoryid`` provided in the {{% gl Accessory %}}'s
  {{% gl UBOS_Manifest %}} to identify the name of the {{% gl Accessory %}} from the
  perspective of the {{% gl App %}}, which may or may not be the same as the package
  name of the {{% gl Accessory %}} in UBOS.

  Example: ``p2``

``${installable.accessoryinfo.accessorytype}``
: Only exists for {{% gls Accessory %}}, not for {{% gls App %}}. The value of the
  ``accessoryinfo`` / ``accessorytype`` provided in the {{% gl Accessory %}}'s
  {{% gl UBOS_Manifest %}} to identify the type of {{% gl Accessory %}} from the
  perspective of the {{% gl App %}}.

  Example: ``theme``

``${installable.customizationpoints.foo.filename}``
: Name of a file that contains the value of customization point ``foo``
  for the {{% gl App %}} or {{% gl Accessory %}} in this
  {{% gl AppConfiguration %}}, as determined from the {{% gl UBOS_Manifest %}}
  file and the {{% gl Site_JSON %}} file.

  Example: ``/ubos/lib/ubos/appconfigpars/a12345678901234567890/mypackage/foo``

``${installable.customizationpoints.foo.value}``
: The value of customization point ``foo``
  for the {{% gl App %}} or {{% gl Accessory %}} in this
  {{% gl AppConfiguration %}}, as determined from the {{% gl UBOS_Manifest %}}
  file and the {{% gl Site_JSON %}} file.

  Example: ``My daily musings``

``${now.tstamp}``
: Timestamp when the current deployment or undeployment run started,
  in a human-readable, but consistently sortable string. Uses UTC time zone.

  Example: ``20140923-202018``

``${now.unixtime}``
: Timestamp when the current deployment or undeployment run started,
  in UNIX timestamp format.

  Example: ``1411503618``

``${package.codedir}``
: Directory in which the package's code should be installed. No trailing slash.

  Example: ``/ubos/share/wordpress``

``${package.name}``
: Name of the package currently being installed.

  Example: ``wordpress``

``${site.admin.credential}``
: Password for the {{% gl Site %}}'s administrator account.

  Example: ``s3cr3t``

``${site.admin.email}``
: E-mail address of the {{% gl Site %}}'s administrator.

  Example: ``foo@bar.com``

``${site.admin.userid}``
: Identifier of the {{% gl Site %}}'s administrator account. This identifier
  does not contain spaces or special characters.

  Example: ``admin``

``${site.admin.username}``
: Human-readable name of the {{% gl Site %}}'s administrator account.

  Example: ``Site administrator (John Smith)``

``${site.apache2.authgroupfile}``
: The groups file for HTTP authentication for this {{% gl Site %}}.

  Example: ``/etc/httpd/ubos/sites/s753ca4a344f56c38aad05172dee6a53f6647af62.groups``

``${site.apache2.htdigestauthuserfile}``
: The digest-based user file for HTTP authentication for this {{% gl Site %}}.

  Example: ``/etc/httpd/ubos/sites/s753ca4a344f56c38aad05172dee6a53f6647af62.htdigest``

``${site.hostname}``
: The virtual hostname of the {{% gl Site %}} to which this {{% gl AppConfiguration %}}
  belongs. This is often different from ``${hostname}``, which is
  the current host as returned by the OS.

  This variable will have value ``*`` for {{% gls Site %}} whose hostname was given
  as the {{% gl wildcard_hostname %}}.

  Example: ``ubosbox.example.org``

``${site.hostnameorlocalhost}``
: Same as ``${site.hostname}`` except that in case of a {{% gl wildcard_hostname "wildcard site" %}}, the value will
  be ``localhost``.

``${site.hostnameorwildcard}``
: Same as ``${site.hostname}`` except that in case of a {{% gl wildcard_hostname "wildcard site" %}}, the value will
  be ``__wildcard``.

``${site.hostnameorsystemhostname}``
: Same as ``${site.hostname}`` except that in case of a {{% gl wildcard_hostname "wildcard site" %}}, the value will
  be the system hostname as returned by ``hostname``.

``${site.protocol}``
: The protocol by which this {{% gl Site %}} is accessed. Valid values are
  ``http`` and ``https``.

  Example: ``http``

``${site.protocolport}``
: The port that goes with the protocol by which this {{% gl Site %}} is accessed.
  Valid values are ``80`` and ``443``.

  Example: ``80``

``${site.siteid}``
: The {{% gl Site %}} identifier of this {{% gl Site %}} per the {{% gl Site_JSON %}}
  file.

  Example: ``s753ca4a344f56c38aad05172dee6a53f6647af62``

``${site.tomcat8.contextdir}``
: The Tomcat context directory for this {{% gl Site %}}. No trailing slash.

  Example: ``/etc/tomcat8/Catalina/ubos.example.org``

``${tomcat8.gname}``
: Name of the Linux group used for running the Tomcat application server.
  This is convenient for setting ownership of files.

  Example: ``tomcat8``

``${tomcat8.uname}``
: Name of the Linux user account used for running the Tomcat application server.
  This is convenient for setting ownership of files.

  Example: ``tomcat8``

## Other variables

While these symbolic names are defined, their use by developers is not usually required
and thus discouraged.

``${apache2.appconfigfragmentdir}``
: Directory that contains Apache configuration file fragments, one per app
  configuration. You may want to use ``${appconfig.apache2.appconfigfragmentfile}``
  instead.

  Example: ``/etc/httpd/ubos/appconfigs``

``${apache2.sitefragmentdir}``
: Directory that contains Apache configuration file fragments, one per {{% gl Site %}}
  (aka virtual host). You may want to use ``${site.apache2.sitefragmentfile}``
  instead.

  Example: ``/etc/httpd/ubos/sites``

``${apache2.sitesdir}``
: Directory that contains the Apache ``DocumentRoots`` of the various
  {{% gls Site %}} installed on the host. You may want to use
  ``${site.apache2.sitedocumentdir}`` or ``${appconfig.apache2.dir}`` instead.

  Example: ``/ubos/http/sites``

``${apache2.ssldir}``
: Directory that contains SSL information.

  Example: ``/etc/httpd/ubos/ssl``

``${package.datadir}``
: Directory in which the package can store data. No trailing slash.
  You may want to use ``${appconfig.datadir}`` instead.

  Example: ``/ubos/lib/wordpress``

``${package.manifestdir}``
: Directory in which packages write their manifests. No trailing slash.
  You should not need to use this.

  Value: ``/ubos/lib/ubos/manifests``

``${site.apache2.sitedocumentdir}``
: The Apache ``DocumentRoot`` for this {{% gl Site %}}. No trailing slash.

  Example: ``/ubos/http/sites/s753ca4a344f56c38aad05172dee6a53f6647af62``

``${site.apache2.sitefragmentfile}``
: The Apache configuration file fragment for this {{% gl Site %}}. No trailing slash.
  You should not have to use this.

  Example: ``/etc/httpd/ubos/sites/s753ca4a344f56c38aad05172dee6a53f6647af62.conf``

``${site.tomcat8.sitedocumentdir}``
: The Tomcat ``DocumentRoot`` for this {{% gl Site %}}. No trailing slash.

  Example: ``/ubos/lib/tomcat8/sites/s753ca4a344f56c38aad05172dee6a53f6647af62``

``${tomcat8.sitesdir}``
: Directory that contains the Tomcat ``DocumentRoots`` of the various
  {{% gls Site %}} installed on the host. You may want to use
  ``${site.tomcat8.sitedocumentdir}`` instead.

  Example: ``/ubos/lib/tomcat8/sites``
