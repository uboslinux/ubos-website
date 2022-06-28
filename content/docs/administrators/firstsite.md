---
title: Setting up your first Site and App
weight: 20
---

Follow these steps:

1. Decide which web {{% gl App %}} to install. You can find the current set of available
   {{% gls App %}} {{% pageref "/apps.md" here %}}. In this example, we'll use Wordpress.

1. Decide at which hostname you'd like to run the {{% gl App %}}.  In this example, we'll
   use host ``*`` and run Wordpress at {{% gl Context_Path %}} ``/blog``. By specifying ``*``,
   meaning "any", you have the most choices for which URL will work in your browser
   to access your new Wordpress installation:

   * you can use the IP address of your {{% gl Device %}}. For example, if the IP address
     is ``192.168.1.10``, Wordpress will be reachable at ``http://192.168.1.10/blog/``

   * UBOS physical devices like PCs and Raspberry Pis (not containers or cloud) use mDNS
     to advertise themselves on the local network. The name depends on the type of device:

     * if installed on a PC, Wordpress will be reachable at ``http://ubos-pc.local/blog/``

     * if installed on a Raspberry Pi Zero or 1, Wordpress will be reachable at
       ``http://ubos-raspberry-pi.local/blog/``

     * if installed on a Raspberry Pi 2 or 3, Wordpress will be reachable at
       ``http://ubos-raspberry-pi2.local/blog/``

     Unfortunately that only works on older versions of Windows if you have iTunes installed.
     It should work on all other devices out of the box, including Macs, Linux PCs, iOS and
     Android devices, and PCs running more recent versions of Windows.

   * If your {{% gl Device %}} has an official DNS entry on its own, you should use this one,
     because it gives you the opportunity to run multiple {{% gls Site %}}, with their own
     distinct {{% gls App %}} on the same {{% gl Device %}}, just like web hosting companies
     do with virtual hosting. This is the recommended option for running UBOS in the cloud.

   * If you are just trying out UBOS, you can fake an official DNS entry by editing your
     ``/etc/hosts`` file on your workstation (not the {{% gl Device %}}).

   See also {{% pageref networking.md %}}.

1. Execute the following command:

   ```
   % sudo ubos-admin createsite
   ```

   This command will ask a number of questions. Once you have answered them, it will
   appear to think for a while and then set up your new {{% gl App %}}.

   For the name of the app, and names of accessories, use the package names
   shown {{% pageref "/apps" here %}}.

   Here is an example transcript:

   ```
   % sudo ubos-admin createsite
   ** First a few questions about the website that you are about to create:
   Hostname (or * for any): *
   Site admin user id (e.g. admin): admin
   Site admin user name (e.g. John Doe): admin
   Site admin user password (e.g. s3cr3t):
   Repeat site admin user password:
   Site admin user e-mail (e.g. foo@bar.com): root@localhost
   ** Now a few questions about the app(s) you are going to deploy to this site:
   First app to run (or leave empty when no more apps): wordpress
   Downloading packages...
   App wordpress suggests context path /blog
   Enter context path: /blog
   Any accessories for wordpress? Enter list:
   Next app to run (or leave empty when no more apps):
   Downloading packages...
   Deploying...
   Installed site sebbab46f26af24d677c955aabed8ae4e0186d4fc at http://*/
   ```

1. Access your new {{% gl App %}}. You can reach it directly by visiting the correct URL as
   described above. If you installed Wordpress as in the transcript above, and when accessing
   it with your web browser leave out the trailing ``/blog/``, you will see the list of
   {{% gls App %}} installed at this {{% gl Site %}}. Currently that is only Wordpress at path
   ``/blog/``. If you had continued entering additional {{% gls App %}} in response to the
   question "Next app to run", UBOS would have installed more {{% gls App %}} that would
   show up here.

If you are curious what UBOS just did under the hood, please refer to
{{% pageref "/docs/developers/reference-linux/understanding/createsite.md" %}}.

