---
id: pcb-power
title: Power up
sidebar_label: 1. Power up
description: How to get power to the APC PCB
slug: pcb-power
image: /img/assembly/apc.jpg
---

:::info
This guide's components' brands and body colors (and even the PCB color itself) may look different from yours, and that's okay! What's important is that the part types and values are in the right spots.
:::

:::note
Take your time and make sure the LED and switch are perfectly flat against the PCB before soldering all of their pins.
:::

First, we'll get power to the board and make sure our battery is working.

1. Find the **330 ohm resistor**; its color bands are _Orange Orange Brown_. Solder it into **R101**.
   - ![330 resistor to R101](/img/assembly/r101.jpg)
2. The **LED** goes to **D101**.
   1. Note that the footprint on the PCB is a circle with one flat side. Insert the **LED** so its flat side matches that footprint.
   2. Hold in place and solder. Make sure it's flat against the PCB. <!-- TODO: advise on technique -->
      ![LED, perfectly flat against PCB, at D101](/img/assembly/led-flat.jpg)
3. The **slider switch** goes to **S101**.
   1. It doesn't have polarity and can go in either direction, but, just like the **LED**, it does need to be perfectly flat against the PCB.
   2. Confirm it's flat before soldering soldering all of its pads. <!-- TODO: advise on technique -->
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
