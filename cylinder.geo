// 1. Define the scale
d = 1;              // Cylinder diameter
mesh_size = 0.5;    // Initial guess for mesh density

// 2. Define the domain dimensions (30d x 30d)
L = 30 * d;         // Total length
H = 30 * d;         // Total height

// Cylinder Center Point
// Point(ID) = {x, y, z, local_mesh_size};
Point(1) = {10*d, 15*d, 0, mesh_size};

// Four corners of the domain (30x30)
Point(2) = {0, 0, 0, mesh_size};    // Bottom-left (Inlet start)
Point(3) = {L, 0, 0, mesh_size};    // Bottom-right (Outlet start)
Point(4) = {L, H, 0, mesh_size};    // Top-right
Point(5) = {0, H, 0, mesh_size};    // Top-left

// Connecting the 4 corner points to create the outer boundary
Line(1) = {2, 3}; // Bottom wall (Point 2 to 3)
Line(2) = {3, 4}; // Outlet wall (Point 3 to 4)
Line(3) = {4, 5}; // Top wall (Point 4 to 5)
Line(4) = {5, 2}; // Inlet wall (Point 5 to 2)