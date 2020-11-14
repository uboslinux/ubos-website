---
title: AppConfigId
plural: AppConfigIds
summary: Uniquely identifies a particular deployment of an App.
seealsoterm: [
    'AppConfig',
    'App',
    'Accessory'
]
---

UBOS identifies each {{% gl Deployment %}} of any {{% gl App %}} at any {{% gl Site %}}
(called an {{% gl AppConfiguration %}}) with a unique identifier, called the
{{% gl AppConfigId %}}, which consists of an ``a`` and a long hexadecimal number.

For example, ``aa6b76deec72fc2e86c812372e5922b9533ca2d58`` is a valid
{{% gl AppConfigId %}}.

An  {{% gl AppConfigId %}} establishes the identity of the {{% gl AppConfiguration %}}
and remains persistent even if the {{% gl AppConfiguration %}}'s
{{% gl Context_Path %}} is changed, or the {{% gl AppConfiguration %}} is moved
to an entirely different {{% gl Site %}}.

{{% gls AppConfigId %}} are used with UBOS commands that refer to a
particular {{% gl AppConfiguration %}}.

To determine an {{% gl AppConfiguration %}}'s {{% gl AppConfigId %}}, execute:

```
% sudo ubos-admin listsites --detail
```

Because {{% gls AppConfigId %}} are long and unwieldy, many UBOS commands allow
the use of only the first few characters, as long as they are unique on the
{{% gl Device %}}, and you append three periods at the end in lieu of the
remainder.

For example, if there is no other {{% gl AppConfiguration %}} installed on your
{{% gl Device %}} and the {{% gl AppConfigId %}} you wish to specify is the one
shown above, you can use ``aaa...``, ``aa6b76dee...`` or even ``a...`` as
a shorthand.

Many commands also accept the {{% gl Hostname %}} of the {{% gl Site %}} at which
the {{% gl AppConfiguration %}} is deployed, plus the {{% gl AppConfiguration %}}'s
{{% gl Context_Path %}} instead of the {{% gl AppConfigId %}}.
