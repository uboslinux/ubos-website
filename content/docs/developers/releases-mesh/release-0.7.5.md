---
title: Release Notes 0.7.5
date: 2022-06-02
---

These are the first release notes for the UBOS Personal Data Mesh!
It must mean that the codebase is getting more stable and more useful!
(It does.)

## Summary

This release adds major new functionality related to importers that makes
developers' lives easier.

## How to run
### Availability

* On the UBOS `red` channel, `x86_64` only.
* In git at https://gitlab.com/ubos, branch `develop`.

### To update

It's recommended to undeploy your UBOS Mesh-based application, redeploy,
and re-convert and re-import data, with commands such as:

```
# ubos-admin showsite --json > mysite.json
# ubos-admin undeploy --all
# ubos-admin update
# ubos-admin deploy --file mysite.json
```
and then run `mesh-converter`, `mesh-differencer` and `mesh-peertalk`
to re-convert and re-import.

### To run for the first time

If you have not run UBOS Mesh before, follow the {{% pageref "/docs/developers/tutorials-mesh/" %}},
and before you execute the first command in the container, run:

```
# sudo ubos-admin update
```

## What's new

### New framework: `importer-handler`

If you are writing a new importer for some data source, an entirely new
importer framework, called the `importer-handler` framework, is now available.
This is an addition, and does not conflict with or replace previously existing
functionality.

This new framework specifically makes it easier to develop, and maintain,
importers that import "compound" files, such as ZIP files, or directory
hierarchies, that contains individual data files (like JSON, or CSV, or
others) with different formats. For example, Facebook provides a single ZIP
file containing many JSON files, one or more for each of their products.
It is similar for Google and Amazon.

The new `importer-handler` framework enables developers:

* To develop importers gradually: instead of having to write code,
  for example, that understands the often more than 100 different files
  with almost as many types exported by a company like Amazon, a developer can
  focus on those parts of the data set they are most interested in,
  and let the framework handle the rest.

* The `importer-handler` framework knows how to import many common file
  types generically (like JSON, CSV, VCard, blob files). This list of generic
  file types is open-ended and can be extended by developers. Of course a generic
  importer cannot understand the semantics of what, say, a given CSV file attempts
  to express, but it can parse the structure and import that data into
  UBOS Mesh as non-typed {{% gls MeshObject %}} (using {{% gls Attribute %}}
  and {{% gls RoleAttribute %}} rather than {{% gls EntityType %}},
  {{% gls PropertyType %}} and {{% gls RoleType %}}).

The new `importer-handler` framework also makes importers much better at
"fuzzy matching" of importers to data sources. This is necessary because:

* Companies change their data export files all the time; sometimes minor,
  sometimes dramatically, and always without announcing it :-(. If we were
  to write importers with hard and fast rules about what is expected and
  what not, the success rate of importing a given file would drop
  dramatically. Instead, we want to deteriorate gradually and be able
  to import files that have content, or structures, we didn't exactly
  expect, at the cost of not getting everything but getting most.

* We don't necessarily want rely on the user to specify the correct
  importer with a given data source, and would like to take educated
  guesses instead.

### Migration of existing importers

The existing importers (Facebook, Google, Amazon) have been migrated
to the new `importer-handler` framework, and as a result, these importers
are now much more maintainable, understandable, and incrementally enhanceable.

They can also -- magically -- import much more data even for those parts of
import files no specific parser has been written for. While being smaller in
terms of code size :-)

### New options for `mesh-converter`

The `mesh-converter` executable has gained several new options to aid
importer developers. Specifically:

* ``--explain`` will explain why a particular importer was chosen for
  a given data file.

* ``--analyze`` will match the expectations of a given importer against
  the content of a compound import file, and explain where they match or
  do not. This enables a developer, for example, to quickly find out
  which parts of their importer need to be updated for a new version of
  an export file.

* ``--statistics`` will emit some statistical information about the
  {{% gls MeshObject %}} created by the import, such as the most
  used {{% gl EntityType %}}, the most-connected (into the graph)
  {{% gl MeshObject %}} and the like. This is useful for developers to
  have some idea what their importer actually produces for a real-world
  data file, without having to look into the `.mesh` file itself.

## Known issues

* No corresponding changes have been made to the UI yet. It can be a bit
  difficult to actually "see" the newly imported data.
* Because the importers are more capable, they import more data. This
  causes `mesh-converter` and other tools to take longer to run and
  require more RAM and storage.
