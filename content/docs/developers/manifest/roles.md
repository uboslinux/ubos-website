---
title: Roles section
weight: 30
---

The roles section in an UBOS Manifest defines how the {{% gl App %}} or {{% gl Accessory %}}
needs to be deployed and related information. For example, the roles section defines:

* which files or directories need to be created in the file system;
* which databases need to be provisioned with which permissions;
* which directories or databases need to be backed up;
* which scripts to run after installation, before uninstallation, or for a version
  upgrade.

The roles section is structured by roles. Currently supported roles are:

* ``apache2``: information related to the web tier;
* ``tomcat8``: information related to the Java :term:`Apps <App>` running on Tomcat (if applicable);
* ``mysql``: information related to MySQL databases (if applicable);
* ``postgresql``: information related to Postgresql databases (if applicable);
* ``generic``: information not related to any of the other tiers (this is rare).

Generally, upon installation of an {{% gl App %}} or {{% gl Accessory %}}, the roles are
processed in this sequence:

1. ``mysql`` or ``postgresql``

1. ``generic``

1. ``tomcat8``

1. ``apache2``

Upon uninstallation of an {{% gl App %}} or {{% gl Accessory %}}, the roles are processed
in the opposite sequence.

Here are common fields for all roles:

## Common fields

### Depends

When the {{% gl App %}} or {{% gl Accessory %}} is deployed for this role, the field
``depends`` identifies required packages. Often, these dependencies could also be listed
in the package's {{% gl PKGBUILD %}} file, but this additional field allows the declaration of
dependencies that are only required if this role is used.

Example:

```
"apache2" : {
  "depends" : [ "php-apache", "php-gd" ],
  ...
```

### AppConfigItems

This section captures the items that need to be put in place before a deployment of
an {{% gl App %}} or {{% gl Accessory %}} is functional. These items can be things
such as files, directories, symbolic links, or databases; but also scripts that need
to be run.

For example, in the ``apache2`` role of an {{% gl App %}} the following ``appconfigitems``
section may be found:

```
"appconfigitems" : [
  {
    "type"         : "file",
    "name"         : "index.php",
    "source"       : "web/index.php",
  },
  {
    "type"         : "file",
    "name"         : "config.php",
    "template"     : "tmpl/config.php.tmpl",
    "templatelang" : "varsubst"
  },
  {
    "type"         : "symlink",
    "name"         : "gladiwashere.php",
    "source"       : "web/gladiwashere.php"
  }
]
```

Here, three items need to be put in place: two files, and a symbolic link. The following
{{% gl AppConfigItem %}} types are currently supported:

* ``directory``: a directory to be created;
* ``directorytree`` : a recursive directory tree, copied from somewhere else;
* ``file``: a file, created by copying another file, or processing another file (see below);
* ``database``: a database that needs to be created (only use this for database roles such
  as the ``mysql`` role);
* ``perlscript``: a Perl script that needs to be run;
* ``sqlscript``: a SQL script that needs to be run (only use this for the ``mysql`` role);
* ``symlink``: a symbolic link;
* ``systemd-service``: a systemd service to be running while the {{% gl AppConfiguration %}} is deployed;
* ``systemd-timer``: a systemd timer to be active while the {{% gl AppConfiguration %}} is deployed;
* ``tcpport``: a TCP port needs to be reserved for the exclusive use of this {{% gl AppConfiguration %}};
* ``udpport``: a UDP port needs to be reserved for the exclusive use of this {{% gl AppConfiguration %}}.

The field ``name`` is the name of the file, directory, database, systemd service or timer to
be created or operated on. ``names`` can be used as a shortcut for several
{{% gls AppConfigItem %}} to which the same other settings apply.

The field ``template`` identifies a file or directory that is to be used as a template for
creating the new item. The corresponding field ``templatelang`` states how the template
should be used to create the item. In the example above, the ``varsubst`` ("variable
substitution") algorithm is to be applied. (See {{% pageref variables..md %}} and
{{% pageref scripts.md %}}.)

The field ``source`` refers to a file that is the source code for the script to be run,
or the destination of the symbolic link. (Think of the original file that is either being
copied, run, or pointed to with the symbolic link.)

The ``source`` field in case of ``directorytree``, ``file`` and ``symlink`` may contain:

* ``$1``: it will be replaced with the value of the ``name`` or current ``names`` entry.
* ``$2``: it will be replaced with the file name (without directories) of the ``name`` or
  current ``names`` entry.

The following table shows all attributes for {{% gls AppConfigItem %}} that
are defined:

<table>
 <thead>
  <tr>
   <th>JSON entry</th>
   <th>Description</th>
   <th>Relative path context</th>
   <th>Mutually exclusive with</th>
  </tr>
 </thead>
 <tbody>
  <tr>
   <td>
    <code>charset</code>
   </td>
   <td>
    Default character set for SQL database (default: Unicode)
   </td>
   <td>
    N/A
   </td>
   <td>
    N/A
   </td>
  </tr>
  <tr>
   <td>
    <code>collate</code>
   </td>
   <td>
    Default collation set for SQL database
   </td>
   <td>
    N/A
   </td>
   <td>
    N/A
   </td>
  </tr>
  <tr>
   <td>
    <code>delimiter</code>
   </td>
   <td>
    Delimiter for SQL scripts (default: <code>;</code>)
   </td>
   <td>
    N/A
   </td>
   <td>
    N/A
   </td>
  </tr>
  <tr>
   <td>
    <code>dirpermissions</code>
   </td>
   <td>
    A string containing the octal number for the <code>chmod</code> permissions
    for directories in this directory hierarchy (default: <code>0755</code>)
   </td>
   <td>
    N/A
   </td>
   <td>
    N/A
   </td>
  </tr>
  <tr>
   <td>
    <code>filepermissions</code>
   </td>
   <td>
    A string containing the octal number for the <code>chmod</code> permissions
    for files in this directory hierarchy (default: <code>0644</code>)
   </td>
   <td>
    N/A
   </td>
   <td>
    N/A
   </td>
  </tr>
  <tr>
   <td>
    <code>gname</code>
   </td>
   <td>
    The name of the Linux group that this item should belong to (default: <code>root</code>).
   </td>
   <td>
    N/A
   </td>
   <td>
    N/A
   </td>
  </tr>
  <tr>
   <td>
    <code>name</code>
   </td>
   <td>
    The name of the created file, directory, symlink, or root of the directory tree,
    or the symbolic name of a database, or port.
   </td>
   <td>
    <code>${appconfig.apache2.dir}</code>
   </td>
   <td>
    <code>names</code>
   </td>
  </tr>
  <tr>
   <td>
    <code>names</code>
   </td>
   <td>
    The names of the created files, directories, symlinks, or roots of the directory
    trees if more than one item supposed to be processed with the same rule.
   </td>
   <td>
    <code>${appconfig.apache2.dir}</code>
   </td>
   <td>
    <code>name</code>
   </td>
  </tr>
  <tr>
   <td>
    <code>permissions</code>
   </td>
   <td>
    A string containing the octal number for the <code>chmod</code> permissions for
    this file or directory (default: <code>"0644"</code> for files, <code>"0755"</code>
    for directories).
   </td>
   <td>
    N/A
   </td>
   <td>
    N/A
   </td>
  </tr>
  <tr>
   <td>
    <code>privileges</code>
   </td>
   <td>
    SQL privileges for a database.
   </td>
   <td>
    N/A
   </td>
   <td>
    N/A
   </td>
  </tr>
  <tr>
   <td>
    <code>retentionbucket</code>
   </td>
   <td>
    If given, captures that this item contains valuable data that needs to be
    preserved, e.g. when a backup is performed, and gives it a symbolic name
    that becomes a named section in backup files. Setting this requires
    setting the <code>retentionpolicy</code> as well.
   </td>
   <td>
    N/A
   </td>
   <td>
    N/A
   </td>
  </tr>
  <tr>
   <td>
    <code>retentionpolicy</code>
   </td>
   <td>
    The string <code>"keep"</code>. All other values are reserved. Setting this requires
    setting the <code>retentionbucket</code> as well.
   </td>
   <td>
    N/A
   </td>
   <td>
    N/A
   </td>
  </tr>
  <tr>
   <td>
    <code>source</code>
   </td>
   <td>
    The name of a file to copy (or execute) without change.
   </td>
   <td>
    <code>${package.codedir}</code>
   </td>
   <td>
    <code>template</code>
   </td>
  </tr>
  <tr>
   <td>
    <code>template</code>
   </td>
   <td>
    The name of a template file that will be copied after being processed
    according to the value of <code>templatelang</code>.
   </td>
   <td>
    <code>${package.codedir}</code>
   </td>
   <td>
    <code>source</code>
   </td>
  </tr>
  <tr>
   <td>
    <code>templatelang</code>
   </td>
   <td>
    Specifies the type of template processing to be performed on the content
    of <code>template</code>.
   </td>
   <td>
    N/A
   </td>
   <td>
    <code>source</code>
   </td>
  </tr>
  <tr>
   <td>
    <code>uname</code>
   </td>
   <td>
    The name of the Linux user account that should own the created item
    (default: <code>root</code>).
   </td>
   <td>
    N/A
   </td>
   <td>
    N/A
   </td>
  </tr>
 </tbody>
</table>

This table shows which attributes apply to which types of {{% gls AppConfigItem %}}:

<table>
 <thead>
  <tr>
   <th>JSON entry</th>
   <th><code>database</code></th>
   <th><code>exec</code></th>
   <th><code>directory</code></th>
   <th><code>directory<br>tree</code></th>
   <th><code>file</code></th>
   <th><code>perl<br>script</code></th>
   <th><code>sql<br>script</code></th>
   <th><code>symlink</code></th>
   <th><code>systemd-<br>service</code></th>
   <th><code>systemd-<br>timer</code></th>
   <th><code>tcpport</code></th>
   <th><code>udpport</code></th>
  </tr>
 </thead>
 <tbody>
  <tr>
   <th><code>delimiter</code></th>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td>Y</td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
  </tr>
  <tr>
   <th><code>dirpermissions</code></th>
   <td></td>
   <td></td>
   <td>Y</td>
   <td>Y</td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
  </tr>
  <tr>
   <th><code>filepermissions</code></th>
   <td></td>
   <td></td>
   <td>Y</td>
   <td>Y</td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
  </tr>
  <tr>
   <th><code>gname</code></th>
   <td></td>
   <td></td>
   <td>Y</td>
   <td>Y</td>
   <td>Y</td>
   <td></td>
   <td></td>
   <td>Y</td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
  </tr>
  <tr>
   <th><code>name</code></th>
   <td>Y</td>
   <td></td>
   <td>Y</td>
   <td>Y</td>
   <td>Y</td>
   <td></td>
   <td>Y</td>
   <td>Y</td>
   <td>Y</td>
   <td>Y</td>
   <td>Y</td>
   <td>Y</td>
  </tr>
  <tr>
   <th><code>names</code></th>
   <td></td>
   <td></td>
   <td>Y</td>
   <td>Y</td>
   <td>Y</td>
   <td></td>
   <td></td>
   <td>Y</td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
  </tr>
  <tr>
   <th><code>permissions</code></th>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td>Y</td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
  </tr>
  <tr>
   <th><code>privileges</code></th>
   <td>Y</td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
 </tr>
  <tr>
   <th><code>retentionbucket</code></th>
   <td>Y</td>
   <td></td>
   <td>Y</td>
   <td></td>
   <td>Y</td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
  </tr>
  <tr>
   <th><code>retentionpolicy</code></th>
   <td>Y</td>
   <td></td>
   <td>Y</td>
   <td></td>
   <td>Y</td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
  </tr>
  <tr>
   <th><code>source</code></th>
   <td></td>
   <td>Y</td>
   <td></td>
   <td>Y</td>
   <td>Y</td>
   <td>Y</td>
   <td>Y</td>
   <td>Y</td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
  </tr>
  <tr>
   <th><code>template</code></th>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td>Y</td>
   <td></td>
   <td>Y</td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
  </tr>
  <tr>
   <th><code>templatelang</code></th>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td>Y</td>
   <td></td>
   <td>Y</td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
  </tr>
  <tr>
   <th><code>uname</code></th>
   <td></td>
   <td></td>
   <td>Y</td>
   <td>Y</td>
   <td>Y</td>
   <td></td>
   <td></td>
   <td>Y</td>
   <td></td>
   <td></td>
   <td></td>
   <td></td>
  </tr>
 </tbody>
</table>

### Installers, Uninstallers, Upgraders

These fields identify scripts to be run when certain events occur:

* field ``installers`` is processed when the {{% gl App %}} or {{% gl Accessory %}} is deployed;
* field ``upgraders`` is processed after an {{% gl App %}} or {{% gl Accessory %}} has been deployed and
  data has been restored that potentially must be migrated to work with the current
  version of the {{% gl App %}} or {{% gl Accessory %}}.

Note that during software upgrades, deployment and undeployment may occur as well
(see {{% pageref "../understanding/update.md" %}}).

Each of these fields points to an array. Each of the elements in the array is a separate
script that will be run in the sequence listed.

Here is an example for ``installers`` in the ``mysql`` role of an {{% gl App %}} that uses MySQL:

```
"installers" : [
  {
    "name"   : "maindb",
    "type"   : "sqlscript",
    "source" : "mediawiki/maintenance/tables.sql"
  }
]
```

When this section is processed, UBOS will run the script ``mediawiki/maintenance/tables.sql``
of type ``sqlscript`` against the database whose symbolic name is ``maindb``.

Supported types are:

* ``sqlscript``: a SQL script (but only for the ``mysql`` role)
* ``perlscript``: a Perl script

## Apache2 role

The ``apache2`` role knows additional fields.

### Context

Web {{% gls App %}} must specify one of the following two fields:

* ``defaultcontext``: the relative URL path at which the {{% gl App %}} is installed by default.
  For example, Wordpress may have a defaultcontext of ``/blog``, i.e. if the user installs
  Wordpress at ``example.com``, by default Wordpress will be accessible at
  ``http://example.com/blog``. This field is to be used if the {{% gl App %}} is able to be installed
  at any relative URL, but this is the default.
* ``fixedcontext``: some web {{% gls App %}} can only be installed at a particular relative URL,
  or only at the root of a {{% gl Site %}}. Use ``fixedcontext`` to declare that relative URL.

### Transport-level security (TLS) required

Some {{% gls App %}} require that they be accessed via HTTPS only, using SSL/TLS, and will
refuse to work over HTTP. Such {{% gls App %}} need to declare this requirement, so
UBOS can prevent that they are deployed to an HTTP-only site. To declare this requirement,
use this JSON fragment:

```
"requirestls" : true
```

If not given, the default for this field is assumed to be ``false``.

### Apache modules

``apache2modules`` is a list of names of Apache2 modules that need to be activated before
the {{% gl App %}} or {{% gl Accessory %}} can be successfully run. Here is an example:

```
"apache2modules" : [
  "php7"
]
```

This declaration will make sure that the ``php7`` module is active in Apache2; if not yet,
UBOS will activate it and restart Apache2 without any further work by the {{% gl App %}} or
{{% gl Accessory %}}.

Note that the ``apache2`` role still needs to declare a dependency on ``php7``;
``apache2modules`` does not attempt to infer which packages might be needed.

### PHP modules

``phpmodules`` is a list of names of PHP modules that need to be activated before
the {{% gl App %}} or {{% gl Accessory %}} can be successfully run. Here is an example:


```
"phpmodules" : [
  "gd"
]
```

This declaration will make sure that the PHP module ``gd`` has been
activated; if not, UBOS will activate it and restart Apache2.

Note that the ``apache2`` role still needs to declare a dependency on ``php-gd``;
``apache2modules`` does not attempt to infer which packages might be needed.

### Contributions to the site's "well-known"

{{% gls Site %}} may publish certain "well-known" files, such as ``robots.txt`` or
the content of directory ``.well-known`` below the root of the {{% gl Site %}}. Subject to
certain conflict resolution rules described in {{% pageref "../site-json.md" %}}, an
{{% gl App %}} deployed to a {{% gl Site %}} may request to augment those entries.

For that purpose, the ``wellknown`` entry may be specified. Here is an example:

```
"wellknown" : {
  "carddav" : {
    "value" : "..."
  },
  "caldav" : {
    "location" : "caldav.php",
    "status" : "302 Found"
  },
  "webfinger" : {
    "proxy" : "http://localhost:1234/webfinger"
  }
}
```

In ``wellknown``, each key-value pair represents an entry into the {{% gl Site %}}'s
``/.well-known/`` context path, with the key being the name of the file and the value
being a JSON object with the following potential members (Note the special rules for
``robots.txt`` and ``webfinger`` described below):

``value``
: Static file content if there is; the value may be encoded. This field must not be
  used by ``robots.txt`` or ``webfinger`` entries (see additional fields below).

``encoding``
: If given, ``base64`` is the only valid value. It indicates that the value of
  ``value`` is provided using Base64 encoding and needs to be decoded first. This is
  useful for entries such as ``favicon.ico``.

``location``
: Value for the HTTP ``Location`` header when accessed. This is mutually exclusive with
  ``value``: only one of these two may be provided. This field must not be used by
  ``robots.txt`` or ``webfinger`` entries (see below). This value may use variables
  (as described in {{% pageref variables.d %}}), which UBOS will replace during deployment.

``status``
: HTTP status code to return when accessed. This may only be specified when a
  ``location`` is provided, and the value must be a HTTP redirect status code,
  such as "307". When ``location`` is provided, the default is "307" (Temporary Redirect).

``allow``
: Only permitted for an entry whose key is ``robots.txt``. This field must have
  a value of type JSON array. The members of that array are individual ``Allow:`` entries
  for a composite ``robots.txt`` file. Each member is prefixed by the content path to
  the {{% gl AppConfiguration %}} to which this {{% gl App %}} has been deployed. For example,
  if one of the values is ``/assets/``, it will become ``Allow: /myapp/assets/`` if the
  {{% gl App %}} has been deployed at context path ``/myapp``.

``disallow``
: Just like ``allow``, but for ``Disallow:`` content for a composite ``robots.txt`` file.

``proxy``
: Only permitted for an entry whose key is ``webfinger``. This field must have a value of
  type string, containing a fully-qualified http or https URL (variable ``$(site.protocol)``
  may be used). This specifies that UBOS, when a client requests the {{% gl Site %}}'s
  well-known webfinger URL, should access the
  given URL, and semantically merge the resulting JSON files obtained from all {{% gl App %}}'s
  defining a well-known proxy at this {{% gl Site %}}. This enables multiple {{% gl App %}}'s
  deployed to the {{% gl Site %}} to all publish their contribution to the {{% gl Site %}}'s
  webfinger well-known. This value may use variables (as described in {{% pageref variables.md %}}),
  which UBOS will replace during deployment.

### Phases

When an {{% gl AppConfiguration %}} with an {{% gl App %}} and one ore more {{% gls Accessory %}}
is deployed, generally the {{% gls AppConfigItem %}} of the {{% gl App %}} are deployed first,
followed by the {{% gls AppConfigItem %}} of one {{% gl Accessory %}} at a time in the sequence
the {{% gls Accessory %}} were defined in the {{% gl Site_JSON %}} file.

Then, any installer or upgrader scripts are run in the sequence they were defined in the
{{% gl UBOS Manifest JSON %}}, with those defined by the {{% gl App %}} before those defined by the
{{% gls Accessory %}}.

Undeploying the {{% gl AppConfiguration %}} occurs in the opposite sequence.

However, sometimes it is necessary to deviate from this default sequence, in particular if
the {{% gl App %}} runs a daemon that requires that all {{% gls Accessory %}} have been
deployed already at the time it starts.

For example, if an {{% gl App %}} runs a Java daemon with {{% gls Accessory %}} that
contribute optional JARs, and the daemon only scans the available JARs at the time it first
starts up, clearly the daemon can only start all {{% gls Accessory %}} have been
deployed.

In order to support this (fairly rare) situation, the relevant
{{% gls AppConfigItem %}} (in the example, of type ``systemd-service`` that
starts the daemon) can be marked with an extra entry:

```
"phase" : "suspendresume"
```

This will cause the {{% gl AppConfigItem %}} to be skipped on the first pass when installing
{{% gls AppConfigItem %}}, and only process it on a second pass that occurs
after the {{% gls Accessory %}} have all been deployed.

No other values for ``phase`` are currently defined.

### Status of the AppConfiguration

{{% status proposed %}}

{{% gls App %}} may optionally declare an executable or script that, when invoked, reports
status information of the {{% gl AppConfiguration %}} on which it is applied. This status
information is provided in JSON in a format defined in {{% pageref "../app-status.md" %}}.

To declare such an executable or script, add the following JSON fragment in the ``apache2``
role in its {{% gl App %}}'s UBOS Manifest JSON, assuming the Perl script ``status.pl``
in directory ``${appconfig.apache2.dir}`` should be invoked:

```
"status" : {
  "source" : "status.pl",
  "type"   : "perlscript"
}
```

Alternatively, the ``exec`` type can be used:

```
"status" : {
  "source" : "status.sh",
  "type"   : "exec"
}
```

The script or executable will be invoked with the same arguments as other scripts or
executables specified in the UBOS Manifest JSON, but the value for ``operation`` is
``status``.

This script or executable is only invoked while the {{% gl App %}} has been deployed and
is supposed to be operational. It is not invoked at any other time.

{{% /status %}}
