---
title: How do I debug UBOS Mesh unit tests?
weight: 1030
---

## The problem

Normally unit tests are being run with the `mesh-test` command. This is
a convenience wrapper around many unit tests which wasn't made to
run just a single unit test, or debug it.

## Running a single, failing unit test

`mesh-test` prints the {{% gl diet4j %}} invocations that it performs.
When a unit test fails, find the last invocation from the console ouput,
and then run this diet4j invocation directly, such as:

```
% diet4j net.ubos.model.test
```

This will still run all unit tests defined in this {{% gl diet4j %}} module,
but it understands arguments, specifically:

```
% diet4j <module> --help
```

to print a short help text, and

```
% diet4j <module> --classnamepattern <pattern>
```

to run only tests whose class names match the `<pattern>` regular expression.

For example:

```
% diet4j net.ubos.model.test --classnamepattern '.*MeshBaseHistoryTest.*'
```

will only run tests whose class name contains `MeshBaseHistoryTest` in the
`net.ubos.model.test` module.

## Debugging a single unit test

Armed with the command-line in the previous section, we precede this command
with environment variable `JAVA_OPTS`, whose value will be passed to the
java executable as flags.

A reasonable default invocation might be:

```
% JAVA_OPTS='-Xdebug -Xrunjdwp:transport=dt_socket,address=*:8888,server=y,suspend=y' diet4j ....
```

which runs the Java debug agent at port 8888, and suspends the process until
the debug client (e.g. NetBeans) has connected.

Then, connect to port 8888 in the container, or wherever you are running the
test, e.g. using the NetBeans "Attach Debugger" feature.

Make sure no firewall gets in the way of accessing this port. You can accomplish this
by making sure file `/etc/ubos/open-ports.d/java-debugging` exists in the container,
with content `8888/tcp`, and `sudo ubos-admin update` has been run to update the
firewall configuration.

{{% warning %}}
This invocation will open up your port 8888 to the world. If you do this for a Linux
container on the workstation you are running the debugger client, that's probably okay.
For server scenarios you may want to lock this down by not specifying `*` but something
more limited.
{{% /warning %}}
