---
title: Structure of the UBOS Manifest
---

A Manifest JSON file has a type declaration, three required components, and
three optional components:


```
{
  "type" : "<<type>>",
  "info" : {
     ... info section (not required but recommended)
  },
  "requirestls" :
     ... (optional)
  "roles" : {
     ... roles section
  },
  "customizationpoints" : {
     ... customizationpoints section (optional)
  },
  "appinfo" : {
     ... appinfo section (for Apps only)
  },
  "accessoryinfo" : {
     ... accessoryinfo section (for Accessories only; required for Accessories)
  }
}
```

The ``type`` declaration states whether the manifest is for an
{{% gl App %}} or an {{% gl Accessory %}}. An {{% gl App %}} uses:

```
"type" : "app"
```

while an {{% gl Accessory %}} uses:

```
"type" : "accessory"
```

The optional ``info`` section contains user-friendly, localized information about
the {{% gl App %}} or {{% gl Accessory %}}. This is described in {{% pageref info.md %}}.

If ``"requirestls" : true``, this {{% gl App %}} must only be deployed to
{{% gls Site %}} that are protected by TLS.

The required ``roles`` section declares how the {{% gl App %}} wishes to be installed and
configured with respect to Apache, MySQL, and other roles. This is described in
{{% pageref roles.md %}}.

{{% gls App %}} or {{% gls Accessory %}} that support customization declare
their parameters in an optional ``customizationpoints`` section. This is described in
{{% pageref customizationpoints.md %}}.

In addition, {{% gls Accessory %}} need to provide a ``accessoryinfo`` section to identify
the {{% gl App %}} that they belong to. This is described in {{% pageref accessoryinfo.md %}}.
