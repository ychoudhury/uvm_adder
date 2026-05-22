# 64-bit Adder UVM Testbench

A SystemVerilog UVM testbench that verifies a 64-bit combinational
adder. It is a learning project built to practice the standard UVM component
hierarchy — sequence, driver, monitor, scoreboard, agent, environment, and test.

## Design under test

The DUT ([`adder.sv`](adder.sv)) is a purely combinational adder:

```
{Cout, Sum} = A + B + Cin
```

| Port  | Direction | Width | Description        |
|-------|-----------|-------|--------------------|
| `A`   | input     | 64    | First operand      |
| `B`   | input     | 64    | Second operand     |
| `Cin` | input     | 1     | Carry in           |
| `Sum` | output    | 64    | Sum result         |
| `Cout`| output    | 1     | Carry out          |

## Testbench architecture

Standard UVM hierarchy, top-down:

```
tb_top
 └─ adder_test
     └─ adder_environment
         ├─ adder_agent
         │   ├─ adder_sequencer  ◄── adder_sequence (100 random transactions)
         │   ├─ adder_driver
         │   └─ adder_monitor
         └─ adder_scoreboard
```

- **`tb_top`** — instantiates the DUT and the `adder_if` interface, publishes the
  virtual interface through `uvm_config_db`, and calls `run_test()`.
- **`adder_interface.sv`** — the `adder_if` interface. Holds the free-running clock
  generator and two clocking blocks: `drv_cb` (driver) and `mon_cb` (monitor).
- **`adder_test`** — builds the environment and starts the stimulus sequence.
- **`adder_environment`** — contains the agent and the scoreboard, and wires the
  monitor's analysis port to the scoreboard.
- **`adder_agent`** — contains the sequencer, driver, and monitor.
- **`adder_sequence`** — generates 100 randomized `adder_seq_item` transactions.
- **`adder_seq_item`** — the transaction object (`rand` inputs `A`, `B`, `Cin`;
  observed outputs `Sum`, `Cout`).
- **`adder_driver`** — drives transactions onto the interface, one per clock.
- **`adder_monitor`** — samples the interface and broadcasts observed transactions.
- **`adder_scoreboard`** — recomputes `A + B + Cin` as a reference model, compares it
  against the DUT result, and reports a pass/fail summary.

## Repository layout

| File                    | Role                                              |
|-------------------------|---------------------------------------------------|
| `adder.sv`              | DUT — 64-bit combinational adder                  |
| `adder_interface.sv`    | `adder_if` interface, clock, clocking blocks      |
| `adder_pkg.sv`          | UVM package — includes all classes in build order |
| `adder_seq_item.sv`     | Transaction object                                |
| `adder_sequence.sv`     | Stimulus sequence                                 |
| `adder_sequencer.sv`    | Sequencer                                         |
| `adder_driver.sv`       | Driver                                            |
| `adder_monitor.sv`      | Monitor                                           |
| `adder_scoreboard.sv`   | Scoreboard / reference model                      |
| `adder_agent.sv`        | Agent                                             |
| `adder_environment.sv`  | Environment                                       |
| `adder_test.sv`         | Test                                              |
| `tb_top.sv`             | Top-level testbench module                        |

## Building and running

Only three files are passed to the compiler; everything else is pulled in via
`` `include `` from `adder_pkg.sv` (the UVM classes) and `tb_top.sv` (the interface).
