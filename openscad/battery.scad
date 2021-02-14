BATTERY_WIDTH = 48.6;
BATTERY_LENGTH = 17.1;
BATTERY_HEIGHT = 25.8;
BATTERY_SNAP_WIDTH = 4.2;
BATTERY_SNAP_CLEARANCE = 3;

module battery(include_snap = true) {
    e = .021;

    cube([BATTERY_WIDTH, BATTERY_LENGTH, BATTERY_HEIGHT]);

    if (include_snap) {
        translate([BATTERY_WIDTH - e, 0, 0]) {
            # cube([BATTERY_SNAP_WIDTH + e * 2, BATTERY_LENGTH, BATTERY_HEIGHT]);
        }
    }
}
