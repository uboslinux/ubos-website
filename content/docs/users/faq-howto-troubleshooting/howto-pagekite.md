---
title: How to use Pagekite to reach your UBOS Device behind a firewall
---

If your {{% gl Device %}} is behind a firewall -- such as behind a home broadband
router or a company firewall -- your firewall will block all incoming traffic
and none of the site(s) on your {{% gl Device %}} are reachable from the public
internet. That's the whole point of a firewall, of course, and a good idea for
security reasons.

But what if you do want to make your {{% gl Site %}} accessible over the internet,
either for the general public, or for your friends, or even just for yourself for
when you are on the road?

One approach is to register with a dynamic DNS provider, to open a special
port in your firewall and forward that special port to the IP address of your
{{% gl Device %}}. This certainly can work, but it tends to be difficult, clumsy
(now you need to remember a funny port number!) and is often unreliable;
some internet providers block such traffic, others prohibit it in their
terms of service, and sometimes the firewalls themselves aren't cooperating.

## About Pagekite

[Pagekite.net](https://pagekite.net/) is open-source software combined with a
paid service that has been developed by The Beanstalks Project ehf in Iceland.
It provides a much simpler alternative: through some ingenious proxying,
Pagekite accepts traffic destined for your device at public servers they run,
and then securely routes that traffic to your device by tunneling through
your firewall. All without compromising your privacy.

To set it up on UBOS, read on. UBOS bundles all necessary software, and
integrates Pagekite a bit more tightly than other Linux distributions,
making your life easier. Please ignore the installation instructions on
pagekite.net and follow the ones here if you are running Pagekite on UBOS.

## Step 1: Sign up for pagekite.net

Go to [Pagekite.net](https://pagekite.net/) and sign up for an account.
They have free trials, so you can sign up without cost and see how you like it.

Let's say you signed as user ``johndoe`` and you picked ``johndoe`` as your
"kite" name, to use their terminology. When you are done with the following
setup, you will be able to reach your {{% gl Device %}} at
``http://johndoe.pagekite.me/``.

## Step 2: Make sure you have a Site on your Device that corresponds to your kite name

This only works if you have a {{% gl Site %}} on your {{% gl Device %}} that
actually corresponds to your kite name, otherwise UBOS will not forward any traffic.
So if your Pagekite kite name is ``johndoe.pagekite.me``, make you sure
that your {{% gl Site %}} either has hostname ``johndoe.pagekite.me`` or
the {{% gl wildcard_hostname %}} ``*``.

You can determine the hostname of your {{% gl Site %}} with ``ubos-admin listsites``.

Also note the section on SSL/TLS/HTTPS certificates below.

## Step 3: Configure Pagekite on your UBOS Device

Log into your {{% gl Device %}}. Then, execute the following commands:

```
% sudo pacman -S --noconfirm pagekite
% sudo ubos-admin start-pagekite <NNN>
```

where ``<NNN>`` is the name of your primary kite (``johndoe.pagekite.me``
in our example). UBOS will then ask you for the secret that goes with this kite.
You can find both the kite name and the secret on the pagekite.net website after you
have logged into your account there (open section "Your details"). You need to
provide this information to UBOS so your {{% gl Device %}} can be securely paired with
your pagekite.net account.

You only need to do this once, for sign-up.

{{% note %}}
After you initially setup Pagekite, it may take a few minutes until your
kitename correctly resolves to your {{% gl Device %}}. This has to do with
DNS propagation. In the meantime, you will get a "Temporarily Unavailable"
message when attempting to access your kite.
{{% /note %}}

## Pagekite status

To determine the status of Pagekite on your {{% gl Device %}}, execute:

```
% ubos-admin status-pagekite
```

## Stop using Pagekite on your UBOS device

If you ever wanted to stop using Pagekite, simply execute:

```
% sudo ubos-admin stop-pagekite
```

## UBOS Site names and Pagekite domain names

If you tell Pagekite.net that your Kite name is ``johndoe.pagekite.me``,
all public web traffic to that domain name will be routed to the website
``johndoe.pagekite.me`` on your {{% gl Device %}}, or, if a {{% gl Site %}}
is deployed on your {{% gl Device %}} with hostname ``*``, to that
{{% gl Site %}}.

If you do not have a {{% gl Site %}} with hostname ``johndoe.pagekite.me`` or ``*``
on your {{% gl Device %}}, you will either be seeing the UBOS "Site not found" error
page or a Pagekite error message.

Just like if you access your {{% gl Device %}} directly, the hostname you type
into your browser must match the hostname of the {{% gl Site %}} you created on
your {{% gl Device %}}. If you use Pagekite, it might be easiest to give the
"kite" name to your {{% gl Site %}} when you create it on UBOS.

Note that Pagekite allows you to use sub-domains at no extra cost, so you
could run sites ``private.johndoe.pagekite.me`` and
``business.johndoe.pagekite.me`` on the same {{% gl Device %}}, and Pagekite will
forward traffic accordingly. To make this easier, you can start Pagekite
with:

```
% sudo ubos-admin start-pagekite --all --kitesecret <SSS> <NNN>
```

and UBOS will attempt to set up a kite for all {{% gls Site %}} you currently
have on your {{% gl Device %}}, and all future {{% gls Site %}} you will deploy to
your {{% gl Device %}} in the future. Of course, this only works
if you have configured the right "kites" on the pagekite.net site.

## Pagekite and SSL/TLS/HTTPS certificates

Encrypting your web traffic, particularly over the open internet, is of
course a good idea. The UBOS/Pagekite integration will automatically take
care of it if your {{% gl Site %}} has been set up with a certificate,
such as one from Letsencrypt.

If your {{% gl Site %}} exists already but does not have a certificate yet,
we recommend:

1. Get Pagekite working without SSL/TLS/HTTPS first. That makes it easier to
   troubleshoot if anything should go wrong.

   Make sure you can access your {{% gl Site %}} without SSL/TLS/HTTPS over
   the public internet before going to the next step.

2. Then, redeploy your {{% gl Site %}} after adding the SSL/TLS certificate
   information. This is described {{% pageref "/docs/users/faq-howto-troubleshooting/howto-modifysite.md" here %}}.
