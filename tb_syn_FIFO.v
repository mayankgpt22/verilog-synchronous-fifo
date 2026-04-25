`timescale 1ns / 1ps


module tb_syn_FIFO;
    parameter DATA_WIDTH = 8;
    parameter DEPTH = 8;
    parameter PTR_WIDTH = 3;

    reg clk;
    reg rst;

    reg wr_en;
    reg rd_en;
    reg [DATA_WIDTH-1:0] din;

    wire [DATA_WIDTH-1:0] dout;
    wire full;
    wire empty;

    
    sync_fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .DEPTH(DEPTH),
        .PTR_WIDTH(PTR_WIDTH)
    ) dut (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .din(din),
        .rd_en(rd_en),
        .dout(dout),
        .full(full),
        .empty(empty)
    );

    always #5 clk = ~clk;   // 10ns clock
    
    initial begin
        clk = 0;
        rst = 1;
        wr_en = 0;
        rd_en = 0;
        din   = 0;

        #10;
        rst = 0;
        // TEST 1: WRITE DATA
        $display("---- WRITE TEST ----");
        repeat (7) begin   // DEPTH-1
            @(posedge clk);
            wr_en = 1;
            din = din + 1;
        end

        @(posedge clk);
        wr_en = 0;

        // TEST 2: CHECK FULL
        if (full)
            $display("FIFO is FULL as expected");
        else
            $display("ERROR: FIFO not FULL");
        // Try writing when full
        @(posedge clk);
        wr_en = 1;
        din = 8'hFF;  

        @(posedge clk);
        wr_en = 0;
        
        // TEST 3: READ DATA
        $display("---- READ TEST ----");
        repeat (7) begin
            @(posedge clk);
            rd_en = 1;
        end

        @(posedge clk);
        rd_en = 0;
        // TEST 4: CHECK EMPTY
        if (empty)
            $display("FIFO is EMPTY as expected");
        else
            $display("ERROR: FIFO not EMPTY");

        // Try reading when empty
        @(posedge clk);
        rd_en = 1;

        @(posedge clk);
        rd_en = 0;

        $display("---- SIMULTANEOUS R/W TEST ----");

        repeat (5) begin
            @(posedge clk);
            wr_en = 1;
            rd_en = 1;
            din = din + 1;
        end

        @(posedge clk);
        wr_en = 0;
        rd_en = 0;

        // Finish
        #20;
        $finish;
    end

endmodule

  
