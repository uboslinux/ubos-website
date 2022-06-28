---
title: How to build UBOS Mesh itself
weight: 30
---

## Prerequisites

### UBOS developer setup

Make sure you set up with a configuration as described
at {{% pageref "/docs/developers/setup" %}}.

Update your virtual UBOS system to the latest and greatest, by executing in
the container:

```
% sudo ubos-admin update -v
```

### Get the UBOS Mesh code

Check out all {{% gl mesh %}} code into your project directory. In your
container:

```
% cd projects
% for p in \
      ubos-mesh \
      ubos-mesh-amazon \
      ubos-mesh-bot \
      ubos-mesh-facebook \
      ubos-mesh-google \
      ubos-mesh-underbars-ui \
  ; do \
      git clone https://gitlab.com/ubos/$p.git \
  ; done
```

### Install the UBOS Mesh development tools

In the container, execute:

```
% sudo pacman -S ubos-mesh-devtools
```

This gives you the tools `mesh-build`, `mesh-clean` and `mesh-test`,
which are wrappers around the package build tool `makepkg`, which in
turn invokes Java build tools like `gradle`.

## Building

### Note on library packages not yet in the repo

If you attempt to build and the build fails with a missing package, that
may be because the missing package is a library that is a newly required
dependency, and the UBOS package repos have not been updated yet to add this
package.

All such library packages are in Git repo
[https://gitlab.com/ubos/ubos-mesh-modules](https://gitlab.com/ubos/ubos-mesh-modules),
which you can check out. To build and install such a package, go into
the package directory, and run:

```
% makepkg -C -f -i
```

### Build sequence

You need to build each of the repos separately. There is no single
"build all" command. (There are pro's and con's, we know). You need
to build from the lower levels of the stack to the higher ones.

1. Build the Mesh itself:

   * repo `ubos-mesh`.

1. Build the importer repos:

   * `ubos-mesh-amazon`
   * `ubos-mesh-facebook`
   * `ubos-mesh-google`

1. Build the bot repo:

   * `ubos-mesh-bot`

1. Build the user interface:

   * `ubos-mesh-underbars-ui`

During development, you may appreciate the faster build speed by only
touching the part of the codebase you are actually working on.

### Actual build

To build repo `ubos-mesh`, for example:

```
% cd ubos-mesh
% mesh-build
```

### Cleaning up a build

To clean up the build (like `make clean`):

```
% cd ubos-mesh
% mesh-clean
```

### One-time setup for running unit tests that use mariadb

Some unit tests use mariadb (nee MySQL). The tests require a test database
to exist, and a database user with the right permissions. To set this up,
run once:

```
% sudo perl -MUBOS::Databases::MySqlDriver -e 'UBOS::Databases::MySqlDriver::ensureRunning();'
% sudo mysql --defaults-file=/etc/mysql/root-defaults-ubos.cnf
```

and then, in the open mysql shell:

```
create database test;
grant all privileges on test.* to 'test'@'localhost' identified by 'test';
flush privileges;
```

Quit the mysql shell.

### To run unit tests

```
% cd ubos-mesh
% mesh-test
```

## Note on building and updating a locally running UBOS Mesh App

`mesh-build` will compile code, create UBOS {{% gls package %}}, and install
the built {{% gls package %}} on the local system (so it's a bit like
``makepkg -i``, not just ``makepkg``).

To update a locally running {{% gl mesh %}} {{% gl app %}}, run
``ubos-admin update`` with a suitable list of {{% gls package %}}, such as:

```
% sudo ubos-admin update -v --pkg $(find . -name '*.pkg*')
```
