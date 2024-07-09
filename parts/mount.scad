// Part mounted onto tripod - holds the pipe and is traversed across by the moving motor

$fn = 50;

totalHeight = 30;
// Scaling down the radius by 3.14 gives us a whole number of teeth 2mm apart on the circumference
gearRadius = 300 / 3.14;
gearHeight = 9.5;
timingBeltToothSpacing = 2;
toleranceConstant = 0.98;
mountHoleDistance = 76.5;
mountHoleRadius = 5.1;
prismDistance = 90;
rodRadius = 5;
pipeRadius = 21.5;
pipeTrackWidth = 2;
pipeTrackDepth = 5;

// Gear to mesh with GT2 timing belt sized adapter on motor
module gt2Gear(radius) {
    cylinder(h = gearHeight, r = radius);
    for (i = [0:360 / (2 * 3.14 * radius / timingBeltToothSpacing) : 360]) {
        rotate([0, 0, i])
        translate([0.997 * radius, 0, 0])
        scale([1.6, 0.8, 1])
        cylinder(r = 2 / 3, h = gearHeight);
    }
}

difference() {
    union() {
        gt2Gear(gearRadius);
        cylinder(h = totalHeight, r = prismDistance, $fn = 3); // triangular prism
    }
    // Hole for mounting screws
    for (i = [0:120:360]) {
        rotate([0,0,i])
        translate([mountHoleDistance, 0, -0.5])
        cylinder(r = mountHoleRadius, h = totalHeight + 1);
    }
    // Hole for rod
    translate([0, 0, -0.5])
    cylinder(r = rodRadius, h = totalHeight + 1);
    // Track for pipe (unused)
    /*
    translate([0,0, totalHeight - pipeTrackDepth])
    difference() {
        
        cylinder(r = pipeRadius, h = 1 + pipeTrackDepth);
        cylinder(r = pipeRadius - pipeTrackWidth, h = 1 + pipeTrackDepth);
    }
    */
}
