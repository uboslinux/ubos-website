---
title: Learning from the toy apps
---

UBOS provides two "toy" {{% gls App %}} that help explain how to package and distribute
real web {{% gls App %}} on UBOS:

* "Hello World" is an extremely simple Web applications that just displays Hello World
  when accessed over the web. We use it to give you a taste for what is involved to
  package web application for UBOS.

* "Glad-I-Was-Here" is a slightly more complex "guestbook" web application that uses a
  relational database to store the guestbook entries. We use it to illustrate how to package
  web {{% gl App %}} that use a database. It now comes in four versions:

  * implemented in PHP with a MySQL backend, called ``gladiwashere-php-mysql``;

  * implemented in PHP with a Postgresql backend, called ``gladiwashere-php-postgresql``;

  * implemented in Java with a MySQL backend, called ``gladiwashere-java-mysql``; and

  * implemented in Python/WSGI with a MySQL backend, called ``gladiwashere-python-mysql``

The PHP versions of Glad-I-Was-Here can also be configured with an {{% gl Accessory %}} called
``gladiwashere-php-footer``. This {{% gl Accessory %}} adds additional content (a footer) to the main
web page. This demonstrates the basic functioning of {{% gls Accessory %}}.

Note: These toy {{% gl App %}} are published in the ``toyapps`` repository, which is not enabled
by default. For how to enable, {{% pageref "/docs/users/enabling-nonstandard-repos.md" %}}.

You may want to read through the documentation for these {{% gls App %}} in this sequence:

* {{% pageref "/docs/toyapps/helloworld.md" %}}
* {{% pageref "/docs/toyapps/gladiwashere-php-mysql.md" %}}
* {{% pageref "/docs/toyapps/gladiwashere-php-mysql-footer.md" %}}
* {{% pageref "/docs/toyapps/gladiwashere-php-postgresql.md" %}}
* {{% pageref "/docs/toyapps/gladiwashere-java-mysql.md" %}}
* {{% pageref "/docs/toyapps/gladiwashere-python-mysql.md" %}}



