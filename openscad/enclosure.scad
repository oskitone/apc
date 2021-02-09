// TODO: extract parts to common repo
use <../../poly555/openscad/lib/basic_shapes.scad>;
use <../../poly555/openscad/lib/enclosure.scad>;
use <../../poly555/openscad/lib/diagonal_grill.scad>;

include <shared_constants.scad>;

// TODO: expose LIP_BOX_DEFAULT_LIP_HEIGHT
ENCLOSURE_BOTTOM_HEIGHT = ENCLOSURE_FLOOR_CEILING + 3;
ENCLSOURE_TOP_HEIGHT = ENCLOSURE_HEIGHT - ENCLOSURE_BOTTOM_HEIGHT;

module _pot_walls(
    diameter_bleed = 0,
    height_bleed = 0
) {
    e = .0321;

    y = PCB_Y + PCB_POT_POSITIONS[0][1];

    module _well() {
        diameter = WELL_DIAMETER + diameter_bleed * 2;
        z = ENCLOSURE_HEIGHT - WHEEL_HEIGHT - ENCLOSURE_FLOOR_CEILING
            - height_bleed;

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

module enclosure(
    width = ENCLOSURE_WIDTH,
    length = ENCLOSURE_LENGTH,
    height = ENCLOSURE_HEIGHT,

    wall = ENCLOSURE_WALL,
    inner_wall = ENCLOSURE_INNER_WALL,
    floor_ceiling = ENCLOSURE_FLOOR_CEILING,
    gutter = ENCLOSURE_INTERNAL_GUTTER,

    grill_depth = ENCLOSURE_GRILL_DEPTH,
    grill_gutter = 3,
    grill_ring = 2,
    grill_coverage = .5,
    grill_fillet = 1,

    side_overexposure = ENCLOSURE_SIDE_OVEREXPOSURE,

    fillet = 2,
    tolerance = DEFAULT_TOLERANCE,

    show_top = true,
    show_bottom = true,

    show_dfm = true,

    enclosure_bottom_position = 0
) {
    e = 0.0321;

    grill_length = (length - grill_gutter * 2) * grill_coverage;

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
            $fn = DEFAULT_ROUNDING
        );
    }

    // TODO: fix PCB sitting unevenly on walls -- should be perfectly flat
    module _component_walls(is_cavity = false) {
        $fn = is_cavity ? HIDEF_ROUNDING : DEFAULT_ROUNDING;

        Z_PCB_TOP = Z_PCB_TOP + (is_cavity ? -e : 0);

        led_bleed = is_cavity ? tolerance : 3;
        speaker_bleed = is_cavity ? tolerance : inner_wall;

        function get_height(z, expose = is_cavity) =
            height - z + (expose ? e : e - floor_ceiling);

        translate([
            PCB_X + PCB_LED_POSITION.x,
            PCB_Y + PCB_LED_POSITION.y,
            Z_PCB_TOP
        ]) {
            cylinder(
                d = LED_BASE_DIAMETER + led_bleed * 2,
                h = get_height(Z_PCB_TOP)
            );
        }

        translate([
            PCB_X + PCB_SPEAKER_POSITION.x,
            PCB_Y + PCB_SPEAKER_POSITION.y,
            Z_PCB_TOP
        ]) {
            cylinder(
                d = SPEAKER_DIAMETER + speaker_bleed * 2,
                h = get_height(Z_PCB_TOP, false) +
                    (is_cavity ? floor_ceiling - grill_depth : 0)
            );
        }

        if (!is_cavity) {
            _pot_walls(inner_wall);
        }
    }

    module _grill_cavities_plate() {
        x = wall - e;
        _width = width - x * 2;
        _length = grill_length - wall + grill_gutter * 2 + e;
        y = length - _length - wall + e;
        z = height - grill_depth - floor_ceiling;

        translate([x, y, z]) {
            cube([_width, _length, grill_depth + e]);
        }
    }

    // TODO: extend grill to full speaker cavity height
    module _grill_cavities() {
        _depth = grill_depth + e;
        _length = grill_length;

        y = length - _length - grill_gutter;
        z = height - grill_depth;

        module _rounding(height = _depth) {
            rounded_xy_cube(
                [width - grill_gutter * 2, _length, height],
                radius = grill_fillet,
                $fn = DEFAULT_ROUNDING
            );
        }

        module _diagonal_grill(height = _depth) {
            diagonal_grill(
                width - grill_gutter * 2, _length, height,
                size = 2,
                angle = 45
            );
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
                    translate([xy.x, xy.y, z - e]) {
                        cylinder(
                            d = WELL_DIAMETER + grill_ring * 2,
                            h = _depth + e * 2
                        );
                    }
                };

                translate([
                    PCB_LED_POSITION.x,
                    PCB_LED_POSITION.y,
                    z - e
                ]) {
                    cylinder(
                        d = LED_DIAMETER + grill_ring * 2,
                        h = _depth + e * 2
                    );
                }
            }
        }
    }

    module _wheel_cavities() {
        well_z = ENCLOSURE_HEIGHT - WHEEL_HEIGHT - e;
        shaft_to_base_z = PCB_Z + PCB_HEIGHT + PTV09A_POT_BASE_HEIGHT - e;

        exposure_diameter = PTV09A_POT_ACTUATOR_BASE_DIAMETER + tolerance * 2;

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
                }
            };
        }
    }

    module _switch_clutch_cavity() {
        y = get_switch_clutch_y(0) - SWITCH_CLUTCH_SLIDE_CLEARANCE;

        length = SWITCH_CLUTCH_LENGTH
            + SWITCH_ACTUATOR_TRAVEL
            + SWITCH_CLUTCH_SLIDE_CLEARANCE * 2;
        height = SWITCH_CLUTCH_HEIGHT + Z_PCB_TOP
            + SWITCH_CLUTCH_VERTICAL_CLEARANCE
            + e;

        translate([-e, y, -e]) {
            cube([wall + e * 2, length, height]);
        }
    }

    module _switch_clutch_wall() {
        width = inner_wall;
        length = SWITCH_BASE_LENGTH;
        _height = ENCLSOURE_TOP_HEIGHT - SWITCH_CLUTCH_HEIGHT
            - floor_ceiling - grill_depth;

        translate([
            SWITCH_CLUTCH_WEB_X - side_overexposure
                + SWITCH_CLUTCH_WEB_WIDTH + tolerance * 2,
            PCB_Y + PCB_SWITCH_POSITION[1] - SWITCH_ORIGIN[1],
            height - floor_ceiling - _height - grill_depth
        ]) {
            cube([width, length, _height + e]);
        }
    }

    module _pcb_rails() {
        _width = inner_wall;
        _length = 30;
        _height = PCB_Z - floor_ceiling;
        _gutter = 25;

        y = PCB_Y + PCB_LENGTH - _length;

        module _rail() {
            cube([_width, _length, _height + e]);

            translate([0, -_height, 0]) {
                flat_top_rectangular_pyramid(
                    top_width = _width,
                    top_length = 0,
                    bottom_width = _width,
                    bottom_length = _height + e,
                    height = _height + e,
                    top_weight_y = 1
                );
            }
        }

        for (x = [
            (width - _width - _gutter) / 2,
            (width - _width + _gutter) / 2
        ]) {
            translate([x, y, floor_ceiling - e]) {
                _rail();
            }
        }
    }

    if (show_bottom) {
        _pcb_rails();

        translate([0, ENCLOSURE_LENGTH * enclosure_bottom_position, 0]) {
            _half(ENCLOSURE_BOTTOM_HEIGHT, false);
        }
    }

    if (show_top) {
        _switch_clutch_wall();
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
            }

            _component_walls(is_cavity = true);
            _grill_cavities();
            _wheel_cavities();
            _switch_clutch_cavity();
        }
    }
}
