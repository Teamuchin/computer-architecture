# Computer Architecture — Processor and Assembly Work

A single-cycle MIPS processor datapath written in Verilog, alongside the MIPS assembly programs and SPIM exercises that go with it.

**Course:** CENG311 — Computer Architecture  
**Institution:** İzmir Institute of Technology (IYTE) — İzmir, Türkiye

## Contents

| Folder | Contents |
|---|---|
| `verilog-single-cycle-processor/` | `processor.v` — the datapath — with the ALU (`alu32.v`, `alucont.v`), controller, register file, sign extension, a shifter, and two 2-to-1 multiplexers (`mult2_to_1_32.v`, `mult2_to_1_5.v`). `im1..im3.dat` are instruction memories; `initDM.dat`, `initIM.dat` and `initReg.dat` are initial-state images |
| `mips-assembly/` | A MIPS assembly program with an earlier draft and a backup |
| `spim-exercises/` | Ten incremental SPIM exercises |
| `x86-64-assembly/` | A Visual Studio x64 assembly project (`AsmTest`) mixing `Source.cpp` with `test1.asm` |

## Running the Verilog

Open `processor.mpf` in ModelSim and run the testbench. The compiled simulation library
(`work/`) and waveform dumps are not tracked — ModelSim rebuilds them on the first run.

## Running the assembly

Load the `.asm` files into SPIM or MARS. `x86-64-assembly/AsmTest` builds with Visual Studio
using the MASM toolchain.

---

Submitted reports, worksheets and lecture material are archived outside this
repository rather than committed, so the repo stays code-only.
