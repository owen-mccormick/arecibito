// Spacer - fits between gear mount and platform

$fn = 80;

rodRadius = 5;
motorHeight = 64;
spacerRadius = 60;

difference() {
    cylinder(r = spacerRadius, h = motorHeight);
    translate([0, 0, -0.5])
    cylinder(r = rodRadius, h = motorHeight + 1);
}
