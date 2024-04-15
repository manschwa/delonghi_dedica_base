$fn = 100;

rounding_factor = 12;
width = 200 - (rounding_factor * 2);
machine_width = 142.4;
height = 33;
radius = 65 - rounding_factor;
hole_size = 10;

module coffee_table_block() {
    difference() {
        minkowski() {
            union() {
            cube([width, radius, height]);
                translate([width / 2, 0, 0]) {
                    resize(newsize=[width, radius * 4, height]) {
                        cylinder(height, radius, radius);
                    }
                }
            }
            translate([0, radius, height]) {
                sphere(rounding_factor);
            }
        }
        
        translate([-(rounding_factor + 1), - radius * 2, 0]) {
            cube([width + rounding_factor * 3, radius * 5, height + rounding_factor]);
        } 
        translate([-(rounding_factor + 1), radius * 2, 0]) {
            cube([width + rounding_factor * 3, radius * 2, 100]);
        }
    }
}

// big block minus a slightly smaller block
module coffee_table() {
    difference() {
        coffee_table_block();
        translate([rounding_factor / 2 - 3, 1, 0]) {
            resize(newsize = [width + 17, (radius * 3) + 6, height - 1.3]) {
                coffee_table_block();
            }
        }
        translate([(width - machine_width) / 2 + 8.5, 10, 0]) {
            resize(newsize = [machine_width, (radius * 3) + 6, height - 1.3]) {
                coffee_table_block();
            }
        }
    }
}

// drip holes and stopper
union() {
    difference() {
        translate([rounding_factor, -radius * 2, -45]) {
            coffee_table();
        }
        translate([width / 2 + rounding_factor - 20, -69, 0]) {
            cylinder(height * 3, hole_size, hole_size);
        }
        translate([width / 2 + rounding_factor + 20, -64, 0]) {
            cylinder(height * 3, hole_size, hole_size);
        }
    }
    translate([100, -96, 7]) {
        cylinder(24, 3, 5);
    }
}