// TODO: extract parts to common repo
use <../../poly555/openscad/lib/switch.scad>;

PCB_WIDTH = 63.2714;
PCB_LENGTH = 46.0756;
PCB_HEIGHT = 1.6;
PCB_MOUNT_HOLE_DIAMETER = 3.2;

module pcb(
    show_speaker = true,
    show_pots = true,
    show_led = true,
    show_switch = true,
    show_volume_pot = true
) {
    e = .031;
    silkscreen_height = e;

    e_z = PCB_HEIGHT - e;

    cube([PCB_WIDTH, PCB_LENGTH, PCB_HEIGHT]);

    % translate([0, 0, e_z]) {
        linear_extrude(silkscreen_height + e) offset(delta = .2) {
            import("../pcb.svg");
        }
    }

    // 36MS30008-PN
    if (show_speaker) {
        translate([PCB_WIDTH / 2, 31.046, e_z]) {
            % cylinder(d = 29.85, h = 12.7 + e);
        }
    }

    if (show_pots) {
        y = 7.551;

        for (x = [9.51, 58.736]) {
            base_width = 9.7;
            base_height = 6.8;

            translate([x - 7.35, y + 1.5, e_z]) {
                % cube([base_width, 11, base_height]);
            }

            translate([x - 2.52, y + 7, e_z]) {
                % cylinder(d = 6.8, h = 20);
            }
        }
    }

    if (show_led) {
        translate([13.716 - 2.54 / 2, 40.698, e_z]) {
            % cylinder(d = 5, h = 9.6 + e);
        }
    }

    if (show_switch) {
        translate([3.556, 34.602, e_z]) {
            % switch();
        }
    }

    if (show_volume_pot) {
        translate([59.944 - 2.54, 30.919 + 2.54, e_z]) {
            % cylinder(d = 6.15, h = 7.8);
        }
    }
}
