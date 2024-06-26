# Stack Based ALU
Our project is the implementation of a stack equipped to perform multiplication and addition operations in addition to the two commands Push and Pop.
# Tools
Since all the implementation is done using only Verilog language, only one coding environment such as ModelSim is needed to facilitate the simulation work for you.
# Implementation Details
This repository contains the Verilog implementation of a stack-based arithmetic logic unit (ALU) along with a comprehensive testbench. The ALU supports basic arithmetic operations using a stack for operand management.
Modules
STACK_BASED_ALU

The STACK_BASED_ALU module is a parameterized stack-based ALU that supports operations like addition, multiplication, push, and pop. It uses a stack to manage operands and provides overflow detection.
Parameters

    n: Bit-width of the data (default is 8).
    STACK_SIZE: Size of the stack (default is 1000).

Ports

    input_data ([n-1:0]): Input data to be pushed onto the stack.
    opcode ([2:0]): Operation code specifying the operation to perform.
    clk: Clock signal.
    reset: Reset signal.
    output_data (reg signed [n-1:0]): Output data from the ALU.
    overflow (reg): Overflow flag indicating if an overflow has occurred during operations.

Operation Codes

    3'b100: Addition
    3'b101: Multiplication
    3'b110: Push
    3'b111: Pop

Testbench

The testbench module, tb, is designed to test the functionality of the STACK_BASED_ALU module with different data widths. It instantiates the ALU with bit-widths of 4, 8, 16, and 32 bits and performs a sequence of operations to verify the correctness of the ALU.
Components

    Clock generation with a period of 10 time units.
    Initial block defining the test sequence for various operations.
    $monitor task to display the state of the ALU instances and track changes during simulation.

For more information on how to implement the code, just refer to the documentation section.
# How to Run
**1)Clone the Repository**:

> git clone https://github.com/yourusername/stack-based-alu.git
> / cd stack-based-alu

**2)Simulate the Design**:
Use your preferred Verilog simulator (e.g., ModelSim, Icarus Verilog) to run the testbench and verify the design.

For example, with Icarus Verilog:

> iverilog -o tb tb.v stack_based_alu.v
> / vvp tb

**3)View the Output**:
The $monitor task in the testbench will provide a detailed output of the operations performed, including the state of the stacks, overflow flags, and result values in both hexadecimal and decimal formats.
# Results
After successfully running the code , we will see the following results:

![Screenshot 2024-06-25 154335](https://github.com/NimaHonarmand/STACKED_BASED_ALU/assets/123174877/95b55824-2dae-46d2-9af9-69d92732ce11)
![Screenshot 2024-06-25 154358](https://github.com/NimaHonarmand/STACKED_BASED_ALU/assets/123174877/b13a459e-705e-4dc5-89fa-c4010fd08d1d)

# Authors
Nima Honarmand
