include <shared_constants.scad>;

CROSS_SECTION_WIDTH = "cross_section_width";
CROSS_SECTION_HEIGHT = "cross_section_length";
CROSS_SECTION_BRANDING = "cross_section_branding";

module cross_section(cross_section_name) {
    if (cross_section_name == CROSS_SECTION_WIDTH) {
        cube([ENCLOSURE_WIDTH / 2, ENCLOSURE_LENGTH * 2, ENCLOSURE_HEIGHT]);
    } else if (cross_section_name == CROSS_SECTION_HEIGHT) {
        cube([ENCLOSURE_WIDTH, ENCLOSURE_LENGTH * .8, ENCLOSURE_HEIGHT]);
    } else if (cross_section_name == CROSS_SECTION_BRANDING) {
        translate([
            ENCLOSURE_WIDTH / 5 * 1,
            ENCLOSURE_GRILL_GUTTER * 1,
            ENCLOSURE_HEIGHT - ENCLOSURE_FLOOR_CEILING
        ]) {
            cube([
                ENCLOSURE_WIDTH / 5 * (5 - 2),
                ENCLOSURE_LENGTH - GRILL_LENGTH - ENCLOSURE_GRILL_GUTTER * 2.5,
                ENCLOSURE_FLOOR_CEILING
            ]);
        }
    }
}
