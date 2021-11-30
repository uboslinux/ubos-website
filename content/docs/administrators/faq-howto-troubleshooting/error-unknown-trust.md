---
title:  Installing a new Package or upgrading fails with a message about "unknown trust"
---

This is most likely because some public key expired. Run

```
% sudo pacman-key --refresh-keys
```

and try again.
