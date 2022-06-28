---
title: EntityType
plural: EntityTypes
summary: The type of a MeshObject
domain: UBOS Mesh
---

The type of a MeshObject, similarly to how in programming, there are
data types for variables, or classes for objects.

Unlike in programming a {{% gl MeshObject %}} can be {{% gl blessing blessed %}}
with more than one EntityType, and it can change its type(s) over its lifetime,
by repeatedly {{% gl blessing %}} and {{% gl unblessing %}}.

This is similarly to how a URL on the web might refer to a HTML page one day,
and a PDF document the next.
