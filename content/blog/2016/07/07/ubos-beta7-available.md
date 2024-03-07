---
title:  "UBOS Beta 7: more apps, Raspberry Pi 3, offsite backup, e-mail, AWS and more"
date:   2016-07-07 22:00:00
categories: [ front, release, beta ]
---

UBOS continues to make great steps forward. In the latest beta, we have added
support for more types of hardware to run UBOS on, more apps, important software
upgrades, and many small improvements that make your life as owner of a UBOS
device in production just so much easier.

{{% slide-in-img-right href="https://aws.amazon.com/" src="/images/2016-04-01/ec2.png" %}}
{{% slide-in-img-right href="http://raspberrypi.org/" src="/images/rpi-83x100.png" %}}

Where do we start?

* You can now run UBOS natively on Amazon Web Services' cloud computing platform,
  EC2. To to so, see {{% pageref "/docs/operation/installation/x86_ec2.md" "details here" %}}.

* The Raspberry Pi Foundation announced the much faster, quad-core Raspberry Pi 3.
  UBOS supports it, of course, just like on its older siblings Raspberry Pi Zero,
  One and Two.

* What do you do if your house burns down or somebody steals your UBOS device with
  all that valuable data on it? Backups stored outside of the house, that's what.
  But traditionally, that's complicated. With UBOS, it's not. Here's what you do:

  ```
  % sudo ubos-admin backup-to-amazon-s3
  ```

  This single command will cleanly back up all the apps on your device, straight to
  Amazon's S3 file storage platform. With one more argument, UBOS will first encrypt
  the backup so nobody can do anything with it unless they have your key.

* New applications Nextcloud and Mattermost make it even easier to use UBOS for
  file sharing and group collaboration.

* Like your website to be encrypted via HTTPS? Setting up such a site is now
  fully-automated due to an integration between UBOS and Letsencrypt. All you need
  to do is add ``--tls --letsencrypt`` to the ``ubos-admin createsite`` command,
  everything else is automated.

* Some web applications like to send e-mail. For example, for sign-ups, or password
  resets, or to notify of comments. Getting e-mail out reliably from behind
  the firewall, with possibly a hostile internet service provider has never
  been easy. Until now. With UBOS, you add the ``amazonses`` app to any site
  from which e-mail needs to be sent. UBOS will then automatically route
  email from that site via the highly reliable Amazon Simple Email Service.

These are just some of the highlights. The more detailed release notes are
~~here~~.

Note: some of these features require you to have an account with Amazon
Web Services (AWS), which Amazon might charge you for.

And as you probably know: to upgrade **everything** on your device, all you need to say is

```
% sudo ubos-admin update
```

We'd love your {{% pageref "/community.md" feedback %}}.
