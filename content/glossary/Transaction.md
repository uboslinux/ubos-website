---
title: Transaction
plural: Transactions
summary: A set of changes to MeshObjects in a MeshBase that are being performed as a unit
seealsoterm: [
    MeshBase,
    TransactionLog
]
domain: UBOS Mesh
---

A set of changes to MeshObjects in a MeshBase that are being performed as a unit.
Any Transaction either succeeds in its entirety -- all changes within the Transaction are applied
to the {{% gls MeshObject %}} in the {{% gl MeshBase %}} -- or fails
-- all of the changes within the Transaction are undone, and the {{% gl MeshBase %}}
is left as if no change had ever been attempted.
