---
title: Build and run your first UBOS Gears App
weight: 10
---

In this tutorial, you will be building, deploying and running a simple
PHP web application as a standalone {{% gl app %}} on UBOS.

We will be using the "{{% pageref "/docs/development/tutorials-gears/toyapps/" "Glad-I-Was-Here" %}}"
toy guestbook {{% gl App %}}, because it is very easy to understand.

This tutorial should take about 20-30 minutes.

## Prerequisites

This tutorial assumes you have set up your development container setup
either using Docker or `systemd-nspawn` as described in
{{% pageref "../setup/" %}}.

Continue here once you have your development container running, and
a shell open in the container.

## Check out the source code for your project

In the `projects` subdirectory you created during setup, on the host,
check out the code for your project, such as:

```
% cd projects
% git clone https://github.com/uboslinux/ubos-toyapps.git
```

You will notice the code also shows up in the `projects` directory
in the container.

## Build the App

In the container, go to the directory that contains the
`PKGBUILD` for our example and build the package:

```
% cd projects/ubos-toyapps/gladiwashere-php-mysql
% makepkg -C -f
```

This creates a package containing your {{% gl app %}} and
associated metadata. We will install it in the next step.

## Install the App

To install the package, in the container, run:

```
% sudo pacman -U gladiwashere-php-mysql-*.pkg*
```

Now we have the code in the right places, but the web server
and database are not configured yet to actually run the {{% gl app %}}.

You can check by accessing your container with your web browser:

* If you run a Docker container, access: [http://localhost:1080/](http://localhost:1080/)
* If you run a `systemd-nspawn` container, access: [http://ubos-develop-yellow/](http://ubos-develop-yellow/)

This will show a "No such site" web page.

We will deploy the {{% gl app %}} in the next step.

## Deploy the App

To create a website, deploy the {{% gl app %}} to the website, and do
all necessary provisioning -- like setting up a Mariadb database -- we use
the `ubos-admin` sub-command `createsite`. In the container, execute:

```
% sudo ubos-admin createsite
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

* If you run a Docker container, access: [http://localhost:1080/](http://localhost:1080/)
* If you run a `systemd-nspawn` container, access: [http://ubos-develop-yellow/](http://ubos-develop-yellow/)

You will find your guestbook toyapp there. Feel free to enter some data.

## Make a change to your deployed App

The update cycle is a bit faster than initial setup.

1. Make your change, say, change one of the PHP files of the {{% gl App %}}.

1. Run the build again:

   ```
   % makepkg -C -f
   ```

1. Redeploy the already-deployed site with:

   ```
   % sudo ubos-admin update -v --pkg gladiwashere-php-mysql-*.pkg*
   ```

This last step will undeploy your previous {{% gl Site %}} configuration, install
the new version of the code, redeploy the same {{% gl Site %}} configuration,
and restore any data that you entered. It would even run database migrations
if it needed to (but it doesn't; this is a simple toy {{% gl App %}}).

## Next steps

We recommend you work through {{% pageref toyapps %}}.

