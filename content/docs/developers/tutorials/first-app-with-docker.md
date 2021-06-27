---
title: Build and run your first UBOS Standalone App using Docker containers for development
weight: 10
---

In this tutorial, you will be building, deploying and running a simple
PHP web application as a standalone {{% gl app %}} on UBOS Linux. You don't need to install
any development tools, because you will be using Docker containers running UBOS Linux
to build and run the {{% gl app %}}.

This tutorial should take about 20-30 minutes.

## Introduction

Just like you need a PC running Windows to develop for Windows, or an
iPhone to develop for iOS, you need a computer running UBOS Linux to develop
for UBOS and test your code.

But fear not: a virtualized computer, like a Docker container running
UBOS Linux, works just fine. No new hardware purchases are required! We have
tested this setup on macOS and on Arch Linux; it should work the same on
other operating systems running Docker.

We will be using a two-container development environment:

* Container ``ubos-develop`` runs UBOS Linux, with common UBOS build tools
  pre-installed. You use this build UBOS {{% gls package %}}, such as for
  {{% gls app %}} and {{% gls accessory %}}.

* Container ``ubos-target`` runs a UBOS production environment with only
  {{% pageref "/docs/developers/details/container-differences.md" "minor differences" %}}
  to what users run in production. You deploy your UBOS {{% gls package %}} there to
  run and test them.

Here are the steps:

## Install Docker and Docker Composer

If you don't have Docker installed yet, please refer to the
[Docker documentation](https://www.docker.com/get-started). It may be
as easy as downloading Docker Desktop for your operating system and running
the app.

## Pick a project directory and download the recommended configuration files

We recommend you do all your UBOS-related development below a certain directory.
Let's say that directory is ``~/ubosdev``. Create that directory and enter
it:

```
% mkdir ~/ubosdev
% cd ~/ubosdev
```

Download the Docker Compose file and save it to the project directory:

```
% curl -O https://raw.githubusercontent.com/uboslinux/ubosdev-setups/main/ubosdev-docker/docker-compose.yml
```

## Check out the source code for your project

For this tutorial, we will be using the "Glad-I-Was-Here" trivial guestbook
{{% gls App %}}, because they are very easy to understand.

In your project directory, check out the code:

```
% git clone https://github.com/uboslinux/ubos-toyapps.git
```

It's important that the code ends up below your toplevel directory ``~/ubosdev``
because otherwise the default Docker container setup can't get at it.

## Start the containers

In the project directory, run:

```
% sudo docker-compose up
```

{{% note %}}
Depending on your computer's setup, you may (or may not) need to prefix
all ``docker`` and ``docker-compose`` commands with ``sudo``. Here we
show them all with ``sudo``; you may be able to omit it.
{{% /note %}}
{{% note %}}
If you want to develop on a {{% gl release_channel %}} other than `green`,
such as on `yellow`, pass in the release channel as an environment variable, like this:
```
% sudo CHANNEL=yellow docker-compose up
```
{{% /note %}}

Wait until Docker has reported:

```
Creating ubos-target  ... done
Creating ubos-develop ... done
Attaching to ubos-develop, ubos-target
```

The containers are ready.

## Allow `ubosdev` on `ubos-develop` to deploy to `ubos-target`

You only need to do this section the very first time you run these containers.

### Create and distribute the ssh key

In another shell, in the project directory, run:

```
% sudo docker exec -u ubosdev ubos-develop ssh-keygen -q -f /home/ubosdev/.ssh/id_rsa -P ''
% sudo docker exec -u ubosdev ubos-develop cat /home/ubosdev/.ssh/id_rsa.pub | sudo docker exec -i ubos-target ubos-admin setup-shepherd -v
```

This will create a fresh ssh keypair for `ubosdev` in `ubos-develop`, and setup
a secured channel to container `ubos-target` through which `ubosdev` can
deploy code.

### Log into `ubos-develop` as `ubosdev` and test the ssh setup between the containers

Log on:

```
% sudo docker exec -i -t -u ubosdev ubos-develop bash
```

In that shell, execute:

```
% ssh -t shepherd@ubos-target whoami
```

After the initial ssh authenticity warnings (say "yes" to continue connecting),
this should print: "shepherd".

## Build the App

Log into `ubos-develop` as `ubosdev`, if you have not already:

```
% sudo docker exec -i -t -u ubosdev ubos-develop bash
```

Your project directory is available as subdirectory `project` there. Go there,
and below into the checked-out git directory. to where the `PKGBUILD` of the
{{% gl app %}} is that we are going to build:

```
% cd ~/project/ubos-toyapps/gladiwashere-php-mysql
```

Build with:

```
% makepkg -C -f
```

## Deploy the App to the ``ubos-target`` container

In the shell on the ``ubos-develop`` container, in the directory where you built
your {{% gl app %}}:

```
% ubos-push --host ubos-target gladiwashere-php-mysql-*.pkg*
```

(You may want to replace the `*`s and use the actual filename. You are looking for
the file with the long name that contains the `.pkg`.)

This will transfer the newly built {{% gl package %}} to the `ubos-target` container, and
cleanly upgrade any {{% gls site %}} that use the {{% gl package %}} there. The first time,
this will take a little bit.

Right now your `ubos-target` container is pristine and does not run any
{{% gl site %}}. You can check by pointing your browser to
`http://ubos-target:8080/`.

So from the `ubosdev` shell, we create a {{% gl site %}} on the target container that
runs your {{% gl app %}}:

```
% ssh -t shepherd@ubos-target sudo ubos-admin createsite
```

Enter ``*`` (the {{% gl wildcard_hostname %}}) as the hostname, and a reasonable
user id, username, password and e-mail address (this toy app doesn't actually use
any of them, so the values don't matter in this tutorial.)

When asked for the first {{% gl app %}} to run, enter
``gladiwashere-php-mysql`` and an empty string for the context path and
the {{% gls accessory %}}.

It will say "Deploying..." and then take a little while because various
dependencies need to be downloaded and installed, such as Mariadb.

## Try out your deployed App!

Go to ``http://localhost:8080/``. You will find your guestbook toyapp
there. Feel free to enter some data.

## Next steps

You might want to make a tiny change to the {{% gl app %}}, like changing the
text of the HTML, rebuild with ``makepkg`` and redeploy with ``ubos-push``.
You don't need to create another {{% gl site %}} -- it remains in place when
software updates are being done, and its data stays in place, too.

Then we recommend you work through {{% pageref "../toyapps" %}}.

To shut down your containers, enter `^C` in the shell where your ran
`docker-compose`.
