---
title:  "UBOS Beta 10 released with automatic Tor hidden services setup"
date:   2017-02-12 16:00:00
categories: [ front, release, beta ]
---

{{% slide-in-img-right href="https://www.torproject.org/" src="/images/2017-02-12/onion.jpg" %}}

Beta 10 has arrived with new software packages, new features and the obligatory
bug fixes. The big news is this:

**You can now set up web applications, like Wordpress, as a Tor hidden service with
a single command**. This joins previously-available functionality to set up HTTPS
sites, including certificate provisioning, with a single command. Here are some
examples:

* ``sudo ubos-admin createsite`` creates a regular HTTP website with the apps you specify.

* ``sudo ubos-admin createsite --tls --self-signed`` creates the same website, but with a
  automatically generated and installed self-signed certificate.

* ``sudo ubos-admin createsite --tls --letsencrypt`` creates the same website, but with an
  official certificate from Letsencrypt that's recognized by all major browsers.

* ``sudo ubos-admin createsite --tor`` creates the same website, but as a Tor hidden service.
  In addition to the privacy and anonymity features Tor provides to site users and
  site publishers, this lets you easily run a website from behind your firewall, or
  pack up your server, plug it in somewhere else and you are back up and running.

{{% pageref "/docs/operation/create-tor-hidden-site.md" "More details" %}}.

Some other things that are new:

* Nextcloud 11 is now available.

* Various bug fixes and improvements.

* All images for all platforms has been updated.

These are just some of the highlights. The more detailed release notes are
~~here~~.

And as you probably know: to upgrade your device, all you need to say is
``sudo ubos-admin update``.

We'd love your {{% pageref "/community.md" feedback %}}.
