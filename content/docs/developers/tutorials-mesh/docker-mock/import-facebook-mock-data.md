---
title: Importing (mock) Facebook data into the UBOS Personal Data Mesh
breadcrumbtitle: Importing (mock) Facebook data
weight: 20
---

## Introduction

Now that you have completed the first section of the tutorial,
{{% pageref "running.md" %}}, you will:

* import some (mock) Facebook data that we have prepared for you. To do that,
  after downloading the mock data, you'll first convert it into a format that the
  {{% gl mesh %}} can understand, then push the converted data into the
  {{% gl mesh %}};

* then, with your web browser, you browse the mock Facebook data that
  you just imported, served by the {{% gl mesh %}}, not Facebook.

{{% note %}}
This is an engineering preview. Many things are still expected to change
before this becomes a released product suitable for end users. For example,
the Facebook importer does not cover all Facebook data yet, the user interface
needs lots of work, the entire import process in this tutorial is something
only a hard-core geek could love (whom it is written for, so you can understand
how things work instead of hiding them under lots of eye candy), and there many
other issues. Expect bugs, too. (Please [file them](https://gitlab.com/ubos/).)

But it's good enough to give you a taste. So in this spirit, carry on!
{{% /note %}}


## Get the (mock) Facebook export data

Imagine you went to https://facebook.com/dyi (their data export page)
and downloaded an archive of your Facebook data. If you did that -- and we
recommend you do -- Facebook would give you a big zip file called, for
example, `facebook-williamsmith.zip`, which contains all your data.

For this tutorial, we have created an archive just like it, but it only
contains mock data. The supposed Facebook user William Smith does not actually
exist. His (mock) data export file, however, is constructed just as if
Facebook had done it. (The sources for the file are
[here](https://gitlab.com/ubos/mock-data-facebook/).)

Go to [http://depot.ubos.net/mockdata/facebook/](http://depot.ubos.net/mockdata/facebook/).
In this directory, you will find the following file:

* `facebook-williamsmith.zip`

Download that mock Facebook export data file, and save it:

* **not** in the the same directory where you ran the `docker`
  command, but:
* in its sub-directory named ``shared``.
* **Do not** uncompress the file. The importer needs the ZIP format.

## Log into the Docker container as user ``ubosdev``

Converting the data and pushing it into the {{% gl mesh %}} needs to be done from
inside the Docker container, where the {{% gl mesh %}} runs. So in another terminal,
log into the Docker container as pre-configured user ``ubosdev``:

```
% sudo docker exec -i -t -u ubosdev demo-ubos-mesh /bin/bash
```

We will be performing data conversion and import in this terminal.

## Convert the mock Facebook data into the {{% gl dotMeshFormat %}}

Remember the `shared` directory into which you downloaded the (mock)
Facebook data file? This directory has been mounted into your container at
directory `~ubosdev/shared` (i.e. directory `shared` below your user's
home directory). Go to that directory in the container terminal, and run the
already-installed {{% gl mesh %}} `mesh-converter`.

```
% cd ~/shared
% mesh-converter --in facebook-williamsmith.zip --out facebook-williamsmith.mesh
```

The ``mesh-converter`` looks at the structure of the file it was given as the
"in" file, makes an intelligent guess about which of the importers it knows about
to run (here: the Facebook one), runs it, and exports the converted data
in the {{% gl dotMeshFormat %}}.

After the command completes, you should now have a `.mesh` file in the same directory:

```
% ls
facebook-williamsmith.mesh  facebook-williamsmith.zip
```

## Interlude: the problem with repeat imports

Now we have the (mock) Facebook data in the {{% gl dotMeshFormat %}}.

We could take that converted data as-is, and send it over to the {{% gl mesh %}}.
This would work, but only the first time! What if we exported our
Facebook data again in six months, and tried to re-import it? We would have
lots of duplicates on the {{% gl mesh %}}, and what if some data was actually
deleted in the meantime? We'd end up with a big mess.

Alternatively we could delete the old version of the Facebook data on the {{% gl mesh %}}
before importing the new version. But we don't want to do that either: if we did, all
annotations the user might have created on their imported Facebook data, and all
relationships between the imported Facebook data and other data, would become orphaned
and useless. Another potential mess. (We will discuss this in more detail in a later
tutorial.)

We don't like messes on the {{% gl mesh %}}. So instead, we send **a delta** to the
{{% gl mesh %}}, i.e. only the differences between the most recent export of the
Facebook data, and the second-most recent export of the Facebook data that we imported
last time.

Right now, this is our very first import, so the baseline (the "last import") is
empty, and the command to create a file containing the delta is:

```
% cd ~/shared
% mesh-differencer --in facebook-williamsmith.mesh --baselineempty --out facebook-williamsmith.peertalk
```

Run it. You should now also have a `.peertalk` file in your directory:

```
% ls
facebook-williamsmith.mesh  facebook-williamsmith.peertalk  facebook-williamsmith.zip
```

When we have a new version of the Facebook data, say exported 6 months later, we would
specify the previous import file as the (then non-empty) baseline, so we only
push the difference to the {{% gl mesh %}}. (We discuss the algorithm later that
creates the delta.)

## Let's send the delta over to the {{% gl mesh %}}

Like this:

```
% cd ~/shared
% mesh-peertalk push --in facebook-williamsmith.peertalk
```

Like all "data load" operations everywere in computing, his will take a little while.
Once the command prints out "Success", the {{% gl mesh %}} will have William Smith's
Facebook data.

(Why is the recommended extension `.peertalk`? Long story ... for some other time, too.)

## Browse the imported data

Refresh your browser window at `http://localhost:1080/` (not: 8080 as in the screenshot.)
The "No data" message has gone away, and instead you see a search field, and a
categorization of the data objects currently held by the
{{% gl mesh %}}.

{{% screenshot "/assets/tutorials-mesh/import-facebook-mock-data/front-with-facebook.png" %}}

A typical real-world Facebook user would of course have many, many more objects than
our mock user William Smith, but they would be in the same categories, and likely some others.
(You can certainly {{% pageref "../docker-your-own-data/" "try with your own Facebook data later" %}}, but
we recommend you continue through this tutorial with the mock data first.)

Feel free to click around, but **to understand what you are seeing**, we recommend
you continue with the next section: {{% pageref "browsing-facebook-mock-data.md" %}}.

## Next step

In the next section {{% pageref "browsing-facebook-mock-data.md" %}}, we will examine some of the
data shown in the UI, and what that tells us about the
{{% gl mesh %}}.

