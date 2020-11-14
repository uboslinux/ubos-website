---
title: Role
plural: Roles
summary: Groups components of an App or Accessory into deployment tiers.
---

To successfully {{% gl Deployment deploy %}} a functioning {{% gl App %}},
all {{% gls AppConfigItem %}} in all {{% gls Role %}} specified in the
{{% gl App %}}'s {{% gl UBOS_Manifest %}} must be deployed. This also applies
for {{% gls Accessory %}}.

Each {{% gl Role %}} relates to a particular "tier" in a multi-tiered web
architecture implemented with a particular service, such as
``apache2`` or ``mysql``. Currently, UBOS only supports collocation of all
{{% gls Role %}} on the same {{% gl Device %}}.
