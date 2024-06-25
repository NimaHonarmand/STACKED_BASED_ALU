module STACK_BASED_ALU #(parameter n = 8, parameter STACK_SIZE = 1000) (
    input [n-1:0] input_data,
    input [2:0] opcode,
    input clk,
    input reset,
    output reg signed [n-1:0] output_data,
    output reg overflow
);

    reg signed [n-1:0] stack [0:STACK_SIZE-1];
    reg [3:0] sp; // stack pointer
    reg [n-1:0] temp_a, temp_b;
    reg [n:0] temp_result; // extra bit for detecting overflow

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            sp <= 0;
            output_data <= {n{1'bz}};
            overflow <= 1'bz;
        end else begin
            case (opcode)
                3'b100: begin // addition
                    if (sp >= 2) begin
                        temp_a = stack[sp-1];
                        temp_b = stack[sp-2];
                        temp_result = temp_a + temp_b;
			if(temp_result[n] != temp_result[n-1])
                        	overflow = 1;
                        output_data = $signed(temp_result[n-1:0]);
                    end
                end
                3'b101: begin // multiply
                    if (sp >= 2) begin
                        temp_a = stack[sp-1];
                        temp_b = stack[sp-2];
                        temp_result = temp_a * temp_b;
			if(temp_result[n] != temp_result[n-1])
                        overflow = 1;
                        output_data = $signed(temp_result[n-1:0]);
                    end
                end
                3'b110: begin // push
                    if (sp < STACK_SIZE) begin
                        stack[sp] = input_data;
                        sp = sp + 1;
			output_data <= {n{1'bz}};
            		overflow <= 1'bz;
                    end
                end
                3'b111: begin // pop
                    if (sp > 0) begin
                        sp = sp - 1;
                        output_data = $signed(stack[sp]);
			stack[sp] = {n{1'bx}};
            		overflow <= 1'bz;
                    end
                end
                default: begin // no operation
                	output_data <= {n{1'bz}};
            		overflow <= 1'bz;
                end
            endcase
        end
    end

endmodule
