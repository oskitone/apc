// TODO: extract parts to common repo
use <../../poly555/openscad/lib/basic_shapes.scad>;

include <pcb.scad>;
include <shared_constants.scad>;

WHEEL_DIAMETER = 2 *
    (PCB_X + PCB_POT_POSITIONS[0][0] + ENCLOSURE_SIDE_OVEREXPOSURE);
WHEEL_HEIGHT = ENCLOSURE_HEIGHT - Z_POT;

module wheel(
    diameter = WHEEL_DIAMETER,
    height = WHEEL_HEIGHT,
    ring = ENCLOSURE_WALL,

    hub_ceiling = ENCLOSURE_FLOOR_CEILING,
    hub_diameter = PTV09A_POT_ACTUATOR_DIAMETER + ENCLOSURE_INNER_WALL * 2,

    brodie_knob_diameter = ENCLOSURE_WALL * 2,
    brodie_knob_height = ENCLOSURE_WALL / 2,

    spokes_count = 6,
    spokes_width = 2,
    spokes_height = WHEEL_HEIGHT * .67,

    chamfer = .4,
    shim_size = .4,
    shim_count = 3,

    test_fit = false,

    tolerance = DEFAULT_TOLERANCE,
    $fn = HIDEF_ROUNDING
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
                diameter = PTV09A_POT_ACTUATOR_DIAMETER,
                height = height - hub_ceiling,
                count = shim_count,
                rotation_offset = 180,
                size = shim_size
            );

            _chamfer();
        }

        translate([0, 0, height - ring / 2]) {
            hull() {
                donut(
                    diameter = hub_diameter,
                    thickness = ring,
                    segments = $preview ? 24 : 36
                );
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
                    diameter_bleed = tolerance
                );
            }
        }
    }

    module _tire() {
        module _donut() {
            render() donut(
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

            render() cylinder_grip(
                diameter = diameter,
                height = height,
                count = round(
                    diameter * PI / (DEFAULT_RIB_LENGTH + DEFAULT_RIB_GUTTER)
                ),
                size = .8
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

    module _brodie_knob() {
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

    _hub();

    if (!test_fit) {
        _tire();
        _spokes();
        /* _brodie_knob(); */
    }
}

module wheels(
    diameter = WHEEL_DIAMETER,
    height = WHEEL_HEIGHT,
    y = 0,
    z = 0,
    test_fit = false
) {
    e = .04321;

    for (xy = PCB_POT_POSITIONS) {
        translate([
            ENCLOSURE_WALL + ENCLOSURE_INTERNAL_GUTTER + xy.x,
            y + xy.y,
            z
        ]) {
            wheel(test_fit = test_fit);
        };
    }
}

// .4 doesn't register in slicer but still seems best w/ DEFAULT_TOLERANCE
// shrug
/* shim_sizes = [.4, .5, .6];
tolerances = [0, DEFAULT_TOLERANCE, DEFAULT_TOLERANCE * 2];

for (i = [0 : len(shim_sizes) - 1]) {
    for (ii = [0 : len(tolerances) - 1]) {
        translate([i * 7.8, ii * 7.8, 0]) {
            wheel(
                test_fit = true,
                shim_size = shim_sizes[i],
                tolerance = tolerances[ii]
            );
        }
    }
} */
