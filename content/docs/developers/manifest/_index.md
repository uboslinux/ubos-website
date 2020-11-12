---
title: UBOS Manifest
---

See also glossary entry {{% gl UBOS_Manifest %}}

Each {{% gl App %}} or {{% gl Accessory %}} on UBOS has a ``ubos-manifest.json`` file, which
contains the meta-data that allows UBOS to correctly deploy, undeploy, backup, restore, upgrade
etc. the {{% gl App %}} or {{% gl Accessory %}}.

This manifest optionally also contains human-readable information about the
{{% gl Package %}} that contains the {{% gl App %}} or {{% gl Accessory %}} and hence
the UBOS Manifest file. The UBOS Manifest file augments the information in the ``PKGBUILD``
file used by the ``pacman`` package manager that UBOS invokes.

This section describes the UBOS manifest and how to use it.
