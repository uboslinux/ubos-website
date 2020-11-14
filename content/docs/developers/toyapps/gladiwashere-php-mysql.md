---
title: Glad-I-Was-Here (PHP, MySQL)
weight: 20
---

## Introduction

Compared to {{% pageref helloworld.md %}}, Glad-I-Was-Here is a slightly more complex
"guestbook" web application that uses a SQL database to store guestbook entries. This
application has been implemented using several different programming languages and
relational databases, so it can act as an example how to package UBOS
{{% gls App %}} built with various common web technologies.

This section describes the possibly simplest-to-understand implementation using PHP
and MySQL.

If you have not already read through the {{% pageref helloworld.md %}} {{% gl App %}}
documentation, we recommend you do so first as we'll only discuss things in this section
that were not covered before.

Here is a screen shot of the {{% gl App %}} in action:

![Screenshot](/images/gladiwashere-screenshot.png)

To obtain the source code:

```
% git clone https://github.com/uboslinux/ubos-toyapps
```

Go to subdirectory ``gladiwashere-php-mysql``.

## Package lifecycle and App deployment

Like all other {{% gls App %}} on UBOS including {{% pageref helloworld.md %}},
``gladiwashere-php-mysql`` is built with ``makepkg``, installed with ``pacman``
and deployed with ``ubos-admin``:

```
% makepkg -f
% sudo pacman -U gladiwashere-php-mysql-*-any.pkg.tar.xz
% sudo ubos-admin createsite
```

Specify ``gladiwashere-php-mysql`` as the name of the {{% gl App %}}. This will
set up a website on your UBOS device that runs ``gladiwashere-php-mysql``.

## Manifest JSON

Let's examine this {{% gl App %}}'s {{% gl UBOS_Manifest %}} file. It is very
similar to that of ``helloworld``, but has several more entries:

```
{
  "type" : "app",

  "roles" : {
    "apache2" : {
      "defaultcontext" : "/guestbook",
      "depends" : [
        "php",
        "php-apache"
      ],
      "apache2modules" : [
        "php7"
      ],
      "phpmodules" : [
        "mysql",
        "mysqli"
      ],
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
    },
    "mysql" : {
      "appconfigitems" : [
        {
          "type"             : "database",
          "name"             : "maindb",
          "retentionpolicy"  : "keep",
          "retentionbucket"  : "maindb",
          "privileges"       : "select, insert"
        }
      ],
      "installers" : [
        {
          "name"   : "maindb",
          "type"   : "sqlscript",
          "source" : "sql/create.sql"
        }
      ]
    }
  }
}
```

* In addition to the ``apache2`` role, this {{% gl App %}} also has a ``mysql``
  {{% gl Role %}}. Like for the ``apache2`` {{% gl Role %}}, the contained
  {{% gls AppConfigItem %}} (entry ``appconfigitems``) tell UBOS what needs to
  be provisioned so the {{% gl App %}} can be run successfully. In the ``mysql``
  {{% gl Role %}}, these are items all related to MySQL.

  Here, we tell UBOS to provision a new database for each deployment of Glad-I-Was-Here,
  together with a new database user and a unique database credential. This database
  user will have database privileges ``select`` and ``insert`` but no others, because
  that's all the Glad-I-Was-Here {{% gl App %}} needs, and fewer privileges is
  better from a security perspective.

  The database's symbolic name is ``maindb``. This will NOT be the actual database
  name at deployment time. Instead, UBOS will create a (random) database name. To
  understand why this is useful, consider which database name, and database username
  and password should be used by this {{% gl App %}}. Hardcoding those would
  create a big security problem, and only a single installation of Hello World
  (or any other {{% gl App %}} that hardcoded its information) could run on the
  same device. Neither is desirable.

  So UBOS automatically generates a unique name, and uses that. To be able for you
  to refer to it, we use a symbolic name, here: ``maindb``. You will see that below
  when we discuss how the PHP code connects to the correct database with the correct
  database user and credential, using the template mechanism.

* The ``rententionbucket`` and ``retentionpolicy`` fields express that this database
  contains precious information that needs to be backed up when a backup is run, and
  kept during software upgrades. If those were not given, UBOS would discard the data
  in the database during upgrades and backups.

* The optional ``installers`` section allows the developer to specify actions to be
  taken after the database has been provisioned for the first time (but not
  after upgrades). Here, a script of type ``sqlscript`` needs to be run whose source can
  be found at ``/ubos/share/gladiwashere/sql/create.sql``. As you would have guessed,
  this script initializes the tables of the database. UBOS runs this script with more
  privileges (``create``) than the {{% gl App %}}'s database user has, which explains
  why the database user can get away with ``select`` and ``insert`` privileges only.

* Back above in the ``apache2`` section, ``phpmodules`` lists the PHP modules that
  the {{% gl App %}} requires. In this case, it needs MySQL drivers. These are names
  of PHP modules as found in ``/etc/php.ini`` and the like.

* The second ``appconfigitem`` in the ``apache2`` role specifies a template file,
  instead of a source. Together with a ``templatelang``, this indicates that
  variable substitution should be performed during deployment when copying the file.

  Here, the template file is the following (omitting the PHP comment for brevity):

  ```
  <?php
  $dbName   = '${appconfig.mysql.dbname.maindb}';
  $dbUser   = '${appconfig.mysql.dbuser.maindb}';
  $dbPass   = '${escapeSquote( appconfig.mysql.dbusercredential.maindb )}';
  $dbServer = '${appconfig.mysql.dbhost.maindb}';
  ```

  which will be transformed into the actual deployed file that looks like this:

  ```
  <?php
  $dbName   = 'somedbname';
  $dbUser   = 'somedbuser';
  $dbPass   = 'some\'dbpass';
  $dbServer = 'localhost';
  ```

  where ``somedbname`` etc are the values for the provisioned database. Above we said
  that ``maindb`` was the symbolic name of the to-be-provisioned database. This symbolic
  name allows us now to refer to various bits of information related to that database.
  For example, ``${appconfig.mysql.dbname.maindb}`` refers to the actual name of the
  MySQL database whose symbolic name is ``maindb``. You can see other such variables
  for database user, password and host.

* The third item creates a symbolic link.

Visit {{% pageref gladiwashere-php-postgresql.md %}} for a version of this
{{% gl App %}} that uses PHP and Postgresql, {{% pageref gladiwashere-java-mysql.md %}}
for one that uses Java, and {{% pageref gladiwashere-python-mysql.md %}} for one
that uses Python.
