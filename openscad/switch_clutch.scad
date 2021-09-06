// TODO: extract parts to common repo
use <../../poly555/openscad/lib/basic_shapes.scad>;

include <enclosure.scad>;
include <rib_cavities.scad>;
include <shared_constants.scad>;

// Length is arbitrary but height's intentional -- middle of clutch should align
// to the switch's actuator.
SWITCH_CLUTCH_WIDTH =  PCB_X + PCB_SWITCH_POSITION[0]
    + SWITCH_BASE_WIDTH / 2
    + ENCLOSURE_SIDE_OVEREXPOSURE;
SWITCH_CLUTCH_LENGTH = SWITCH_ACTUATOR_LENGTH + ENCLOSURE_WALL * 2;
SWITCH_CLUTCH_HEIGHT = SWITCH_BASE_HEIGHT * 2 + SWITCH_ACTUATOR_HEIGHT;

SWITCH_CLUTCH_WEB_X = ENCLOSURE_SIDE_OVEREXPOSURE + ENCLOSURE_WALL
    + DEFAULT_TOLERANCE * 2;

SWITCH_CLUTCH_WEB_WIDTH = SWITCH_CLUTCH_WIDTH
    - SWITCH_BASE_WIDTH - DEFAULT_TOLERANCE - SWITCH_CLUTCH_WEB_X;
SWITCH_CLUTCH_WEB_LENGTH = SWITCH_BASE_LENGTH + SWITCH_ACTUATOR_TRAVEL
    + 4 * 2;
SWITCH_CLUTCH_WEB_HEIGHT = ENCLOSURE_HEIGHT - Z_PCB_TOP - ENCLOSURE_FLOOR_CEILING
    - ENCLOSURE_GRILL_DEPTH
    - DEFAULT_DFM_LAYER_HEIGHT; // just to be safe

function get_switch_clutch_y(position = 0) = (
    PCB_Y + PCB_SWITCH_POSITION[1] - SWITCH_ORIGIN[1]
        + SWITCH_BASE_LENGTH / 2
        - SWITCH_ACTUATOR_TRAVEL / 2
        + SWITCH_ACTUATOR_TRAVEL * position
        - SWITCH_CLUTCH_LENGTH / 2
);

module switch_clutch(
    position = 0,
    fillet = ACCESSORY_FILLET,
    side_overexposure = ENCLOSURE_SIDE_OVEREXPOSURE,
    tolerance = DEFAULT_TOLERANCE,
    floor_ceiling = ENCLOSURE_FLOOR_CEILING,
    brim_height = DEFAULT_DFM_LAYER_HEIGHT,
    brim_depth = 1,
    show_dfm = true
) {
    e = .045321;

    skirt_width = side_overexposure + PCB_X - SWITCH_CLUTCH_WEB_X
        - tolerance * 2;
    skirt_height = PCB_HEIGHT + MISC_CLEARANCE;

    module _breakaway_support(height) {
        cube([
            BREAKAWAY_SUPPORT_DEPTH,
            SWITCH_CLUTCH_LENGTH,
            height - DEFAULT_DFM_LAYER_HEIGHT
        ]);

        translate([-brim_depth, -brim_depth, 0]) {
            cube([
                BREAKAWAY_SUPPORT_DEPTH + brim_depth * 2,
                SWITCH_CLUTCH_LENGTH + brim_depth * 2,
                brim_height
            ]);
        }
    }

    module _clutch() {
        module _web() {
            dfm_cavity_depth = SWITCH_CLUTCH_WEB_WIDTH - skirt_width;

            translate([
                SWITCH_CLUTCH_WEB_X,
                (SWITCH_CLUTCH_LENGTH - SWITCH_CLUTCH_WEB_LENGTH) / 2,
                0
            ]) {
                difference() {
                    cube([
                        SWITCH_CLUTCH_WEB_WIDTH,
                        SWITCH_CLUTCH_WEB_LENGTH,
                        SWITCH_CLUTCH_WEB_HEIGHT
                    ]);

                    if (show_dfm) {
                        translate([skirt_width, -e, -e]) {
                            flat_top_rectangular_pyramid(
                                top_width = 0,
                                top_length = SWITCH_CLUTCH_WEB_LENGTH + e * e,
                                bottom_width = dfm_cavity_depth + e,
                                bottom_length = SWITCH_CLUTCH_WEB_LENGTH + e * e,
                                height = dfm_cavity_depth + e,
                                top_weight_x = 1
                            );
                        }
                    }
                }
            }
        }

        module _exposed_grip() {
            width = SWITCH_CLUTCH_WIDTH - SWITCH_CLUTCH_WEB_WIDTH
                - SWITCH_BASE_WIDTH;

            if (show_dfm) {
                translate([
                    fillet,
                    0,
                    -skirt_height
                ]) {
                    _breakaway_support(skirt_height);
                }
            }

            difference() {
                rounded_cube(
                    [
                        width + fillet,
                        SWITCH_CLUTCH_LENGTH,
                        SWITCH_CLUTCH_HEIGHT
                    ],
                    radius = fillet,
                    $fn = DEFAULT_ROUNDING
                );

                rib_cavities(
                    length = SWITCH_CLUTCH_LENGTH,
                    height = SWITCH_CLUTCH_HEIGHT
                );
            }
        }

        module _actuator_clutch() {
            actuator_cavity_length = SWITCH_ACTUATOR_LENGTH + tolerance * 2;
            width = SWITCH_BASE_WIDTH + e;

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

            if (show_dfm) {
                inset = 1; // try to prevent loose hangs
                x = SWITCH_CLUTCH_WIDTH - BREAKAWAY_SUPPORT_DEPTH - inset;

                translate([x, 0, -skirt_height]) {
                    _breakaway_support(SWITCH_BASE_HEIGHT + skirt_height);
                }
            }
        }

        module _skirt() {
            length = SWITCH_CLUTCH_WEB_LENGTH;

            translate([
                SWITCH_CLUTCH_WEB_X,
                (SWITCH_CLUTCH_WEB_LENGTH - SWITCH_CLUTCH_LENGTH) / -2,
                -skirt_height
            ]) {
                cube([skirt_width, length, skirt_height + e]);
            }
        }

        module _output() {
            _web();
            _exposed_grip();
            _actuator_clutch();
            _skirt();
        }

        _output();
    }

    translate([0, position * SWITCH_ACTUATOR_TRAVEL, 0]) {
        difference() {
            translate([
                -side_overexposure,
                get_switch_clutch_y(0),
                Z_PCB_TOP
            ]) {
                _clutch();
            }

            _pot_walls(
                diameter_bleed = ENCLOSURE_INNER_WALL
                    + SWITCH_CLUTCH_SLIDE_CLEARANCE,
                height_bleed = tolerance * 2
            );
        }
    }
}
