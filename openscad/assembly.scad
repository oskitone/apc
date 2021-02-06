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

    switch_position = round($t)
) {
    e = .0123;

    enclosure(
        show_bottom = show_enclosure_bottom,
        show_top = show_enclosure_top,
        fillet = 2
    );

    if (show_pcb) {
        translate([
            ENCLOSURE_WALL + ENCLOSURE_INTERNAL_GUTTER,
            ENCLOSURE_LENGTH - ENCLOSURE_WALL - ENCLOSURE_INTERNAL_GUTTER
                - PCB_LENGTH,
            ENCLOSURE_FLOOR_CEILING + PCB_Z
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
        translate([0, 0, -e]) {
            switch_clutch(
                switch_position = switch_position,
                web_height = ENCLOSURE_HEIGHT - Z_PCB_TOP - ENCLOSURE_FLOOR_CEILING
            );
        }
    }

    if (show_battery) {
        translate([
            ENCLOSURE_WALL + ENCLOSURE_INTERNAL_GUTTER,
            ENCLOSURE_WALL + ENCLOSURE_INTERNAL_GUTTER,
            ENCLOSURE_HEIGHT - ENCLOSURE_FLOOR_CEILING - BATTERY_HEIGHT - e
        ]) {
            battery();
        }
    }
}

intersection() {
    assembly(
        show_enclosure_top = true,
        show_enclosure_bottom = true,

        show_pcb = true,
        show_wheels = true,
        show_switch_clutch = true,
        show_battery = true
    );

    /* cube([ENCLOSURE_WIDTH / 2, ENCLOSURE_LENGTH, ENCLOSURE_HEIGHT]); */
}
