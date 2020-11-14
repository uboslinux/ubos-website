---
title: App
plural: Apps
summary: A software module that provides value to a user, such as a web app.
seealsoterm: [
    'Accessory'
]
---

On UBOS, an {{% gl App %}} is a software application that provides direct value to
the end user without any further additions, integrations or customizations. Those
further additions would be called {{% gls Accessory %}}.

{{% gls App %}} generally have software dependencies only on {{% gls Package %}}
provided as part of UBOS.

UBOS {{% gls App %}} are typically web {{% gls App %}}, i.e.
{{% gls App %}} whose primary user interface is presented using a web browser.
Some examples are:

* Wordpress (blogging and publishing)
* A house monitoring application, accessible over http or https.

On UBOS, generally many {{% gls App %}} may be {{% gl Deployment deployed %}}
on the same {{% gl Device %}}, distributed over several {{% gls Site %}} and
{{% gls AppConfiguration %}}.

Middleware components (e.g. databases) are not considered {{% gls App %}}
because the user generally does not experience direct value from them.

