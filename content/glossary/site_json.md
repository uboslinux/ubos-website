---
title: Site JSON
summary: A JSON file that contains all meta-data about a Site.
seealsoterm: [
    'Site',
    'Site_JSON_Template',
    'Hostname'
]
domain: UBOS Gears
---

A JSON file that contains all meta-data about a {{% gl Site %}}, including its
{{% gl Hostname %}}, whether it uses TLS and potentially the TLS keys and certificates,
which {{% gls App %}} are installed at which relative URLs with which {{% gl Accessory %}},
and so forth.

To obtain the full {{% gl Site_JSON %}} for a particular {{% gl Site %}} with
{{% gl SiteId %}} ``<siteid>``, execute:

```
% sudo ubos-admin showsite --json --siteid <siteid>
```
