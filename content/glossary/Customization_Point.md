---
title: Customization Point
plural: Customization Points
summary: Allows customization of deployed Apps or Accessories.
seealsoterm: [
    'App',
    'Accessory',
    'Site'
]
---

A variable for a deployed {{% gl App %}} or {{% gl Accessory %}} whose value
can be customized by the user.

For example, an {{% gl App %}} such as Wordpress might allow the user to configure
the title of their blog upon deployment. In this case, the {{% gl App %}} might
declare a {{% gl Customization_Point %}} called ``title`` in its
{{% gl UBOS_Manifest %}}. It may or may not specify a default value.
