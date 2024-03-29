---
title: How to create a website secured by SSL/TLS
weight: 40
---

Creating an https website secured by SSL or TLS has traditionally been
notoriously difficult. UBOS makes it easy. On UBOS, you now have three options:

1. Self-sign your keys. This is easiest, and costs no money, but you need to set a
   security exception in your browser. (That isn't hard either, but off-putting for
   any visitor to your {{% gl Site %}} who isn't you.)

1. Use an automatically generated {{% gl LetsEncrypt %}}
   certificate. This is free, and UBOS sets it up in a way that your {{% gl Device %}}
   will automatically renew your certificate before it expires.

   {{< note >}}
   This requires your {{% gl Site %}} to have an official domain
   name and to run on a {{% gl Device %}} that has a publicly available IP address.
   {{< /note >}}

1. Have an official certificate authority sign your keys. That usually takes some time
   and money, is more complicated, and requires that you own an official domain name
   for your {{% gl Site %}}.

All of these options are supported by UBOS. Whichever version you choose, visitors
to your {{% gl Site %}} will be automatically redirected from the insecure (HTTP)
version to the secure (HTTPS) one. UBOS will not serve your {{% gl Site %}} insecurely
if it has valid TLS keys for it.

## Self-signed certificate

For a self-signed {{% gl Site %}}, simply add the ``--tls`` and ``--selfsigned`` options
when you create your {{% gl Site %}}:

```
% sudo ubos-admin createsite --tls --selfsigned
```

Continue to answer the questions just as you did in {{% pageref "/docs/administrators/firstsite.md" %}}.
Done!

## LetsEncrypt certificate

For a {{% gl Site %}} whose certificate is generated by {{% gl LetsEncrypt %}}, simply add
the ``--tls`` and ``--letsencrypt`` options when you create your {{% gl Site %}}:

```
% sudo ubos-admin createsite --tls --letsencrypt
```

Continue to answer the questions just as you did in {{% pageref "/docs/administrators/firstsite.md" %}}.
Done!

{{% note %}}
If something goes wrong with the {{% gl LetsEncrypt %}} validation process, the {{% gl Site %}}
will still be set up, but without SSL/TLS.

The most common problem is that {{% gl LetsEncrypt %}} could not reach your {{% gl Site %}},
e.g. because public DNS is not set up correctly or your {{% gl Site %}} ran on a {{% gl Device %}}
not on the public internet or behind a firewall.
{{% /note %}}

## Official certificate

For a {{% gl Site %}} whose keys are signed by a traditional certificate authority, you need to
perform the following steps. Let's assume you want to run ``example.org`` with SSL/TLS; replace
this with your own domain name. First, generate SSL/TLS keys:

```
% openssl genrsa -out example.org.key 4096
```

Protect the generated file ``example.org.key``. Anybody who can get their hands on this
file can impersonate you.

Then, generate the certificate request:

```
% openssl req -new -key example.org.key -out example.org.csr
```

This will ask you a few questions, and generate file ``example.org.csr``. Send
``example.org.csr`` to your certificate authority.

Once your certificate authority has approved your request, they typically send you
two files:

* the actual certificate. This file typically ends with ``.crt``, such as
  ``example.org.crt``.

* a file containing their certificate chain. This is the same for all of their
  customers, and might be called ``gd_bundle.crt`` (for GoDaddy, for example).

Unfortunately, different certificate authorities tend to call their files by
different names, and many are not exactly very good at explaining which is which.

Keep all of those files in a safe place. When you are ready to set up your new
secured {{% gl Site %}} on your {{% gl Device %}}, execute:

```
% sudo ubos-admin createsite --tls
```

and enter the names of the above files when asked.

Continue to answer the questions just as you did in {{% pageref "/docs/administrators/firstsite.md" %}}.
Done!

