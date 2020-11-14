---
title: Site JSON
weight: 50
---

## Overview

A {{% gl Site_JSON %}} file describes the structure of a {{% gl Site %}}, aka virtual
host. Generally, {{% gl Site %}}:

* has a certain hostname, such as ``family.example.com``, or ``*`` if the {{% gl Site %}}
  should respond to all requests regardless of HTTP host header;
* has a single administrator, for which username, e-mail address etc. are given;
* may or may not have SSL/TLS information (key, certificate etc.) so the {{% gl Site %}} can be
  served over HTTPS;
* runs one or more {{% gls App %}} at different context paths, such as Wordpress at ``/blog``,
  and a wiki at ``/wiki``.
* each of those {{% gls App %}} may be configured with any number of
  {{% gls Accessory %}} (for example, Wordpress plugins or themes)
* may also define certain well-known files, such as ``robots.txt``.

UBOS captures all of this information in a single JSON file with a particular structure,
called the {{% gl Site_JSON %}} file. You can usually interact with {{% gl Site_JSON %}}
files as opaque blobs, but if you like to see the {{% gl Site_JSON %}} file for a
{{% gl Site %}} you have currently deployed, use the ``ubos-admin showsite`` command
either with the {{% gl Site %}}'s hostname or {{% gl SiteId %}}:

```
% sudo ubos-admin showsite --json --hostname <hostname>
```

or

```
% sudo ubos-admin showsite --json --siteid <siteid>
```

If you run this command as a user other than ``root``, no credential information will be
included.

The easiest way of creating a {{% gl Site_JSON %}} file is with the ``createsite`` command:

```
% sudo ubos-admin createsite -n -o newsite.json
```

(The ``-n`` flag will only generate the {{% gl Site_JSON %}} and not deploy the
{{% gl Site %}}; the ``-o newsite.json`` flag will save the generated
{{% gl Site_JSON %}} to file ``newsite.json``.)

## Structure

The {{% gl Site_JSON %}} is a JSON hash with the following entries:

``admin`` (required)
: The admin section defines the administrator for the {{% gl Site %}}. It has the following
  entries:

   ``userid`` (required)
      User identifier for the administrator. Example: ``admin``.

   ``username`` (required)
      Human-readable name for the administrator. Example: ``John Smith``.

   ``credential`` (required)
      Credential for the administrator account. Example: ``s3cr3t``. Only shown to the
      root user.

   ``email`` (required)
      Contact e-mail for the administrator. Example: ``admin@family.example.org``.

``appconfigs`` (optional)
: A JSON array of the {{% gls AppConfiguration %}} at this {{% gl Site %}}. There is
  no significance to the order of the elements in the array. An {{% gl AppConfiguration %}}
  is the deployment of an {{% gl App %}} at a particular {{% gl Context_Path %}}
  at a particular {{% gl Site %}}, together with any {{% gls Accessory %}} and/or
  {{% gls Customization_Point %}} that are specific to this deployment of the {{% gl App %}}.

``hostname`` (required)
: The hostname for the {{% gl Site %}}, or ``*``. E.g. ``family.example.org``.

``lastupdated`` (optional)
: timestamp for when this {{% gl Site_JSON %}} file was last deployed to the current
  {{% gl Device %}}. This data element gets inserted or updated by UBOS in the
  {{% gl Site_JSON %}} held on the {{% gl Device %}} every time a {{% gl Site %}}
  is deployed.

``siteid`` (required)
: The {{% gl SiteId %}}: a unique identifier for the {{% gl Site %}}. This is generally
  an ``s`` followed by 40 hex characters. E.g. ``s054257e710d12d7d06957d8c91ab2dc1b22d7b4c``.

``tls`` (optional)
: This section is optional. If provided, UBOS will set up the {{% gl Site %}} to be only
  accessible via HTTPS. UBOS will also automatically redirect incoming HTTP requests
  to their HTTPS equivalent.

   ``letsencrypt``
      If ``true``, obtain a certificate from {{% gl LetsEncrypt %}}, and set up the
      {{% gl Site %}} with it. Also start an automatic renewal process.

   ``key`` (if not provided and not ``letsencrypt``, auto-generate one)
      The key for the tls {{% gl Site %}}. Only shown to the ``root`` user.

   ``crt`` (if not provided and not ``letsencrypt``, create a self-signed on)
      The certificate for the tls {{% gl Site %}} as issued by your certificate authority,
      plus the certificate chain of your certificate authority, concatenated into
      one file.  Only shown to the ``root`` user.

   ``cacrt`` (optional)
      If you use TLS client authentication (not common), the certificate chain
      of the certificate authorities that your TLS clients are using.
      Only shown to the ``root`` user.

``tor`` (optional)
: This section is optional. If it is given, this {{% gl Site %}} is intended to be
  run as a Tor hidden service.

  ``privatekey`` (optional)
     Contains the Tor private key, if it has been allocated already.

``wellknown`` (optional)
   This section is optional. It contains the data for "well-known" files that your
   {{% gl Site %}} may be using. In this section, each key-value pair represents an
   entry into the {{% gl Site %}}'s ``/.well-known/`` {{% gl Context_Path %}}, with the
   key being the name of the file and the value being a structure with the following
   potential members:

   ``value``
      Static file content if there is; the value may be encoded.

   ``encoding``
      If given, ``base64`` is the only valid value. It indicates that the value of
      ``value`` is provided using Base64 encoding and needs to be decoded first. This is
      useful for entries such as `favicon.ico`.

   ``status``
      HTTP status code to return when accessed. This may only be specified when a
      ``location`` is provided, and the value must be a HTTP redirect status code, such
      as "307". When ``location`` is provided, the default is "307" (Temporary Redirect).

   ``location``
      Value for an HTTP Redirect header when accessed. This is mutually exclusive with
      ``value``: only one of these two may be provided.

   ``prefix``
      Only permitted for an entry whose key is ``robots.txt`` and for which no ``value``
      has been provided. See discussion below.

   For all keys other than ``robots.txt``, the values provided in the {{% gl Site_JSON %}}
   override any values that may have been provided by the {{% gls App %}} deployed to that
   {{% gl Site %}}. Conversely, if the {{% gl Site_JSON %}} does not specify a certain key,
   but an {{% gl App %}} deployed to this {{% gl Site %}} does, the {{% gl App %}}'s will
   be used (more details are described in {{% pageref ubos-manifest.md %}}). If multiple
   {{% gls App %}} define the same key, the value from the {{% gl App %}} defined earlier
   in the {{% gl Site_JSON %}}'s list of {{% gls AppConfiguration %}} takes precedence over
   later ones.

   If a ``value`` is provided for the key ``robots.txt``, this value will be used.
   If not, the value for the ``robots.txt`` content is constructed by concatenating:

   * the value of ``prefix`` in the {{% gl Site_JSON %}}, if such a value is given;

   * a catch-all ``User-Agent`` line

   * all ``Allow``/``Disallow`` statements specified by the {{% gls App %}}
     (more details are described in {{% pageref ubos-manifest.md %}}).

   Note that UBOS will automatically make the content of the historic files `robots.txt`,
   `favicon.ico` and `sitemap.xml` available both at the root of the {{% gl Site %}} and
   in the `.well-known` sub-directory.

## AppConfigurations

Each member of the ``appconfigs`` array is a JSON hash with the following entries:

``appconfigid`` (required)
: A unique identifier for the {{% gl AppConfiguration %}}. This is generally an ``a``
  followed by 40 hex characters. E.g. ``a7d74fb881d43d12ff0ba4bd2ed39a98e107eab8c``.

``context`` (optional)
: The context path, from the root of the {{% gl Site %}}, where the {{% gl AppConfiguration %}}
  will run. For example, if you want to run Wordpress at ``http://example.org/blog``, the
  {{% gl Context_Path %}} would be ``/blog`` (no trailing slash). If you want to run an
  {{% gl App %}} at the root of the {{% gl Site %}}, specify an empty string. If this field
  is not provided, UBOS will use the {{% gl App %}}'s default {{% gl Context_Path %}}
  defined in the {{% gl App %}}'s {{% pageref ubos-manifest.md %}}.

``isdefault`` (optional)
: If provided, the value must be boolean ``true``. This instructs UBOS to automatically
  redirect clients from the root page of the {{% gl Site %}} to this {{% gl AppConfiguration %}}.
  If not provided, UBOS will show the installed {{% gls App %}} at the root page of the
  {{% gl Site %}}.

``appid`` (required)
: The package identifier of the {{% gl App %}} to be run. For example: ``wordpress``.

``accessoryids`` (optional)
: If provided, this entry must be a JSON array, containing one or more package
  identifiers of the {{% gls Accessory %}} to be run for this installation of the {{% gl App %}}.
  For example: ``[ 'wordpress-plugin-webmention' ]``

``customizationpoints`` (optional)
  If provided, this entry must be a JSON hash, providing values for
  {{% pageref "manifest/customizationpoints.md" %}} of the {{% gl App %}} and/or
  {{% gls Accessory %}} at this {{% gl AppConfiguration %}}. They keys in this
  JSON hash are the package names of the packages installed at this {{% gl AppConfiguration %}},
  i.e. the package name of the {{% gl App %}}, and any additional {{% gls Accessory %}}.
  (By doing this, there cannot be any namespace collisions between {{% gls Customization_Point %}}
  defined in the {{% gl App %}} and the {{% gl Accessory %}}).

  The value for each package is again a JSON hash, with the name of the
  {{% gl Customization_Point %}} as the key, and a JSON hash as a value. Typically, this
  last JSON hash only has a single entry named ``value``, whose value is the value of the
  {{% gl Customization_Point %}}. For example:

  ```
  "customizationpoints" : {
    "wordpress" : {
      "title" : {
        "value" : "My blog"
      }
    }
  }
  ```
