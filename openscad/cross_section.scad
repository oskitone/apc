include <shared_constants.scad>;

CROSS_SECTION_WIDTH = "cross_section_width";
CROSS_SECTION_LENGTH = "cross_section_length";
CROSS_SECTION_BRANDING = "cross_section_branding";
CROSS_SECTION_WHEEL = "cross_section_wheel";
CROSS_SECTION_TOP_Z = "cross_section_top_z";

module cross_section(cross_section_name) {
    if (cross_section_name == CROSS_SECTION_WIDTH) {
        cube([ENCLOSURE_WIDTH / 2, ENCLOSURE_LENGTH * 2, ENCLOSURE_HEIGHT]);
    } else if (cross_section_name == CROSS_SECTION_LENGTH) {
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
    } else if (cross_section_name == CROSS_SECTION_WHEEL) {
        width = PCB_X + PCB_POT_POSITIONS[1][0];
        cube([width, ENCLOSURE_LENGTH, ENCLOSURE_HEIGHT + 10]);
    } else if (cross_section_name == CROSS_SECTION_TOP_Z) {
        z = 13.2;
        offset = 5;

        translate([
            -offset,
            -offset,
            ENCLOSURE_HEIGHT - z
        ]) {
            cube([
                ENCLOSURE_WIDTH + offset * 2,
                ENCLOSURE_LENGTH + offset * 2,
                z + offset
            ]);
        }
    }
}
