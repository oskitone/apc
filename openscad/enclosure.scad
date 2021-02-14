// TODO: extract parts to common repo
use <../../poly555/openscad/lib/basic_shapes.scad>;
use <../../poly555/openscad/lib/enclosure.scad>;
use <../../poly555/openscad/lib/engraving.scad>;
use <../../poly555/openscad/lib/diagonal_grill.scad>;

include <shared_constants.scad>;

ENCLOSURE_BOTTOM_HEIGHT = ENCLOSURE_FLOOR_CEILING + LIP_BOX_DEFAULT_LIP_HEIGHT;
ENCLSOURE_TOP_HEIGHT = ENCLOSURE_HEIGHT - ENCLOSURE_BOTTOM_HEIGHT;
ENCLOSURE_ENGRAVING_DEPTH = .8;
ENCLOSURE_SIDE_ENGRAVING_SIZE = 3;

PCB_RAILS_TOTAL_WIDTH = 25 + ENCLOSURE_INNER_WALL;

module _pot_walls(
    diameter_bleed = 0,
    height_bleed = 0
) {
    e = .0321;

    y = PCB_Y + PCB_POT_POSITIONS[0][1];

    module _well() {
        diameter = WELL_DIAMETER + diameter_bleed * 2;
        z = ENCLOSURE_HEIGHT - WHEEL_HEIGHT + WHEEL_VERTICAL_EXPOSURE
            - ENCLOSURE_FLOOR_CEILING - height_bleed;

        intersection() {
            translate([ENCLOSURE_WALL - e, y - diameter / 2 - e, 0]) {
                cube([
                    ENCLOSURE_WIDTH - ENCLOSURE_WALL * 2 - e * 2,
                    diameter + e * 2,
                    100
                ]);
            }

            for (xy = PCB_POT_POSITIONS) {
                translate([PCB_X + xy.x, y, z]) {
                    cylinder(
                        d = diameter,
                        h = ENCLOSURE_HEIGHT - z - ENCLOSURE_FLOOR_CEILING + e
                    );
                }
            };
        }
    }

    module _shaft_to_base() {
        z = PCB_Z + PCB_HEIGHT + PTV09A_POT_BASE_HEIGHT;

        for (xy = PCB_POT_POSITIONS) {
            translate([PCB_X + xy.x, y, z]) {
                cylinder(
                    d = PTV09A_POT_ACTUATOR_DIAMETER + diameter_bleed * 2,
                    h = ENCLOSURE_HEIGHT - z - ENCLOSURE_FLOOR_CEILING + e
                );
            }
        };
    }

    _well();
    _shaft_to_base();
}

module _brand_engraving(
    width = 10,
    height = ENCLOSURE_ENGRAVING_DEPTH,
    tolerance = DEFAULT_TOLERANCE
) {
    e = .049;

    OSKITONE_LENGTH_WIDTH_RATIO = 4.6 / 28; // TODO: extract

    engraving(
        svg = "../../branding.svg",
        size = [width, width * OSKITONE_LENGTH_WIDTH_RATIO],
        height = height + e,
        bleed = -tolerance,
        chamfer = $preview ? 0 : .2 // engraving_chamfer
    );
}

module _text_engraving(
    string,
    size = ENCLOSURE_SIDE_ENGRAVING_SIZE,
    tolerance = DEFAULT_TOLERANCE,
    depth = ENCLOSURE_ENGRAVING_DEPTH,
    bleed = .2
) {
    e = .09421;

    engraving(
        string = string,
        font = "Orbitron:style=Black",
        size = size,
        bleed = -tolerance + bleed,
        height = depth + e,
        center = true,
        chamfer = $preview ? 0 : .2
    );
}

module _half(h, lip) {
    enclosure_half(
        width = ENCLOSURE_WIDTH, length = ENCLOSURE_LENGTH, height = h,
        wall = ENCLOSURE_WALL,
        floor_ceiling = ENCLOSURE_FLOOR_CEILING,
        add_lip = lip,
        remove_lip = !lip,
        fillet = ENCLOSURE_FILLET,
        tolerance = DEFAULT_TOLERANCE,
        include_tongue_and_groove = true,
        tongue_and_groove_end_length = undef,
        $fn = DEFAULT_ROUNDING
    );
}

module enclosure_bottom(
    width = ENCLOSURE_WIDTH,
    length = ENCLOSURE_LENGTH,
    height = ENCLOSURE_HEIGHT,

    wall = ENCLOSURE_WALL,
    inner_wall = ENCLOSURE_INNER_WALL,
    floor_ceiling = ENCLOSURE_FLOOR_CEILING,
    gutter = ENCLOSURE_INTERNAL_GUTTER,

    tolerance = DEFAULT_TOLERANCE,

    enclosure_bottom_position = 0
) {
    e = 0.0321;

    module _pcb_rails() {
        _length = 30;
        _height = PCB_Z - floor_ceiling;
        _gutter = PCB_RAILS_TOTAL_WIDTH - inner_wall;

        y = PCB_Y + PCB_LENGTH - _length;

        module _rail() {
            cube([inner_wall, _length, _height + e]);

            translate([0, -_height, 0]) {
                flat_top_rectangular_pyramid(
                    top_width = inner_wall,
                    top_length = 0,
                    bottom_width = inner_wall,
                    bottom_length = _height + e,
                    height = _height + e,
                    top_weight_y = 1
                );
            }
        }

        for (x = [
            (width - inner_wall - _gutter) / 2,
            (width - inner_wall + _gutter) / 2
        ]) {
            translate([x, y, floor_ceiling - e]) {
                _rail();
            }
        }
    }

    module _output() {
        translate([0, ENCLOSURE_LENGTH * enclosure_bottom_position, 0]) {
            _pcb_rails();

            difference() {
                _half(ENCLOSURE_BOTTOM_HEIGHT, false);

                translate([
                    width / 2,
                    length * .67,
                    ENCLOSURE_ENGRAVING_DEPTH
                ]) {
                    rotate([0, 180, 0]) {
                        _brand_engraving(width * .67);
                    }
                }
            }
        }
    }

    _output();
}

module enclosure_top(
    width = ENCLOSURE_WIDTH,
    length = ENCLOSURE_LENGTH,
    height = ENCLOSURE_HEIGHT,

    wall = ENCLOSURE_WALL,
    inner_wall = ENCLOSURE_INNER_WALL,
    floor_ceiling = ENCLOSURE_FLOOR_CEILING,
    gutter = ENCLOSURE_INTERNAL_GUTTER,

    grill_depth = ENCLOSURE_GRILL_DEPTH,
    grill_gutter = ENCLOSURE_GRILL_GUTTER,
    grill_ring = ENCLOSURE_GRILL_RING,
    grill_coverage = ENCLOSURE_GRILL_COVERAGE,
    grill_fillet = ACCESSORY_FILLET,

    side_overexposure = ENCLOSURE_SIDE_OVEREXPOSURE,

    fillet = ENCLOSURE_FILLET,
    tolerance = DEFAULT_TOLERANCE,

    show_dfm = true
) {
    e = 0.0321;

    switch_clutch_cavity_length = SWITCH_CLUTCH_LENGTH
        + SWITCH_ACTUATOR_TRAVEL
        + SWITCH_CLUTCH_SLIDE_CLEARANCE * 2;

    module _component_walls(is_cavity = false) {
        $fn = is_cavity ? HIDEF_ROUNDING : DEFAULT_ROUNDING;

        pcb_top_z = Z_PCB_TOP + (is_cavity ? -e : 0);
        volume_pot_access_z = Z_PCB_TOP + VOLUME_POT_ACTUATOR_HEIGHT
            + MISC_CLEARANCE + (is_cavity ? -e : 0);

        led_bleed = is_cavity ? tolerance : 3;
        default_bleed = is_cavity ? tolerance : inner_wall;

        function get_height(z, expose = is_cavity) =
            height - z + (expose ? e : e - floor_ceiling);

        translate([
            PCB_X + PCB_LED_POSITION.x,
            PCB_Y + PCB_LED_POSITION.y,
            pcb_top_z
        ]) {
            cylinder(
                d = LED_BASE_DIAMETER + led_bleed * 2,
                h = get_height(pcb_top_z)
            );
        }

        translate([
            PCB_X + PCB_VOLUME_POT_POSITION.x,
            PCB_Y + PCB_VOLUME_POT_POSITION.y,
            volume_pot_access_z
        ]) {
            cylinder(
                d = VOLUME_POT_SCREWDRIVER_ACCESS_DIAMETER + default_bleed * 2,
                h = get_height(volume_pot_access_z)
            );
        }

        translate([
            PCB_X + PCB_SPEAKER_POSITION.x,
            PCB_Y + PCB_SPEAKER_POSITION.y,
            pcb_top_z
        ]) {
            cylinder(
                d = SPEAKER_DIAMETER + default_bleed * 2,
                h = get_height(pcb_top_z, false) +
                    (is_cavity ? -grill_depth : 0)
            );
        }

        if (!is_cavity) {
            _pot_walls(inner_wall);
        }
    }

    module _grill_cavities_plate() {
        x = wall - e;
        _width = width - x * 2;
        _length = GRILL_LENGTH - wall + grill_gutter * 2 + e;
        y = length - _length - wall + e;
        z = height - grill_depth - floor_ceiling;

        translate([x, y, z]) {
            cube([_width, _length, grill_depth + e]);
        }
    }

    // TODO: extend grill to full speaker cavity height
    module _grill_cavities() {
        _depth = grill_depth + e;
        _length = GRILL_LENGTH;

        y = length - _length - grill_gutter;
        z = height - grill_depth;

        module _rounding(height = _depth) {
            rounded_xy_cube(
                [width - grill_gutter * 2, _length, height],
                radius = grill_fillet,
                $fn = DEFAULT_ROUNDING
            );
        }

        module _diagonal_grill(height = _depth, angle = 45) {
            diagonal_grill(
                width - grill_gutter * 2, _length, height,
                size = 2,
                angle = angle
            );
        }

        module _ring(xy, diameter) {
            translate([xy.x, xy.y, z - e]) {
                cylinder(
                    d = diameter + grill_ring * 2,
                    h = _depth + e * 2
                );
            }
        }

        intersection() {
            translate([grill_gutter, y, z - floor_ceiling - e]) {
                _diagonal_grill(floor_ceiling + e * 2, angle = -45);
            }

            translate([
                PCB_X + PCB_SPEAKER_POSITION.x,
                PCB_Y + PCB_SPEAKER_POSITION.y,
                z - floor_ceiling - e
            ]) {
                cylinder(
                    d = SPEAKER_DIAMETER + e * 2,
                    h = floor_ceiling + e * 4
                );
            }
        }

        difference() {
            translate([grill_gutter, y, z]) {
                intersection() {
                    _rounding();
                    translate([0, 0, -e]) _diagonal_grill(_depth + e * 2);
                }
            }

            translate([PCB_X, PCB_Y, 0]) {
                for (xy = PCB_POT_POSITIONS) {
                    _ring(xy, WELL_DIAMETER);
                };
                _ring(PCB_LED_POSITION, LED_BASE_DIAMETER);
                _ring(PCB_VOLUME_POT_POSITION,
                    VOLUME_POT_SCREWDRIVER_ACCESS_DIAMETER);
            }
        }
    }

    module _wheel_cavities() {
        well_z = ENCLOSURE_HEIGHT - WHEEL_HEIGHT + WHEEL_VERTICAL_EXPOSURE - e;
        shaft_to_base_z = PCB_Z + PCB_HEIGHT + PTV09A_POT_BASE_HEIGHT - e;

        exposure_diameter = PTV09A_POT_ACTUATOR_DIAMETER + tolerance * 2;

        module _well(_height = height - well_z + e) {
            cylinder(
                d = WELL_DIAMETER,
                h = _height,
                $fn = HIDEF_ROUNDING
            );
        }

        module _well_dfm(
            coverages = [1, .5, 0, 0],
            layer_height = DEFAULT_FDM_LAYER_HEIGHT
        ) {
            function get_span(
                coverage = 0,
                minimum = exposure_diameter,
                maximum = WELL_DIAMETER
            ) = (
                minimum + coverage * (maximum - minimum)
            );

            intersection() {
                translate([0, 0, layer_height * -len(coverages) - e]) {
                    cylinder(
                        d = WELL_DIAMETER + e * 2,
                        h = layer_height * len(coverages) + e * 2,
                        $fn = HIDEF_ROUNDING
                    );
                }

                for (i = [0 : len(coverages) - 1]) {
                    width = get_span(coverage = coverages[max(0, i - 1)]);
                    length = get_span(coverage = coverages[i]);

                    translate([0, 0, (i + 1) * -layer_height]) {
                        rotate([0, 0, (i % 2) * 90]) {
                            translate([width / -2, length / -2, 0]) {
                                cube([width, length, layer_height + e]);
                            }
                        }
                    }
                }
            }
        }

        for (xy = PCB_POT_POSITIONS) {
            translate([wall + gutter + xy.x, PCB_Y + xy.y, 0]) {
                translate([0, 0, well_z]) {
                    _well();

                    if (show_dfm) {
                        _well_dfm();
                    }
                }

                translate([0, 0, shaft_to_base_z]) {
                    cylinder(
                        d = exposure_diameter,
                        h = height - shaft_to_base_z + e,
                        $fn = HIDEF_ROUNDING
                    );

                    cylinder(
                        d = PTV09A_POT_ACTUATOR_BASE_DIAMETER + tolerance * 2,
                        h = PTV09A_POT_ACTUATOR_BASE_HEIGHT,
                        $fn = HIDEF_ROUNDING
                    );
                }
            };
        }
    }

    module _switch_clutch_cavity() {
        y = get_switch_clutch_y(0) - SWITCH_CLUTCH_SLIDE_CLEARANCE;

        height = SWITCH_CLUTCH_HEIGHT + Z_PCB_TOP
            + SWITCH_CLUTCH_TOP_CLEARANCE
            + e;

        translate([-e, y, -e]) {
            cube([wall + e * 2, switch_clutch_cavity_length, height]);
        }
    }

    module _switch_clutch_web_wall() {
        width = ENCLOSURE_INNER_WALL;
        length = SWITCH_CLUTCH_WEB_LENGTH + SWITCH_ACTUATOR_TRAVEL;
        height = SWITCH_CLUTCH_WEB_HEIGHT;

        cavity_length = SWITCH_BASE_LENGTH + SWITCH_CLUTCH_SLIDE_CLEARANCE * 2;

        translate([
            SWITCH_CLUTCH_WEB_X - ENCLOSURE_SIDE_OVEREXPOSURE
                + SWITCH_CLUTCH_WEB_WIDTH + MISC_CLEARANCE,
            get_switch_clutch_y(.5) - (length - SWITCH_CLUTCH_LENGTH) / 2,
            ENCLOSURE_HEIGHT - ENCLOSURE_FLOOR_CEILING - height
                - ENCLOSURE_GRILL_DEPTH
        ]) {
            difference() {
                cube([width, length, height + e]);

                translate([-e, (length - cavity_length) / 2, -e]) {
                    cube([width + e * 2, cavity_length, height + e * 3]);
                }
            }
        }
    }

    module _pcb_rails_lip_cavity() {
        _width = PCB_RAILS_TOTAL_WIDTH + MISC_CLEARANCE * 2;

        translate([
            (width - _width) / 2,
            length - wall - e,
            ENCLOSURE_BOTTOM_HEIGHT - LIP_BOX_DEFAULT_LIP_HEIGHT - e
        ]) {
            cube([_width, wall + e * 2, LIP_BOX_DEFAULT_LIP_HEIGHT + e]);
        }
    }

    module _top_engraving(depth = ENCLOSURE_ENGRAVING_DEPTH) {
        area_length = length - GRILL_LENGTH - grill_gutter * 3;

        translate([
            width / 2,
            grill_gutter + area_length / 2,
            height - depth - e
        ]) {
            // TODO: derive
            translate([0, 7, 0]) {
                _brand_engraving(
                    width = 20,
                    height = ENCLOSURE_ENGRAVING_DEPTH + e
                );
            }

            _text_engraving(
                "APC",
                area_length / 2,
                bleed = 0
            );
        }
    }

    module _power_switch_engraving(depth = ENCLOSURE_ENGRAVING_DEPTH) {
        ys = [
            get_switch_clutch_y(0) - ENCLOSURE_SIDE_ENGRAVING_SIZE * 1.5,
            get_switch_clutch_y(0) + switch_clutch_cavity_length
                + ENCLOSURE_SIDE_ENGRAVING_SIZE / 2
        ];
        z = PCB_Z + SWITCH_CLUTCH_HEIGHT / 2;

        for (i = [0 : len(ys) - 1]) {
            translate([depth - e, ys[i], z]) {
                rotate([270, 180, 90]) {
                    _text_engraving(["0", "1"][i]);
                }
            }
        }
    }

    module _volume_engraving(depth = ENCLOSURE_ENGRAVING_DEPTH) {
        y = PCB_Y + PCB_VOLUME_POT_POSITION[1];
        z = height - ENCLOSURE_GRILL_GUTTER - ENCLOSURE_SIDE_ENGRAVING_SIZE / 2;

        translate([width - depth, y, z]) {
            rotate([270, 180, 270]) {
                _text_engraving("V");
            }
        }
    }

    module _output() {
        // TODO: endstop tabs for PCB -- component walls aren't enough
        // TODO: hold battery into place

        difference() {
            union() {
                translate([0, 0, height]) {
                    mirror([0, 0, 1]) {
                        _half(ENCLSOURE_TOP_HEIGHT, true);
                    }
                }

                _component_walls();
                _grill_cavities_plate();
                _switch_clutch_web_wall();
            }

            _component_walls(is_cavity = true);
            render() _grill_cavities();
            _wheel_cavities();
            _switch_clutch_cavity();
            _pcb_rails_lip_cavity();
            _top_engraving();
            _power_switch_engraving();
            _volume_engraving();
        }
    }

    _output();
}
