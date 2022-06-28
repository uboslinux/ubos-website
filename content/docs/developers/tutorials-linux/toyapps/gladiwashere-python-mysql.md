---
title: Glad-I-Was-Here (Python, MySQL)
weight: 60
---

## Introduction

The Python version of Glad-I-Was-Here is functionally equivalent to
{{% pageref gladiwashere-php-mysql.md %}}. However, it is
implemented in Python and interacts with the web server through WSGI, as
many Python web applications do.

If you have not already read through {{% pageref gladiwashere-php-mysql.md %}}
of Glad-I-Was-Here, we recommend you do so first as we'll only discuss things in this
section that were not covered before.

```
% git clone https://github.com/uboslinux/ubos-toyapps
```

Go to subdirectory ``gladiwashere-python-mysql``.

## Package lifecycle and App deployment

Like all other {{% gls App %}} on UBOS including {{% pageref helloworld.md %}},
``gladiwashere-python-mysql`` is built with ``makepkg``, installed with
``pacman`` and deployed with ``ubos-admin``.

```
% makepkg -f
% sudo pacman -U gladiwashere-python-mysql-*-any.pkg.tar.xz
% sudo ubos-admin createsite
```

Specify ``gladiwashere-python-mysql`` as the name of the {{% gl App %}}.

## Manifest JSON

Let's examine this {{% gl App %}}'s {{% gl UBOS_Manifest %}} file. It is similar to
that of ``gladiwashere-php-mysql``, but there are a few differences:

* It declares the {{% gl App %}} as requiring TLS. This means the user cannot deploy
  it to a {{% gl Site %}} unless the {{% gl Site %}} uses TLS (i.e. it is a
  HTTPS-only site).
* It specifies dependencies on Python instead of PHP modules,
* It keeps application files out of the Apache document root. This is good
  security practice, and somewhat easier with WSGI than with PHP:

```
{
    "type" : "app",

    "requirestls" : true,

    "roles" : {
        "apache2" : {
            "defaultcontext" : "/guestbook",
            "depends" : [
                "mod_wsgi",
                "python-mysql-connector"
            ],
            "apache2modules" : [
                "wsgi"
            ],
           "appconfigitems" : [
                {
                    "type"         : "directory",
                    "name"         : "${appconfig.datadir}"
                },
                {
                    "type"         : "file",
                    "name"         : "${appconfig.datadir}/config.py",
                    "template"     : "tmpl/config.py.tmpl",
                    "templatelang" : "varsubst"
                },
                {
                    "type"         : "file",
                    "name"         : "${appconfig.apache2.appconfigfragmentfile}",
                    "template"     : "tmpl/htaccess.tmpl",
                    "templatelang" : "varsubst"
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
                },
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

Let's first note what is the same as in the PHP version:

* The ``type`` is ``app`` for both, of course.

* The ``defaultcontext`` is the same.

* The entire ``mysql`` section is the same, including database permissions and
  database initialization.

Here are the differences:

* Apache now needs to use modules ``wsgi``, which allow Apache to invoke Python.
  Because there is no more PHP involved, the Apache PHP modules are not needed any more.

* Instead of having the PHP files as ``appconfigitems``, there is only one Apache
  configuration fragment file that configures Apache's WSGI module. This file is
  in the package as a template, so UBOS can correctly parameterize it for the particular
  {{% gl AppConfiguration %}} (see below).

* Just as in the PHP case, we generate a Python file that contains
  {{% gl AppConfiguration %}}-specific parameters (the database name, username and
  credentials) and import that into our application.

## WSGI configuration

The Apache WSGI configuration could be different, as WSGI has many options, but in
this example it is this:

```
WSGIScriptAlias ${appconfig.contextorslash} ${package.codedir}/web/index.py

WSGIDaemonProcess gladiwashere-python-mysql-${appconfig.appconfigid} processes=2 threads=10 \
       umask=0007 inactivity-timeout=900 maximum-requests=1000 \
       python-path=${package.codedir}/web:${appconfig.datadir}:/usr/lib/python3.8/site-packages/
WSGIProcessGroup gladiwashere-python-mysql-${appconfig.appconfigid}

# Can't do this because there may be more than one WSGI :term:`App`:
# WSGIApplicationGroup %{GLOBAL}

<Directory "${package.codedir}">
    Require all granted
</Directory>
<Directory "${appconfig.datadir}">
    Require all granted
</Directory>
```

At deployment time, UBOS will replace the variables in this template and save the
resulting file as ``.htaccess`` in the web server directory, such as:

```
WSGIScriptAlias /guestbook /usr/share/gladiwashere-python-mysql/web/index.py

WSGIDaemonProcess gladiwashere-python-mysql-a1234567890123456789012345678901234567890 processes=2 threads=10 \
       umask=0007 inactivity-timeout=900 maximum-requests=1000 \
       python-path=/ubos/share/gladiwashere-python-mysql/web:/ubos/lib/gladiwashere-python-mysql/a1234567890123456789012345678901234567890:/usr/lib/python3.6/site-packages/
WSGIProcessGroup gladiwashere-python-mysql-a1234567890123456789012345678901234567890

# Can't do this because there may be more than one WSGI App:
# WSGIApplicationGroup %{GLOBAL}

<Directory "/ubos/share/gladiwashere-python-mysql">
    Require all granted
</Directory>
<Directory "/ubos/lib/gladiwashere-python-mysql/a1234567890123456789012345678901234567890">
    Require all granted
</Directory>
```

Let's go through these lines step by step:

* ``WSGIScriptAlias`` maps all incoming requests to the ``index.py`` script, which is the
  entry point to the application.

* ``WSGIDaemonProcess`` specifies parameters to the WSGI setup, such as how many processes
  to spawn for our application. The ``python-path`` argument must list all locations
  for Python files that are being included by the application. Here, we specify a location
  in the application package (``/ubos/share/gladiwashere-python-mysql/web``), a location in the
  {{% gl AppConfiguration %}}'s data directory
  (``/ubos/lib/gladiwashere-python-mysql/a1234567890123456789012345678901234567890``) where we
  save the generated/parameterized code, and the default location for Python packages on
  the system (``/usr/lib/python3.8/site-packages/``)

* ``WSGIProcessGroup`` puts all processes for this {{% gl AppConfiguration %}} into the same Linux
  process group. This is optional.

* The two ``Directory`` declarations are allowing access to these directories, otherwise
  Apache will prevent access.
