---
title: Scripts in UBOS Manifests
weight: 100
---

Most application instrumentation in UBOS can be accomplished purely with
``ubos-manifest.json`` and template files that are parameterized with variables.

Sometimes, however, running a script or other command is necessary. For that purpose,
AppConfigItems and installers/upgraders of type ``exec`` and ``perlscript`` are provided.
These  allow developers to run code at certain points during {{% gl Site %}} deployment,
undeployment and other management tasks.

## Arbitrary executables

An AppConfigItem of type ``exec`` specifies a command that will be executed by UBOS.
Two command-line arguments are passed:

* argument 1: a text string that indicates the operation that is being
  applied, such as ``deploy``, ``undeploy``, ``install``, ``uninstall``, and
  ``upgrade`` (see below).
* argument 2: name of a JSON file that contains contextual variables,
  included all of those described in :doc:`variables`.

## Perl scripts

An AppConfigItem of type ``perlscript`` specifies a Perl fragment that will be executed by
UBOS through Perls' ``eval`` method. Two variables are being provided by the run-time context:

* ``$operation``: contains a text string that indicates the operation that is being
  applied, such as ``deploy``, ``undeploy``, ``install``, ``uninstall``, and
  ``upgrade`` (see below).
* ``$config``: a ``UBOS::Configuration`` object that contains contextual variables,
  included all of those described in :doc:`variables`.

Perl fragments typically look like this:

```
#!/usr/bin/perl

use strict;
use warnings;

my $dataDir = $config->getResolve( 'appconfig.datadir' );
    # or look up whatever variables are needed

if( 'deploy' eq $operation ) {
    # do something
}
if( 'undeploy' eq $operation ) {
    # do something else
}
# potentially more possible values of $operation
1;
```

## The ``operation`` parameter

The possible values of the ``operation`` parameter are the following:

For ``exec`` or ``perlscript`` {{% gls AppConfigItem %}}:

* ``deploy``: invoked when the {{% gl AppConfigItem %}} is deployed as part of the deployment
  or redeployment of an {{% gl App %}} to a {{% gl Site %}}.
* ``undeploy``: the reverse operation of ``deploy``. Invoked when the {{% gl AppConfigItem %}}
  is undeployed as part of the undeployment of an {{% gl App %}} from a {{% gl Site %}}.

For ``exec`` or ``perlscript`` installers:

* ``install``: invoked when an {{% gl App %}} is deployed or redeployed to a {{% gl Site %}},
  after all the {{% gls AppConfigItem %}} have been deployed, but only if no data is to be
  restored (i.e. it is a virgin install).
* ``uninstall``: the reverse operation of ``install``. Invoked when an {{% gl App %}} is undeployed
  from a {{% gl Site %}}, before any the {{% gls AppConfigItem %}} have been undeployed.

For ``exec`` or ``perlscript`` updaters:

* ``upgrade``: invoked when an {{% gl App %}} is deployed or redeployed to a {{% gl Site %}},
  after all the {{% gls AppConfigItem %}} have been deployed, but only if backup data is to be
  restored (i.e. it is a restore or upgrade, rather than a virgin install).

The same executable or script may be used to handle several of these operations, which is why
there are different verbs.

For an example, refer to ``initialize.pl`` and ``upgrade.pl`` in the Wordpress package for UBOS
([source](https://github.com/uboslinux/ubos-wordpress/blob/main/wordpress/bin>)).
This ``initialize.pl`` script is used to generate the Wordpress ``config.php`` file from a script, instead
of from a file template, and to initialize Wordpress. ``upgrade.pl`` invokes the Wordpress data
migration functionality after a Wordpress upgrade.
