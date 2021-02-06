// TODO: extract parts to common repo
use <../../poly555/openscad/lib/basic_shapes.scad>;
use <../../poly555/openscad/lib/enclosure.scad>;
use <../../poly555/openscad/lib/diagonal_grill.scad>;

include <shared_constants.scad>;

// TODO: expose LIP_BOX_DEFAULT_LIP_HEIGHT
ENCLOSURE_BOTTOM_HEIGHT = ENCLOSURE_FLOOR_CEILING + 3;
ENCLSOURE_TOP_HEIGHT = ENCLOSURE_HEIGHT - ENCLOSURE_BOTTOM_HEIGHT;

Z_PCB_TOP = ENCLOSURE_FLOOR_CEILING + PCB_Z + PCB_HEIGHT;

module enclosure(
    width = ENCLOSURE_WIDTH,
    length = ENCLOSURE_LENGTH,
    height = ENCLOSURE_HEIGHT,

    wall = ENCLOSURE_WALL,
    inner_wall = 1.2,
    floor_ceiling = ENCLOSURE_FLOOR_CEILING,
    gutter = ENCLOSURE_INTERNAL_GUTTER,

    grill_depth = 1,
    grill_gutter = 3,
    grill_ring = 2,

    side_overexposure = ENCLOSURE_SIDE_OVEREXPOSURE,

    fillet = 2,
    tolerance = DEFAULT_TOLERANCE,

    show_top = true,
    show_bottom = true
) {
    e = 0.0321;

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

    module _component_walls(
        is_cavity = false,
        $fn = 36
    ) {
        Z_PCB_TOP = Z_PCB_TOP + (is_cavity ? -e : 0);

        bleed = is_cavity ? tolerance : inner_wall;

        function get_height(z, expose = is_cavity) =
            height - z + (expose ? e : e - floor_ceiling);

        module _pot_walls() {
            diameter = WHEEL_DIAMETER + bleed * 2;
            y = PCB_Y + PCB_POT_POSITIONS[0][1];
            z = Z_PCB_TOP + PTV09A_POT_BASE_HEIGHT;

            intersection() {
                translate([wall - e, y - diameter / 2 - e, 0]) {
                    cube([width - wall * 2 - e * 2, diameter + e * 2, 100]);
                }

                for (xy = PCB_POT_POSITIONS) {
                    base_width = 9.7;
                    base_height = 6.8;

                    translate([PCB_X + xy.x, y, z]) {
                        cylinder(
                            d = diameter,
                            h = get_height(z)
                        );
                    }
                };
            }
        }

        translate([
            PCB_X + PCB_LED_POSITION.x,
            PCB_Y + PCB_LED_POSITION.y,
            Z_PCB_TOP
        ]) {
            cylinder(
                d = LED_DIAMETER + bleed * 2,
                h = get_height(Z_PCB_TOP)
            );
        }

        translate([
            PCB_X + PCB_SPEAKER_POSITION.x,
            PCB_Y + PCB_SPEAKER_POSITION.y,
            Z_PCB_TOP
        ]) {
            cylinder(
                d = SPEAKER_DIAMETER + bleed * 2,
                h = get_height(Z_PCB_TOP, false) +
                    (is_cavity ? floor_ceiling - grill_depth : 0)
            );
        }

        if (!is_cavity) {
            _pot_walls();
        }
    }

    module _grill(depth = grill_depth, coverage = .5, _fillet = 1) {
        _depth = depth + e;
        _length = (length - grill_gutter * 2) * coverage;

        y = length - _length - grill_gutter;
        z = height - depth;

        module _rounding(height = _depth) {
            rounded_xy_cube(
                [width - grill_gutter * 2, _length, height],
                radius = _fillet,
                $fn = 12
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
                    base_width = 9.7;
                    base_height = 6.8;

                    translate([xy.x, xy.y, z - e]) {
                        cylinder(
                            d = WHEEL_DIAMETER + grill_ring * 2,
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

    module _pot_cavities() {
        z = Z_POT - e;

        // TODO: add shaft holes

        for (xy = PCB_POT_POSITIONS) {
            translate([wall + gutter + xy.x, PCB_Y + xy.y, z]) {
                cylinder(
                    d = WHEEL_DIAMETER + tolerance * 4, // intentionally loose
                    h = height - z + e
                );
            };
        }
    }

    module _switch_clutch_cavity() {
        y_tolerance = tolerance * 2; // intentionally loose

        y = get_switch_clutch_y(0) - y_tolerance;

        length = SWITCH_CLUTCH_LENGTH
            + SWITCH_ACTUATOR_TRAVEL
            + y_tolerance * 2;
        height = SWITCH_CLUTCH_HEIGHT + Z_PCB_TOP + e;

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

    if (show_bottom) {
        // TODO: ensure PCB and battery are held into place

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
            _grill();
            _pot_cavities();
            _switch_clutch_cavity();
        }
    }
}
