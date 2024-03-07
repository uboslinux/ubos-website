---
title: Functions that may be applied to variables
weight: 80
---

Often, a variable cannot be used as-is, but needs to be processed slightly.

For example, before a text string can be inserted into PHP, possible quotes in
the text string need to be escaped. If a blogging {{% gl App %}} defines a
{{% gl Customization_Point %}} called ``title``, and a user provides
the value ``Bob's Greatest`` in their {{% gl Site_JSON %}} for it, a hypothetical
PHP configuration file for this {{% gl AppConfiguration %}} should read as follows:

```
$blogTitle = 'Bob\'s Greatest';
```

to avoid syntax errors. To accomplish this, the developer would use the following
line in their template file:

```
$blogTitle = '${escapeSquote( installable.customizationpoints.title.value) }';
```

instead of:

```
$blogTitle = '${installable.customizationpoints.title.value}';
```

See also {{% pageref variables.md %}}.

{{% note %}}
Currently, the implementation of functions on those variables is rudimentary.
Only a single function may be used; they may not be nested or concatenated.
{{% /note %}}

The following functions are currently available:

``base64encode``
: Base64-encode the value.

``base64decode``
: Base64-decode the value.

``cr2space``
: Convert all newlines to spaces. This is useful to convert a multi-line string
  into a single-line string.

``escapeSquote``
: Prepend all single quotes in the string with a backslash, so
  ``abc'def`` becomes ``abc\'def``. This is useful in configuration files where
  values need to be specified as quoted strings, e.g. in PHP.

``escapeDquote``
: Prepend all double quotes in the string with a backslash, so
  ``abc"def`` becomes ``abc\"def``. This is useful in configuration files where
  values need to be specified as quoted strings, e.g. in PHP.

``gid``
: Lookup the numerical group id from the name of the Linux group. For example,
  ``git( installable.customizationpoints.user.value )``, if customization point
  ``user`` was ``root``, would result in the value ``0``.

``trim``
: Remove leading and trailing white space from a string.

``uid``
: Lookup the numerical user id from the name of a Linux user. For example,
  ``git( installable.customizationpoints.user.value )``, if customization point
  ``user`` was ``root``, would result in the value ``0``.
