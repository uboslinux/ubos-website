---
title: Customization Point
plural: Customization Points
summary: Allows customization of deployed Apps or Accessories.
seealsoterm: [
    'Accessory',
    'App',
    'Site'
]
domain: UBOS Gears
---

A variable for a {{% gl Deployment deployed %}} {{% gl App %}} or {{% gl Accessory %}} whose value
can be customized by the user.

While any {{% gl App %}} or {{% gl Accessory %}} may define its own {{% gls Customization_Point %}}
in its {{% gl UBOS_Manifest %}}, the values for {{% gls Customization_Point %}} are specific to
the {{% gl AppConfiguration %}} at which the {{% gl App %}} or {{% gl Accessory %}} has been
{{% gl Deployment deployed %}}.

For example, an {{% gl App %}} such as Wordpress might allow the user to configure
the title of their blog upon deployment. In this case, the {{% gl App %}} might
declare a {{% gl Customization_Point %}} called ``title`` in its
{{% gl UBOS_Manifest %}}. It may or may not specify a default value. If Wordpress is
{{% gl Deployment deployed %}} twice, the values for its ``title`` may differ in
these two {{% gls Deployment %}}.
