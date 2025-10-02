//
// Riser feet with carpet spikes.
//
// MIT License
// 
// Copyright (c) 2025 Ken Whitaker
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

// The Belfry OpenScad Library, v2:  https://github.com/BelfrySCAD/BOSL2
// This library must be installed in your instance of OpenScad to use this model.
include <BOSL2/std.scad>

// *** Model Parameters ***
/* [Model Parameters] */

// Foot height (z)
foot_height = 16;

// Foot width (x)
foot_width = 50;

// Foot depth (y)
foot_depth = 35;

// Number of rows for teeth in the x direction (width)
teeth_rows_x = 6;

// Number of columns for teeth in the y direction (depth)
teeth_cols_y = 4;

// minimum spacing needed between teeth
min_teeth_spacing = 2;

// *** "Private" variables ***
/* [Hidden] */

// OpenSCAD System Settings - make curves smooth.
$fa = 1;
$fs = 0.4;
 
//
// Creates the riser foot.
//
module riser_foot() {
  cuboid(size=[foot_width, foot_depth, foot_height], rounding=1, except=BOT);
}

//
// Adds grip teeth to the top of the foot (intended to be the bottom when mounted)
//
module carpet_grips() {

  // Pyramid base size for each tooth.
  grip_tooth_base = floor((foot_depth / (teeth_cols_y + min_teeth_spacing)));

  grip_tooth_height = grip_tooth_base;

  x_offset = -( (foot_width / 2) - (grip_tooth_base / 2));
  y_offset = -( (foot_depth / 2) - (grip_tooth_base / 2));
  z_offset = foot_height / 2;

  // Calculate the actual spacing for each tooth based on available space.
  x_spacing = ( (foot_width - (grip_tooth_base * teeth_rows_x)) / teeth_rows_x);
  y_spacing = ( (foot_depth - (grip_tooth_base * teeth_cols_y)) / teeth_cols_y);

  // Create the teeth
  for (row = [0:teeth_rows_x - 1])
    for (col = [0:teeth_cols_y - 1])
      translate(
        [
          x_offset + (row * x_spacing) + (row * grip_tooth_base) + (x_spacing / 2),
          y_offset + (col * y_spacing) + (col * grip_tooth_base) + (y_spacing / 2),
          z_offset,
        ]
      )
        prismoid([grip_tooth_base, grip_tooth_base], [0, 0], h=grip_tooth_height);
}

//
// Builds the complete model
//
module build_model() {
  riser_foot();
  carpet_grips();
}
build_model();
