# APC

[![APC](apc-24-600-256.gif)](apc-24-600-256.gif)

A decapitated robot head? An extraterrestrial communicator? A specter summoner?

Nope (and yep!), it's an [APC](https://en.wikipedia.org/wiki/Atari_Punk_Console)!

## Assembly

### BOM

| Part         | Package                             | Quantity | Value        | Marking             |
| ------------ | ----------------------------------- | -------- | ------------ | ------------------- |
| RV101, RV102 | PTV09 Vertical Pot                  | 2        | 500k-1M      |                     |
| LS101        | Speaker 30mm_36MS30008-PN           | 1        | Speaker      |                     |
| C103         | CP_Radial_D4.0mm_P2.00mm            | 1        | 10uF         |                     |
| U101         | DIP-14_W7.62mm_LongPads             | 1        | LM556        |                     |
| S101         | EG1218                              | 2        |              |                     |
| RV103        | Potentiometer Piher_PT-6-V_Vertical | 1        | 1k           | 102                 |
| D101         | LED D5.0mm                          | 1        | LED          |                     |
| C102         | Ceramic disc D5.0mm_W2.5mm_P5.00mm  | 1        | .1uF         | 104                 |
| C101         | Ceramic disc D5.0mm_W2.5mm_P5.00mm  | 1        | .01uF / 10nF | 103                 |
| BT101        |                                     | 1        | 9v           |                     |
| R101         | Resistor                            | 1        | 330          | Orange Orange Brown |
| R102         | Resistor                            | 1        | 1k           | Brown Black Red     |

#### Notes:

- Be sure to match polarity on electrolytic caps, diodes, and LEDs! The longer leg of the LED is positive.
- The 556 chip doesn't solder directly to the PCB at U101. Instead, solder the included socket, then insert IC.
- Don't bend the speaker leads because that may break it internally.
- One way to solder components that don't want to stay in place is to [bring the board to the solder instead of the other way around](https://www.instagram.com/p/BdvbqTtloH5/). You can also try taping them in place or use "mounting putty."
- Make sure the switch, speaker, and pots are all perfectly straight against the PCB before you solder _all_ of their leads. De-soldering a crooked component is no fun!
- When done soldering, trim all leads as close to the PCB as you can. The enclosure only leaves a handful of millimeters of clearance.

### Schematic

[![APC Schematic](schematic.svg)](schematic.svg)

PCB and its schematic are actually part of [poly555](https://github.com/oskitone/poly555), which explains why component numbers start at 100.

## OpenSCAD

### Dependencies

Assumes poly555 repo is in a sibling directory. Here's how I've got it:

    \ oskitone
        \ apc
        \ poly555

## License

Designed by Oskitone. Please support future synth projects by purchasing from [Oskitone](https://www.oskitone.com/).

Creative Commons Attribution/Share-Alike, all text above must be included in any redistribution. See license.txt for additional details.
