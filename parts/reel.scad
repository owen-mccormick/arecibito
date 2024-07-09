// Reel assembly that pulls cables to raise or lower the dish altitude

use <mount.scad>

$fn = 80;

bearingWidth = 10;
bearingRadius = 11.25;
mountLength = 80;
gearCenterOff = 42;
gearRadius = (gearCenterOff - 2) * 3 / 3.14; // guarantees an integer number of teeth on the circumference
mountHeight = 80;
motorMountSpacing = 46.5;
motorShaft = 25;
screwRadius = 2.6;
baseScrewRadius = 2;
supportHeight = mountHeight / 2 + 2 * bearingRadius;
plateSpacing = 100;
bearingInternalRadius = 3.75;
gearHeight = 9.5;
addedBaseThickness = 10;
screwDivotRadius = 8;
motorFaceToGear = 15;
reelRadius = 6 * bearingInternalRadius;

module reelBase() {
    difference() {
        union() {
            // Motor holder
            cube([mountLength, bearingWidth, mountHeight], center = true);
            // Reel holder A
            translate([-gearCenterOff, -plateSpacing, supportHeight / 2 - mountHeight / 2])
            cube([bearingRadius * 4, bearingWidth, supportHeight], center = true);
            // Reel holder B
            translate([-gearCenterOff, 0, supportHeight / 2 - mountHeight / 2])
            cube([bearingRadius * 4, bearingWidth, supportHeight], center = true);
            // Base
            translate([mountLength / 2 - 0.25 * mountLength - gearCenterOff / 2 - bearingRadius, -plateSpacing / 2, -mountHeight / 2 - addedBaseThickness / 2])
            cube([0.5 * mountLength + gearCenterOff + bearingRadius * 2, bearingWidth + plateSpacing, bearingWidth + addedBaseThickness], center = true);
        }
        // Bearing hole for reel
        translate([-gearCenterOff, -plateSpacing / 2, 0])
        rotate([90, 0, 0])
        cylinder(r = bearingRadius, h = plateSpacing * 2, center = true);
        // Motor mounting holes
        rotate([90, 0, 0])
        union() {
            for (i = [0:45:360]) {
                if (i % 90 != 0) {
                    rotate([0, 0, i])
                    translate([sqrt(2) * motorMountSpacing / 2, 0, 0])
                    cylinder(r = screwRadius, h = bearingWidth + 1, center = true);
                }
            }
            cylinder(r = motorShaft, h = bearingWidth + 1, center = true);
        }
        // Screw holes on the base plate
        translate([0.45 * mountHeight, -plateSpacing, -mountHeight / 2 - addedBaseThickness / 2])
        cylinder(r = baseScrewRadius, h = bearingWidth + addedBaseThickness + 1, center = true);
        translate([-gearCenterOff - 1.5 * bearingRadius, -bearingWidth / 2 - plateSpacing / 2, -mountHeight / 2 - addedBaseThickness / 2])
        cylinder(r = baseScrewRadius, h = bearingWidth + addedBaseThickness + 1, center = true);
        // Divots
        translate([0.45 * mountHeight, -plateSpacing, -mountHeight / 2 - addedBaseThickness / 2])
        cylinder(r = screwDivotRadius, h = bearingWidth + addedBaseThickness + 1);
        translate([-gearCenterOff - 1.5 * bearingRadius, -bearingWidth / 2 - plateSpacing / 2, -mountHeight / 2 - addedBaseThickness / 2])
        cylinder(r = screwDivotRadius, h = bearingWidth + addedBaseThickness + 1);
    }
}

module reelGear() {
    // Bearing insert
    translate([-gearCenterOff, 0, 0])
    rotate([90, 0, 0])
    cylinder(r = bearingInternalRadius, h = 2 * bearingWidth, center = true);
    
    // Gear
    translate([-gearCenterOff, motorFaceToGear + gearHeight - bearingWidth / 2, 0])
    rotate([90, 0, 0])
    gt2Gear(gearRadius);
}

module reelShaft() {
    difference() {
        union() {
            translate([-gearCenterOff, -plateSpacing, 0])
            rotate([90, 0, 0])
            cylinder(r = bearingInternalRadius, h = 1.5 * bearingWidth,     center = true);
            translate([-gearCenterOff, -bearingWidth, 0])
            rotate([90, 0, 0])
            cylinder(r = reelRadius, h = plateSpacing * 0.845);
        }
        //translate([-gearCenterOff, 0, 0])
        //rotate([90, 0, 0])
        //cylinder(r = bearingInternalRadius + 0.5, h = 3.5 * bearingWidth + 1, center = true);
        // Holes to tie in rope coil ends
        translate([-gearCenterOff, -plateSpacing / 3, 0])
        rotate([0, 90, 0])
        cylinder(r = baseScrewRadius, h = 2 * reelRadius + 1, center = true);
        translate([-gearCenterOff, -2 * plateSpacing / 3, 0])
        rotate([0, 90, 0])
        cylinder(r = baseScrewRadius, h = 2 * reelRadius + 1, center = true);
    }
}

reelBase();
%reelGear();
reelShaft();
