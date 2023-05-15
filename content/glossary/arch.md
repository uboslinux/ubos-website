---
title: Arch
summary: A processor architecture, like Intel 64bit
seealsoterm: [
    'Device_Class'
]
domain: UBOS Linux
---

The "Arch" of a {{% gl Device %}} is defined by its processor architecture.
Different "Arch"s generally require different binary code, and {{% gls Package %}}
need to be recompiled between them.

UBOS currently supports:

* ``x86_64``: Intel 64bit
* ``armv7h``: ARM v7 hard-float
* ``aarch64``: ARM 64 bit

Support for ARM v6 is discontinued.
