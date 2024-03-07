---
title: UBOS system architecture
breadcrumbtitle: architecture
weight: 5
---

The overall architecture of the UBOS project is shown in the following
overview diagram:

<p class="img"><img src="/images/architecture.png"></p>

Let's discuss this architecture from the bottom layers towards the top:

* **Hosting**: all software must run somewhere. The UBOS project supports
  a variety of hardware platforms, and virtualization platforms. Shown in
  the diagram are traditional PCs, various forms of virtualization, ARM
  devices, and in the cloud.

* **Operating system**: {{% gl linux %}} is the Linux variant developed
  for the UBOS project. It is based on {{% gl arch_linux %}} and takes
  most of its packages from there. {{% gl linux %}} augments this with
  functionality that makes server-side applications much simpler to
  install and maintain than on typical other Linux distros.

Above the operating system layer, the stack splits into two:

* On the left, we have **traditional web apps** like Wordpress, or Nextcloud.
  They are {{% gl package packaged %}} specific for {{% gl linux %}} and
  because of that, can be installed and administered through `ubos-admin`,
  the central {{% gl linux %}} administration command.

* On the right, we have **{{% gl mesh %}}** and various software components
  that plug into it. {{% gl mesh %}} is a novel kind of {{% gl middleware %}}
  that enables {{% gl l_app %}} developers to all work on the same data,
  which is represented as a graph in a {{% gl MeshBase %}}.

* On top of {{% gl mesh %}}, because of the shared data infrastructure it
  provides, run {{% gls L_App %}}, which can contain user interface components,
  {{% gls bot %}}, {{% gls importer %}} and more. In {{% gl linux %}}
  terms, most of these {{% gls L_App %}} are {{% gls accessory %}}.

{{% note %}}
As a developer on UBOS, one of the fundamental decisions you need to make
is whether your software is going to be a standalone, traditional
{{% gl app %}} with its own data storage (and consequent difficulties
exchanging data with other {{% gls app %}}, or providing a consistent
user experience across the boundaries of your {{% gl app %}}) or whether
you want to make use of the {{% gl mesh %}} high-level data management
infrastructure.
{{% /note %}}
