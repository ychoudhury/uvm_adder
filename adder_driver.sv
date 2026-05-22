class adder_driver extends uvm_driver #(adder_seq_item);
    
    // utility macro
    `uvm_component_utils(adder_driver)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

        // declare the virtual interface
    virtual adder_if vif;

    // build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
            // get the interface handle using config_db
        if(!uvm_config_db #(virtual adder_if)::get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "Didn't get handle to virtual interface")
    endfunction

    // run phase
    virtual task run_phase(uvm_phase phase);
        reset();
        forever begin
            seq_item_port.get_next_item(req);
            drive();
            seq_item_port.item_done();
        end

    endtask

    task reset;
        $display("[ DRIVER ] --------- Reset Started ---------");
        @(vif.drv_cb);
        vif.drv_cb.A <= 0;
        vif.drv_cb.B <= 0;
        vif.drv_cb.Cin <= 0;

        $display("[ DRIVER ] --------- Reset Complete ---------");
    endtask

    task drive;
        @(vif.drv_cb); // wait for posedge clock - advances time
        vif.drv_cb.A <= req.A;
        vif.drv_cb.B <= req.B;
        vif.drv_cb.Cin <= req.Cin;
    endtask

endclass