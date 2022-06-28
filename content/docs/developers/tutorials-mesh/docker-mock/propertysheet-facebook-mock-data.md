---
title: Deep-dive into data representation with the Property Sheet Viewlet (OPTIONAL)
breadcrumbtitle: Deep-dive with the Property Sheet Viewlet
weight: 50
---

## Introduction

In this section, we will use the Property Sheet Viewlet:

* to look at some {{% gls MeshObject %}} in detail,

* and do a deep dive on how data is represented on the {{% gl mesh %}}.

This tutorial assumes you have successfully imported the mock Facebook
data as described in {{% pageref "import-facebook-mock-data.md" %}}.

## Understanding what's shown on a Property Sheet Viewlet

Open up the message from Lisa Nelson in the precending section again
(its URL is
`http://localhost:1080/%5bfacebook.com/user/William%20Smith%5dmessage/lisanelson_mtudvy2-zq/1251261270000`).

Click on "Views" and select "Properties".

{{% screenshot "/assets/tutorials-mesh/propertysheet-facebook-mock-data/views.png" %}}

After the "Property Sheet Viewlet" has come up, look at the URL in your browser.
You may notice that the URL is the same as before, but with an extra argument.
This extra argument indicates that we want top use a different
{{% gl Viewlet %}} than the default, in this case the "Property Sheet Viewlet".

The "Property Sheet Viewlet" is both the most inscrutable, and
the most useful {{% gl Viewlet %}} for developers, because it shows you
how data is natively represented on the {{% gl mesh %}}. Think of it
as the assembly language view of personal data.

Let's examine it section by section:

### The header area

The headline shows the {{% gl MeshObjectIdentifier %}} as the headline.

{{% screenshot "/assets/tutorials-mesh/propertysheet-facebook-mock-data/header.png" %}}

{{% insight %}}
Each {{% gl MeshObject %}} has a unique {{% gl MeshObjectIdentifier %}}, which
is immutable over the lifetime of the {{% gl MeshObject %}}. It is generally
mapped directly to the URL in the browser that accesses that {{% gl MeshObject %}}.
{{% /insight %}}

To the right, we have the times the {{% gl MeshObject %}} was created and last updated.
These two values are automatically maintained by the {{% gl mesh %}}.

{{% insight %}}
The {{% gl mesh %}} keeps track when each {{% gl MeshObject %}} was created
and last updated.
{{% /insight %}}

### EntityTypes and Properties section

Let's define two terms first:

{{% insight %}}
An {{% gl EntityType %}} for a {{% gl MeshObject %}} is similar to what a class
is to an instance in programming: it defines some semantics, and typically
a structure.

An {{% gl EntityType %}} may define one or more {{% gls PropertyType %}}, similar
to how members (or fields) are defined by a class. Each {{% gl PropertyType %}} has a name,
and comes with rules about what values a {{% gl MeshObject %}} can hold in
that property. However, compared to a typical programming language, {{% gls PropertyType %}}
can define far more detail about what values are permitted. For example, an
integer {{% gl PropertyType %}} can specify permitted minimum and maximum values,
like 5 or 7.
(More about this later).

All {{% gls MeshObject %}} blessed with an {{% gl EntityType %}} will have
one slot for each {{% gl PropertyType %}} defined by that {{% gl EntityType %}},
as you would expect in analogy with classes, members and instances.
{{% /insight %}}

This section in the Property Sheet {{% gl Viewlet %}} shows the
{{% gl MeshObject %}}'s {{% gls EntityType %}}: here the {{% gl EntityType %}} is
"Facebook message".

{{% screenshot "/assets/tutorials-mesh/propertysheet-facebook-mock-data/entitytypes.png" %}}

In the rows below, each of the {{% gls PropertyType %}} of "Facebook message"
is listed, with the value that this {{% gl MeshObject %}} carries for each
{{% gl PropertyType %}}. This is how this "Facebook message" object carries
the content of the message, the subject (which is not set in this case)
and other fields.

If you hover over "Facebook message" or any of the names of the
{{% gls PropertyType %}}, a tool tip will show you the {{% gl MeshTypeIdentifier %}},
which is a unique identifier for this particular {{% gl MeshType %}}. You often
use {{% gls MeshTypeIdentifier %}} in programming to refer to the {{% gl MeshType %}}
you mean. What's shown here are the fully-qualified names: they come with scope,
because {{% gls Model %}} -- which is where {{% gls EntityType %}},
{{% gls PropertyType %}} etc are defined -- can be defined by developers like you,
and name conflicts would be a bad idea.

### Attributes section

This section is empty for this {{% gl MeshObject %}}.

{{% screenshot "/assets/tutorials-mesh/propertysheet-facebook-mock-data/attributes.png" %}}

{{% insight %}}
{{% gls Attribute %}} are a free-form version of {{% gls PropertyType %}}:
you can arbitrarily add {{% gls Attribute %}}
to any {{% gl MeshObject %}} and there are (almost) no rules about values
for them.
{{% /insight %}}

There are useful for prototyping, and attaching short-lived information
to {{% gls MeshObject %}}.

If you like, you can click on the little + next to "Attribute name" and
set an {{% gl Attribute %}} with some name and String value right there.

In fact, if you hadn't noticed, you can change most data on the {{% gl mesh %}}
right there from the Property Sheet Viewlet. This makes development quite
simple, too, because you can easily try out how your code is behaving with
different data values that you can enter right in the GUI without writing
any new code.

{{% insight %}}
All information on the {{% gl mesh %}} is can be edited by the user
(if the current {{% gl Viewlet %}} provides a UI for it; the Property
Sheet does.)
{{% /insight %}}

### RoleTypes and RoleProperties section

Note that there is more than one table in this section. Each table has
a headline saying "Neighbor" and a clickable {{% gl MeshObjectIdentifier %}}.

{{% screenshot "/assets/tutorials-mesh/propertysheet-facebook-mock-data/roletypes.png" %}}

This section shows you how the current {{% gl MeshObject %}} is related
to other {{% gls MeshObject %}}: we call them neighbors (in a graph).
You can click the neighbor and thus traverse to it.

Below each neighbor, the type of relationship with this neighbor is
shown. Distinguishing types of relationships, and their direction is useful:
it lets us distinguish, for example, whether Alice and Bob, if they are neighbors
in the graph, "love" or "hate" each other, or that Alice is Bob's landlord.
All of them would be examples of relationship types.

In many ways, the concept of relationship type is to a pair of
{{% gls MeshObject %}} what an {{% gl EntityType %}} is for a single
{{% gl MeshObject %}}: it defines the semantics of the relationship,
and potentially a structure. So the layout in the Property Sheet
{{% gl Viewlet %}} is rather similar.

It's important to not mix up a relationship's direction. There is a big
difference whether Alice is the landlord of Bob, or Bob is the landlord
of Alice! So instead of relationship types, we typically use the concept
of a {{% gl RoleType %}}. A relationship type is made up of two {{% gls RoleType %}},
which you can think of as the source and the destination of the relationship type.
By using a {{% gl RoleType %}}, instead of the relationship type, in the API
and in the user interface, we know not only what relationship type is meant,
but also which direction.

Going back to the Property Sheet Viewlet, the name of the {{% gl RoleType %}} is
preceded by an arrow that either points forward or backward. It indicates how
the relationship is directed.

Remember that the current {{% gl MeshObject %}} is a Facebook message.
Here "=> created by" means that the current message was "created by"
this particular neighbor {{% gl MeshObject %}}. (If you click through to
the neighbor, you see it is a "Facebook account", meaning that this
particular message was created by that particular Facebook account.)

In the second table in this section, the arrow points the other way,
meaning it should be read the opposite way. The neighbor {{% gl MeshObject %}}
here is a "Facebook message thread", and so the relationship reads
"This facebook message thread (the neighbor) collects this message".

{{% insight %}}
{{% gls MeshObject %}} can have (any number of) neighbor {{% gls MeshObject %}}.
The connection between them may be blessed with one or more {{% gls RoleType %}},
which indicate the semantics and the direction of the relationship.

Like {{% gls EntityType %}}, {{% gls RoleType %}} can define
{{% gls PropertyType %}} (and {{% gls RoleAttribute %}} see next section),
which allow you to attach values to the relationship between two
{{% gls MeshObject %}}. (This is somewhat uncommon, but very handy when needed.)
{{% /insight %}}

### Role Attributes section

Finally, {{% gls RoleAttribute %}} are to {{% gls RoleProperty %}}
as {{% gls Attribute %}} are to {{% gls Property %}}.

{{% screenshot "/assets/tutorials-mesh/propertysheet-facebook-mock-data/roleattributes.png" %}}

{{% insight %}}
{{% gls RoleAttribute %}} are a free-form version of {{% gls PropertyType %}}
on {{% gls RoleType %}}: you can arbitrarily add {{% gls RoleAttribute %}}
to any pair of {{% gls MeshObject %}} and there are (almost) no rules
about values for them.
{{% /insight %}}

There are useful for prototyping, and attaching short-lived information
to {{% gls MeshObject %}}.

## Next step

Let's add some (mock) Google data, and watch a {{% gl bot %}} connect the
Facebook data and the Google data into a single, multi-service address book,
by going to {{% pageref "import-google-mock-data.md" %}}.


