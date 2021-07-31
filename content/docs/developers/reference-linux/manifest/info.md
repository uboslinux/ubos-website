---
title: Info section
weight: 20
---

The info section in a {{% gl UBOS_Manifest %}} is optional but recommended.
It contains user-friendly, localized information about the {{% gl App %}} or
{{% gl Accessory %}}. Here is an example:

```
"info" : {
  "en_US" : {
    "name" : "Glad I Was Here",
    "tagline" : "Best guestbook evar"
  },
  "de" : {
    "name" : "Gerne hier gewesen",
    "tagline" : "Das allerbeste Gästebuch"
  },
  "default" : {
    "name" : "Glad I Was Here",
    "tagline" : "Best guestbook evar"
  }
}
```

Below the ``info`` tag, the ``name`` and ``tagline`` fields are grouped by locale. A locale:

* may have two components, such as ``en_US``, or ``fr_FR`` (language, underscore, country)
* may have one component, such as ``de`` (language)
* or be the special value ``default``, which is used if no more appropriate locale
  can be found.

``name`` is a user-friendly name for the {{% gl App %}} or {{% gl Accessory %}}.

``tagline`` is a single-line, short summary for the {{% gl App %}} or {{% gl Accessory %}} that reminds the
user what this {{% gl App %}} or {{% gl Accessory %}} is all about.
