// ============================================================================
// BOSS SPECIFICATIONS DATABASE
// ============================================================================
    
include <utils.scad>    

$BOSS_COLOR = "Yellow";
    
function get_boss_spec(boss_type) =
  let(
    BOSS_SPECS_TABLE = [
      //       boss   insert   height  screw 
      ["M4",   [7.0,   4.6,    5.0,    4.3]], // NOT TESTED !
      ["M3",   [6.0,   3.8,    5.0,    3.4]],
      ["M2.5", [5.0,   3.0,    5.0,    2.8]],
      ["M2",   [4.6,   2.6,    5.0,    2.5]]
    ],
    idx = search_in_table(boss_type, BOSS_SPECS_TABLE, 0)
  )
  assert(idx >= 0, str("Unknown boss type: ", boss_type))
  BOSS_SPECS_TABLE[idx][1];
  
// ============================================================================
// HELPER FUNCTIONS TO ACCESS SPEC VALUES
// ============================================================================

function boss_diameter(spec) = spec[0];
function insert_hole_diameter(spec) = spec[1];
function boss_height(spec) = spec[2];
function screw_hole_diameter(spec) = spec[3];

// ============================================================================
// SPACER FOR SCREW
// ============================================================================

module spacer_for_screw(type, height=0) {
    spec = get_boss_spec(type); 
    h = height != 0 ? height : boss_height(spec);
    d = boss_diameter(spec);
    dh = insert_hole_diameter(spec);
    color($BOSS_COLOR)
    difference() {
        // boss 
        cylinder(h=h, d=d);
        // hole
        translate([0, 0, -0.1])
            cylinder(h=h+0.2, d=dh);
    }
}


// ============================================================================
// BOSS FOR HEAT-UP BRASS INSERT
// ============================================================================

module boss_for_insert(type, height=0) {
    spec = get_boss_spec(type); 
    h = height != 0 ? height : boss_height(spec);
    d = boss_diameter(spec);
    dh = insert_hole_diameter(spec);
    color($BOSS_COLOR)
    difference() {
        // Boss 
        cylinder(h=h, d=d);
        // Hole
        translate([0, 0, -0.1])
            cylinder(h=h+0.2, d=dh);
        // Bevel 
        translate([0, 0, h - 0.5])
            cylinder(h=0.6, d1=dh, d2=dh+1.5);
    }
}

// ============================================================================
// 4 BOSS 
// ============================================================================

module four_boss_for_insert(type, x_pitch, y_pitch, height=0) {
    translate([- x_pitch / 2, - y_pitch / 2, 0])            
        boss_for_insert(type, height);
    translate([- x_pitch / 2, y_pitch / 2, 0])            
        boss_for_insert(type, height);
    translate([x_pitch / 2, y_pitch / 2, 0])            
        boss_for_insert(type, height);
    translate([x_pitch / 2, - y_pitch / 2, 0])            
        boss_for_insert(type, height);        
}

// ============================================================================
// 2 BOSS 
// ============================================================================

module two_boss_for_insert(type, x_pitch, y_pitch, height=0) {
    translate([- x_pitch / 2, - y_pitch / 2, 0])            
        boss_for_insert(type, height);
    translate([- x_pitch / 2, y_pitch / 2, 0])            
        boss_for_insert(type, height);
}

// ============================================================================
// 2 X BOSS  
// ============================================================================

module two_cross_boss_for_insert(type, x_pitch, y_pitch, height=0) {
    translate([- x_pitch / 2, - y_pitch / 2, 0])
        boss_for_insert(type, height);
    translate([x_pitch / 2, y_pitch / 2, 0])            
        boss_for_insert(type, height);
}

// Usage
/*
M3_spec = get_boss_spec("M3");  // [10, 2.5, 4, 3.3]
echo(boss_diameter(M3_spec));   // 10
echo(boss_height(M3_spec));     // 4
*/
  

  