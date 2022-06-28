---
Title: How to develop a new Importer
weight: 80
display: hide
---

## Context

As we are developing the Twitter {{% gl Importer %}}, we have been taking notes,
in the hope that they will be helpful for others developing other {{% gls Importer %}}.

## Setup

The Twitter {{% gl Importer %}} is going to be rather similar to the Facebook {{% gl Importer %}}, or
the Google {{% gl Importer %}}. Because of that, we create a project structure that mirrors
those.

Specifically, we have:
* a project containing the {{% gl Model %}} for the Twitter data
* a project containing the actual {{% gl Importer %}} code.

Note: in the future, this may be automated (better than it is right now) using
`ubos-scaffold` to generate the right structure.

## Get a representative data export from Twitter

We went through the Twitter data download process, obtained the ZIP file they
generated, and expanded that ZIP file in a suitable place, to get a feel for what
kind of data there is, and how Twitter represent it.

The Twitter data export ZIP file contains lots of JSON files and media assets
of various types. It also helpfully contains an HTML file that can render the files;
we can use this to understand the exported data during development, but won't
otherwise use it because it's only made for visual rendering. (Note: it turns
out Twitter does not actually visualize all of the exported JSON data, so it
isn't as helpful as it looked like in the first place!)

## Decide which subset of data to support with a strongly-typed Model

If you follow our approach here, all data that Twitter exports will end up on the
UBOS Mesh, even if you don't write any code for importing it. This is because out
of the box, the UBOS Mesh `GenericImporter` can import any ZIP file containing
JSON files into {{% gls MeshObject %}} with weakly-typed {{% gls Attribute %}}
and {{% gls RoleAttribute %}}.

However, without a {{% gl Model %}} that's instantiated by an {{% gl Importer %}}
that you write for your data source, UBOS Mesh cannot actually "understand" the imported
data. To do interesting stuff with imported data, it needs to be imported into strongly-typed
{{% gls EntityType %}}, {{% gls RelationshipType %}} and the like. To do that, we
need a {{% gl Model %}}.

In many cases, we don't want to develop a complete {{% gl Model %}} for all data
exported from a particular source; at least not initially. So we pick those parts
of the data set that we are particularly interested in.

Reviewing the exported Twitter data, we decided for our project here that we are interested in:

* Profile information (e.g. avatar)
* Friends (followers and following)
* Content (tweets, replies, direct messages etc)

These are the data elements we need {{% gl Model %}} support for.

## Creating the Twitter Model by extending already-existing generic Models

Chances are that the {{% gl Model %}} you need for your new {{% gl Importer %}}
only needs to be a refinement of {{% gls Model %}} that already exist in the
{{% gl mesh %}} model library. You can use those existing concepts by:

* Using them directly.
* Subtyping them to add more information.
* Creating additional relationships to and from them.

You are strongly encouraged to reuse existing {{% gls MeshType %}}, because
that way, any code -- like user interface code -- that has been written against
those {{% gls Model %}} immediately works with the data imported through your new
{{% gl Importer %}}. This saves you effort, and makes life easier for the user
because their cognitive effort is lower to interact with and make sense of the
new data.

Also, if an {{% gl Importer %}} for similar data exists already, you are encouraged
to follow the same approach as it does. Here, we already have a Facebook
{{% gl importer %}} and it would be highly desirable that the {{% gl MeshObject %}}
graph structures we instantiate for Twitter import are similar to the ones
being instantiated for Facebook, for data that is similar (e.g. posts, social graph).

A good approach for creating a new {{% gl Model %}} is the following:

1. Review the graphical representation of the existing {{% gls Model %}} that
   may be relevant. They are on-line at {{% pageref "../reference-mesh/models" %}}.
1. Graphically, like on a white board, draw a similar diagram for the
   {{% gl Model %}} you are about to create for your new {{% gl Importer %}}.
1. Review the data you want to import, file by file, item by item, and
   check that you can represent it with the {{% gl Model %}} you drew.
1. Convert the hand-drawn {{% gl Model %}} into a `model.xml` file that
   you can then build.
1. Only then, start developng the {{% gl Importer %}} itself.



---

## Introduction

In this tutorial, we will create a new importer for a new data
source that uses a **new data format** that the {{% gl mesh %}} does not know about
so far, and that contains **new types of data**, too.

(Actually, we are going to cheat. We are going to pretend that we are building
an importer for Amazon data from scratch. Such an importer exists already, and we will
save some time by pretending we had to create it from scratch.)

To do that, we will:

* Create a {{% gl model %}} that captures the semantics and structure of the
  new types of data that we want to import. As it is best-practice, it will only
  define new types of data, and reuse the {{% gls model %}} that already
  define types of data that are the same as existing ones.

* Create the actual importer code, which uses the new {{% gl model %}}.

* Build and install the created code modules, with the {{% gl mesh %}} build tools.

* Push some Amazon mock data into the {{% gl mesh %}}.

## Directory layout and the UBOS "Scaffold" tool

An entirely new importer may warrant a new Git repository. That's what we have been
doing when developing the {{% gl mesh %}}. Let's say say it is named
``ubos-mesh-amazon``

(You can see the final version at
[on Gitlab](https://gitlab.com/ubos/ubos-mesh-amazon). Don't panic. It's not
as complicated as it looks.)

FIXME. To be continued.



