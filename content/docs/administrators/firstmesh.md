---
title: Setting up UBOS Mesh
weight: 25
---

For {{% gl linux %}}, {{% gl mesh %}} is just another {{% gl App %}} with
some {{% gls Accessory %}}, so the instructions in {{% pageref firstsite.md %}}
apply.

For the {{% gl app %}} name, use:

```
ubos-mesh-underbars-mysql
```

For {{% gls accessory %}}, you may want to use (all on one line, just printed differently here):

```
ubos-mesh-model-amazon ubos-mesh-model-facebook ubos-mesh-model-google
ubos-mesh-bot-advertisercategorizer ubos-mesh-bot-personaggregation ubos-mesh-bot-urlextractor
ubos-mesh-underbars-peertalk ubos-mesh-underbars-skin-world ubos-mesh-underbars-vl-addressbook
ubos-mesh-underbars-vl-advertisementinteraction ubos-mesh-underbars-vl-advertiser
ubos-mesh-underbars-vl-album ubos-mesh-underbars-vl-annotation ubos-mesh-underbars-vl-bookmark
ubos-mesh-underbars-vl-collection ubos-mesh-underbars-vl-comment
ubos-mesh-underbars-vl-facebookpartner ubos-mesh-underbars-vl-indexcloud
ubos-mesh-underbars-vl-industrycategory ubos-mesh-underbars-vl-industrycategorycollection
ubos-mesh-underbars-vl-interestcollection ubos-mesh-underbars-vl-mediaobject
ubos-mesh-underbars-vl-mediaproperty ubos-mesh-underbars-vl-meshbase
ubos-mesh-underbars-vl-message ubos-mesh-underbars-vl-messagethread ubos-mesh-underbars-vl-order
ubos-mesh-underbars-vl-person ubos-mesh-underbars-vl-portal ubos-mesh-underbars-vl-post
ubos-mesh-underbars-vl-productoffering ubos-mesh-underbars-vl-propertysheet
ubos-mesh-underbars-vl-searchquery ubos-mesh-underbars-vl-webresource
```

{{% note %}}
{{% gl mesh %}} currently is only available in the `yellow` {{% gl release_channel %}}
on the `x86_64` {{% gl arch %}}.
{{% /note %}}

If you want to run an {{% gl Importer %}} from the command-line, you need a few more packages:

```
% sudo pacman -S ubos-mesh-converter ubos-mesh-differencer
```

