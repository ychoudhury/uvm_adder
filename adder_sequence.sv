class adder_sequence extends uvm_sequence #(adder_seq_item);
    // Utility macro
    `uvm_object_utils(adder_sequence)

    // Constructor function
    function new(string name = "adder_sequence");
        super.new(name);
    endfunction

    virtual task body();

        
        repeat(100) begin

            req = adder_seq_item::type_id::create("req");

            // Blocking call. Execution is blocked until the method returns.
            start_item(req);

            if(!req.randomize()) begin
                `uvm_error("REQ", "Randomization Failed")
            end

            finish_item(req);
        end
    endtask
    

endclass : adder_sequence