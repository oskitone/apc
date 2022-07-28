---
id: pcb-power
title: Power up
sidebar_label: Power up
description: How to get power to the APC PCB
slug: pcb-power
---

First, we'll get power to the board and make sure our battery is working.

1. Find the **330 ohm resistor**; its color bands are _Orange Orange Brown_. Solder it into **R101**.
2. The **LED** goes to **D101** and has polarity (one side is positive, the other negative), so make sure its flat side matches the outline on the PCB. It needs to be perfectly flat against the **PCB**. Here's how I like to do that:
   1. Solder one leg to its pad.
   2. While pushing the **LED** _into_ the **PCB** from the other side, remelt the solder -- the **LED** may wiggle a little -- and allow to cool before releasing pressure.
   3. Check the other side of the board to inspect. Repeat until there's no gap between the **LED** and the **PCB**, then solder the other leg.
3. The **slider switch** goes to **S101**.
   - It doesn't have polarity and can go in either direction. This also needs to be perfectly flat against the PCB, so do like you did for the **LED** and don't solder all of its pins until it looks good.
4. Next up is the **9v battery snap**.
   1. Feed its wires through the hole by **BT101**. This acts as a stress relief, preventing strain at the solder joints whenever you replace the battery.
   2. Insert and solder wires into place: red to **+** and black to **-**.
5. **Test it!**
   1. Connect a **battery** to the **9v snap**, and slide the **switch** back and forth. You should see the **LED** turn on and off.
   2. If you don't, it's time to debug. _Don't move on to the next step until you've got this working._
      - Check all your solder joints
      - Verify **LED** is placed correctly and matches its footprint
      - Is the **battery** dead?
      - Are the **battery** wires in the right spots?
   3. Trim leads if you haven't already, and remove the **battery** before continuing.
