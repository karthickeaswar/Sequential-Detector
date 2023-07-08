module SequentialDetector_TB;

  // Testbench inputs
  reg clk;
  reg reset;
  reg data_in;

  // Testbench outputs
  wire detection_out;

  // Instantiate the sequential detector module
  SequentialDetector DUT (
    .clk(clk),
    .reset(reset),
    .data_in(data_in),
    .detection_out(detection_out)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Testbench stimulus
  initial begin
    // Initialize inputs
    clk = 0;
    reset = 1;
    data_in = 0;

    // Apply reset
    #10 reset = 0;

    // Start test scenario
    #20 data_in = 1;  // Activate the detector
    @(posedge clk); // Wait for positive clock edge
    data_in = 0;    // Transition to S0 state
    @(posedge clk);
    data_in = 1;    // Transition to S1 state
    @(posedge clk);
    data_in = 1;    // Transition to DETECTED state
    @(posedge clk);
    data_in = 0;    // Transition to IDLE state

    // Dump output waveform to a VCD file
    $dumpfile("output_waveform.vcd");
    $dumpvars(0, SequentialDetector_TB);

    // End of test
    @(posedge clk);
    $finish;
  end

endmodule
