---
title: Site JSON Template
plural: Site JSON Templates
summary: A JSON file that contains most meta-data about a Site, with blanks to be added at Deployment time
seealsoterm: [
    'Site',
    'Site_JSON'
]
---

A {{% gl Site_JSON %}} file that is missing certain information, such as:

* Parameters to be filled-in by the user at the time of running ``ubos-admin createsite``
  with this {{% gl Site_JSON_Template %}}.

* {{% gls SiteId %}} and/or {{% gls AppConfigId %}} so that at time of deployment
  with ``ubos-admin deploy`` or ``ubos-admin createsite``, new identifiers are
  being created.

