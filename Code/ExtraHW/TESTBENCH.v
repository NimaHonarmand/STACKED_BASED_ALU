module tb;

    // Parameterized instances
    reg clk;
    reg reset;
    reg [2:0] opcode;
    reg [3:0]  input_data1;
    reg [7:0]  input_data2;
    reg [15:0] input_data3;
    reg [31:0] input_data4;

    wire signed [3:0]  output_data1;
    wire signed [7:0]  output_data2;
    wire signed [15:0] output_data3;
    wire signed [31:0] output_data4;
    wire overflow1;
    wire overflow2;
    wire overflow3;
    wire overflow4;

    // Instantiate the ALU for different n values
    STACK_BASED_ALU #(.n(4) , .STACK_SIZE(8)) alu_4 (.input_data(input_data1), .opcode(opcode), .clk(clk), .reset(reset), .output_data(output_data1), .overflow(overflow1));
    STACK_BASED_ALU #(.n(8) , .STACK_SIZE(8)) alu_8 (.input_data(input_data2), .opcode(opcode), .clk(clk), .reset(reset), .output_data(output_data2), .overflow(overflow2));
    STACK_BASED_ALU #(.n(16), .STACK_SIZE(8)) alu_16 (.input_data(input_data3), .opcode(opcode), .clk(clk), .reset(reset), .output_data(output_data3), .overflow(overflow3));
    STACK_BASED_ALU #(.n(32), .STACK_SIZE(8)) alu_32 (.input_data(input_data4), .opcode(opcode), .clk(clk), .reset(reset), .output_data(output_data4), .overflow(overflow4));

    // Clock generation
    always
  	#5 clk = ~clk;

    initial begin
        // Test sequence
	clk = 0;
        reset = 1;

        #6;

        reset = 0;
	opcode = 3'b110; // Push operation
        input_data1 = 4'b0111; // Push 7
	input_data2 = 8'b0111;
	input_data3 = 16'b0111;
	input_data4 = 32'b0111;

        #10;

        input_data1 = 4'b1111; // Push -1 for first one and 15 for the others
        input_data2 = 8'b1111;
        input_data3 = 16'b1111;
        input_data4 = 32'b1111;

        #10;

        opcode = 3'b100; // Add operation
	
        #10;
        
	opcode = 3'b111; // Pop operation

        #10;

	opcode = 3'b110; // Push operation
        input_data1 = 4'b0011; // Push 3
        input_data2 = 8'b0011;
        input_data3 = 16'b0011;
        input_data4 = 32'b0011;

        #10;

        opcode = 3'b100; // Multiply operation

        #10;

        opcode = 3'b100; // Add operation

        #10;

        opcode = 3'b111; // Pop operation

        #10;

        opcode = 3'b111; // Pop operation

        #10;
        $stop;
    end

initial
	$monitor( $time ,"opcode=%b \n 4_bit_stack=[%d,%d,%d,%d,%d,...] , 8_bit_stack[%d,%d,%d,%d,%d,...] , 16_bit_stack[%d,%d,%d,%d,%d,...] , 32_bit_stack[%d,%d,%d,%d,%d,...] \n 4_bit_overflow=%d , 8_bit_overflow=%d , 16_bit_overflow=%d , 32_bit_overflow=%d \n 4_bit_result=(%h)Hex=(%d)Dec , 8_bit_result=(%h)Hex=(%d)Dec , 16_bit_result=(%h)Hex=(%d)Dec , 32_bit_result=(%h)Hex=(%d)Dec \n ======================================================================================================================", opcode,alu_4.stack[0] , alu_4.stack[1] , alu_4.stack[2] , alu_4.stack[3] , alu_4.stack[4] , alu_8.stack[0] , alu_8.stack[1] , alu_8.stack[2] , alu_8.stack[3] , alu_8.stack[4] , alu_16.stack[0] , alu_16.stack[1] , alu_16.stack[2] , alu_16.stack[3] , alu_16.stack[4] , alu_32.stack[0] , alu_32.stack[1] , alu_32.stack[2] , alu_32.stack[3] , alu_32.stack[4] , overflow1 , overflow2 , overflow3 , overflow4 , output_data1 , output_data1 , output_data2 , output_data2 , output_data3 , output_data3 , output_data4 , output_data4);

endmodule