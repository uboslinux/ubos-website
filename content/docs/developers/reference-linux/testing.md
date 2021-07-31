---
title: 'Testing standalone Apps with "webapptest"'
weight: 100
---

## About ``webapptest``

It's very important that {{% gls App %}} on UBOS deploy correctly, undeploy cleanly, and that
their data can be reliably backed up, restored, and migrated when your {{% gl App %}} moves
to a new version. We do not ever want to ask a user to "fix the {{% gl App %}} installation"
manually if we can help it.

To aid in testing this, we use a test tool called ``webapptest``
(source is [here](https://github.com/uboslinux/ubos-tools/tree/master/webapptest)),
which has been written specifically for this purpose. ``webapptest`` is not a regular application
testing tool; it is not intended to find out whether, say, your {{% gl App %}} runs nicely in
Internet Explorer. Instead, it focuses on testing installation, uninstallation, backup and restore;
something typical testing tools don't focus on.

To install ``webapptest`` on a UBOS {{% gl Device %}}, run:

```
% sudo pacman -S webapptest
```

## Example: Testing Glad-I-Was-Here locally

To test the Glad-I-Was-Here toy application with all the default settings on a
{{% gl Device %}}, execute:

```
> webapptest run GladIWasHereTest1.pm
```

(see [GladIWasHereTest1.pm in Git]( https://github.com/uboslinux/ubos-toyapps/blob/master/gladiwashere/tests/GladIWasHere1Test.pm).)

This will go through a series of steps deploying ``gladiwashere`` on your local {{% gl Device %}},
interacting with the {{% gl App %}} by filling out a guestbook entry, backing up the {{% gl App %}} data,
undeploying the {{% gl App %}}, re-deploying and restoring from backup. In other words, the types of
things that the {{% gl App %}} needs to do correctly to behave on UBOS.

The exact steps depend on the test plan you are using. To see available test plans,
execute:

```
% webapptest listtestplans
backup-all-states  - Creates a local backup file for each State.
default            - Walks through all States and Transitions, and attempts to backup and restore each State.
deploy-only        - Only tests whether the application can be installed.
deploy-update      - Tests whether the application can be installed and updated.
redeploy           - Tests that the application can be re-deployed after install at different hostnames.
restore-all-states - Restores from a local backup file for each State, and tests upgrade.
simple             - Walks through all States and Transitions in sequence.
well-known         - Walks twice through all States and Transitions in sequence, checking well-known site fields only.
```

To employ a test plan that is not the default, specify ``--testplan <name>`` as an argument
to ``webapptest``.

## Alternate scaffolds

``webapptest`` also knows the notion of a scaffold. To show the available scaffolds, execute:

```
% webapptest listscaffolds
container - A scaffold that runs tests on the local machine in a Linux container.
here      - A trivial scaffold that runs tests on the local machine without any insulation.
ssh       - A scaffold that runs tests on the remote machine that is already set up, and accessible via ssh.
v-box     - A scaffold that runs tests on the local machine in a VirtualBox virtual machine.
```

If using ``webapptest`` with the ``here`` scaffold, ``webapptest`` deploys the to-be-tested
{{% gl App %}} on the local {{% gl Device %}} (which needs to run UBOS). This is also the default.

By using the ``ssh`` scaffold, the to-be-tested {{% gl App %}} can be tested on a remote
UBOS {{% gl Device %}} over ssh. This is particularly useful for cross-platform testing, or
if you want to test your {{% gl App %}} on a dedicated test {{% gl Device %}} or server.

The ``v-box`` scaffold sets up and tears down an entire UBOS virtual machine for
the test. This is only available on x86_64 and requires VirtualBox to be installed.

Finally, the ``container`` scaffold creates a Linux container into which UBOS and the
to-be-tested {{% gl App %}} will be installed, using ``systemd-nspawn``.

Some of these scaffolds need parameters (e.g. the hostname of the ssh host or the image to boot
from), which are specified by appending them to the name of the scaffold like this:

```
% webapptest run --scaffold container:directory=/build/my-ubos-image-dir
```

## Test description

To define a test for webapptest, follow the example in
[GladIWasHereTest1.pm](https://github.com/uboslinux/ubos-toyapps/blob/master/gladiwashere/tests/GladIWasHere1Test.pm).

The essence of the test description is a series of states and transitions between them. The
states are states (with different data) that the application can be in. In ``GladIWasHereTest1``,
those are:

* ``virgin``: the {{% gl App %}} has just been deployed, and nobody has filled out a guestbook entry yet
* ``comment-posted``: a single comment has been posted

Obviously, depending on the {{% gl App %}}, many more states can be defined.

For each of these states, a script is run that tests that the {{% gl App %}} is indeed
in this state.

Transitions capture instructions for how ``webapptest`` can move the {{% gl App %}} from one
state to another. Here, we have only one, called ``post-comment``, which contains the
code to post a guestbook entry.

The essence of the test are the ``getMustContain`` and similar statements in the states.
``getMustContain`` will perform an HTTP GET operation on the provided URL (relative to
the location at which the {{% gl App %}} was installed), and make sure that the received content
contains a certain pattern. If not, it will print the provided error message.

The full API is
[here](https://github.com/uboslinux/ubos-tools/blob/master/webapptest/vendor_perl/UBOS/WebAppTest/TestContext.pm).
