---
title: Getting your personal data from Facebook, Google and Amazon
weight: 10
---

## Introduction

In this section, you will download your personal data from one or more
of the companies whose export files the {{% gl mesh %}} knows to parse
at this time.

This process takes time. Depending on the company, it may be hours,
or weeks, so you want to do this some time before you actually want
to work through the rest of this tutorial.

## Getting your data

### Facebook

Log into your Facebook account with a web browser on a PC (not mobile),
and then go to [facebook.com/dyi](https://facebook.com/dyi).

In the first section, select JSON format, the media quality you want
(for this tutorial, "low" is fine) and the time range ("all"), like this:

{{% screenshot "/assets/tutorials-mesh/facebook-export/format.png" %}}

Scrolling further down, there are many categories of data you might want
to export. {{% gl mesh %}} only understands some of them at this point,
but it does not hurt if you export them all. Then, start your download:

{{% screenshot "/assets/tutorials-mesh/facebook-export/start-your-download.png" %}}

Facebook will notify you by e-mail when the data files are available.
Download them to the computer on which you will run this tutorial.

{{% note %}}
The {{% gl mesh %}} needs the files in the format provided by Facebook,
so do not uncompress them.
{{% /note %}}

### Google

Log into your Google account with a web browser on a PC (not mobile),
then go to [takeout.google.com](https://takeout.google.com/).

In the first section, there are many categories of data you might want
to export. {{% gl mesh %}} only understands some of them at this point,
but it does not hurt if you export them all. Select them, like this,
and go to the next step.

{{% screenshot "/assets/tutorials-mesh/google-export/select-data.png" %}}

Then, specify "download link via email" as delivery method, the ".zip"
file type, and set the file size to the largest number they offer.
The {{% gl mesh %}} currently does not know yet how to process Google
export files that have been broken up into several pieces.

{{% screenshot "/assets/tutorials-mesh/google-export/delivery-method.png" %}}

After clicking "Create export", wait for the e-mail from Google to arrive.
Download the created files to the computer on which you will run this tutorial.

{{% note %}}
The {{% gl mesh %}} needs the files in the format provided by Google,
so do not uncompress them.
{{% /note %}}

### Amazon

Log into your Amazon account with a web browser on a PC (not mobile),
then go to [www.amazon.com/gp/privacycentral/dsar/preview.html](https://www.amazon.com/gp/privacycentral/dsar/preview.html).

In the popup, select "Request All Your Data", like this:

{{% screenshot "/assets/tutorials-mesh/amazon-export/request.png" %}}

After you submitted your request, click the confirmation link in the
e-mail Amazon will send to you, and then follow the instructions for
how to download your files when they have made it available.

{{% note %}}
Amazon provides a long list of separate files that you need to download
separately. Create a separate, initially empty directory for those files, and
download them into that directory. Do not store any other files in that
directory.

The {{% gl mesh %}} needs the files in the format provided by Amazon,
so do not uncompress them.
{{% /note %}}

## Next steps

Once you have donwloaded at least one of the data export files,
proceed to {{% pageref "running.md" %}}.

