// Code your design here
// Module: up_down_counter
// Description: Parameterizable up/down counter with load, overflow, and underflow detection
// Parameters:
//   WIDTH      - Bit width of the counter (default: 8)
//   SYNC_RESET - 0 for async reset, 1 for sync reset (default: 0)
module up_down_counter #(
    parameter WIDTH      = 32,
    parameter SYNC_RESET = 0
) (
    input  wire             i_clk,       // Clock input
    input  wire             i_rst_n,     // Active-low reset
    input  wire             i_en,        // Counter enable
    input  wire             i_up_down,   // 1 for up, 0 for down
    input  wire             i_load,      // Load enable
    input  wire [WIDTH-1:0] i_load_data, // Data to load
    output reg  [WIDTH-1:0] o_count,     // Counter output
    output wire             o_ovf,       // Overflow flag
    output wire             o_udf        // Underflow flag
);

    // Overflow and underflow detection
    assign o_ovf = i_en && i_up_down && (o_count == {WIDTH{1'b1}});
    assign o_udf = i_en && !i_up_down && (o_count == 0);

    // Counter logic
    generate
        if (SYNC_RESET) begin
            always @(posedge i_clk) begin
                if (!i_rst_n) begin
                    o_count <= 0;
                end else if (i_load) begin
                    o_count <= i_load_data;
                end else if (i_en) begin
                    o_count <= i_up_down ? o_count + 1 : o_count - 1;
                end
            end
        end else begin
            always @(posedge i_clk or negedge i_rst_n) begin
                if (!i_rst_n) begin
                    o_count <= 0;
                end else if (i_load) begin
                    o_count <= i_load_data;
                end else if (i_en) begin
                    o_count <= i_up_down ? o_count + 1 : o_count - 1;
                end
            end
        end
    endgenerate

endmodule