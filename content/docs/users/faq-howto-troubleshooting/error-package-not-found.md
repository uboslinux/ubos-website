---
title: '"Package not found error" when installing a new App or Accessory'
---

This can happen if you haven't updated your UBOS {{% gl Device %}} for some time.
In this case, ``ubos-admin`` will attempt to install a {{% gl Package %}} that has
been upgraded since your last update, and can't find the old version.

Always execute ``ubos-admin update`` before installing a new {{% gl App %}}
or {{% gl Accessory %}}.



