---
title: Context Path
plural: Context Paths
summary: The part of a URL below the hostname to which an App is deployed.
seealsoterm: [
    'App',
    'Hostname',
    'Site'
]
---

The "path" part of a URL to which an {{% gl App %}} is being deployed, without
a trailing slash.

For example, if an {{% gl App %}} has been deployed to URL ``http://example.com/blog/``,
its {{% gl Context_Path %}} would be ``/blog``. If it were deployed to the root of the
{{% gl Site %}}, the {{% gl Context_Path %}} would be the empty string.
