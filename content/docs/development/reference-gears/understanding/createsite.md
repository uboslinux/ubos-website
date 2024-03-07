---
title: "Command: ubos-admin createsite"
---

## Running

To see the supported options, invoke ``ubos-admin createsite --help``.

Unless the ``--dry-run`` command is given, this command must be run as root
(``sudo ubos-admin createsite``).

## Understanding

This command is best understood as a wrapper around {{% pageref deploy.md %}}
which:

* creates a {{% gl Site_JSON %}} from information provided interactively by the user
  on the terminal;

* optionally, generates an OpenSSL key pair and a self-signed certificate and inserts
  those into the {{% gl Site_JSON %}} file;

* optionally, obtains a {{% gl LetsEncrypt %}} SSL/TLS certificate. Due to the way
  {{% gl LetsEncrypt %}} operates, this only works on {{% gls Device %}} that have a
  publicly accessible IP address and public DNS has been set up to resolve the hostname
  of the to-be-created {{% gl Site %}} to that {{% gl Device %}}.

* deploys the generated {{% gl Site_JSON %}} file using {{% pageref deploy.md %}}.

* optionally, the user can provide a template {{% gl Site_JSON %}} file as
  an argument to the command. If so, the user will only be asked for
  information that is not already contained in the template {{% gl Site_JSON %}} file.

This command does nothing that {{% pageref deploy.md %}} cannot do. It only
exists for ease-of-use purposes, so users do not need to edit {{% gl Site_JSON %}}
files directly.

## See also:

* {{% pageref "/docs/operation/ubos-admin.md" %}}
* {{% pageref deploy.md %}}
