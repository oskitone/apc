// TODO: extract parts to common repo
use <../../poly555/openscad/lib/basic_shapes.scad>;
use <../../poly555/openscad/lib/enclosure.scad>;

include <battery.scad>;
include <pcb.scad>;

DEFAULT_TOLERANCE = .1;

ENCLOSURE_WALL = 2.4;
ENCLOSURE_FLOOR_CEILING = 1.8;
ENCLOSURE_GUTTER = 2;
ENCLOSURE_SIDE_OVEREXPOSURE = 2;

ENCLOSURE_WIDTH = PCB_WIDTH
    + ENCLOSURE_GUTTER * 2
    + ENCLOSURE_WALL * 2;
ENCLOSURE_LENGTH = PCB_LENGTH
    + BATTERY_LENGTH
    + ENCLOSURE_GUTTER * 3
    + ENCLOSURE_WALL * 2;

// TODO: expose LIP_BOX_DEFAULT_LIP_HEIGHT
ENCLOSURE_BOTTOM_HEIGHT = ENCLOSURE_FLOOR_CEILING + 3;

PCB_X = ENCLOSURE_WALL + ENCLOSURE_GUTTER;
PCB_Y = ENCLOSURE_WALL + ENCLOSURE_GUTTER * 2 + BATTERY_LENGTH;
PCB_Z = max(
    PCB_BOTTOM_CLEARANCE,
    ENCLOSURE_BOTTOM_HEIGHT - ENCLOSURE_FLOOR_CEILING - PCB_HEIGHT
);

ENCLOSURE_HEIGHT =
    max(
        BATTERY_HEIGHT,
        PCB_Z + PCB_HEIGHT + PTV09A_POT_BASE_HEIGHT + PTV09A_POT_ACTUATOR_HEIGHT
    )
    + ENCLOSURE_FLOOR_CEILING * 2;

ENCLSOURE_TOP_HEIGHT = ENCLOSURE_HEIGHT - ENCLOSURE_BOTTOM_HEIGHT;

SWITCH_CLUTCH_LENGTH = SWITCH_ACTUATOR_LENGTH + ENCLOSURE_WALL * 2;
SWITCH_CLUTCH_HEIGHT = SWITCH_BASE_HEIGHT * 2 + SWITCH_ACTUATOR_HEIGHT;

// TODO: fix obstruction with speaker
SWITCH_CLUTCH_WIDTH =  PCB_X + PCB_SWITCH_POSITION[0]
    + SWITCH_BASE_WIDTH / 2
    + ENCLOSURE_SIDE_OVEREXPOSURE;
SWITCH_CLUTCH_WEB_X = ENCLOSURE_SIDE_OVEREXPOSURE + ENCLOSURE_WALL
    + DEFAULT_TOLERANCE * 2;
SWITCH_CLUTCH_WEB_WIDTH = SWITCH_CLUTCH_WIDTH
    - SWITCH_BASE_WIDTH - DEFAULT_TOLERANCE - SWITCH_CLUTCH_WEB_X;

SWITCH_POSITION = round($t);

module enclosure(
    width = ENCLOSURE_WIDTH,
    length = ENCLOSURE_LENGTH,
    height = ENCLOSURE_HEIGHT,

    wall = ENCLOSURE_WALL,
    inner_wall = 1.2,
    floor_ceiling = ENCLOSURE_FLOOR_CEILING,
    gutter = ENCLOSURE_GUTTER,

    side_overexposure = ENCLOSURE_SIDE_OVEREXPOSURE,

    fillet = 2,
    tolerance = DEFAULT_TOLERANCE,

    show_top = true,
    show_bottom = true,
    show_wheels = true,
    show_switch_clutch = true
) {
    e = 0.0321;

    wheel_diameter = 2 *
        (PCB_X + PCB_POT_POSITIONS[0][0] + side_overexposure);

    module _half(h, lip) {
        enclosure_half(
            width = width, length = length, height = h,
            wall = wall,
            floor_ceiling = floor_ceiling,
            add_lip = lip,
            remove_lip = !lip,
            fillet = fillet,
            tolerance = tolerance,
            include_tongue_and_groove = true,
            tongue_and_groove_end_length = undef,
            $fn = 12
        );
    }

    z_pcb_top = floor_ceiling + PCB_Z + PCB_HEIGHT;
    z_pot = z_pcb_top + PTV09A_POT_BASE_HEIGHT + PTV09A_POT_ACTUATOR_HEIGHT
        - PTV09A_POT_ACTUATOR_D_SHAFT_HEIGHT;

    module _component_walls(
        is_cavity = false,
        $fn = 36
    ) {
        z_pcb_top = z_pcb_top + (is_cavity ? -e : 0);
        z_pot = z_pot + (is_cavity ? -e : 0);

        bleed = is_cavity ? tolerance : inner_wall;
        _height = is_cavity ? height + e : height - floor_ceiling + e;

        translate([PCB_X, PCB_Y, 0]) {
            translate([
                PCB_LED_POSITION.x,
                PCB_LED_POSITION.y,
                z_pcb_top
            ]) {
                cylinder(
                    d = LED_DIAMETER + bleed * 2,
                    h = _height - z_pcb_top
                );
            }

            translate([
                PCB_SPEAKER_POSITION.x,
                PCB_SPEAKER_POSITION.y,
                z_pcb_top
            ]) {
                cylinder(
                    d = SPEAKER_DIAMETER + bleed * 2,
                    h = _height - z_pcb_top
                );
            }

            for (xy = PCB_POT_POSITIONS) {
                base_width = 9.7;
                base_height = 6.8;

                translate([xy.x, xy.y, z_pot]) {
                    cylinder(
                        d = PTV09A_POT_ACTUATOR_DIAMETER + bleed * 2,
                        h = _height - z_pot
                    );
                }
            };
        }
    }

    module _accent_cavities(depth = .4, _fillet = 1) {
        _gutter = gutter + 1;
        _length = (length - _gutter * 2) * .5;
        y = length - _length - _gutter;

        translate([_gutter, y, height - depth]) {
            rounded_xy_cube(
                [width - _gutter * 2, _length, depth + e],
                radius = _fillet,
                $fn = 12
            );
        }
    }

    module _pot_cavities() {
        z = z_pot - e;

        for (xy = PCB_POT_POSITIONS) {
            translate([wall + gutter + xy.x, PCB_Y + xy.y, z]) {
                cylinder(
                    d = wheel_diameter + tolerance * 4, // intentionally loose
                    h = height - z + e
                );
            };
        }
    }

    module _wheels() {
        z = z_pot - e;
        wheel_height = height - z;

        for (xy = PCB_POT_POSITIONS) {
            translate([wall + gutter + xy.x, PCB_Y + xy.y, z]) {
                cylinder(
                    d = wheel_diameter,
                    h = wheel_height
                );
            };
        }
    }

    function get_switch_clutch_y(position = 0) = (
        PCB_Y + PCB_SWITCH_POSITION[1] - SWITCH_ORIGIN[1]
            + SWITCH_BASE_LENGTH / 2
            - SWITCH_ACTUATOR_TRAVEL / 2
            + SWITCH_ACTUATOR_TRAVEL * position
            - SWITCH_CLUTCH_LENGTH / 2
    );

    module _switch_clutch(_fillet = 1) {
        x = -side_overexposure;
        y = get_switch_clutch_y(SWITCH_POSITION);

        module _clutch() {
            cavity_width =
                (SWITCH_BASE_WIDTH - SWITCH_ACTUATOR_WIDTH) / 2
                + SWITCH_ACTUATOR_WIDTH
                + tolerance;
            cavity_length = SWITCH_ACTUATOR_LENGTH + tolerance * 2;

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

            module _web() {
                overlap = 1;
                length = SWITCH_BASE_LENGTH + SWITCH_ACTUATOR_TRAVEL
                    + overlap * 2;

                translate([
                    SWITCH_CLUTCH_WEB_X,
                    (SWITCH_CLUTCH_LENGTH - length) / 2,
                    0
                ]) {
                    cube([
                        SWITCH_CLUTCH_WEB_WIDTH,
                        length,
                        ENCLOSURE_HEIGHT - z_pcb_top - floor_ceiling
                    ]);
                }
            }

            _web();

            difference() {
                rounded_cube(
                    [
                        SWITCH_CLUTCH_WIDTH,
                        SWITCH_CLUTCH_LENGTH,
                        SWITCH_CLUTCH_HEIGHT
                    ],
                    radius = _fillet,
                    $fn = 12
                );

                _rib_cavities();

                translate([
                    SWITCH_CLUTCH_WIDTH - SWITCH_BASE_WIDTH
                        - DEFAULT_TOLERANCE - e,
                    -e,
                    -e
                ]) {
                    cube([
                        SWITCH_BASE_WIDTH + DEFAULT_TOLERANCE + e,
                        SWITCH_CLUTCH_LENGTH + e * 2,
                        SWITCH_BASE_HEIGHT + e
                    ]);
                }

                translate([
                    SWITCH_CLUTCH_WIDTH - cavity_width,
                    (SWITCH_CLUTCH_LENGTH - cavity_length) / 2,
                    SWITCH_BASE_HEIGHT - e
                ]) {
                    cube([
                        cavity_width + e,
                        cavity_length,
                        SWITCH_ACTUATOR_HEIGHT + e + tolerance // just in case
                    ]);
                }
            }
        }

        translate([x, y, z_pcb_top]) {
            _clutch();
        }
    }

    module _switch_clutch_cavity() {
        y_tolerance = tolerance * 2; // intentionally loose

        y = get_switch_clutch_y(0) - y_tolerance;

        length = SWITCH_CLUTCH_LENGTH
            + SWITCH_ACTUATOR_TRAVEL
            + y_tolerance * 2;
        height = SWITCH_CLUTCH_HEIGHT + z_pcb_top + e;

        translate([-e, y, -e]) {
            cube([wall + e * 2, length, height]);
        }
    }

    module _switch_clutch_wall() {
        width = inner_wall;
        length = SWITCH_BASE_LENGTH;
        _height = ENCLSOURE_TOP_HEIGHT - SWITCH_CLUTCH_HEIGHT
            - floor_ceiling;

        translate([
            SWITCH_CLUTCH_WEB_X - side_overexposure
                + SWITCH_CLUTCH_WEB_WIDTH + tolerance * 2,
            PCB_Y + PCB_SWITCH_POSITION[1] - SWITCH_ORIGIN[1],
            height - floor_ceiling - _height
        ]) {
            cube([width, length, _height + e]);
        }
    }

    if (show_wheels) {
        _wheels();
    }

    if (show_switch_clutch) {
        translate([0, 0, e]) {
            _switch_clutch();
        }
    }

    if (show_bottom) {
        translate([0, 0, -e]) {
            _half(ENCLOSURE_BOTTOM_HEIGHT, false);
        }
    }

    if (show_top) {
        _switch_clutch_wall();

        difference() {
            union() {
                translate([0, 0, height]) {
                    mirror([0, 0, 1]) {
                        _half(ENCLSOURE_TOP_HEIGHT, true);
                    }
                }

                _component_walls();
            }

            _component_walls(is_cavity = true);
            _accent_cavities();
            _pot_cavities();
            _switch_clutch_cavity();
        }
    }
}

enclosure(
    show_bottom = false,
    show_top = true,
    show_wheels = true,
    show_switch_clutch = true,
    fillet = 2
);

translate([
    ENCLOSURE_WALL + ENCLOSURE_GUTTER,
    ENCLOSURE_LENGTH - ENCLOSURE_WALL - ENCLOSURE_GUTTER - PCB_LENGTH,
    ENCLOSURE_FLOOR_CEILING + PCB_Z
]) {
    # pcb(
        show_board = true,
        show_speaker = true,
        show_pots = true,
        show_led = true,
        show_switch = true,
        show_volume_pot = true,
        switch_position = SWITCH_POSITION
    );
}

translate([
    ENCLOSURE_WALL + ENCLOSURE_GUTTER,
    ENCLOSURE_WALL + ENCLOSURE_GUTTER,
    ENCLOSURE_FLOOR_CEILING + .03 // TODO: e
]) {
    battery();
}
