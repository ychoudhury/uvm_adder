class adder_seq_item extends uvm_sequence_item;

    // fields
    rand bit [63:0] A, B;
    rand bit Cin;

    bit [63:0] Sum;
    bit Cout;

    // Utility and Field macros
    `uvm_object_utils_begin(adder_seq_item)
        `uvm_field_int(A, UVM_ALL_ON)
        `uvm_field_int(B, UVM_ALL_ON)
        `uvm_field_int(Cin, UVM_ALL_ON)
        `uvm_field_int(Sum, UVM_ALL_ON)
        `uvm_field_int(Cout, UVM_ALL_ON)
    `uvm_object_utils_end

    // constructor
    function new(string name = "adder_seq_item");
        super.new(name);
    endfunction 


endclass : adder_seq_item