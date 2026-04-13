# SheddingSeason: 2D Laminar Vortex Shedding
**A Computational Fluid Dynamics Study using OpenFOAM**

## 1. Project Overview
**SheddingSeason** is a transient CFD simulation focused on the formation of the **Von Kármán vortex street** behind a circular cylinder. This phenomenon occurs when a fluid flows past a blunt body at specific Reynolds numbers, causing alternating low-pressure vortices to be shed from the downstream side.

This project utilizes **OpenFOAM v2312** to solve the incompressible Navier-Stokes equations using the `icoFoam` solver.

## 2. Physics and Non-Dimensional Parameters
The simulation is characterized by the **Reynolds Number ($Re$)**, defining the ratio of inertial forces to viscous forces. This case targets the laminar shedding regime.

$$Re = \frac{U \cdot D}{\nu}$$

| Parameter | Symbol | Value |
| :--- | :--- | :--- |
| **Inlet Velocity** | $U$ | $1.0 \, \text{m/s}$ |
| **Cylinder Diameter** | $D$ | $1.0 \, \text{m}$ |
| **Kinematic Viscosity** | $\nu$ | $0.01 \, \text{m}^2/\text{s}$ |
| **Reynolds Number** | $Re$ | $100$ |

## 3. Numerical Setup
### Solver
* **Solver:** `icoFoam` 
* **Type:** Incompressible, laminar, transient flow.
* **Algorithm:** PISO (Pressure-Implicit with Splitting of Operators).

### Domain and Mesh
* **Geometry:** 2D domain with a central circular cylinder.
* **Mesh Tool:** Gmsh.
* **Conversion:** `gmshToFoam`.
* **Topology:** 1-cell thick in the Z-direction, with front and back planes set to `empty`.

### Boundary Conditions
| Patch | Field | Type | Value |
| :--- | :--- | :--- | :--- |
| **Inlet_Zone** | $U$ / $p$ | `fixedValue` / `zeroGradient` | $U = (1, 0, 0)$ |
| **Outlet_Zone** | $U$ / $p$ | `zeroGradient` / `fixedValue` | $p = 0$ |
| **Cylinder_Wall** | $U$ / $p$ | `noSlip` / `zeroGradient` | - |
| **Upper/Lower** | $U$ / $p$ | `symmetry` | - |
| **Front/Back** | $U$ / $p$ | `empty` | - |

## 4. Repository Structure
```text
SheddingSeason/
├── 0/                # Initial and Boundary Conditions
├── constant/         # Physical properties and Mesh
├── system/           # Solver & Numerical Control
├── mesh/             # Source files (.geo and .msh)
└── README.md
