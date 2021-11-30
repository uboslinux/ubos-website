---
title:  "WiFi on UBOS"
date:   2016-08-18 15:00:00
categories: [ front, howto ]
---

**Update:** UBOS now has built-in WiFi support via the
{{% pageref "/docs/administrators/shepherd-staff.md" "UBOS Staff" %}} and the manual
setup described in this post should not be necessary any more.

<hr/>

Unfortunately, the state of WiFi on Linux in general is a mess. We can't fix that general
mess single-handedly on UBOS I'm afraid. But when your WiFi dongle has the "right" chip set,
using WiFi on UBOS can be surprisingly easy. Such as
when using Element14's [Wi-Pi](http://www.newark.com/element14/wipi/frequency-rf-2-4ghz/dp/07W8938)
([datasheet](http://farnell.com/datasheets/1669935.pdf)) with the Raspberry Pi.

Here is how I just set up WiFi for a Raspberry Pi that is installed in my back yard,
where it controls the pumps of my pool, running UBOS of course
([more about that project](http://upon2020.com/blog/2012/12/my-raspberry-pi-pool-timer-why/)).
I needed to replace the SD Card of that Raspberry Pi, and decided to do a clean reinstall.

* Boot UBOS on your Raspberry Pi, and log in (either via console or via SSH over Ethernet)

* Insert the Wi-Pi dongle into the USB port

* Determine its interface name, by executing:

  ```
  % ip link
  ```

* In directory ``/etc/wpa_supplicant``, become ``root`` by executing:

  ```
  % sudo bash
  ```

  and create a file called ``wpa_supplicant-wlan0.conf``.

  This assumes that the name of the WiFi interface you found with `ip link` above was
  ``wlan0``. If it is something else, adjust the name of the file correspondingly.
  This file needs to have the following content:

  ```
  ctrl_interface=/run/wpa_supplicant
  eapol_version=1
  ap_scan=1
  fast_reauth=1

  network={
    ssid="XXXXXX"
    psk="YYYYYY"
  }
  ```

  Replace ``XXXXXX`` with the name of your WiFi network you want to connect to, and
  ``YYYYYY`` with your WiFi password.

* Set the correct regulatory domain. In directory ``/etc/conf.d``, edit file ``wireless-regdom``
  and remove the comment from the line that represents your country. For example, if you
  reside in the US, change line:

  ```
  #WIRELESS_REGDOM="US"
  ```

  to read as follows:

  ```
  WIRELESS_REGDOM="US"
  ```

* Start the Wifi daemon:

  ```
  % sudo systemctl start wpa_supplicant@wlan0
  % sudo systemctl enable wpa_supplicant@wlan0
  ```

  Again, use the correct interface name.

You are done! You can check that you have an IP address with:

```
% ip addr
```

and you should be able to access any website you like, such as:

```
% curl -v http://ubos.net/
```

If it doesn't work? Check that you got the right mix of underscores and hyphen in the
file you created. And, of course, `wpa_supplicant` is known to only work with some WiFi
adapters, not all. But IMHO spending a few dollars on an extra, supported WiFi adapter
beats spending hours attempting to debug WiFi drivers. At least that's what I did.

Updated 2016-11-14 with setting the correct regulatory domain.

