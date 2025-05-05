module fifo(
    input wire clk,
    input wire rstn,
    input wire wr_en,
    input wire rd_en,
    input wire [7:0] data_in,
    output reg [7:0] data_out,
    output full,
    output empty
);
    reg [7:0] buffer [0:3];
    
    reg [1:0] w_ptr, r_ptr;
    
    assign empty = (w_ptr == r_ptr);
    assign full =  (w_ptr == r_ptr-1) || (w_ptr == 3 && r_ptr == 0);
    
    // Lógica de escrita
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            w_ptr = 2'b00;
            r_ptr = 2'b00;
        end else begin

            if (wr_en && !full) begin
                buffer[w_ptr] = data_in;
                w_ptr = w_ptr + 1;
            end
            
            if (rd_en && !empty) begin
                data_out = buffer[r_ptr];
                r_ptr = r_ptr + 1;
            end
            
        end
    end

endmodule
