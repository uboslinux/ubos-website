---
title: How do I use the current assets during development with UBOS Mesh?
weight: 1040
---

## The problem

The current build process packages all resources -- like HTML and CSS files,
Handlebars templates etc -- into {{% gl linux %}} packages, from where they
are served when the {{% gl mesh %}} is run. Even during development.

That makes the edit cycle lengthier than we'd like: it should be possible to
immediately see the change in a CSS file, for example.

## The solution

Run the {{% gl mesh %}} with environment variable ``PACKAGE_RESOURCES_PARENT_DIR``.
The value of this variable is interpreted as a directory (or several, separated
by colon or comma) that are prepended to the default search path for assets.
This allows specifying a path that "overrides" the default search path for assets,
and you can point it to the directory hierarchy where you make your edits.

You need to specify this environment variable in a place where it can be effective
when you run the {{% gl mesh %}} as a systemd service. One way this can be accomplished
is by adding a line to `/etc/diet4j/diet4j-jsvc-<<APPCONFIGID>>.env`, where
`<<APPCONFIGID>>` is the applicable App Configuration Id from the Site JSON file
(`sudo ubos-admin showsite --detail`).

Example added line:

```
PACKAGE_RESOURCES_PARENT_DIR=/home/ubosdev/projects/ubos-mesh-underbars-ui:/home/ubosdev/projects/ubos-mesh-underbars-ui-experimental
```

## How it works

The default for this path is `/ubos/share`, because that's where {{% gls package %}}
store their files. For example, {{% gl package %}} `ubos-mesh-underbars-vl-album` stores
the following files there:

* `/ubos/share/ubos-mesh-underbars-vl-album/assets/net.ubos.underbars.vl.album/default.css`
* `/ubos/share/ubos-mesh-underbars-vl-album/viewlets/net.ubos.underbars.vl.album/html_body_content.hbs`
* `/ubos/share/ubos-mesh-underbars-vl-album/viewlets/net.ubos.underbars.vl.album/html_body_inlined.hbs`
* `/ubos/share/ubos-mesh-underbars-vl-album/viewlets/net.ubos.underbars.vl.album/html_head_title.hbs`

If you mounted your git source code directory into your build/test container,
such as by specifying `./projects:/home/ubosdev/projects` in your Docker setup
as recommended in {{% pageref "../tutorials-mesh/build-mesh.md" %}}, and you set

```
PACKAGE_RESOURCES_PARENT_DIR=/home/ubosdev/projects/ubos-mesh-underbars-ui
```

then the {{% gl mesh %}} UI framework will, for example, look for the above CSS
file in the following locations, in sequence:

1. `/home/ubosdev/projects/ubos-mesh-underbars-ui/ubos-mesh-underbars-vl-album/assets/net.ubos.underbars.vl.album/default.css`
1. `/ubos/share/ubos-mesh-underbars-vl-album/assets/net.ubos.underbars.vl.album/default.css`
