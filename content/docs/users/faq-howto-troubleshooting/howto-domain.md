---
title: I own a domain name, and I'd like to use it for my UBOS Device. How do I do that?
---

Generally, you do three things:

* When you set up your {{% gl Site %}} with ``ubos-admin createsite``, you specify that
  domain name.
  (You could also say ``*``, but if you specify the domain name you can later add another
  {{% gl Site %}} with a different domain name that runs on the same {{% gl Device %}}.)

* You make sure your {{% gl Device %}} can be reached from the public internet. This
  is trivial in some cases (like if your {{% gl Device %}} is a
  {{% pageref "/docs/users/installation-ec2.md" "cloud server" %}}) and a bit more
  tricky if it is {{% pageref howto-pagekite.md "behind a firewall" %}}.

* You instruct your domain name registrar or name server to resolve your domain to your
  {{% gl Device %}}. The exact details of this process depend on your registrar or name server,
  so we cannot describe this here. But in general, you set up an "A" record that points
  to the public IP address of your {{% gl Device %}}.
