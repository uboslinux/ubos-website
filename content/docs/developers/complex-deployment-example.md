---
title: A more complex deployment example
weight: 40
---

In the real world, apps and sites tend to be more complex than the ones discussed
in {{% pageref "toyapps/" %}}. Let's look at one such example, and dissect what happens in
detail when such a more complex {{% gl Site %}} is deployed.

In this example, we deploy a TLS-encrypted {{% gl Site %}} as it might be used by a
small business: it runs a public website, using Wordpress, with an additional plugin.
It also runs Nextcloud for the company's filesharing and calendaring needs,
with the Redis cache and calendar accessories. The main site is going
to be at ``https://example.com/``. In the real world, we would probably also set up a
site at ``https://www.example.com/`` that runs the ``redirect`` {{% gl App %}} to
redirect to the main site, but we won't discuss this here.

The {{% gl Site_JSON %}} file for ``example.com`` might look as follows:

```
{
    "hostname" : "example.com",
    "siteid" : "s6641ad1b780d2330247896c0fe74438fb1e19a33",
    "tls" : {
        "letsencrypt" : true
    },
    "appconfigs" : [
        {
           "appid" : "wordpress",
           "context" : "/blog",
           "appconfigid" : "a5830f84d072d95001a272ab7a5ee2866f93972d0",
           "accessoryids" : [
               "wordpress-plugin-photo-dropper"
           ]
        },
        {
            "appid" : "nextcloud",
            "context" : "/nextcloud",
            "appconfigid" : "a3e2e73410ad9a09fa82794783cd76eb602276736",
            "accessoryids" : [
                "nextcloud-calendar",
                "nextcloud-cache-redis"
            ]
        }
    ]
}
```

Some observations about the {{% gl Site %}} defined by this {{% gl Site_JSON %}} file:

* UBOS needs to obtain a TLS certificate from {{% gl LetsEncrypt %}}. Because letsencrypt.org
  performs a callback to this {{% gl Site %}} to verify ownership, UBOS needs to temporarily
  stage certain files with the web server that, obviously, should not conflict with any
  {{% gls App %}} installed at the same {{% gl Site %}}.

* After the files for Wordpress and the Wordpress plugin have been put in the right
  places, the Wordpress plugin needs to be automatically activated by Wordpress.

* Similarly, after the files for Nextcloud and the Nextcloud accessories have been
  put in the right places, the accessories need to be activated in Nextcloud as
  Nextcloud apps.

* The Redis cache accessory just provides a connector a running Redis daemon (Redis).
  This deamon needs to be started and stopped at the right times.

* A unique password needs to be generated that's used to communicate between
  the Nextcloud Redis cache extension, and the Redis daemon.

Let's assume we have the above {{% gl Site_JSON %}} file saved to ``example.com.json``.
Then we deploy the {{% gl Site %}} with:

```
% sudo ubos-admin deploy --file example.com.json
```

Here is what UBOS does in (reasonable) detail:

1. Check the {{% gl Site_JSON %}} file:

   1. It is syntactically correct.

   1. It contains all required fields with syntactically valid values.

   1. It can be deployed to the current {{% gl Device %}}:

      1. The ``hostname`` of the new {{% gl Site %}} does not conflict with
         the hostname of any {{% gl Site %}} already deployed to the current {{% gl Device %}}.

      1. None of the {{% gls AppConfigId %}} conflicts with an existing one. Note that
         the {{% gl SiteId %}} is not checked for conflicts, as it is perfectly valid to
         redeploy an already-deployed {{% gl Site %}}. This redeployment would cause
         the existing {{% gl Site %}} to be reconfigured to the new configuration.

   1. Whether it is a new {{% gl Site %}}, or an update of an already-existing
      {{% gl Site %}}. We won't discuss the latter here as it makes things even more
      complex.

1. Set a flag that prevents other, concurrent invocations of ``ubos-admin``.

1. Download and install needed packages:

   1. Download and install the {{% gl App %}} and {{% gl Accessory %}} {{% gls Package %}}
      referenced in the {{% gl Site_JSON %}} file, and their package dependencies. In our
      example, they are: ``wordpress``, ``wordpress-plugin-photo-dropper``, ``nextcloud``,
      ``nextcloud-calendar``, ``nextcloud-cache-redis``, and dependencies such as
      ``php`` and ``redis``.

   1. Now that the {{% gls Package %}} for the {{% gls App %}} and {{% gls Accessory %}}
      have been downloaded and installed, UBOS can examine their respective
      {{% gl UBOS_Manifest %}}. First, UBOS downloads and installs the
      {{% gls Package %}} (and, recursively, their dependencies)
      listed as dependencies in the various (applicable) {{% gl Role %}} sections in the
      {{% gl UBOS_Manifest %}} of all the {{% gls App %}} and {{% gls Accessory %}}.
      Here: from Wordpress: ``php``, ``php-apache``; nothing from the Photo Dropper
      {{% gl Accessory %}}; from Nextcloud: ``php-apache``, ``php-apcu``, ``php-gd``,
      ``php-systemd``; from the Redis cache {{% gl Accessory %}}: ``php-redis``.

1. Check the semantics of the intended configuration. This can only be done now that
   the {{% gl UBOS_Manifest %}} files are available:

   1. The {{% gls AppConfiguration %}} at the same {{% gl Site %}} may not
      be deployed to conflicting {{% gls Context_Path %}}. Here we have
      ``/blog`` (for Wordpress) and ``/nextcloud`` (for Nextcloud), which is fine.

   1. Values for all required {{% gls Customization_Point %}}
      have been provided, or have defaults. Here, the value for the Wordpress blog's
      title is taken from the default specified in the {{% gl UBOS_Manifest %}} of
      {{% gl App %}} Wordpress, and the Redis password for the Nextcloud Redis cache
      is automatically generated because a random password generation expression has
      been specified  in the {{% gl UBOS_Manifest %}} of the Redis cache {{% gl Accessory %}}.

   1. Values of the {{% gls Customization_Point %}} are valid
      according to the constraints specified in the respective {{% gl UBOS_Manifest %}}.

   1. The {{% gls Accessory %}} specified in the {{% gl AppConfiguration %}} can be
      used with the {{% gl App %}} in that same {{% gl AppConfiguration %}}. This would catch,
      for example, if the {{% gl Site_JSON %}} file specified that the Nextcloud Redis cache
      was supposed to be used with Wordpress instead of Nextcloud.

   1. The {{% gl UBOS_Manifest %}} of all {{% gls App %}} and {{% gls Accessory %}}
      is valid. This includes checks for:

      1. Syntactic correctness.

      1. Semantic correctnes.

      1. The files mentioned in the {{% gl UBOS_Manifest %}} actually exist in the
         file system. This would catch, for example, if the script to activate a Wordpress
         plugin, contained in the Wordpress package, had been renamed in a recent package
         update, but an {{% gl Accessory %}} depending on it hadn't been updated and was still
         referencing the old location.

      1. If an {{% gl Accessory %}} requires the presence of another {{% gl Accessory %}} at
         the same {{% gl AppConfiguration %}} per its {{% gl UBOS_Manifest %}}, check that it
         is actually present (this does not apply in our example and is rare; an
         example would we a Wordpress theme, packaged as an {{% gl Accessory %}} that is a
         child theme of another Wordpress theme, packaged as a separate
         {{% gl Accessory %}}).

1. As this is the deployment of a new {{% gl Site %}}, no existing {{% gl Site %}} needs to be
   suspended.

1. Set up a placeholder {{% gl Site %}} at the same hostname:

   1. Create an Apache configuration file for this virtual host whose document directory
      is the "maintenance" document directory

   1. Restart Apache.

1. Obtain the {{% gl LetsEncrypt %}} certificate:

   * Invoke the ``certbot`` program to create a TLS keypair, stage the challenge files in the
     right location so ``letsencrypt.org`` can retrieve them via HTTP, have LetsEncrypt issue
     a certificate for it, and then save the certificate in the right place with the right
     Apache configuration directives for it.

1. Deploy the {{% gl Site %}}:

   1. Create the directories needed by Apache2 for this {{% gl Site %}}.

   1. Process all {{% gls AppConfiguration %}}:

      1. For the Wordpress {{% gl AppConfiguration %}}:

         1. Create the directory ``blog`` below the {{% gl Site %}}'s Apache document root
            directory.

         1. First process {{% gl App %}} Wordpress:

            1. Save the ``title`` {{% gl Customization_Point %}} to a file with a well-known
               location so the ``${installable.customizationpoints.title.file}`` variable
               can be resolved later.

            1. Process all {{% gls AppConfigItem %}} for the ``mysql``
               {{% gl Role %}} of {{% gl App %}} Wordpress:

               * Provision a new MySQL database.

               * Provision a new MySQL database user and give it all privileges to the
                 newly provisioned MySQL database, as that is what is specified in the
                 {{% gl UBOS_Manifest %}}.

            1. Create a symbolic link in the Apache modules directory so Apache will
               load the ``ssl`` Apache module upon restart.

            1. Create a symbolic link each in the Apache modules directory so Apache will
               load all Apache modules upon restart that are specified in Wordpress's
               {{% gl UBOS_Manifest %}}: ``php7`` and ``rewrite``.

            1. Create a file each in the PHP modules directory so Apache's PHP module
               will load all PHP modules specified in Wordpress's
               {{% gl UBOS_Manifest %}}: ``gd``, ``iconv``, ``mysqli`` and ``pdo_mysql``.

            1. Process all {{% gls AppConfigItem %}} for the ``apache2``
               {{% gl Role %}} of {{% gl App %}} Wordpress, in sequence. This includes:

               * Recursively copy directory trees to the ``/blog`` subdirectory of the
                 {{% gl Site %}}'s Apache document root.

               * Create directories relative to the ``/blog`` subdirectory of the
                 {{% gl Site %}}'s Apache document root.

               * Run the ``wp-config.pl`` file that generates the ``wp-config.php`` file
                 below the ``/blog`` subdirectory of the {{% gl Site %}}'s Apache document root.

               * Copy the two ``htaccess`` files to below the ``/blog`` subdirectory of the
                 {{% gl Site %}}'s Apache document root, while replacing the variables contained
                 in them.

         1. Now process {{% gl Accessory %}} Photo Dropper:

            1. Process the single {{% gl AppConfigItem %}} for the ``apache2``
               {{% gl Role %}} of {{% gl Accessory %}} Photo Dropper:

               * Recursively copy its files into ``wp-plugins`` subdirectory below the
                 Wordpress installation

      1. For the Nextcloud {{% gl AppConfiguration %}}:

         1. Create the directory ``nextcloud`` below the {{% gl Site %}}'s Apache document
            root directory.

         1. First process {{% gl App %}} Nextcloud:

            1. Process all :term:`AppConfigItems <AppConfigItem>` for the ``mysql``
               {{% gl Role %}}: of {{% gl App %}} Nextcloud:

               * Provision a new MySQL database.

               * Provision a new MySQL database user and give it all privileges to the
                 newly provisioned MySQL database.

            1. Create a symbolic link each in the Apache modules directory so Apache will
               load all Apache modules upon restart that are specified in Nextcloud's
               {{% gl UBOS_Manifest %}}: ``php7``, ``rewrite``, ``headers``, ``env`` and
               ``setenvif``.

            1. Create a file each in the PHP modules directory so Apache's PHP module
               will load all PHP modules specified in Nextcloud's
               {{% gl UBOS_Manifest %}}: ``apcu``, ``gd``, ``iconv``, ``mysqli``,
               ``pdo_mysql`` and ``systemd``.

            1. Process all :term:`AppConfigItems <AppConfigItem>` for the ``apache2``
               {{% gl Role %}}: of {{% gl App %}} Nextcloud, in sequence. This includes:

               * Recursively copy directory trees to the ``/nextcloud`` subdirectory of the
                 {{% gl Site %}}'s Apache document root.

               * Create directories relative to the ``/nextcloud`` subdirectory of the
                 {{% gl Site %}}'s Apache document root.

               * Copy files while replacing the variables contained in them.

               * Run the Perl script ``fix-permissions.pl``

               * Start the Systemd timer that runs the Nextcloud background process.

         1. Now process {{% gl Accessory %}} Nextcloud Calendar:

            1. Process the single {{% gl AppConfigItem %}} for the ``apache2``
               {{% gl Role %}}: of {{% gl Accessory %}} Nextcloud Calendar:

               * Recursively copy its files into ``apps`` subdirectory below the
                 Nextcloud installation.

         1. Now process {{% gl Accessory %}} Nextcloud Redis Cache:

            1. Create a file each in the PHP modules directory so Apache's PHP module
               will load all PHP modules specified in Nextcloud Redis Cache's
               {{% gl UBOS_Manifest %}}: ``redis`` and ``igbinary``.

            1. Process all {{% gls AppConfigItem %}} for the ``apache2``
               {{% gl Role %}}: of {{% gl Accessory %}} Nextcloud Redis Cache, in sequence.
               This includes:

               * Create directories below the {{% gl AppConfiguration %}}'s data directory.

               * Copy the Redis configuration file into the right place, while
                 replacing the variables contained in them (e.g.
                 ``${appconfig.appconfigid}``, which uniquely identifies this Nextcloud
                 installation from any other running on the same {{% gl Device %}}, thus
                 allowing multiple Redis daemons to coexist on the same machine)

               * Start a {{% gl AppConfiguration %}}-specific Redis Systemd service.

   1. Save the {{% gl Site_JSON %}} file so ``ubos-admin`` can find the configuration again.

   1. Invoke the hostname callbacks for this {{% gl Site %}}. This depends on which are
      installed on the {{% gl Device %}}, but always includes:

      * Add the hostname of the {{% gl Site %}} to the ``/etc/hostname`` file, resolving
        to the local IP address.

1. Run the installers:

   1. Run the installers for the Wordpress installation:

      1. According to Wordpress's {{% gl UBOS_Manifest %}}, run ``initialize.pl``,
         which in turn invokes Wordpress's installer script, so the user does not have to
         run it from the browser.

      1. According to Photo Dropper's {{% gl UBOS_Manifest %}}, run ``activate-plugin.pl``
         (which is actually contained in the Wordpress {{% gl Package %}}) in order to
         activate the installed plugin, so the user does not have run it from the browser.
         As this script is invoked with the context of the {{% gl Accessory %}}'s variables,
         no arguments need to be specified.

   1. Run the installers for the Nextcloud installation:

      1. According to Nextcloud's {{% gl UBOS_Manifest %}}, run ``install.pl``, which in
         turn runs various Nextcloud command-line commands to initialize the Nextcloud
         installation correctly. For example, it sets up logging to the system journal
         instead of the default log file.

      1. According to Nextcloud Calendar's {{% gl UBOS_Manifest %}}, run ``activate-app.pl``
         (which is actually contained in the Nextcloud {{% gl Package %}}) in order to
         activate the installed {{% gl Accessory %}} (called "app" by the Nextcloud
         project), so the user does not have run it from the browser.

      1. According to Nextcloud Redis Cache's {{% gl UBOS_Manifest %}}, run
         ``activate-deactivate.pl``, which in turn runs various Nextcloud command-line
         commands to configure the Nextcloud installation to use the correct Redis
         instance.

1. Update the open ports if needed. Neither Wordpress nor Nextcloud open any non-standard
   ports, but if an {{% gl App %}} or {{% gl Accessory %}} requested to open up a port,
   UBOS would reconfigure its firewall to permit this.

1. Resume the {{% gl Site %}}:

   1. Update the Apache virtual host configuration:

      1. Save "well-known" files, like ``robots.txt`` (none specified in the example).

      1. Create the Apache virtual host configuration file.

      1. Restart Apache.

Perhaps a good time to state that as a developer, you very rarely really have to
know all of this :-)

