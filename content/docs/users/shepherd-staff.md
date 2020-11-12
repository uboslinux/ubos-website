---
title: The UBOS Staff
---

## Overview

The {{% gl UBOS_Staff %}} allows the secure installation and configuration of
{{% gls Device %}} without ever having to attach a keyboard or monitor to the
{{% gl Device %}}. This is particularly convenient for physical hardware that is
"hidden away" somewhere, and where attaching a monitor and keyboard would be
cumbersome, like inside an IoT device.

Among other things, the {{% gl UBOS_Staff %}} can be used:

* to provision an administrator account on the device called the {{% gl Shepherd %}}
  account, into which the user can ``ssh`` over the network. Either existing ``ssh``
  credentials provided by the user can be used, or UBOS can generate a new key pair
  automatically.

* to connect to a WiFi access point with credentials provided by the user and saved
  to the {{% gl UBOS_Staff %}};

* to automatically install and configure a {{% gl Site %}} upon boot;

The {{% gl UBOS_Staff %}} is simply a standard USB flash drive whose name and directory
layout follows certain conventions. A similar mechanism is available for virtualized
{{% gls Devices %}}.

See also this
[blog post](http://upon2020.com/blog/2015/03/ubos-shepherd-rules-their-iot-device-flock-with-a-staff/)
with a longer discussion.

## UBOS Staff device format and name

Any standard USB flash drive can be used as the {{% gl UBOS_Staff %}}. It is recommended
that such a USB flash drive only be used as {{% gl UBOS_Staff %}}, and not for other purposes
at the same time.

The drive must have a "VFAT" ("Windows") partition called ``UBOS-STAFF`` -- otherwise
UBOS will not recognize the device as a {{% gl UBOS_Staff %}}. This can often be accomplished
simply by inserting a new USB flash drive in a computer, and renaming the drive to
``UBOS-STAFF``.

The USB flash drive can have any size; the amount of storage required for use as
{{% gl UBOS_Staff %}} is minimal. Speed is also largely irrelevant.

The {{% gl UBOS_Staff %}}uses the following directory layout. For details, see below:

<table>
 <thead>
  <tr>
   <th>Directory</th>
   <th>File</th>
   <th>Description</th>
  </tr>
 </thead>
 <tbody>
  <tr>
   <td rowspan="2">
    <code>shepherd/ssh/</code>
   </td>
   <td>
    <code>id_rsa.pub</code>
   </td>
   <td>
    SSH public key for the <code>shepherd</code> account.
   </td>
  </tr>
  <tr>
   <td>
    <code>id_rsa</code>
   </td>
   <td>
    SSH private key for the <code>shepherd</code> account. You can delete it here once you have
    copied it to your workstation from where you will be logging into your {{% gl Device %}}.
   </td>
  </tr>
  <tr>
   <td>
    <code>wifi/</code>
   </td>
   <td>
    <code>&lt;ssid&gt;.conf</code>
   </td>
   <td>
    This directory may contain several files, one for each to-be-configured WiFi SSID.
    Each file must be named based on the SSID it configures, with extension <code>.conf</code>.
   </td>
  </tr>
  <tr>
   <td>
    <code>site-templates/</code>
   </td>
   <td>
    <code>&lt;name&gt;.json</code>
   </td>
   <td>
    This directory may contain several {{% gl Site_JSON_Template %}} files. Each of them will
    be instantiated and deployed to any {{% gl Device %}} that reads this {{% gl UBOS_Staff %}}
    unless a {{% gl Site %}} with the same hostname exists already on the {{% gl Device %}}, or
    reading {{% gl Site_JSON_Template %}} files has been disabled on the {{% gl Device %}}.
   </td>
  </tr>
  <tr>
   <td>
    <code>flock/&lt;HOSTID&gt;/bootlog/</code>
   <td>
    <code>%lt;timestamp%gt.txt</code>
   </td>
   <td>
    Text files containing the {{% gl Device %}}'s boot log from the systemd journal. This may help
    with troubleshooting issues on {{% gls Device %}} that don't have an attached monitor.
   </td>
  </tr>
  <tr>
   <td>
    <code>flock/&lt;HOSTID&gt;/device-info/</code>
   </td>
   <td>
    <code>device.json</code>
   </td>
   <td>
    A JSON file containing information about the {{% gl Device %}}.
   </td>
  </tr>
  <tr>
   <td>
    <code>flock/&lt;HOSTID&gt;/site-templates/</code>
   </td>
   <td>
    <code>&lt;name&gt;.json</code>
   </td>
   <td>
    This directory may contain one or more {{% gl Site_JSON %}} files or
    {{% gl Site_JSON_Template %}} files. Each of them will be instantiated (if a template)
    and deployed to the {{% gl Device %}} with {{% gl HostId %}} <code>&lt;HOSTID&gt;</code>,
    but ignored on other {{% gls Device %}}.
   </td>
  </tr>
  <tr>
   <td>
    <code>flock/&lt;HOSTID&gt;/sites/</code>
   </td>
   <td>
    <code>&lt;name&gt;.json</code>
   </td>
   <td>
    This directory may contain several {{% gl Site_JSON %}} files, which represent the
    {{% gl Site %}} or {{% gls Site %}} as they were deployed on the {{% gl Device %}} with
    {{% gl HostId %}} <code>&lt;HOSTID&gt;</code> at the time the {{% gl UBOS_Staff %}} was
    written last.
   </td>
  </tr>
  <tr>
   <td>
    <code>flock/&lt;HOSTID&gt;/ssh/</code>
   </td>
   <td>
    <code>ssh_host_&lt;type&gt;_key</code>
   </td>
   <td>
    This directory may contain one or more of the {{% gl Device %}}'s SSH host keys of different
    types, such as <code>rsa</code> or <code>ecdsa</code>. This can be used, in addition to the
    <code>shepherd</code> SSH key pair, to authenticate the host (not just the client) over
    the network.
   </td>
  </tr>
  <tr>
   <td>
    root of {{% gl UBOS_Staff %}}
   </td>
   <td>
    <code>I-ADMINISTER-MY-UBOSBOX-MYSELF.txt</code>
   </td>
   <td>
    If package <code>ubos-live</code> is installed, a {{% gl UBOS_Staff %}} is present at boot
    and a file with this name is NOT present, the {{% gl Device %}} will register itself with
    Indie Computing's [UBOS Live](https://indiecomputing.com/products/ubos-live/)
    management service. To prevent this, do not install package <code>ubos-live</code> or create
    a file (content is irrelevant) with this name on the {{% gl UBOS_Staff %}}.
   </td>
  </tr>
 </tbody>
</table>

``<HOSTID>`` refers to the device's unique {{% gl HostId %}}, which can be printed with ``ubos-admin hostid``.

Note: all files and directories are optional and may not be present on a given {{% gl UBOS Staff %}}:
an empty drive called ``UBOS-STAFF`` is entirely valid.

## Virtual UBOS Staff devices

### In the cloud

When booting an UBOS image on Amazon EC2, UBOS instead will take
the key pair specified by the user in the instance creation wizard on the
Amazon website, and configure the {{% gl Shepherd %}} account with it. No actual
Staff device is required.

None of the other {{% gl UBOS_Staff %}} functionality is available in the cloud.

### In a Linux container

When booting UBOS in a Linux container, UBOS will treat the directory
``/UBOS-STAFF`` as the {{% gl UBOS_Staff %}}, assuming it is present in the
container (not the host).

It may be advantageous to bind a suitable directory into the container with
the ``--bind`` flag to ``systemd-nspawn``.

UBOS will never auto-generate a new key pair when running UBOS in a container.

### Provisioning a Shepherd account

An automatically provisioned {{% gl Shepherd %}} account can be used as the primary
administration account on a UBOS device. By default, it has the rights to invoke
``sudo ubos-admin``, ``sudo systemctl`` and the like. It can also become ``root``
(see {{% pageref "/docs/users/faq-howto-troubleshooting/howto-root.md" %}}).

If a {{% gl Device %}} is booted a second time with the {{% gl UBOS_Staff %}}
present, the ssh key will be updated. (We work under the assumption that if an
attacker has the ability to physically insert a USB device into the USB port
and reboot the {{% gl Device %}}, the {{% gl Device %}} should be considered
compromised in any case.)

### Provision a Shepherd account with an existing ssh public key

If you would like to use an existing ssh public key to log into your {{% gl Device %}}
over the network as user ``shepherd``, create the following file system layout:

```
shepherd/
    ssh/
        id_rsa.pub
```

where the file ``id_rsa.pub`` contains a valid ``ssh`` public key. You can use any
existing ``ssh`` public key for which you have the corresponding private key.

I.e., the file called ``id_rsa.pub`` must be contained in a directory named ``ssh``,
which in turn must be contained in a directory called ``shepherd`` at the root level
of the directory hierarchy of the {{% gl UBOS_Staff %}}.

### Provision a Shepherd account with a newly generated ssh key pair

If you don't have an ssh key pair yet, and would like UBOS to generate one for you,
simply use a {{% gl UBOS_Staff %}} that is empty or at least does not have the
``shepherd`` directory yet at the root of the {{% gl UBOS_Staff %}}.

During boot, UBOS will automatically generate the key pair, save it to the
{{% gl UBOS_Staff %}}, and create the ``shepherd`` account on the {{% gl Device %}}.
(This behavior only occurs with a physical {{% gl UBOS_Staff %}}; not with a virtual
{{% gl UBOS_Staff %}} in case of running UBOS in the cloud or in a Linux container.)

Once UBOS has booted and generated the ``ssh`` keys, you can unplug the {{% gl UBOS_Staff %}}
and insert it into the computer from which you want to log into your {{% gl Device %}}.
Copy the file ``shepherd/ssh/id_rsa`` from the {{% gl UBOS_Staff %}} into a secure place
on your computer, as anybody who has access to this file can use it to log into your
{{% gl Device %}}. Also, delete the ``id_rsa`` file from the {{% gl UBOS_Staff %}} for
the same reason. (The file ``id_rsa.pub`` is the public key which can be shared without harm.)

### To log into a remote UBOS Device as the Shepherd

On the computer that has the private ``id_rsa`` file, execute the following command:

```
% ssh -i <id_rsa> shepherd@1.2.3.4
```

where ``<id_rsa>`` is the name of the file containing the private key from above,
and ``1.2.3.4`` is replaced with the IP address or hostname of your {{% gl Device %}},
such as ``ubos-pc.local`` (see {{% pageref networking.md %}}).

If you had UBOS generate the key pair, copy the private key file ``id_rsa`` to your
computer first: ssh will not let you use the ``id_rsa`` directly from the {{% gl UBOS_Staff %}}.

If you use a Windows workstation and PuTTY as your ssh client, you need to first convert
the ``id_rsa`` file into the "PuTTY Private Key Files (.ppk)" format by running ``puttygen.exe``.
Then, use the converted file as the authentication parameter with the PuTTY-Client.

## To setup WiFi

If you would like your {{% gl Device %}} to be able to connect to WiFi immediately after
it boots, you can save information about one or more WiFi networks to the {{% gl UBOS_Staff %}},
and UBOS will configure your {{% gl Device %}} as a WiFi client when it boots. Of course,
this assumes that your {{% gl Device %}} has WiFi support and all relevant drivers have been
installed (if not, this will do nothing).

To provide information on a WiFi network called ``ExampleWiFi``, create file
``wifi/ExampleWiFi.conf`` with the following content:

```
ssid="ExampleWiFi"
psk="MySecret"
```

``ssid`` must be the WiFi network's SSID (here: ``ExampleWiFi``) and ``psk`` must be the
corresponding WiFi passphrase.

You can specify more than one file in directory ``wifi/``, and your {{% gl Device %}} will be
able to connect to any of those networks. If your network needs more configuration, you can
add additional settings accepted by ``wpa_supplicant`` into these files: UBOS simply
inserts the content of those files into the ``network={ ... }`` section of a generated
``wpa_supplicant.conf`` file, and so you can add any settings there acceptable to
``wpa_supplicant``.

You should also create a file in directory ``wifi/`` called ``wireless-regdom``. Allowed
WiFi frequencies are different in different countries, and this allows you to conform
to radio emission regulations in your country. This file should contain a single line
that, if you are based in the United States, looks like this:

```
WIRELESS_REGDOM="US"
```

If you are based in another country, use your two-letter country code instead of ``US``.

## To auto-deploy Sites upon boot

If you place one or more {{% gl Site_JSON %}} files, or {{% gl Site_JSON_template %}}
files in the correct place on the {{% gl UBOS_Staff %}}, UBOS will automatically deploy
those {{% gls Site %}} during boot. There are two places where those files may be located:

* If placed in top-level directory ``site-templates/``, any {{% gl Device %}} booting with the
  {{% gl UBOS_Staff %}} will deploy the corresponding {{% gls Site %}}. This functionality
  is useful if you'd like to deploy the same kind of {{% gl Site %}} running the same
  {{% gls App %}} and {{% gls Accessory %}} to several {{% gls Devices %}}.

  It is highly recommended that the files be {{% gl Site_JSON_template %}} files (rather
  that {{% gl Site_JSON %}} files) that do not contain {{% gls SiteId %}} or
  {{% gls AppConfigId %}}, in order to generate unique identifiers for {{% gls Site %}} and
  {{% gls AppConfiguration %}} on different {{% gls Device %}}.

* If placed in directory ``flock/<HOSTID>/site-templates/``, where ``<HOSTID>`` is the
  host identifier of a particular {{% gl Device %}} as determined by ``ubos-admin hostid``,
  UBOS will only deploy the {{% gls Site %}} on that {{% gl Device %}}.

{{% note %}}

{{% gls Site %}} or {{% gls Site_Template %}} will not be deployed if the {{% gl Device %}}
already as a {{% gl Site %}} with either the same hostname or the same {{% gl SiteId %}} or
{{% gl AppConfigId %}}.

The {{% gl Site_JSON %}} files of the {{% gls Site %}} deployed through this mechanism will,
once the {{% gl Site %}} has been deployed, stored in ``flock/<HOSTID>/sites/<SITEID>.json``.
This gives the user a way of knowing automatically-generated credentials, for example.

## Disabling UBOS Staff functionality

To disable reading the {{% gl UBOS_Staff %}} on boot at all, change the setting ``host.readstaffonboot``
to ``false`` in ``/etc/ubos/config.json``.

To disable modifying the {{% gl UBOS_Staff %}} on boot, such as by generating a new SSH keypair,
change the setting ``host.initializestaffonboot`` to ``false`` in ``/etc/ubos/config.json``.
