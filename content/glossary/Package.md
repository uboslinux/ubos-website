---
title: Package
plural: Packages
summary: A unit of code and associated files bundled together
seealsoterm: [
    'App',
    'Accessory'
]
---

A set of code components, and other files that logically belong together and should
be installed or uninstalled together.

For example, the ``wordpress`` {{% gl Package %}} contains all code specific to
the Wordpress {{% gl App %}}, but no code that might also be used by other
{{% gls Package %}}. Such other code, e.g. PHP, would be contained in a
separate {{% gl Package %}}.

