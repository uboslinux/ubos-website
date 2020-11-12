---
title: Format of the App Status JSON
---

{{% status proposed %}}

{{% gls App %}} may optionally declare an executable or script that, when invoked,
reports status information of the {{% gl AppConfiguration %}} on which it is applied.
This is further described in the {{% gl UBOS_Manifest %}}.

The format of the emitted JSON, for now, is very simple. The {{% gl App %}}
currently can only convey whether it is operational or not, by emitting:

```
{
  "status" : "operational"
}
```

or

```
{
  "status" : "failed"
}
```

{{% /status %}}
