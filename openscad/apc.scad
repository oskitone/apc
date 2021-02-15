include <battery.scad>;
include <enclosure.scad>;
include <switch_clutch.scad>;
include <wheels.scad>;

module apc(
    show_enclosure_top = true,
    show_enclosure_bottom = true,

    show_pcb = true,
    show_wheels = true,
    show_switch_clutch = true,
    show_battery = true,

    show_dfm = true,

    wheels_count = undef,

    enclosure_color = "hotpink",
    wheels_color = "white",
    switch_clutch_color = "white",

    switch_position = round($t),
    enclosure_bottom_position = 0 // abs($t - .5) * 2
) {
    e = .0123;

    color(enclosure_color) {
        if (show_enclosure_bottom) {
            enclosure_bottom(
                enclosure_bottom_position = enclosure_bottom_position
            );
        }

        if (show_enclosure_top) {
            enclosure_top(
                show_dfm = show_dfm
            );
        }
    }

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

    color (wheels_color) {
        if (show_wheels) {
            wheels(
                diameter = WHEEL_DIAMETER,
                height = WHEEL_HEIGHT,
                y = PCB_Y,
                z = ENCLOSURE_HEIGHT - WHEEL_HEIGHT + WHEEL_VERTICAL_EXPOSURE
                    - e,
                count = wheels_count
            );
        }
    }

    if (show_switch_clutch) {
        color(switch_clutch_color) {
            switch_clutch(
                position = switch_position,
                show_dfm = show_dfm
            );
        }
    }

    if (show_battery) {
        translate([
            ENCLOSURE_WALL + ENCLOSURE_INTERNAL_GUTTER,
            ENCLOSURE_WALL + ENCLOSURE_INTERNAL_GUTTER,
            ENCLOSURE_FLOOR_CEILING
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
WHEELS_COUNT = undef;

FLIP_VERTICALLY = false;

rotate(FLIP_VERTICALLY ? [0, 180, 0] : [0, 0, 0]) {
    intersection() {
        apc(
            show_enclosure_top = SHOW_ENCLOSURE_TOP,
            show_enclosure_bottom = SHOW_ENCLOSURE_BOTTOM,
            show_pcb = SHOW_PCB,
            show_wheels = SHOW_WHEELS,
            show_switch_clutch = SHOW_SWITCH_CLUTCH,
            show_battery = SHOW_BATTERY,
            show_dfm = SHOW_DFM,
            wheels_count = WHEELS_COUNT
        );

        /* cube([ENCLOSURE_WIDTH / 2, ENCLOSURE_LENGTH * 2, ENCLOSURE_HEIGHT]); */
        /* cube([ENCLOSURE_WIDTH, ENCLOSURE_LENGTH * 2, ENCLOSURE_HEIGHT / 2]); */
        /* cube([ENCLOSURE_WIDTH, ENCLOSURE_LENGTH * .8, ENCLOSURE_HEIGHT]); */
        /* translate([
            ENCLOSURE_WIDTH / 5 * 1,
            ENCLOSURE_GRILL_GUTTER * 1,
            ENCLOSURE_HEIGHT - ENCLOSURE_FLOOR_CEILING
        ]) {
            cube([
                ENCLOSURE_WIDTH / 5 * (5 - 2),
                ENCLOSURE_LENGTH - GRILL_LENGTH - ENCLOSURE_GRILL_GUTTER * 2.5,
                ENCLOSURE_FLOOR_CEILING
            ]);
        } */
    }
}
