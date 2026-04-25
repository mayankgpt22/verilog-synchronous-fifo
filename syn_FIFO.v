module sync_fifo #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH = 8,
    parameter PTR_WIDTH = 3 
)(
    input  wire                   clk,
    input  wire                   rst,
    
    input  wire                   wr_en,
    input  wire [DATA_WIDTH-1:0]  din,
    
    input  wire                   rd_en,
    output reg  [DATA_WIDTH-1:0]  dout,

    output wire                   full,
    output wire                   empty
);

    // Memory
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    // Pointers
    reg [PTR_WIDTH-1:0] wr_ptr;
    reg [PTR_WIDTH-1:0] rd_ptr;

    assign full  = ((wr_ptr + 1'b1) == rd_ptr);
    assign empty = (wr_ptr == rd_ptr);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            wr_ptr <= 0;
            end
        else if (wr_en && !full) begin
            mem[wr_ptr] <= din;
            wr_ptr <= wr_ptr + 1'b1;
        end
    end
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            rd_ptr <= 0;
            dout   <= 0;
        end 
        else if (rd_en && !empty) begin
            dout   <= mem[rd_ptr];
            rd_ptr <= rd_ptr + 1'b1;
        end
    end

endmodule