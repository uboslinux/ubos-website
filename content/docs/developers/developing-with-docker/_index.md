---
title: Using Docker for development
weight: 20
display: hide
---

You can use Docker containers to develop and test {{% gls app %}} and
{{% gls accessory %}} for UBOS.

If you do that, other than Docker and Docker Compose, you don't need to install
any other development tools. You can use your preferred editor on you development
workstation. And you also get a realistic UBOS run-time environment for testing.

Our preferred Docker develoment environment uses two Docker containers:

* container ``ubos-develop`` runs UBOS, with common UBOS build tools
  pre-installed. You use this build UBOS packages, as as for {{% gl app %}}
  and {{% gls accessory %}}.

* container ``ubos-target`` runs a UBOS production environment. You deploy
  your UBOS packages there to run and test them. This container is

TTo set up and use this two-container Docker environment:
