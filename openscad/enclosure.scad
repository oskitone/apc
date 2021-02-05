// TODO: extract parts to common repo
use <../../poly555/openscad/lib/basic_shapes.scad>;
use <../../poly555/openscad/lib/enclosure.scad>;

include <battery.scad>;
include <pcb.scad>;

ENCLOSURE_WALL = 2.4;
ENCLOSURE_FLOOR_CEILING = 1.8;
ENCLOSURE_GUTTER = 2;

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

EXPOSED_SWITCH_ACTUATOR_LENGTH = SWITCH_ACTUATOR_LENGTH + ENCLOSURE_WALL * 2;
EXPOSED_SWITCH_ACTUATOR_HEIGHT = SWITCH_BASE_HEIGHT * 2 + SWITCH_ACTUATOR_HEIGHT;

SWITCH_POSITION = round($t);

module enclosure(
    width = ENCLOSURE_WIDTH,
    length = ENCLOSURE_LENGTH,
    height = ENCLOSURE_HEIGHT,

    wall = ENCLOSURE_WALL,
    inner_wall = 1.2,
    floor_ceiling = ENCLOSURE_FLOOR_CEILING,
    gutter = ENCLOSURE_GUTTER,

    side_overexposure = 2,

    fillet = 2,
    tolerance = .1,

    show_top = true,
    show_bottom = true,
    show_wheels = true,
    show_switch_actuator = true
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

    // TODO: extract and tidy
    // TODO: fix obstruction with speaker
    switch_actuator_width =  PCB_X + PCB_SWITCH_POSITION[0]
        + SWITCH_BASE_WIDTH / 2
        + side_overexposure;
    switch_base_cavity_width = SWITCH_BASE_WIDTH + tolerance;
    web_x = side_overexposure + wall + tolerance * 2;
    web_cavity_y_overlap = 1;
    web_width = switch_actuator_width - switch_base_cavity_width - web_x + e;
    web_length = SWITCH_BASE_LENGTH + SWITCH_ACTUATOR_TRAVEL
        + web_cavity_y_overlap * 2;
    web_height = height - z_pcb_top - floor_ceiling;

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

    function get_switch_actuator_y(position = 0) = (
        PCB_Y + PCB_SWITCH_POSITION[1] - SWITCH_ORIGIN[1]
            + SWITCH_BASE_LENGTH / 2
            - SWITCH_ACTUATOR_TRAVEL / 2
            + SWITCH_ACTUATOR_TRAVEL * position
            - EXPOSED_SWITCH_ACTUATOR_LENGTH / 2
    );

    module _switch_actuator(_fillet = 1) {
        x = -side_overexposure;
        y = get_switch_actuator_y(SWITCH_POSITION);

        module _actuator() {
            actuator_cavity_width =
                (SWITCH_BASE_WIDTH - SWITCH_ACTUATOR_WIDTH) / 2
                + SWITCH_ACTUATOR_WIDTH
                + tolerance;
            actuator_cavity_length = SWITCH_ACTUATOR_LENGTH + tolerance * 2;

            module _rib_cavities(
                rib_length = .8,
                depth = .4,
                rib_gutter = 1.234
            ) {
                available_length = EXPOSED_SWITCH_ACTUATOR_LENGTH
                    - rib_gutter * 2 - rib_length;
                count = round(available_length / (rib_length + rib_gutter));

                for (i = [0 : count - 0]) {
                    y = rib_gutter + i * (available_length / count);

                    translate([-e, y, -e]) {
                        cube([
                            depth + e,
                            rib_length,
                            EXPOSED_SWITCH_ACTUATOR_HEIGHT + e * 2
                        ]);
                    }
                }
            }

            module _web() {
                translate([
                    web_x,
                    (EXPOSED_SWITCH_ACTUATOR_LENGTH - web_length) / 2,
                    0
                ]) {
                    cube([web_width, web_length, web_height]);
                }
            }

            _web();

            difference() {
                rounded_cube(
                    [
                        switch_actuator_width,
                        EXPOSED_SWITCH_ACTUATOR_LENGTH,
                        EXPOSED_SWITCH_ACTUATOR_HEIGHT
                    ],
                    radius = _fillet,
                    $fn = 12
                );

                _rib_cavities();

                translate([
                    switch_actuator_width - switch_base_cavity_width,
                    -e,
                    -e
                ]) {
                    cube([
                        switch_base_cavity_width + e,
                        EXPOSED_SWITCH_ACTUATOR_LENGTH + e * 2,
                        SWITCH_BASE_HEIGHT + e
                    ]);
                }

                translate([
                    switch_actuator_width - actuator_cavity_width,
                    (EXPOSED_SWITCH_ACTUATOR_LENGTH - actuator_cavity_length) / 2,
                    SWITCH_BASE_HEIGHT - e
                ]) {
                    cube([
                        actuator_cavity_width + e,
                        actuator_cavity_length,
                        SWITCH_ACTUATOR_HEIGHT + e + tolerance // just in case
                    ]);
                }
            }
        }

        translate([x, y, z_pcb_top]) {
            _actuator();
        }
    }

    module _switch_actuator_cavity() {
        y_tolerance = tolerance * 2; // intentionally loose

        y = get_switch_actuator_y(0) - y_tolerance;

        length = EXPOSED_SWITCH_ACTUATOR_LENGTH
            + SWITCH_ACTUATOR_TRAVEL
            + y_tolerance * 2;
        height = EXPOSED_SWITCH_ACTUATOR_HEIGHT + z_pcb_top + e;

        translate([-e, y, -e]) {
            cube([wall + e * 2, length, height]);
        }
    }

    module _switch_actuator_wall() {
        width = inner_wall;
        length = SWITCH_BASE_LENGTH;
        _height = ENCLSOURE_TOP_HEIGHT - EXPOSED_SWITCH_ACTUATOR_HEIGHT
            - floor_ceiling;

        translate([
            web_x - side_overexposure + web_width + tolerance * 2,
            PCB_Y + PCB_SWITCH_POSITION[1] - SWITCH_ORIGIN[1],
            height - floor_ceiling - _height
        ]) {
            cube([width, length, _height + e]);
        }
    }

    if (show_wheels) {
        _wheels();
    }

    if (show_switch_actuator) {
        translate([0, 0, e]) {
            _switch_actuator();
        }
    }

    if (show_bottom) {
        translate([0, 0, -e]) {
            _half(ENCLOSURE_BOTTOM_HEIGHT, false);
        }
    }

    if (show_top) {
        _switch_actuator_wall();

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
            _switch_actuator_cavity();
        }
    }
}

enclosure(
    show_bottom = false,
    show_top = true,
    show_wheels = true,
    show_switch_actuator = true,
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
