---
title: UBOS state
weight: 170
---

## State diagram

A UBOS {{% gl Device %}} can be thought of as always being in a particular
state. The following diagram shows these as a state chart:

![UBOS state chart](/images/ubos-state.png)

A UBOS {{% gl Device %}} can either be in one of the following two major states:

* "Powered Off", or
* "Powered On".

When "Powered On", initially it is:

* "Booting", until the boot process is complete and it is in state
* "Operational".
* While ``ubos-admin`` is running, the device is in "In Maintenance".

Once ``ubos-admin`` completes, the device goes back to being "Operational".
The device can further be:

* "Shutting Down", going back to "Powered Off", or
* "Rebooting", going back to "Operational".

While it hopefully never happens, the device can also be in state:

* "Error".

If the device enters one of the states shown with a gray background, a
state transition callback is performed as described next.

## State transitions

When UBOS transitions from one state to another, it invokes callbacks defined in
``/etc/state-callbacks``. Callbacks are defined as follows:

* Each file in ``/etc/state-callbacks`` defines one callback
* Each callback file consists of a single line with the fully-qualified name of a
  Perl module with optional arguments that are passed-on verbatim, e.g.
  ``Some::Where::Callback a 17``.
* The Perl class must have a subroutine called ``stateChanged``, which will be invoked
  when the device state changes. Arguments to the subroutine are:
  * the name of the new state
  * the remaining arguments from the callback file
  So in this example, the invocation may be
  ``Some::Where::Callback::stateChanged( 'Operational', 'a', 17 );``

The values for the states are the same as the gray-shaded states shown in the
diagram, except that blanks are removed: ``Operational``, ``InMaintenance``,
``ShuttingDown``, ``Rebooting`` and ``Error``.
