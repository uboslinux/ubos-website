---
title: Importing your data into the UBOS Personal Data Mesh
breadcrumbtitle: Importing your data
weight: 30
---

## Introduction

Now that you have obtained your personal data from Facebook, Google or Amazon,
and you have the Docker container running, you will:

* import some or all of the personal data you obtained;

* then, with your web browser, you browse the data that
  you just imported, served by the {{% gl mesh %}}, not Facebook and
  the like.

{{% note %}}
This is an engineering preview. Many things are still expected to change
before this becomes a released product suitable for end users. For example,
the various importers do not cover all exported data yet, the user interface
needs lots of work, the entire import process in this tutorial is something
only a hard-core geek could love (whom it is written for, so you can understand
how things work instead of hiding them under lots of eye candy), and there many
other issues. Expect bugs, too. (Please [file them](https://gitlab.com/ubos/).)

But it's good enough to give you a taste. So in this spirit, carry on!
{{% /note %}}

## Put the downloaded data into the right place

Copy the files you obtained from Facebook, Google, or Amazon:

* **not** in the the same directory where you ran the `docker`
  command, but:
* in its sub-directory named ``shared``.
* If you downloaded Amazon data and you followed our advice to store all Amazon
  files in a separate directory, copy that entire directory into ``shared``
  as a subdirectory. Do not commingle individual files from the Amazon export
  with files from Google or Facebook in the same directory.
* **Do not** uncompress the files. The importer needs the formats in which
  the data was exported.

## Log into the Docker container as user ``ubosdev``

Converting the data and pushing it into the {{% gl mesh %}} needs to be done from
inside the Docker container, where the {{% gl mesh %}} runs. So in another terminal,
log into the Docker container as pre-configured user ``ubosdev``:

```
% sudo docker exec -i -t -u ubosdev demo-ubos-mesh /bin/bash
```

We will be performing data conversion and import in this terminal.

## Convert the obtained data into the {{% gl dotMeshFormat %}}

Remember the `shared` directory into which you copied your data files a couple
of steps back? This directory has been mounted into your container at
directory `~ubosdev/shared` (i.e. directory `shared` below your user's
home directory). Go to that directory in the container terminal:

```
% cd ~/shared
```

Then, for each of the data files you obtained from Facebook or Google,
run the `mesh-converter` command, replacing the file names
suitably. For example, if your Facebook export file is called
`facebook-williamsmith.zip`, you might want to invoke the converter
like this:

```
% mesh-converter --in facebook-williamsmith.zip --out facebook-williamsmith.mesh
```

The ``--in`` argument specifies the name of the input file, the ``--out``
that of the converted export file. We recommend you use the ``.mesh`` extension.

For the Amazon data, use the name of the directory as the ``--in`` argument,
e.g. like this:

```
% mesh-converter --in amazon/ --out amazon.mesh
```

If you have three exports, this should give you three `.mesh` files,
which contain your exported data in the {{% gl dotMeshFormat %}}.

{{% note %}}
Some people are far more active online than others. Depending on that,
your data files may be significantly larger (or smaller) than other people's.
Factors of 1000 are not unheard of. Depending on this, your conversion
times may be seconds, or take a long time.

In this engineering preview, for now, if you have large data files, you may run
out of memory, depending on how much RAM your computer has available.
Sorry about that, we'll fix that for production.
{{% /note %}}

## Interlude: the problem with repeat imports

Now we have the data in the {{% gl dotMeshFormat %}}.

We could take that converted data as-is, and send it over to the {{% gl mesh %}}.
This would work, but only the first time! What if we exported, say, our
Facebook data again in six months, and tried to re-import it? We would have
lots of duplicates on the {{% gl mesh %}}, and what if some data was actually
deleted in the meantime? We'd end up with a big mess.

Alternatively we could delete the old version of the data on the {{% gl mesh %}}
before importing the new version. But we don't want to do that either: if we did, all
annotations the user might have created on their imported data, and all
relationships between the imported data and other data, would become orphaned
and useless. Another potential mess.

We don't like messes on the {{% gl mesh %}}. So instead, we send **a delta** to the
{{% gl mesh %}}, i.e. only the differences between the most recent export from some
data source (like Facebook), and the second-most recent export of the same data
that we imported last time.

Right now, this is our very first import, so the baseline (the "last import") is
empty. Run the following command for each one of your `.mesh` files. Adjust the name
of the ``--out`` file suitable. We recommend you use the `.peertalk` extension.

For example:

```
% cd ~/shared
% mesh-differencer --in facebook-williamsmith.mesh --baselineempty --out facebook-williamsmith.peertalk
```

When we have a new version of some data (e.g. the Facebook data), say exported 6 months
later, we would specify the previous import file as the (then non-empty) baseline, so we only
push the difference to the {{% gl mesh %}}.

## Let's send the delta over to the {{% gl mesh %}}

Like this, for each one of the `.peertalk` files you created, such as:

```
% mesh-peertalk push --in facebook-williamsmith.peertalk
```

Like all "data load" operations everywere in computing, his will take a little while.
Once the command prints out "Success", the {{% gl mesh %}} will have imported that
data file.

## Browse the imported data

Refresh your browser window at `http://localhost:1080/` (not: 8080 as in the screenshot.)
The "No data" message has gone away, and instead you see a search field, and a
categorization of the data objects currently held by the
{{% gl mesh %}}.

## The end of this tutorial

You have made it to the end of this tutorial! Here are some ideas for next steps:

* To stop your container, enter `^C` (control-C) in the shell where you are running `docker-compose`.
  This will:

  * **delete the (mock) data you uploaded** to the {{% gl mesh %}}
  * but not the converted files in the `shared` directory.

  When running the container again, you can always load the data again with commands such as:

  ```
  % mesh-peertalk push --in facebook-williamsmith.peertalk
  ```

* Please file [issues](https://gitlab.com/ubos/) with anything odd you encounter.

