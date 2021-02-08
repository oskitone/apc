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

    tolerance = DEFAULT_TOLERANCE,
    $fn = HIDEF_ROUNDING
) {
    module _hub() {
        pot_z = height - hub_ceiling -
            PTV09A_POT_BASE_HEIGHT - PTV09A_POT_ACTUATOR_HEIGHT;

        difference() {
            cylinder(
                d = hub_diameter,
                h = height
            );

            translate([0, 0, pot_z]) {
                pot(
                    show_base = false,
                    diameter_bleed = tolerance
                );
            }
        }
    }

    module _tire() {
        ring(
            diameter = diameter,
            height = height,
            thickness = ring
        );
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

    module _rounded_exposure() {
        translate([0, 0, height]) {
            donut(
                diameter = diameter,
                thickness = ring,
                segments = $preview ? 24 : 120,
                starting_angle = 0,
                coverage = 360
            );
        }
    }

    module _brodie_knob() {
        translate([0, diameter / 2 - brodie_knob_diameter / 2, 0]) {
            cylinder(
                h = height + brodie_knob_height,
                d = brodie_knob_diameter
            );

            translate([0, 0, height + brodie_knob_height]) {
                sphere(
                    d = brodie_knob_diameter
                );
            }
        }
    }

    _hub();
    _tire();
    _spokes();
    _rounded_exposure();
    _brodie_knob();
}

module wheels(
    diameter = WHEEL_DIAMETER,
    height = WHEEL_HEIGHT,
    y = 0,
    z = 0
) {
    e = .04321;

    for (xy = PCB_POT_POSITIONS) {
        translate([
            ENCLOSURE_WALL + ENCLOSURE_INTERNAL_GUTTER + xy.x,
            y + xy.y,
            z
        ]) {
            wheel();
        };
    }
}
