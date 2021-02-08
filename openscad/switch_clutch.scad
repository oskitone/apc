// TODO: extract parts to common repo
use <../../poly555/openscad/lib/basic_shapes.scad>;

include <enclosure.scad>;
include <shared_constants.scad>;

SWITCH_CLUTCH_LENGTH = SWITCH_ACTUATOR_LENGTH + ENCLOSURE_WALL * 2;
// TODO: shorten and elevate to reduce friction
SWITCH_CLUTCH_HEIGHT = SWITCH_BASE_HEIGHT * 2 + SWITCH_ACTUATOR_HEIGHT;

SWITCH_CLUTCH_WIDTH =  PCB_X + PCB_SWITCH_POSITION[0]
    + SWITCH_BASE_WIDTH / 2
    + ENCLOSURE_SIDE_OVEREXPOSURE
    + ENCLOSURE_INNER_WALL;
SWITCH_CLUTCH_WEB_X = ENCLOSURE_SIDE_OVEREXPOSURE + ENCLOSURE_WALL
    + DEFAULT_TOLERANCE * 2;
SWITCH_CLUTCH_WEB_WIDTH = SWITCH_CLUTCH_WIDTH
    - SWITCH_BASE_WIDTH - DEFAULT_TOLERANCE - SWITCH_CLUTCH_WEB_X
    - ENCLOSURE_INNER_WALL;

function get_switch_clutch_y(position = 0) = (
    PCB_Y + PCB_SWITCH_POSITION[1] - SWITCH_ORIGIN[1]
        + SWITCH_BASE_LENGTH / 2
        - SWITCH_ACTUATOR_TRAVEL / 2
        + SWITCH_ACTUATOR_TRAVEL * position
        - SWITCH_CLUTCH_LENGTH / 2
);

module switch_clutch(
    _fillet = 1,
    side_overexposure = ENCLOSURE_SIDE_OVEREXPOSURE,
    tolerance = DEFAULT_TOLERANCE,
    floor_ceiling = ENCLOSURE_FLOOR_CEILING,
    switch_position = 0,
    web_height = 10,
    web_overlap = 4
) {
    e = .045321;

    module _clutch() {
        module _web() {
            length = SWITCH_BASE_LENGTH + SWITCH_ACTUATOR_TRAVEL
                + web_overlap * 2;

            translate([
                SWITCH_CLUTCH_WEB_X,
                (SWITCH_CLUTCH_LENGTH - length) / 2,
                0
            ]) {
                cube([
                    SWITCH_CLUTCH_WEB_WIDTH,
                    length,
                    web_height
                ]);
            }
        }

        module _exposed_grip() {
            module _rib_cavities(
                rib_length = .8,
                depth = .4,
                rib_gutter = 1.234
            ) {
                available_length = SWITCH_CLUTCH_LENGTH
                    - rib_gutter * 2 - rib_length;
                count = round(available_length / (rib_length + rib_gutter));

                for (i = [0 : count - 0]) {
                    y = rib_gutter + i * (available_length / count);

                    translate([-e, y, -e]) {
                        cube([
                            depth + e,
                            rib_length,
                            SWITCH_CLUTCH_HEIGHT + e * 2
                        ]);
                    }
                }
            }

            width = SWITCH_CLUTCH_WIDTH - SWITCH_CLUTCH_WEB_WIDTH
                - SWITCH_BASE_WIDTH;

            difference() {
                rounded_cube(
                    [
                        width + _fillet,
                        SWITCH_CLUTCH_LENGTH,
                        SWITCH_CLUTCH_HEIGHT
                    ],
                    radius = _fillet,
                    $fn = DEFAULT_ROUNDING
                );

                _rib_cavities();
            }
        }

        module _actuator_clutch() {
            actuator_cavity_length = SWITCH_ACTUATOR_LENGTH + tolerance * 2;
            width = SWITCH_BASE_WIDTH + ENCLOSURE_INNER_WALL + e;

            cavity_x = SWITCH_CLUTCH_WIDTH - width - e;
            cavity_width = SWITCH_BASE_WIDTH + DEFAULT_TOLERANCE * 2;

            difference() {
                translate([SWITCH_CLUTCH_WIDTH - width - e, 0, 0]) {
                    cube([
                        width,
                        SWITCH_CLUTCH_LENGTH,
                        SWITCH_CLUTCH_HEIGHT
                    ]);
                }

                translate([cavity_x, -e, -e]) {
                    cube([
                        cavity_width,
                        SWITCH_CLUTCH_LENGTH + e * 2,
                        SWITCH_BASE_HEIGHT + e
                    ]);
                }

                translate([
                    cavity_x,
                    (SWITCH_CLUTCH_LENGTH - actuator_cavity_length) / 2,
                    -e
                ]) {
                    cube([
                        cavity_width,
                        actuator_cavity_length,
                        SWITCH_ACTUATOR_HEIGHT + SWITCH_BASE_HEIGHT + e
                            + tolerance // just in case
                    ]);
                }
            }
        }

        _web();
        _exposed_grip();
        _actuator_clutch();
    }

    translate([0, switch_position * SWITCH_ACTUATOR_TRAVEL, 0]) {
        difference() {
            translate([
                -side_overexposure,
                get_switch_clutch_y(0),
                Z_PCB_TOP
            ]) {
                _clutch();
            }

            _pot_walls(ENCLOSURE_INNER_WALL + tolerance * 2, tolerance * 2);
        }
    }
}
