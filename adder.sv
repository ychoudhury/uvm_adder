module adder (	input logic [63:0] A, B, 
		      	input logic Cin,
			  	output logic [63:0] Sum,
			  	output logic Cout);
			 
					always_comb begin
						{Cout, Sum} = A + B + Cin;			 
					end
			 			 
endmodule : adder