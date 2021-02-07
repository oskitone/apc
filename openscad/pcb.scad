// TODO: extract parts to common repo
use <../../poly555/openscad/lib/switch.scad>;

PCB_WIDTH = 63.2714;
PCB_LENGTH = 46.0756;
PCB_HEIGHT = 1.6;

PCB_BOTTOM_CLEARANCE = 1;

PCB_SPEAKER_POSITION = [PCB_WIDTH / 2, 31.046];
SPEAKER_DIAMETER = 29.85;

PCB_POT_POSITIONS = [
    [9.51 - 2.52, 7.551 + 7],
    [58.736 - 2.52, 7.551 + 7]
];

PTV09A_POT_BASE_WIDTH = 10;
PTV09A_POT_BASE_HEIGHT = 6.8;
PTV09A_POT_ACTUATOR_DIAMETER = 6;
PTV09A_POT_ACTUATOR_BASE_DIAMETER = 6.9;
PTV09A_POT_ACTUATOR_BASE_HEIGHT = 2;
PTV09A_POT_ACTUATOR_HEIGHT = 20 - PTV09A_POT_BASE_HEIGHT;
PTV09A_POT_ACTUATOR_D_SHAFT_HEIGHT = 7;
PTV09A_POT_ACTUATOR_D_SHAFT_DEPTH = PTV09A_POT_ACTUATOR_DIAMETER - 4.5;

PCB_LED_POSITION = [13.716 - 2.54 / 2, 40.698];
LED_DIAMETER = 5;
LED_HEIGHT = 8.6;

PCB_SWITCH_POSITION = [3.556, 34.602];

PCB_VOLUME_POT_POSITION = [59.944 - 2.54, 30.919 + 2.54];
VOLUME_POT_ACTUATOR_HEIGHT = 7.8;
VOLUME_POT_ACTUATOR_DIAMETER = 6.15;

// TODO: extract from poly555
SWITCH_BASE_WIDTH = 4.4;
SWITCH_BASE_LENGTH = 8.7;
SWITCH_BASE_HEIGHT = 4.5;
SWITCH_ACTUATOR_WIDTH = 2;
SWITCH_ACTUATOR_LENGTH = 2.1;
SWITCH_ACTUATOR_HEIGHT = 3.8;
SWITCH_ACTUATOR_TRAVEL = 1.5;
SWITCH_ORIGIN = [SWITCH_BASE_WIDTH / 2, 6.36];

module pcb(
    show_board = true,
    show_speaker = true,
    show_pots = true,
    show_led = true,
    show_switch = true,
    show_volume_pot = true,

    switch_position = 0
) {
    e = .031;
    silkscreen_height = e;

    e_z = PCB_HEIGHT - e;

    if (show_board) {
        cube([PCB_WIDTH, PCB_LENGTH, PCB_HEIGHT]);

        % translate([0, 0, e_z]) {
            linear_extrude(silkscreen_height + e) offset(delta = .2) {
                import("../pcb.svg");
            }
        }
    }

    // 36MS30008-PN
    if (show_speaker) {
        translate([PCB_SPEAKER_POSITION.x, PCB_SPEAKER_POSITION.y, e_z]) {
            % cylinder(d = SPEAKER_DIAMETER, h = 12.7 + e);
        }
    }

    if (show_pots) {
        for (xy = PCB_POT_POSITIONS) {
            translate([xy.x - 7.35 + 2.52, xy.y + 1.5 - 7, e_z]) {
                % cube([PTV09A_POT_BASE_WIDTH, 11, PTV09A_POT_BASE_HEIGHT]);
            }

            translate([xy.x, xy.y, e_z + PTV09A_POT_BASE_HEIGHT]) {
                % difference() {
                    cylinder(
                        d = PTV09A_POT_ACTUATOR_DIAMETER,
                        h = PTV09A_POT_ACTUATOR_HEIGHT
                    );

                    translate([
                        PTV09A_POT_ACTUATOR_DIAMETER / -2,
                        PTV09A_POT_ACTUATOR_DIAMETER / -2 - e,
                        PTV09A_POT_ACTUATOR_HEIGHT
                            - PTV09A_POT_ACTUATOR_D_SHAFT_HEIGHT
                    ]) {
                        cube([
                            PTV09A_POT_ACTUATOR_DIAMETER,
                            PTV09A_POT_ACTUATOR_D_SHAFT_DEPTH + e,
                            PTV09A_POT_ACTUATOR_D_SHAFT_HEIGHT + e
                        ]);
                    }
                }
            }
        }
    }

    if (show_led) {
        translate([PCB_LED_POSITION.x, PCB_LED_POSITION.y, e_z]) {
            % cylinder(d = LED_DIAMETER, h = LED_HEIGHT + e);
        }
    }

    if (show_switch) {
        translate([PCB_SWITCH_POSITION.x, PCB_SWITCH_POSITION.y, e_z]) {
            % switch(switch_position);
        }
    }

    if (show_volume_pot) {
        translate([PCB_VOLUME_POT_POSITION.x, PCB_VOLUME_POT_POSITION.y, e_z]) {
            % cylinder(
                d = VOLUME_POT_ACTUATOR_DIAMETER,
                h = VOLUME_POT_ACTUATOR_HEIGHT
            );
        }
    }
}
