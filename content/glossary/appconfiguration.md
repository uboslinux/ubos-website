---
title: AppConfiguration
plural: AppConfigurations
summary: The deployment of an App at a particular Site with a certain Context Path.
seealsoterm: [
    'App',
    'Site',
    'Context_Path'
]
domain: UBOS Gears
---

The installation of an {{% gl App %}}, potentially with one or more {{% gls Accessory %}}
at a particular {{% gl Site %}} (aka virtual host) with a certain {{% gl Context_Path %}}.

For example, if a {{% gl Device %}} runs the two virtual hosts ``example.com``
and ``example.net``, and Wordpress is installed at ``http://example.com/blog/``, at
``http://example.com/notes/`` and at the root of ``https://example.net/``, the
{{% gl Device %}} runs three {{% gls AppConfiguration %}}. It can additionally
run several other {{% gls AppConfiguration %}} for other {{% gls App %}}.

Each of the {{% gls AppConfiguration %}} usually has its own database, data storage,
set of {{% gls Accessory %}} and values for {{% gls Customization_Point %}}.

{{% gls AppConfiguration %}} are identified through {{% gls AppConfigId %}}.
