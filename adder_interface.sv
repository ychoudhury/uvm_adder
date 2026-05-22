interface adder_if();
    logic [63:0] A, B;
    logic Cin;
    logic [63:0] Sum;
    logic Cout;

    logic clk;

    // clock generator
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    clocking drv_cb @(posedge clk);
        default input #1step output #2;  // sample 1 step pre-edge, then drive 2 units post-edge
        output A, B, Cin;
        input Sum, Cout;
    endclocking

    clocking mon_cb @(posedge clk);
        default input #1step;
        input A, B, Cin, Sum, Cout;
    endclocking

    modport DRV (clocking drv_cb);
    modport MON (clocking mon_cb);

endinterface