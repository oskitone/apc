// TODO: extract parts to common repo
use <../../poly555/openscad/lib/basic_shapes.scad>;
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
    inner_wall = 1.2,
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

    pcb_y = wall + gutter * 2 + BATTERY_LENGTH;

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
            tongue_and_groove_end_length = undef,
            $fn = 12
        );
    }

    module _component_walls(
        is_cavity = false,
        $fn = 36
    ) {
        z_pcb_top = floor_ceiling + PCB_BOTTOM_CLEARANCE + PCB_HEIGHT
            + (is_cavity ? -e : 0);
        z_pot = z_pcb_top + PV09_POT_BASE_HEIGHT
            + (is_cavity ? -e : 0);

        bleed = is_cavity ? tolerance : inner_wall;
        _height = is_cavity ? height + e : height - floor_ceiling + e;

        translate([wall + gutter, pcb_y, 0]) {
            translate([
                PCB_LED_POSITION.x,
                PCB_LED_POSITION.y,
                z_pcb_top
            ]) {
                cylinder(
                    d = LED_DIAMETER + bleed * 2,
                    h = _height - z_pcb_top
                );
            }

            translate([
                PCB_SPEAKER_POSITION.x,
                PCB_SPEAKER_POSITION.y,
                z_pcb_top
            ]) {
                cylinder(
                    d = SPEAKER_DIAMETER + bleed * 2,
                    h = _height - z_pcb_top
                );
            }

            for (xy = PCB_POT_POSITIONS) {
                base_width = 9.7;
                base_height = 6.8;

                translate([xy.x, xy.y, z_pot]) {
                    cylinder(
                        d = PV09_POT_ACTUATOR_DIAMETER + bleed * 2,
                        h = _height - z_pot
                    );
                }
            };
        }
    }

    module _accent_cavities(depth = .4, _fillet = 1) {
        _gutter = gutter + 1;
        _length = (length - _gutter * 2) * .5;
        y = length - _length - _gutter;

        translate([_gutter, y, height - depth]) {
            rounded_xy_cube(
                [width - _gutter * 2, _length, depth + e],
                radius = _fillet,
                $fn = 12
            );
        }
    }

    if (show_bottom) {
        _half(bottom_height, false);
    }

    if (show_top) {
        difference() {
            union() {
                translate([0, 0, height]) {
                    mirror([0, 0, 1]) {
                        _half(top_height, true);
                    }
                }

                _component_walls();
            }

            _component_walls(is_cavity = true);
            _accent_cavities();
        }
    }
}

enclosure(
    show_bottom = false,
    show_top = true,
    fillet = 2
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
