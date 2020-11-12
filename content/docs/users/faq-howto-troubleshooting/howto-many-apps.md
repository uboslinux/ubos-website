---
title: How can I install more than one web App on the same Device?
---

You have two choices:

* You can invoke ``ubos-admin createsite`` as many times as you wish and create
  as many {{% gls Site %}} on your {{% gl Device %}} as you wish, each running
  one or more {{% gls App %}}.

  However, every time you invoke ``ubos-admin createsite`` again, you need
  to use a different hostname: ``createsite`` means that you are creating a separate
  {{% gl Site %}} every time; the command cannot modify an existing {{% gl Site %}}.

  This may be what you want -- for example, every family member might have their
  own {{% gl Site %}} on your {{% gl Site %}}. Or, it might not be worth the
  extra complexity setting up several DNS entries.

* You can augment an existing {{% gl Site %}} by adding another {{% gl App %}}
  to the same {{% gl Site %}}, accessible at the same hostname but at different
  {{% gls Context_Path %}} . To do that today, you need to obtain the existing
  {{% gl Site %}}'s {{% gl Site_JSON %}} file and add another entry to it.
  This is described in {{% pageref howto-modifysite.md %}}.

