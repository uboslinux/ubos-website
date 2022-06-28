---
title: blessing
summary: The act of assigning an additional type to an object
seealso: [ unblessing ]
domain: UBOS Mesh
---

A {{% gl MeshObject %}} may be blessed with an {{% gl EntityType %}}.
The {{% gl Relationship %}} from one {{% gl MeshObject %}} to another
{{% gl MeshObject %}} may be blessed with a {{% gl RoleType %}}.

Blessing also adds all {{% gls Property %}} that correspond to the
{{% gls PropertyType %}} defined on the {{% gl EntityType %}} or
{{% gl RoleType %}}. The {{% gls Property %}} are
initialized to their default values.
