---
title: Appinfo section
weight: 50
---

{{% status proposed %}}

{{% gls App %}} may optionally provide this section in a {{% pageref "../ubos-manifest.md" %}}.
Here is an example:

```
"appinfo" : {
  "defaultaccessoryids" : [
    "accessory1",
    "accessory2"
  ]
}
```

In this example, the {{% gl App %}} specifies that if no :term:`Accessories <Accessory>`
have been specified for an {{% gl AppConfiguration %}} running this {{% gl App %}},
the default :term:`Accessories <Accessory>` ``accessory1`` and ``accessory2`` shall
be deployed.

This makes it easier for users to install :term:`Apps <App>` in a reasonable default
configuration.

{{% /status %}}
