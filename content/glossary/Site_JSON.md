---
title: Site JSON
summary: A JSON file that contains all meta-data about a Site.
seealsoterm: [
    'Site',
    'Hostname'
]
---

A JSON file that contains all meta-data about a {% gl Site %}}, including its
{{% gl Hostname %}}, whether it uses TLS and potentially the TLS keys and certificates,
which {{% gls Apps %}} are installed at which relative URLs, and so forth.

To obtain the full {{% gl Site_JSON %}} for a particular installed {{% gl Site %}} with
{{% gl SiteId %}} ``<siteid>``, execute:

```
% sudo ubos-admin showsite --json --siteid <siteid>
```
