---
title: Migrating from one App to another
---

## Motivation

Sometimes, an {{% gl App %}} gets forked, as it happened recently with ownCloud and its
new fork Nextcloud. Sometimes, a developer would make it particularly easy to let users
take their data from an old {{% gl App %}} and use it in their new {{% gl App %}}. Sometimes,
major versions of {{% gls App %}} are sufficiently different from each other that in UBOS,
we effectively treat them as different {{% gls App %}}.

Under any of these circumstances, the user needs to be able to tell UBOS to migrate
their data and configuration to a new {{% gl App %}}.

## How to migrate from one App to another

For simplicity, let's assume that a {{% gl Device %}} only runs a single {{% gl Site %}}, and
that at that {{% gl Site %}},a single {{% gl App %}} is installed whose data and configuration
needs to be migrated to another {{% gl App %}}. Let's assume that the {{% gl Site %}} has
hostname ``example.com``.

In case of more complex setups, different options to the backup and restore commands need to
be used (e.g. only some {{% gls Site %}} instead of all), otherwise everything is the same.

Let's take a real-world example, and assume you want to upgrade from ``nextcloud18`` to
``nextcloud19`` (Note: this is a historical example.)

1. Create a backup of the existing {{% gl Site %}}, such as:

   ```
   % sudo ubos-admin backup --host example.com --backuptofile before-migration.ubos-backup
   ```

1. Undeploy the {{% gl Site %}}, such as:

   ```
   % sudo ubos-admin undeploy --host example.com
   ```

1. Restore the backup, instructing UBOS to swap out ``nextcloud18`` and replace it with
   ``nextcloud19``:

   ```
   % ubos-admin restore --in before-migration.ubos-backup --migratefrom nextcloud18 --migrateto nextcloud19
   ```

This will restore your {{% gl Site %}} into the same location (hostname, context path),
restore and migrate all your data, but run ``nextcloud19`` going forward instead of
``nextcloud18``.
