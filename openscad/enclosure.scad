include <battery.scad>;
include <pcb.scad>;

ENCLOSURE_WALL = 2.4;
ENCLOSURE_FLOOR_CEILING = 1.8;
ENCLOSURE_GUTTER = 2;

ENCLOSURE_WIDTH = PCB_WIDTH
    + ENCLOSURE_GUTTER * 2
    + ENCLOSURE_WALL * 2;
ENCLOSURE_LENGTH = PCB_LENGTH
    + BATTERY_LENGTH
    + ENCLOSURE_GUTTER * 3
    + ENCLOSURE_WALL * 2;
ENCLOSURE_HEIGHT = BATTERY_HEIGHT
    + ENCLOSURE_WALL * 2;

module enclosure(
    width = ENCLOSURE_WIDTH,
    length = ENCLOSURE_LENGTH,
    height = ENCLOSURE_HEIGHT,

    wall = ENCLOSURE_WALL,
    floor_ceiling = ENCLOSURE_FLOOR_CEILING,
    gutter = ENCLOSURE_GUTTER,

    pcb_bottom_clearance = 1
) {
    e = 0.0321;

    difference() {
        cube([width, length, height / 2]);

        translate([wall, wall, floor_ceiling]) {
            cube([width - wall * 2, length - wall * 2, height]);
        }
    }

    translate([
        wall + gutter,
        length - wall - gutter - PCB_LENGTH,
        floor_ceiling + pcb_bottom_clearance
    ]) {
        # pcb();
    }

    translate([wall + gutter,
        wall + gutter,
        floor_ceiling + e
    ]) {
        battery();
    }
}

enclosure();
