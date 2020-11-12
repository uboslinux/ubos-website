---
title: Shepherd
summary: The account on a UBOS Device from which users can perform system administration.
seealsoterm: [
    'UBOS_Staff'
]
---

The UBOS {{% gl Shepherd %}} is the person who administers one or more {{% gls Devices %}}
running UBOS. These {{% gls Devices %}} together are called the {{{% gl Shepherd %}}'s
{{% gl Flock %}}.

The {{% gl Shepherd %}} uses a USB stick, called the {{% gl UBOS Staff %}}, to
configure each {{% gl Device %}} in the {{% gl Flock %}} by booting it while the
{{% gl UBOS_Staff %}} is inserted into the {{% gl Device %}}'s USB port.

Configuration information picked up by the UBOS {{% gl Device %}} will remain valid
until the {{% gl Shepherd %}} reboots the {{% gl Device %}} with a different, or
differently configured {{% gl UBOS_Staff %}} inserted.

