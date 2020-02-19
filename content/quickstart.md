---
layout: page
title: Quick Start
---

<style>
table#platforms {
  border-collapse: separate;
  border-spacing: 5px;
  margin-top: 10px;
}
table#platforms td {
  width: 25%;
  text-align: center;
  vertical-align: top;
  padding: 5px 10px;
  border: 1px solid #808080;
  border-radius: 10px;
}
table#platforms p,
table#platforms pre {
  text-align: left;
}
table#platforms span.middleimg {
  height: 150px;
  vertical-align: middle;
  display: inline-block;
}
table#platforms img {
  vertical-align: middle;
}
div#ubos-amazon-ec2-image-latest {
  margin: 0 auto;
}
div.buy {
   position: absolute;
   top: 5px;
   right: 5px;
   padding: 0 10px;
   width: 35%;
   border-radius: 10px;
   background: #fba923;
   background: linear-gradient(0, #fba923, #fba92360);
}
div.buy img {
    float: left;
    display: block;
    margin: 10px;
}
</style>

<div class="buy">
 <a href="https://indiecomputing.com/products/"><img src="/images/ubosbox-nextcloud-on-nuc-model-a-on-67x50.jpg"></a>
 <p>
  Or, buy a pre-configured <a href="https://indiecomputing.com/products/">UBOSbox</a><br>
  from <a href="https://indiecomputing.com/">indiecomputing.com</a>.
 </p>
</div>

## On a device or server

A more detailed step-by-step guide can be found in the [user documentation](/docs/users/).
The links on this page are for the [yellow release channel](/docs/developers/buildrelease.html).

<table id="platforms">
 <tr>
  <td>
   <span class="middleimg"></span>
   <img src="/images/rpi-83x100.png" alt="[Raspberry Pi]">
   <p><b>To run UBOS on the Raspberry Pi:</b></p>
   <p>Download <a href="http://depot.ubos.net/yellow/armv6h/images/ubos_yellow_armv6h-rpi_LATEST.img.xz">this
      image for Raspberry Pi&nbsp;Zero or the original Raspberry Pi 1</a> (approx. 540MB), or
      <a href="http://depot.ubos.net/yellow/armv7h/images/ubos_yellow_armv7h-rpi2_LATEST.img.xz">this
      image for Raspberry Pi&nbsp;2 or Raspberry Pi&nbsp;3</a> (approx. 540MB),
      uncompress, and write to a USB stick in "raw" format.</p>
  </td>
  <td>
   <span class="middleimg"></span>
   <img src="/images/espressobin-175x22.png" alt="[ESPRESSObin]">
   <p><b>To run UBOS on the Marvell ESPRESSObin:</b></p>
   <p>Download <a href="http://depot.ubos.net/yellow/aarch64/images/ubos_yellow_aarch64-espressobin_LATEST.img.xz">this
      image</a> (approx. 560MB), uncompress, and write to a USB stick in "raw" format.</p>
  </td>
  <td>
   <span class="middleimg"></span>
   <img src="/images/pc-79x100.png" alt="[PC]">
   <p><b>To run UBOS on an x86 PC:</b></p>
   <p>Download <a href="http://depot.ubos.net/yellow/x86_64/images/ubos_yellow_x86_64-pc_LATEST.img.xz">this
      image for a physical PC</a> (approx. 780MB), uncompress, and write to a USB stick in "raw" format. Or
      <a href="http://depot.ubos.net/yellow/x86_64/images/ubos_yellow_x86_64-vbox_LATEST.vmdk.xz">this
      image for VirtualBox or VMWare</a> (approx. 780MB), uncompress, and use as the main virtual hard drive.</p>
  </td>
 </tr>
</table>

Once booted, log in from the console as root, or via ssh using the
[UBOS staff](/docs/users/shepherd-staff.html).

<h2>In the Cloud</h2>
<table id="platforms">
 <tr>
  <td>
   <p><b>To run UBOS on Amazon EC2:</b></p>
   <script id="ubos-amazon-ec2-image-latest" src="/include/amazon-ec2-image-latest.js"></script>
   <p>Click on the logo and follow the Amazon wizard.</p>
  </td>
 </tr>
</table>

Once booted, log in via ssh using the private key you specified in the EC2 wizard, and
account name <tt>shepherd</tt>, such as (replace IP address and name of your private key
file):

    % ssh shepherd@1.1.1.1 -i id_rsa

<h2>Using Docker</h2>
<table id="platforms">
 <tr>
  <td>
   <p><b>To run UBOS on Docker:</b></p>
   <pre>% alias ubos-docker-yellow='docker run -i -t --cap-add NET_ADMIN --cap-add NET_BIND_SERVICE
  --cap-add NET_BROADCAST --cap-add NET_RAW --cap-add SYS_ADMIN -v /sys/fs/cgroup:/sys/fs/cgroup:ro
  -e container=docker ubos/ubos-yellow /bin/init'
% ubos-docker-yellow</pre>
  </td>
 </tr>
</table>

Once booted, log in as <code>root</code> from the console.

For more details and other installation options, refer to the
[Installation section](/docs/users/installation.html) in the
UBOS user documentation. It also describes how to run UBOS in a Linux container.

## Then: Create a website that runs one or more web apps

Once logged in, create a website that runs one or more apps:

    % sudo ubos-admin createsite

and answer the questions. To obtain the list of currently available web apps,
and the available accessories, execute:

    % pacman -Sl hl

To show installed apps and at which virtual hosts they run:

    % ubos-admin listsites

To upgrade operating system, middleware, all installed apps, and perform any
necessary data migrations and/or reboots:

    % sudo ubos-admin update

To remove all apps at a virtual host, and the site itself:

    % sudo ubos-admin undeploy --host hostname

To back up all data from your apps:

    % sudo ubos-admin backup --backuptofile all.ubos-backup

For details, refer to the [UBOS user documentation](/docs/users/).
