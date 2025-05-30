# Wireless‑Links: Signal Simulation Tool

> Octave‑based signal propagation simulator and visualizer for urban environments, developed as an open‑source teaching aid for the Department of Computer Science & Engineering at the University of Ioannina (course ΜΥΕ048).

---

## 📋 Table of Contents

1. [Overview](#overview)  
2. [Features](#features)  
3. [Screenshots](#screenshots)  
4. [Technologies](#technologies)  
5. [Installation](#installation)  
6. [Usage](#usage)  
7. [Implementation](#implementation)  
8. [Documentation & Report](#documentation--report)  
9. [Contributing](#contributing)  
10. [License & Contact](#license--contact)  

---

## Overview

This project converts and optimizes MATLAB laboratory code into GNU Octave scripts, creating a free‑and‑open‑source tool for simulating and visualizing wireless signal propagation in city‑like obstacle environments. It empowers future students to experiment with link performance, obstacle effects, and parameter tuning without MATLAB licenses.  

---

## Features

- **MATLAB → Octave porting**: All lab exercises originally in MATLAB are reworked in Octave to ensure open‑source accessibility.  
- **Signal propagation simulation**: Model line‑of‑sight, multipath, and obstacle attenuation in urban scenarios.  
- **Interactive visualization**: Generate 2D plots of signal strength over a grid of receiver locations, highlighting dead zones and coverage areas.  
- **Parameter configuration**: Easily adjust transmitter power, frequency, obstacle material properties, and grid resolution via script variables.  
- **Extensible framework**: Modular code structure allows the department or students to add new propagation models or GUI front‑ends.  

---

## Screenshots

<p align="center">  
  <img src="https://user-images.githubusercontent.com/56134761/210102985-aa47538a-8ef5-4f2c-b042-e955587fa1f3.png" alt="" width="300"/>  
  <img src="https://user-images.githubusercontent.com/56134761/210103150-8ea13c5e-6376-4197-a6ed-30aa0bd6fd35.png" alt="" width="300"/> 
</p>  
<p align="center">  
    <img src="https://user-images.githubusercontent.com/56134761/210102995-f081b13d-fbf0-41fa-beb2-abd495d536ad.png" alt="" width="300"/>  
  <img src="https://user-images.githubusercontent.com/56134761/210103001-85ae9ea3-9516-4a31-bfc2-42d589b1b19b.png" alt="" width="300"/>  
  <img src="https://user-images.githubusercontent.com/56134761/210103008-c5662e3d-6c44-4de7-8e53-987fe4bcad4a.png" alt="" width="300"/> 

  <img src="https://user-images.githubusercontent.com/56134761/210103012-f317d1ae-0e05-4c15-994d-03c7e8873cef.png" alt="" width="300"/> 
  <img src="https://user-images.githubusercontent.com/56134761/210103137-33b60a3d-c270-4f15-ab8a-a8fccb4e0107.png" alt="" width="300"/> 
  
</p>

---

## Technologies

| Component           | Technology                                |
|---------------------|-------------------------------------------|
| **Language**        | GNU Octave 10.x (free MATLAB alternative) |
| **Plotting**        | Octave built‑in plotting (gnuplot backend) |
| **Scripting**       | Octave `.m` scripts, modular functions     |
| **Documentation**   | ODT & PDF report via LibreOffice/OpenOffice |

---

## Installation

1. **Install GNU Octave** (latest stable release 10.1.0) from the official site or your OS package manager.  
2. **Clone the repo**:  
   ```bash
   git clone https://github.com/johnprif/Wireless-Links.git
   cd Wireless-Links
    ```
3. **Ensure dependencies:** No extra toolboxes needed—pure Octave core functions.

## Usage
From within the project folder, launch Octave and run the main script:
```bash
octave:1> run('new_Lab_2_Ooctave/main_simulation.m');
```
- Modify parameters (transmitter power, frequency, obstacle map) at the top of `main_simulation.m`.
- View generated plots in the Octave GUI or export via `print -dpng`.

- Compare results against MATLAB originals in `old_Lab_2_MATLAB/`.

## Implementation
```plaintext
+----------------------+      +----------------------+      +----------------------+
| main_simulation.m    | -->  | propagation_models.m | -->  | visualization_utils.m|
+----------------------+      +----------------------+      +----------------------+
         |                            |                                |
         v                            v                                v
  parameter_config.m        path_loss_models.m                  plot_heatmap.m

```
- **Modular design:** Separate scripts for configuration, propagation math, and plotting, enabling easy extension.
- **Conversion approach:** Converted MATLAB built‑in functions to Octave equivalents, optimized loops for performance.

## Documentation & Report
Detailed methodology, algorithmic choices, and results analysis are provided in:
- `new_Lab_2_Ocate_report.pdf` (full report)
- `new_Lab_2_Ocate_report.odt` (editable source)

Refer to these for theoretical background and validation plots.

## Contributing
This tool is open‑source for future students and faculty development. To contribute:
1. Fork the repository.
2. Create a branch: `git checkout -b feature/your_feature`.
3. Commit changes and push.
4. Submit a Pull Request.

Feedback and extensions (new models, GUIs) are encouraged by the department.

## License & Contact
**MIT License** © 2020 University of Ioannina contributors. See [LICENSE](https://github.com/johnprif/Wireless-Links/blob/main/LICENSE) file for details.

For questions or collaboration, contact:
- Joanis Prifti (author) — [giannispriftis37@gmail.com](mailto:giannispriftis37@gmail.com)
- Filippo Priftis (co‑author) — [filpri6@gmail.com](filpri6@gmail.com)

*Developed as an educational resource for Wireless Links (ΜΥΕ048) labs at University of Ioannina.*
