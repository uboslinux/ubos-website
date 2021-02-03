---
title: How to modify the configuration of your Site
---

Let's say you have a {{% gl Site %}} running on your {{% gl Device %}}, with an
{{% gl App %}} or several, and you'd like to make changes to your configuration,
such as adding or removing {{% gls App %}} or {{% gls Accessory %}}. Here are some
ideas how to go about it for common scenarios.

Common to all these scenarios that you need to obtain your {{% gl Site %}}'s
{{% gl Site_JSON %}} (a text file), make a modification to that {{% gl Site_JSON %}},
and then redeploy it. So let's first talk about this.

First, let's figure out what {{% gls Site %}} are currently running on your
{{% gl Device %}}:

```
% ubos-admin listsites
```

This lists the {{% gls Site %}} by their hostnames, and some information about which
{{% gls App %}} are deployed at which {{% gl Site %}}.

To obtain the full {{% gl Site_JSON %}} for a {{% gl Site %}} with hostname
``example.com``, including all secret credentials (which is needed if you want to redeploy):

```
% sudo ubos-admin showsite --host example.com --json
```

If your {{% gl Site %}} has hostname ``*`` -- the wildcard -- you need to put that star
into single quotes, otherwise your shell will get in your way:

```
% sudo ubos-admin showsite --host '*' --json
```

That will print the {{% gl Site_JSON %}} for that {{% gl Site %}} to the terminal. Because
that's a bit impractical given we want to make changes to it, we rather save that output to
a file. What you call that (temporary) file is immaterial; in our example we call it the same
as the hostname with the extension ``.json``, such as:

```
% sudo ubos-admin showsite --host example.com --json > example.com.json
```

Now you can edit that file -- here ``example.com.json`` -- with a text editor of your choice,
such as ``vim``. Which edits you want to make depend on what changes you want to make to
your {{% gl Site %}} -- see below.

But once you are done, you redeploy the {{% gl Site_JSON %}} like this:

```
% sudo ubos-admin deploy --file example.com.json
```

That's assuming your changed {{% gl Site_JSON %}} file is called ``example.com.json``.

UBOS will figure out what has changed between the current deployed configuration, and
the modified configuration, and make suitable changes to your {{% gl Device %}}.

{{% warning %}}
Always make a backup of your {{% gl Site %}} before you redeploy. UBOS deletes the
data of {{% gls App %}} and {{% gls Accessory %}} you deleted, or whose
{{% gl AppConfigId %}} you changed. As mistakes can happen, a backup before redeploy is
always a good idea.
{{% /warning %}}

## How to change the hostname of a Site

For example, you might have run your {{% gl Site %}} at ``example.com`` but you
let that domain expire and now you'd like to run it at ``example.net`` instead.
Or, you may have initially created your {{% gl Site %}} at the wildcard domain
``*`` and now you need to give it an official hostname so you can get a
SSL/TLS certificate for it.

To do this:

1. Save your {{% gl Site_JSON %}} to a file as described above.

1. Find the ``hostname`` element and change its value. For example, modify:

   ```
   "hostname" : "*",
   ```

   to:

   ```
   "hostame" : "example.pagekite.me",
   ```

1. Save the file.

1. Redeploy your modified {{% gl Site_JSON %}} file as described above.

## How to change the context path of an App

For example, you might run Wordpress at root of your {{% gl Site %}} ``example.com``,
but would like to move it to ``example.com/blog`` so you can run another {{% gl App %}}
at the same hostname.

1. Save your {{% gl Site_JSON %}} to a file as described above.

1. Find the ``context`` element and change its value. For example, modify:

   ```
   "context" : "",
   ```

   to:

   ```
   "context" : "/blog",
   ```

1. Save the file.

1. Redeploy your modified {{% gl Site_JSON %}} file as described above.

## How to add LetsEncrypt TLS to your non-TLS Site

{{% note %}}
This only works if your {{% gl Device %}} can be accessed from the public internet.
If you have your {{% gl Device %}} behind a firewall, you need to
{{% pageref howto-pagekite.md "run Pagekite" %}} or open up a port in your router.
{{% /note %}}

1. Save your {{% gl Site_JSON %}} to a file as described above.

1. Then add this into your {{% gl Site_JSON %}} file on the first level inside the
   outer curly braces:

   ```
   "tls" : {
       "letsencrypt" : true
   },
   ```

   Make sure there is a comma each between what you added and what comes before and after.

1. Save the file.

1. Redeploy your modified {{% gl Site_JSON %}} file as described above.

## How to add another App to an existing Site

1. Save your {{% gl Site_JSON %}} to a file as described above.

1. You can manually add an entire {{% gl AppConfiguration %}} section in the ``appconfigs``
   section in your {{% gl Site_JSON %}}. However, that tends to be a bit tedious and is
   easy to get wrong. So we suggest copy-paste instead:

1. Run ``ubos-admin createsite -n``. (The ``-n`` flag prevents UBOS from actually doing
   the ``createsite``; instead it will only emit {{% gl Site_JSON %}} for the
   {{% gl Site %}} it didn't actually create.). Make up some data for the hostname, admin
   accounts and the like; those values won't matter. But enter the {{% gl App %}}, and
   all information about it like {{% gl Context_Path %}} and {{% gls Accessory %}}, as
   you want it to be on your modified {{% gl Site %}}.

1. Once the command has completed, a {{% gl Site_JSON %}} file will be printed to the
   terminal. Copy the curly-braced section inside the ``appconfigs`` section. Then,
   insert that section into your existing {{% gl Site_JSON %}} file, as a sibling of
   the section (or sections) that are there already inside ``appconfigs``. Make sure
   there is a comma before and after what you added if there is a section before or
   after.

1. Save the file.

1. Redeploy your modified {{% gl Site_JSON %}} file as described above.

## How to remove an App from an existing Site

1. Save your {{% gl Site_JSON %}} to a file as described above.

1. Find the {{% gl AppConfiguration %}} in your {{% gl Site_JSON %}}. It would be an
   element in the ``appconfigs`` section, with potentially lots of lower-level entries.
   Remove all of it. (Of course if you have only one {{% gl AppConfiguration %}} at your
   {{% gl Site %}}, it may be easier to simply undeploy the entire {{% gl Site %}}.)

1. Save the file.

1. Redeploy your modified {{% gl Site_JSON %}} file as described above.

## How to add an Accessory to an AppConfiguration

1. Save your {{% gl Site_JSON %}} to a file as described above.

1. Find the list of already deployed {{% gls Accessory %}}. It looks like this:

   ```
   "accessoryids" : [
       "nextcloud-contacts",
       "nextcloud-calendar"
   ],
   ```

   and add the {{% gl Package %}} name of the {{% gl Accessory %}} into that array.
   For example, if you wanted to add the Nextcloud "Deck" to a Nextcloud deployment, you
   would modify this to read:

   ```
   "accessoryids" : [
       "nextcloud-contacts",
       "nextcloud-calendar",
       "nextcloud-deck"
   ],
   ```

1. If there aren't any {{% gls Accessory %}} yet at your {{% gl AppConfiguration %}},
   you will have to add this array, as a sibling of ``appid``.

1. Save the file.

1. Redeploy your modified {{% gl Site_JSON %}} file as described above.

## How to remove an Accessory from an AppConfiguration

1. Save your {{% gl Site_JSON %}} to a file as described above.

1. That's easy! Find the name of the {{% gl Accessory %}} in the ``accessoryids``
   section, and remove it. If that was the only {{% gl Accessory %}}, you can remove
   the entire `accessoryids`` section, but you don't need to.

1. Save the file.

1. Redeploy your modified {{% gl Site_JSON %}} file as described above.
