---
title: RoleType
plural: RoleTypes
summary: Defines one end of a RelationshipType between two MeshObjects.
domain: UBOS Mesh
---

A {{% gl RelationshipType %}} defines the structure and semantics of
how two {{% gls MeshObject %}} can relate to each other. Most
{{% gls RelationshipType %}} are directed, meaning that
"Alice is mother of Bob" indicates a different situation than
"Bob is mother of Alice".

To distinguish these situations, a {{% gl RoleType %}} is one end of
a {{% gl RelationshipType %}}, and there are generally two
{{% gls RoleType %}} per {{% gl RelationshipType %}}.

