---
title: Doesn’t apt / dpkg / yum / pacman etc. does what UBOS Gears does already?
weight: 10
---

No. They all manage software {{% gls Package %}}. They do not manage full configurations of
the code in those {{% gls Package %}} into running web {{% gls App %}}.

Take WordPress as an example. If you install a WordPress {{% gl Package %}} with one of the
package managers above, it will dump all the WordPress code on your drive, but it is left to
you to create a database and edit the Apache virtual host configuration. That is in spite of
the fact that installing WordPress is much simpler than installing most web applications
where you often also need to install (or even compile) additional dependencies, and sometimes
even get additional services to run.

If you want to run the same application more than once on the same machine (for example,
at different virtual hosts), package managers are not able to help at all. Certainly they
also don't help with backups, restores, SSL/TLS configuration and many other administration
tasks that {{% gl gears %}} helps automate.

P.S. We build on top of ``pacman`` (the Arch Linux package manager) and each UBOS package
is a valid ``pacman`` package. ``ubos-admin`` invokes ``pacman`` somewhere in the middle
of rather more functionality.

