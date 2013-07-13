// CONFIGURATION

paddle_x_size = 550;
paddle_y_size = 450;
paddle_z_size = 10;

handle_x_size = 250;
handle_y_size = 30;
handle_z_size = 20;

handle_paddle_overlap = 3 * handle_y_size;

handle_hole_radius = 5;
handle_hole_x_position = 20;

facets = 10; // Granularity of circular objects

// CONFIGURATION END

// CALCULATIONS

handle_x_position = 0;
handle_y_position = (paddle_y_size - handle_y_size) / 2;
handle_z_position = 0;

paddle_x_position = handle_x_size - handle_paddle_overlap;
paddle_y_position = 0;
paddle_z_position = 0;

handle_hole_height = handle_z_size * 2;
handle_hole_y_position = handle_y_position + handle_y_size / 2;
handle_hole_z_position = -handle_z_size / 2;

peel_x_size = paddle_x_position + paddle_x_size;
peel_y_size = paddle_y_size;
peel_z_size = max(handle_z_size, paddle_z_size);

// CALCULATIONS END

// MODULES
module paddle() {
    translate([paddle_x_position, paddle_y_position, paddle_z_position]) {
        cube([paddle_x_size, paddle_y_size, paddle_z_size]);
    }
}

module handle() {
    translate([handle_x_position, handle_y_position, handle_z_position]) {
        cube([handle_x_size, handle_y_size, handle_z_size]);
    }
}

module handle_hole() {
    translate([handle_hole_x_position, handle_hole_y_position, handle_hole_z_position]) {
        cylinder(h = handle_hole_height, r = handle_hole_radius, $fn = facets);
    }
}

module peel() {
    difference() {
        union() {
            paddle();
            handle();
        }
        handle_hole();
    }
}

// MODULE END

// DOCUMENTATION

echo (str(
    "Total dimensions: ",
    "length = ", peel_x_size, ", ",
    "width = ", peel_y_size, ", ",
    "thickness = ", peel_z_size));

echo (str(
    "Other configuration: ",
    "facets = ", facets));

// DOCUMENTATION END

peel();
