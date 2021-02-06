include <shared_constants.scad>;

// TODO: fix obstruction with speaker
WHEEL_DIAMETER = 2 *
    (PCB_X + PCB_POT_POSITIONS[0][0] + ENCLOSURE_SIDE_OVEREXPOSURE);

module wheels(
    diameter = 20,
    height = 10,
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
            cylinder(
                d = diameter,
                h = height
            );
        };
    }
}
