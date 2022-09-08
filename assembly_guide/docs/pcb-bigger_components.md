---
id: pcb-bigger_components
title: Bigger components
sidebar_label: 3. Bigger components
description: How to solder the APC's pots, speaker, and IC socket
slug: pcb-bigger_components
image: /img/assembly/apc.jpg
---

Last is the bigger components: pots, speaker, and IC.

1. Push the two **500k pots** into their footprints at **RV101** and **RV102**
   1. A trick to get the pot to snap in better is to _gently_ push its mounting tabs inward before popping it onto the PCB.
      ![Bending the potentiometer tabs](/img/assembly/pot-tabs.jpg)
   2. Check that they're flat against the PCB, then solder into place.
      <!-- ![TODO: 500k pot flat against PCB at RV101/RV102](https://dummyimage.com/1920x1080/000/fff) -->
   3. You can solder the mounting tabs on the side too, if you want!
2. Fit the **speaker** into **LS101**, matching its **+** and **-** pins to the right holes.
   1. Don't bend its leads! That can break it.
   2. Solder. This can be tricky because it might fall out when you flip the board over. One way to do it is to [bring the board to the solder instead of the other way around](https://www.instagram.com/p/BdvbqTtloH5/). You can also try taping the component in place or use "mounting putty."
      ![Soldering the APC speaker at LS101](/img/assembly/speaker-solder.jpg)
      <!-- TODO: merge w/ switch advice -->
   3. Check that the **speaker** is flat against the PCB before continuing.
      ![Speaker, flat against PCB](/img/assembly/speaker-flat.jpg)
3. And the absolute last component to solder is the **IC socket**
   1. Place the **IC socket** into **U101**, matching its little indentation to the footprint.
      ![Placing the IC socket at U101](/img/assembly/socket-placement.jpg)
   2. Solder using the same technique you did for the **speaker** to hold it in place.
      ![Soldering the socket](/img/assembly/socket-solder.jpg)
4. With its socket soldered, we can add its 556 chip.
   1. In order to fit well into its **socket**, the pins of the **556** need to point straight down from the chip's body.
      ![The IC chip's pins, straightened](/img/assembly/ic-pins.jpg)
   2. Carefully insert the **556 chip** into the **socket** at **U101**, matching its indentation. If its pins don't seem to go in well, try the previous step again.
      ![556 chip into socket at U101](/img/assembly/chip-insert.jpg)

<!-- TODO: consider breaking out test from the rest of the steps -->
