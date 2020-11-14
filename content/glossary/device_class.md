---
title: Device Class
plural: Device Classes
summary: A class of Devices, such as Raspberry Pi 2
seealsoterm: [
    'Device'
]
---

A {{% gl Device_Class %}} is similar to an {{% gl Arch %}} but more specific:
beyond the processor architecture, it also categorizes peripherals and
other properties of the {{% gl Device %}}.

UBOS currently supports the {{% gls Device_Class %}}:

* ``pc``: A personal computer, or server
* ``vbox``: A virtual personal computer running on VirtualBox
* ``ec2``: A virtual personal computer running on Amazon EC2
* ``rpi``: A Raspberry Pi Zero or 1
* ``rpi2``: A Raspberry Pi 2 or 3
* ``rpi4``: A Raspberry Pi 4
* ``espressobin``: An ESPRESSObin
* ``odroid-xu3``: An ODROID-XU3, XU4, HC1 or UC2
* ``container``: A virtual machine running as Linux container
