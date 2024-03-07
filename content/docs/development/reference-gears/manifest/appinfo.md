---
title: Appinfo section
weight: 50
---

{{% status proposed %}}

{{% gls App %}} may optionally provide this section in a {{% gl UBOS_Manifest %}}.
Here is an example:

```
"appinfo" : {
  "defaultaccessoryids" : [
    "accessory1",
    "accessory2"
  ]
}
```

In this example, the {{% gl App %}} specifies that if no {{% gls Accessory %}}
have been specified for an {{% gl AppConfiguration %}} running this {{% gl App %}},
the default {{% gls Accessory %}} ``accessory1`` and ``accessory2`` shall
be deployed.

This makes it easier for users to install {{% gls App %}} in a reasonable default
configuration.

{{% /status %}}
