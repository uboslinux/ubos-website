---
title:  "UBOS Beta 4: support for Mediagoblin, Webtrees and PostgreSQL"
date:   2015-04-13 18:00:00
categories: [ front, release, beta ]
---

We are proud that UBOS beta 4 has been released:

{{% slide-in-img-right src="/images/2015-04-13/postgresql-144x144.png" alt="[PostgreSQL]" %}}
{{% slide-in-img-right src="/images/webtrees-144x144.png"              alt="[Webtrees]" %}}
{{% slide-in-img-right src="/images/mediagoblin-144x144.png"           alt="[Mediagoblin]" %}}


There are three major new features:

1. [Mediagoblin](http://mediagoblin.org/), the GNU Project's photo and media
   sharing application, now installs, backs up, restores and upgrades with a single command,
   like all the other apps on UBOS.

2. [Webtrees](http://webtrees.net/), a full-featured web genealogy app, allows you
   to collaborate with your relatives on your ancestors over the internet, without spilling
   the family secrets to the general public because you keep them on your UBOS device.

3. As an alternative to MySQL/mariadb, UBOS apps can now use
   [PostgreSQL](http://postgresql.org/), and Mediagoblin
   makes use of that already. Of course, as a user, you don't have to worry about that because
   UBOS never makes you touch a database directly.

In addition, there have been application upgrades, a number of new packages, substantial
improvements to the UBOS Staff so you don't need generate SSH keys yourself, and a number
of bug fixes.

For more details, refer to the ~~release notes~~.

### How to upgrade

If you are an existing UBOS user and want to upgrade, log into your UBOS device.
First, you might want to make a backup of all your apps installed on your device:

```
% sudo ubos-admin backup --out ~/backup.ubos-backup
```

Then, to upgrade UBOS and all apps on your device, all you need to do is:

```
% sudo ubos-admin update
```

### For new users

{{% pageref "/quickstart.md" %}}
