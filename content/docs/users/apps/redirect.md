---
title: Notes on Redirect
weight: 50
---

{{% gl App %}} Redirect sends the user's browser to some other URL that is
specified as a {{% gl Customization_Point %}} which ``ubos-admin createsite``
will prompt you for.

Two approaches to using Redirect can be taken. Assume that Redirect is deployed to
{{% gl Site %}} ``example.com``:

* If the ``target`` {{% gl Customization_Point %}} is set to ``http://example.net/path``,
  all URLs below ``example.com`` will be redirected to the same target
  ``http://example.net/path``.

  For example, ``http://example.com/`` and ``http://example.com/somewhere``
  will both be redirected to ``http://example.net/path``.

* If the ``target`` {{% gl Customization_Point %}} is set to ``http://example.net/path/$1``,
  all URLs below ``example.com`` will be redirected to the corresponding relative
  URL below the target ``http://example.net/path/``.

  For example, ``http://example.com/`` will be redirected to ``http://example.net/path/``, but
  ``http://example.com/somewhere`` will be redirected to ``http://example.net/path/somewhere``.

