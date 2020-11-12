---
title: Accessoryinfo section
---

{{% gls Accessory %}} must provide this section in a {{% pageref "../ubos-manifest.md" %}}. Here is an example:

```
"accessoryinfo" : {
  "appid" : "wordpress",
  "accessoryid" : "jetpack",
  "accessorytype" : "plugin",
  "requires" : [
    "other-accessory"
  ]
}
```

``appid`` is the name of the package that contains the :term:`App` to which this
{{% gl Accessory %}} belongs. In this example, the {{% gl Accessory %}} belongs to the
``wordpress`` {{% gl App %}}. This value is required.

``accessoryid`` and ``accessorytype`` are optional fields. If they are given, they
identify the {{% gl Accessory %}} in the terminology of the {{% gl App %}} that the
{{% gl Accessory %}} belongs to. This often makes it easier for {{% gl Accessory %}}
activation and the like to perform the correct action, based on the type of {{% gl Accessory %}}.

For example, Wordpress {{% gls Accessory %}} can be plugins or themes. Their activation is different
depending on their type. If the {{% gl UBOS_Manifest %}} marks the {{% gl Accessory %}} with this
type, as Wordpress understands it, a general-purpose activation script can perform different actions
based on that type.

* ``accessoryid`` is the name of the {{% gl Accessory %}} as the {{% gl App %}} refers to it. This may
  or may not be the same as the {{% gl Accessory %}}'s {{% gl Package %}} name. For example, Wordpress
  may refer to a plugin as "jetpack", while the UBOS {{% gl Package %}} for the plugin is
  ``wordpress-plugin-jetpack``. The domain of this value depends on the {{% gl App %}}.

* ``accessorytype`` is the type of {{% gl Accessory %}} that this is. For example, Wordpress
  distinguishes between plugins and themes. The domain of this value depends on the {{% gl App %}}.

* ``requires`` is an optional array of other {{% gl Accessory %}} names. If it is given, this
  {{% gl Accessory %}} can only be used successfully for a given {{% gl AppConfiguration %}}, if the listed
  other {{% gls Accessory %}} have also been deployed at the same {{% gl AppConfiguration %}}.
