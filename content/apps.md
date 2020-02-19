---
title: Apps on UBOS
---

Currently available apps (alphabetically):

<img src="/images/amazonses-72x72.png" alt="[Amazon SES]" class="apps-icon">
**Amazon SES**: Send e-mail via Amazon's Simple E-mail Service (SES).<br>
Install with `sudo ubos-admin createsite`, specify app `amazonses`<br>

<img src="/images/docroot-72x72.png" alt="[Docroot]" class="apps-icon">
**Docroot**: Static file hosting with SSH-based upload<br>
Install with `sudo ubos-admin createsite`, specify app `docroot`<br>

<img src="/images/mediawiki-72x72.png" alt="[Mediawiki]" class="apps-icon">
**Mediawiki**: The wiki that Wikipedia runs on<br>
Install with `sudo ubos-admin createsite`, specify app `mediawiki`

<img src="/images/nextcloud-72x72.png" alt="[Nextcloud]" class="apps-icon">
**Nextcloud**: A safe home for all your data<br>
Install with `sudo ubos-admin createsite`, specify app `nextcloud`

<img src="/images/redirect-72x72.png" alt="[Redirect]" class="apps-icon">
**Redirect**: Redirects to another site<br>
Install with `sudo ubos-admin createsite`, specify app `redirect`

<img src="/images/wordpress-72x72.png" alt="[Wordpress]" class="apps-icon">
**Wordpress**: Blog tools, publishing platform, and CMS<br>
Install with `sudo ubos-admin createsite`, specify app `wordpress`

<br>

Available in beta ("yellow" release channel only):

<img src="/images/decko-72x72.png" alt="[Decko]" class="apps-icon">
**Decko**: Dynamic websites from creatively organized cards<br>
Install with `sudo ubos-admin createsite`, specify app `decko`

<img src="/images/known-72x72.png" alt="[Known]" class="apps-icon">
**Known**: Indieweb publishing platform for everyone<br>
Install with `sudo ubos-admin createsite`, specify app `known`

<img src="/images/mastodon-72x72.png" alt="[Mastodon]" class="apps-icon">
**Mastodon**: Free, open-source, decentralized microblogging network<br>
Install with `sudo ubos-admin createsite`, specify app `mastodon`

<img src="/images/matomo-72x72.png" alt="[Matomo]" class="apps-icon">
**Matomo**: Open web analytics platform<br>
Install with `sudo ubos-admin createsite`, specify app `matomo`

<img src="/images/mattermost-72x72.png" alt="[Mattermost]" class="apps-icon">
**Mattermost**: Open source, self-hosted Slack-alternative<br>
Install with `sudo ubos-admin createsite`, specify app `mattermost`

<img src="/images/phpbb-72x72.png" alt="[phpBB]" class="apps-icon">
**phpBB**: Bulletin-board<br>
Install with `sudo ubos-admin createsite`, specify app `phpbb`

<img src="/images/river-72x72.png" alt="[River5]" class="apps-icon">
**River5**: A river-of-news RSS aggregator<br>
Install with `sudo ubos-admin createsite`, specify app `river`

<img src="/images/selfoss-72x72.png" alt="[Selfoss]" class="apps-icon">
**Selfoss**: Multipurpose rss reader, live stream, mashup, aggregation web application<br>
Install with `sudo ubos-admin createsite`, specify app `selfoss`

<img src="/images/shaarli-72x72.png" alt="[Shaarli]" class="apps-icon">
**Shaarli**: Personal, minimalist, super-fast, bookmarking service<br>
Install with `sudo ubos-admin createsite`, specify app `shaarli`

<img src="/images/webtrees-72x72.png" alt="[Webtrees]" class="apps-icon">
**Webtrees**: Full-featured web genealogy app<br>
Install with `sudo ubos-admin createsite`, specify app `webtrees`

## Accessories

Some apps have accessories, which you an install in order to add functionality or styling
to the app. To install, list the name(s) of the accessories when asked as you execute
`sudo ubos-admin createsite`:

**Known**

   * `known-plugin-linkedin`: integrate your Known with LinkedIn
   * `known-plugin-wordpress`: integrate your Known with WordPress

**Mediawiki**

   * `mediawiki-ext-confirmaccount`: cut down on wiki spam by making registration harder

**Nextcloud**

   Additional features:

   * `nextcloud-bookmarks`: bookmark management
   * `nextcloud-calendar`: calendaring
   * `nextcloud-contacts`: contact management
   * `nextcloud-deck`: kanban style organization tool aimed at personal planning and
     project organization for teams
   * `nextcloud-files-rightclick`: adds a right click menu
   * `nextcloud-group-everyone`: adds a virtual "everyone" group
   * `nextcloud-groupfolders`: admin configured folders shared by everyone in a group
   * `nextcloud-markdown`: markdown support
   * `nextcloud-news`: news reader
   * `nextcloud-notes`: note taking
   * `nextcloud-spreed`: chat and video conferencing
   * `nextcloud-tasks`: task management

   Security:

   * `nextcloud-bruteforcesettings`: protect Nextcloud from attempts to guess user
     passwords
   * ``nextcloud-passwords``: password manager

   Social networking:

   * `nextcloud-social`: decentralized social media via the Fediverse
   * `nextcloud-socialsharing-email`: sharing of files via email
   * `nextcloud-socialsharing-facebook`: sharing of files via Facebook
   * `nextcloud-socialsharing-twitter`: sharing of files via Twitter

   Performance:

   * `nextcloud-cache-redis` to run a Redis cache to speed up Nextcloud

**phpBB**

   * `phpbb-extension-shareon`: share posts on social media
   * `phpbb-extension-googleanalytics`: Google Analytics support

**Wordpress**

   Additional features:

   * `wordpress-plugin-bridgy-publish`: syndicate to and from social networks via brid.gy
   * `wordpress-plugin-indieauth`: support for IndieAuth single-sign-on
   * `wordpress-plugin-indieweb`: IndieWeb support
   * `wordpress-plugin-indieweb-post-kinds`: add more IndieWeb post kinds
   * `wordpress-plugin-indieweb-press-this`: respond to the current page
   * `wordpress-plugin-micropub`: MicroPub support
   * `wordpress-plugin-semantic-linkbacks`: semantic linkback support
   * `wordpress-plugin-syndication-links`: add syndication microformats
   * `wordpress-plugin-webmention`: add WebMention support
   * `wordpress-plugin-wp-uf2`: add microformats to your posts
   * `wordpress-plugin-google-analytics-for-wordpress`: add Google Analytics support
   * `wordpress-plugin-seo`: add Search Engine Optimization functionality
   * `wordpress-plugin-photo-dropper`: easily find and add pictures to posts
   * `wordpress-plugin-wp-mail-smtp`: make configuration of outgoing mail simpler

   Themes:

   * `wordpress-theme-independent-publisher`: the Independent Publisher theme
   * `wordpress-theme-p2`: the P2 theme
   * `wordpress-theme-pinboard`: the Pinboard theme
   * `wordpress-theme-responsive`: the Response theme
   * `wordpress-theme-sempress`: the Sempress theme
   * the default themes starting with `wordpress-theme-twentytwelve`.

   Social networking:

   * `wordpress-plugin-social-networks-auto-posted-facebook-twitter-g`: automatically
     post to social networks.

<br>

The following blockchain-related servers are also available in beta ("yellow" release
channel) on all platforms except for ``armv6h`` (no user interface, connect with API):

* **Bitcoin daemon**: Run your own Bitcoin blockchain<br>
  Install with `sudo pacman -S bitcoin` and start with `systemctl start bitcoind`

* **Ethereum daemon**: Run your own Ethereum blockchain<br>
  Install with `sudo pacman -S geth` and start with `systemctl start geth`

* **Monero daemon**: Run your own Monero blockchain<br>
  Install with `sudo pacman -S monero` and start with `systemctl start monerod`
