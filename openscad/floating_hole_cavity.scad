include <shared_constants.scad>;

module floating_hole_cavity(
    minimum_diameter,
    maximum_diameter,

    coverages = [1, .5, 0, 0],
    layer_height = DEFAULT_DFM_LAYER_HEIGHT,

    $fn = HIDEF_ROUNDING
) {
    e = .0245;

    function get_span(
        coverage = 0,
        minimum = minimum_diameter,
        maximum = maximum_diameter
    ) = (
        minimum + coverage * (maximum - minimum)
    );

    intersection() {
        translate([0, 0, layer_height * -len(coverages) - e]) {
            cylinder(
                d = maximum_diameter + e * 2,
                h = layer_height * len(coverages) + e * 2
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
