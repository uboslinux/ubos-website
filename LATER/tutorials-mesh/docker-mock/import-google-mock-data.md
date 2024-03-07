---
title: Adding Google data and watching a bot connect it to the Facebook data
weight: 60
---

## Introduction

In this section:

* we will add some (mock) Google data to the (mock) Facebook data you imported previously
  in {{% pageref import-facebook-mock-data.md %}};

* automatically, a {{% gl bot %}} will integrate the new Google data with the previous
  Facebook data, attempting to identify the same people on the two services, to create an
  "uber" address book that contains all people that our fictitious user William Smith knows on
  either Facebook or Google, with a single address book record each.

## Import the mock Google data

The process is the same as in {{% pageref import-facebook-mock-data.md %}}: get the (mock)
data from "Google", convert it into the universal {{% gl mesh %}} format, construct a delta,
and pass that on to the {{% gl mesh %}}.

The mock Google data is at [http://depot.ubosfiles.net/mockdata/google/](http://depot.ubosfiles.net/mockdata/google/).
Look for file `google-williamsmith.zip` and download it into the ``shared`` directory.
(The sources for the file are
[here](https://gitlab.com/ubos/mock-data-google/).)

Then, in the container shell:

```
% cd ~/shared
% mesh-converter --in google-williamsmith.zip --out google-williamsmith.mesh
% mesh-differencer --in google-williamsmith.mesh --baselineempty --out google-williamsmith.peertalk
% mesh-peertalk push --in google-williamsmith.peertalk
```

Again that takes a little bit of time.

You can revisit {{% pageref import-facebook-mock-data.md %}} to remind yourself what
those steps do.

## Browse the mock Google data

Go back to the front page of the {{% gl mesh %}} at `http://localhost:1080/` (not: 8080 as in
the screenshot.) You'll see that new categories of data have shown up. Feel free to click around.

{{% screenshot "/assets/tutorials-mesh/import-google-mock-data/front-with-facebook-google.png" %}}

{{% note %}}
Currently the coverage of the Google importer is very minimal, it really only
imports profile information of the user, and parts of their Google address book.
(Want to help? The parser code is
[here](https://gitlab.com/ubos/ubos-mesh-google/-/tree/main/ubos-mesh-importer-google/net.ubos.importer.google/src/main/java/net/ubos/importer/google)
and open source!)
{{% /note %}}

## Enter the bot

While you were performing the `mesh-peertalk push` command, a little {{% gl bot %}} was
watching the {{% gl TransactionLog %}} of the main {{% gl MeshBase %}} of the
{{% gl mesh %}}. Actually, it watches it all the time, not just then. Every time a
{{% gl Transaction %}} commits successfully, all registered {{% gls bot %}} run to
figure out whether they need to do something.

{{% insight %}}
Making changes to the data in a {{% gl MeshBase %}} requires a Transaction, just
like a database would. Unlike a typical database, code can subscribe to Transaction events,
and be notified when a Transaction is done committing. That's what the {{% gl Bot %}} uses
to know when it is time to run.
{{% /insight %}}

The Docker container you are using in this tutorial runs a single {{% gl bot %}}, called the
"Person Aggregation Bot".

When the Google (mock) data import succeeded, the "Person Aggregation Bot" looked at the
newly created data, specifically any {{% gls MeshObject %}} related to people, and tried
to figure out whether people with these names are known already on the {{% gl mesh %}}. If so,
it would create relationships between newly imported data and existing data about
the same person.

Here is an example. Go to the front page of the {{% gl mesh %}}, select "Person", then
"Rosie". It now says that she has two on-line profiles, one from Google and one from Facebook.
The {{% gl bot %}} matched her by name.

{{% screenshot "/assets/tutorials-mesh/import-google-mock-data/person-rosie.png" %}}

But it wasn't too sneaky about it. If you open up the Property Sheet for Rosie (
from the "Views" popup on the right), you see, further down, that the Person Aggregation Bot
notes in the {{% gls RoleAttribute %}} section that it created this relationship:

* name: `bot-created`, value: `net.ubos.bot.personaggregation.PersonAggregationBot`.

{{% screenshot "/assets/tutorials-mesh/import-google-mock-data/person-rosie-bot-created.png" %}}

This value makes it easy to tell which data that has been created by
a {{% gl bot %}}.

## The end of this tutorial

You have made it to the end of this tutorial! Here are some ideas for next steps:

* To stop your container, enter `^C` (control-C) in the shell where you are running `docker-compose`.
  This will:

  * **delete the (mock) data you uploaded** to the {{% gl mesh %}}
  * but not the converted files in the `shared` directory.

  When running the container again, you can always load the data again with:

  ```
  % mesh-peertalk push --in facebook-williamsmith.peertalk
  % mesh-peertalk push --in google-williamsmith.peertalk
  ```

* Try the tutorial: {{% pageref "../docker-your-own-data/" %}}

* Please file [issues](https://gitlab.com/ubos/) with anything odd you encounter.

