module SequentialDetector (
  input wire clk,
  input wire reset,
  input wire data_in,
  output wire detection_out
);

  // Internal registers
  reg [2:0] state;

  // Define states
  localparam IDLE = 3'b000;
  localparam S0 = 3'b001;
  localparam S1 = 3'b010;
  localparam DETECTED = 3'b100;

  // Sequential logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;  // Reset state
    end else begin
      case (state)
        IDLE: begin
          if (data_in) begin
            state <= S0;
          end
        end
        S0: begin
          if (data_in) begin
            state <= S1;
          end else begin
            state <= IDLE;
          end
        end
        S1: begin
          if (data_in) begin
            state <= DETECTED;
          end else begin
            state <= IDLE;
          end
        end
        DETECTED: begin
          state <= IDLE;
        end
      endcase
    end
  end

  // Output assignment
  assign detection_out = (state == DETECTED);

endmodule
