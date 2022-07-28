# APC

[![APC](apc-10-60-838-450-32.gif)](apc-10-60-838-450-32.gif)

A decapitated robot head? An extraterrestrial communicator? A specter summoner?

Nope (and yep!), it's an [APC](https://en.wikipedia.org/wiki/Atari_Punk_Console)!

**Demo:** [https://vimeo.com/518375593](https://vimeo.com/518375593)<br />
**Purchase:** [APC (fully assembled)](https://www.oskitone.com/product/apc), [APC DIY Electronics Kit](https://www.oskitone.com/product/apc-diy-electronics-kit)<br />
**Blog post:** [https://blog.tommy.sh/posts/oskitone-makes-an-atari-punk-console/](https://blog.tommy.sh/posts/oskitone-makes-an-atari-punk-console/)

---

### KiCad Source

![A soldered APC PCB](assembly_content/apc-pcb-16x9.jpg)

The PCB and its schematic are actually part of [poly555](https://github.com/oskitone/poly555), so head over there to its KiCad project to dig deeper into the electronics. (That the APC is a part of a bigger project may also help to explain why the component numbers start at 100!)

## 3D Models

The APC's 3D-printed models are written in OpenSCAD.

### Changelog

- **September 6, 2021:** Add brim to switch_clutch for better DFM (2d0a1d0), Loosen wheel fit (7e2dab7)
- **February 25, 2021:** Init (8df1dc4)

### Dependencies

Assumes poly555 repo is in a sibling directory. Here's how I've got it:

    \ oskitone
        \ apc
        \ poly555

### Mods

- For pots with flatted D shafts, use `shaft_type = POT_SHAFT_TYPE_FLATTED` in the call to `wheels()` for a better fit.

### Building

STLs are generated with `make_stls.sh`. Run `./make_stls.sh -h` for full flags list.

---

## License

Designed by Oskitone. Please support future synth projects by purchasing from [Oskitone](https://www.oskitone.com/).

Creative Commons Attribution/Share-Alike, all text above must be included in any redistribution. See license.txt for additional details.
