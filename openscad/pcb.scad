PCB_WIDTH = 63.2714;
PCB_LENGTH = 46.0756;
PCB_HEIGHT = 1.6;
PCB_MOUNT_HOLE_DIAMETER = 3.2;

module pcb() {
    e = .0031;
    silkscreen_height = e;

    cube([PCB_WIDTH, PCB_LENGTH, PCB_HEIGHT]);

    % translate([0, 0, PCB_HEIGHT - e]) {
        linear_extrude(silkscreen_height + e * 2) offset(delta = .2) {
            import("../pcb.svg");
        }
    }
}

# pcb();
