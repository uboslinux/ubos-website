---
title: An Accessory for Glad-I-Was-Here (PHP, MySQL)
weight: 30
---

## Introduction

To demonstrate how {{% gls Accessory %}} work, we created a simple plugin for the
{{% pageref gladiwashere-php-mysql.md "PHP/MySQL version" %}} that adds a footer to
the Glad-I-Was-Here front page.

If you have not already read through {{% pageref gladiwashere-php-mysql.md %}},
we recommend you do so first as we'll only discuss things in this section that were
not covered before.

To obtain the source code:

```
% git clone https://github.com/uboslinux/ubos-toyapps
```

Go to subdirectory ``gladiwashere-php-mysql-footer``.

## Package lifecycle and App deployment

Like all other {{% gls App %}} and {{% gls Accessory %}} on UBOS including
{{% pageref helloworld.md %}}`, ``gladiwashere-php-mysql-footer`` is built
with ``makepkg``, installed with ``pacman`` and deployed with ``ubos-admin``:

```
% makepkg -f
% sudo pacman -U gladiwashere-php-mysql-footer-*-any.pkg.tar.xz
% sudo ubos-admin createsite
```

Specify ``gladiwashere-php-mysql`` as the name of the {{% gl App %}}, and then
specify ``gladiwashere-php-mysql-footer`` as the (only) {{% gl Accessory %}}.

## Manifest JSON

Let's examine this {{% gl Accessory %}}'s {{% gl UBOS_Manifest %}} file. It is
similar to an {{% gl App %}}'s, but much simpler (that is common for
{{% gls Accessory %}}. It also has an extra entry ``accessoryinfo`` entry that
relates the {{% gl Accessory %}} to the {{% gl App %}} it belongs to:

```
{
    "type"  : "accessory",

    "accessoryinfo" : {
        "appid"         : "gladiwashere-php-mysql",
        "accessoryid"   : "footer"
    },

    "roles" : {
        "apache2" : {
            "appconfigitems" : [
                {
                    "type" : "file",
                    "name" : "footer.php",
                    "template"     : "tmpl/footer.php.tmpl",
                    "templatelang" : "varsubst"
                }
            ]
        }
    },
    "customizationpoints" : {
        "message" : {
            "name"     : "message",
            "type"     : "string",
            "required" : true
        }
    }
}
```

The ``apache2`` role functions just like in case of an {{% gl App %}}. It takes file
``tmpl/footer.php.tmpl`` from the code base, and putx it into the root directory of
the {{% gl App %}}'s deployment as ``footer.php`` after having replaced variables in it.

What variables? Well, this template file reads as follows:

```
<div class="footer">
 <hr/>
 <h4>Footer, from the <tt>gladiwashere-php-mysql-footer</tt> accessory.</h4>
 <p>Message you entered as customization point: &quot;${installable.customizationpoints.message.value}&quot;</p>
 <hr/>
</div>
```

You see the variable ``${installable.customizationpoints.message.value}``, which refers
to the value of customization point ``message``. If you deployed the {{% gl Accessory %}}
with ``ubos-admin createsite``, it will have asked you for the value of this
{{% gl Customization_Point %}}, and the value you provided will be inserted.

Which brings us to the last part of the manifest: the declaration of that
{{% gl Customization_Point %}} with data type ``string``.

Note that both {{% gls App %}} and {{% gls Accessory %}} may (or may not)
have any number of {{% gls Customization_Point %}}. {{% gls Customization_Point %}}
are not special to {{% gls Accessory %}}, it's just the first place in the example
{{% gls App %}} where we have used one.
