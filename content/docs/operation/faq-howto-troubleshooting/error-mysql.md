---
title: "Cannot access MySQL database. File missing: /etc/mysql/root-defaults-ubos.cnf"
---

This is known to happen under some circumstances if you run UBOS from a very slow disk, such
as a USB 2.0 stick. During startup of the database engine (MySQL/MariaDB) required by
certain {{% gls App %}}, a timeout may have occurred that prevents the database initialization
from completing.

You can try to start the database manually with:

```
% sudo systemctl start mysqld.service
```

and then attempt to re-install your {{% gl App %}}. If this does not work, use a faster disk:
For one, if your disk is too slow to successfully install an {{% gl App %}}, chances are
it is also too slow to do anything useful with the {{% gl App %}}.
