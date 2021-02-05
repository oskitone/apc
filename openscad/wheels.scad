include <shared_constants.scad>;

module wheels(
    diameter,
    height,
    y,
    z
) {
    e = .04321;

    for (xy = PCB_POT_POSITIONS) {
        translate([ENCLOSURE_WALL + ENCLOSURE_GUTTER + xy.x, y + xy.y, z]) {
            cylinder(
                d = diameter,
                h = height
            );
        };
    }
}
