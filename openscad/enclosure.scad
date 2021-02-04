// TODO: extract parts to common repo
use <../../poly555/openscad/lib/enclosure.scad>;

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

    fillet = 2,
    tolerance = .1,

    show_top = true,
    show_bottom = true
) {
    e = 0.0321;

    // TODO: expose LIP_BOX_DEFAULT_LIP_HEIGHT
    bottom_height = floor_ceiling + 3;
    top_height = height - bottom_height;

    module _half(h, lip) {
        enclosure_half(
            width = width, length = length, height = h,
            wall = wall,
            floor_ceiling = floor_ceiling,
            add_lip = lip,
            remove_lip = !lip,
            fillet = fillet,
            tolerance = tolerance,
            include_tongue_and_groove = true,
            tongue_and_groove_end_length = undef
        );
    }

    module _exposures() {
        $fn = 36;

        z = height - floor_ceiling - e;
        _height = height - z + e;

        translate([wall + gutter, wall + gutter * 2 + BATTERY_LENGTH, z]) {
            translate(PCB_LED_POSITION) {
                cylinder(d = LED_DIAMETER + tolerance * 2, h = _height);
            }

            translate(PCB_SPEAKER_POSITION) {
                cylinder(d = SPEAKER_DIAMETER + tolerance * 2, h = _height);
            }

            for (xy = PCB_POT_POSITIONS) {
                base_width = 9.7;
                base_height = 6.8;

                translate([xy.x, xy.y, 0]) {
                    cylinder(
                        d = PV09_POT_ACTUATOR_DIAMETER + tolerance * 2,
                        h = _height
                    );
                }
            };
        }
    }

    if (show_bottom) {
        _half(bottom_height, false);
    }

    if (show_top) {
        difference() {
            translate([0, 0, height]) {
                mirror([0, 0, 1]) {
                    _half(top_height, true);
                }
            }

            _exposures();
        }
    }
}

# enclosure(
    show_bottom = false,
    show_top = true
);

translate([
    ENCLOSURE_WALL + ENCLOSURE_GUTTER,
    ENCLOSURE_LENGTH - ENCLOSURE_WALL - ENCLOSURE_GUTTER - PCB_LENGTH,
    ENCLOSURE_FLOOR_CEILING + PCB_BOTTOM_CLEARANCE
]) {
    # pcb();
}

translate([
    ENCLOSURE_WALL + ENCLOSURE_GUTTER,
    ENCLOSURE_WALL + ENCLOSURE_GUTTER,
    ENCLOSURE_FLOOR_CEILING + .03 // TODO: e
]) {
    battery();
}
