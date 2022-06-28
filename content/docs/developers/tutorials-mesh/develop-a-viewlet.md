---
title: Creating a new Viewlet to render data the way you want
weight: 90
display: hide
---

## Introduction

In this tutorial:

* you will create your own {{% gl viewlet %}} to render Amazon Orders.
* add this {{% gl viewlet %}} to your instance of the {{% gl mesh %}}.

## Generate a project outline

```
cd gitlab.com/ubos/ubos-mesh-underbars-ui

ubos-scaffold list

ubos-scaffold generate --template mesh_underbars_viewlet --directory .
To parameterize things properly, we still need to know a few things.
Name of the Viewlet package (e.g. ubos-mesh-underbars-vl-northpole): ubos-mesh-underbars-vl-order
Name of the Viewlet (e.g. net.ubos.underbars.vl.northpole): net.ubos.underbars.vl.order
The Maven Group ID for the Viewlet (e.g. net.ubos.underbars): net.ubos.underbars
URL of the developer, such as your company URL: https://indiecomputing.com/
URL of the package, such as a product information page on your company website: https://ubos.net/
One-line description of your package, which will be shown to the user when
they ask pacman about your package (-i flag to pacman): UBOS Mesh Viewlet to render commerce Orders
License of your package, such as GPL, Apache, or Proprietary: AGPL3
Generating UBOS files for package ubos-mesh-underbars-vl-order using template mesh_underbars_viewlet into directory ..
Done.

```

This has created a directory hierarchy in `ubos-mesh-underbars-vl-order`. If
we look into this directory hierarchy, we find the following files:

`./PKGBUILD`

: Build file for the package. We may need to edit this later.

`./.gitignore`

: Ignore certain files when checking into Git. No need to change.

`./ubos-manifest.json`

: Metadata for UBOS administration. For {{% gls viewlet %}} like this one the needed content
  is minimal and always the same. No need to change.

`./appicons/72x72.png`

: Default icon for the Viewlet. Currently not used.

`./appicons/144x144.png`

: Default icon for the Viewlet. Currently not used.

`./assets/net.ubos.underbars.vl.order/net.ubos.underbars.vl.order.css`

: Default CSS file. Put the CSS you need for your {{% gl viewlet %}} here.

`./viewlets/net.ubos.underbars.vl.order/html_body_contained.hbs`

: {{% gl handlebars %}} template to emit compact HTML when the {{% gl viewlet %}} is contained
  inside another {{% gl viewlet %}}, such as in a search result. Edit this to change how the
  {{% gl viewlet %}} renders its {{% gl MeshObject %}} in compact form.

`./viewlets/net.ubos.underbars.vl.order/html_body_content.hbs`

: {{% gl handlebars %}} template to emit full HTML when the {{% gl viewlet %}} is used normally.
  Edit this to change how the {{% gl viewlet %}} renders its {{% gl MeshObject %}} normally.

`./viewlets/net.ubos.underbars.vl.order/html_head_title.hbs`

: {{% gl handlebars %}} template to emit the (hopefully short) HTML title for
  the {{% gl viewlet %}}.

`./net.ubos.underbars.vl.order/src/main/java/net/ubos/underbars/vl/order/ModuleInit.java`

: Module activation code. Most importantly contains the code that determines which
  {{% gls MeshObject %}} this {{% gl Viewlet %}} can render, and how well.

`./net.ubos.underbars.vl.order/src/main/resources/net/ubos/underbars/vl/order/VL.properties`

: Name of the {{% gl viewlet %}} in the user interface.

`./net.ubos.underbars.vl.order/build.gradle`

: {{% gl gradle %}} build file. Edit this for correct dependencies, such as dependencies on the code
  that defines the {{% gl model %}} that the {{% gl Viewlet %}} uses.

`./build.gradle`

: {{% gl gradle %}} build file. No need to edit.

## Include the project outline into the Gradle parent project

The `ubos-scaffold` does not attempt to edit the {{% gl gradle %}} parent project
(in parent directory `ubos-mesh-underbars-ui`). So you need to do this manually.

1. In `ubos-mesh-underbars-ui`, edit `build.gradle`.

   Look for a section that defines the `diet4jProperties` for a project, copy it
   and adjust the names, so that the following extra section is being added:

   ```
   project(':ubos-mesh-underbars-vl-purchase:net.ubos.underbars.vl.purchase') {
       ext {
           diet4jProperties = [ 'diet4j.activationclass' : 'net.ubos.underbars.vl.purchase.ModuleInit' ]
       }
   }
   ```

1. In `ubos-mesh-underbars-ui`, edit `settings.gradle`. You need to add two `include` and two
   `project` lines:

   ```
   include(':ubos-mesh-underbars-vl-purchase')
   include(':ubos-mesh-underbars-vl-purchase:net.ubos.underbars.vl.purchase')
   ```

   and

   ```
   project(':ubos-mesh-underbars-vl-purchase').projectDir = file('ubos-mesh-underbars-vl-purchase')
   project(':ubos-mesh-underbars-vl-purchase:net.ubos.underbars.vl.purchase').projectDir = file('ubos-mesh-underbars-vl-purchase/net.ubos.underbars.vl.purchase')
   ```

1. In `ubos-mesh-underbars-ui`, edit `devtools.json`, and add this line in the `vl` section, next to
   all the other listed {{% gls viewlet %}}:

   ```
   "ubos-mesh-underbarsl-vl-purchase",
   ```

## Build once

Some {{% gls Ide %}} don't like to parse projects that have never been built before.
So build this (so far uncustomized) project:

```
mesh-build
```

