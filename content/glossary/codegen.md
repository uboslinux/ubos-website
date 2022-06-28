---
title: UBOS Mesh code generator
summary: The UBOS Mesh code generator
domain: UBOS Mesh
---

This code generator takes {{% gl mesh %}} {{% gl model %}} files, and
generates Java code that:

* instantiates those model files, making loading models faster than having
  to parse them from XML; also, model checking can be performed already during code
  generation, and not only at runtime;
* generates Java contants like `Person.FIRSTNAME`, to make programming easier.

