---
title: Developing using Docker (all Intel platforms)
weight: 10
---

## Prerequisites

This should work on all x86_64 platforms that run Docker. We have tested this
setup on macOS Intel and Arch Linux on x86_64.

An alternative setup is {{% pageref systemd-nspawn.md %}}.

Here are the steps:

## Install Docker and Docker Composer

If you don't have Docker installed yet, please refer to the
[Docker documentation](https://www.docker.com/get-started). It may be
as easy as downloading Docker Desktop for your operating system and running
the app.

## Pick a project directory and download the recommended configuration files

We recommend you do all your UBOS-related development below a certain directory.
Let's say that directory is ``~/ubosdev-docker``. Create that directory and enter
it:

```
% mkdir ~/ubosdev-docker
% cd ~/ubosdev-docker
```

Download the Docker Compose file and save it to the project directory:

```
% curl -O https://raw.githubusercontent.com/uboslinux/setups-ubosdev/main/ubosdev-docker/docker-compose.yml
```

Then create a sub-directory for your project files:

```
% mkdir projects
```

## Pick a release channel to work on

By default, this setup uses the `yellow` {{% gl release_channel %}}.
This is the recommended {{% gl release_channel %}} for most application development.

{{% note %}}
If you want to develop on a {{% gl release_channel %}} other than `yellow`,
set the release channel as an environment variable for the Docker commands,
and replace the string `yellow` with the name of the alternate {{% gl release_channel %}}
in all other commands.
{{% /note %}}

## Start the container

In the project directory, run:

```
% sudo docker-compose up -d
```
or, if you use a different {{% gl release_channel %}} such as `red`:
```
% sudo CHANNEL=red docker-compose up -d
```

{{% note %}}
Depending on your computer's setup, you may (or may not) need to prefix
all ``docker`` and ``docker-compose`` commands with ``sudo``. Here we
show them all with ``sudo``; you may be able to omit it.
{{% /note %}}

This may take a bit of time, if Docker has to download the container image
first, or download a new image when there were updates.

Wait until Docker has reported:

```
Attaching to ubos-develop-yellow
```

The container is ready.

## Open a shell in the container

In another shell, execute:

```
% sudo docker exec -i -t -u ubosdev ubos-develop-yellow bash
```

This gives you a shell in your container. You will execute your build
commands in this shell. You can open up as many shells on the container
as you like.

Note that your projects directory on the host that you created earlier,
is mounted into your container right where you are. You can see the same
files there on the host and in the container:

```
% ls -al projects
```

That makes sharing files between the host (where you can edit them with
the editor of your choice) and the container (where you build and run your
code) quite easy.

## Shut down the container

When you are done developing, shut down the container with:

```
% sudo docker-compose stop
```
You can always start it again with
```
% sudo docker-compose start
```
