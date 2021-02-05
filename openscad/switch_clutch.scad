include <shared_constants.scad>;

SWITCH_CLUTCH_LENGTH = SWITCH_ACTUATOR_LENGTH + ENCLOSURE_WALL * 2;
SWITCH_CLUTCH_HEIGHT = SWITCH_BASE_HEIGHT * 2 + SWITCH_ACTUATOR_HEIGHT;

// TODO: fix obstruction with speaker
SWITCH_CLUTCH_WIDTH =  PCB_X + PCB_SWITCH_POSITION[0]
    + SWITCH_BASE_WIDTH / 2
    + ENCLOSURE_SIDE_OVEREXPOSURE;
SWITCH_CLUTCH_WEB_X = ENCLOSURE_SIDE_OVEREXPOSURE + ENCLOSURE_WALL
    + DEFAULT_TOLERANCE * 2;
SWITCH_CLUTCH_WEB_WIDTH = SWITCH_CLUTCH_WIDTH
    - SWITCH_BASE_WIDTH - DEFAULT_TOLERANCE - SWITCH_CLUTCH_WEB_X;

function get_switch_clutch_y(position = 0) = (
    PCB_Y + PCB_SWITCH_POSITION[1] - SWITCH_ORIGIN[1]
        + SWITCH_BASE_LENGTH / 2
        - SWITCH_ACTUATOR_TRAVEL / 2
        + SWITCH_ACTUATOR_TRAVEL * position
        - SWITCH_CLUTCH_LENGTH / 2
);

module _switch_clutch(
    _fillet = 1,
    side_overexposure = ENCLOSURE_SIDE_OVEREXPOSURE,
    tolerance = DEFAULT_TOLERANCE,
    floor_ceiling = ENCLOSURE_FLOOR_CEILING,
    switch_position = 0,
    web_height = 10
) {
    e = .045321;

    x = -side_overexposure;
    y = get_switch_clutch_y(switch_position);

    module _clutch() {
        cavity_width =
            (SWITCH_BASE_WIDTH - SWITCH_ACTUATOR_WIDTH) / 2
            + SWITCH_ACTUATOR_WIDTH
            + tolerance;
        cavity_length = SWITCH_ACTUATOR_LENGTH + tolerance * 2;

        module _rib_cavities(
            rib_length = .8,
            depth = .4,
            rib_gutter = 1.234
        ) {
            available_length = SWITCH_CLUTCH_LENGTH
                - rib_gutter * 2 - rib_length;
            count = round(available_length / (rib_length + rib_gutter));

            for (i = [0 : count - 0]) {
                y = rib_gutter + i * (available_length / count);

                translate([-e, y, -e]) {
                    cube([
                        depth + e,
                        rib_length,
                        SWITCH_CLUTCH_HEIGHT + e * 2
                    ]);
                }
            }
        }

        module _web() {
            overlap = 1;
            length = SWITCH_BASE_LENGTH + SWITCH_ACTUATOR_TRAVEL
                + overlap * 2;

            translate([
                SWITCH_CLUTCH_WEB_X,
                (SWITCH_CLUTCH_LENGTH - length) / 2,
                0
            ]) {
                cube([
                    SWITCH_CLUTCH_WEB_WIDTH,
                    length,
                    web_height
                ]);
            }
        }

        _web();

        difference() {
            rounded_cube(
                [
                    SWITCH_CLUTCH_WIDTH,
                    SWITCH_CLUTCH_LENGTH,
                    SWITCH_CLUTCH_HEIGHT
                ],
                radius = _fillet,
                $fn = 12
            );

            _rib_cavities();

            translate([
                SWITCH_CLUTCH_WIDTH - SWITCH_BASE_WIDTH
                    - DEFAULT_TOLERANCE - e,
                -e,
                -e
            ]) {
                cube([
                    SWITCH_BASE_WIDTH + DEFAULT_TOLERANCE + e,
                    SWITCH_CLUTCH_LENGTH + e * 2,
                    SWITCH_BASE_HEIGHT + e
                ]);
            }

            translate([
                SWITCH_CLUTCH_WIDTH - cavity_width,
                (SWITCH_CLUTCH_LENGTH - cavity_length) / 2,
                SWITCH_BASE_HEIGHT - e
            ]) {
                cube([
                    cavity_width + e,
                    cavity_length,
                    SWITCH_ACTUATOR_HEIGHT + e + tolerance // just in case
                ]);
            }
        }
    }

    translate([x, y, 0]) {// Z_PCB_TOP
        _clutch();
    }
}
