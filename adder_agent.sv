// uvm_agent.sv

class adder_agent extends uvm_agent;

// utility macros
`uvm_component_utils(adder_agent)

function new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

// TODO expose monitor's analysis port. Otherwise the scoreboard cannot connect to this agent.

// declare instances of driver, sequencer, and monitor
adder_sequencer sequencer;
adder_driver driver;
adder_monitor monitor;

// build phase
virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(get_is_active() == UVM_ACTIVE) begin
        driver = adder_driver::type_id::create("driver", this);
        sequencer = adder_sequencer::type_id::create("sequencer", this);
    end

    monitor = adder_monitor::type_id::create("monitor", this);
endfunction

virtual function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE) begin
        driver.seq_item_port.connect(sequencer.seq_item_export);
    end
endfunction


endclass