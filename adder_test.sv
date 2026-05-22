class adder_test extends uvm_test;
    `uvm_component_utils(adder_test)

    adder_environment env;
    adder_sequence seq;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        env = adder_environment::type_id::create("env", this);
    endfunction

    task run_phase(uvm_phase phase);
        seq = adder_sequence::type_id::create("seq", this);
        phase.raise_objection(this);
        seq.start(env.agent.sequencer);
        phase.drop_objection(this);
    endtask


endclass