include <battery.scad>;
include <enclosure.scad>;
include <switch_clutch.scad>;
include <wheels.scad>;

module assembly(
    show_enclosure_top = true,
    show_enclosure_bottom = true,

    show_pcb = true,
    show_wheels = true,
    show_switch_clutch = true,
    show_battery = true,

    show_dfm = true,

    switch_position = round($t),
    enclosure_bottom_position = 0
) {
    e = .0123;

    enclosure(
        show_bottom = show_enclosure_bottom,
        show_top = show_enclosure_top,
        show_dfm = show_dfm,
        fillet = 2,
        enclosure_bottom_position = enclosure_bottom_position
    );

    if (show_pcb) {
        translate([
            ENCLOSURE_WALL + ENCLOSURE_INTERNAL_GUTTER,
            ENCLOSURE_LENGTH - ENCLOSURE_WALL - ENCLOSURE_INTERNAL_GUTTER
                - PCB_LENGTH,
            PCB_Z - e
        ]) {
            # pcb(
                show_board = true,
                show_speaker = true,
                show_pots = true,
                show_led = true,
                show_switch = true,
                show_volume_pot = true,
                switch_position = switch_position
            );
        }
    }

    if (show_wheels) {
        wheels(
            diameter = WHEEL_DIAMETER,
            height = WHEEL_HEIGHT,
            y = PCB_Y,
            z = ENCLOSURE_HEIGHT - WHEEL_HEIGHT- e
        );
    }

    if (show_switch_clutch) {
        switch_clutch(switch_position);
    }

    if (show_battery) {
        translate([
            ENCLOSURE_WALL + ENCLOSURE_INTERNAL_GUTTER,
            ENCLOSURE_WALL + ENCLOSURE_INTERNAL_GUTTER,
            PCB_Z
        ]) {
            battery();
        }
    }
}

SHOW_ENCLOSURE_TOP = true;
SHOW_ENCLOSURE_BOTTOM = true;
SHOW_PCB = true;
SHOW_WHEELS = true;
SHOW_SWITCH_CLUTCH = true;
SHOW_BATTERY = true;
SHOW_DFM = false;

intersection() {
    assembly(
        show_enclosure_top = SHOW_ENCLOSURE_TOP,
        show_enclosure_bottom = SHOW_ENCLOSURE_BOTTOM,
        show_pcb = SHOW_PCB,
        show_wheels = SHOW_WHEELS,
        show_switch_clutch = SHOW_SWITCH_CLUTCH,
        show_battery = SHOW_BATTERY,
        show_dfm = SHOW_DFM
    );

    /* cube([ENCLOSURE_WIDTH / 2, ENCLOSURE_LENGTH * 2, ENCLOSURE_HEIGHT]); */
    /* cube([ENCLOSURE_WIDTH, ENCLOSURE_LENGTH * 2, ENCLOSURE_HEIGHT / 2]); */
    /* cube([ENCLOSURE_WIDTH, ENCLOSURE_LENGTH * .8, ENCLOSURE_HEIGHT]); */
}
