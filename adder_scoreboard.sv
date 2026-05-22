class adder_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(adder_scoreboard)

    // counters
    int num_checked;
    int num_passed;
    int num_failed;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    uvm_analysis_imp #(adder_seq_item, adder_scoreboard) ap_imp;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap_imp = new("ap_imp", this);
    endfunction

    virtual function void write(adder_seq_item data);
        logic [64:0] expected = data.A + data.B + data.Cin;
       
        `uvm_info("write", $sformatf("Data Received: \n%s", data.sprint()), UVM_MEDIUM)
    
        num_checked++;

        if({data.Cout, data.Sum} === expected) begin
           num_passed++;
           `uvm_info("SCB", "testcase passed", UVM_LOW) 
        end else begin
            num_failed++;
            `uvm_error("SCB", $sformatf("MISMATCH: A = %0h, B = %0h, Cin = %0h -> exp %0h, got %0h", 
            data.A, data.B, data.Cin, expected, {data.Cout, data.Sum}))
        end
    endfunction

    virtual function void check_phase(uvm_phase phase);
        super.check_phase(phase);

        if(num_failed > 0) begin
            `uvm_error("SCB", "testcase(s) failed")
        end else if (num_checked == 0) begin
            `uvm_error("SCB", "monitor checked nothing")
        end

        `uvm_info("SCB", $sformatf("SUMMARY: Testcases ran: %0d Testcases passed: %0d, Testcases failed: %0d", num_checked, num_passed, num_failed), UVM_LOW)
    endfunction

endclass