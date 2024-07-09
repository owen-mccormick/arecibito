// Bracket - screws onto the platform and connects it with the rod and pipe

$fn = 80;

totalHeight = 120;
bearingRadius = 11.25;
pipeRadius = 20;
pipeTrackWidth = 2.25;
pipeTrackDepth = 110;
screwRadius = 2;

difference() {
    union() {
        cylinder(r = pipeRadius + pipeTrackWidth * 2, h = totalHeight);
        // Screw mount points
        scale([1.5, 0.5, 1])
        cylinder(r = 2 * pipeRadius, h = totalHeight - pipeTrackDepth);
        scale([0.5, 1.5, 1])
        cylinder(r = 2 * pipeRadius, h = totalHeight - pipeTrackDepth);
    }
    // Pipe track
    translate([0, 0, totalHeight - pipeTrackDepth])
    difference() {
        cylinder(r = pipeRadius + pipeTrackWidth / 2, h = totalHeight);
        cylinder(r = pipeRadius - pipeTrackWidth / 2, h = totalHeight);
    }
    // Hole for central rod with bearing
    translate([0, 0, -0.5])
    cylinder(r = bearingRadius, h = totalHeight + 1);
    // Screw holes
    for (i = [0 : 90 : 360]) {
        rotate([0, 0, i])
        translate([2 * pipeRadius, 0, -0.5])
        cylinder(r = screwRadius, h = totalHeight - pipeTrackDepth + 1);
    }
}