---
title: Apps on UBOS
---

Currently available apps (alphabetically). Install with `sudo ubos-admin createsite`:

{{% app name="Amazon SES" img="/images/amazonses-72x72.png" package="amazonses"%}}
Send e-mail via Amazon's Simple E-mail Service (SES).
{{% /app %}}

{{% app name="Docroot" img="/images/docroot-72x72.png" package="docroot"%}}
Static file hosting with SSH-based upload.
{{% /app %}}

{{% app name="Matomo" img="/images/matomo-72x72.png" package="matomo"%}}
Open web analytics platform (formerly Piwik).
{{% /app %}}

{{% app name="Mediawiki" img="/images/mediawiki-72x72.png" package="mediawiki"%}}
The wiki that Wikipedia runs on.
{{% /app %}}

{{% app name="Nextcloud" img="/images/nextcloud-72x72.png" package="nextcloud"%}}
A safe home for all your data.
{{% /app %}}

{{% app name="phpBB" img="/images/phpbb-72x72.png" package="phpbb"%}}
Bulletin-board.
{{% /app %}}

{{% app name="Redirect" img="/images/redirect-72x72.png" package="redirect"%}}
Redirects to another site.
{{% /app %}}

{{% app name="Webtrees" img="/images/webtrees-72x72.png" package="webtrees"%}}
Full-featured web genealogy app
{{% /app %}}

{{% app name="Wordpress" img="/images/wordpress-72x72.png" package="wordpress"%}}
Blog tools, publishing platform, and CMS.
{{% /app %}}

Available in beta ("yellow" release channel only):

{{% app name="Decko" img="/images/decko-72x72.png" package="decko"%}}
Dynamic websites from creatively organized cards.
{{% /app %}}

{{% app name="Known" img="/images/known-72x72.png" package="known"%}}
Indieweb publishing platform for everyone.
{{% /app %}}

{{% app name="Mastodon" img="/images/mastodon-72x72.png" package="mastodon"%}}
Free, open-source, decentralized microblogging network.
{{% /app %}}

{{% app name="Mattermost" img="/images/mattermost-72x72.png" package="mattermost"%}}
Open source, self-hosted Slack-alternative.
{{% /app %}}

{{% app name="River5" img="/images/river-72x72.png" package="river"%}}
A river-of-news RSS aggregator.
{{% /app %}}

{{% app name="Selfoss" img="/images/selfoss-72x72.png" package="selfoss"%}}
Multipurpose RSS reader, live stream, mashup, aggregation web application.
{{% /app %}}

{{% app name="Shaarli" img="/images/shaarli-72x72.png" package="shaarli"%}}
Personal, minimalist, super-fast, bookmarking service
{{% /app %}}

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

   * `nextcloud-audioplayer`: audio player
   * `nextcloud-bookmarks`: bookmark management
   * `nextcloud-bruteforcesettings`: protection against brute-force password guess attempts
   * `nextcloud-cache-redis`: Redis-based cache for faster operations
   * `nextcloud-calendar`: calendaring
   * `nextcloud-contacts`: contact management
   * `nextcloud-deck`: kanban style organization tool aimed at personal planning and
     project organization for teams
   * `nextcloud-documentserver-community`: server-side component for OnlyOffice
   * `nextcloud-extract`: file decompression and extraction
   * `nextcloud-files-fulltextsearch`: full-text search for common file types
   * `nextcloud-files-rightclick`: adds a right click menu
   * `nextcloud-forms`: self-hosted forms for surveys and questionnaires
   * `nextcloud-fulltextsearch-elasticsearch`: full-text search backend
   * `nextcloud-fulltextsearch`: basic full-text search app
   * `nextcloud-group-everyone`: adds a virtual "everyone" group
   * `nextcloud-groupfolders`: admin configured folders shared by everyone in a group
   * `nextcloud-mail`: web mail
   * `nextcloud-markdown`: markdown support
   * `nextcloud-news`: news reader
   * `nextcloud-notes`: note taking
   * `nextcloud-onlyoffice`: edit formatted documents right in your browser
     by integrating with OnlyOffice
   * `nextcloud-passwords`: password manager
   * `nextcloud-richdocuments`: edit formatted documents right in your browser
     by integrating with Collabora
   * `nextcloud-richdocumentscode`: server-side component of the
     Collabora integration
   * `nextcloud-social`: Fediverse-based social networking right in Nextcloud (beta-quality)
   * `nextcloud-socialsharing-email`: share links via e-mail
   * `nextcloud-socialsharing-facebook`: share links via Facebook
   * `nextcloud-socialsharing-twitter`: share links via Twitter
   * `nextcloud-spreed`: chat and video conferencing
   * `nextcloud-tasks`: task management
   * `nextcloud-twofactor-totp`: Two-factor authentication

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
