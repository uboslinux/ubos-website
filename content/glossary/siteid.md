---
title: SiteId
plural: SiteIds
summary: Uniquely identifies a Site.
seealsoterm: [
    "AppConfigId",
    "Site"
]
domain: UBOS Linux
---

UBOS identifies each {{% gl Site %}} with a unique identifier, called the
{{% gl SiteId %}}, which consists of an ``s`` and a long hexadecimal number.

For example, ``s4100f3ed79b845dc04a974c0144f5c5b2f81face`` is a valid
{{% gl SiteId %}}.

A {{% gl Site %}}'s
{{% gl SiteId %}} establishes the identity of the {{% gl Site %}} and remains
persistent even if the {{% gl Site %}}'s {{% gl Hostname %}} is changed, for example.

{{% gls SiteId %}} are used with UBOS commands that refer to a
particular {{% gl Site %}}.

To determine a {{% gl Site %}}'s {{% gl SiteId %}}, execute:

```
% sudo ubos-admin listsites --detail
```

Because {{% gls SiteId %}} are long and unwieldy, many UBOS commands allow
the use of only the first few characters, as long as they are unique on the
{{% gl Device %}}, and you append three periods at the end, in lieu of
the remainder.

For example, if there is no other {{% gl Site %}} installed on your
{{% gl Device %}} and the {{% gl SiteId %}} you wish to specify is the one
shown above, you can use ``s41...``, ``s4100f3...`` or even ``s...`` as
a shorthand.

Many commands also accept the {{% gl Site %}}'s {{% gl Hostname %}}
instead of the {{% gl SiteId %}}.

