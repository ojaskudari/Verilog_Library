`timescale 1ns/1ps

module tb;
    parameter WIDTH = 8;
    parameter DEPTH = 16;
    
    reg                  clk;
    reg                  rst_n;
    reg  [WIDTH-1:0]     data_in;
    reg                  wr_en;
    reg                  rd_en;
    wire [WIDTH-1:0]     data_out;
    wire                 full;
    wire                 empty;
    
    integer i;
    
    Synchronous_FIFO #(
        .WIDTH(WIDTH),
        .DEPTH(DEPTH)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .data_out(data_out),
        .full(full),
        .empty(empty)
    );
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        rst_n = 0;
        data_in = 0;
        wr_en = 0;
        rd_en = 0;
        
        #20 rst_n = 1;
        
        // Write single
        #10 data_in = 8'hAA; wr_en = 1;
        #10 wr_en = 0;
        
        // Read single
        #10 rd_en = 1;
        #10 rd_en = 0;
        
        // Fill FIFO
        #10;
        for (i = 0; i < DEPTH; i = i + 1) begin
            data_in = i;
            wr_en = 1;
            #10;
        end
        wr_en = 0;
        
        // Try write when full
        #10 data_in = 8'hFF; wr_en = 1;
        #10 wr_en = 0;
        
        // Read all
        #10;
        for (i = 0; i < DEPTH; i = i + 1) begin
            rd_en = 1;
            #10;
        end
        rd_en = 0;
        
        // Try read when empty
        #10 rd_en = 1;
        #10 rd_en = 0;
        
        // Simultaneous read/write
        #10;
        for (i = 0; i < 5; i = i + 1) begin
            data_in = 8'h10 + i;
            wr_en = 1;
            #10;
        end
        wr_en = 0;
        
        #10;
        for (i = 0; i < 5; i = i + 1) begin
            data_in = 8'h20 + i;
            wr_en = 1;
            rd_en = 1;
            #10;
        end
        wr_en = 0;
        rd_en = 0;
        
        #50 $finish;
    end
    
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, tb);
    end
    
endmodule
