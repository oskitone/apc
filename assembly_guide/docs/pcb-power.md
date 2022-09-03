---
id: pcb-power
title: Power up
sidebar_label: 1. Power up
description: How to get power to the APC PCB
slug: pcb-power
---

<!-- TODO: remind that components will look different -->

First, we'll get power to the board and make sure our battery is working.

1. Find the **330 ohm resistor**; its color bands are _Orange Orange Brown_. Solder it into **R101**.
   - ![330 resistor to R101](/img/assembly/r101.jpg)
2. The **LED** goes to **D101** and has polarity (one side is positive, the other negative), so make sure its flat side matches the outline on the PCB. It needs to be perfectly flat against the **PCB**. Here's how I like to do that:
   1. Bend one of the LED's legs to roughly hold it into place, then solder the straight leg to its pad.
      ![Soldering one LED leg](/img/assembly/led-solder.jpg)
   2. While pushing the **LED** _into_ the **PCB** from the other side, remelt the solder &mdash; the **LED** may wiggle a little &mdash; and allow to cool before releasing pressure.
      ![Remelting that solder while pushing in LED](/img/assembly/led-remelt.jpg)
   3. Check the other side of the board to inspect. Repeat until there's no gap between the **LED** and the **PCB**, then solder the other leg.
      ![LED, perfectly flat against PCB, at D101](/img/assembly/led-flat.jpg)
3. The **slider switch** goes to **S101**.
   1. It doesn't have polarity and can go in either direction, but it does need to be perfectly flat against the PCB. One trick to do that is, instead of bringing the solder to the component as you'd normally do, hold the component in place and bring it to the solder. A pair of "helping hands" will help.
      ![Soldering the switch](/img/assembly/switch-solder.jpg)
   2. Confirm it's flat before soldering the rest of the pads.
      ![Switch, perfectly flat against PCB, at S101](/img/assembly/switch-flat.jpg)
4. Next up is the **9v battery snap**.
   1. Feed its wires through the hole by **BT101**. This acts as a stress relief, preventing strain at the solder joints whenever you replace the battery.
      ![9v snap wires in their relief hole](/img/assembly/9v-relief.jpg)
   2. Insert and solder wires into place: red to **+** and black to **-**
      ![9v snap wires in place at BT101](/img/assembly/9v-wires.jpg)
5. **Test it!**
   1. Connect a **battery** to the **9v snap**, and slide the **switch** back and forth. You should see the **LED** turn on and off. Nice!
      ![Testing power](/img/assembly/power.jpg)
   2. If you don't, don't worry; it's just time to debug. _Don't move on to the next step until you've got this working._
      - Check all your solder joints.
      - Verify **LED** is placed correctly and matches its footprint.
      - Is the **battery** dead?
      - Are the **battery** wires in the right spots?
6. Trim leads if you haven't already, and remove the **battery** before continuing.

<!-- TODO: consider breaking out test from the rest of the steps -->
