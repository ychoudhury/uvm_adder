class adder_monitor extends uvm_monitor;
    // Utility macro
    `uvm_component_utils(adder_monitor)

    // constructor function
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    // virtual interface 
    virtual adder_if vif;
    
    // declare an analysis port
    uvm_analysis_port  #(adder_seq_item) mon_analysis_port;


    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        mon_analysis_port = new("mon_analysis_port", this);

        // get virtual interface handle from config_db
        if(!uvm_config_db #(virtual adder_if)::get(this, "", "vif", vif)) begin
            `uvm_error(get_type_name(), "DUT interface not found")
        end
    endfunction

    virtual task run_phase(uvm_phase phase);
        // declare data_obj as a handle for adder_seq_item
        adder_seq_item data_obj;
        forever begin
            @(vif.mon_cb);
            data_obj = adder_seq_item::type_id::create("data_obj");
            data_obj.A = vif.mon_cb.A;
            data_obj.B = vif.mon_cb.B;
            data_obj.Cin = vif.mon_cb.Cin;
            
            data_obj.Sum = vif.mon_cb.Sum;
            data_obj.Cout = vif.mon_cb.Cout;

            mon_analysis_port.write(data_obj);
        end
    endtask

endclass