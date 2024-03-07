---
title: What is a good way to set up the NetBeans IDE for UBOS Mesh development?
weight: 1010
---

## Intro

We mostly use the [NetBeans](https://netbeans.org/) integrated development
environment to develop the {{% gl mesh %}}. This section describes our setup
and how to solve common issues.

## Have the same `~/.m2` on host and in your development container

If you:

* compile the {{% gl mesh %}} in a Docker or Linux container, as recommended in
  {{% pageref "../tutorials-mesh/build-mesh.md" %}}, and
* you run NetBeans on your host,

make sure that both use the same `~/.m2` directory. This is best accomplished:

* if you use Docker: making sure your `docker-compose.yml` file has the appropriate
  line in the right section:

  ```
      volumes:
        - ./projects:/home/ubosdev/projects
        - ~/.m2:/home/ubosdev/.m2
  ```

* if you use a ``systemd-nspawn`` container, by passing a ``--bind`` flag, such as:

  ```
  % sudo systemd-nspawn -b -n -D .... --bind ~/.m2:/home/ubosdev/.m2
  ```
  (other flags not shown)

## Building using NetBeans

In short: **don't**.

Use the `mesh-clean` and `mesh-build` commands as documented in {{% pageref "../tutorials-mesh/build-mesh.md" %}}.

(The {{% gl mesh %}} build runs the {{% gl codegen %}}, which in
turn uses the {{% gl diet4j %}} to find {{% gls model %}}. Running this on anything
else than {{% gl linux %}} itself is not currently supported.)

## Testing using NetBeans

In short: **don't**.

Use the `mesh-test` command as documented in {{% pageref "../tutorials-mesh/build-mesh.md" %}}.

(The tests find test modules using {{% gl diet4j %}}. Running this on anything
else than {{% gl linux %}} itself is not currently supported.)

## Debugging using NetBeans

This is described in {{% pageref "debug-ubos-mesh-webapp.md" %}}.

## The dreaded red exclamation marks and wiggly lines

Nobody has ever understood how exactly the NetBeans cache works, and that may
include the NetBeans cache developers. As a result, NetBeans frequently claims that
it cannot resolve some symbols in the UI, showing them with red annotations, without
any explanation -- or perhaps good reason -- why that might be. Our setup makes
things somewhat worse, because the build takes place outside of NetBeans.

If you have this problem, we suggest you do the following:

* Quit NetBeans.

* In your container, run a clean build (`mesh-clean` and `mesh-build`)

* On your host, delete the NetBeans cache. For example, on Linux:

  ``
  % rm -rf ~/.cache/netbeans
  ``

* Start NetBeans again on your host, and open up the {{% gl mesh %}}
  projects you are interested in. Give it a bit of time so NetBeans can
  attempt to parse them and get confused, as it usually does.

* In the NetBeans project outline, select the projects marked with the
  red exclamation mark. We select them, a few at a time, roughly in
  dependency order. Right-click and say "reload project". After a bit of
  thinking, that usually fixes things.

Until NetBeans corrupts its cache again. Rinse and repeat.

