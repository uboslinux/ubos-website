---
title: "Static website hosting with rsync-based upload: docroot"
weight: 20
---

``docroot`` is a simple but quite useful web {{% gl App %}} for static file hosting.
It is useful if:

* You manually edit all HTML files of your website, and your {{% gl Site %}} does not
  need to run any kind of server-side scripts.

* You use a static website generator such as [Jekyll](https://jekyllrb.com/),
  [Sphinx](http://www.sphinx-doc.org/) or [Hugo](https://gohugo.io/).

* You can run PHP scripts simply by uploading them, but there is no server-side
  infrastructure (like a database) for them. However, they can access whatever local
  files have been uploaded.

For example, the UBOS website at ``ubos.net`` runs ``docroot`` at the root of the {{% gl Site %}},
as all of its content is statically generated.

Here is how to use ``docroot``:

1. On your computer (not the UBOS {{% gl Device %}}), pick, or create an SSH key pair
   that will be used to securely upload your content to your to-be-created {{% gl Site %}}.
   This can be the same key pair that you use with your {{% gl UBOS_Staff %}}, or a different
   key pair. For more info about SSH and how to create an SSH key pair, see
   {{% pageref "/docs/administrators/faq-howto-troubleshooting/howto-ssh.md" %}}.

2. You create a {{% gl Site %}} at which to run ``docroot``, using ``ubos-admin createsite``
   on your UBOS {{% gl Device %}}. Specify ``docroot`` for the {{% gl App %}}, and any
   {{% gl Context_Path %}} you wish. ``ubos-admin createsite`` will then ask you for the
   filename of a public key. Enter the path to that file (usually called
   ``id_rsa.pub``).

3. After ``ubos-admin createsite`` is complete, you can now securely upload data to your
   new static {{% gl Site %}}, using ``rsync`` over ``ssh``, which is the most efficient and secure
   method we could think of.

4. You need only one more piece of information, which is the {{% gl AppConfigId %}} of the
   deployment of ``docroot`` that you just created. (This is necessary so UBOS knows which one you
   are talking about, in case you have more than one installation of ``docroot`` on the same
   {{% gl Device %}}.) You determine it by executing on your UBOS {{% gl Device %}}:

   ```
   % ubos-admin listsites --detail
   ```

Look for the name of the {{% gl Site %}} you just created, and the {{% gl AppConfiguration %}}
that runs ``docroot``. It will also show you the {{% gl AppConfigId %}} (a long hexadecimal
number starting with ``a``).

To upload a file, or an entire directory hierarchy of files with your default SSH keypair, use
this command:

```
% rsync -rtlvH --delete-after --delay-updates --safe-links -e ssh <FROM> docroot@<HOST>:<APPCONFIGID>/
```

where ``<FROM>>`` is the local file or directory to upload, ``<HOST>`` is the name of the
UBOS device to upload to, and ``<APPCONFIGID>`` the {{% gl AppConfigId %}} you just determined.
Note that the destination path in this command is not the usual path to the file on the remote
{{% gl Device %}}, but the {{% gl AppConfigId %}} (plus potentially a local path from there):
``docroot`` will figure out the absolute path.

If you want to use a non-default SSH keypair, you need to add which to the command, so the
command becomes:

```
% rsync -rtlvH --delete-after --delay-updates --safe-links -e 'ssh -i <PRIVKEY>' <FROM> docroot@<HOST>:<APPCONFIGID>/
```

where ``<PRIVKEY>`` is the name of the file that contains the private key.

Admittedly, this command is a handful, so let's unpack this:

* ``rsync``: we use the ``rsync`` command for uploading, as it is smart and can intelligently
  skip everything you uploaded before, by just transferring data that is new or has changed since
  the last upload. This is particularly useful for the many static websites where only little
  content changes from upload to upload.

* ``-rtlvH``: tell ``rsync`` to recursively upload an entire directory hierarchy, and things
  like that.

* ``--delete-after``: tell ``rsync`` to delete files that were previously uploaded but don't
  exist locally on your computer any more.

* ``--delay-updates``: useful for long uploads; tell ``rsync`` to do the actual update of
  the website in one swoop at the end of the upload, instead of incrementally as files arrive
  one by one.

* ``--safe-links``: in case you are using symlinks, keep those links intact during the upload
  as long as they are safe.

* ``-e ssh``: tell rsync to transfer data over ``ssh``. This encrypts all uploaded data,
  and uses SSH access control so only you can upload to your {{% gl Site %}}, because only
  you have access to your SSH private key. This uses your default SSH private key.

* ``-e 'ssh -i <PRIVKEY>``: instead of using the default SSH private key, use the private
  key contained in file ``<PRIVKEY>``.

If you execute this command regularly, you may want to create an alias or script for it
on your local computer.

As soon as the ``rsync`` command is complete, when you visit the URL at which you installed
``docroot``, your content should be displayed in your web browser.
