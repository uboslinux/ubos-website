---
title: "Command: ubos-admin deploy"
---

## Running

To see the supported options, invoke ``ubos-admin deploy --help``.

This command must be run as root (``sudo ubos-admin deploy``).

## Understanding

If the {{% gl Site_JSON %}} file provided to this command is valid, UBOS will
perform the following steps:

1. Install {{% gls Package %}} that haven't been installed yet and that are required to deploy
   the {{% gls App %}} and {{% gls Accessory %}} in the {{% gl Site_JSON %}}. This
   includes:

   * the {{% gls Package %}} of {{% gls App %}} to be deployed per the {{% gl Site_JSON %}},
     but not yet installed on the {{% gl Device %}};

   * the {{% gls Package %}} of {{% gls Accessory %}} to be deployed per the {{% gl Site_JSON %}},
     but not yet installed on the {{% gl Device %}};

   * dependencies of those {{% gls Package %}} as listed in the respective ``PKGBUILD``
     files;

   * {{% gls Package %}} listed in the ``depends`` section of the {{% gl UBOS_Manifest %}}
     of the {{% gls App %}} and {{% gl Accessory %}}, for those {{% gls Role %}} that
     are being used on the {{% gl Device %}}.

   * the database engine(s) required for the {{% gls App %}}, if not already installed.

1. If the {{% gl Site %}} has previously been deployed (i.e. the {{% gl SiteId %}} of
   a to-be-deployed {{% gl Site %}} is the same as that of an already-deployed
   {{% gl Site %}}; this does not consider the hostname, only the {{% gl SiteId %}}):

   1. the existing {{% gl Site %}} will first be suspended;

   1. the {{% gl Site %}}'s frontpage will be replaced with a placeholder saying
      "upgrade in progress".

   1. the data of all the {{% gls App %}} and {{% gls Accessory %}} at the
      {{% gl Site %}} will temporarily be backed up.

   1. if the user requested a backup through the command-line-option, this backup will
      be exported to the specified destination;

   1. all of the previously deployed {{% gl Site %}}'s {{% gls App %}} and
      {{% gls Accessory %}} will be undeployed.

1. If the {{% gl Site %}} hadn't been deployed previously, the {{% gl Site %}}'s
   frontpage will be replaced with a placeholder saying "upgrade in progress".

1. If the {{% gl Site_JSON %}} specifies to use a {{% gl LetsEncrypt %}} certificate, and
   no valid certificate for this {{% gl Site %}} is available on the {{% gl Device %}},
   ``certbot`` will automatically contact the {{% gl LetsEncrypt %}} web service and
   attempt to obtain a valid certificate for the {{% gl Site %}}. This involves the
   temporary publication of a challenge document in the {{% gl Site %}}'ss ``.well-known``
   subdirectory.

   If a valid certificate was found or obtained, the {{% gl Site %}} will then be set
   up with it. If no valid certificate could be obtained (e.g. because
   {{% gl LetsEncrypt %}} could not contact the device due to DNS problems or a lack of
   public IP address, per {{% gl LetsEncrypt %}} requirements), {{% gl Site %}} will still
   be set up, but without SSL/TLS and after emitting a warning message.

1. If the {{% gl Site %}} specifies TLS (not {{% gl LetsEncrypt %}}) but no key or
   certificate was provided as part of the {{% gl Site_JSON %}}, a self-signed
   key/certificate pair will be automatically generated.

1. All the {{% gls App %}} and {{% gls Accessory %}} specified in the new {{% gl Site_JSON %}}
   will be deployed. For each of them, the {{% gl UBOS_Manifest %}} is processed. For each of
   the {{% gls Role %}} in each {{% gl UBOS_Manifest %}}, each of the {{% gls AppConfigItem %}}
   is deployed: files are copied, directories created, databases provisioned and populated,
   and scripts run. The {{% gls Role %}} are processed in the sequence from backend to
   frontend, so that, for example, at the time the Apache {{% gl Role %}} is processed,
   the setup of a MySQL database is already complete.

1. If the {{% gl Site %}} had been previously deployed on this {{% gl Device %}}, the previously
   backed-up data will be restored to those {{% gls AppConfiguration %}} in the {{% gl Site %}}
   that still exist; then, the "upgrade" scripts will be run that were specified by the
   {{% gls App %}} and {{% gls Accessory %}} in their respective of {{% gl UBOS_Manifest %}}.

1. If an {{% gl App %}} or {{% gl Accessory %}} at the {{% gl Site %}} had not previously been
   deployed, the "installer" scripts will be run instead that were specified by the
   {{% gls App %}} and {{% gls Accessory %}} in their respective of {{% gl UBOS_Manifest %}}.

1. The frontpage of the {{% gl Site %}} will be re-enabled.

This command also accepts the ``--template`` flag. In this case, ``ubos-admin deploy``
allows the provided {{% gl Site_JSON %}} file to leave out information such as {{% gls SiteId %}}
and {{% gls AppConfigId %}}, and automatically generate new ones before deploying
the {{% gl Site %}}

## See also:

* {{% pageref "/docs/users/ubos-admin.md" %}}
* {{% pageref createsite.md %}}
* {{% pageref undeploy.md %}}
