---
title: Browsing the imported Facebook mock data
weight: 30
---

## Introduction

In this section, we will browse through some of the (mock) Facebook data you
{{% pageref "import-facebook-mock-data.md" "imported previously" %}} and touch on:

* the core ideas about data representation on the {{% gl mesh %}},
  such as {{% gls MeshObject %}};

* the core idea about the {{% gl mesh %}} user interface: dynamically matched
  {{% gls Viewlet %}}.

## Let's look at the photos imported from Facebook, and introducing {{% gls MeshObject %}}

Go back to the front page of your Docker container at `http://localhost:1080/`.
Click on "Photo" (below the "Media" headline).

This will bring up the list of the (mock) photos our mock user supposedly has uploaded
to Facebook. Scroll down a bit, and you should see a screen similar to the
following:

{{% screenshot "/assets/tutorials-mesh/browsing-facebook-mock-data/photos.png" %}}

On the left, we see the (mock) photos, and on the right side, the metadata exported
by Facebook, such as when each photo was created.

Note the "Album" label next to some of the photos. Click this label, and you
will see the Facebook album that contains this photo on Facebook -- together
with all the other photos in the same album.

{{% screenshot "/assets/tutorials-mesh/browsing-facebook-mock-data/album.png" %}}

You can click from the photo to the album, and to other photos in the same
album, because the {{% gl mesh %}} keeps all the relationships in the source data:
if Facebook said that a photo was part of an album, that's also true on the
{{% gl mesh %}}.

{{% insight %}}
Data elements on the {{% gl mesh %}} are called {{% gls MeshObject %}}. There
is much to say about {{% gls MeshObject %}} -- for now, only a few tidbits:

* {{% gls MeshObject %}} may have types (here: photo vs album)
* {{% gls MeshObject %}} may have properties (like the "Created" timestamp), and
* {{% gls MeshObject %}} may have relationships to other {{% gls MeshObject %}}
  (here: the relationship between the album and the photos it contains, so you
  could click from one to the other and back).

Most importantly: all personal data on the {{% gl mesh %}} is represented as
{{% gls MeshObject %}}. If you are looking for where data is stored, always
look for a {{% gl MeshObject %}} (and not a database table or such).
{{% /insight %}}

{{% insight %}}
Notice that all relationships between {{% gls MeshObject %}} are bidirectional:
you can traverse from a photo to the containing album, and from an album to any
of the contained photos. On the {{% gl mesh %}}, all relationships are bidirectional
regardless of whether they were in the input data or not (in the case of Facebook,
they are not).

The {{% gl mesh %}} automatically manages the integrity of these relationships in both
directions, so they never dangle or become inconsistent. You don't have to do anything
as an application developer. (Makes software development easy, no?)
{{% /insight %}}

## Let's look at the imported Facebook messages

Go back to the front page (click on the logo upper-left), and then click on
"Facebook message". As you would expect, that shows you all messages that our
user sent and received with Facebook Messenger.

{{% screenshot "/assets/tutorials-mesh/browsing-facebook-mock-data/messages-lisa-nelson-selected.png" %}}

For this tutorial, select a message sent by "Lisa Nelson" saying something
about rain. This shows the message, again with some metadata, one of which
is field "Thread".

{{% screenshot "/assets/tutorials-mesh/browsing-facebook-mock-data/message-lisa-nelson.png" %}}

Facebook collects messages in threads. Click that thread, and now you see
all messages that are part of this message thread.

{{% screenshot "/assets/tutorials-mesh/browsing-facebook-mock-data/message-thread.png" %}}

## Viewlets and Skins

You probably noticed that the user interface is different based on what
type of data element, aka {{% gl MeshObject %}} you are looking at. That's of
course what most web applications do, but the {{% gl mesh %}} doesn't have
a global "route" table; instead, it's a competition.

{{% insight %}}
Different types of {{% gls MeshObject %}} are rendered differently in
the user interface. We call a user interface component that knows how
to render things in a particular way a {{% gl Viewlet %}}. The part of
the user interface that remains the same is a {{% gl Skin %}}.

When you browse around data on the {{% gl mesh %}}, there is an automatic
match-making process between available {{% gls Viewlet %}} and the {{% gl MeshObject %}}
that's your current subject of interest. The best match wins, and that
{{% gl Viewlet %}} is chosen to render the current subject, inside the
current {{% gl Skin %}}.

Because there is no static "route" table, this makes adding new {{% gls Viewlet %}}
or even removing default ones very simple, and the UI very customizable.
{{% /insight %}}

But there may be other {{% gls Viewlet %}} that can also render the
current subject: click on the little "Views" link towards the top right.

{{% screenshot "/assets/tutorials-mesh/browsing-facebook-mock-data/views.png" %}}

If you select "Properties", the "Properties Viewlet" will render the
current subject instead of the "Message Thread Viewlet" that won the
competition. Depending on the type of {{% gl MeshObject %}} you are looking at,
and depending on the set of {{% gls Viewlet %}} that are available at
your installation of the {{% gl mesh %}}, the list of {{% gls Viewlet %}}
may be shorter or longer for a given {{% gl MeshObject %}}.

{{% insight %}}
As developer, you can create your own {{% gls Viewlet %}}, and they will
show up in the user interface at the right time, i.e. when they match
what the user wants to see better than any alternative {{% gls Viewlet %}}.
To add a {{% gl Viewlet %}}, not even a recompile is required.
Don't like our {{% gls Viewlet %}}? Create your own! (More about that later.)
{{% /insight %}}

{{% insight %}}
The "Properties Viewlet" (if installed) is always available to render any
{{% gl MeshObject %}}. It is the fallback if no better {{% gl Viewlet %}}
can be found, and it helps you, the developer, understand the actual
data you are looking at.

You may notice that many links in the current
version of the {{% gl mesh %}} lead to the Properties Viewlet; that's because
we don't have all that many {{% gls Viewlet %}} developed yet.
{{% /insight %}}

## Identifiers for {{% gls MeshObject %}} and URLs

Go to this {{% gl MeshObject %}}:
`http://localhost:1080/%5bfacebook.com/user/William%20Smith%5dmessage/lisanelson_mtudvy2-zq/1251261270000`.

This will bring up the specific Facebook message you looked at earlier.

{{% insight %}}
Each {{% gl MeshObject %}} has its own URL.
It's very [RESTful](https://en.wikipedia.org/wiki/Representational_state_transfer)
in the original sense of the word. You can bookmark it, e-mail it, and the like,
and it will always resolve to the same {{% gl MeshObject %}} (assuming the
user has permission to access this URL).

This URL has a one-to-one mapping with the {{% gl MeshObjectIdentifier %}} used
internally to identify  the {{% gl MeshObject %}}. So every single data element
on the {{% gl mesh %}} is effortlessly available to anybody on the web (assuming
they have permissions). No database / relational / object / web mapping
mismatches on the {{% gl mesh %}}.
{{% /insight %}}

The square brackets in the URL? We use this convention to indicate
the namespace for this {{% gl MeshObjectIdentifier %}}. More about that later.

## Next steps

If you want to deep dive in the data representation on the {{% gl mesh %}},
go to {{% pageref "propertysheet-facebook-mock-data.md" %}}.

But you can skip that, add some (mock) Google data instead, and watch
a {{% gl bot %}} connect the Facebook data and the Google data into a single,
multi-service address book, by going to {{% pageref "import-google-mock-data.md" %}}.

