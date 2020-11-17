---
title: Debugging a Java/Tomcat App
---

If you test your Java/Tomcat web {{% gl App %}} by running it in a UBOS container, the
following setup has proven to be useful:

1. In the container, have ``systemd`` start Tomcat with the debug flags on. To do
   so, say:

   ```
   % sudo systemctl edit tomcat8
   ```

   and enter the following content:

   ```
   [Service]
   Environment='CATALINA_OPTS=-Xdebug -Xrunjdwp:transport=dt_socket,address=8888,server=y,suspend=n'
   ```

   Note the quotes.

   Then invoke ``systemctl restart tomcat8``. This will restart Tomcat and your {{% gl App %}},
   but instead of running normally, it will wait for your IDE's debugger to connect on
   port 8888 before proceeding.

2. In the container, open port 8888 in the firewall so the debugger running on the
   host can connect to Tomcat:

   ```
   % sudo vi /etc/iptables/iptables.rules
   ```

   Add the following line where similar lines are:

   ```
   -A OPEN-PORTS -p tcp --dport 8888 -j ACCEPT
   ```

   Restart the firewall: ``systemctl restart iptables``. Note that this setting
   will be overridden as soon as you invoke ``ubos-admin setnetconfig``, but that
   should not be an issue in a debug scenario.

   Alternatively you can create a file named, say ``/etc/ubos/open-ports.d/java-debug``
   with content ``tcp/8080`` and ``ubos-admin setnetconfig`` will always keep
   that port open.

3. On your host, attach your debugger to the container's port 8888. In NetBeans,
   for example, select "Debug / Attach Debugger", select "JDPA", "SocketAttach",
   "dt_socket", enter the IP address of your container and port 8888. For
   good measure, increase the timeout to 60000msec.
