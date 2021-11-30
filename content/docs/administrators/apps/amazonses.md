---
title: "Reliably send e-mail via Amazon Web Services' Simple E-mail Service: amazonses"
weight: 10
---

## Introduction

Reliably sending e-mail from a device or cloud server you control, unfortunately, is
not easy. Because historically, e-mail has had no concept of security, and spammers are
sending trillions of unwanted and malicious messages, most e-mail providers have
implemented strict, and always-changing heuristics that determine whether or not
an e-mail they received ever gets forwarded to the recipient's e-mail in-box. In our
experience, naively sending off e-mail via SMTP from a random cloud server results in
about 50% delivered messages, with the rest being discarded or lost on the way.

However, many {{% gls App %}} on UBOS need to reliably send e-mail, such as to confirm
account sign-ups.

Enter {{% gl App %}} ``amazonses``. If you use ``ubos-admin createsite`` to setup a
{{% gl Site %}} called ``example.com`` which will run, say, Mediawiki, enter ``mediawiki``
as the name of the {{% gl App %}} to run at this {{% gl Site %}}, but then continue and
specify ``amazonses`` as the second {{% gl App %}} running on the same {{% gl Site %}}.

``ubos-admin createsite`` will ask you for credentials (more about those below), but
once you have entered them, UBOS will send all outgoing e-mail originating from
``example.com`` via Amazon Web Services' Simple E-mail Service (SES). Amazon, not
surprisingly, works hard to be on the good side of e-mail providers world-wide, which
means that the e-mail you send via them has a high reputation, and will likely be
delivered (unless you send spam, of course).

If you run more than one {{% gl Site %}} on the same {{% gl Device %}}, outgoing e-mail
originating from a domain other that at the one to which you deployed ``amazonses`` will
not be affected and will continue to be sent directly, without going through Amazon SES.
If you would like that outgoing e-mail to go through SES as well, simply add
``amazonses`` as an additional {{% gl App %}} to that {{% gl Site %}} as well.

Note that you need to have a control of the DNS settings of the domain from which you
want to send your e-mails, otherwise Amazon will not permit you to do so.

## How to run ``amazonses`` as a second App if ``ubos-admin createsite`` does not ask

Some {{% gls App %}}, such as Mastodon, can only run at the root of a {{% gl Site %}}.
When you create a new {{% gl Site %}} with such an {{% gl App %}},
``ubos-admin createsite`` will not ask for a second {{% gl App %}}, because other web
{{% gls App %}} cannot run at the same {{% gl Site %}}. However, ``amazonses`` is not a
web {{% gl App %}} (it has no web interface), so it can run! So how can you enter it?

Simple: always specify ``amazonses`` as the first {{% gl App %}} when running
``ubos-admin createsite``. And then enter ``mastodon``, or whatever other {{% gl App %}}
you want to run at the root of the {{% gl Site %}} as the second {{% gl App %}}.

## How to sign up for Amazon Web Services' Simple E-mail Service and get credentials

Here are the steps:

1. Go to [console.aws.amazon.com/ses](https://console.aws.amazon.com/ses)
   and log into your Amazon Web Services account. If you do not have an Amazon Web
   Services account, create one.

1. In the left sidebar, select "Domains"

1. Click on "Verify a New Domain" and enter the name of your DNS domain from where your
   e-mail will originate, such as ``example.com``.

1. At your domain name registrar, or DNS provider, enter the additional domain name
   records that Amazon displays. You can ignore all aspects of "receiving e-mail" as
   UBOS currently is not set up to receive and/or dispatch incoming e-mails.

1. Wait until you have received e-mail confirmation that your domain has been verified, and
   the status of your domain in the SES console has turned "verified".

1. Select "SMTP settings" in the left sidebar in the SES console.

1. Click "Create my SMTP credentials".

1. Click through the wizard, and select "Show User SMTP Security Credentials". This shows
   two values. Enter those two values when ``ubos-admin createsite`` asks for those values
   (see discussion above). "SMTP Username" is the same thing as ``aws_access_key_id`` and
   "SMTP Password" is the same as ``aws_secret_key``.

{{% note %}}
It is possible that Amazon first places your account into a "sandbox", which
strongly limits which e-mail addresses you can send messages to. Usually, requesting to
be let out of the sandbox is a straightforward process. Check the SES control panel whether
you need to do that.
{{% /note %}}

