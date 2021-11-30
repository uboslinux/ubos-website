---
title: Can I use UBOS without purchasing a domain name?
---

Yes:

* You can use the IP address of your {{% gl Device %}} instead of a domain name, if you
  have specified ``*``, or the IP address directly as the domain name when executing
  ``ubos-admin createsite``.

* If you are satisfied with accessing your {{% gl Device %}} only on your local network,
  the UBOS device advertises itself via {{% gl mDNS %}} and you can use that name. See
  {{ % pageref networking.md %}}

* You can enter a domain name for your {{% gl Site %}} name in your ``/etc/host``
  file(s) or in the local DNS server of your home router. This makes most sense if your
  {{% gl Site %}} is only on your local network anyway.

* You can use a free dynamic DNS service.
