---
title: Top
layout: front
---

<style>
div.banner {
    background: #fffdcc;
    border-radius: 20px;
    border: 1px solid #ffe0c0;
    overflow: hidden;
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    justify-content: center;
}

div.section {
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    justify-content: center;
    clear: both;
}

div.section div.sectioncontent {
    margin: 5px 20px;
    padding: 10px;
}

div.section-header {
    width: 100%;
    color: #808080;
    border-bottom: 2px solid #c0c0c0;
    position: relative;
    margin: 40px 0 30px 0;
    text-align: center;
}
div.section-header span {
    position: relative;
    top: 12px;
    padding: 0 10px;
    background: #fff;
}
div.section-header a {
    color: inherit;
}

ul.news-posts {
  margin: 0;
  overflow: hidden;
}
ul.news-posts > li {
    list-style: none;
    margin: 0;
}
span.news-meta {
  display: inline-block;
  width: 110px;
}

div.apps img {
    margin: 10px 10px 0 15px;
}

div.howto > div.howtoitem {
  float: left;
  width: 225px;
  min-height: 235px;
  margin: 4px;
  padding: 0 5px;
  border: 1px solid #ccc;
  border-radius: 5px;
}
div.howto h2 {
  margin-top: 5px;
  font-size: 120%;
  text-align: center;
}
div.howto pre {
  overflow-x: hidden;
}

</style>

<div class="banner">
 <div style="width: 320px; text-align: center">
  <img src="/images/ubos-160x160.png" alt="[UBOS]" style="margin: 34px 0 18px 0;"><br>
  <a href="/quickstart/">
   For PCs, Raspberry Pi's,<br>
   odroid-xu3/4, odroid-hc1/2,<br>
   ESPRESSObin, VirtualBox,<br>
   Docker and cloud
  </a>
 </div>
 <div style="width: 638px; padding: 25px 10px 10px 10px">
  <h1 class="title" style="margin: 0 0 21px 0; text-align: center">Keep your data close.</h1>

The UBOS project develops software that makes it easier for you to control your
personal data and your privacy on-line. It has several components:

**UBOS Linux** is a Linux distro that aims to make it 10x easier to
[self-host](https://en.wikipedia.org/wiki/Self-hosting_(web_services)) applications
such as Nextcloud, so you can run your own web services for youself, your friends
and your family without depending on somebody else's cloud services.

**UBOS Mesh** is middleware with a web frontend that lets you import your data from
Facebook, Google and other on-line services and use it as you wish (in development;
preview only so far).
 </div>
</div>

<div class="section news">
 <div class="section-header"><span><a href="/blog/">BLOG POSTS</a></span></div>

 <div class="sectioncontent" style="flex-grow: 2; background: #f0f6fa; border-radius: 20px; border: 1px solid #e0f0f4;">
  <ul class="news-posts">
{{% teaser-posts %}}
  </ul>
 </div>

 <div class="sectioncontent" style="flex-grow: 1; border-radius: 20px; background: #f0f0f0">
  <p style="margin: 0; padding: 0">Subscribe to announcements:</p>
  <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.2/jquery.min.js"></script>
  <script type="text/javascript" src="https://s3.amazonaws.com/phplist/phplist-subscribe-0.2.min.js"></script>
  <script type="text/javascript">
var pleaseEnter = "Your e-mail";
var thanksForSubscribing = '<div class="subscribed">Thanks for <a href="https://indiecomputing.hosted.phplist.com/lists/?p=unsubscribe&id=4">subscribing</a>.</div>';
  </script>
  <div style="display: flex">
   <div id="phplistsubscriberesult"></div>
   <form action="https://indiecomputing.hosted.phplist.com/lists/?p=subscribe&id=4" method="post" id="phplistsubscribeform" style="width: 100%">
    <input type="text" name="email" value="" id="emailaddress" style="width: 100%; border: 1px solid #c0c0c0"/>
    <button type="submit" id="phplistsubscribe" style="text-align: center">Subscribe</button>
   </form>
  </div>
 </div>

 <div class="feeds sidenote">
  <a href="/blog/">More news</a> &mdash;
  Follow UBOS:
  <a href="/index.xml">RSS</a>
  • <a href="https://mastodon.social/@ubos">Mastodon</a>
  • <a href="https://twitter.com/uboslinux">Twitter</a>
  • <a href="https://www.facebook.com/uboslinux">Facebook</a>
  • <a href="https://www.youtube.com/channel/UCFv32pjDjv49l5EWAZQhw8A/playlists">YouTube</a>
  • <a href="/survey"><b>Survey</b></a>
 </div>
</div>

<div class="section apps">
 <div class="section-header"><span><a href="/apps/" style="color: inherit">APPS</a></span></div>
 <a href="/apps/" title="Nextcloud: A safe home for all your data">
  <img src="/images/nextcloud-72x72.png" alt="[Nextcloud]">
 </a>
 <a href="/apps/" title="Mastodon: Decentralized microblogging">
  <img src="/images/mastodon-72x72.png" alt="[Mastodon]">
 </a>
 <a href="/apps/" title="Mattermost: Slack alternative">
  <img src="/images/mattermost-72x72.png" alt="[Mattermost]">
 </a>
 <a href="/apps/" title="Known: publishing platform for everyone">
  <img src="/images/known-72x72.png" alt="[Known]">
 </a>
 <a href="/apps/" title="Wordpress: blog tools, publishing platform, and CMS">
  <img src="/images/wordpress-72x72.png" alt="[Wordpress]">
 </a>
 <a href="/apps/" title="Mediawiki: the wiki that Wikipedia runs on">
  <img src="/images/mediawiki-72x72.png" alt="[Mediawiki]">
 </a>
 <a href="/apps/" title="Selfoss: multipurpose rss reader, live stream, mashup, aggregation web application">
  <img src="/images/selfoss-72x72.png" alt="[Selfoss]">
 </a>
 <a href="/apps/" title="Shaarli: your own URL shortener">
  <img src="/images/shaarli-72x72.png" alt="[Shaarli]">
 </a>
 <a href="/apps/" title="UBOS Personal Data Mesh">
  <img src="/images/ubos-mesh-72x72.png" alt="[UBOS Mesh]">
 </a>
 <a href="/apps/" title="Webtrees: collaborative genealogy application">
  <img src="/images/webtrees-72x72.png" alt="[Webtrees]">
 </a>
</div>
<p class="sidenote" style="float: right; margin: 0;">... and <a href="/apps/">others</a>.</p>

<div class="section howto">
 <div class="section-header"><span>HOWTO</span></div>
 <div class="howtoitem">
  <h2>Run UBOS</h2>
  <ul>
   <li>on an x86 PC (64bit)
       (<a href="/docs/administrators/installation/x86_bootstick/">bootstick</a>,
       <a href="/docs/administrators/installation/x86_disk/">hard drive</a>,
       <a href="/docs/administrators/installation/x86_container/">container</a>,
       <a href="/docs/administrators/installation/x86_virtualbox/">VirtualBox</a>,
       <a href="/docs/administrators/installation/x86_docker/">Docker</a>)
       or cloud (<a href="/docs/administrators/installation/x86_ec2/">EC2</a>).</li>
   <li>on a Raspberry Pi&nbsp;0, 1 (<a href="/docs/administrators/installation/raspberrypi/">SDCard</a>,
       <a href="/docs/administrators/installation/armv6h_container/">container</a>) or
       Pi&nbsp;2, 3 (<a href="/docs/administrators/installation/raspberrypi2/">SDCard</a>,
       <a href="/docs/administrators/installation/armv7h_container/">container</a>) or
       Pi&nbsp;4 (<a href="/docs/administrators/installation/raspberrypi4/">SDCard or USB disk</a>,
       <a href="/docs/administrators/installation/armv7h_container/">container</a>)</li>
   <li>on an Odroid-XU4, HC2 (<a href="/docs/administrators/installation/odroid-xu3/">SDCard</a>,
       <a href="/docs/administrators/installation/armv7h_container/">container</a>)</li>
   <li>on a Marvell ESPRESSObin (<a href="/docs/administrators/installation/espressobin/">SDCard</a>,
       <a href="/docs/administrators/installation/espressobin/">hard drive</a>,
       <a href="/docs/administrators/installation/aarch64_container/">container</a>).</li>
  </ul>
 </div>
 <div class="howtoitem">
  <h2>Install an App</h2>
  <pre># ubos-admin createsite
Hostname: <i>ubos-pc.local</i>
App: <i>nextcloud</i>...</pre>
  <p>Code installed, database provisioned, virtual host configured...</p>
 </div>
 <div class="howtoitem">
  <h2>Upgrade everything</h2>
  <pre># ubos-admin update
Done.</pre>
  <p>OS updated, apps upgraded, database migrations performed, services restarted...</p>
 </div>
 <div class="howtoitem">
  <h2>Backup &amp; restore</h2>
  <pre># ubos-admin backup \
   --all --backuptofile \
  all.ubos-backup
# ubos-admin restore \
  --in all.ubos-backup</pre>
  <p>Plenty of options for more fine-grained control.</p>
 </div>
</div>

<p style="text-align: center; margin-top: 20px">
 <a href="/quickstart/" class="get-started-button">Get started!</a>
</p>
