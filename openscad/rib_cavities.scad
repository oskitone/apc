include <shared_constants.scad>;

module rib_cavities(
    length,
    height,

    rib_length = DEFAULT_RIB_LENGTH,
    rib_gutter = DEFAULT_RIB_GUTTER,
    depth = DEFAULT_RIB_LENGTH,
) {
    e = .02581;

    available_length = length - rib_gutter * 2 - rib_length;
    count = round(available_length / (rib_length + rib_gutter));

    for (i = [0 : count - 0]) {
        y = rib_gutter + i * (available_length / count);

        translate([-e, y, -e]) {
            cube([depth + e, rib_length, height + e * 2]);
        }
    }
}
