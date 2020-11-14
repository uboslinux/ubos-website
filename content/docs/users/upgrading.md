---
title: Upgrading and keeping your Device current
weight: 80
---

UBOS makes this really simple:

```
% sudo ubos-admin update
```

This single command will perform all necessary steps. This includes:

1. Checking whether software upgrades are available.

1. Displaying an "upgrade in progress" message to users who attempt to access
   any of the {{% gls Site %}} on your {{% gl Device %}} over the web during the upgrade.

1. Creating a file system snapshot.

1. Temporarily backing up the data of all {{% gls Apps %}} current deployed on
   your {{% gl Device %}}.

1. Uninstalling all {{% gls App %}} currently deployed on your {{% gl Device %}}.

1. Downloading and installing upgraded {{% gls Package %}}.

1. If needed, rebooting the {{% gl Device %}} (e.g. for kernel upgrades).

1. Redeploying the same {{% gls App %}} as before in the same configuration, but
   in their new version(s).

1. Restoring all data to the redeployed {{% gls App %}}.

1. Performing whatever data migration is necessary to use the data with the new versions
   of the {{% gls App %}}.

1. Removing the "upgrade in progress" message.

How long an update takes depends on many factors, including the number and size of the
updated {{% gls Package %}}, the amount of data that needs to be backed up, restored, and
migrated, the number of installed {{% gls App %}}, as well as processor, disk and network
speed.

{{% warning %}}

Sometimes, upgrading may require additional steps. Please
review the {{% pageref "/docs/releases" %}} prior to upgrading.

{{% /warning %}}
