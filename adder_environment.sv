class adder_environment extends uvm_env;
    `uvm_component_utils(adder_environment)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    // declare instances of agent and scoreboard
    adder_agent agent;
    adder_scoreboard scoreboard;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = adder_agent::type_id::create("agent", this);
        scoreboard = adder_scoreboard::type_id::create("scoreboard", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        agent.monitor.mon_analysis_port.connect(scoreboard.ap_imp);
    endfunction



endclass