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
| **Inlet Velocity** | $U$ | 1.0 m/s |
| **Cylinder Diameter** | $D$ | 1.0 m |
| **Kinematic Viscosity** | $\nu$ | 0.01 m²/s |
| **Reynolds Number** | $Re$ | 100 |

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
| **Inlet_Zone** | $U$ / $p$ | `fixedValue` / `zeroGradient` | U = (1 0 0) |
| **Outlet_Zone** | $U$ / $p$ | `zeroGradient` / `fixedValue` | p = 0 |
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
```

## 5. Execution Instructions
To run this simulation, follow these steps in your OpenFOAM terminal:

1. **Mesh Conversion**:
   Convert the Gmsh file into the OpenFOAM polyMesh format:
   ```bash
   gmshToFoam mesh/SheddingSeason.msh
   ```

2. **Mesh Validation**:
   Verify the mesh quality and ensure the boundaries are recognized:
   ```bash
   checkMesh
   ```

3. **Run Solver**:
   Start the transient, laminar calculation:
   ```bash
   icoFoam
   ```

## 6. Post-Processing and Visualization
To visualize the results in ParaView:

1. **Generate Reader File**:
   Create an empty `.foam` file for ParaView to recognize:
   ```bash
   touch SheddingSeason.foam
   ```

2. **ParaView Analysis**:
   - Open **ParaView** on Windows.
   - Load `SheddingSeason.foam` and click **Apply**.
   - Change the display field to **U** (Velocity) or **p** (Pressure).
   - Use the **Play** button to watch the vortex street develop.
  

## 7. License
This project is licensed under the MIT License - see the LICENSE file for details.

## 8. Acknowledgments
- **OpenFOAM:** For the robust CFD framework.
- **Gmsh:** For the unstructured mesh generation.
- **ParaView:** For the high-fidelity visualization.  
   

---
---
---


### Author
**Soumil Garg**<br>
*Student, B.Tech Mechanical Engineering*<br>
*Indian Institute of Technology Roorkee, Roorkee*<br>
📧 [soumilgarg97@gmail.com](mailto:soumilgarg97@gmail.com)<br>
🔗 [LinkedIn Profile](https://www.linkedin.com/in/soumil-garg-2a99672a3)
