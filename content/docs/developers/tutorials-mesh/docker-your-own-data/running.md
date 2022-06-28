---
title: Getting the UBOS Personal Data Mesh running with Docker
weight: 20
---

## Introduction

In this section, you will:

* start an instance of the {{% gl mesh %}} in a Docker container.
* import one or more of the data files you obtained from Facebook,
  Google or Amazon in the {{% pageref "getting.md" "previous step" %}}.

## Prerequisites

A x86_64 computer with:

* `Docker`,
* `docker-compose` and
* `git`.

It does NOT work on Apple Silicon at this time.

To install Docker, please refer to the Docker documentation at
[www.docker.com/get-docker](https://www.docker.com/get-docker). It may be
as easy as downloading and running Docker Desktop for your operating system.

Installation instructions for `docker-compose` are at
[docs.docker.com/compose/install](https://docs.docker.com/compose/install/).

Installation for `git` depends on your operating system. On macOS, it
is installed automatically when you install [XCode](https://developer.apple.com/download/).

This tutorial has been tested on macOS and Arch Linux; however, there
is no reason they wouldn't work on other platforms that run Docker.

## Check out the project directory from Git

Open a terminal. In a suitable directory, enter:

```
% git clone https://gitlab.com/ubos/demo-ubos-mesh.git
```

In your terminal, enter that git directory and take a look what's there:

```
% cd demo-ubos-mesh
% ls -l
```

You will notice a `docker-compose.yml` file.

If you previously checked out this repository, update it to the latest version:

```
% cd demo-ubos-mesh
% git pull
```

## Pull the latest version of the Docker container and run it

Pull the latest:

```
% sudo docker-compose pull
```

This may take a little while, as there is lots to download.

Run docker-compose:

```
% sudo docker-compose up
```

{{% note %}}
Docker may or may not need administration or root privileges on your computer. On macOS and Linux,
try running all `docker` and `docker-compose` commands with `sudo` as we show it here; on
Windows, run the terminal in Administrator mode.
{{% /note %}}

Then wait until Docker reports on the terminal that it has created
the container and attached to it. This might take a few minutes, as the
Docker container is first downloaded and then booted.

## Open a browser window to view the user interface of the still-empty UBOS Personal Data Mesh

In your browser, go to `http://localhost:1080/` (not: 8080; screenshot is wrong). This will access
the web server in the Docker container.

{{% screenshot "/assets/tutorials-mesh/running/front-empty.png" %}}

This may first show an error page: "No such site", saying that the website might still
be upgrading. That's because this engineering preview Docker container
only deploys the {{% gl mesh %}} when it is booted.

After a few minutes, if you hit refresh in your browser, that message disappears and
you get the default {{% gl mesh %}} front page saying "No data."

{{% note %}}
If you cannot use port 1080, use a different port by changing the "1080" in the `docker-compose.yml`
file to something else, and restart your Docker container.
{{% /note %}}

{{% note %}}
If you want to stop your Docker container again, simply hit `^C` (control-C)
once in the shell where you are running `docker-compose`.
{{% /note %}}

## Next step

In the {{% pageref "import-data" "next step" %}}, let's
import the data you obtained from Facebook, Google and Amazon.

