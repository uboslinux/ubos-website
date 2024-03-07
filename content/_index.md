---
title: Top
layout: front
class: background
---

<style>
div.banner {
    background: #00000040;
    border-radius: 20px;
    overflow: hidden;
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    justify-content: center;
    align-items: center;
    margin-bottom: 50px;
}
</style>

<div class="banner">
 <div style="width: 320px; text-align: center">
  <img src="/images/ubos-240x240.png" alt="[UBOS]" style="margin: 34px 0 18px 0;"><br>
 </div>
 <div style="width: 638px; padding: 25px 10px 10px 10px">

UBOS is going through some major changes.<br>
Please excuse the ongoing construction.

In particular, we are moving servers: from Github to Gitlab, from Amazon S3 to
Digital Ocean. **Expect broken links** and some of the VM images are out of date.
 </div>
</div>


We are developing what we call a **Peer Computing Platform** called **UBOS**.

Peer Computing is the architectural computing pattern in which:

* always-on servers, developed and operated by different parties, communicate with each
  other as peers using symmetrical protocols;

* temporarily connected clients interact with those servers in a client-server pattern; and

* messages from user A to user B flow from A's client to A's server,
  from there to B's server, and finally to B's client.

The Peer Computing architecture has been well-established for decades: E-mail uses the
Peer Computing architecture, as well as many other systems, such as
Jabber/XMPP, Matrix and the many applications in the Fediverse like Mastodon.
[More details about Peer Computing](https://peercomputing.org/).

Other architectural patterns have their own computing platforms, such as LAMP for web-based
client server systems, or iOS/Xcode for mobile applications. As the world is moving away
from closed, single-vendor cloud applications (like traditional social media platforms),
to federated systems like the Fediverse, Peer Computing is becoming (again) highly relevent.

We believe it needs to become simpler both to develop Peer Computing systems and to operate
them. These two objectives are what UBOS is for.

UBOS is still work in progress. Some parts ({{% gl linux %}}, {{% gl gears %}}) have been
running quite reliably for various users in production for a number of years, hosted both
on public clouds and individually-owned personal servers behind the firewall. Some
others ({{% gl mesh %}}) are still some distance away from a first release.

UBOS is licensed under an OSI-certified open-source license (AGPLv3). For potential users
that do not wish to make their own code available as open-source, we are considering to
also offer a commercial license.

To learn more about UBOS, go to the [UBOS documentation](/docs/).
