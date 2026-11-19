// ==============================================================================
// COMMON MODULES
// ==============================================================================

function search_in_table(value, table, index) =
  index >= len(table) ? -1 :
  table[index][0] == value ? index :
  search_in_table(value, table, index + 1);

module reference(l=20) {
    color("red")   cube([l, 1, 1]); // X
    color("green") cube([1, l, 1]); // Y
    color("blue")  cube([1, 1, l]); // Z
}

