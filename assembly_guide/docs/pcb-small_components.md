---
id: pcb-small_components
title: Small components
sidebar_label: 2. Small components
description: Soldering the APC's small components
slug: pcb-small_components
image: /img/assembly/apc.jpg
---

:::note
Take your time and make sure the 1k trim pot is perfectly flat against the PCB before soldering all of its pins.
:::

Next we'll do the remaining small, passive components.

1. There are two small ceramic capacitors:
   1. The one marked _103_ is for **.01uF** (also known as 10nF). It goes to **C101**.
      ![.01uF to C101](/img/assembly/c101.jpg)
   2. The other's marked _104_, for **.1uF**, and goes to **C102**.
      ![.1uF to C102](/img/assembly/c102.jpg)
2. The last cap is an electrolytic **10uF** capacitor at **C103**.
   - Match the capacitor's white stripe to the white part of the footprint.
     ![10uF to C103](/img/assembly/c103.jpg)
3. The remaining resistor is **1k ohms**, colored _Brown Black Red_.
   - Solder to **R102**.
     ![1k ohms to R102](/img/assembly/r102.jpg)
4. The small, blue **1k trim potentiometer** goes to **RV103**. It's marked _102_. Make sure it's flat against the PCB. <!-- TODO: advise on technique -->
   - ![1k trim pot to 102](/img/assembly/vol-flat.jpg)
5. Nothing to test here, but check all solder joints and trim leads before moving on. We're almost done!

<!-- TODO: consider breaking out test from the rest of the steps -->
