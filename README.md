# VHDL_FIR_Filter_Design
## Finite Impulse Response (FIR) digital filter implemented in VHDL using direct, transpose, and pipelined architectures with performance and resource analysis

## About The Project
This project is a full simulation of a finite impulse response (FIR) digital filter in VHDL using Quartus and ModelSim. It evaluates three design approaches: direct form, transpose form, and pipelined transpose form. Each design is synthesized and simulated to compare logic utilization, maximum operating frequency (Fmax), register usage, and power consumption. Results highlight tradeoffs in speed, resource efficiency, and power for FPGA based digital signal processing.


### Built With

* [![VHDL](https://img.shields.io/badge/VHDL-00599C?style=for-the-badge&logo=vhdl&logoColor=white)][VHDL-url]
* [![Intel Quartus](https://img.shields.io/badge/Quartus%20Prime-0071C5?style=for-the-badge&logo=intel&logoColor=white)][Quartus-url]
* [![ModelSim](https://img.shields.io/badge/ModelSim-FF6F00?style=for-the-badge&logoColor=white)][ModelSim-url]
* [![FPGA](https://img.shields.io/badge/FPGA-333333?style=for-the-badge&logo=firebase&logoColor=white)][FPGA-url]

[VHDL-url]: https://en.wikipedia.org/wiki/VHDL
[Quartus-url]: https://www.intel.com/content/www/us/en/software/programmable/quartus-prime/overview.html
[ModelSim-url]: https://eda.sw.siemens.com/en-US/ic/modelsim/
[FPGA-url]: https://www.intel.com/content/www/us/en/products/details/fpga.html


## Getting Started
### Prerequisites
You will need the following installed to build and run this project
* Intel Quartus Prime
  - For VHDL design entry, synthesis, and FPGA compilation.
  - [Download Quartus Prime](https://www.intel.com/content/www/us/en/software/programmable/quartus-prime/overview.html)
* ModelSim (Questa)  Intel Edition
  - For simulating VHDL code and viewing waveforms.
  - [Download ModelSim](https://eda.sw.siemens.com/en-US/ic/modelsim/)
* FPGA Development Board
  - Any Intel/Altera board supported by Quartus (for example DE10-Lite or Cyclone V) if you want to load the bitstream to physical hardware.
    This is an optional step for hardware simulation.
* Basic VHDL Knowladge
* Computer with Windows or Linux


### Installation
1. Clone the Repository
   ```sh
   git clone https://github.com/<Garrison-Gralike>/VHDL_FIR_Filter_Design.git
   cd VHDL_FIR_Filter_Design
   ```
2. Install Intel Quartus Prime. Make sure to includedevice support package for your FPGA
   ```sh
   https://www.intel.com/content/www/us/en/software/programmable/quartus-prime/overview.html
   ```
3. Install ModelSim
   ```sh
   https://eda.sw.siemens.com/en-US/ic/modelsim/
   ```
4. Open the project in Quartus
   ```sh
   # Launch Quartus Prime and open the .qpf project file located in the cloned repository
   ```
5. Compile the Design
   ```sh
   # Inside Quartus Prime Click Processing → Start Compilation
   ```
6. Run Simulation on ModelSim
   ```sh
   # From Quartus: Tools → Run Simulation → RTL Simulation
   ```
7. Verify Output


## Usage


### Demo

Pre-Pipelining:
* This design implements the FIR filter using a standard transposed structure without any pipeline registers.  
* Data flows through each multiplier and adder in a single clock cycle which results in a long combinational path.  
* Because there are no intermediate registers, the design achieves a higher Fmax in synthesis but is more sensitive to timing closure and may limit scalability for large filters.


<img width="1185" height="235" alt="image" src="https://github.com/user-attachments/assets/e3662639-2d88-4c95-9610-7ce052d8bcff" />







Post Pipelining:
* This design introduces pipeline registers between key stages of the adder tree and multiplier outputs.  
* Pipelining shortens the critical path and allows for higher throughput on real hardware, even though the maximum operating frequency (Fmax) may drop slightly in simulation due to added latency.  
* The increased register count improves timing stability and makes it easier to meet performance targets on an FPGA, at the cost of slightly higher resource usage and latency.


<img width="1122" height="183" alt="image" src="https://github.com/user-attachments/assets/dbeebfaa-017c-489d-a67d-8ce0bd2b6660" />




### Results
For our purposes, we choose to analyze three different architectures and compare across
multiple Quartus optimization modes (Balanced, Performance, Power, and Area).
Each design was synthesized and simulated to collect logic utilization, register count,
maximum operating frequency (Fmax), and power consumption.


**Direct Form**
* Logic utilization remained stable at **≈47 ALMs** across all optimization modes.
* Registers ranged from **46–51** depending on mode.
* Fmax increased from **~584 MHz** (Balanced) to **~744 MHz** (Performance).
* Power consumption was lowest in Balanced/Performance (**~354 mW**) and
rose to **~420 mW** in Power/Area optimizations.

**Transpose Form (Pre-Pipelining)**
* Logic utilization held at **≈48 ALMs**, with **44–53** registers.
* Achieved the highest operating frequency, peaking at **~954 MHz** in
Performance mode and dropping to **~692 MHz** in Power mode.
* Power remained consistently near **~420 mW** across all modes.

**Transpose Form (Post-Pipelining)**
* Logic utilization stayed near **48 ALMs** but register count increased
significantly due to added pipeline stages.
* Fmax decreased to approximately **110–115 MHz** across all modes,
reflecting the additional clock cycles introduced by pipelining.
* Power remained steady at **~420 mW**.


## Key Takeaways
The transpose form without pipelining achieved the highest maximum clock speed,
meaning it is the best choice for applications that demand raw speed and can tolerate
some latency. The pipelined version introduced additional registers that shortened
the critical path and improved timing stability for real hardware. However it did this at
the cost of a much lower Fmax and a larger register footprint. 

The direct form provided a balanced baseline with moderate resource usage and frequency. This makes it a
good starting point for anyone learning FIR design in VHDL, or someone who needs a nice middle ground.

When repeating this project, users should pay close attention to how different synthesis optimization
modes influence Fmax and power consumption, and choose the FIR filter that is best for there needs.  Consider exploring the tradeoff between pipelining for throughput versus keeping the design simple for maximum clock
speed. If someone is looking to design an FIR filter, the options here provide a great baseline to build off of.


## Contact
- [LinkedIn](https://www.linkedin.com/in/<garrison-gralike-56164b253>) – <ggralike1@gmail.com>
