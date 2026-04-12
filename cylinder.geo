// 1. Define Basic Variables
d = 1;              // Cylinder diameter
R = 15 * d;         // Outer domain radius (total width/height still effectively 30d)
mesh_size = 0.5;    // Mesh density far away
center = 15 * d;    // The center coordinate for both circles

// 2. Define the Points
// Center of the whole universe
Point(1) = {center, center, 0, mesh_size};

// Outer Circle Points (Placed at 45, 135, 225, 315 degrees)
Point(2) = {center + R*Cos(Pi/4), center + R*Sin(Pi/4), 0, mesh_size}; // Top-Right
Point(3) = {center - R*Cos(Pi/4), center + R*Sin(Pi/4), 0, mesh_size}; // Top-Left
Point(4) = {center - R*Cos(Pi/4), center - R*Sin(Pi/4), 0, mesh_size}; // Bottom-Left
Point(5) = {center + R*Cos(Pi/4), center - R*Sin(Pi/4), 0, mesh_size}; // Bottom-Right

// Inner Cylinder Points (Aligned with the outer diagonals)
Point(6) = {center + (d/2)*Cos(Pi/4), center + (d/2)*Sin(Pi/4), 0, mesh_size/10}; // Top-Right
Point(7) = {center - (d/2)*Cos(Pi/4), center + (d/2)*Sin(Pi/4), 0, mesh_size/10}; // Top-Left
Point(8) = {center - (d/2)*Cos(Pi/4), center - (d/2)*Sin(Pi/4), 0, mesh_size/10}; // Bottom-Left
Point(9) = {center + (d/2)*Cos(Pi/4), center - (d/2)*Sin(Pi/4), 0, mesh_size/10}; // Bottom-Right

// 3. Outer Boundary Arcs
Circle(1) = {2, 1, 3}; // Upper Arc
Circle(2) = {3, 1, 4}; // Inlet Arc
Circle(3) = {4, 1, 5}; // Lower Arc
Circle(4) = {5, 1, 2}; // Outlet Arc

// 4. Inner Cylinder Arcs
Circle(5) = {6, 1, 7}; // Upper Cylinder Arc
Circle(6) = {7, 1, 8}; // Inlet Cylinder Arc
Circle(7) = {8, 1, 9}; // Lower Cylinder Arc
Circle(8) = {9, 1, 6}; // Outlet Cylinder Arc

// 5. Diagonal Partition Lines (The "Slices")
Line(9)  = {3, 7}; // Top-Left diagonal
Line(10) = {4, 8}; // Bottom-Left diagonal
Line(11) = {5, 9}; // Bottom-Right diagonal
Line(12) = {2, 6}; // Top-Right diagonal

// 1. Create Loops for each of the 4 zones
// Inlet Section (Left)
Curve Loop(1) = {2, 10, -6, -9}; 
Plane Surface(1) = {1};

// Outlet Section (Right)
Curve Loop(2) = {4, 12, -8, -11};
Plane Surface(2) = {2};

// Upper Section (Top)
Curve Loop(3) = {1, 9, -5, -12};
Plane Surface(3) = {3};

// Lower Section (Bottom)
Curve Loop(4) = {3, 11, -7, -10};
Plane Surface(4) = {4};

// 2. Ensure all 4 surfaces are made of squares (Quads)
Recombine Surface {1, 2, 3, 4};

// 3. Name the Surfaces so they are "Changeable" in Ansys
Physical Surface("Inlet_Zone") = {1};
Physical Surface("Outlet_Zone") = {2};
Physical Surface("Upper_Zone") = {3};
Physical Surface("Lower_Zone") = {4};

// 4. Name the Boundaries for Boundary Conditions
Physical Curve("Inlet_Boundary") = {2};
Physical Curve("Outlet_Boundary") = {4};
Physical Curve("Upper_Boundary") = {1};
Physical Curve("Lower_Boundary") = {3};
Physical Curve("Cylinder_Wall") = {5, 6, 7, 8};

// 1. MATCHING REFINEMENT PARAMETERS
// For a structured mesh, outer and inner counts must be equal
num_nodes_side = 600;     // Points on each arc (Outer AND Cylinder)
num_nodes_radial = 500;   // Layers between cylinder and outer wall

// 2. APPLY TO CURVES
// Outer arcs (1, 2, 3, 4) must match inner arcs (5, 6, 7, 8)
Transfinite Curve {1, 2, 3, 4, 5, 6, 7, 8} = num_nodes_side;
Transfinite Curve {9, 10, 11, 12} = num_nodes_radial;

// 3. MAP AND RECOMBINE
Transfinite Surface {1, 2, 3, 4};
Recombine Surface {1, 2, 3, 4};