`timescale 1ns / 1ps

module Program_Counter_tb;

    reg clk;
    reg rst;
    reg jump;
    reg pc_enable;
    reg [3:0] jump_address;
    wire [3:0] pc;

    Program_Counter uut (.clk(clk), .rst(rst), .jump(jump), .pc_enable(pc_enable), .jump_address(jump_address), .pc(pc));
    
    // Generates VCD waveform files for online EDA tools.
     initial begin
        $dumpfile("Program_Counter.vcd");
        $dumpvars(0, Program_Counter_tb);
     end
    
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        jump = 0;
        jump_address = 0;
        pc_enable = 0;

        #10;
        rst = 0;

        // Normal counting for two clock cycles
        pc_enable = 1;
        #20;

        // Jump to address 9
        jump = 1;
        jump_address = 4'b1001;

        #10;
        jump = 0;

        // Continue counting
        #20;
        
        // Reset mid-operation
        pc_enable = 0;
        rst = 1;
        #10;
        
        rst = 0;
        pc_enable = 1;
        #20;
        $finish;
    end
endmodule
