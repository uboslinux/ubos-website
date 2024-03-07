---
title: Customization points section
weight: 40
---

{{% gls App %}} and {{% gls Accessory %}} may define "customization points",
which enable the user to configure the {{% gl App %}} or {{% gl Accessory %}} at deploy time.

If you invoke ``ubos-admin createsite`` and specify an {{% gl App %}} that declares one or more
required customization points, you will be asked for values for those customization points.
(If you specify ``--askForAllCustomizationPoints`` as argument, you will be asked for
values for all customization points, not just the required ones.)

Here is an example:

```
"customizationpoints" : {
  "title" : {
    "type"        : "string",
    "required"    : false,
    "default" : {
      "value" : "My wiki"
    }
  }
}
```

This {{% gl App %}}, or {{% gl Accessory %}}, declares a single customization point whose
programmatic name is ``title``. It is of type string, meaning that a value provided for it
must be a valid string. No value has to be provided by the user for this customization point,
as it is not ``required``; if none is provided, the default value "My wiki" will be used
instead.

Customization points are useful to set information such as the title of the installed
{{% gl App %}}, a logo, or settings such as whether comments should be allowed etc.

The following types of customization points are currently recognized:

* ``string``: A text string. May not contain newlines.
* ``email``: A valid e-mail address.
* ``url``: A valid URL.
* ``text``: A text string that may contain many lines.
* ``password``: A password. UBOS may enforce certain rules about password strength.
* ``boolean``: Either ``true`` or ``false``.
* ``integer``: A whole number that may be positive, negative or zero.
* ``positiveinteger``: A whole number that must be 1 or greater.
* ``positiveintegerorzero``: A whole number that must not be negative.
* ``float``: A floating-point number that may be positive, negative or zero.
* ``image``: An image in a supported file format.

The default value may be provided in encoded form. For example, a GIF image may be
provided in base64 encoding. Currently only plain (the default) and base64 encoding are
supported. To provide a default value in base64 encoding, add an ``encoding`` field like
this:

```
"default" : {
  "value" : "VUJPUw0K",
  "encoding" : "base64"
}
```

Alternatively to an explicit value, an expression may be provided, such as:

```
"default" : {
  "expression" : "${randompassword(8)}"
}
```

Customization points may be declared as private:

```
"customizationpoints" : {
  "apikey" : {
    "type"       : "string",
    "private"    : true
    ...
  }
}
```

If declared as private, only ``root`` is allowed to see the provided values.
This applies to commands such as ``ubos-admin showsite``.

Customization points may also be declared as internal:

```
"customizationpoints" : {
  "salt" : {
    "type"       : "string",
    "internal"    : true
    ...
  }
}
```

If declared as internal, it is not shown to the user as it contains no information that
may be useful for the user. This can be used for customization points that, for example,
contain salts for internally managed application passwords.

If a customization point is of type string, an optional regular expression may
be given. UBOS will enforce that any value given for the customization point conforms
to this regular expression. For example:

```
"customizationpoints" : {
  "nospaces" : {
    "type"     : "string",
    "required" : yes,
    "regex"    : "^[A-Za-z0-9]+$"
  }
}
```

allows the value ``HiMom`` but not the value ``Hi Mom``.

By default, ``ubos-admin createsite`` will ask the user for values of customization points
in an undefined sequence. To order the sequence in which the questions are asked, add
an ``index`` field whose value is an integer, and which is used for sorting.
For example:

```
"customizationpoints" : {
  "last" : {
    "type"       : "string",
    "index"      : 3
  },
  "first" : {
    "type"       : "string",
    "index"      : 1
  },
  "middle" : {
    "type"       : "string",
    "index"      : 2
  },
}
```

These customization points will be presented to the user in sequence ``first``, ``middle``,
``last``.
