include <DCOX/boss.scad>

board_length = 70;
board_width = 40;
wall_thickness = 3;

ext_length = board_length + (wall_thickness * 2);
ext_width = board_width + (wall_thickness * 2);

$fn = 100;

cube([ext_width, ext_length, wall_thickness]);
cube([ext_width + wall_thickness, wall_thickness, 10]);
cube([wall_thickness, ext_length, 10]);
translate([ext_width, 0, 0]) cube([wall_thickness, ext_length + wall_thickness, 10]);
translate([0, ext_length, 0]) cube([ext_width + wall_thickness, wall_thickness, 10]);


translate([ext_width / 2 + (wall_thickness / 2), ext_length / 2 + (wall_thickness / 2), wall_thickness]) four_boss_for_insert("M2", 30, 60, height = 5); 
