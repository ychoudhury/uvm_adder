`timescale 1ns/1ps

`include "adder_interface.sv"


module tb_top;
    import uvm_pkg::*;
    import adder_pkg::*;
        

    // declare virtual interface to connect the DUT to the test.
    adder_if vif();

    // instantiate the DUT here.
    adder dut (.A(vif.A), .B(vif.B), .Cin(vif.Cin), .Sum(vif.Sum), .Cout(vif.Cout));

    initial begin
        uvm_config_db #(virtual adder_if)::set(null, "*", "vif", vif);
        run_test();
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end


endmodule