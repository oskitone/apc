// TODO: extract parts to common repo
use <../../poly555/openscad/lib/basic_shapes.scad>;

include <pcb.scad>;
include <shared_constants.scad>;

WHEEL_DIAMETER = 2 *
    (PCB_X + PCB_POT_POSITIONS[0][0] + ENCLOSURE_SIDE_OVEREXPOSURE);
WHEEL_VERTICAL_EXPOSURE = 2;
WHEEL_HEIGHT = ENCLOSURE_HEIGHT - Z_POT + WHEEL_VERTICAL_EXPOSURE;
WHEEL_DIAMETER_CLEARANCE = 1;
WELL_DIAMETER = WHEEL_DIAMETER + WHEEL_DIAMETER_CLEARANCE * 2;

module wheel(
    diameter = WHEEL_DIAMETER,
    height = WHEEL_HEIGHT,
    ring = ENCLOSURE_FILLET * 2,

    hub_ceiling = ENCLOSURE_FLOOR_CEILING,
    hub_diameter = PTV09A_POT_ACTUATOR_DIAMETER + ENCLOSURE_INNER_WALL * 2,

    brodie_knob_diameter = ENCLOSURE_WALL * 2,
    brodie_knob_height = ENCLOSURE_WALL * -.75,
    brodie_knob_count = 3,

    spokes_count = 6,
    spokes_width = 2,
    spokes_height = WHEEL_HEIGHT * .5,

    chamfer = .4,
    shim_size = .5,
    shim_count = 3,

    test_fit = false,

    tolerance = DEFAULT_TOLERANCE,
    $fn = DEFAULT_ROUNDING
) {
    e = 0.043;

    module _hub() {
        pot_z = height - hub_ceiling -
            PTV09A_POT_BASE_HEIGHT - PTV09A_POT_ACTUATOR_HEIGHT;

        module _chamfer() {
            translate([0, 0, -e]) {
                cylinder(
                    d1 = PTV09A_POT_ACTUATOR_DIAMETER + tolerance * 2
                        + chamfer * 2,
                    d2 = PTV09A_POT_ACTUATOR_DIAMETER + tolerance * 2
                        - PTV09A_POT_ACTUATOR_D_SHAFT_DEPTH * 2,
                    h = chamfer + PTV09A_POT_ACTUATOR_D_SHAFT_DEPTH + e
                );
            }
        }

        difference() {
            cylinder_grip(
                diameter = PTV09A_POT_ACTUATOR_DIAMETER + tolerance * 2,
                height = height - hub_ceiling,
                count = shim_count,
                rotation_offset = 180,
                size = shim_size
            );

            _chamfer();
        }

        if (!test_fit) {
            translate([0, 0, height - ring / 2]) {
                hull() {
                    donut(
                        diameter = hub_diameter,
                        thickness = ring,
                        segments = $preview ? 24 : 36
                    );
                }
            }
        }

        difference() {
            cylinder(
                d = hub_diameter,
                h = height - ring / 2
            );

            _chamfer();

            translate([0, 0, pot_z]) {
                pot(
                    show_base = false,
                    diameter_bleed = tolerance,
                    $fn = HIDEF_ROUNDING
                );
            }
        }
    }

    module _tire() {
        module _donut() {
            donut(
                diameter = diameter,
                thickness = ring,
                segments = $preview ? 24 : 36
            );
        }

        difference() {
            union() {
                for (z = [ring / 2, height - ring / 2]) {
                    translate([0, 0, z]) {
                        _donut();
                    }
                }

                translate([0, 0, ring / 2]) {
                    ring(
                        diameter = diameter,
                        height = height - ring,
                        thickness = ring
                    );
                }
            }

            cylinder_grip(
                diameter = diameter,
                height = height,
                count = round(
                    diameter * PI / (DEFAULT_RIB_LENGTH + DEFAULT_RIB_GUTTER)
                ),
                size = .8,
                $fn = FIXED_LODEF_ROUNDING
            );
        }
    }

    module _spokes() {
        overlap = ENCLOSURE_INNER_WALL / 2; // nominal

        x = spokes_width / -2;
        y = hub_diameter / 2 - overlap;

        length = diameter / 2 - y - ring + overlap;

        for (i = [0 : spokes_count - 1]) {
            rotate([0, 0, (i / spokes_count) * 360]) {
                translate([x, y, 0]) {
                    cube([spokes_width, length, spokes_height]);
                }
            }
        }
    }

    module _brodie_knobs() {
        for (i = [0 : brodie_knob_count - 1]) {
            rotate([0, 0, i * (360 / brodie_knob_count)]) {
                translate([0, diameter / 2 - brodie_knob_diameter / 2, 0]) {
                    cylinder(
                        h = height + brodie_knob_height,
                        d1 = 0,
                        d2 = brodie_knob_diameter
                    );

                    translate([0, 0, height + brodie_knob_height]) {
                        sphere(
                            d = brodie_knob_diameter
                        );
                    }
                }
            }
        }
    }

    _hub();

    if (!test_fit) {
        _tire();
        _spokes();
        _brodie_knobs();
    }
}

function slice(list, start = 0, end) =
    end == 0
        ? []
        : [for (i = [start : (end == undef ? len(list) : end) - 1]) list[i]]
;

module wheels(
    diameter = WHEEL_DIAMETER,
    height = WHEEL_HEIGHT,
    y = 0,
    z = 0,
    test_fit = false,
    count = undef
) {
    e = .04321;

    for (xy = slice(PCB_POT_POSITIONS, 0, count)) {
        translate([
            ENCLOSURE_WALL + ENCLOSURE_INTERNAL_GUTTER + xy.x,
            y + xy.y,
            z
        ]) {
            wheel(test_fit = test_fit);
        };
    }
}

/* shim_sizes = [.5, .6, .8];
shim_counts = [2, 3, 4, 5, 6];

for (i = [0 : len(shim_sizes) - 1]) {
    for (ii = [0 : len(shim_counts) - 1]) {
        is_needle = i == 0 && ii == 1;

        translate([i * 7.8, ii * 7.8, 0]) {
            color(is_needle ? "red" : undef) {
                wheel(
                    shim_size = shim_sizes[i],
                    shim_count = shim_counts[ii],
                    test_fit = true,
                    tolerance = DEFAULT_TOLERANCE // TODO: try DEFAULT_TOLERANCE * 2,
                );
            }
        }
    }
} */
