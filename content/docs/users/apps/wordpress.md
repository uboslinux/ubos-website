---
title: Notes on Wordpress (App ``wordpress``)
---

## Note on terminology: plugins, themes and UBOS Accessories

In the UBOS world, we use the term {{% gl Accessory %}} for what Wordpress
calls "plugins" and "themes".

## How to install Wordpress "plugins" and "themes"

When you run Wordpress, you usually install Wordpress plugins and themes by
logging into your Wordpress installation as administrator, navigating to the plugins
and themes pages, and pick install new ones from there.

This is not how it works on UBOS.

When you run Wordpress on UBOS, you need to specify your {{% gls Accessory %}} at the
time you create your {{% gl Site %}}, or by redeploying the {{% gl Site %}}
later with an updated configuration.

Example: let's say you want to use the Wordpress "Pinboard" theme for your {{% gl Site %}}.
When you create the {{% gl Site %}} with ``ubos-admin createsite``, you specify
``wordpress`` as your {{% gl App %}}, and ``wordpress-theme-pinboard`` as an
{{% gl Accessory %}}. You can specify as many {{% gls Accessory %}} as you like.

Here's the reason why: UBOS cannot manage {{% gls App %}} that change their code
base without UBOS knowing, and that's what would be happening if Wordpress got to
add "themes" or "plugins" by itself.
