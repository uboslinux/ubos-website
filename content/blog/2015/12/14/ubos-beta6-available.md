---
title:  "UBOS Beta 6: now supporting Raspberry Pi Zero, Docker and more"
date:   2015-12-13 15:00:00
categories: [ front, release, beta ]
---

<div style="float: right; margin: 0 0 10px 20px">
 <p><a href="https://www.raspberrypi.org/"><img src="/images/rpi-zero.jpg"></a></p>
 <p><a href="https://hub.docker.com/r/ubos/ubos-yellow/"><img src="/images/docker.png"></a></p>
</div>

Hot on the heels of beta 5, here is beta 6 already. It was intended only as a bug fix
release, but those bugs got squashed faster than expected, and so UBOS also got a few new
features while we were at it.

Here are the highlights:

* It's hard to believe, but $5 buys you a gigahertz processor, half a gig of RAM, HDMI video
  and lots of programmable I/O pins; in other words, a Raspberry Pi Zero. We are proud to
  announce that UBOS now runs on the Raspberry Pi Zero, in addition to the original one
  and version 2. (Go to
  {{% pageref "/docs/administrators/installation/raspberrypi.md" "installation instructions" %}}.)

* What else is hot in the computing universe? Docker, of course. And as of now, UBOS
  also runs on Docker. ({{% pageref "/docs/administrators/installation/x86_docker.md" "Here is how" %}}.)

* Want to run web applications at home, but also access them over the internet? The new
  UBOS network configuration ``public-gateway`` lets you set up your UBOS device as a router
  for your home network, and access your apps on your public IP address. Just say

  ```
  % sudo ubos-admin setnetconfig public-gateway
  ```

  ({{% pageref "/docs/administrators/networking.md" "More info" %}}.)

* And of course the usual: some packages have been upgraded, bugs have been fixed etc.

And as you probably know: to upgrade **everything** on your device, all you need to say is:

```
% sudo ubos-admin update
```

The more detailed release notes are ~~here~~.

We'd love your {{% pageref "/community.md" feedback %}}.
